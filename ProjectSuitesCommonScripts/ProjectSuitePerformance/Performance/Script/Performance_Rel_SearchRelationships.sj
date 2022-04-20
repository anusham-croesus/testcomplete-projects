//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: 
Analyste d'automatisation: Xian Wei */

function Performance_Rel_SearchRelationships() {

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Rel_SearchRelationships";
        var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationshipNo", language+client);
        var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
		    
        Get_ModulesBar_BtnRelationships().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
        // Recherche de relations
        Search_Relationship(relationshipName);
        
        StopWatchObj.Start();
        WaitObject(Get_RelationshipsClientsAccountsGrid(),["ClrClassName", "WPFControlText"], ["CellValuePresenter", relationshipName],waitTimeShort);
        StopWatchObj.Stop();
        
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







function Search_Relationship(relationshipName)
{
      Sys.Keys(relationshipName);
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
      Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
      Get_WinRelationshipsQuickSearch_RdoRelationshipNo().Click();
      //Get_WinRelationshipsQuickSearch_RdoName.set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
}