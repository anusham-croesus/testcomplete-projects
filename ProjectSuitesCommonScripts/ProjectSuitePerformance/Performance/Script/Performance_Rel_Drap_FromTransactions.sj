//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions
//USEUNIT Relations_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Rel_Drap_FromTransactions(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Rel_Drap_FromTransactions";
//            var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//            var posTransaction = GetData(filePath_Performance, sheetName_DataBD, 22, language);
//            var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);  
            
            var account        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
            var posTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransaction20", language+client);
            var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);                    
            
            try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
            // Clique le module Transactions
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
            Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnTransactions().Click(); 
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"]);
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
            //if (DataType == "Position"){
                //******************************** position *************************
                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
    
                // Maillage un transactions au module relations
                Drag(Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10), Get_ModulesBar_BtnRelationships());
               
                StopWatchObj.Start();
               WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                StopWatchObj.Stop();
                //*******************************************************************
            /*} else if (DataType == "Data"){
            
                //******************************* Data ******************************
                Search_Transactions_Account(account);
                WaitObject(Get_Transactions_ListView(), ["ClrClassName", "Text"], ["BrowserCellTemplateSimple", account]);
                //Get_Transactions_ListView().WaitProperty("IsInitialized", true, 15000);
                Get_Transactions_ListView().FindChild("Text",account,1000).Click(); 
                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WaitProperty("IsLoaded", true, 15000);
    
                // Maillage un transactions au module relations
                StopWatchObj.Start();
                Drag(Get_Transactions_ListView().Find("Text",account,1000), Get_ModulesBar_BtnRelationships());
                WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                StopWatchObj.Stop();
                //*******************************************************************
            }*/
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

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