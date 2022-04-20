//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Xian Wei */



function Performance_CROES_10617(){
  
        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_CROES_10617";
        var criterionSleevesName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceSleeves", language+client); 
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
        // Attend le module Comptes présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
            
        // Clique le module Comptes
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsLoaded", true, 15000);
        
        SelectSearchCriteria(criterionSleevesName);
                
        // Cliquer sur le bouton reequilibrer
        Get_Toolbar_BtnRebalance().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeMethodWindow_5e8e",waitTimeShort);

        Get_WinRebalancingMethod_GrpParameters_CmbSources().ClickItem(1);

        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().Click();  
        Get_WinRebalancingMethod_BtnOK().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_7456");
        

        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");
        Get_WinCashManagement().Parent.Maximize();
        
        // Mesure le performance tri
        StopWatchObj.Start(); 
        Get_WinCashManagement_ChName().Click();
        Get_WinCashManagement_ChName().WaitProperty("SortStatus", "Ascending", waitTimeShort);
        StopWatchObj.Stop();  
         
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        Get_WinCashManagement_BtnOk().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "CashAmountOverrideWindow_9cd1");       
        
        Get_WinRebalance_BtnClose().Click();
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

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