//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1571_Croes6545_ValidateTheOperationNewCheckBoxManualProcessingOrder
//USEUNIT CR1852_5755_Preparation


/**
 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6551
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	ref90-12-18--V9-croesus (TD) :Le backup pour l'environnement de GDO TD se trouve dans BDref:  HF_TD_GDO_90.12-18_2019-07-12
*/

function CR1571_Croes6551_ValidateMaximumValuePerUnderlyingOrderBasedOnTheCurrency()
{
    try {
      
       
       var accountBuyCroes6547=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "accountBuyCroes6547", language+client);
       var quantityBuyCroes6551=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyCroes6551", language+client);
       var symbolBuyCroes6551=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "symbolBuyCroes6551", language+client);
       var messageWarningCroes6551=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "messageWarningCroes6551", language+client);
      
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
       Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityBuyCroes6551);
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
        
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolBuyCroes6551)
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
        // Get_SubMenus().Find("Value",securityCroes6547,10).DblClick();
        
        
       
        //Cliquer sur vérifier ensuite soumettre
        Get_WinOrderDetail_BtnVerify().Click();
      
        //Les points de vérifications :L'ordre s'ajoute dans le Blotter avec l'état : Exécuté  
        Get_WinOrderDetail_TabWarnings().Click();
        var dispalyMessagCroes6551=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Message
        CheckEquals(dispalyMessagCroes6551, messageWarningCroes6551, "Le message bloquant de l'onglet d'avertissement");
        //Cliquer sur le bouton Annuler
        Get_WinOrderDetail_BtnCancel().Click();
      
      
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));       
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        Runner.Stop(true); 
    }
}

