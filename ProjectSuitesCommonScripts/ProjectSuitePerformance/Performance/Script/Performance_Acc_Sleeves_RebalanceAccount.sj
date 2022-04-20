//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Xian Wei */


function Performance_Acc_Sleeves_RebalanceAccount(){


//    var nbOfAccountsToBeSelected1 = GetData(filePath_Performance, sheetName_DataBD, 49, language);
//    var nbOfAccountsToBeSelected2 = GetData(filePath_Performance, sheetName_DataBD, 50, language);
//    var nbOfAccountsToBeSelected3 = GetData(filePath_Performance, sheetName_DataBD, 51, language);
//    var nbOfAccountsToBeSelected4 = GetData(filePath_Performance, sheetName_DataBD, 52, language);
    
    var nbOfAccountsToBeSelected1 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SelectedAccounts1", language+client);
    var nbOfAccountsToBeSelected2 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SelectedAccounts50", language+client); 
    var nbOfAccountsToBeSelected3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SelectedAccounts100", language+client); 
    var nbOfAccountsToBeSelected4 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SelectedAccounts500", language+client);     
    
    var SoughtForValue1 = "Performance_Acc_Sleeves_RebalanceAccount_" + nbOfAccountsToBeSelected1;
    var SoughtForValue2 = "Performance_Acc_Sleeves_RebalanceAccount_" + nbOfAccountsToBeSelected2;
    var SoughtForValue3 = "Performance_Acc_Sleeves_RebalanceAccount_" + nbOfAccountsToBeSelected3;
    var SoughtForValue4 = "Performance_Acc_Sleeves_RebalanceAccount_" + nbOfAccountsToBeSelected4;
    var SoughtForValue5 = "Performance_Acc_Sleeves_CashMgmt_RebalanceAccount_" + nbOfAccountsToBeSelected1;
    var SoughtForValue6 = "Performance_Acc_Sleeves_CashMgmt_RebalanceAccount_" + nbOfAccountsToBeSelected2;
    var SoughtForValue7 = "Performance_Acc_Sleeves_CashMgmt_RebalanceAccount_" + nbOfAccountsToBeSelected3;
    var SoughtForValue8 = "Performance_Acc_Sleeves_CashMgmt_RebalanceAccount_" + nbOfAccountsToBeSelected4;
    
    
    //AccSleevesRebalanceAccount(SoughtForValue1,nbOfAccountsToBeSelected1);
    
    //AccSleevesRebalanceAccount(SoughtForValue2,nbOfAccountsToBeSelected2);
    
    //AccSleevesRebalanceAccount(SoughtForValue3,nbOfAccountsToBeSelected3);
    
    //AccSleevesRebalanceAccount(SoughtForValue5,nbOfAccountsToBeSelected1,"Cash Management");
    
    //AccSleevesRebalanceAccount(SoughtForValue6,nbOfAccountsToBeSelected2,"Cash Management");
    
    //AccSleevesRebalanceAccount(SoughtForValue7,nbOfAccountsToBeSelected3,"Cash Management");
    
    AccSleevesRebalanceAccount(SoughtForValue4,nbOfAccountsToBeSelected4,"",4800000);
    
    AccSleevesRebalanceAccount(SoughtForValue8,nbOfAccountsToBeSelected4,"Cash Management",4800000); 
    
    
} 




function AccSleevesRebalanceAccount(SoughtForValue,nbOfAccountsToBeSelected,addFunction,waitTime){

        var StopWatchObj = HISUtils.StopWatch;
//        var criterionSleevesName = GetData(filePath_Performance, sheetName_DataBD, 47, language);
//        //var nbOfAccountsToBeSelected1 = GetData(filePath_Performance, sheetName_DataBD, 49, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var criterionSleevesName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceSleeves", language+client);
        // var waitTimeShort        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

    
        // Attend le module Comptes présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
            
        // Clique le module Comptes
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 15000);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsLoaded", true, 15000);
        
        SelectSearchCriteria(criterionSleevesName);
        
        if (nbOfAccountsToBeSelected == "ALL"){
            Log.Message("Select all account Sleeves");
        }else{
            SelectNbOfAccounts(nbOfAccountsToBeSelected);
        }
                
        // Cliquer sur le bouton reequilibrer
        
        Get_Toolbar_BtnRebalance().Click();               
           var numberOftries=0;  
           while ( numberOftries < 5 && !Get_WinRebalancingMethod().Exists){//Dans le cas, si le click ne fonctionne pas 
             Get_Toolbar_BtnRebalance().Click();
           numberOftries++;}                                                  
        
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeMethodWindow_5e8e"); 
        if (nbOfAccountsToBeSelected == "ALL"){
              Get_WinRebalancingMethod_GrpParameters_CmbSources().ClickItem(1);
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().Click(); 
        Get_WinRebalancingMethod_BtnOK().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_7456");
        
        if (addFunction == "Cash Management"){
        
                Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
                WaitObject(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");
                Get_WinCashManagement().Parent.Maximize();
                
                if (nbOfAccountsToBeSelected == 1){
                  AddCashMgmt(1,1000);
                } else {
                  AddCashMgmt(1,4000);
                  AddCashMgmt(2,3500);
                  AddCashMgmt(3,2800);
                  AddCashMgmt(4,6000);
                  AddCashMgmt(5,1000);
                  AddCashMgmt(6,2000);
                  AddCashMgmt(7,3000);
                  AddCashMgmt(8,4800);
                  AddCashMgmt(9,3600);
                  AddCashMgmt(10,1000);
                }              
                Get_WinCashManagement_BtnOk().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "CashAmountOverrideWindow_9cd1");       
        }
        
        Get_WinRebalance_BtnNext().Click();
        SetAutoTimeOut();
            if (Get_WinWarningDeleteGeneratedOrders().Exists == true){
                Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();}
        RestoreAutoTimeOut();
            
        // Mesure le performance rééquilibrer
        StopWatchObj.Start(); 
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ProgressCroesusWindow_b5e1", waitTime);//1680000); //SA: attendre que la fenêtre de progression de croesus disparait
        WaitObject(Get_CroesusApp(),"Uid", "Expander_0a4c",1600);
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();
        
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        Get_WinRebalance_BtnClose().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1], 30000);
//        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
        Get_DlgConfirmation_BtnYes().Click();
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 30000);
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}

function SelectNbOfAccounts(nbOfAccountsToBeSelected)
{
    Log.Message("Select " + nbOfAccountsToBeSelected + " accounts.")

    Get_ModulesBar_BtnAccounts().Click();
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 50, 55);
    Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(false);
    
    Get_Toolbar_BtnSum().Click();
    accountsTotalCount = Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountAcc();
    Log.Message("The Accounts total count is : " + accountsTotalCount);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    Sys.Desktop.KeyDown(0x11); //Press Ctrl
    nbOfSelectedAccounts = 0;
    arrayOfAllAccountsNumbers = new Array();
    
    while (arrayOfAllAccountsNumbers.length < accountsTotalCount){
        accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (i = 0; i < accountsPageCount; i++){
            displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            isFound = false;
            for (j = 0; j < arrayOfAllAccountsNumbers.length; j++){
                if (displayedAccountNumber == arrayOfAllAccountsNumbers[j]){ 
                    isFound = true;
                    break;
                }
            }
			
            if (!isFound){
                arrayOfAllAccountsNumbers.push(displayedAccountNumber);
                Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                nbOfSelectedAccounts ++;
			}
            
            if (nbOfSelectedAccounts == nbOfAccountsToBeSelected)
                break;
        }
        
        if (nbOfSelectedAccounts == nbOfAccountsToBeSelected)
            break;

        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 60);
    
    }
    
    Sys.Desktop.KeyUp(0x11); //Release Ctrl
    
    if (nbOfSelectedAccounts < nbOfAccountsToBeSelected)
        Log.Warning("Only " + nbOfSelectedAccounts + " out of " + nbOfAccountsToBeSelected + " accounts have been selected!");
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


function AddCashMgmt(position,value){

      Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position))).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 5).Click();
      Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position))).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 5).WPFObject("XamNumericEditor", "", 1).Keys(value);
}

function test(){
      Aliases.CroesusApp.winRebalancingMethod.WPFObject("GroupBox", "Paramètres", 1).WPFObject("ComboBox", "", 1).ClickItem(1);
}