//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Ajout d`un ordre d'achat
Regrouper les cas de test pour éviter de répeter les étapes dans les scripts afin de réduire le temps d’exécution des tests-auto.

GDO_2453_Create_BuyOrder_FixedIncome;
GDO_2453_Create_BuyOrder_MutualFunds;
GDO_2453_Create_BuyOrder_Stocks
GDO_2491_Edit_BuyOrderStocks
GDO_2492_Edit_SellOrderFixedIncome
GDO_2494_ViewOrder
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-17-2020-07-63 */ 

function TCVE_1484_GDO()
{
    var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10, logEtape11, logEtape12, logEtape13, logEtape14, logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-1484");
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");        
        var ordersDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersDescription_2494", language+client);
        var winTitle=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailTitle", language+client);
        
        //Stoks
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
        var securitySymbol= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolStocks_2453", language+client);
        var typeForDisplay=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentStocks_2453", language+client);
        var accountEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2491", language+client);
        var securityEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2491", language+client);
        var quantityEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2491", language+client);
        
        //Mutual Funds
        var quantityMF=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityMutualFunds_2453", language+client);
        var securityMF= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityMutualFunds_2453", language+client);
        var securitySymbolMF= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolMutualFunds_2453", language+client);
        var typeForDisplayMF=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var financialInstrumentMF =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentMutualFund_2453", language+client);
        
        //Fixed Income
        var quantityFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var securityFI= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2453", language+client);
        var securitySymbolFI= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolFixedIncome_2453", language+client);
        var typeForDisplayFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var financialInstrumentFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentBond_2453", language+client);
        var accountEditFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2492", language+client);
        var securityEditFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2492", language+client);
        var quantityEditFI=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFixedIncome_2492", language+client);
        
        
        // ********************************************************Étape 1*******************************************
        logEtape1 = Log.AppendFolder("Étape 1: Accéder au module Ordres");
        
        Log.Message("Login");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        DeleteAllOrdersInAccumulator();
        
        // ********************************************************Étape 2*******************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Consulter un ordre");
               
        Get_OrderGrid().Find("Value",ordersDescription,10).Click();
        Get_OrdersBar_BtnView().Click();
        aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains,winTitle);
        Get_WinOrderDetail_BtnCancel().Click();
        
        //*******************************************************  !!!STOKS!!! **************************************         
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("!!!STOKS!!! Étape 3: Ouvrir la fênetre : Créer un ordre d'achat.");
        
        Log.Message("Cliquer sur le btn Créer un ordre d'achat.");
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Log.Message("sélectionner 'Stoks'");
        SelecteAnOrderType(Get_WinFinancialInstrumentSelector_RdoStocks())
 
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Créer un ordre d'achat.");
        
        Log.Message("Creation d'ordre"); 
        CreateEditOrder("stocks",account,quantity,security,securitySymbol);       
        
        // ********************************************************Étape 5*******************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Valider la creation d'ordre");
        
        //Verification
        if(CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay)){
        }
        else{
          Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        }
        
        // ********************************************************Étape 6*******************************************
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Modifier un ordre");
        
        Log.Message("Modification d'ordre");                              
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnEdit().Click();
        CreateEditOrder("stocks", accountEdit,quantityEdit,securityEdit); 
                
        Log.Message("Verification");
        if(CheckPresenceOrderInAccumulator(accountEdit,quantityEdit,securityEdit,financialInstrument,typeForDisplay)){           
        }
        else{
          Log.Error("Un ordre n'a pas été modifié")
        }

     
        //**********************************************   !!!Fixed Income!!! ******************************************
        // ********************************************************Étape 7_3*******************************************
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("!!!Fixed Income!!!La Répétition des étapes pour Fixed Income. Étape 7_3: Ouvrir la fênetre : Créer un ordre d'achat.");
        
        Log.Message("Cliquer sur le btn Créer un ordre d'achat.");
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Log.Message("sélectionner 'Fixed Income'");
        SelecteAnOrderType(Get_WinFinancialInstrumentSelector_RdoFixedIncome())

 
        // ********************************************************Étape 7_4*******************************************
        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("La Répétition des étapes pour Fixed Income.Étape 7_4: Créer un ordre d'achat.");
        
        Log.Message("Creation d'ordre"); 
        CreateEditOrder("FI",account,quantityFI,securityFI,securitySymbolFI);       
        
        // ********************************************************Étape 7_5*******************************************
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("La Répétition des étapes pour Fixed Income.Étape 7_5: Valider la creation d'ordre");
        
        //Verification
        if(CheckPresenceOrderInAccumulator(account,quantityFI,securityFI,financialInstrumentFI,typeForDisplayFI)){
        }
        else{
          Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        }
        // ********************************************************Étape 8*******************************************
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 8: Valider la modification d'un ordre");
        
        Log.Message("Modification d'ordre");                              
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnEdit().Click();
        CreateEditOrder("FI",accountEditFI,quantityEditFI,securityEditFI);
                
        Log.Message("Verification");
        if(CheckPresenceOrderInAccumulator(accountEditFI,quantityEditFI,securityEditFI,financialInstrumentFI,typeForDisplayFI)){           
        }
        else{
          Log.Error("Un ordre n'a pas été modifié")
        }
        
        
        //**********************************************   !!!MutualFunds!!! ******************************************
        // ********************************************************Étape 7_3*******************************************
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("!!!MutualFunds!!!La Répétition des étapes pour Mutual Funds. Étape 7_3: Ouvrir la fênetre : Créer un ordre d'achat.");
        
        Log.Message("Cliquer sur le btn Créer un ordre d'achat.");
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Log.Message("sélectionner 'MutualFunds'");
        SelecteAnOrderType(Get_WinFinancialInstrumentSelector_RdoMutualFunds())

 
        // ********************************************************Étape 7_4*******************************************
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("La Répétition des étapes pour Mutual Funds.Étape 7_4: Créer un ordre d'achat.");
        
        Log.Message("Creation d'ordre"); 
        CreateEditOrder("MF", account,quantityMF,securityMF,securitySymbolMF);
        
        // ********************************************************Étape 7_5*******************************************
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("La Répétition des étapes pour Mutual Funds.Étape 7_5: Valider la creation d'ordre");
        
        //Verification
        if(CheckPresenceOrderInAccumulator(account,quantityMF,securityMF,financialInstrumentMF,typeForDisplayMF,"MF")){
        }
        else{
          Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        }
        
        
        // ********************************************************Étape 9*******************************************
        Log.PopLogFolder();
        logEtape14 = Log.AppendFolder("Étape 9:Valider la suppresion d'un ordre");     
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        SetAutoTimeOut();
        if(Get_OrderAccumulatorGrid().Find("Value",account,10).Exists){
          Log.Error("L'ordre n'a pas été supprimé");
        }else{
          Log.Checkpoint("L'ordre a été supprimé");
        };
        RestoreAutoTimeOut();
              
        //Fermer Croesus
        Terminate_CroesusProcess(); //Fermer Croesus 
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
 
        //(Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess(); //Fermer Croesus 
    }
}


function SelecteAnOrderType(rdo){ 
    Log.Message("sélectionner le type d'ordre");
    rdo.Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
    Get_WinFinancialInstrumentSelector_BtnOK().Click(); 
}

function CreateEditOrder(type, account,quantity,securityDescription,securitySymbol)
 {           
   var security = "";
    //Creation d'ordre 
    //***Emna IHM: Remplacé par la recherche par symbol/security car La recherche par description ne fonctionne pas correctement, 
    //***C'est peut être lié au bug de la recherche par description détecté dernièrement (Pour plus de détails Voir le fichier d'analyse ref90-28-2021-12-49)
    if(securitySymbol == null || securitySymbol == "") {    
      Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
      Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
      security = securityDescription;
    }
    else
      security = securitySymbol;
    
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if(type == "stocks"){
      if (Trim(VarToStr(quantity))!== ""){  
        Get_WinStocksOrderDetail_TxtQuantity().set_Value(quantity);
      }
    }
    
    if(type == "MF"){
      if (Trim(VarToStr(quantity))!== ""){  
        Get_WinMutualFundsOrderDetail_TxtQuantity().set_Value(quantity);
      }
    }
    
    if(type == "FI"){
      if (Trim(VarToStr(quantity))!== ""){  
        Get_WinFixedIncomeOrderDetail_TxtQuantity().set_Value(quantity);
      }
    }
        
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(security))!== ""){  
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
      SetAutoTimeOut();
      if(Get_SubMenus().Exists){
        Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
      }
      RestoreAutoTimeOut();
    }    
    Get_WinOrderDetail_BtnSave().WaitProperty("IsEnabled",true,30000);
    Get_WinOrderDetail_BtnSave().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_66bd", true]);
 }
 
 function CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay,type)
{
  var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
  var found=false;
  for(var i=0;i<count;i++){
    if(VarToString(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber)==VarToString(account))
    {
      if(type=="MF"){
         aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity+"000");
      }else{
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity);
      }      
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "SecurityDesc", cmpEqual,security);
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "FinancialInstrument", cmpEqual,financialInstrument);
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,typeForDisplay);
      found=true;
    }
  }
  return found;
}
