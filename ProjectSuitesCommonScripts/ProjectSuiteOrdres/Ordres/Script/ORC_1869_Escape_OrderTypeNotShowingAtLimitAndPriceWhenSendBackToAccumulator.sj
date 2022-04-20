//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Escape client TD
https://jira.croesus.com/browse/ORC-1869
 
Analyste d'assurance qualité: Taous.A
Analyste d'automatisation: Abdel.M
Date : 21/04/2021
Version de scriptage: 90.24.2021.04-38 */ 

 
 function ORC_1869_Escape_OrderTypeNotShowingAtLimitAndPriceWhenSendBackToAccumulator()
 {             
    try{  
        //liens vers les stories
        Log.Link("https://jira.croesus.com/browse/TCVE-4860", "lien vers la story");
        Log.Link("https://jira.croesus.com/browse/ORC-2075", "lien vers le cas de test");
        Log.Link("https://jira.croesus.com/browse/ORC-1869", "lien vers le jira");
        
        //Declaration des Variables
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account800001NA = "800001-NA"
        var quantity1 = 10
        var security = "MICROSOFT CORP"
        var atMarketType = "Au marché"//"At market"
        var limitType = "Cours limite"//"Limit
        var quantity2 = 20
        var price = 15
        var cancelNote = "??A|C(P)"
        var expiredNote = "??A;E"
        var rejectedNote = "??A(4)"
        var statusCancel = "Cancelled"
        var statusExpired = "Expired"
        var statusRejected = "Rejected"
        
          
        // ********************************************************Étape 1*******************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à Croesus et accéder au module Ordres");
        
        Log.Message("Se connecter à croesus avec KEYNEJ");
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
                
        // ********************************************************Étape 2*******************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Créer un ordre d'achat de type Action");
        
        Get_ModulesBar_BtnOrders().Click(); 
        
        //Creation d'ordres       
        Log.Message("Créer un ordre d'achat de type Action de type Au marché");
        CreateStocksOrder(account800001NA,quantity1,security,atMarketType,price, cancelNote);
        
        Log.Message("Créer un ordre d'achat de type Action de type Cours limite");
        CreateStocksOrder(account800001NA,quantity2,security,limitType,price, cancelNote);
        
        Log.Message("Soumettre les ordres vers le Blotter");
        VerifyAndSubmit(quantity1);
        VerifyAndSubmit(quantity2);
        
        //Annuler les ordres en cliquant sur annuler un ordre
        
        //Valider que l'état des ordres est annulé
        Log.Message("Valider que l'état des ordres est annulé");
        var count = Get_OrderGrid().RecordListControl.Items.Count;
        for (i=0;i<count;i++){
          if (Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity1
              && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.PriceStr == atMarketType)
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statusCancel);
        }
        
        
        
       
        
        
        
    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
      // ********************************************************Étape 4*******************************************
      Log.PopLogFolder();
      logEtape4 = Log.AppendFolder("Étape 4: Se déconnecter de Croesus");
        
//      Terminate_CroesusProcess(); //Fermer Croesus
    }
 }
 
 function Get_WinStocksOrderDetail_CmbOrderType(){return Get_WinOrderDetail().FindChild("Uid", "ComboBox_9fdb", 10)} //ok

 function VerifyAndSubmit(order){
      Get_OrderAccumulatorGrid().Find("Value",order,10).Click();
      Get_OrderAccumulator_BtnVerify().Click();
      //Côcher la cas Inclure + Soumettre
      if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
      Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
      WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
      Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
      Get_WinAccumulator_BtnSubmit().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
      WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BatchOrderVerificationWindow_342c", true]);
        
 }
 
 
 function CreateStocksOrder(account,quantity,security,type,price,note)
 {                
    Log.Message("Créer un ordre d'achat de type Action");
    Get_Toolbar_BtnCreateABuyOrder().Click();
        
    //Selectioner 'Stoks'
    Get_WinFinancialInstrumentSelector_RdoStocks().Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
   
   //Creation d'ordre 
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
    
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if (Trim(VarToStr(quantity))!== ""){  
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
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
    if (type == "Cours limite"){
        Get_WinStocksOrderDetail_CmbOrderType().Click();
        Get_SubMenus().FindChild("WPFControlText",type,10).Click();
        Get_WinStocksOrderDetail_TxtPriceLimit().Keys(price);
    }
    Get_WinOrderDetail_TabNotes().Click();
      Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Clear();
      Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Keys(note);
         
    Get_WinOrderDetail_BtnSave().Click();
 }
 
 function EditNote(note){
      Get_WinOrderDetail_TabNotes().Click();
      Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Clear();
      Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Keys(note);
 }
