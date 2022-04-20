//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Ajout d`un ordre de vente
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2455
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2455_Create_SellOrder_Stocks()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2455", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2455", language+client);
        var typeForDisplay=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2455", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentStocks_2453", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
       //Creation d'ordre 
        CreateEditStocksOrder(account,quantity,security)
        
        //Verification
        if(CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,typeForDisplay)){
               //Remettre les données 
            Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
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