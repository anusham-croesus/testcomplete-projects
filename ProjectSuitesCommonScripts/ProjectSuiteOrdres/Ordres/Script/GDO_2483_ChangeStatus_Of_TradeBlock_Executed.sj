//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2453_Create_BuyOrder_FixedIncome
//USEUNIT DBA
//USEUNIT GDO_2482_PartialStatus_for_FixedIncome

/* Description :Changement de statut d`un block trade en statut Exécuté
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2483
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2483_ChangeStatus_Of_TradeBlock_Executed()
 {             
    try{      
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");        
      var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2482", language+client);
      var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2482", language+client);        
      var quantityFillOrder=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFillOrder_2482", language+client);
      var price=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Price_2482", language+client);
      var indexationFactor=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "IndexationFactor_2482", language+client);
      var yieldANN=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldANN_2482", language+client);
      var yieldSA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldSA_2482", language+client);
      var inventoryCode=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", " InventoryCode_2482", language+client);
      var StatusExecuted= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusExecuted_2483", language+client);
      var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2483", language+client);
           
      PartialStatus_for_FixedIncome();// Le script GDO_2482
      
      Get_MainWindow().Maximize();
      
      //Ajouter des exécutions jusqu`à ce que la quantité restante du block trade soit égale à zéro(0)
      if(language=="english"){
        Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).Click();        
      } else{
        Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click();
      } 
      
      Get_OrdersBar_BtnFills().Click();

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
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,StatusExecuted);
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);
          Log.Message("Vérifier la colonne Progression  (ajoutée dans la version LU)");  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);    
       } 
       else{
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click(); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,StatusExecuted); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
          Log.Message("Vérifier la colonne Progression  (ajoutée dans la version LU)");
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip); 
       } 
              
             
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