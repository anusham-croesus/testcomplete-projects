//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6070 
    Description          :  Échange/bloc avec deux comptes dont un est de type bloqué et source égale sélection courante-Générer.
    Préconditions        :  PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
                            Aucun critere de recherche n'est actif
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-9
    Date                 :  04/03/2019
    
*/


function CR2140_6070_ExchangeBlockWithTwoAccountsWichOneIsBlockedAndSourceEqualCurrentSelectionGenerate() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6070","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            var msgWarning_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var transactionType_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6070", language+client);
            var cmbTransaction_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6070", language+client);
            var quantity_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6038", language+client); 
            var symbol_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6038", language+client); 
            var type_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
            var CADAccount_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
            
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800019-JW
            SelectTwoAccounts(account1_6070,account2_6070);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Vérifier le message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning_6070);
            Get_DlgWarning().Keys("[Enter]");
            
            //Mettre Transaction à Vente
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6070],10).Click();
            
            //Ajouter : 100 % de la position détenue, symbole = NBC813
            AddABuyBySymbol(quantity_6070,cmbTransaction_6070,symbol_6070);
            
            //Valider que l'ordre de vente du titre NBC813 est ajouté
            CheckASellInGrid(quantity_6070,symbol_6070);
            
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
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6070);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6070);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6070);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6070],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que juste le compte 800019-JW est affiché dans l'onglet Comptes sous-jacents
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == 1) Log.Checkpoint("Un seul compte sous-jacent est affiché");
            else Log.Error("Aucun compte ou plus d'un compte sous-jacents sont affichés");
            aqObject.CheckProperty( Grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account2_6070);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6070); 
            
            //Supprimer les segments et les modèles créés dans CROES-6025
            DeleteSleevesAndModelsCreatedIn6025(); 
      
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess(); 
            
            //Mettre la pref PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = "" valeur par défaut
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TRADE_ACCOUNT_TYPES_EXCLUDED", "", vServerOrders);
            
            //Mettre la pref PREF_SLEEVE_ALLOW_TRADE = NO  pour le USer utilisé (keyneJ) la valeur par défaut
            Activate_Inactivate_Pref("KEYNEJ", "PREF_SLEEVE_ALLOW_TRADE", "NO", vServerOrders);
            
            //Redemarrer les services
            RestartServices(vServerOrders);               
        }
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