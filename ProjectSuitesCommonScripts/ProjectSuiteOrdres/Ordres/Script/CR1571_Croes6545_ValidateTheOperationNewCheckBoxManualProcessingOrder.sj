//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1852_5755_Preparation


/**
 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6545
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	90.10.Fm-19_2019-05-30 (TD) :Le backup pour l'environnement de GDO TD se trouve dans BDref: Fm_TD_GDO_90.10.Fm-19_2019-05-30
*/

function CR1571_Croes6545_ValidateTheOperationNewCheckBoxManualProcessingOrder()
{
    try {
      
            var accountBuyCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "accountBuyCroes6545", language+client);
            var quantityBuyCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "quantityBuyCroes6545", language+client);
            var symbolBuyCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "symbolBuyCroes6545", language+client);
            var securityCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "securityCroes6545", language+client);
            var financialInstrumentCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "financialInstrumentCroes6545", language+client);
            var orderTypeCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "orderTypeCroes6545", language+client);
            var statusRejetedCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "statusRejetedCroes6545", language+client);
            var statusOpenCroes6545=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "statusOpenCroes6545", language+client);
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);

            Log.Message("Créer un ordre d'achat");
            Get_Toolbar_BtnCreateABuyOrder().Click();
            Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
            Log.Message("Remplir les details de l'ordre");
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountBuyCroes6545)
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
            Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityBuyCroes6545);
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolBuyCroes6545)
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            Get_SubMenus().Find("Value",securityCroes6545,10).DblClick();
         

            Log.Message("Aller dans l'onglet Notes et côcher la case 'Traitement manuel de l'Ordre'");
            Get_WinOrderDetail_TabNotes().Click();
            Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling().set_IsChecked(true);
        
            Log.Message("Sauvgarder");
            Get_WinOrderDetail_BtnSave().Click();
        
            Log.Message("les points de vérifications:L'ordre s'ajoute dans l'Accumulateur");
            CheckPresenceOrderInAccumulator(accountBuyCroes6545,quantityBuyCroes6545,symbolBuyCroes6545,financialInstrumentCroes6545,orderTypeCroes6545);
        
            Log.Message("Sélectionner l'ordre du compte 800001-NA dans l'accumulateur et cliquer sur le bouton Vérifier");
            Log.Message("la fenêtre Vérifier les ordres s'ouvre Cocher la cas Inclure + Soumettre");
            Get_OrderAccumulatorGrid().Find("Value",accountBuyCroes6545,10).Click();
       
            WaitObject(Get_CroesusApp(), ["Uid", "IsEnabled"], ["Button_4407", true]);
            Get_OrderAccumulator_BtnVerify().Click();
       
            Log.Message("Côcher la cas Inclure + Soumettre");
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).set_IsChecked(true)
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
            WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
            Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
            Get_WinAccumulator_BtnSubmit().Click();
            Delay(2000);
//       WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
//       WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BatchOrderVerificationWindow_342c", true]);

       
            Log.Message("Les points de vérifications :L'ordre est transféré dans le blotter (section du haut)");
            if(language=="english"){
              Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).Click(); 
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,statusOpenCroes6545);
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityCroes6545);  
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityBuyCroes6545); 
            } 
            else{
              Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click(); 
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,statusOpenCroes6545); 
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityCroes6545);  
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityBuyCroes6545); 
            }   
       

            Log.Message("Dans le blotter sélectionner l'ordre d'achat RY  du compte 800001-NA et cliquer sur Consulter");
            Log.Message("Aller dans l'onglet Notes");
            Get_OrderGrid().Find("Value",securityCroes6545,10).Click();
            Get_OrdersBar_BtnView().Click();
              
            Log.Message("Les points de vérifications :La case Traitement manuel de l'ordre est grisée ");
            Get_WinOrderDetail_TabNotes().Click();
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling(), "IsEnabled", cmpEqual, false);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling(), "wState", cmpEqual, 1);
      
    }
    catch(e) {
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

function ChangetheDefaultValueForAPreferenc(pref, new_default_value, vServer){   
    var updateQueryString = "update B_DEF set DEFAULT_VALUE = '" + new_default_value + "' where CLE = '" + pref + "'";
    var resultat=Execute_SQLQuery(updateQueryString, vServer);
    Log.Message(resultat);
    return Execute_SQLQuery(updateQueryString, vServer);
}
 function DeleteAllOrdersInAccumulator(){   
   var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
   if(count>0){   
        Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }   
}


