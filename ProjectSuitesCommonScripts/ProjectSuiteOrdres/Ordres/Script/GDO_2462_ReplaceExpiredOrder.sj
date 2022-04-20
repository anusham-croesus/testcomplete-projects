//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2464_Split_Of_BlockTrade

/* Description :Modifier un ordre
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2462
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 

function GDO_2462_ReplaceExpiredOrder(){

  var ordersStatus=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersStatusExpired", language+client);
  GDO_ReplaceOrder(ordersStatus)  
}
 
 function GDO_ReplaceOrder(ordersStatus)
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Delay(1000);
        DeleteAllOrdersInAccumulator(); 
        
        Get_OrderGrid().Find("Value",ordersStatus,10).Click();
        var account= Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.AccountNumber;
        var quantity= Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.Quantity - Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.ExecQuantity
        var security= Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.SecurityDesc;
        var financialInstrument=Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.FinancialInstrument;
        var typeForDisplay= Get_OrderGrid().Find("Value",ordersStatus,10).DataContext.DataItem.TypeForDisplay;
        Log.Message("JIRA: GDO-2262");
        Get_OrdersBar_BtnReplace().Click();
                
         //Verification
        if(CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay)){
            Delay(1500);
           //Remettre les données 
            Get_OrderAccumulatorGrid().Find("Value",VarToString(account),10).Click();
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        else{
          Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        }
                    
        Close_Croesus_MenuBar();
         
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
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }