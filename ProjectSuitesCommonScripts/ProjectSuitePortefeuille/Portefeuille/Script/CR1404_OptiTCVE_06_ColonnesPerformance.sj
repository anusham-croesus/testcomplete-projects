//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
  Description : Valider l'affichage des colonnes dans la fenêtre Performance du Portefeuille
  
  Regrouper les cas suivants:
  CR1404_06_01_ColonnesPerf_Cumul
  CR1404_06_02_ColonnesPerf_CumulClassDActifs
  CR1404_06_03_ColonnesPerf_CumulClassDActifs_SousGroupe
  CR1404_06_04_ColonnesPerf_Fixe
  CR1404_06_05_ColonnesPerf_FixeClassDActifs
  CR1404_06_06_ColonnesPerf_FixeClassDActifs_SousGroupe
    
  Analyste d'assurance qualité : Karima Mo
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-21-2020-11-63
*/


 function CR1404_OptiTCVE_06_ColonnesPerformance()
 {  
    try{
      //Afficher le lien de cas de test global
      Log.Link("https://docs.google.com/spreadsheets/d/1pC_gLl03pEinVyZ6xDSWXgVv7sKue3S4WkyaK69d2Y4/edit#gid=98060071", "Fichier Excel des cas de test de CR1404 sur Google Drive");  
            
      var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");            
      var ROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
      var pswROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");         
      
      Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","YES",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_TIME_MONEY_WEIGHTED","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_REPORT","1",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_DISPLAY","YES",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS","YES",vServerPortefeuille);
      Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS_IN_REPORT","YES",vServerPortefeuille);
      RestartServices(vServerPortefeuille);      
      
      var columnID; if(language == "french") columnID = 1; else columnID = 2; 
       
      Log.Message("se connercter avec ROOSEF");
      Login(vServerPortefeuille, ROOSEF, pswROOSEF, language);
          
      //********************************** Étape 1 : Vérifie les colonnes dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //            le bouton performance activé, période cumulative, frais net et répartition d'actifs de base. *******************************************//
      Log.AppendFolder("Étape 1: CR1404_06_01 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider l'affichage des colonnes dans la fenêtre Performance du Portefeuille pour la performance par position et la période Cumulative.");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("*********** Choisir le module comptes et mailler vers portefeuille."); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
      
      //Sélectionner un compte non fictif //EM: Modifié Depuis CO-90-07-22
      var max=0;
      var res =aqString.Find(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).dataContext.dataItem.AccountNumber,"~F");
      while(max < 50 && res != -1){ 
          max++;
          res =aqString.Find(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", max+1).dataContext.dataItem.AccountNumber,"~F"); 
          Get_RelationshipsClientsAccountsGrid().Keys("[Down]");        
      }
      
      Drag(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", max+1), Get_ModulesBar_BtnPortfolio());           
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton performance.");
      Get_PortfolioBar_BtnPerformance().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      
      Log.Message("Valider l'affichage des colonnes dans la fenêtre Performance - période cumulative, frais net et répartition d'actifs de base.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != false) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Cumulative")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Cumulative().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Net")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Net().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
    
      var columnList = Get_Portfolio_PositionsGrid_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      var values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 1, columnID).split(";");    
      Check_PerformanceColumns(columnList,values);
      
      Log.PopLogFolder();
      
      //********************************** Étape 2 : Vérifie les colonnes dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //                  le bouton performance activé, par classes d'actif, période cumulative, frais net et répartition d'actifs de base. *************************************************//
      Log.AppendFolder("Étape 2: CR1404_06_02 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider l'affichage des colonnes dans la fenêtre Performance du Portefeuille pour la performance par classe d'actifs et  par position et la période Cumulative");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Valider l'affichage des colonnes dans la fenêtre Performance - par classes d'actif, période cumulative, frais net et répartition d'actifs de base.");      
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Cumulative")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Cumulative().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Net")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Net().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
      
      columnList = Get_Portfolio_AssetClassesGrid_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 2, columnID).split(";");
      Check_PerformanceColumns(columnList,values);
      
      Log.PopLogFolder();
      
      //********************************** Étape 3 : Vérifie les colonnes d'un groupe de positions dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //            le bouton performance activé, par classes d'actif, période cumulative, frais net et répartition d'actifs de base. *************************************************//
      Log.AppendFolder("Étape 3: CR1404_06_03 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider les colonnes d'un groupe de positions dans le module Portefeuille par classes d'actif, période cumulative, frais net et répartition d'actifs de base.");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Valider l'affichage des colonnes affichées (vue détaillée en cliquant sur le +) - pour la performance par classe d'actifs, répartition d'actifs de base et la période Cumulative.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Cumulative")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Cumulative().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Net")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Net().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
    
      Get_Portfolio_AssetClassesGrid().Click(5, 32);
    
      columnList = Get_Portfolio_AssetClassesGrid_AssetGroup_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 1, columnID).split(";");
      Check_PerformanceColumns(columnList,values);  
      
      Log.PopLogFolder();
      
      //********************************** Étape 4 : Vérifie les colonnes dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //            le bouton performance activé, période fixe, frais brut et répartition d'actifs de base. *************************************************//
      Log.AppendFolder("Étape 6: CR1404_06_04 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider l'affichage des colonnes dans la fenêtre Performance du Portefeuille pour la performance par position et la période Fixe");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Valider l'affichage des colonnes dans la fenêtre Performance - pour la performance par position, période fixe, frais brut et répartition d'actifs de base.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != false) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixe" && Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixed")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Fixed().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Brut" && Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Gross")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Gross().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
    
      columnList = Get_Portfolio_PositionsGrid_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 3, columnID).split(";");
      Check_PerformanceColumns(columnList,values);  
      
      Log.PopLogFolder();
      
      //********************************** Étape 5 : Vérifie les colonnes dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //            le bouton performance activé, par classes d'actif, période fixe, frais brut et répartition d'actifs de base. *************************************************//
      Log.AppendFolder("Étape 5: CR1404_06_05 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider l'affichage des colonnes dans la fenêtre Performance du Portefeuille pour la performance par classe d'actifs et par position et la période Fixe");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Valider l'affichage des colonnes dans la fenêtre Performance - pour la performance par classes d'actif, période fixe, frais brut et répartition d'actifs de base.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixe" && Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixed")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Fixed().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Brut" && Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Gross")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Gross().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
    
      columnList = Get_Portfolio_AssetClassesGrid_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      var values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 4, columnID).split(";");
      Check_PerformanceColumns(columnList,values);  
      
      Log.PopLogFolder();
      
      //**********************************  Vérifie les colonnes d'un groupe de positions dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
      //            le bouton performance activé, par classes d'actif, période fixe, frais brut et répartition d'actifs de base. *************************************************//
      Log.AppendFolder("Étape 6: CR1404_06_06 - PREF_POSITION_LEVEL_PERFORMANCE = 1: Valider les colonnes d'un groupe de positions dans le module Portefeuille pour la performance par classes d'actif et la période Fixe");        
      //**********************************************************************************************************************************************************************/
      
      Log.Message("Valider l'affichage des colonnes affichées (vue détaillée en cliquant sur le +) - pour la performance par classes d'actif, période fixe, frais brut et répartition d'actifs de base.");
      if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixe" && Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixed")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Fixed().Click();
      }
      if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Brut" && Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Gross")
      {
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
        Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Gross().Click();
      }
      if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
      {
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
      }
    
      Get_Portfolio_AssetClassesGrid().Click(5, 32);
    
      columnList = Get_Portfolio_AssetClassesGrid_AssetGroup_ColumnList();
      for(n = 0; n < columnList.length; n++)
        if(aqString.Compare(columnList[n].Content, "", true) == 0)
          columnList.shift();
    
      values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 3, columnID).split(";");
      Check_PerformanceColumns(columnList,values);         
      
      Log.PopLogFolder();
      
    }
    catch(e){
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
 
function Check_PerformanceColumns(columnList, values)
{   
  if (client == "CIBC")
    for(var n = 0; n < values.length; n++)
      aqObject.CheckProperty(columnList[n+1], "Content", cmpEqual, values[n]);
  else
    for(var n = 0; n < columnList.length; n++)          
      aqObject.CheckProperty(columnList[n], "Content", cmpEqual, values[n]);
}