//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2462_ReplaceExpiredOrder



/* Description :Modifier un ordre
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2462
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 

function GDO_2462_ReplaceCancelledOrder(){

  var ordersStatus=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersStatusCancelled", language+client);
  GDO_ReplaceOrder(ordersStatus) 
   
}