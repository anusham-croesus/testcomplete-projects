//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-677
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3- Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4- Sélectionner une position qui contient des notes:La position est bien sélectionnées.
         5- Cliquer sur le bouton "Info" ensuite cliquer sur le bouton "Ajouter":La fenêtre 'ajouter une note' est ouverte.
         6- Sélectionner une phrase prédéfinie crée avec l'utilisateur copern ensuite faire un double-clic pour la modifier.:La phrase est bien sélectionnée
          et le champ est modifiable.
         7-Modifier la phrase ensuite fermer la fenêtre 'Ajouter une note' et l'ouvrir de nouveau.:La phrase prédéfinie est modifiée.
          
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
*/



function CR1501_677_Port_ValidModifOfPredefinedSentencWhenEnteringNotWithInfo()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
      
        //Les variables
          var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
          var namePredefinSentenceCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceCROES677", language+client);
          var sentencePredefinedCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedCROES677", language+client);
          var createdBySentPrefedCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "createdBySentPrefedCROES677", language+client);
          var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          var namePredefinSentenceModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceModCROES677", language+client);
          var sentencePredefinedModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedModCROES677", language+client);
          
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
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
           Get_PortfolioBar_BtnInfo().Click()
           Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           
           Delay(800)
           
           //Ajout d'une phrase prédéfinie
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES677);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES677);
           Get_WinAddNewSentence_BtnSave().Click();
           //Modification d'une phrase prédéfinie
           Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceCROES677, 10).Click();
           Get_WinCRUANote_BtnEditPredefinedSentences().Click();
           Get_WinEditSentence_TxtName().Click()
           Get_WinEditSentence_TxtName().set_Text(namePredefinSentenceModCROES677);
           Get_WinEditSentence_TxtSentence().Click()
		       Get_WinEditSentence_TxtSentence().set_Text(sentencePredefinedModCROES677);
           Get_WinEditSentence_BtnSave().Click();
           Get_WinCRUANote_BtnCancel1().Click();
           Get_WinPositionInfo_BtnOK().Click();
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
           Get_PortfolioBar_BtnInfo().Click()
          Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           Delay(800)
          //Les points de vérification
          
         
          var displaySenPredefNameModif=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1)
          aqObject.CheckProperty(displaySenPredefNameModif, "DisplayText", cmpEqual, namePredefinSentenceModCROES677);
          aqObject.CheckProperty(displaySenPredefNameModif, "Enabled", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefNameModif, "Exists", cmpEqual, true);
          aqObject.CheckProperty(displaySenPredefNameModif, "VisibleOnScreen", cmpEqual, true);
          
           Delay(1000)
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceModCROES677, 10).Click();
          Delay(1000)
          Get_WinCRUANote_BtnEditPredefinedSentences().Click();
          //Les points de vérifications
          aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Text", cmpEqual, namePredefinSentenceModCROES677);
          aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Enabled", cmpEqual, true);
          aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "VisibleOnScreen", cmpEqual, true);
          
          aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Text", cmpEqual, sentencePredefinedModCROES677);
          aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Enabled", cmpEqual, true);
          aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "VisibleOnScreen", cmpEqual, true);
          
          Get_WinEditSentence_BtnCancel().Click();
          Get_WinCRUANote_BtnCancel1().Click();
          Get_WinPositionInfo_BtnOK().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceModCROES677, vServerPortefeuille)
        Delete_PredefinedSentences(namePredefinSentenceCROES677, vServerPortefeuille)
        Delete_PredefinedSentencesGRD(vServerPortefeuille)
         
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceModCROES677, vServerPortefeuille)
        Delete_PredefinedSentences(namePredefinSentenceCROES677, vServerPortefeuille)
        Delete_PredefinedSentencesGRD(vServerPortefeuille)
        Terminate_CroesusProcess();
        
    }
}
