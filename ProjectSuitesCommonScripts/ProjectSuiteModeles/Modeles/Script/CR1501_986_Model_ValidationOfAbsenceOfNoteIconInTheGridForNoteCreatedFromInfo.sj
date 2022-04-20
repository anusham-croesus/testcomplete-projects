//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-986
        

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CR1501_986_Model_ValidationOfAbsenceOfNoteIconInTheGridForNoteCreatedFromInfo()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-986");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes986=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes986", language+client);
       var modelTextAddNotCROES986=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES986", language+client);
      
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
       //ajout d'une note
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(modelNameCroes986);
         Get_ModelsGrid().Find("Value",modelNameCroes986,10).Click();//Le modéle *FALL BACK n'as pas de note
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES986);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
           WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
          Get_WinCRUANote_BtnSave().Click();
        
          //Les points de vérifications
            var ColumnIndex = -1;
 
          var listCol = Get_ColumnListAll(Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote());
            for(col = 0; col < listCol.length && ColumnIndex < 0; col++)
             {

                if(VarToString(listCol[col]) ==  Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote().WPFControlText)
               {
            ColumnIndex = col;
    
              }
   
          }
          var indexColonNote=ColumnIndex+1;
          
          var displayNoteAfterModif=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", indexColonNote], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displayNoteAfterModif, "DisplayText", cmpEqual, modelTextAddNotCROES986);
          aqObject.CheckProperty(displayNoteAfterModif, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "VisibleOnScreen", cmpEqual, true);
          Get_WinModelInfo_BtnOK().Click();
          //Supppression de la note 
          SearchModelByName(modelNameCroes986);
          Get_ModelsGrid().Find("Value",modelNameCroes986,10).Click();
          Get_ModelsBar_BtnInfo().Click();
          Get_WinModelInfo_TabNotes().Click();
          Get_WinModelInfo_TabNotes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",modelTextAddNotCROES986,10).Click();
          Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          Get_WinModelInfo_BtnOK().Click();
          //les poinst de vérifications 
         SearchModelByName(modelNameCroes986);
         var indexModel=Get_ModelsGrid().FindChild("Value", modelNameCroes986, 10).Record.Index
         
         var valuIconHasNote=Get_ModelsGrid().RecordListControl.Items.Item(indexModel).DataItem.HasNote
         if(valuIconHasNote == true)
         {
          Log.Error("L'icône existe") 
         }
         else
         {
           Log.Checkpoint("L'icône n'existe pas")
         }
          
   

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(modelTextAddNotCROES986, vServerModeles)
        
      }  
}