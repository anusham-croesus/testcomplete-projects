//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1571_Croes6545_ValidateTheOperationNewCheckBoxManualProcessingOrder
//USEUNIT CR1852_5755_Preparation


/**
 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6547
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	ref90-12-18--V9-croesus (TD) :Le backup pour l'environnement de GDO TD se trouve dans BDref:  HF_TD_GDO_90.12-18_2019-07-12
*/

function CR1571_Croes6547_ValidateMaximumValueByUnderlyingOrder()
{
    try {
      
       var accountBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "accountBuyCroes6547", language+client);
       var quantityBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyCroes6547", language+client);
       var symbolBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "symbolBuyCroes6547", language+client);
       var securityCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "securityCroes6547", language+client);
       var messageWarningCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "messageWarningCroes6547", language+client);
       var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account1", language+client);
       var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account2", language+client);
       var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account3", language+client);
       var account4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account4", language+client);
       var account5=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account5", language+client);
       var account6=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account6", language+client);
       var account7=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account7", language+client);
       var account8=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account8", language+client);
       var account9=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account9", language+client);
       var account10=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "account10", language+client);
       var transactionCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "transactionCroes6547", language+client);
       var ItemSymbolSecurityBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ItemSymbolSecurityBNC906", language+client);
       var perUnitAccountCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "perUnitAccountCroes6547", language+client);
       var financialInstrumentCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "financialInstrumentCroes6545", language+client);
       var accountBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "accountBuyCroes6547", language+client);
       var quantityBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyCroes6547", language+client);
       var orderTypeCroes6545 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "orderTypeCroes6545", language+client);
       var messageTotalExcelCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "messageTotalExcelCroes6547", language+client);
       
       
      
       var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
                
        //Créer un ordre d'achat
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        //Remplir les details de l'ordre
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountBuyCroes6547)
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
       Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityBuyCroes6547);
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
        
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolBuyCroes6547)
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
        Get_SubMenus().Find("Value",securityCroes6547,10).DblClick();
        
        
       
        //Cliquer sur vérifier ensuite soumettre
        Get_WinOrderDetail_BtnVerify().Click();
      
       //Les points de vérifications :L'ordre s'ajoute dans le Blotter avec l'état : Exécuté  
        Get_WinOrderDetail_TabWarnings().Click();
        var dispalyMessagCroes6547=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Message
        CheckEquals(dispalyMessagCroes6547, messageWarningCroes6547, "Le message bloquant de l'onglet d'avertissement");
        //Cliquer sur le bouton Annuler
        Get_WinOrderDetail_BtnCancel().Click();
        //Aller dans le module compte ensuite sélectionner 10 comptes
         Get_MainWindow().Maximize();
        
        var arrayOfAccountsNo= new Array(account1,account2,account3,account4,account5,account6,account7,account8,account9,account10)
        //Sélectionner 10 accounts
        SelectAccounts(arrayOfAccountsNo)
        /*Cliquer sur le bouton Ordres multiples en bloc et d'échanges

          Transaction(s): Achat

           Cliquer sur Ajouter

              Quantité 10000   Unités par compte

               Titre;  NA + rechercher

              OK

              Générer*/
              
           Get_Toolbar_BtnSwitchBlock().Click();
           WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
           Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transactionCroes6547);
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
           Get_WinSwitchSource_TxtQuantity().Keys(quantityBuyCroes6547);
           Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
           Aliases.CroesusApp.subMenus.Find("WPFControlText",perUnitAccountCroes6547,10).Click();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
           Get_WinSwitchSource_GrpPosition().Click();
           Aliases.CroesusApp.subMenus.Find("WPFControlText",ItemSymbolSecurityBNC906,10).Click();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbolBuyCroes6547);
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
           Aliases.CroesusApp.subMenus.Find("WPFControlText",securityCroes6547,10).DblClick();
           Get_WinSwitchSource_btnOK().Click();
           Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
           Get_WinSwitchBlock_BtnGenerate().Click();  
           //les points de vérifications:L'ordre s'ajoute dans l'Accumulateur
           CheckPresenceOrderInAccumulator(accountBuyCroes6547,quantityBuyCroes6547,symbolBuyCroes6547,financialInstrumentCroes6545,orderTypeCroes6545)
           //Dans la section Accumulateur sélectionner l'ordre créé de l'étape 2 et cliquer sur Vérifier
           Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityCroes6547,10).Click();   
           Get_OrderAccumulator_BtnVerify().Click();
           
           //Les points de vérifications
           var dispalyMessage1Croes65471=Get_WinAccumulator_LstMessages().WPFObject("ListBoxItem", "", 1).Content.Message.OleValue
           var dispalyMessage2Croes65471=Get_WinAccumulator_LstMessages().WPFObject("ListBoxItem", "", 2).Content.Message.OleValue
           var dispalyTotalMessageCroes65471=dispalyMessage1Croes65471+dispalyMessage2Croes65471;
           CheckEquals(dispalyTotalMessageCroes65471, messageTotalExcelCroes6547, "Le message est : ");
           Get_WinAccumulator_BtnCancel().Click();
      
      
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();  
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
       Runner.Stop(true); 
    }
}

