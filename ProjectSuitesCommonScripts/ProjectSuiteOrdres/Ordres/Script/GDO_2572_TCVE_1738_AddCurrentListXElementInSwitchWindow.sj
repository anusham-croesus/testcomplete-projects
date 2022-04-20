//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-1738
    Description          :  Décompte fenêtre Switch - Module Comptes, Portefeuille
    Préconditions        : 
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.17.2020.7-21
    date                 :  24-07-2020 
  
    
*/

function GDO_2572_TCVE_1738_AddCurrentListXElementInSwitchWindow()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1738","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/GDO-2572","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/GDO-2842","Lien de cas de test dans Jira");
           Log.Link("https://jira.croesus.com/browse/GDO-2844","Lien de cas de test dans Jira");
           
    
           //Declaration des Variables
           
           var nameCriteria2572 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameCriteria2572",language+client);
           var sourceType       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "sourceTypeStep4", language+client);  
           var element          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "element",language+client);
           var account800223RE  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800223RE",language+client);
           var account800227OB  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800227OB",language+client);
           var account800227JW  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800227JW",language+client);
           var selectionNumber  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "selectionNumber",language+client);
           
           
/************************************Étape 1************************************************************************/     
           //Se connecter à croesus avec LINCOA
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec COPERN");
          
          Log.Message("Se connecter à croesus avec COPERN")
          Login(vServerOrders, userName, psw, language);
          Get_MainWindow().Maximize();
          
          Log.PopLogFolder();      
          Log.AppendFolder("----------------------- PREMIERE PARTIE MODULE COMPTES ------------------------------------------");
          
//            Log.Message("-------------------------------------------------------------------------------------------------");
//            Log.Message("----------------------- PREMIERE PARTIE MODULE COMPTES ------------------------------------------");
//            Log.Message("-------------------------------------------------------------------------------------------------");
      
//************************************Étape 2************************************************************************/     
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Créer et appliquer un critère de recherche contenant plusieurs comptes." );

           //Accéder au module compte
           Log.Message("Acceder au module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           
           //Créer et appliquer un critère de recherche "Liste de comptes ayant Devise égal à USD."
           Log.Message("Créer et appliquer un critère de recherche Liste de comptes ayant Devise égal à USD.'");
           Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
           Get_WinAddSearchCriterion_TxtName().Clear();
           Get_WinAddSearchCriterion_TxtName().Keys(nameCriteria2572);
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUSD().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
           Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
//           var countSelection = Get_StatusBarContentSelection().Text;
//           Log.Message("Le nombre de comptes qui ont des crochés est: "+countSelection);
           
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
           Get_RelationshipsClientsAccountsGrid().waitproperty("IsLoaded", true);
           
/************************************Étape 3, 4 ************************************************************************/     
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3, 4: Désactiver, sans supprimer (cliquer sur le nom du critère dans l'entête) le critère.");
           Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
           
           //Selectionner 5 comptes avec clic+shift
           selectFiveAccounts(account800223RE, account800227OB);
           
           var countSelection = Get_StatusBarContentSelection().Text;
           Log.Message("Le nombre de comptes qui ont des crochés est: "+countSelection);
           
           // Cliquer le boutonOrdres multiples, en bloc et d'échange
           Log.Message("Cliquer le boutonOrdres multiples, en bloc et d'échange");
           Get_Toolbar_BtnSwitchBlock().Click();
           WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
           Log.Message("vérifier le nombre des élements");
           aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, selectionNumber+element);
         
           Log.Message("Sélectionner dans sources 'Liste courante (Crochets)'")
           Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceType],10).Click();  
           Delay(500);
          
          Log.Message("vérifier le nombre des élements");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, countSelection+element);
          
          //Clic le bouton Annuler
          Get_WinSwitchBlock_BtnCancel().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          
          
//-------------------------- DEUXIÈME PARTIE MODULE PORTEFEUILLE --------------------------------------------------------
          Log.PopLogFolder();      
          Log.AppendFolder("----------------------- DEUXIÈME PARTIE MODULE PORTEFEUILLE ------------------------------------------");
          
//************************************Étape 5************************************************************************/     
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Sélectionner 5 comptes et mailler vers portefeuille.");
          
          //Selectionner 5 comptes avec clic+shift
          selectFiveAccounts(account800223RE, account800227OB); 
          
          //Mailler vers portefeuille  
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           
          //Selectionner 3 positions dans 3 comptes différents avec clic+ctrl    
          selectPositionsInThreeDifferentAccounts(account800223RE,account800227OB,account800227JW);
          
          // Cliquer le boutonOrdres multiples, en bloc et d'échange
          Log.Message("Cliquer le boutonOrdres multiples, en bloc et d'échange");
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
          if (Get_DlgConfirmation().Exists)
              Get_DlgConfirmation_BtnYes().Click();
          
          //Impossible de changer la source; le champ est grisé.
          Log.Message("Valider que Impossible de changer la source; le champ est grisé.");
          Get_WinSwitchBlock_GrpParameters_CmbSources()
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_CmbSources(), "IsEnabled", cmpEqual, false);
          
          //Clic le bouton Annuler
          Get_WinSwitchBlock_BtnCancel().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
          

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
      
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: ------------- C L E A N U P -----------------------------");
//      supprimer le critere de recherche créé
        Log.Message("------------- C L E A N U P -----------------------------");
        Log.Message("Supprimer le critère de recherche créé"); 
        // Accéder au module compte
        Log.Message("Acceder au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
        Delete_FilterCriterion(nameCriteria2572, vServerOrders); 
        Get_WinSearchCriteriaManager_BtnClose().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }

  
 function selectFiveAccounts(accountStart, accountEnd){
          //Selectionner 5 comptes avec clic+shift
           Log.Message("Selectionner 5 comptes avec clic+shift");
           SearchAccount(accountStart);
           Get_RelationshipsClientsAccountsGrid().Find("Value",accountStart,10).Click();
           
           Sys.Desktop.KeyDown(0x10);
           Get_RelationshipsClientsAccountsGrid().Find("Value",accountEnd,10).Click();
           Sys.Desktop.KeyUp(0x10);
 }
 
 function selectPositionsInThreeDifferentAccounts(account1, account2, account3){
           Log.Message("Selectionner 3 positions dans 3 comptes différents avec clic+ctrl");
           Get_Portfolio_PositionsGrid().Find("Value",account1,10).Click();
           Sys.Desktop.KeyDown(0x11);
           Get_Portfolio_PositionsGrid().Find("Value",account2,10).Click();
           Get_Portfolio_PositionsGrid().Find("Value",account3,10).Click();
           Sys.Desktop.KeyUp(0x11);
 }
 
 