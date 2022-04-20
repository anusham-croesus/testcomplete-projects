//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6033
    Description          :  Ordre d`Achat avec compte non bloqué par la pref suivi de modification de compte par compte bloqué.
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6033_PurchaseOrderWithAccountNotBlockedByPrefAccountModificationFollowedByBlockedAccount() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6033","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6033 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6033", language+client);
            var account2_6033 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6033", language+client);
            var type_6033 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
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
            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(account1_6033);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

function SelectAndEditOrderInAccumulatorByAccountNotPermit(Account1,Account2){
     Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",Account1],10).Click();
     Get_OrderAccumulator_BtnEdit().Click();
     WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
     Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey();
     Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(Account2)
     Get_WinOrderDetail_GrpAccount_BtnSearch().Click();
     if (Get_SubMenus().VisibleOnScreen) Log.Checkpoint("Le compte "+Account2+" n'existe pas dans la liste");
     else Log.Error("Le compte "+Account2+" existe dans la liste");
     Get_SubMenus().Keys("[Esc]");
     Get_WinOrderDetail_BtnCancel().Click();
     WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");     
}
