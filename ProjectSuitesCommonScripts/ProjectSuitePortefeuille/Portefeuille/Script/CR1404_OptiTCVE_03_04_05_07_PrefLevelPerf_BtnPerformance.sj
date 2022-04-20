//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
  Description : Valider l'affichage du bouton Performance / par classe d'actifs et de la fenêtre Performance avec Pref_Position_Level_Performance = 1,2,3
  
  Regrouper les cas suivants:
  CR1404_03_01_PrefLevel3Perf_BoutonPerformance
  CR1404_04_01_PrefLevel2Perf_BoutonPerformance
  CR1404_05_01_PrefLevel1Perf_BoutonPerformance_CompteReel
  CR1404_05_02_PrefLevel1Perf_BoutonPerformance_Client
  CR1404_05_03_PrefLevel1Perf_BoutonPerformance_Relation
  CR1404_05_04_PrefLevel1Perf_BoutonPerformance_Modele
  CR1404_05_05_PrefLevel1Perf_BoutonPerformance_CompteFictif
  CR1404_05_06_PrefLevel1Perf_BoutonPerformance_CompteExterne
  CR1404_07_01_Perf500Positions

    
  Analyste d'assurance qualité : Karima Mo
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-21-2020-11-63
*/


 function CR1404_OptiTCVE_03_04_05_07_PrefLevelPerf_BtnPerformance()
 {  
    try{
      //Afficher le lien de cas de test global
      Log.Link("https://docs.google.com/spreadsheets/d/1pC_gLl03pEinVyZ6xDSWXgVv7sKue3S4WkyaK69d2Y4/edit#gid=98060071", "Fichier Excel des cas de tests de CR1404 sur Google Drive");  
      
      
      var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");            
      var ROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
      var pswROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");         
      
      Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","3",vServerPortefeuille);
      RestartServices(vServerPortefeuille);
      
      //Les variables
      var relationshipNum = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1404_RegressionUI", "RelationshipNumA0006", language+client);
         
      Log.Message("se connercter avec ROOSEF");
      Login(vServerPortefeuille, ROOSEF, pswROOSEF, language);
          
      //********************************** Étape 1 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 3,
      //                  le bouton performance n'est pas visible dans Portefeuille. **********************************//
      Log.AppendFolder("Étape 1: CR1404_03_01 - PREF_POSITION_LEVEL_PERFORMANCE = 3: Valider que le bouton performance n'est pas visible dans Portefeuille");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("*********** Choisir le module comptes et mailler vers portefeuille."); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());           
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Valider que le bouton performance n'est pas visible dans Portefeuille.");
      if(!Get_PortfolioBar_BtnPerformance().Visible)
      Log.Checkpoint("Bouton \"Perf. par classe d'actifs\" n'est pas visible après maillage compte.");
      else
      Log.Error("Bouton \"Perf. par classe d'actifs\" ne devrait pas être visible après maillage compte."); 
      
      Log.Message("*********** Choisir le module client et mailler vers portefeuille.");
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      
      Log.Message("Valider que le bouton performance n'est pas visible dans Portefeuille.");
      if(!Get_PortfolioBar_BtnPerformance().Visible)
        Log.Checkpoint("Bouton \"Perf. par classe d'actifs\" n'est pas visible après maillage client.");
      else
        Log.Error("Bouton \"Perf. par classe d'actifs\" ne devrait pas être visible après maillage client.");
        
      Log.Message("*********** Choisir le module relation et mailler vers portefeuille.");    
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      if(client == "CIBC"){
        Get_RelationshipsClientsAccountsGrid().keys("0");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().keys(relationshipNum);
        Get_WinQuickSearch_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipNum,10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipNum,10), Get_ModulesBar_BtnPortfolio());      
      }
      else      
        Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton performance n'est pas visible dans Portefeuille.");
      if(!Get_PortfolioBar_BtnPerformance().Visible)
        Log.Checkpoint("Bouton \"Perf. par classe d'actifs\" n'est pas visible après maillage relation.");
      else
        Log.Error("Bouton \"Perf. par classe d'actifs\" ne devrait pas être visible après maillage relation.");
      
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
      
      Log.PopLogFolder();
      
      //********************************** Étape 2 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 2,
      //                  le bouton performance/par classe d'actifs est visible dans Portefeuille. *************************************************//
      Log.AppendFolder("Étape 2: CR1404_04_01 - PREF_POSITION_LEVEL_PERFORMANCE = 2: Valider que le bouton performance/par classe d'actifs est visible dans Portefeuille");        
      //**********************************************************************************************************************************************************************/
      
      Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","2",vServerPortefeuille);
      RestartServices(vServerPortefeuille);
      
      Log.Message("se connercter avec ROOSEF");
      Login(vServerPortefeuille, ROOSEF, pswROOSEF, language);
      
      Log.Message("*********** Choisir le module comptes et mailler vers portefeuille."); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      
      Log.Message("Valider que lorsqu'on click sur bouton performance Croesus ne crash pas (Bug PF-2600.");
      if (Get_DlgError().Exists){
          Log.Error("Croesus crashed upon click on Performance Button.");
          Log.Error("Bug PF-2600");
          Get_DlgError_BtnOK().Click();
      }
      else
          Log.Checkpoint("No crash detected upon click on Performance Button.");
          
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est inactif et activé dans Portefeuille.");    
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible && !Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled && Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est inactif et activé après maillage compte.");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être inactif et activé après maillage compte.");
        
      //Valider que l'Interface performance est affichée
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");
      
      Log.Message("*********** Choisir le module client et mailler vers portefeuille.");
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();    
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est inactif et activé dans Portefeuille.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible && !Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled && Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est inactif et activé après maillage client");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être inactif et activé après maillage client");
        
      //Valider que l'Interface performance est affichée
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");
        
      Log.Message("*********** Choisir le module relation et mailler vers portefeuille.");    
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      if(client == "CIBC"){
        Get_RelationshipsClientsAccountsGrid().keys("0");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().keys(relationshipNum);
        Get_WinQuickSearch_BtnOK().Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipNum,10), Get_ModulesBar_BtnPortfolio());      
      }
      else      
        Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est inactif et activé dans Portefeuille.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible && !Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled && Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est inactif et activé après maillage relation");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être inactif et activé après maillage relation");        
      
      //Valider que l'Interface performance est affichée  
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");        
        
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
      
      Log.PopLogFolder();
      
      //********************************** Étape 3 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance est visible dans Portefeuille après avoir mailler un compte réel. *************************************************//
      Log.AppendFolder("Étape 3: CR1404_05_01 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance est visible dans Portefeuille après avoir mailler un compte réel.");        
      //**********************************************************************************************************************************************************************/
      
      Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_POSITION_PERF_MAX_POSITIONS","500",vServerPortefeuille); //À utiliser à l'étape 8
      RestartServices(vServerPortefeuille);
      
      Log.Message("se connercter avec ROOSEF");
      Login(vServerPortefeuille, ROOSEF, pswROOSEF, language);
      
      Log.Message("Choisir le module comptes et mailler vers portefeuille."); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();      
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());                 
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est actif dans Portefeuille.");
      
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible &&
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est actif après maillage compte réel.");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être actif après maillage compte réel..");
      
      //Valider que l'Interface performance est affichée
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");      
      
      Log.PopLogFolder();
      
      //********************************** Étape 4 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance est visible dans Portefeuille après avoir mailler une relation. *************************************************//
      Log.AppendFolder("Étape 4: CR1404_05_03 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance est visible dans Portefeuille après avoir mailler une relation.");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Choisir le module relation et mailler vers portefeuille.");    
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      if(client == "CIBC"){
        Get_RelationshipsClientsAccountsGrid().keys("0");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().keys(relationshipNum);
        Get_WinQuickSearch_BtnOK().Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipNum,10), Get_ModulesBar_BtnPortfolio());
      }
      else      
        Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est actif dans Portefeuille.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible && Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est actif.");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être actif.");
      
      //Valider que l'Interface performance est affichée  
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");         
      
      Log.PopLogFolder();
      
      //********************************** Étape 5 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance n'est pas visible dans Portefeuille après avoir mailler un modèle. *************************************************//
      Log.AppendFolder("Étape 5: CR1404_05_04 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance n'est pas visible dans Portefeuille après avoir mailler un modèle");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Choisir le module modèle et mailler vers portefeuille.");    
      Get_ModulesBar_BtnModels().Click();
      Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
      
      Drag(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");   
      
      Log.Message("Valider que le bouton \"par classe d'actifs\" est actif dans Portefeuille.");
      if(!Get_PortfolioBar_BtnPerformance().Visible)
        Log.Checkpoint("Bouton \"Perf. par classe d'actifs\" n'est pas visible.");
      else
        Log.Error("Bouton \"Perf. par classe d'actifs\" ne devrait pas être visible.");        
      
      Log.PopLogFolder();
      
      //********************************** Étape 6 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance est grisé dans Portefeuille après avoir mailler un compte fictif. *************************************************//
      Log.AppendFolder("Étape 6: CR1404_05_05 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance est grisé dans Portefeuille après avoir mailler un compte fictif");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Choisir le module compte et selectionner un compte fictif.");    
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
      
      Get_RelationshipsClientsAccountsGrid().keys("~~");
      Get_WinQuickSearch_TxtSearch().keys("F");
      Get_WinQuickSearch_BtnOK().Click();
      
      Log.Message("Mailler vers portefeuille.");     
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Portfolio().Click();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
      
      //Créer un compte fictif si n'existe pas un
      var compteFictifCree = false;
      if(!Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName().Text.contains("~F"))
      {
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        //creer un client fictif
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_CreateFictitiousClient().Click();
        var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().keys("Test A" + UniqueID);
        Get_WinDetailedInfo_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().keys("A");
        Get_WinQuickSearch_TxtSearch().keys(UniqueID);
        Get_WinQuickSearch_BtnOK().Click();
        //mailler vers comptes
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        if(Get_DlgWarning().Exists)
          Get_DlgWarning().Close();        
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        //Créer un compte fictif
        Get_Toolbar_BtnAdd().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        Delay(500);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();        
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      
        compteFictifCree = true;
      }  
          
      Log.Message("Valider que le bouton \"performance\" est grisé dans Portefeuille.");       
      if(Get_PortfolioBar_BtnPerformance().Visible && !Get_PortfolioBar_BtnPerformance().Enabled)
        Log.Checkpoint("Button performance est grisé.");
      else
        Log.Error("Button performance n'est pas grisé.");
    
      if(compteFictifCree)
      {
        Log.Message("Supprimer le client fictif créé.");
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        Get_RelationshipsClientsAccountsGrid().keys("A");
        Get_WinQuickSearch_TxtSearch().keys(UniqueID);
        Get_WinQuickSearch_BtnOK().Click();
        Get_Toolbar_BtnDelete().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
      }       
      
      Log.PopLogFolder();
      
      //********************************** Étape 7 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance/par classe d'actifs est visible dans Portefeuille après avoir mailler un compte externe. *************************************************//
      Log.AppendFolder("Étape 7: CR1404_05_06 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance est visible dans Portefeuille après avoir mailler un compte externe");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Choisir le module compte et selectionner un compte externe");    
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000); 
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
      
      Get_RelationshipsClientsAccountsGrid().keys("~~");
      Get_WinQuickSearch_TxtSearch().keys("E");
      Get_WinQuickSearch_BtnOK().Click();
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Portfolio().Click();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      //Créer un compte externe si n'existe pas un
      var compteExterneCree = false;
      if(!Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName().Text.contains("~E"))
      {
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        //creer un client externe
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_CreateExternalClient().Click();
        var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().keys("Test A" + UniqueID);
        Get_WinDetailedInfo_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().keys("A");
        Get_WinQuickSearch_TxtSearch().keys(UniqueID);
        Get_WinQuickSearch_BtnOK().Click();
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        if(Get_DlgWarning().Exists)
          Get_DlgWarning().Close();          
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        //Créer un compte externe
        Get_Toolbar_BtnAdd().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        Delay(500);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
      
        compteExterneCree = true;
      }
    
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est actif. dans Portefeuille.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible &&  Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est actif.");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être actif.");
        
      //Valider que l'Interface performance est affichée
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");
    
      if(compteExterneCree)
      {
        Log.Message("Supprimer le client externe créé.");
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        Get_RelationshipsClientsAccountsGrid().keys("A");
        Get_WinQuickSearch_TxtSearch().keys(UniqueID);
        Get_WinQuickSearch_BtnOK().Click();
        Get_Toolbar_BtnDelete().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
      }
      
      Log.PopLogFolder();
      
      //********************************** Étape 8 : Vérifie le message d'erreur quand on tente d'afficher la performance de plus de 500 positions dans le module portefeuille. *************************************************//
      Log.AppendFolder("Étape 8: CR1404_07_01 - Vérifie le message d'erreur quand on tente d'afficher la performance de plus de 500 positions dans le module portefeuille.");        
      //**********************************************************************************************************************************************************************/
      //Prefs déjà activés à l'étape 3
      
      var filtre ="~F";
      Log.Message("Choisir le module clients et mailler vers portefeuille."); 
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      
      Log.Message("*** Création d'un filtre temporaire - Afficher juste Clients Non Fictifs."); //depuis CO-90-07-22
      Log.Message("Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters et créer le filtre.");
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click(); 
      Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();   
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemNotContaining().Click();
      Get_WinCreateFilter_TxtValue().Click();
      Get_WinCreateFilter_TxtValue().SetText(filtre);
      Get_WinCreateFilter_BtnApply().Click();                
    
      Log.Message("Sélectionner plus 500 positions.");
      var nbPositions = 0;
      for (nbClients = 2; nbClients < 30 && nbPositions < 500; nbClients++)
      {
        Get_ModulesBar_BtnClients().Click();
        Get_RelationshipsClientsAccountsGrid().Keys("[Home]");
        for (n = 0; n < nbClients; n++)
          Get_RelationshipsClientsAccountsGrid().Keys("![Down]");
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_PortfolioBar_BtnAll().Click();
        Get_Toolbar_BtnSum().Click();
        nbPositions = Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions().Text;
        Get_WinPortfolioSum_BtnClose().Click();
      }
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      var columnID; 
      if(language == "french") columnID = 1; else columnID = 2;
      
      Log.Message("Valider le message d'erreur quand on tente d'afficher la performance de plus de 500 positions.");
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 5, columnID).replace("\\r", "\r").replace("\\n", "\n"));
      
      Log.Message("Cliquer sur non et valider que l'interface performance n'est pas affichée.");
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(2/3)),73);
    
      if(!Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance n'est pas affichée après avoir appuyé sur non.");
      else
        Log.Error("Interface performance est affichée après avoir appuyé sur non.");
      
      Log.Message("Recliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      
      Log.Message("Cliquer sur oui et valider que l'interface performance est affichée.");
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    
      Delay(5000);
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée après avoir appuyé sur oui.");
      else
        Log.Error("Interface performance n'est pas affichée après avoir appuyé sur oui.");      
      
      Log.Message("Supprimer le filtre temporaire.");
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
    
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
      Log.PopLogFolder(); 
       
      //********************************** Étape 9 : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance est visible dans Portefeuille après avoir mailler un client. *************************************************//
      Log.AppendFolder("Étape 9: CR1404_05_02 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider que le bouton performance est visible dans Portefeuille après avoir mailler un client.");        
      //**********************************************************************************************************************************************************************/
      
      Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","Yes",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_TIME_MONEY_WEIGHTED","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_REPORT","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_DISPLAY","Yes",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS","Yes",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS_IN_REPORT","Yes",vServerPortefeuille);
      RestartServices(vServerPortefeuille);
      
      Log.Message("se connercter avec ROOSEF");
      Login(vServerPortefeuille, ROOSEF, pswROOSEF, language);
      
      Log.Message("Choisir le module clients et mailler vers portefeuille."); 
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1), Get_ModulesBar_BtnPortfolio());      
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
    
      Log.Message("Valider que le bouton \"par classe d'actifs\" est actif dans Portefeuille.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible && Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled)
        Log.Checkpoint("Bouton \"par classe d'actifs\" est actif.");
      else
        Log.Error("Bouton \"par classe d'actifs\" devrait être actif.");
        
      //Valider que l'Interface performance est affichée
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
        Log.Checkpoint("Interface performance est affichée.");
      else
        Log.Error("Interface performance n'est pas affichée.");          
      
       Log.PopLogFolder(); 
    }
    catch(e) 
    {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally{
      
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
  	  
      //Reinitialiser BD
      Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
      RestartServices(vServerPortefeuille);
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)  
    
    }   
 }
 
