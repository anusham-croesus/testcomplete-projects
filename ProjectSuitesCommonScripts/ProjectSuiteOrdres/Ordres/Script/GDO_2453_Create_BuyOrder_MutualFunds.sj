//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks

/* Description :Ajout d`un ordre d'achat
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2453
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper 
Mise à jour du script pour couvrir le jira client ORC-2090
Analyste d'automatisation: Abdel M
Date : 15/04/2021
Version de scriptage: 90.24.2021.04-33 */ 
 
 function GDO_2453_Create_BuyOrder_MutualFunds()
 {             
    try{  
      
        //liens vers les stories
        Log.Link("https://jira.croesus.com/browse/TCVE-4941", "lien vers la story");
        Log.Link("https://jira.croesus.com/browse/RTM-646", "lien vers le cas de test");
        
        //Variables
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityMutualFunds_2453", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityMutualFunds_2453", language+client);
        var typeForDisplay=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentMutualFund_2453", language+client);
        var  statusApproved  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step2", language+client);   
        var quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityORC2090", language+client);//10
        var Message1 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message1ORC2090", language+client);//"La devise du titre diffère de la devise du compte."+"\r\n"+
                  //"Le taux de change applicable sera pris en compte."
                  
        var Message2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message2ORC2090", language+client);//"Un ordre similaire pour le compte «800001-NA» est dans le journal des ordres."
        
        // ********************************************************Étape 1*******************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à Croesus et accéder au module Ordres");
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        // ********************************************************Étape 2*******************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Créer un ordre d'achat de type Action et valider les warnings");
        
        Log.Message("Créer un ordre d'achat de type Action");
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'FixedIncome'
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        //Creation d'ordre 
        CreateEditMutualFundsOrder(account,quantity,security)
        CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay);
        
        Get_OrderAccumulatorGrid().Find("Value",account,10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid", "OrderDetails_d698");
//        aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "IsSelected", cmpEqual,false);
        Get_WinOrderDetail_BtnVerify().Click();
//        Log.Message("Valider quand on clic sur vérifier l'onglet Avertissement n'est pas sélectionnée car il ya pas de message");
        aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "IsSelected", cmpEqual,true);
        Get_WinOrderDetail_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "OrderDetails_d698");
        
        Log.Message("Vérifier + Inclure + soumettre");
        Get_OrderAccumulator_BtnVerify().Click();
        //Côcher la cas Inclure + Soumettre
        if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BatchOrderVerificationWindow_342c", true]);
        
        //vérifier que l'ordre est dans le blotter en approbation
        Log.Message("valider que l'ordre passe dans le blotter en approbation");
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,statusApproved);
        
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Créer un autre ordre d'achat de type Action avec les mêmes paramètre sauf la quantité et valider les warnings");
        
        //Créer un ordre comme le premier meme compte et symbol et quantité différente
        Log.Message("Créer un autre Ordre d'achat avec les mêmes paramètres sauf la quantité");
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'FixedIncome'
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        CreateEditMutualFundsOrder(account,quantity2,security);
        
        Get_OrderAccumulatorGrid().Find("Value",account,10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid", "OrderDetails_d698");
//        aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "IsSelected", cmpEqual,false);
        Get_WinOrderDetail_BtnVerify().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "IsSelected", cmpEqual,true);
        
        //Valider le message d'avertissement
        Log.Message("Valider le message d'avertissement dans la fenêtre détail de l'ordre");
        var grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("ErrorGrid", "", 1).WPFObject("RecordListControl", "", 1);
        var count = grid.Items.Count;
        for (i=0; i<count; i++){
           if (i == 0)
              aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Message", cmpEqual,Message2);
//           else
//              aqObject.CheckProperty(grid.Items.Item(1).DataItem, "Message", cmpEqual,Message2);
          
        }
        Get_WinOrderDetail_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "OrderDetails_d698");
        
        Get_OrderAccumulator_BtnVerify().Click();
        
        //Valider les messages affichés
        Log.Message("Valider les messages d'avertissement après le clic sur vérifier");
//        aqObject.CheckProperty(Get_WinAccumulator().Find("Uid", "GroupBox_1c98", 10).Find(["ClrClassName","WPFControlOrdinalNo"],["ListBoxItem","1"],10).DataContext, "Message", cmpEqual,Message1);
        aqObject.CheckProperty(Get_WinAccumulator().Find("Uid", "GroupBox_1c98", 10).Find(["ClrClassName","WPFControlOrdinalNo"],["ListBoxItem","1"],10).DataContext, "Message", cmpEqual,Message2);
        
        //Côcher la cas Inclure + Soumettre
        if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BatchOrderVerificationWindow_342c", true]);
        
        //vérifier que l'ordre est dans le blotter en approbation
        Log.Message("Valider que l'ordre est dans le blotter en approbation");
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,statusApproved);
       
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        if(CheckPresenceOrderInAccumulator(account,quantity,security)){
             //Remettre les données 
            Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
    }
    finally { 
      // ********************************************************Étape 4*******************************************
      Log.PopLogFolder();
      logEtape4 = Log.AppendFolder("Étape 4: Se déconnecter de Croesus");
        
      Terminate_CroesusProcess(); //Fermer Croesus
    }
 }
 
 function CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay)
{
  var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
  var found=false;
  for(var i=0;i<count;i++){
    if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber==account)
    {
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity+"000");
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "SecurityDesc", cmpEqual,security);
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "FinancialInstrument", cmpEqual,financialInstrument);
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,typeForDisplay);
      found=true;
    }
    return found;
  }
}

 function CreateEditMutualFundsOrder(account,quantity,security)
 {        
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();   
    //Creation d'ordre 
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");

    Get_WinMutualFundsOrderDetail_TxtQuantity().set_Value(quantity);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
    SetAutoTimeOut();
    if(Get_SubMenus().Exists){
      Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
    }  
    RestoreAutoTimeOut();  
    Get_WinOrderDetail_BtnSave().Click();
 }