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
function CROES_10678_Comp_FieldDateReferenceNotesMustBeEmptyDefaults()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-10678");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
       
       var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
       var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
       var CompTextAddNotTestCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CompTextAddNotTestCROES10678", language+client);
       
       Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
       //Choisir le module cleint
       Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      SearchAccount(numberAccount800083);
       Get_MainWindow().Maximize();          
       //ajout d'une note
      
       Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800083,10).Click();//Le modéle *FALL BACK n'as pas de note
       Get_AccountsBar_BtnInfo().Click()
      
       Get_WinInfo_Notes_TabGrid().Click();
       Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
       //Vérification que la date de référence est par défaut est vide sur la fenêtre d'ajout d'une note a partir de l'option info
       aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
       
       //Ajout d'une note
       Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
       var dateCreationCROES754=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %#I:%M");
       WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
       Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
       Get_WinCRUANote_GrpNote_TxtNote().Click()
       Get_WinCRUANote_GrpNote_TxtNote().Keys(CompTextAddNotTestCROES10678);
       Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES842, 10).Click();
       Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
       WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
       var textAjoutNoteCROES10678=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
       Log.Message(textAjoutNoteCROES10678)
       Get_WinCRUANote_BtnSave().Click();
       Get_WinDetailedInfo_BtnOK().Click();
         
       SearchAccount(numberAccount800083);
       Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800083,10).Click();
       Get_AccountsBar_BtnInfo().Click()
      
       Get_WinInfo_Notes_TabGrid().Click();
       Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(textAjoutNoteCROES10678),10).Click();
       
       Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
       Get_WinCRUANote().WaitProperty("VisibleOnScreen", true, 20000);
       
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
          
           UpdateDateCreation_Note(CompTextAddNotTestCROES10678,FormatDateYesterday,vServerAccounts);
           SearchAccount(numberAccount800083);
           Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800083,10).Click();
           Get_AccountsBar_BtnInfo().Click()
           
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(textAjoutNoteCROES10678),10).Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
           
           if (client == "CIBC" )
                Log.Message("Croes-11137");
           
           aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
           Get_WinCRUANote_BtnClose().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           //Les points de vérification pour la date de référence a partir du click-right
           SearchAccount(numberAccount800083);
           Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800083,10).Click();
           Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800083,10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
             aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(CompTextAddNotTestCROES10678, vServerAccounts)
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(CompTextAddNotTestCROES10678, vServerAccounts)
         Terminate_CroesusProcess();
        
      }  
}

function test123()
{
  
  var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
       var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
       var CompTextAddNotTestCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CompTextAddNotTestCROES10678", language+client);
       
  Delete_Note(CompTextAddNotTestCROES10678, vServerAccounts)
  
}