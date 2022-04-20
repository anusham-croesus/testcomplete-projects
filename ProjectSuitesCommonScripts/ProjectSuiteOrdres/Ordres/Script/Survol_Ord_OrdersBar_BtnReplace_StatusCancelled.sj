//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions



/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre ayant le statut "Cancelled" et cliquer sur le bouton "Replace" de la barre des Ordres.
    Vérifier que la boîte de dialogue Croesus ne s'affiche pas.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnReplace_StatusCancelled()
{
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Get_OrderGrid().Click();
        Search_Order_Symbol("FID224");
        //Get_OrderGrid().Find("Value", "FID224", 1000).Click();
    
	      Log.Message("JIRA: GDO-2262");
        Get_OrdersBar_BtnReplace().Click();
  
        Check_NonExistence_DlgMessage();
   
        Close_Croesus_MenuBar();
    }
}




function Check_NonExistence_DlgMessage()
{
    Delay(200);

    if (Get_DlgInformation().Exists) {
        Log.Error("Croesus dialogbox has appeared ; this is not normal. According to the status of the order, the replacement operation should succeed.");
        var width=Get_DlgInformation().get_ActualWidth()
        var height=Get_DlgInformation().get_ActualHeight()
        Get_DlgInformation().Click(width/2,height-40);
    } else {
        Log.Checkpoint("Croesus dialogbox didn't appear.");
    }

}