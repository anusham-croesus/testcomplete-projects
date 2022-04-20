//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6035
    Description          :  Ordre d`Achat avec compte non bloqué par la pref suivi de modif de compte par compte non bloqué.
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6035_PurchaseOrderWithAccountNotBlockedByPrefTrackingAccountChangesPerAccountNotBlocked() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6035","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6035 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6035 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6035", language+client);
            var type_6035 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
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
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account2_6035);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

function SelectAndEditOrderInAccumulatorByAccountPermit(Account1,Account2){
     Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",Account1],10).Click();
     Get_OrderAccumulator_BtnEdit().Click();
     WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
     Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey();
     Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(Account2)
     Get_WinOrderDetail_GrpAccount_BtnSearch().Click();
     Log.Checkpoint("Le compte "+Account2+" existe dans la liste");
     Get_WinOrderDetail_BtnSave().Click();
     WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
}