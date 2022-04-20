//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions

/* Analyste d'assurance qualité: Julie Lamarche
Analyste d'automatisation: Xian Wei */

function Performance_Rel_Rapport_PortfolioEvaluation(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Rel_Rapport_PortfolioEvaluation"; 
//        var typeReport = GetData(filePath_Performance, sheetName_DataBD, 38, language) 
//        var criterionRelationsName = GetData(filePath_Performance, sheetName_DataBD, 31, language);
//        var posRelation = GetData(filePath_Performance, sheetName_DataBD, 25, language);
//        var relationshipName = GetData(filePath_Performance, sheetName_DataBD, 13, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);

        var posRelation      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionRelation1", language+client);
        var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationshipNo", language+client);
        var waitTimeLong    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var criterionRelationsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceRelations", language+client);
        var typeReport   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "TypePortfolioEvaluation", language+client);
                
        try {   
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
        
        // Clique le module Relations
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
        Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnRelationships().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        //************************************** position ***********************
        SelectSearchCriteria(criterionRelationsName);
        
        //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posRelation], 10).Click();
        //***********************************************************************
        
        
        //********************************* Data ********************************
        /*Search_Relationship(relationshipName);
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
        Get_RelationshipsClientsAccountsGrid().Find("Value", relationshipName, 10).Click();*/
        //***********************************************************************
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitObject(Get_CroesusApp(), ["ClrFullClassName", "WPFControlOrdinalNo"], ["com.unigiciel.components.windows.UniDialog", "1"]);
        Get_WinReports().WaitProperty("VisibleOnScreen", true, 15000);
    
        // Évaluation du portefeuille (avancé)
        Select_Report_Performance(typeReport);
        WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["ListBoxItem", typeReport]);
        if (language == 'french'){
            Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).WaitProperty("VisibleOnScreen", true, 30000); 
        } else if (language == 'english'){
            Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Reports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).WaitProperty("VisibleOnScreen", true, 30000);  
        }  
        Get_WinReports_BtnOK().WaitProperty("Enabled", true, 15000);
         
        
        StopWatchObj.Start();
        Get_WinReports_BtnOK().Click();
        Sys.WaitProcess(GetAcrobatProcessName(), waitTimeLong, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
        Sys.FindChild("WndClass","AcrobatSDIWindow",10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();

                
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        TerminateAcrobatProcess(); //2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits

        
        // Retourne l'état initiale
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 180000);
}
