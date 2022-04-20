//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1571_Croes6545_ValidateTheOperationNewCheckBoxManualProcessingOrder



/**
 
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6546
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	90.10.Fm-19_2019-05-30 (TD) :Le backup pour l'environnement de GDO TD se trouve dans BDref: Fm_TD_GDO_90.10.Fm-19_2019-05-30
*/

function CR1571_Croes6546_ValidateOperationOfBidOfMutualSubstantiveOrder()
{
    try {
      
       var accountBuyCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "accountBuyCroes6546", language+client);
       var quantityBuyCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyCroes6546", language+client);
       var itemQuantityCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "itemQuantityCroes6546", language+client);
       var symbolBuyCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "symbolBuyCroes6546", language+client);
       var statusExecutedCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "statusExecutedCroes6545", language+client);
       var securityCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "securityCroes6546", language+client);
       var quantityBuyGrillCroes6546=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyGrillCroes6546", language+client);
      
       var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
                
        //Créer un ordre d'achat
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        //Remplir les details de l'ordre
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountBuyCroes6546)
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinMutualFundsOrderDetail_CmbQuantityType().Click();
        Aliases.CroesusApp.subMenus.Find("WPFControlText",itemQuantityCroes6546,10).Click();
        Get_WinMutualFundsOrderDetail_TxtQuantity().Keys(quantityBuyCroes6546);
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolBuyCroes6546)
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
        
       
        //Cliquer sur vérifier ensuite soumettre
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnVerify().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
       //Les points de vérifications :L'ordre s'ajoute dans le Blotter avec l'état : Exécuté 
       Delay (10000); 
         if(language=="english"){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).Click(); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,statusExecutedCroes6545);
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityCroes6546);  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityBuyGrillCroes6546); 
       } 
       else{
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click(); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,statusExecutedCroes6545); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityCroes6546);  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityBuyGrillCroes6546); 
       }     
      
    }
    catch(e) {
		   //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));        
    }
    finally {
		    //Fermer le processus Croesus
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        Runner.Stop(true); 
    }
}
