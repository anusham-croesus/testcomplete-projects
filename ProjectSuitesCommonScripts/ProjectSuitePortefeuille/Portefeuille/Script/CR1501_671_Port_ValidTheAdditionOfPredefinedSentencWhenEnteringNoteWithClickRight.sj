//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-671
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3- Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4- Sélectionner une position qui contient des notes:La position est bien sélectionnées.
         5- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         6- Cliquer sur le bouton 'Créer nouvelle phrase' ensuite saisir une phrase.:La nouvelle phrase est saisie.
         7-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:La nouvelle phrase saisie précédemment fait partie parmi la liste
          des phrases prédéfinies.
          
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
*/



function CR1501_671_Port_ValidTheAdditionOfPredefinedSentencWhenEnteringNoteWithClickRight()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
      
        //Les variables
          var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
          var namePredefinSentenceCROES671=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceCROES671", language+client);
          var sentencePredefinedCROES671=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedCROES671", language+client);
          var createdBySentPrefedCROES671=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "createdBySentPrefedCROES671", language+client);
          var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          
          
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          //Sélectionner le compte 800300-NA
         Search_Account(numberAccount800300NA)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
           Delay(800)
           
           //Ajout d'une phrase prédéfinie
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES671);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES671);
           Get_WinAddNewSentence_BtnSave().Click();
           
           
           //Les points de vérifications
          var displaySenPredef=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1)
          Log.Message("CROES-10547");
          aqObject.CheckProperty(displaySenPredef, "DisplayText", cmpEqual, createdBySentPrefedCROES671);
          aqObject.CheckProperty(displaySenPredef, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredef, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredef, "VisibleOnScreen", cmpEqual, true);
          var displaySenPredefName=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displaySenPredefName, "DisplayText", cmpEqual, namePredefinSentenceCROES671);
          aqObject.CheckProperty(displaySenPredefName, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefName, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefName, "VisibleOnScreen", cmpEqual, true);
          Get_WinCRUANote_BtnCancel1().Click();
          
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
           
            var displaySenPredef=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1)
          Log.Message("CROES-10547");
          aqObject.CheckProperty(displaySenPredef, "DisplayText", cmpEqual, createdBySentPrefedCROES671);
          aqObject.CheckProperty(displaySenPredef, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredef, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredef, "VisibleOnScreen", cmpEqual, true);
          var displaySenPredefName=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displaySenPredefName, "DisplayText", cmpEqual, namePredefinSentenceCROES671);
          aqObject.CheckProperty(displaySenPredefName, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefName, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefName, "VisibleOnScreen", cmpEqual, true);
          Get_WinCRUANote_BtnCancel1().Click();
          
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES671, vServerPortefeuille)
        Delete_PredefinedSentencesGRD(vServerPortefeuille)
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES671, vServerPortefeuille)
        Delete_PredefinedSentencesGRD(vServerPortefeuille)
        Terminate_CroesusProcess();
        
    }
}


