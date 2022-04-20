//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions

/* Analyste d'assurance qualité:
Analyste d'automatisation: Xian Wei */

function Performance_Por_CreateSleeves(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Por_CreateSleeves";
//        var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var assetClass = GetData(filePath_Performance, sheetName_DataBD, 84, language);
        var target = "100";
        var min = "";
        var max = "";
//        var modele = GetData(filePath_Performance, sheetName_DataBD, 75, language);

        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);       
        var criterionAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceAccounts", language+client);
        var assetClass = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AmericanEquityClass", language+client);
        var modele = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA200", language+client);
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        
        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"]);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        // Recherche de comptes
        Search_Account(account);
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
        
        // Clique le bouton segement
        Get_PortfolioBar_BtnSleeves().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
        AddEditSleeveWinSleevesManager(assetClass,assetClass,target,min,max,modele);
        
        Get_WinManagerSleeves_BtnSave().Click(); 
        
        StopWatchObj.Start();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
        StopWatchObj.Stop();
        //***********************************************************************

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          
        }
        finally {
        
        // Supprimer sleeves
        Get_ModulesBar_BtnPortfolio().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnPortfolio().Click();
        WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
        Get_PortfolioBar_BtnSleeves().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Find(["ClrClassName","Text"],["XamTextEditor",assetClass],10).Click();
        //Cliquer sur le bouton Supprimer
        Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        
        SetAutoTimeOut();
        if(Get_DlgConfirmation().Exists){
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
        } 
        RestoreAutoTimeOut();
        
        
        Get_WinManagerSleeves_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
        
        // Retourne l'état initiale
        Get_ModulesBar_BtnAccounts().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        Execute_SQLQuery("update b_compte set lock_id = null where no_compte = '" +account+ "'", vServerPerformance); 
        
        }

}




function SelectSearchCriteria(criterion){
    
    // Clique le bouton gérer les critères de recherche
    Get_Toolbar_BtnManageSearchCriteria().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"], 30000);
    Get_WinSearchCriteriaManager().Parent.Maximize();
        
    // Clique le critère de recherche
    var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (var i = 0; i < rowCount; i++){
        displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
          if (displayedCriterionName == criterion){
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            break;
          }
    }
    
    Get_WinSearchCriteriaManager_BtnRefresh().Click();
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 15000);
}