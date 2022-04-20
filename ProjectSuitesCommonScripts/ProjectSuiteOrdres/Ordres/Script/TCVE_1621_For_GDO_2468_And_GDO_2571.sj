//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0()


/**
    Module               :  Orders
    Jira                 :  GDO-2468 et GDO-2571
    Description          :  Script pour couvrir les 2 jiras GDO-2468 et GDO-2571 
    Préconditions        : 
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.16.2020.7-19
    date                 :  18-06-2020 
  
    
*/

function TCVE_1621_For_GDO_2468_And_GDO_2571()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1621","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1622","Lien du cas de test dans Jira");
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
           
           var account800053NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800053NA", language+client);
           var descriptionTCVE1621  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "descriptionTCVE1621", language+client);
           var quantityTCVE1621     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "quantityTCVE1621", language+client);
           var message_TCVE1621     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "message_TCVE1621", language+client);
           var account800075RE      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800075RE", language+client);
           var account800075SF      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800075SF", language+client);
           var quantitySellTCVE1621 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "quantitySellTCVE1621", language+client);
           var cmbTransactionTCVE1621 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "cmbTransactionTCVE1621", language+client);
           var symbolMSFT           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolMSFT", language+client);
           var cmbTransaction1      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
           var account300001NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800053NA", language+client);
           var symbolNA             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolNA", language+client);
           var nbreOrderAccumulator = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "nbreOrderAccumulator", language+client);
           var symbolRIC            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolRIC", language+client);


/************************************Étape 1************************************************************************/     
           //Se connecter à croesus avec KEYNEJ
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ et mailler le compte 800053-NA vers le portefeuille ");
          Log.Message("Se connecter à croesus avec KEYNEJ");
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          
          Log.Message("Mailler le compte 800053-NA vers le portefeuille ");
          //Accéder au module compte
          Log.Message("Acceder au module Compte");
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
           
          //Sélectionner le comptes 800053-NA 
          Log.Message("Sélectionner le compte "+account800053NA+" et mailler vers Portefeuille");
          Search_Account(account800053NA);
          Get_RelationshipsClientsAccountsGrid().Find("Value",account800053NA,10).Click();
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
       
/************************************Étape 2************************************************************************/     
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Sélectionner la position short RIC (ASE) et  cliquer sur le bouton Ordres Multiples" );
          SearchAccountByDescriptionInPortfolioGrid(descriptionTCVE1621);
          Get_Portfolio_PositionsGrid().Find("Value",descriptionTCVE1621,10).Click();
          
          // Cliquer le boutonOrdres multiples, en bloc et d'échange
          Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          
        //Adaptation des scripts GDO suite au retrait de la story GDO-1675
       Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantitySellTCVE1621)
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbolRIC);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        if(Get_SubMenus().Exists){        
          Aliases.CroesusApp.subMenus.Find("Value",symbolRIC,10).DblClick();
        }   
        Get_WinSwitchSource_btnOK().Click();
        

 
          
         
/************************************Étape 3************************************************************************/     
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3: Cliquer sur le bouton Aperçu");
                      
           //Cliquer sur le bouton Aperçu
           Log.Message("Cliquer sur le bouton Aperçu");
           Get_WinSwitchBlock_BtnPreview().Click();
           
           Log.Message("Valider que la case Inclure est cochée et la valeur de la colonne quantité détenue est égale à celle dans le portefeuille(-1037)");
           var count = Get_WinSwitchBlock_DgvOrders().Items.Count;
           for (i=0; i<count; i++){
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber == account800053NA ){
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"QtyOnHandForDisplay", cmpEqual, quantityTCVE1621);
                 break;
              }
           }
                   
/************************************Étape 4 et 5 ************************************************************************/    
           Log.PopLogFolder();
           logEtape4 = Log.AppendFolder("Étape 4,5 : Cliquer sur le bouton Générer et sélectionner l'ordre dans l'accumulateur");
           //Cliquer sur le bouton Générer
           Log.Message("Cliquer sur le bouton Générer");
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 30000);          
//           Get_WinSwitchBlock_BtnGenerate().Click();
           if (Get_WinSwitchBlock_BtnGenerate().IsEnabled)
               Get_WinSwitchBlock_BtnGenerate().Click();
           if (Get_DlgConfirmation_BtnYes().Exists)
               Get_DlgConfirmation_BtnYes().Click();
           //Sélectionner l'ordre et cliquer sur le bouton vérifier
           Log.Message("Sélectionner l'ordre et cliquer sur le bouton vérifier");
           Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",descriptionTCVE1621],10).Click();
           Get_OrderAccumulator_BtnVerify().Click();
           WaitObject(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
           
           //Valider le message d'avertissement affiché
           Log.Message("Valider le message d'avertissement qui est affiché en bas de la fenêtre");
           aqObject.CheckProperty(Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["ListBoxItem","1"],10).DataContext.Message,"OleValue", cmpEqual, message_TCVE1621);
           
           //Cliquer sur Annuler
           Get_WinAccumulator_BtnCancel().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
          
/****************************************Étape 6 ************************************************************************/     
           Log.PopLogFolder();
           logEtape6 = Log.AppendFolder("Étape 6 :Aller dans le module comptes et sélectionner les comptes:800075-RE,800075-SF et cliquer sur bouton Ordres multiples.");
           Log.Message("Aller dans le module comptes et sélectionner les comptes:800075-RE,800075-SF");           
           //Accéder au module compte
           Log.Message("Acceder au module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
           
           //Sélectionner 2 comptes 800075-RE,800075-SF
           Log.Message("Sélectionner les comptes 800075-RE,800075-SF");
           Search_Account(account800075RE);
           Get_RelationshipsClientsAccountsGrid().Find("Value",account800075RE,10).Click(-1, -1, skCtrl);
           Search_Account(account800075SF);
           Get_RelationshipsClientsAccountsGrid().Find("Value",account800075SF,10).Click(-1, -1, skCtrl);
           
           // Cliquer le boutonOrdres multiples, en bloc et d'échange
          Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          
/************************************Étape 7************************************************************************/     
           Log.PopLogFolder();
           logEtape7 = Log.AppendFolder("Étape 7: Cliquer sur le bouton Aperçu");
           
           Log.Message("Appel à la fonction d'ajout d'une vente");
           AddASellBySymbol(quantitySellTCVE1621,cmbTransactionTCVE1621,symbolMSFT);
                      
           //Cliquer sur le bouton Aperçu
           Log.Message("Cliquer sur le bouton Aperçu");
           Get_WinSwitchBlock_BtnPreview().Click();
           
           //Valider que seul le compte 800075-SF est coché dans la colonne Include.
           Log.Message("Valider que seul le compte 800075-SF est coché dans la colonne Include");
           var count = Get_WinSwitchBlock_DgvOrders().Items.Count;
           for (i=0; i<count; i++){
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber == account800075SF ){
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
              }
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber == account800075RE || Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber == account800053NA ){
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, false);
              }
           }





            
/****************************************Étape 8 et 9 ************************************************************************/     
           Log.PopLogFolder();
           logEtape8 = Log.AppendFolder("Étape 8 et 9 :Modifier l'ordre Multiple et cliquer sur Aperçu ");
           Log.Message("Modifier l'ordre Multiple");
           Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();
           WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
           Get_WinSwitchSource_CmbQuantity().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction1],10).Click();
           Get_WinSwitchSource_btnOK().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
           
           //Cliquer sur le bouton Aperçu
           Log.Message("Cliquer sur le bouton Aperçu");
           Get_WinSwitchBlock_BtnPreview().Click();
           
           //Valider que tous les comptes sont cochés dans la colonne Include.
           Log.Message("Valider que tous les comptes sont cochés dans la colonne Include");
           var count = Get_WinSwitchBlock_DgvOrders().Items.Count;
           for (i=0; i<count; i++){
              aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
           }
           
           //Cliquer sur le bouton Générer
           Log.Message("Cliquer sur le bouton Générer");
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true, maxWaitTime);
           Get_WinSwitchBlock_BtnGenerate().Click(); 
           if (Get_WinSwitchBlock().Exists)
              Get_WinSwitchBlock_BtnGenerate().Click(); 
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
           
           
           if (Get_DlgConfirmation_BtnYes().Exists)
               Get_DlgConfirmation_BtnYes().Click();
           
/****************************************Étape 10 ************************************************************************/     
           Log.PopLogFolder();
           logEtape10 = Log.AppendFolder("Étape 10 :Dans le module ordres Créer des ordres d'achat pour actions");
           Log.Message("Créer 7 ordres d'achat de type Actions");
           //ordre 1:Ne remplir aucun champ  dans la fenêtre Achat et sauvegarder.
           Log.Message("ordre 1:Ne remplir aucun champ  dans la fenêtre Achat et sauvegarder.");
           CreateBuyOrder("", "", "");
  
           //Ordre 2 : Remplir uniquement le champs compte ( 300001-Na)
           Log.Message("Ordre 2 : Remplir uniquement le champs compte ( 300001-Na)");
           CreateBuyOrder(account300001NA, "", "");
           
           //Ordre 3 : Remplir uniquement le symbol(Na)
           Log.Message("Ordre 3 : Remplir uniquement le symbol(Na)");
           CreateBuyOrder("", "", symbolNA);
           
           //Ordre 4 : Remplir uniquement la quantité
           Log.Message("Ordre 4 : Remplir uniquement la quantité");
           CreateBuyOrder("", quantitySellTCVE1621, "");
           
           //Ordre 5 : Remplir la quantité et le symbole
           Log.Message("Ordre 5 : Remplir la quantité et le symbole");
           CreateBuyOrder("", quantitySellTCVE1621, symbolNA);
           
           //Ordre 6 : Remplir le compte et la quantité 
           Log.Message("Ordre 6 : Remplir le compte et la quantité ");
           CreateBuyOrder(account300001NA, quantitySellTCVE1621, "");
           
           //Ordre 7 : remplir le compte et le symbol
           Log.Message("Ordre 7 : remplir le compte et le symbol");
           CreateBuyOrder(account300001NA, "", symbolNA);

/****************************************Étape 11 ************************************************************************/     
           Log.PopLogFolder();
           logEtape11 = Log.AppendFolder("Étape 11 :Sélectionner tous les ordres créer à l'étape 9 et 10  et cliquer sur vérifier");
           Log.Message("Sélectionner tous les ordres créer à l'étape 9 et 10");
           //Supprimer l'ordre généré au début de script
          Log.Message("Supprimer l'ordre généré au début de script");
          if (Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",descriptionTCVE1621],10).Exists);
              DeleteOrderInAcumulator(descriptionTCVE1621);
  
          //Sélectionner tous les ordres qui restent dans l'accumulateur (bloc de étape9 et les 7 ordres d'achat
          Log.Message("Sélectionner tous les ordres qui restent dans l'accumulateur (bloc de étape9 et les 7 ordres d'achat");
          Get_OrderAccumulatorGrid().Click();
          Get_OrderAccumulatorGrid().Keys("^a");
  
          //Cliquer sur le bouton vérifier
          Log.Message("Cliquer sur le bouton vérifier");
          Get_OrderAccumulator_BtnVerify().Click();
          WaitObject(Get_CroesusApp(), "Uid", "BatchOrderVerificationWindow_342c");
  
          //Points de vérification
          Log.Message("Tous les ordres vont s'afficher dans la fenêtre vérifier les ordres y compris le bloc créée dans l'étape 9");
          var grid = Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10);
          var count = grid.Items.Count;
          aqObject.CheckProperty(grid.Items,"Count", cmpEqual, nbreOrderAccumulator);
          for (i=0; i<count; i++){
            if (grid.Items.Item(i).DataItem.OrderSymbol == "MSFT")
                aqObject.CheckProperty(grid.Items.Item(i).DataItem,"HasErrors", cmpEqual, false);
            else
                aqObject.CheckProperty(grid.Items.Item(i).DataItem,"HasErrors", cmpEqual, true);
          }

           Get_WinAccumulator_BtnCancel().Click();
          
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
//      suppression des ordres de l'accumulateur
        Log.Message("------------- C L E A N U P -----------------------------");
        Log.Message("Supprimer les ordres dans l'accumulateur"); 
        Get_OrderAccumulatorGrid().Click();
        Get_OrderAccumulatorGrid().Keys("^a");
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }
 
 //ligne 7400 in common_function
function SearchAccountByDescriptionInPortfolioGrid(description){
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().SetText(description); 
        Get_WinPortfolioQuickSearch_RdoDescription().set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
}

function CreateBuyOrder(account, quantity, symbol){
   
      Get_Toolbar_BtnCreateABuyOrder().Click();
      //WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
      
      //Selectioner 'Stoks'
      Get_WinFinancialInstrumentSelector_RdoStocks().Click();
      Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
      Get_WinFinancialInstrumentSelector_BtnOK().Click();
      WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
               
      if (Trim(VarToStr(account))!== "")    
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
          
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
      if (Trim(VarToStr(quantity))!== "") 
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
        
      if (Trim(VarToStr(symbol))!== "") 
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbol);
        
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        
      Get_WinOrderDetail_BtnSave().Click();
      WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);

}

function test(){
    
 var account800053NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800053NA", language+client);
           var descriptionTCVE1621  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "descriptionTCVE1621", language+client);
           var quantityTCVE1621     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "quantityTCVE1621", language+client);
           var message_TCVE1621     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "message_TCVE1621", language+client);
           var account800075RE      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800075RE", language+client);
           var account800075SF      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800075SF", language+client);
           var quantitySellTCVE1621 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "quantitySellTCVE1621", language+client);
           var cmbTransactionTCVE1621 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "cmbTransactionTCVE1621", language+client);
           var symbolMSFT           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolMSFT", language+client);
           var cmbTransaction1      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
           var account300001NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "account800053NA", language+client);
           var symbolNA             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolNA", language+client);
           var nbreOrderAccumulator = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "nbreOrderAccumulator", language+client);
           var symbolRIC            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "symbolRIC", language+client);


  
        //Adaptation des scripts GDO suite au retrait de la story GDO-1675
        //Ajout d'une transaction(s):Achat  
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantitySellTCVE1621)
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbolRIC);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        if(Get_SubMenus().Exists){        
          Aliases.CroesusApp.subMenus.Find("Value",symbolRIC,10).DblClick();
        }   
        Get_WinSwitchSource_btnOK().Click();
Get_WinSwitchBlock_BtnPreview().Click();
 Get_WinSwitchBlock_BtnGenerate().Click();
 Get_DlgConfirmation_BtnYes().Click();
}