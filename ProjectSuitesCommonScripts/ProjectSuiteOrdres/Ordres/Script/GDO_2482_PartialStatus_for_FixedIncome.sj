//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2453_Create_BuyOrder_FixedIncome
//USEUNIT DBA

/* Description :Statut Partiel pour un ordre d`obligation
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2482
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2482_PartialStatus_for_FixedIncome()
 {             
    try{     
        PartialStatus_for_FixedIncome()     
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      Runner.Stop(true); 
    }
 }
 
 function PartialStatus_for_FixedIncome(){
 
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");        
      var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
      var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2482", language+client);
      var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2482", language+client);        
      var quantityFillOrder=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFillOrder_2482", language+client);
      var price=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Price_2482", language+client);
      var indexationFactor=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "IndexationFactor_2482", language+client);
      var yieldANN=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldANN_2482", language+client);
      var yieldSA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldSA_2482", language+client);
      var inventoryCode=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", " InventoryCode_2482", language+client);
      var statusPartialFill= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusPartialFill_2482", language+client); 
      var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2482", language+client);
      var fillStatus=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "fillStatus_2482", language+client);
               
      Login(vServerOrders, user , psw ,language);
      Get_ModulesBar_BtnOrders().Click();
      
      Get_MainWindow().Maximize();
        
      Get_Toolbar_BtnCreateABuyOrder().Click();
        
       //Selectioner 'FixedIncome'
      Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
      Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
      Get_WinFinancialInstrumentSelector_BtnOK().Click();
      
     
      //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre.  
      Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
      Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
        
      //Creation d'ordre 
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");

      Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantity);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
      if(Get_SubMenus().Exists){  
        Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
      }
      Get_WinOrderDetail_BtnVerify().Click();
      //Submit
      Get_WinOrderDetail_BtnVerify().Click();
                
      //Slectioner L’ordre créé
      Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
      Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
        
      var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
      if(date==aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y")){
         Get_OrdersBar_BtnView().Click();
         Get_WinOrderDetail_BtnApprove().Click();
         Get_WinOrderFills_GrpFills_BtnAdd().Click();
                     
         Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFillOrder);
         Get_WinAddOrderFill_TxtClientPrice().Keys(price);
         Get_WinAddOrderFill_TxtIAPrice().Keys(price);
         Get_WinAddOrderFill_TxtIndexationFactor().set_Value(indexationFactor);
         Get_WinAddOrderFill_TxtYieldANN().set_Value(yieldANN);
         Get_WinAddOrderFill_TxtYieldSA().set_Value(yieldSA);
         Get_WinAddOrderFill_CmbInvetoryCode().set_Text(inventoryCode);        
         Get_WinAddOrderFill_BtnOK().Click();
           
         Get_WinOrderFills_BtnSave().Click();    
           
         //Vérifier le changement du statut 
         if(language=="english"){
            Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).Click(); 
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,statusPartialFill);
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity); 
            Log.Message("La colonne Progression est 50% exécuté")
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,fillStatus);
             
         } 
         else{
            Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click(); 
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,statusPartialFill); 
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);
            Log.Message("La colonne Progression est 50% exécuté")
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,fillStatus);   
         } 
      } 
      else{
        Log.Error("L’ordre créé n’a pas été sélectionné ")
      } 
 } 