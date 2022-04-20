//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-894
    
   
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Cliquer sur le bouton 'Par titre'.:La fenêtre de répartition par titre est affichée. 
         5-Sélectionner une position ensuite faire un click-right et choisir 'Ajouter une note'.:La fenêtre 'Ajouter une note ' est affichée.
         6-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:La phrase prédéfinie et ''heure & date ' 
         sont insérés correctemet.La fenêtre 'ajouter une note' est fermée.
         7-Ouvrir la fenêtre info de la position ensuite sélectionner l'onglet note.:La note est bien ajoutée sur la position.
      
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_894_Port_ValidatInsertingANoteToSelectedRecordFofRroupingByTitre()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-894");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
         var PortTextAddNotTestCROES894=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES894", language+client);
         var numberAccountPositionBySecurity=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccountPositionBySecurity", language+client);
          
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          //Sélectionner le client 800300
          Search_Client(numberClient800300)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
         
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           
           Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().Click();
           
           if (client == "CIBC"){
              aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsChecked", cmpEqual, false);
              Search_SecurityBySymbol(numberAccountPositionBySecurity)
              }
           else{ 
              aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsChecked", cmpEqual, true);
              Search_PositionByAccountNo(numberAccountPositionBySecurity)
              }
                
        //Sélectionner une position
           
           Get_Portfolio_AssetClassesGrid().FindChild("Value", numberAccountPositionBySecurity, 10).Click();
           Get_Portfolio_AssetClassesGrid().FindChild("Value", numberAccountPositionBySecurity, 10).ClickR(); 
           //Ajout d'une  note
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
            
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
           
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 30000);
          // WaitObject(Get_WinCRUANote(), ["UID", "IsLoaded","IsEnabled"], ["Button_4da0", true,true]);
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES894);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          var textAjoutNoteCROES894=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteCROES894)
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
              
           //Les points de vérifications
           

        Get_Portfolio_AssetClassesGrid().FindChild("Value", numberAccountPositionBySecurity, 10).DblClick(); 
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        // La note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES894);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotTestCROES894);
            var textNotCROES894= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES894), 10)
           
          if(textNotCROES894.Exists && textNotCROES894.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinPositionInfo_BtnCancel().Click();
        
         
         
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNoteCROES894, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNoteCROES894, vServerPortefeuille)
        
    }
}
