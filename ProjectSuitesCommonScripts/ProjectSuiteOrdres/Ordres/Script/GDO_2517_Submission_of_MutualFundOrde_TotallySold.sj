//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT DBA

/* Description :Soumission d`un ordre de fonds mutuel vendu en totalité(Jira CROES-545)
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2517
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2517_Submission_of_MutualFundOrde_TotallySold()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2461", language+client);        
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2517", language+client);
        var itemQuantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItemQuantity_2517", language+client);
        var typeOrder = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2455", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_2517", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        
        Search_SecurityBySymbol(securitySymbol);
        
        Get_SecurityGrid().Find("Value",securitySymbol,10).Click();
        Drag(Get_SecurityGrid().Find("Value",securitySymbol,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Portfolio_PositionsGrid().Find("Value",account,10).Click();
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        Get_WinMutualFundsOrderDetail_CmbQuantityType().Click();
        Aliases.CroesusApp.subMenus.Find("WPFControlText",itemQuantity,10).Click();
        
        Get_WinOrderDetail_BtnVerify().Click();
        //Submit
        Get_WinOrderDetail_BtnVerify().Click();
        
        //Verification
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "TypeForDisplay", cmpEqual,typeOrder);    
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);

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
 
