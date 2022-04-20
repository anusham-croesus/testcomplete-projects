//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

            La preference 'PREF_NOTE_DELETE'=NO

            Se connecter avec 'COPERN'
            
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-949
        Description : 
        1-Choisir le module modèle:Le module modèle s'ouvre correctement
        2-Sélectionner un modèle.:Le modèle est bien sélectionné.
        3-Ajouter une note a ce modèle a partir de la fenêtre info.La note est ajoutée.
        4-Cliquer sur le bouton 'Info':La fenêtre info du modèle sélectionné est ouverte.
        5-Sélectionner la note crée précédemment.:On peut pas supprimer la note et le bouton 'Supprimer' est grisé.
        
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_949_NotDeletingANoteCreatedOnTheSameDayAndByTheSameUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-949");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","NO",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
        var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
        var modelTextAddNotCROES949=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES949", language+client);
    
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES949);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
          var displayNoteAfterModif=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displayNoteAfterModif, "DisplayText", cmpEqual, modelTextAddNotCROES949);
          aqObject.CheckProperty(displayNoteAfterModif, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "VisibleOnScreen", cmpEqual, true);
          Get_WinModelInfo_BtnOK().Click();
          //Cliquer sur le bouton info
         
          SearchModelByName(modelNameCroes940);
          Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
          Get_ModelsBar_BtnInfo().Click();
          //Sélectionner la note crée précédemment
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES949,10).Click();
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
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerModeles);
        RestartServices(vServerModeles);
        Delete_Note(modelTextAddNotCROES949, vServerModeles)
        Terminate_CroesusProcess();
      }  
}

