//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/* Analyste d'assurance qualité:
Analyste d'automatisation: Xian Wei */


function Performance_Delete_SearchCriteria()
{
        var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
        var criterionClientsName = GetData(filePath_Performance, sheetName_DataBD, 30, language);
        var criterionSecuritiesName = GetData(filePath_Performance, sheetName_DataBD, 32, language);
        var criterionRelationsName = GetData(filePath_Performance, sheetName_DataBD, 31, language);
        var nom = GetData(filePath_Performance, sheetName_DataBD, 11, language);

        try {
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        Get_Toolbar_BtnManageSearchCriteria().Click(); 
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
        DeleteFilter(criterionAccountsName);
        DeleteFilter(criterionClientsName);
        DeleteFilter(criterionSecuritiesName);
        DeleteFilter(criterionRelationsName); 
        DeleteFilter(criterionSleevesName); 
        DeleteFilter(criterionNoAssignModeleName);   
        Get_WinSearchCriteriaManager_BtnClose().Click();
        
        //DeleteFilterTransactions(nom);
        
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}




function DeleteFilterTransactions(filterName)
{
    // Clique le module Transactions
    Get_ModulesBar_BtnTransactions().Click(); 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 2], 10).WaitProperty("VisibleOnScreen", true, 15000);

    // supprime un filtre
    Get_Toolbar_BtnQuickFilters().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"], 30000);
    Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", filterName], 10).Click();
    Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Click();
    Delay(2000);
    Get_DlgConfirmAction_BtnYes().Click();
    //Aliases.CroesusApp.winDetailedInfo.WPFObject("UniButton", "_Oui", 1)
    Delay(1000);
    Get_WinQuickFiltersManager_BtnClose().Click();
       
}

function DeleteFilter(criterion){
 
        var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
            for (i=0; i<= count-1; i++){ 
                if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
                     findFilter=true;           
                     break;             
                  }             
                } 
                if (findFilter==true){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                Get_WinSearchCriteriaManager_BtnDelete().Click();
                var width = Get_DlgCroesus().Get_Width();
                Get_DlgCroesus().Click((width*(1/3)),73);
                Log.Message(" Le critère " + criterion + " a été supprimé ");
                }
                else{
                    Log.Message(" Le critère " + criterion + " n'est pas sur la liste ");
                }

}