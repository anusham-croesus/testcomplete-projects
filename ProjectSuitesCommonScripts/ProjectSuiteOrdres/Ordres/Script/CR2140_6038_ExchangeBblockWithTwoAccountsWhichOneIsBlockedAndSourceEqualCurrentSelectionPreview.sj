//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6038 
    Description          :  Échange/bloc avec deux comptes dont un est de type bloqué et source égale selection courante-AperÇu.
    Préconditions        :  PREF_TRADE_ACCOUNT_TYPES_EXCLUDED
                            PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
                            Aucun critere de recherche n'est actif
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6038_ExchangeBblockWithTwoAccountsWhichOneIsBlockedAndSourceEqualCurrentSelectionPreview() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6038","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            var msgWarning1_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var transactionType_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            var quantity_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6038", language+client);
            var symbol_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6038", language+client);
            var type_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
            var CADAccount_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800019-JW
            SelectTwoAccounts(account1_6038,account2_6038);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Vérifier le 1er message d'avertissement affiché
            if(Get_DlgWarning().Exists){
                aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6038);
                Get_DlgWarning().Keys("[Enter]");
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            }
            //Choisir type transaction Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6038],10).Click();
            
                       
            //Ajouter : 100 Unités par compte, symbole = NBC813
            AddABuyBySymbol(quantity_6038,cmbTransaction_6038,symbol_6038);
            
            //Valider que l'ordre d'achat du titre NBC813 est ajouté
            CheckABuyInGrid(quantity_6038,symbol_6038);
            
            //Cliquer sur Aperçu
            Get_WinSwitchBlock_BtnPreview().Click();
            
            if(Get_DlgWarning().Exists){
                aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6038);
                Get_DlgWarning().Keys("[Enter]");
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            }
            
            //Vérifier l'affichage des comptes dans la section Ordres
            CheckAccountsAfterPreview(account1_6038,account2_6038);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6038);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6038);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6038);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6038],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que juste le compte 800019-JW est affiché dans l'onglet Comptes sous-jacents
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == 1) Log.Checkpoint("Un seul compte sous-jacent est affiché");
            else Log.Error("Aucun compte ou plus d'un compte sous-jacents sont affichés");
            aqObject.CheckProperty( Grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account2_6038);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6038);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

function CheckAccountsAfterPreview(account1,account2){
  var Grid = Get_WinSwitchBlock().WPFObject("_switchTransactionGrid").WPFObject("RecordListControl", "", 1);
  Grid.WaitProperty("HasItems", true, 30000);
  var count = Grid.Items.Count;
  var found1 =false;
  var found2 = false;
  for (i=0;i<count;i++){
       if(Grid.Items.Item(i).DataItem.AccountNumber == account1) found1=true;
       if(Grid.Items.Item(i).DataItem.AccountNumber == account2) found2=true;
  }
  if (found1) Log.Error("l'ordre pour le compte "+account1+" ne doit pas être inclu dans la grille");
  else Log.Checkpoint("l'ordre pour le compte "+account1+" n'est pas inclu dans la grille");
  if (found2) Log.Checkpoint("l'ordre pour le compte "+account2+" est inclu dans la grille"); 
  else Log.Error("l'ordre pour le compte "+account2+" doit être inclu dans la grille");
}

