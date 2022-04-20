//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

            La preference 'PREF_NOTE_DELETE'=YES

            Se connecter avec 'COPERN'
            
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1117
        Description : 
        1-Choisir le module modèle:Le module modèle s'ouvre correctement
        2-Sélectionner un modèle qui contient des notes.:le modèle est bien sélectionné.
        3-Cliquer sur le bouton info:La fenêtre info est ouverte.
        4-Sélectionner une note dont sa date de création est différente de la date du jour.:
          On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_1117_NotModifyingNoteNotCreatedTheSameDayFromInfoAndBySameUser()
{
    try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1117");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerModeles);
        RestartServices(vServerModeles);

        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
        var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
        var modelTextAddNotCROES1117=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES1117", language+client);
    
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES1117);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
          var displayNoteAfterModif=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displayNoteAfterModif, "DisplayText", cmpEqual, modelTextAddNotCROES1117);
          aqObject.CheckProperty(displayNoteAfterModif, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displayNoteAfterModif, "VisibleOnScreen", cmpEqual, true);
          Get_WinModelInfo_BtnOK().Click();
          //Modifier la date de création a partir de la BD
          // Obtain the current date
          var CurrentDate = aqDateTime.Today();

          // Convert the date/time value to a string and post it to the log
          Today = aqConvert.DateTimeToStr(CurrentDate);
          Log.Message("Today is " + Today);

          // Calculate the yesterday’s date, convert the returned date to a string and post this string to the log
          YesterdayDate = aqDateTime.AddDays(CurrentDate, -1);
          ConvertedYesterdayDate = aqConvert.DateTimeToStr(YesterdayDate);
          Log.Message("Yesterday was " + ConvertedYesterdayDate);
          //
  
          var FormatDateYesterday=aqConvert.DateTimeToFormatStr(ConvertedYesterdayDate, "%b %d %Y %#I:%M %p")
          Log.Message(FormatDateYesterday);
          
          UpdateDateCreation_Note(modelTextAddNotCROES1117,FormatDateYesterday,vServerModeles);
  
          //Cliquer sur le bouton info
         
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         //Sélectionner la note crée précédemment
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES1117,10).Click();
         
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
        /* Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerModeles);
        RestartServices(vServerModeles);*///je l'ai pas désactivé parce que sur le dump de BNC la pref est a YES
        Delete_Note(modelTextAddNotCROES1117, vServerModeles)
        Terminate_CroesusProcess();
      }  
}

