//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-940
        Description : 
        1-Choisir le module modèle:Le module modèle s'ouvre correctement
        2-Sélectionner un modèle.:Le modèle est bien sélectionné.
        3-Ajouter une note a ce modèle a partir de la fenêtre info:La note est ajoutée.
        4-Cliquer sur le bouton 'Info':La fenêtre info du mdèle sélectionné est ouverte.
        5-Sélectionner la note crée ensuite cliquer sur le bouton 'Modifier'.:La fenêtre de modification d'une note est affichée.
        6-Modifier la note ensuite cliquer sur le bouton sauvegarder.:La note est modifiée.

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CR1501_940_Model_ModificOfNotCreatedInTheSameDayAndbyTheSameUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-940");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerModeles);
        RestartServices(vServerModeles);
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES940", language+client);
       var modelTextAddNotCROES940Modif=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES940Modif", language+client);
       
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        // 4. Créer un nouveau modèle.
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES940);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
           WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
          Get_WinCRUANote_BtnSave().Click();
          //Modification de la note
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES940,10).Click();
          Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES940Modif);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
          Get_WinCRUANote_BtnSave().Click();
          //Les points de vérifications
       
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES940Modif);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES940Modif);
            var textNotCROES940= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES940Modif), 10)
            var x=textNotCROES940.Exists;
            Log.Message(x);
          if(textNotCROES940.Exists && textNotCROES940.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
          }
          
          Get_WinModelInfo_BtnOK().Click();
         //Vérification que la note est modifé aprés avoir fermer la fenêtre info
               SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click(); 
        //Les points de vérifications
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES940Modif);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES940Modif);
            var textNotCROES940= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES940Modif), 10)
            var x=textNotCROES940.Exists;
            Log.Message(x);
          if(textNotCROES940.Exists && textNotCROES940.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
          }
          Get_WinModelInfo_BtnOK().Click();
        
   

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
         Terminate_CroesusProcess(); //Fermer Croesus
         Delete_Note(modelTextAddNotCROES940, vServerModeles)
         Delete_Note(modelTextAddNotCROES940Modif, vServerModeles)
      }  
}
