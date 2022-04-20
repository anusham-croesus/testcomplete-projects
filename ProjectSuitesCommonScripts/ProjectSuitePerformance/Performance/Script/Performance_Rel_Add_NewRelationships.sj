//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions

/* Analyste d'assurance qualité: Karima mehiguene
Analyste d'automatisation: Xian Wei */

function Performance_Rel_Add_NewRelationships(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Rel_Add_NewRelationships";
  //        var AddRelationName = GetData(filePath_Performance, sheetName_DataBD, 53, language);
  //        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
  //        var IAcode = GetData(filePath_Performance, sheetName_DataBD, 14, language);  
        
            var AddRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationName", language+client);
            var waitTimeShort   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
            var IAcode          = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "IACode", language+client);  
            var namRelat          = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "namRelat", language+client); 
            try {
            // Se connecte
            //Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Attend le module Clients présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
            Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
    
            // Clique le module Relations
            Get_ModulesBar_BtnRelationships().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
            //Ajouter une relation par le bouton "+"
            Log.Message("Add the relationship \"" + AddRelationName + "\" with the 'Add' button.");
            var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddRelationName, 10);
            if (SearchResult.Exists == true){
                Log.Message("The relationship \"" + AddRelationName + "\" already exists.");
                return;
            } else {
                Get_Toolbar_BtnAdd().Click();
                WaitObject(Get_CroesusApp(), "Uid", "ContextMenu_8804");
                Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
                WaitObject(Get_CroesusApp(), ["ClrFullClassName", "WPFControlName"], ["com.unigiciel.components.windows.UniDialog", "basedialog1"]);
                Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(AddRelationName);
                Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().Keys(IAcode);
                 Get_WinDetailedInfo_BtnOK().Click();
                // Mesure la performance
                StopWatchObj.Start();
               
                WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
                //Get_WinDetailedInfo().WaitProperty("Visible", false, 15000);
//                WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo", "Text"], ["XamTextEditoreff", 1, "ADDRELATIONTEST"], waitTimeShort);
                WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "Value"], ["XamTextEditor",namRelat], waitTimeShort);

//                var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddRelationName, 10);
//                    if (SearchResult.Exists == true){
//                        Log.Checkpoint("The relationship \"" + AddRelationName + "\" was successfully added.");
//                    } else {
//                        Log.Error("The relationship \"" + AddRelationName + "\" was not successfully added." + "numero d'anomalie: CROES-6181");
//                    }
                StopWatchObj.Stop();
                
                // Écrit le résultat dans le fichier excel
                Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
                var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
                WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
                //Vérifier que la relation a été correctement ajoutée
                //CheckExistenceOfRelationship(relationshipName);
                
            }

        } catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess();
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            DeleteRelationship(AddRelationName);
            Terminate_CroesusProcess();
            Terminate_IEProcess();
    }

}




function DeleteRelationship(RelationshipName)
{
    Log.Message("Delete the relationship \"" + RelationshipName + "\".");
    
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
    Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
    Get_ModulesBar_BtnRelationships().Click();
    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
    Search_Relationship(RelationshipName);
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo", "Text"], ["XamTextEditor", 1, RelationshipName], 600000);
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    if (searchResult.Exists){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        Delay(100);
        
        /*if (Get_DlgConfirmAction_BtnOK().Exists)
            Get_DlgConfirmAction_BtnOK().Click();
        else if (Get_DlgConfirmAction_BtnDelete().Exists)
            Get_DlgConfirmAction_BtnDelete().Click();*/
        if (Get_DlgConfirmation().Exists == true){
              Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
        } 
        searchResult.WaitProperty("Visible", false, 30000);
    }
    else {
        Log.Message("The relationship " + RelationshipName + " does not exist.");
    }
}


function Search_Relationship(relationshipName)
{
      Sys.Keys(relationshipName);
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
      Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
      //Get_WinRelationshipsQuickSearch_RdoRelationshipNo().Click();
      //Get_WinRelationshipsQuickSearch_RdoName.set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
}



function CheckExistenceOfRelationship(relationshipName)
{
    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    Log.Message("Verify that the relationship \"" + relationshipName + "\" was successfully added.");
    var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (SearchResult.Exists == true){
        Log.Checkpoint("The relationship \"" + relationshipName + "\" was successfully added.");
    }
    else {
        Log.Error("The relationship \"" + relationshipName + "\" was not successfully added.");
    }
}


function test()
{
   var waitTimeShort   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
           

        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "Value"], ["XamTextEditor","ADDRELATIONTEST"], waitTimeShort);

}