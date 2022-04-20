//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Préconditions:
          Se connecter avec COPERN. 
          La préférence pref_edit_note=YES.
        
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-941
        Description :
         
        1-Se connecter avec COPERN.:L'application s'ouvre correctement.
        2-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        3-Ajouter une note a ce modèle a partir de la fenêtre info.:La note est ajoutée.
        4-Fermer l'application.:L'application se ferme correctement.
        5-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
        6-Choisir le module modèle:Le module modèle est ouvert.
        7-Sélectionner le même modèle surlequel on a ajouté la note avec COPERN.:Le modèle est sélectionné.
        8-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné
        9-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
        10-Essayer de modifier la note.:On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
        

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CR1501_941_NoModificationOfANoteCreatedTheSameDayAndByAnotherUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-941");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
        passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES941=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES941", language+client);
    
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES941);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
        
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES941);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES941);
            var textNotCROES941= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES941), 10)
            var x=textNotCROES941.Exists;
            Log.Message(x);
          if(textNotCROES941.Exists && textNotCROES941.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
          }

          
          Get_WinModelInfo_BtnOK().Click();
          Close_Croesus_X();
          // se connecter avec DALTOJ
          Login(vServerModeles, userNameDALTOJ, passwordDALTOJ, language);
          Get_ModulesBar_BtnModels().Click();
          Get_MainWindow().Maximize(); 
          SearchModelByName(modelNameCroes940);
          Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
          Get_ModelsBar_BtnInfo().Click();
          Get_WinModelInfo_TabNotes().Click();
          Get_WinModelInfo_TabNotes_TabGrid().Click();
          //Vérifier qu'on peut pas modifier la note
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES941,10).Click();
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
        Delete_Note(modelTextAddNotCROES941, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
