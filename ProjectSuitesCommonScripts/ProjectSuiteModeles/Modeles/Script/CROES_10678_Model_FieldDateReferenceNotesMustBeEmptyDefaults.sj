//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**

 Anomalie:CROES-10678
        

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CROES_10678_Model_FieldDateReferenceNotesMustBeEmptyDefaults()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-10678");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var NameModelCROESUS_10678=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameModelCROESUS_10678", language+client);
       var modelTextAddNotCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelTextAddNotCROES10678", language+client);
      
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
       //ajout d'une note
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(NameModelCROESUS_10678);
         Get_ModelsGrid().Find("Value",NameModelCROESUS_10678,10).Click();//Le modéle *FALL BACK n'as pas de note
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         //Vérification que la date de référence est par défaut est vide sur la fenêtre d'ajout d'une note a partir de l'option info
         aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         
         //Ajout d'une note 
        
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES10678);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         Get_WinModelInfo_BtnOK().Click();
         
         SearchModelByName(NameModelCROESUS_10678);
         Get_ModelsGrid().Find("Value",NameModelCROESUS_10678,10).Click();//Le modéle *FALL BACK n'as pas de note
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES10678,10).Click();
         Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          
          //Vérification que la date de référence est par défaut vide lors de la modification a partir de l'option info      
         aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         Get_WinCRUANote_BtnSave().Click();
         Get_WinModelInfo_BtnOK().Click();
         //Vérification que la date de référence est par défaut vide lors de la consultation a partir de l'option info
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
                    
           var FormatDateYesterday=aqConvert.DateTimeToFormatStr(ConvertedYesterdayDate, "%b %d %Y %#I:%M %p")
           Log.Message(FormatDateYesterday);
          
           UpdateDateCreation_Note(modelTextAddNotCROES10678,FormatDateYesterday,vServerModeles);
           SearchModelByName(NameModelCROESUS_10678);
           Get_ModelsGrid().Find("Value",NameModelCROESUS_10678,10).Click();//Le modéle *FALL BACK n'as pas de note
           Get_ModelsBar_BtnInfo().Click();
           Get_WinModelInfo_TabNotes().Click();
           Get_WinModelInfo_TabNotes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES10678,10).Click();
           Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Click();
           if (client == "CIBC" )
                Log.Message("Croes-11137");
           aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
          
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
         Terminate_CroesusProcess(); //Fermer Croesus
         Delete_Note(modelTextAddNotCROES10678, vServerModeles)
        
      }  
}
