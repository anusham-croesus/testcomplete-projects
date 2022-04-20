//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Cli_Drag_FromRelationships() {

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Cli_Drag_FromRelationships";
//        var criterionRelationsName = GetData(filePath_Performance, sheetName_DataBD, 31, language);
//        var posRelation = GetData(filePath_Performance, sheetName_DataBD, 25, language);
//        var relationshipName = GetData(filePath_Performance, sheetName_DataBD, 13, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);	
        
        var posRelation      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionRelation1", language+client);
        var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationshipNo", language+client);
        var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var criterionRelationsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceRelations", language+client);
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


		    Get_ModulesBar_BtnClients().Click();         
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsVisible", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();    
        
        // Attend le module Clients présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
        Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);

        // Clique le module Relations
        Get_ModulesBar_BtnRelationships().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
//        
//        if (DataType == "Position"){
//            //***************************** position ********************************
//            SelectSearchCriteria(criterionRelationsName);
//        
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posRelation], 10).Click();
//    
//            // Maillage une relations au module clients
//            StopWatchObj.Start();
//            Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posRelation], 10), Get_ModulesBar_BtnClients());
//            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1],waitTimeShort);
//            StopWatchObj.Stop();
//            //***********************************************************************
//
//        } else if (DataType == "Data"){
            //***************************** Data ************************************
            // Recherche de Relations
            Search_Relationship(relationshipName);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value", relationshipName, 10).Click();
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
    
            // Maillage une relations au module clients
            StopWatchObj.Start();
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName,1000), Get_ModulesBar_BtnClients());
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1],waitTimeShort);
            StopWatchObj.Stop();
            //***********************************************************************
//        }
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Retourne l'état initiale
        Get_ModulesBar_BtnRelationships().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
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


function Search_Relationship(relationshipName)
{
      Sys.Keys(relationshipName);
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
      Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
      Get_WinRelationshipsQuickSearch_RdoRelationshipNo().Click();
      //Get_WinRelationshipsQuickSearch_RdoName.set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
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