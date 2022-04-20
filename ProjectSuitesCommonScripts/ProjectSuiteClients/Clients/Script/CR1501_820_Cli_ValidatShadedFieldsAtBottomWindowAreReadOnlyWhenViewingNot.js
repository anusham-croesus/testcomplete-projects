//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-820
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner un client qui contient des notes.:Le client est bien sélectionné.
         3-Cliquer sur le bouton Info ensuite cliquer sur le bouton 'Consulter' pour consulter une note.:La fenêtre info est ouverte et la fenêtre
          Consulter une note' est ouverte aussi.
         4-Vérifier que le contenu des champs 'Client', 'Date de création' et 'Créée par' est grisé.:Le contenu des champs 'Client', 
         'Date de création' et 'Créée par' est grisé.
          
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_820_Cli_ValidatShadedFieldsAtBottomWindowAreReadOnlyWhenViewingNot()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-820");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var PortTextAddNotTestCROES820=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES820", language+client);
         var textNoteCompletCROES820=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textNoteCompletCROES820", language+client);
        
        
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
          //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          //Sélectionner le client 800300
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
           //Ajout d'une note 
          Get_ClientsBar_BtnInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES820);
        
          var textAjoutNoteCROES820=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteCROES820)
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
          Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          //se connecter avec KEYNEJ
           Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
           //Sélectionner le client 800300
            //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
           //Ajout d'une note 
          Get_ClientsBar_BtnInfo().Click();
          //Cliquer sur le bouton consulter pour consulyter la note
           Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",textNoteCompletCROES820, 10).Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
           /*4-Vérifier que le contenu des champs 'Client', 'Date de création' et 'Créée par' est grisé.:Le contenu des champs 'Client', 
         'Date de création' et 'Créée par' est grisé.*/
         Log.Message("en anglais il faut voir ppour le titre de la fenêtre a display a note est devenue View a note")
         
         if(client == "CIBC"){
                 //Client   
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);// 
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 
                 //Date de création:
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 
                 //'Créée par'
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 }
         else{
               //Client
               aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);// 
               aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               //Date de création:
         
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               //'Créée par'
         
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               }          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
         Delete_Note(textNoteCompletCROES820, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Delete_Note(textNoteCompletCROES820, vServerClients)
      
        
    }
}

//function Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_20b4", 10)}
//
//function Get_WinNoteDetail_TxtPositionForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_a079", 10)}
//
//function Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_053b", 10)}