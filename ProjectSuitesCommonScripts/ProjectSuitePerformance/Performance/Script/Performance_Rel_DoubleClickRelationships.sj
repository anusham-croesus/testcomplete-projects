//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Rel_DoubleClickRelationships(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Rel_DoubleClickRelationships";
//            var posRelation = GetData(filePath_Performance, sheetName_DataBD, 25, language);
//            var relationshipName = GetData(filePath_Performance, sheetName_DataBD, 13, language);	
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
 
            var posRelation      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionRelation1", language+client);
            var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationshipNo", language+client);
            var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

            try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Attend le module Clients présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
            Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
    
            // Clique le module Relations
            Get_ModulesBar_BtnRelationships().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
            
            // Recherche de Relations
            Search_Relationship(relationshipName);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value", relationshipName, 10).DblClick();
                //*******************************************************************

            // Mesure la performance boutton info
            StopWatchObj.Start();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
            Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 15000);
            StopWatchObj.Stop();
      
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
    
            // Ferme la fenetre
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"]);
            //WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
            //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

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