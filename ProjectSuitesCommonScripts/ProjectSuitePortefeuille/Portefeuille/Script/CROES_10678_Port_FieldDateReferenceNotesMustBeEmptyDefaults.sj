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
function CROES_10678_Port_FieldDateReferenceNotesMustBeEmptyDefaults()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-10678");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
       
       
       var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
       var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
       var PortTextAddNotCROES10678=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "PortTextAddNotCROES10678", language+client);
       
       Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
       //Choisir le module cleint
       Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(numberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
       Search_PositionByAccountNo(numberAccount800300NA)
       Search_PositionByDescription(positionDescripCROES566)
       Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
       Get_PortfolioBar_BtnInfo().Click()
       Get_WinPositionInfo_TabNotes().Click();
       Get_WinInfo_Notes_TabGrid().Click();
       Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        //Vérification que la date de référence est par défaut est vide sur la fenêtre d'ajout d'une note a partir de l'option info
       aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
        //Ajout d'une note   
       Get_WinCRUANote_GrpNote_TxtNote().Click()
       Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotCROES10678);
       Get_WinCRUANote_GrpNote_TxtNote().Click()
       Delay(8000)
       Get_WinCRUANote_BtnSave().Click();
       Get_WinPositionInfo_BtnOK().Click();
       //Vérification que la date de référence est par défaut est vide sur la fenêtre de modification d'une note a partir de l'option info
       Search_PositionByAccountNo(numberAccount800300NA)
       Search_PositionByDescription(positionDescripCROES566)
       Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
       Get_PortfolioBar_BtnInfo().Click()
       Get_WinPositionInfo_TabNotes().Click();
       Get_WinInfo_Notes_TabGrid().Click();
       Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(PortTextAddNotCROES10678),10).Click();
       Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        //Les points de vérifications
        aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
        Get_WinCRUANote_BtnSave().Click();
       Get_WinPositionInfo_BtnOK().Click();
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
          
           UpdateDateCreation_Note(PortTextAddNotCROES10678,FormatDateYesterday,vServerPortefeuille);
       
       
        Search_PositionByAccountNo(numberAccount800300NA)
       Search_PositionByDescription(positionDescripCROES566)
       Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
       Get_PortfolioBar_BtnInfo().Click()
       Get_WinPositionInfo_TabNotes().Click();
       Get_WinInfo_Notes_TabGrid().Click();
       Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", VarToString(PortTextAddNotCROES10678),10).Click();
       Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
       //Les points de vérifications
       
       if (client == "CIBC" )
                Log.Message("Croes-11137");
       
       aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
       Get_WinCRUANote_BtnClose().Click();
       Get_WinPositionInfo_BtnOK().Click();
       //Les points de vérification pour la date de référence a partir du click-right
       Search_PositionByAccountNo(numberAccount800300NA)
       Search_PositionByDescription(positionDescripCROES566)
       Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
       Get_PortfolioGrid_ContextualMenu_AddANote().Click();
       //Les points de vérifications 
       aqObject.CheckProperty(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), "WPFControlText", cmpEqual, "");
        
        
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotCROES10678, vServerPortefeuille)
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(PortTextAddNotCROES10678, vServerPortefeuille)
         Terminate_CroesusProcess();
        
      }  
}
function test()
{
  


}