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
function CROES_10678_Rel_FieldDateReferenceNotesMustBeEmptyDefaults()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-10678");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
       var nameRelation1CROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "nameRelation1CROES10678", language+client);
       var relTextAddNotCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relTextAddNotCROES10678", language+client);
       var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
       var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          //Ajout d'une nouvelle relation
           Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          CreateRelationship(nameRelation1CROES10678)
          Get_MainWindow().Maximize();          
       //ajout d'une note
      
          SearchRelationshipByName(nameRelation1CROES10678);
         Get_RelationshipsClientsAccountsGrid().Find("Value",nameRelation1CROES10678,10).Click();//Le modéle *FALL BACK n'as pas de note
         Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
       
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
         Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
         //Vérification que la date de référence est par défaut est vide sur la fenêtre d'ajout d'une note a partir de l'option info
         aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         
         //Ajout d'une note 
         Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(relTextAddNotCROES10678);
         Get_WinCRUANote_GrpNote_BtnDateTime().Click();
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNoteNomrmal=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;;
          
          /**
           var textNotCROES1275= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1275.Exists;
          
          **/
          
          
          Log.Message(textAjoutNoteNomrmal)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
         
         SearchRelationshipByName(nameRelation1CROES10678);
         Get_RelationshipsClientsAccountsGrid().Find("Value",nameRelation1CROES10678,10).Click();
        Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(textAjoutNoteNomrmal),10).Click();
         Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          //Vérification que la date de référence est par défaut vide lors de la modification a partir de l'option info
         aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         Get_WinCRUANote_BtnSave().Click();
         Get_WinDetailedInfo_BtnOK().Click();
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
          
           UpdateDateCreation_Note(relTextAddNotCROES10678,FormatDateYesterday,vServerRelations);
           SearchRelationshipByName(nameRelation1CROES10678);
           Get_RelationshipsClientsAccountsGrid().Find("Value",nameRelation1CROES10678,10).Click();
           Get_RelationshipsBar_BtnInfo().Click()
           Get_WinDetailedInfo_TabInfo().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(textAjoutNoteNomrmal),10).Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
           
           if (client == "CIBC" )
                Log.Message("Croes-11137");
           
           aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
           Get_WinCRUANote_BtnClose().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           //Les points de vérification pour la date de référence a partir du click-right
           SearchRelationshipByName(nameRelation1CROES10678);
           Get_RelationshipsClientsAccountsGrid().Find("Value",nameRelation1CROES10678,10).Click();
           Get_RelationshipsClientsAccountsGrid().Find("Value",nameRelation1CROES10678,10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
             aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES10678)
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
         DeleteRelationship(nameRelation1CROES10678)
         Terminate_CroesusProcess();
        
      }  
}
