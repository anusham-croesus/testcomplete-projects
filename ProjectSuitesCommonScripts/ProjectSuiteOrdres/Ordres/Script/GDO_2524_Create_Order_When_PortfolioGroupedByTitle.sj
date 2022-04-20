//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade

/* Description :Création d'un ordre simple lorsque le portefeuille est groupé par titre (JIRA: CROES-1491)
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2524
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2524_Create_Order_When_PortfolioGroupedByTitle()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolRY_2517", language+client);        
        var clientNo=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ClientNo_2517", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        Search_Client(clientNo);
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,10), Get_ModulesBar_BtnPortfolio());
        
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().Click();
        
        Search_Security(securitySymbol)
                
        Get_Portfolio_PositionsGrid().Find("Value",securitySymbol,10).Click();
        Get_Toolbar_BtnCreateASellOrder().Click();
                
        Get_WinOrderDetail_BtnSave().Click();
        
        //Verification
        var date= aqConvert.DateTimeToFormatStr(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        
        //Remettre les données 
        DeleteAllOrdersInAccumulator()      
        Close_Croesus_MenuBar();         
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        //Remettre les données 
        DeleteAllOrdersInAccumulator()      
        Close_Croesus_MenuBar();
    
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }