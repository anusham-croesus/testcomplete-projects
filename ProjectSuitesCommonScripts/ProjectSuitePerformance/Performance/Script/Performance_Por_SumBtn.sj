//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Por_SumBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Por_SumBtn";
//        var posAccount = GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var account       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
        var posAccount    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionAccount6", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
        var criterionAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceAccounts", language+client);
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"]);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
//        if (DataType == "Position"){
//            //******************************* position ******************************
//            SelectSearchCriteria(criterionAccountsName);
//        
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
//  
//            // Maillage un client au module portefeuille
//            Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10), Get_ModulesBar_BtnPortfolio());
//            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
//            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
//            //***********************************************************************
//        
//        } else if (DataType == "Data"){
            //********************************** Data *******************************
            // Recherche de comptes
            Search_Account(account);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
  
            // Maillage un compte au module portefeuille
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000); 
            //***********************************************************************
//        }
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnSum().WaitProperty("Enabled", true, 15000);
        Get_Toolbar_BtnSum().Click();
        // Mesure la performance clique le boutton sommation    
        StopWatchObj.Start();
       
//        WaitObject(Get_CroesusApp(), "Uid", "SumWindow_782a", waitTimeShort);
        Get_WinPortfolioSum_BtnClose().WaitProperty("VisibleOnScreen", true, waitTimeShort);       
         
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la fenêtre sommation
        Get_WinPortfolioSum_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SumWindow_782a");
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
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