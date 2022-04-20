//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT PDFUtils



/**

 Anomalie:CROES-10678
        

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CROES_10678_Tit_FieldDateReferenceNotesMustBeEmptyDefaults()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-10678");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
       var DescrSecurityCROES_7801=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "DescrSecurityCROES_7801", language+client);
       var titrTextAddNotTestCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "titrTextAddNotTestCROES10678", language+client);
               
       //Mettre la PREF_EDIT_SECURITY_NOTE  a YES
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","YES",vServerTitre);
       RestartServices(vServerTitre);
       
       Login(vServerTitre, userNameCOPERN, passwordCOPERN, language);
       Get_ModulesBar_BtnSecurities().Click();
       Get_MainWindow().Maximize();    
       Search_SecurityByDescription(DescrSecurityCROES_7801)
       Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
       Get_SecuritiesBar_BtnInfo().Click();
       Get_WinInfoSecurity_Notes().Click();
       Get_WinInfo_Notes_TabGrid_BtnAdd().Click()
       //Vérification que la date de référence est par défaut est vide sur la fenêtre d'ajout d'une note a partir de l'option info
       aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
        //Ajout d'une note
       Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
      
       Get_WinCRUANote_GrpNote_TxtNote().Click()
       Get_WinCRUANote_GrpNote_TxtNote().Keys(titrTextAddNotTestCROES10678);
       Get_WinCRUANote_BtnSave().Click();
       Get_WinInfoSecurity_BtnOK().Click();
       //Vérification que la date de référence est par défaut vide lors de la modification a partir de l'option info
       Get_ModulesBar_BtnSecurities().Click();
       Get_MainWindow().Maximize();    
       Search_SecurityByDescription(DescrSecurityCROES_7801)
       Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
       Get_SecuritiesBar_BtnInfo().Click();
       Get_WinInfoSecurity_Notes().Click();
       Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(titrTextAddNotTestCROES10678),10).Click();
       Get_WinInfo_Notes_TabGrid_BtnEdit().Click()
      //Les points de vérifications
        aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
       Get_WinCRUANote_BtnSave().Click();
       Get_WinInfoSecurity_BtnOK().Click();
       
       
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
          
           UpdateDateCreation_Note(titrTextAddNotTestCROES10678,FormatDateYesterday,vServerTitre);
           //
           Search_SecurityByDescription(DescrSecurityCROES_7801)
           Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
           Get_SecuritiesBar_BtnInfo().Click();
           Get_WinInfoSecurity_Notes().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(titrTextAddNotTestCROES10678),10).Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click()
           
           if (client == "CIBC" )
                Log.Message("Croes-11137");
           
           aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
           Get_WinCRUANote_BtnClose().Click();
           Get_WinInfoSecurity_BtnOK().Click();
       
           //Les points de vérifications pour l'option click-right
            Search_SecurityByDescription(DescrSecurityCROES_7801)
           Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
           Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).ClickR();
           Get_SecurityGrid_ContextualMenu_AddANote().Click();
           //Les points de vérifications
            aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(titrTextAddNotTestCROES10678, vServerTitre)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","NO",vServerTitre);
        RestartServices(vServerTitre);
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(titrTextAddNotTestCROES10678, vServerTitre)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","NO",vServerTitre);
        RestartServices(vServerTitre);
        Terminate_CroesusProcess();
        
      }  
}

