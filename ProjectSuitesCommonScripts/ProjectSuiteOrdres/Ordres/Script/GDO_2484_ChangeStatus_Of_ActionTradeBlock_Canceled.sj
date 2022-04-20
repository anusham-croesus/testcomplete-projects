//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2477_ChangeStatus_Of_TradeBlock_Open
//USEUNIT DBA 

/* Description :Changement de statut d`un block trade en statut Ouvert
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2477
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2484_ChangeStatus_Of_ActionTradeBlock_Canceled()
 {             
    try{    
       var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
       var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
       var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
       var statusCancelled=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusCancelled_2484", language+client);  
         
       ChangeStatus_Of_TradeBlock_Open(); //Le script GDO_2477 
       
       Get_OrdersBar_BtnCXL().Click();        
       //Cancel order
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       
       //Vérifier le changement du statut 
       if(language=="english"){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).Click(); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "Status", cmpEqual,statusCancelled);
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity); 
       } 
       else{
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).Click(); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "Status", cmpEqual,statusCancelled); 
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
          aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"),10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity); 
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