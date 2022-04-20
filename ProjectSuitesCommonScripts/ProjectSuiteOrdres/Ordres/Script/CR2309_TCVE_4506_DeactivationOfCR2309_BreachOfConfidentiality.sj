//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA

/*  https://jira.croesus.com/browse/TCVE-4506
    https://jira.croesus.com/browse/ORC-1944

    Analyste d'assurance qualité: Taous.A
    Analyste d'automatisation: Abdel.M
    Date: 14/05/2021
    Version: 90.24.2021.04-54 */ 

 function CR2309_TCVE_4506_DeactivationOfCR2309_BreachOfConfidentiality()
 {             
    try{  
      
          //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-4506","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/ORC-1944","Lien du cas de test dans Jira");
          
//         Variables
           var userNameUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
           var passwordUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw"); 
           var userNameCOPERN  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
           var passwordCOPERN  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"); 
           var userNameLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
           var passwordLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw"); 
           
           var account300014NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "account300014NA", language+client);
           var account800001OB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "account800001OB", language+client);
           var account800002NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "account800002NA", language+client);
           var quantityTCVE4506 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityTCVE4506", language+client);
           var symbolTCVE4506 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "symbolTCVE4506", language+client);
           var cmbTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
           var quantityAfterPref = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityAfterPref", language+client);
           
/************************************Étape 1************************************************************************/     
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Rouler le Script SQL");
          var scriptToExecute = "";
              scriptToExecute += "exec spB_DEF \r\n";
              scriptToExecute += "'P', 'PREF_GDO_SERIALIZER_MODE', 'General/Général', 'U', 'U','', '', 'N', 1, 1, 1, 2, '1', 1, 0 \r\n";
              
          Log.Message("Execute SQL to desactivate CR2309");
          Execute_SQLQuery(scriptToExecute, vServerOrders);
          RestartServices(vServerOrders);
              
/************************************Étape 2************************************************************************/     
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Se connecter avec UNI00  ,Créer un ordres multiples, en bloc et d'échanges");
//          Se connecter à croesus avec UNI00 
          Log.Message("Se connecter à croesus avec UNI00 ");
          Login(vServerOrders, userNameUNI00, passwordUNI00, language);

          //Acceder au Module Comptes
          Log.Message("Acceder au Module Comptes");
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 10000);
          
          //Selectionner 3 comptes 300014-NA, 800001-OB et 800002-NA
          Log.Message("Selectionner 3 comptes 300014-NA, 800001-OB et 800002-NA");
          SelectAccounts([account300014NA, account800001OB, account800002NA]);
          
          //Créer un ordres multiples, en bloc et d'échanges
          Log.Message("Créer un ordres multiples, en bloc et d'échanges");
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          //Ajouter une transaction vente
          AddASellBySymbol(quantityTCVE4506, cmbTransaction, symbolTCVE4506);
          
          Log.Message("Cliquer sur le bouton Générer");
          Get_WinSwitchBlock_BtnPreview().Click();
         
          Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
          Get_WinSwitchBlock_BtnGenerate().Click(); 
          if (Get_DlgConfirmation().Exists)
              Get_DlgConfirmation_BtnYes().Click();           
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");

          Log.Message("Se déconnecter de croesus");
          Close_Croesus_X(); //Fermer Croesus
          
/************************************Étape 3************************************************************************/     
           
           //Se connecter avec LINCOA, Aller dans l'accumulateur  
    
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Se connecter avec LINCOA, Aller dans l'accumulateur");
          
          Log.Message("Se connecter à croesus avec LINCOA");
          Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
          
          // Aller dans le module Ordres
          Log.Message("Aller dans le module Ordres");
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
          
          //Valider que l'ordre n'est pas visible car on cherche le code de CP de l'ordre est pas des comptes sous jacents.
          Log.Message("Valider que l'ordre n'est pas visible car on cherche le code de CP de l'ordre est pas des comptes sous jacents");
          var count = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
          var found = false;
          for (i=0; i<count; i++){
              if (Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbolTCVE4506 && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantityAfterPref){
                  Log.Error("L'ordre ne doit pas être affiché");
                  found = true;
              }
          }
          if (!found) 
              Log.Checkpoint("L'ordre n'est pas affiché comme attendu");
          
          Log.Message("Se déconnecter de croesus");
          Close_Croesus_X(); //Fermer Croesus
         
          
          
/************************************Étape 4************************************************************************/     
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Se connecter avec COPERN, Aller dans l'accumulateur");
          
          //Se connecter avec COPERN  
          Log.Message("Se connecter à croesus avec COPERN");
          Login(vServerOrders, userNameCOPERN, passwordCOPERN, language);
          
          // Aller dans le module Ordres
          Log.Message("Aller dans le module Ordres");
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
          
          //Valider que  l'ordre est visible et le compte sous-jacent: 300014-NA
          Log.Message("Valider que  l'ordre est visible et le compte sous-jacent: 300014-NA");
          var count = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
          var found = false;
          for (i=0; i<count; i++){
              if (Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbolTCVE4506 && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantityAfterPref){
                  Log.Checkpoint("L'ordre est affiché comme attendu");
                  found = true;
              }
          }
          if (!found) 
          Log.Error("L'ordre doit être affiché");              
          
          Log.Message("Se déconnecter de croesus");
          Close_Croesus_X(); //Fermer Croesus
          
    }
    catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          
    }
    finally { 
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: C L E A N U P");
           
          Login(vServerOrders, userNameUNI00, passwordUNI00, language);
          Get_ModulesBar_BtnOrders().Click();
          
          // Supprimer l'ordre créé dans l'accumulateur
          Log.Message("Supprimer l'ordre créé dans l'accumulateur");
          if (language == "french") var date = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d");
          else var date = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y");
          Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamDateTimeEditor",date],10).Click();
          Get_OrderAccumulator_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().Click();
          
          Close_Croesus_X();
          Terminate_CroesusProcess(); //Fermer Croesus
          
          //Exécuter le script SQL pour retourner à l'état initial
          var scriptActivateToExecute = "DELETE FROM B_DEF WHERE TABLESRC='P' AND CLE='PREF_GDO_SERIALIZER_MODE ' AND CLEGROUPE='General/Général'";   
          Log.Message("Execute SQL to activate CR2309");
          Execute_SQLQuery(scriptActivateToExecute, vServerOrders);
          RestartServices(vServerOrders);
    }
 }
 
 