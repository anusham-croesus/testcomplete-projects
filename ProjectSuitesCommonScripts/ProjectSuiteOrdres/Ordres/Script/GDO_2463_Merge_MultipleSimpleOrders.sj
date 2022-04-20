//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2453_Create_BuyOrder_FixedIncome
//USEUNIT GDO_2453_Create_BuyOrder_MutualFunds
//USEUNIT GDO_2464_Split_Of_BlockTrade


/* Description :Fusion de plusieurs ordres simples en bloc de type action, Obligation
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2463
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2463_Merge_MultipleSimpleOrders()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2453", language+client);        
        var quantityMutualFunds=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityMutualFunds_2455", language+client);
        var securityMutualFunds= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityMutualFunds_2455", language+client);        
        var securitySellMutualFunds= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2463", language+client);         
        var type=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);          
          
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator(); 
        
        //Creation d'ordre 
        Get_Toolbar_BtnCreateABuyOrder().Click();        
        //Selectioner 'FixedIncome'
        Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        CreateEditFixedIncomeOrder(account,quantity,security)
        
        //Creation d'ordre
        Get_Toolbar_BtnCreateABuyOrder().Click();        
        //Selectioner 'MutualFunds'
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();     
        CreateEditMutualFundsOrder(account,quantityMutualFunds,securityMutualFunds)
        
        //Creation d'ordre 
        Get_Toolbar_BtnCreateASellOrder().Click();   
         //Selectioner 'FixedIncome'
        Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        CreateEditFixedIncomeOrder(account,quantity,security)
        
        //Creation d'ordre 
        Get_Toolbar_BtnCreateASellOrder().Click();       
        //Selectioner 'MutualFunds'
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();               
        //Creation d'ordre 
        CreateEditMutualFundsOrder(account,quantity,securitySellMutualFunds)
        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_66bd");
       Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
         
        //Selectioner 2 ordres du meme type mais titres different
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count   
        for (var i = 0; i < count; i++){
           if(VarToString(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.TypeForDisplay)==type){
                Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsSelected(true);
                Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsActive(true);
           }            
        } 
        
        //Validation du bouton 'Merge'
        aqObject.CheckProperty(Get_OrderAccumulator_BtnMerge(), "IsEnabled", cmpEqual,false);    
        
        //Selectionner les ordres et cliquer sur le bouton 'merge'
        Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
        
        //Validation du bouton 'Merge'
        aqObject.CheckProperty(Get_OrderAccumulator_BtnMerge(), "IsEnabled", cmpEqual,false);//2020.3.147 Le bouton devrait etre grisé GDO-2594 YR///valeur avant 'true' changé par A.A 90.15.2020.3-84  //Selon krima,  il faut adapter car ce bouton fusionner va toujours etre débloqué
        
        //Remettre les données 
        DeleteAllOrdersInAccumulator(); 
                  
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
      Runner.Stop(true); 
    }
 }