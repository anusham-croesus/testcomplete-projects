//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_FixedIncome


/* Description :Modifier un ordre
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2492
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2492_Edit_SellOrderFixedIncome()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2453", language+client);
        var typeForDisplay=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2455", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentBond_2453", language+client);
        
        var accountEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2492", language+client);
        var securityEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2492", language+client);
        var quantityEdit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFixedIncome_2492", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
         Get_Toolbar_BtnCreateASellOrder().Click();
        
         //Selectioner 'FixedIncome'
        Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click()        
       //Creation d'ordre 
        CreateEditFixedIncomeOrder(account,quantity,security)
          
        //Modification d'ordre                              
        Get_OrderAccumulatorGrid().Find("Value",account,10).DblClick();
        CreateEditFixedIncomeOrder(accountEdit,quantityEdit,securityEdit) 
        
        
        //Verification
        if(CheckPresenceOrderInAccumulator(accountEdit,quantityEdit,securityEdit,financialInstrument,typeForDisplay)){
               //Remettre les données 
            Get_OrderAccumulatorGrid().Find("Value",accountEdit,10).Click();
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        else{
          Log.Error("Un ordre n'a pas été modifié")
        }
               
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        if(CheckPresenceOrderInAccumulator(accountEdit,quantityEdit,securityEdit)){
             //Remettre les données 
            Get_OrderAccumulatorGrid().Find("Value",accountEdit,10).Click();
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }