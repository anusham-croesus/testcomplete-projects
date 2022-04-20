//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT Regression_2034_2035_2036_2037_Tit_EditSecurity
//USEUNIT Regression_2030_2031_2032_2033_Tit_AddSecurity



/**
    Module               :  Titres
    CR                   :  Regression
    TestLink             :  Croes-2038, Croes-2039, Croes-4258, Croes-2040
    Description          :  Supprimer un titre par:
                            - Bouton supprimer
                            - Menu Edition/ supprimer
                            - Clic-droit
                            - Ctrl + D
                            On valide qu'il est possible de supprimer un titre manuel de chaque catégorie.
    
    Préconditions        :  - Un titre réel ne peut être supprimé à moins d'avoir la pref avancée PREF_EDIT_REAL_SECURITY.  
                            - Dans ce test, on valide seulement la suppression des titres manuels (type = MAN).  Se référer au cas CROES-2030 pour ajouter des titres manuels.
                            - Un titre manuel peut être ajouté à un compte fictif ou externe.  Si le titre manuel est détenu dans un portefeuille, il ne sera pas possible de le supprimer.
                            - Se référer au cas CROES-2221 du module Portefeuille pour créer un compte fictif à partir d'une simulation et ensuite y ajouter un titre manuel.
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-12
    Date                 :  15/03/2019
    
    NB: Ce script nécessite l'execution du script EditSecurity
    
*/

function Regression_2038_2039_4259_2040_Tit_DeleteSecurity() {
         
      try {
            //lien pour TestLink
            Log.Message("Le script décrit la suppression d'un titre à 4 façons différentes");
            Log.Message("Le lien de test link qui suit ce message pointe sur la 1ere façon de la suppression");
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2038","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var descriptionEquityButtonDelete = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityButtonDelete", language+client);
            var descriptionEquityEditMenuDelete  = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityEditMenuDelete", language+client);
            var descriptionEquityClickRDelete = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityClickRDelete", language+client);
            var descriptionEquityCtrlEDelete = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityCtrlEDelete", language+client);
            var messageHeldInPortfolio = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "messageHeldInPortfolio", language+client);
            
            var noClient ="300001";
            var nomCompte = "FICTITIOUS SIMUL";
            var frenchDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionEquityButton", language+client);
            var englishDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionEquityButton", language+client);
            var country = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "country", language+client);
                    
            //Se connecter à croesus et aller au module Titre
            Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
                        
            //-------------CROES-2038 Suppression d'un titre par bouton supprimer ----------------------------------------------------------------------------
            // Titre manuel non détenu dans un portefeuille
            Log.Message("------------------ Supprimer un titre non détenu dans un portefeuille avec le bouton Supprimer ----------------------");
            CheckNotHeldInPortfolio(descriptionEquityButtonDelete, messageHeldInPortfolio);
            if (Get_SecurityGrid().Find("Value",descriptionEquityButtonDelete,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityButtonDelete,10).Click() ;
                Get_Toolbar_BtnDelete().Click();
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            }else {
                Log.Error("Le titre à supprimer n'existe pas dans la grille");
            }
            CheckSecurityIsDeleted(descriptionEquityButtonDelete);
                 
            //-------------CROES-2039 Suppression d'un titre par Menu Edition- supprimer ---------------------------------------------------------------------
            // Titre manuel non détenu dans un portefeuille
            Log.Message("--------------------- Supprimer un titre non détenu dans un portefeuille avec Menu Edition- supprimer --------------");
            CheckNotHeldInPortfolio(descriptionEquityEditMenuDelete, messageHeldInPortfolio);
            if (Get_SecurityGrid().Find("Value",descriptionEquityEditMenuDelete,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityEditMenuDelete,10).Click() ;
                Get_MenuBar_Edit().OpenMenu();
                Get_MenuBar_Edit_Delete().Click();
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            }else {
                Log.Error("Le titre à supprimer n'existe pas dans la grille");
            }
            CheckSecurityIsDeleted(descriptionEquityEditMenuDelete);
             
            //-------------CROES-4249 Suppression d'un titre par Clic-droit de la souris -------------------------------------------------------------------
            // Titre manuel non détenu dans un portefeuille
            Log.Message("--------------- Supprimer un titre non détenu dans un portefeuille avec Clic-droit de la souris ------------------");
            CheckNotHeldInPortfolio(descriptionEquityClickRDelete, messageHeldInPortfolio);
            if (Get_SecurityGrid().Find("Value",descriptionEquityClickRDelete,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityClickRDelete,10).ClickR() ;
                Get_SecurityGrid_ContextualMenu_Delete().Click();
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            }else {
                Log.Error("Le titre à supprimer n'existe pas dans la grille"); 
            }   
            CheckSecurityIsDeleted(descriptionEquityClickRDelete);
            
            //-------------CROES-2040 Suppression d'un titre par CTRL+D --------------------------------------------------------------------------------------
            // Titre manuel non détenu dans un portefeuille
            Log.Message("------------------ Supprimer un titre non détenu dans un portefeuille avec CTRL+D ----------------------------");
            CheckNotHeldInPortfolio(descriptionEquityCtrlEDelete, messageHeldInPortfolio);
            if (Get_SecurityGrid().Find("Value",descriptionEquityCtrlEDelete,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityCtrlEDelete,10).Click() ;
                Get_SecurityGrid().Keys("^d");
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            }else {
                Log.Error("Le titre à supprimer n'existe pas dans la grille"); 
            } 
            CheckSecurityIsDeleted(descriptionEquityCtrlEDelete);
            
            //Ajouter un titre sur lequel on va faire les tests de suppression d'un titre retenu dans un portefeuille
            Log.Message("------------- Ajouter un titre sur lequel on va faire les tests de suppression d'un titre retenu dans un portefeuille ------");
            Get_Toolbar_BtnAdd().Click();
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemEquity(),frenchDescriptionEquityButton, englishDescriptionEquityButton, country);
            
            // Créer un compte fictif, associé le titre créé et valider que la suppression est inactive
             Log.Message("----------- Créer un compte fictif, associé le titre créé et valider que la suppression est inactive -----------------------");
            var description;
            if (language == "french") description = frenchDescriptionEquityButton;
            else description = englishDescriptionEquityButton;
            CreateSimulationFictifAccountAndAssociateSecurity(noClient,nomCompte,description);
            CheckHeldInPortfolio(description, nomCompte);
            CheckBtnDeleteInactif(description); 
            
            //Valider que la suppression d'un titre réel est inactive
            Log.Message("----------- Valider que la suppression d'un titre réel est inactive --------------------------------");
            var titreReel = "TREDEGAR CORPORATION";
            CheckBtnDeleteInactif(titreReel); 
               
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    //Supprimer le compte fictif créé
                    DeleteFictitiousAccount(nomCompte);
                    Delay(10000);
                                       
                    //Supprimer le titre créé
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
                    Delete_SecurityInGrid(frenchDescriptionEquityButton,englishDescriptionEquityButton);
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    //Terminate_IEProcess();
          }
}
function CheckNotHeldInPortfolio(description, message){
      Search_SecurityByDescription(description);
      if (Get_SecurityGrid().Find("Value",description,10).Exists)
        {
           Get_SecurityGrid().Find("Value",description,10).Click();
           Get_MenuBar_Modules().OpenMenu();
           Get_MenuBar_Modules_Portfolio().Click();
           Get_MenuBar_Modules_Portfolio_DragSelection().Click(); 
           aqObject.CheckProperty(Get_DlgInformation_LblMessage().Text, "OleValue", cmpEqual, message);
           Get_DlgInformation_BtnOK().Click();
           
        }else {
            Log.Error("Le titre qu'on veut mailler n'existe pas");
        }
}

function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

function CheckSecurityIsDeleted(description){
      Search_SecurityByDescription(description);
      if (Get_SecurityGrid().Find("Value",description,10).Exists)
          Log.Error("Le titre existe toujours dans la grille");
      else 
          Log.Checkpoint("Le titre n'existe pas dans la grille");
}

function CreateSimulationFictifAccountAndAssociateSecurity(noClient,nomCompte,description)
{
      Get_ModulesBar_BtnClients().Click();
      Search_Client(noClient);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", noClient, 10).Click();
  
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Portfolio().Click();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
      Get_PortfolioBar_BtnWhatIf().Click();
      Get_PortfolioBar_BtnCancel().Click();
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(2/3)),73);
  
      Get_PortfolioBar_BtnSave().Click();
      Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
      Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(nomCompte);
      Get_WinWhatIfSave_BtnOK().Click();
      Get_DlgInformation().Find("WPFControlText","OK",10).Click();
  
      // Ajouter une position (Titre)
      Get_Toolbar_BtnAdd().Click();
      Get_WinAddPosition_GrpAdd_TxtQuickSearchKey().Keys(description);
      Get_WinAddPosition_GrpAdd_DlSecurityListPicker().Click();
      Get_WinAddPosition_GrpPositionInformation_TxtQuantity().Keys(10);
      Get_WinAddPosition_BtnOK().Click();
 
      //Sauvegarder les modifications
      Get_PortfolioBar_BtnSave().Click();
      Get_WinWhatIfSave_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "WhatIfSaveWindow_afd7");
}

function CheckHeldInPortfolio(description, nomCompte){
      Get_ModulesBar_BtnSecurities().Click();
      Search_SecurityByDescription(description);
      if (Get_SecurityGrid().Find("Value",description,10).Exists)
        {
           Get_SecurityGrid().Find("Value",description,10).Click();
           Get_MenuBar_Modules().OpenMenu();
           Get_MenuBar_Modules_Portfolio().Click();
           Get_MenuBar_Modules_Portfolio_DragSelection().Click();
           aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem, "ClientFullName", cmpEqual, nomCompte);          
        }else {
            Log.Error("Le titre qu'on veut mailler n'existe pas");
        }
}

function DeleteFictitiousAccount(nomCompte){
      Get_ModulesBar_BtnClients().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      SearchClientByName(nomCompte);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", nomCompte, 10).Click();
      Get_Toolbar_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
}
function CheckBtnDeleteInactif(description){
      Get_ModulesBar_BtnSecurities().Click();
      Search_SecurityByDescription(description);
      Get_SecurityGrid().Find("Value",description,10).Click();
      //Valider que le bouton Supprimer est inactif
      aqObject.CheckProperty(Get_Toolbar_BtnDelete(), "IsEnabled", cmpEqual, false);
      //Valider que Supprimer du menu Edition est inactif
      Get_MenuBar_Edit().OpenMenu();
      aqObject.CheckProperty(Get_MenuBar_Edit_Delete(), "IsEnabled", cmpEqual, false);
      //Valider que Supprimer du Click droit est inactif
      Get_SecurityGrid().Find("Value",description,10).ClickR();
      aqObject.CheckProperty(Get_SecurityGrid_ContextualMenu_Delete(), "IsEnabled", cmpEqual, false);
      //Valider qu'il n ya pas une fenêtre de confirmation de suppression après CTRL+D
      Get_SecurityGrid().Find("Value",description,10).Click();
      Get_SecurityGrid().Keys("^d");
      if (Get_DlgConfirmation().Exists)
          Log.Error("La suppression du titre détenu dans un portefeuille est active");
      else
          Log.Checkpoint("La suppression du titre détenu dans un portefeuille est inactive");         
}

