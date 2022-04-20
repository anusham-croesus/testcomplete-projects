//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


 function AddABuyBySymbol(quantity,cmbTransaction,symbol){
            Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
            //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
            Get_WinSwitchSource_CmbSecurity().Click();
            Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
            
            Get_WinSwitchSource_TxtQuantity().Keys(quantity);
            Get_WinSwitchSource_CmbQuantity().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction],10).Click();
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
            Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",symbol,10).DblClick();
            }
            Get_WinSwitchSource_btnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
 }
 
 function CheckABuyInGrid(quantity,symbol){
        if (language == "french") var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Achat", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            else var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Buy", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            aqObject.CheckProperty(item.DataItem, "Quantity", cmpEqual,quantity);
            aqObject.CheckProperty(item.DataItem, "SymbolDisplay", cmpEqual,symbol);
 }
 
 function CheckAccountInAccumulatorBySymbol(symbol,USDAccount){
        var NbrItem = Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Count;
            var find = false;
            for (i=0;i<NbrItem;i++)
            {
              Get_OrderAccumulator().FindChild(["ClrClassName","XamTextEditor"],["Text",symbol],10);
              find = true;
              break;
            }
            if (find) 
            {
              Log.Message("Valider que le No de compte = " +USDAccount);
              aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(i).DataItem,"AccountNumber",cmpEqual,USDAccount);
            }else
              Log.Error("L'ordre n'existe pas dans l'accumulateur");  
 }
 
function SelectTwoAccounts(account1,account2){
      Search_Account(account1);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(-1, -1, skCtrl);
      Search_Account(account2);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(-1, -1, skCtrl); 
}

function Get_DlgWarning_LblMessage(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}
function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

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

function SelectThreeAccounts(account1,account2,account3){
      Search_Account(account1);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(-1, -1, skCtrl);
      Search_Account(account2);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(-1, -1, skCtrl);
      Search_Account(account3);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account3,10).Click(-1, -1, skCtrl);
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

function SelectFiveAccounts(account1,account2,account3,account4,account5){
      Search_Account(account1);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(-1, -1, skCtrl);
      //Search_Account(account2);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(-1, -1, skCtrl); 
      //Search_Account(account3);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account3,10).Click(-1, -1, skCtrl);
      //Search_Account(account4);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account4,10).Click(-1, -1, skCtrl);
      //Search_Account(account5);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account5,10).Click(-1, -1, skCtrl);
}

function CheckAccountCrochet(account1,account2,account3,account4,account5){
      var Grid = Get_RelationshipsClientsAccountsGrid().RecordListControl
      var count = Grid.Items.Count;
      for (i=0;i<count;i++){
          if (Grid.Items.Item(i).DataItem.AccountNumber == account1){
              Log.Message(i)
              aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
          }
          if (Grid.Items.Item(i).DataItem.AccountNumber == account2){
              Log.Message(i)
              aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
          }
          if (Grid.Items.Item(i).DataItem.AccountNumber == account3){
              Log.Message(i)
              aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
          }
          if (Grid.Items.Item(i).DataItem.AccountNumber == account4){
              Log.Message(i)
              aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
          }
          if (Grid.Items.Item(i).DataItem.AccountNumber == account5){
              Log.Message(i)
              aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
          }
      } 
}

function CheckAccountsAfterPreview5(account1,account2,account3,account4,account5){
  var Grid = Get_WinSwitchBlock().WPFObject("_switchTransactionGrid").WPFObject("RecordListControl", "", 1);
  Grid.WaitProperty("HasItems", true, 30000);
  var count = Grid.Items.Count;
  var found1 =false;
  var found2 = false;
  var found3 = false;
  var found4 = false;
  var found5 = false;
  for (i=0;i<count;i++){
       if(Grid.Items.Item(i).DataItem.AccountNumber == account1) found1=true;
       if(Grid.Items.Item(i).DataItem.AccountNumber == account2) found2=true;
       if(Grid.Items.Item(i).DataItem.AccountNumber == account3) found3=true;
       if(Grid.Items.Item(i).DataItem.AccountNumber == account4) found4=true;
       if(Grid.Items.Item(i).DataItem.AccountNumber == account5) found5=true;
  }
  if (found1) Log.Error("l'ordre pour le compte "+account1+" ne doit pas être inclu dans la grille");
  else Log.Checkpoint("l'ordre pour le compte "+account1+" n'est pas inclu dans la grille");
  if (found2) Log.Checkpoint("l'ordre pour le compte "+account2+" est inclu dans la grille"); 
  else Log.Error("l'ordre pour le compte "+account2+" doit être inclu dans la grille");
  if (found3) Log.Checkpoint("l'ordre pour le compte "+account3+" est inclu dans la grille"); 
  else Log.Error("l'ordre pour le compte "+account3+" doit être inclu dans la grille");
  if (found2) Log.Checkpoint("l'ordre pour le compte "+account4+" est inclu dans la grille"); 
  else Log.Error("l'ordre pour le compte "+account4+" doit être inclu dans la grille");
  if (found2) Log.Checkpoint("l'ordre pour le compte "+account5+" est inclu dans la grille"); 
  else Log.Error("l'ordre pour le compte "+account5+" doit être inclu dans la grille");
}

function CheckASellInGrid(quantity,symbol){
        if (language == "french") var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Vente", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            else var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Sell", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            aqObject.CheckProperty(item.DataItem, "Quantity", cmpEqual,quantity);
            aqObject.CheckProperty(item.DataItem, "SymbolDisplay", cmpEqual,symbol);
 }
 
 function DeleteSleevesAndModelsCreatedIn6025(){
            var modelName1Croes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "modelName1Croes_6025", language+client);
            var modelName2Croes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "modelName2Croes_6025", language+client);
            var AccountNoCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "AccountNoCroes_6025", language+client);
            var LongTermCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "LongTermCroes_6025", language+client);
            var CanadianEquityCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CanadianEquityCroes_6025", language+client);
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 50000);  
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            Search_Account(AccountNoCroes_6025);
            Get_RelationshipsClientsAccountsGrid().Find("Value",AccountNoCroes_6025,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
            
            //Sélectionner les classes Long terme et Actions canadiennes
            var Grid = Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("_assetMixgrid").WPFObject("RecordListControl", "", 1);
  
            Grid.FindChild("Value", LongTermCroes_6025, 10).Click(-1, -1, skCtrl);
            Grid.FindChild("Value", CanadianEquityCroes_6025, 10).Click(-1, -1, skCtrl);
            
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
            
            //Supprimer les segments créés
            DeleteSleeveWinSleevesManager(LongTermCroes_6025);
            DeleteSleeveWinSleevesManager(CanadianEquityCroes_6025);
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
            
            //Supprimer les modèles créés
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            DeleteModelByName(modelName1Croes_6025);
            DeleteModelByName(modelName2Croes_6025);    
 }