//USEUNIT CR2140_common_functions

/** 
    Ce script regroupe les scripts: CR2140_6027, CR2140_6031, CR2140_6032, CR2140_6033, CR2140_6034, CR2140_6035,
    
    Les Liens dans TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6027
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6031
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6032
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6033
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6034
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6035
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
    Regroupé par : A.A Version ref90-19-2020-09-6 
*/

function CR2140_CombinatedBlotterValidation() {
         
      try {            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
            var account1_6027        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6027", language+client);
            var account2_6027        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6027", language+client);
            var account3_6027        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account3_6027", language+client);
            var transactionType_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6027  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6027", language+client);
            var quantity_6027        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6027", language+client);
            var symbol_6027          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6027", language+client);
            var USDAccount_6027      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "USDAccount_6027", language+client);
                  
            var account_6031 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account_6031", language+client);
            var type_6031    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
            
            var type_6032    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
            
            var account1_6033 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6033 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6033", language+client);
            var type_6033     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
                       
            var account1_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6033", language+client);
            var symbol_6034   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6034", language+client);
            var type_6034     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
                        
            var account1_6035 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6035 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6035", language+client);
            var type_6035     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
    
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
//6027      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6027 ");
      
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000); 
            
            //Selectionner les comptes 800216-OB, 800230-FS, 800230-RE
            SelectThreeAccounts(account1_6027,account2_6027,account3_6027);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Mettre Transaction à Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6026],10).Click();
        
            //Ajouter : 400 $ par compte (devise du compte), symbole =MAN
            AddABuyBySymbol(quantity_6027,cmbTransaction_6027,symbol_6027)
            
            //Valider que l'ordre d'achat du titre MAN est ajouté
            CheckABuyInGrid(quantity_6027,symbol_6027)
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            SetAutoTimeOut();
            if(Get_WinSwitchBlock().Exists){
               Get_WinSwitchBlock_BtnGenerate().Click(); 
               WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            }
            RestoreAutoTimeOut();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
            //Vérifier dans l'accumulateur qu'une entrée est créée, No de compte = GP1859_USD
            CheckAccountInAccumulatorBySymbol(symbol_6027,USDAccount_6027);

            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(USDAccount_6027);            
//6031      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6031 ");
      
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner le compte 800228-RE
            Search_Account(account_6031);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account_6031,10).Click();
            
            //Créer un ordre d'achat
            Get_Toolbar_BtnCreateABuyOrder().Click();
            
            //Choisir Revenus Fixes
            Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Cliquer sur sauvegarder
            Get_WinOrderDetail_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier l'ordre dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account_6031);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6031);
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account_6031);
//6032      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6032");      
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Selectionner le compte 800228-RE
            Search_Account(account_6031);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account_6031,10).Click();
            
            //Créer un ordre de vente
            Get_Toolbar_BtnCreateASellOrder().Click();
            
            //Choisir Revenus Fixes
            Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Cliquer sur sauvegarder
            Get_WinOrderDetail_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier l'ordre dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account_6031);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6032);
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account_6031);

//6033      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6033");
                  
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Selectionner le compte 800300-NA
            Search_Account(account1_6033);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account1_6033,10).Click();
            
            //Créer un ordre d'achat
            Get_Toolbar_BtnCreateABuyOrder().Click();
            
            //Choisir Actions
            Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Cliquer sur sauvegarder
            Get_WinOrderDetail_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier l'ordre dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account1_6033);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6033);
            
            //Selectionner et modifier l'ordre créé dans l'accumulateur
            SelectAndEditOrderInAccumulatorByAccountNotPermit(account1_6033,account2_6033);
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account1_6033);

//6034 
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6034");
                                  
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Selectionner le compte 800300-NA
            Search_Account(account1_6034);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account1_6034,10).Click();
            
            //Mailler vers portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Rechercher le symbole R76899
            SearchAccountBySymbolInPortfolioGrid(symbol_6034);
            Get_Portfolio_PositionsGrid().Find("Value",symbol_6034,10).Click();
            
            //Créer un ordre de vente
            Get_Toolbar_BtnCreateASellOrder().Click();
            
            //Choisir Revenus Fixes
            Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Cliquer sur sauvegarder
            Get_WinOrderDetail_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier l'ordre dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account1_6034);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6034);
            
            //Selectionner et modifier l'ordre créé dans l'accumulateur
            SelectAndEditOrderInAccumulatorByAccountNotPermit(account1_6034,account2_6034);           

            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account1_6034);

//6035
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6035");
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Selectionner le compte 800300-NA
            Search_Account(account1_6035);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account1_6035,10).Click();
            
            //Créer un ordre d'achat
            Get_Toolbar_BtnCreateABuyOrder().Click();
            
            //Choisir Fonds d'investissements
            Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Cliquer sur sauvegarder
            Get_WinOrderDetail_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier l'ordre dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account1_6035);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6035);
            
            //Selectionner et modifier l'ordre créé dans l'accumulateur
            SelectAndEditOrderInAccumulatorByAccountPermit(account1_6035,account2_6035);
            
            //Vérifier l'ordre modifié dans l'accumulateur
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,account2_6035);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6035);

            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account2_6035);            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}
