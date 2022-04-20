//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
  Description : Jira PF-2532 L'application roule dans le vide lorsqu'on backdate.   
  
  
  Analyste d'assurance qualité : Alberto Quintero
  Analyste d'automatisation : Alhassane Diallo
  Version de scriptage:		2020.04-39
  Date de scriptage :       22-04-2021 
  Version du Scriptage :   2021-04-69
*/


function TCVE_4652_CALCUL_3079_RTM_643()
{
   try {
       
   
          
          //Lien de la storie dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-4652","Tâche TCVE-4652");
           //Lien du cas de test dans Jira
           Log.Link("https://jira.croesus.com/browse/RTM-643","Anomalie RTM-643");
           
          //Declaration des Variables
          var userNameKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
             
          var account800228RE        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ACCOUNT_800228RE", language+client);
          var account800245RE        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ACCOUNT_800245RE", language+client);
          var account300002OB        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ACCOUNT_300002OB", language+client);
          var account300010OB        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ACCOUNT_300010OB", language+client);
          var account800006OB        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ACCOUNT_800006OB", language+client);
          
          var positionBMO_PRJ        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "POSITION_BMO.PR.J", language+client);
          var valuePBR_BMOPRJ_CAD    = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ADJUSTED_COSTBASE_BMOPRJ_CAD", language+client);
          var valuePBR_BMOPRJ_USD    = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ADJUSTED_COSTBASE_BMOPRJ_USD", language+client);
          
          var positionGGF412         = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "POSITION_GGF412", language+client);
          var valuePBR_GGF412_CAD    = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ADJUSTED_COSTBASE_GGF412_CAD", language+client);
          var valuePBR_GGF412_USD    = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ADJUSTED_COSTBASE_GGF412_USD", language+client);
          var valuePBR_GGF412_USD_1  = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ADJUSTED_COSTBASE_GGF412_USD_1", language+client);
          var date_2009_07_06        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "DATE_2009_07_06", language+client);
          var date_2010_10_25        = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "DATE_2010_10_25", language+client);
          
          var devise_CAD             = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "DEVISE_CAD", language+client);
          var devise_USD             = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "DEVISE_USD", language+client); 
          var value                  = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "VALUE", language+client);
          
          
/*****************************************************************Étape 0*************************************************************************************/ 
          
          //connecter avec le user KEYNEJ 
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 0: Se connecter avec le user KEYNEJ");
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();

/*****************************************************************Étape 1*************************************************************************************/ 
           
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1 :Sélectionner des comptes CAD_USD et les mailler vers portefeuill (800228-RE, 800245-RE, 300002-OB, 300010-OB, 800006-OB) et les mailler vers portefeuilles")                    
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
          
          SearchAccount(account800228RE);  
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800228RE, 10).Click(-1, -1, skCtrl); 
          SearchAccount(account800245RE);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800245RE, 10).Click(-1, -1, skCtrl); 
          SearchAccount(account300002OB);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account300002OB, 10).Click(-1, -1, skCtrl); 
          SearchAccount(account300010OB);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account300010OB, 10).Click(-1, -1, skCtrl);    
          SearchAccount(account800006OB);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800006OB, 10).Click(-1, -1, skCtrl);
          
/*****************************************************************Étape 2*************************************************************************************/ 
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2 :Sélectionner des comptes CAD_USD et les mailler vers portefeuill (800228-RE, 800245-RE, 300002-OB, 300010-OB, 800006-OB) et les mailler vers portefeuilles")                    
         
                 
          //Mailler les vers le module portefeuille 
          Log.Message("Mailler les vers le module portefeuille")                    
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);

/*****************************************************************Étape 3*************************************************************************************/ 
          
          //Sélectionner le titre BK OF MTL-N/CUM-B-PFD S13 du compte 800228-RE, puis valider que le  PBR = 25,000
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Sélectionner le titre BK OF MTL-N/CUM-B-PFD S13 du compte 800228-RE, puis valider que le  PBR = 25,000");           
          var grid  = Get_Portfolio_PositionsGrid()
          var count = grid.Items.Count
          
          for (i=0; i<count-1; i++){ 
                      if (grid.Items.Item(i).DataItem.AccountNumber == account800228RE && grid.Items.Item(i).DataItem.Symbol== positionBMO_PRJ)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_BMOPRJ_CAD)
                      }                          
         } 
 
/*****************************************************************Étape 4*************************************************************************************/ 
          
          //Changer la devise: USD et  pour le même titre du compte 800228-RE  valider que le  PB = 21,277 
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Changer la devise: USD et  pour le même titre du compte 800228-RE  valider que le  PB = 21,277");        
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          while(!Get_SubMenus().Exists){
             Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          }
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency_USD().Click();
          Get_PortfolioGrid_BarToolBarTray_dtpDate().Click();
          Get_PortfolioGrid_BarToolBarTray_dtpDate().keys("^a");
          Get_PortfolioGrid_BarToolBarTray_dtpDate().set_StringValue(date_2009_07_06);
          Get_Portfolio_AssetClassesGrid().WaitProperty("IsEnabled", true, 15000);
          
          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account800228RE && grid.Items.Item(i).DataItem.Symbol== positionBMO_PRJ)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_BMOPRJ_USD)
                      }                          
         } 

/*****************************************************************Étape 6*************************************************************************************/ 
          
          //Sans sortir du module portefeuille sélectionner le titre BMOG MCH MON AMER /N du compte 300010-OB  avec la devise USD, valider que le  PB = 10,099 
          Log.PopLogFolder();
          logEtape6 = Log.AppendFolder("Étape 6: Sans sortir du module portefeuille sélectionner le titre BMOG MCH MON AMER /N du compte 300010-OB  avec la devise USD, valider que le  PB = 10,099");        
        	
          var grid  = Get_Portfolio_PositionsGrid()
          var count = grid.Items.Count
          
          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB && grid.Items.Item(i).DataItem.Symbol== positionGGF412)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_GGF412_USD)
                      }                          
         } 
         
/*****************************************************************Étape 5*************************************************************************************/ 
          
          //Changer la devise: CAD et  pour le même titre du compte 300010-OB  valider que le  PB = 12,499 
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Changer la devise: USD et  pour le même titre du compte 800228-RE  valider que le  PB = 12,499");        
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          
          var grid  = Get_Portfolio_PositionsGrid()
          var count = grid.Items.Count
          while(!Get_SubMenus().Exists){
             Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          }
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency_CAD().Click();
          
          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB && grid.Items.Item(i).DataItem.Symbol== positionGGF412)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_GGF412_CAD)
                      }                          
          } 
	  
/************************************************************Étape 7*************************************************************************************/ 
          
          //Sans sortir du module portefeuille et avec la même sélection, cliquer sur Par classe d'actifs 
          Log.PopLogFolder();
          logEtape7 = Log.AppendFolder("Étape 7: Sans sortir du module portefeuille et avec la même sélection, cliquer sur Par classe d'actifs");        
          var grid  = Get_Portfolio_PositionsGrid()
          var count = grid.Items.Count
          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB && grid.Items.Item(i).DataItem.Symbol== positionGGF412)
                      { 
                        
                      } 
                      i=i+1;
                        break;                         
          } 

          
          Aliases.CroesusApp.winMain.PortfolioPlugin.WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Click();
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();   

          
/************************************************************Étape 8*************************************************************************************/ 
          // Éclater Encaisse/quasi-espèces et sélectionner le titre BMOG MCH MON AMER /N du compte 300010-OB, valider que le  PBR = 12,499 
          Log.PopLogFolder();
          logEtape8 = Log.AppendFolder("Étape 8: Éclater Encaisse/quasi-espèces et sélectionner le titre BMOG MCH MON AMER /N du compte 300010-OB, valider que le  PBR = 12,499 ");        
         
          Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",1).set_IsExpanded(true);
          var grid  = Aliases.CroesusApp.winMain.PortfolioPlugin.WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("_assetMixgrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1)
          var count = grid.Items.Count
          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB && grid.Items.Item(i).DataItem.Symbol== positionGGF412)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_GGF412_CAD)
                      }                          
          } 
/********************************************************************Étape 9*************************************************************************************/ 
          // Changer la devise: USD et vérifier la colonne PBR pour le même titre du compte 300010-OB / PBR: 10,099
          Log.PopLogFolder();
          logEtape9 = Log.AppendFolder("Étape 9 : Changer la devise: USD et vérifier la colonne PBR pour le même titre du compte 300010-OB / PBR: 10,099"); 
                 
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          while(!Get_SubMenus().Exists){
             Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
          }
          Get_PortfolioGrid_BarToolBarTray_CmbCurrency_USD().Click(); 
          Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",1).set_IsExpanded(true);
          var grid  = Aliases.CroesusApp.winMain.PortfolioPlugin.WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("_assetMixgrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1)
          var count = grid.Items.Count

          for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB && grid.Items.Item(i).DataItem.Symbol== positionGGF412)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AdjustedCostBaseStr",cmpEqual,valuePBR_GGF412_USD_1)
                      }                          
          } 
    }
    catch(e) 
    {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
                          
    }
    finally 
    {   
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
  		//Fermer le processus Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}


