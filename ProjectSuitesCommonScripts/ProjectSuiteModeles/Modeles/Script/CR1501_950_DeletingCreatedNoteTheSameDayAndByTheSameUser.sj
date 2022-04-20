//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

            La preference 'PREF_NOTE_DELETE'=YES

            Se connecter avec 'COPERN'
            
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-950
        Description : 
        1-Choisir le module modèle:Le module modèle s'ouvre correctement
        2-Sélectionner un modèle.:Le modèle est bien sélectionné.
        3-Cliquer sur le bouton 'Info':La fenêtre info s'ouvre.
        4-Choisir l'onglet note ensuite cliquer sur le bouton 'Ajouter' pour ajouter une note.:L'onglet 'Note' est sélectionnée et la fenêtre d'ajout d'une note s'ouvre.
        5-Ajouter la note .:La note est ajoutée.
        6-Sélectionner la note crée ensuite cliquer sur le bouton 'Supprimer'.:Le bouton Supprimer est actif et la note est supprimée.
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_950_DeletingCreatedNoteTheSameDayAndByTheSameUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-950");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
        var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
        var modelTextAddNotCROES950=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES950", language+client);
    
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES950);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES950);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES950);
            var textNotCROES950= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES950), 10)
            var x=textNotCROES950.Exists;
            Log.Message(x);
          if(textNotCROES950.Exists && textNotCROES950.VisibleOnScreen)
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
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES950,10).Click();
          //Les points de vérification
        
              aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "Exists", cmpEqual, true);
              aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "VisibleOnScreen", cmpEqual, true);
          //Vérification de la suppression de la relation
           Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Click(); 
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
           //Les points de vérifications
           
           var  ExistenceNoteOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES950,10)
           if(ExistenceNoteOnGrill.Exists)
                {
                  Log.Error("La note n'est pas supprimée")
                }
                else
                {
                 Log.Checkpoint("La note est supprimée") 
                }
               Get_WinModelInfo_BtnOK().Click();   
           //Vérification que la note est supprimé aprés avoir fermer la fenêtre d'info modéle
           SearchModelByName(modelNameCroes940);
           Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
           Get_ModelsBar_BtnInfo().Click();     
      var  ExistenceNoteOnGrillAfterCloseInfo=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES950,10)
           if(ExistenceNoteOnGrillAfterCloseInfo.Exists)
                {
                  Log.Error("La note n'est pas supprimée")
                }
                else
                {
                 Log.Checkpoint("La note est supprimée") 
                }
                Get_WinModelInfo_BtnOK().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
      /*  Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","NO",vServerModeles);
        RestartServices(vServerModeles);*/
        Delete_Note(modelTextAddNotCROES950, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
