//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* 
Testlink                 : Croes-6602:Appuyer sur la bare d'espace pour créer une lite manuelle
Résumé                   : Correspond au jira CROES-9379 Crash suite a avoir appuyer sur la barre d'espace pour créer une liste manuelle.
Précondition             : CE JIRA DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR.
Analyste d'automatisation: Abdel Matmat 
*/

function Performance_CROES_6602() {

          try {
                    var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
                    var criterionName = "CROES_6602";
                    
                    // Se connecter à croesus
                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    // Attend le module Comptes présent et actif
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);

                    //Créer un critère de recherche
                    Create_Criteria(criterionName);
                    
                    //Aller dans le module modèle
                    Get_ModulesBar_BtnModels().Click(); 
                    //WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
                    WaitObject(Get_ModelsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
                    
                    //Sélectionner le 1er modèle
                    Get_ModelsGrid().Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                    WaitObject(Get_Models_Details(),["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"]);
                    
                    //Sélectionner tous les comptes 
                    Get_Models_Details().Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Keys("[Hold]^a[Release]");
                    
                    //Mailler tous les comptes sélectionnés vers le module comptes
                    Get_MenuBar_Modules().Click();
                    Get_MenuBar_Modules_Accounts().Click();
                    Get_MenuBar_Modules_Accounts_DragSelection().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    
                    //Sélectionner tous les comptes et appuyer sur la bare d'espace
                    Get_RelationshipsClientsAccountsGrid().Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Keys("[Hold]^a[Release]");
                    Get_RelationshipsClientsAccountsGrid().Keys(" ");
                    
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                    
                   
          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {
                    // Supprimer le critère de recherche créé
                    DeleteCriterion(criterionName);
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess(); 
                    Terminate_IEProcess();
          }

}

function Create_Criteria(criterion){
      //Afficher la fenêtre "Add Search Criterion"
      Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
      WaitObject(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
   
      //creation de critere 
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().Keys(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSleeves().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSave().Click();  
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
}

