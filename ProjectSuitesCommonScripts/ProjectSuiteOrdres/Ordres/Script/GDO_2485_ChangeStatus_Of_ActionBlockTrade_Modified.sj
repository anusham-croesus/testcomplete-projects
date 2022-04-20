//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2477_ChangeStatus_Of_TradeBlock_Open
//USEUNIT DBA 

/* Description :Changement de statut d`un block trade Action en statut Modifié
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2485
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2485_ChangeStatus_Of_ActionBlockTrade_Modified()
 {             
    try{  
       var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
       var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
       var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
       var statusModified=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusModified_2485", language+client);  
       var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client); 
       var modifiedQuantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ModifiedQuantity_2485", language+client);
       var modified=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2485", language+client);
       var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
       
       ChangeStatus_Of_TradeBlock_Open(); //Le script GDO_2477 
       
       Get_MainWindow().Maximize();
       
       Get_OrdersBar_BtnCFO().Click(); 
        
       Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Find("Value",account,10).Click();
       Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click();
            
       Get_WinEditQuantity_TxtRequestedQuantity().Keys(modifiedQuantity);
       Get_WinEditQuantity_BtnOK().Click();
       
       //Verify
       Get_WinOrderDetail_BtnVerify().Click();
       //Submit
       Get_WinOrderDetail_BtnVerify().Click();
       
       if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", "Status_2485",10)){
           //Vérifier le changement du statut 
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,statusModified);
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);
       }
       else{
         Log.Error("L’ordre active n’est pas bon ")
       } 
       
       //Valider que il y a Deuxieme ordre  
       if(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10)){
           //Vérifier le changement du statut 
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).DataContext.DataItem, "Status", cmpEqual,statusOpen);
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,modifiedQuantity);
       }
       else{
         Log.Error("Le deuxiem ordre n’est pas present")
       }
             
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