//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6055
    Description          :  Échange/bloc avec des comptes dont un est de type bloqué et source égale Liste courante(Crochet).
    Préconditions        :  PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6055_ExchangeBlockWithAccountsWhichOneIsBlockedAndSourceEqualCurrentList() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6055","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            var account3_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account3_6055", language+client);
            var account4_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account4_6055", language+client);
            var account5_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account5_6055", language+client);
            var sourceType_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "sourceType_6055", language+client);
            var transactionType_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            var quantity_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6026", language+client);
            var symbol_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6055", language+client); 
            var msgWarning_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var type_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
            var CADAccount_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
            var UndrlyingAccounts_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "UndrlyingAccounts_6055", language+client);

            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800022-HU
            SelectFiveAccounts(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            //SelectFiveAccounts(account5_6055,account4_6055,account3_6055,account2_6055,account1_6055);
            
            //Appuyer la touche espace et afficher la liste par défaut les 2 comptes
            Get_RelationshipsClientsAccountsGrid().Keys(" ");
                        
            //Valider que les comptes ont un check rouge (Crochet)
            CheckAccountCrochet(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            
            //Enlever la sélection de tous les comptes sauf 800020-RE
           // Search_Account(account5_6055);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account5_6055,10).Click();
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Choisir Liste courante (Crochet) dans le Combo Source(s)
            Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceType_6055],10).Click();
            
            //Mettre Transaction à Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6055],10).Click();
            
            //Ajouter : 500 Unités par compte, symbole = CAS
            AddABuyBySymbol(quantity_6055,cmbTransaction_6055,symbol_6055);
            
            //Valider que l'ordre d'achat du titre CAS est ajouté
            CheckABuyInGrid(quantity_6055,symbol_6055);
            
            //Cliquer sur Aperçu
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Vérifier le message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning_6055);
            Get_DlgWarning().Keys("[Enter]");
            
            //Vérifier l'affichage des comptes dans la section Ordres
            CheckAccountsAfterPreview(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6055);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6055);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6055);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6055],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que les comptes 800019-JW, 800020-ER, 800020-FS, 800020-RE sont affichés dans l'onglet Comptes sous-jacents et non 800019-HU
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == UndrlyingAccounts_6055) Log.Checkpoint(UndrlyingAccounts_6055+" comptes sous-jacent sont affichés");
            else Log.Error("Le nombre de comptes affichés dans l'onglet sous-jacents est incorrect");
            for (i=0;i<Grid.Items.Count;i++){
              if (Grid.Items.Item(0).DataItem.AccountNumber == account1_6055)
                  Log.Error("Le compte "+account1_6055+" ne doit pas être affiché");
              if (i==0)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account2_6055);
              if (i==1)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account3_6055);
              if (i==2)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account4_6055);
              if (i==3)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account5_6055);
            }
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");   
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6055);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
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

function CheckAccountsAfterPreview(account1,account2,account3,account4,account5){
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

