//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

            La preference 'PREF_NOTE_DELETE'=YES

       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-951
        Description : 
        1-Se connecter avec COPERN.:L'application s'ouvre correctement.
        2-Choisir le module modèle:Le module modèle s'ouvre correctement.
        3-Sélectionner un modèle.:Le modèle est sélectionné.
        4-Ajouter une note a ce modèle a partir du bouton  'info':La note est ajoutée.
        5-La note est ajoutée.:L'application se ferme correctement.
        6-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
        7-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        8-Sélectionner le modèle surlequel la note a été ajouté par COPERN.:Le modèle est sélectionné.
        9-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné.
        10-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
        11-Essayer de supprimer la note:On peut pas supprimer la note et le bouton 'Supprimer' est grisé.
        
        
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_951_NotDeletingCreatedNoteTheSameDayAndByAnotherUser()
{
  try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-951");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
        passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES951=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES951", language+client);
    
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES951);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
          var displayNoteAfterModif=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displayNoteAfterModif, "DisplayText", cmpEqual, modelTextAddNotCROES951);
          aqObject.CheckProperty(displayNoteAfterModif, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "VisibleOnScreen", cmpEqual, true);
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
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES951,10).Click();
          //Les points de vérification
          aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "VisibleOnScreen", cmpEqual, true);
            

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(modelTextAddNotCROES951, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
