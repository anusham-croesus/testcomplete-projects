//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

            La preference PREF_EDIT_NOTE=NO.

            Se connecter avec 'COPERN'
            
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-943
        Description : 
        1-Choisir le module modèle:Le module modèle s'ouvre correctement
        2-Sélectionner un modèle.:Le modèle est bien sélectionné.
        3-Ajouter une note a ce modèle a partir de la fenêtre info:La note est ajoutée.
        4-Cliquer sur le bouton 'Info':La fenêtre info du mdèle sélectionné est ouverte.
        5-Sélectionner la note crée précédemment.:On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
       
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_943_NoModificationOfANoteCreatesTheSameDayAndByTheSameUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-943");
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","NO",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
        var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
        var modelTextAddNotCROES943=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES943", language+client);
    
       
         Get_ModulesBar_BtnModels().Click();
         Get_MainWindow().Maximize();          
         //Chercher un modéle
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES943);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
        
          
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES943);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES943);
            var textNotCROES943= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES943), 10)
            var x=textNotCROES943.Exists;
            Log.Message(x);
          if(textNotCROES943.Exists && textNotCROES943.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
          }

          
          
          
          
          Get_WinModelInfo_BtnOK().Click();
         //Cliquer sur le bouton info
         
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         //Sélectionner la note crée précédemment
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES943,10).Click();
         //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnEdit().Exists && Get_WinInfo_Notes_TabGrid_BtnEdit().VisibleOnScreen )
         {
           Log.Error("Le bouton modifier existe et visble sur l'écran");
         }
         else
         {
            if(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Exists && Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().VisibleOnScreen )
            {
              aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
              Log.Checkpoint("Le bouton consulter existe et visible sur l'écran") 
            }
         }

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerModeles);
        RestartServices(vServerModeles);
        Delete_Note(modelTextAddNotCROES943, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
