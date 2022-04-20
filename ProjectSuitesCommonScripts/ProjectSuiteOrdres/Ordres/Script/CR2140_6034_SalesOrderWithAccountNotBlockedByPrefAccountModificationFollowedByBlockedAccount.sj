//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6033_PurchaseOrderWithAccountNotBlockedByPrefAccountModificationFollowedByBlockedAccount


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6034
    Description          :  Ordre de Vente avec compte non bloqué par la pref suivi de modification de compte par compte bloqué.
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6034_SalesOrderWithAccountNotBlockedByPrefAccountModificationFollowedByBlockedAccount() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6034","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6033", language+client);
            var symbol_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6034", language+client);
            var type_6034 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
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
            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account1_6034);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

