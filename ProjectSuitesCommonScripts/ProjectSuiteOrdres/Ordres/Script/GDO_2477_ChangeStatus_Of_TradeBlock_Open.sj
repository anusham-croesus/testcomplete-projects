//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT DBA 

/* Description :Changement de statut d`un block trade en statut Ouvert
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2477
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2477_ChangeStatus_Of_TradeBlock_Open()
 {             
    try{       
        ChangeStatus_Of_TradeBlock_Open();  
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      Runner.Stop(true); 
    }
 }
 
 function ChangeStatus_Of_TradeBlock_Open()
 {
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
      var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
      var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
      var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
      var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
      var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
      var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2477", language+client);
        
      Login(vServerOrders, user ,psw,language);
      Get_ModulesBar_BtnOrders().Click();
        
      //Supprimer des ordres dans accumulateur si existent
      DeleteAllOrdersInAccumulator();  
        
      Get_Toolbar_BtnCreateABuyOrder().Click();
        
      //Selectioner 'Stoks'
      Get_WinFinancialInstrumentSelector_RdoStocks().Click();
      Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
      Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
      //Creation d'ordre 
      CreateEditStocksOrder(account,quantity,security)
        
      //Sélectionner l'ordre créé
      Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
      Get_OrderAccumulator_BtnEdit().Click(); 
        
      //Verifier
      Get_WinOrderDetail_BtnVerify().Click();
      //Submit
      Get_WinOrderDetail_BtnVerify().Click();
        
      //Verification
      var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
      aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,security); 
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);
        
      Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
      Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
        
      Get_OrdersBar_BtnView().Click();
      Get_WinOrderDetail_BtnApprove().Click();
        
      //Vérifier le changement du statut 
      Get_OrderGrid().Find("Value",security,10).Click()
      var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
      aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
      aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 
      //Valider la colonne Progression (ajouté dans la version LU)
      Log.Message("Valider la colonne Progression (ajouté dans la version LU)");
      aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip); 
 } 