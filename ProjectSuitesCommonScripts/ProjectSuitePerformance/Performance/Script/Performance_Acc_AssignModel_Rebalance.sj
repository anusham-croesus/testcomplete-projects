//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Mamoudou Diaby
Analyste d'automatisation: Xian Wei */


function Performance_Acc_AssignModel_Rebalance(){

    /*var nbOfAccountsToBeSelected1 = GetData(filePath_Performance, sheetName_DataBD, 49, language);
    var SoughtForValue1 = "Performance_Acc_AssignModel_Rebalance_" + nbOfAccountsToBeSelected1;
    AccSleevesRebalanceAccount(SoughtForValue1,nbOfAccountsToBeSelected1);*/
    
    /*var nbOfAccountsToBeSelected2 = GetData(filePath_Performance, sheetName_DataBD, 50, language);
    var SoughtForValue2 = "Performance_Acc_AssignModel_Rebalance_" + nbOfAccountsToBeSelected2;
    AccAssignModelRebalance(SoughtForValue2,nbOfAccountsToBeSelected2);*/
    
//    var nbOfAccountsToBeSelected3 = GetData(filePath_Performance, sheetName_DataBD, 51, language);
    var nbOfAccountsToBeSelected3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SelectedAccounts100", language+client);
    var SoughtForValue3 = "Performance_Acc_AssignModel_Rebalance_" + nbOfAccountsToBeSelected3;
    AccAssignModelRebalance(SoughtForValue3,nbOfAccountsToBeSelected3);
    
    /*var nbOfAccountsToBeSelected4 = GetData(filePath_Performance, sheetName_DataBD, 52, language);
    var SoughtForValue4 = "Performance_Acc_AssignModel_Rebalance_" + nbOfAccountsToBeSelected4;
    AccAssignModelRebalance(SoughtForValue4,nbOfAccountsToBeSelected4);*/
    
} 



function AccAssignModelRebalance(SoughtForValue,nbOfAccountsToBeSelected){

        var StopWatchObj = HISUtils.StopWatch;
//        var criterionNoAssignModeleName = GetData(filePath_Performance, sheetName_DataBD, 48, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var ModelNameOrNumber = GetData(filePath_Performance, sheetName_DataBD, 19, language);
        
        var criterionNoAssignModeleName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionNoAssignModele", language+client);
        var ModelNameOrNumber = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "NameModelOrNumber", language+client); 
        var waitTimeLong      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client); 
        var waitTimeShort     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

    
        // Attend le module Comptes présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
            
        // Clique le module Comptes
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsLoaded", true, 15000);
        
        SelectSearchCriteria(criterionNoAssignModeleName);
        
        SelectNbOfAccounts(nbOfAccountsToBeSelected);
        
        // Clique le boutton associer a un modèle existant
        Get_MenuBar_Edit().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CustomizableMenu_2602");
        Get_MenuBar_Edit_AssignToAnExistingModel().Click();
        WaitObject(Get_CroesusApp(), "Uid", "PickerBase_dcbf");
        
        Sys.Keys(ModelNameOrNumber);
        Get_WinQuickSearch_TxtSearch().SetText(ModelNameOrNumber);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow().FindChild("Value", ModelNameOrNumber, 100).Click();
        Get_WinPickerWindow_BtnOK().Click();
        WaitObject(Get_CroesusApp(), "Uid", "AssignToModelWindow_c8c3");  
        Get_WinAssignToModel_BtnYes().Click();
        
        // Clique le boutton rééquilibrer
        WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
        Get_Toolbar_BtnRebalance().WaitProperty("Enabled", true, 15000);
        Get_Toolbar_BtnRebalance().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "Button_2943"); 
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");   
        
        // Trier par le nom
        Log.Message("Trier par le nom, anomalie BNC-1061.");
        Get_WinCashManagement_ChName().Click();
//        Check_columnAlphabeticalSort(Get_WinCashManagement_DgvOverrideCashAmountData(),GetData(filePath_Performance, sheetName_DataBD, 62, language),"FullName" );
        Check_columnAlphabeticalSort(Get_WinCashManagement_DgvOverrideCashAmountData(),ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ColumnName", language+client),"FullName" );
        Get_WinCashManagement_BtnOk().Click();
        Get_WinRebalance_BtnNext().WaitProperty("Enabled", true, 15000);
        Get_WinRebalance_BtnNext().Click();
        
        // Mesure le performance rééquilibrer
        StopWatchObj.Start(); 
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(),"Uid", "Expander_0a4c", waitTimeLong);
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().WaitProperty("Visible", true, 15000);
        StopWatchObj.Stop();
        
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        Get_WinRebalance_BtnClose().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1], waitTime);
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/3, Get_DlgWarning().get_ActualHeight()-50);
        
        // Retourne l'état initiale
        Get_ModulesBar_BtnAccounts().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 600000);
}