//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Modifier un ordre
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2494
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2494_ViewOrder()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var ordersDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersDescription_2494", language+client);
        var winTitle=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailTitle", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        Get_OrderGrid().Find("Value",ordersDescription,10).Click();
        Get_OrdersBar_BtnView().Click();
        aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains,winTitle);
        Get_WinOrderDetail_BtnCancel().Click();
                     
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }