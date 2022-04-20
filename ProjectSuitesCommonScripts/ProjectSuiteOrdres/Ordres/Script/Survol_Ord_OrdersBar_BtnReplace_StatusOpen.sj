//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions



/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre ayant le statut "Open" et cliquer sur le bouton "Replace" de la barre des Ordres.
    Vérifier que la boîte de dialogue Croesus s'affiche avec le message disant qu'il n'est pas possible d'exécuter l'opération correspondant au statut de l'ordre.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnReplace_StatusOpen()
{
    if(client == "RJ" || client == "BNC" ||client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Get_OrderGrid().Click();
        Search_Order_Symbol("RY");
    
        Get_OrderGrid().Find("Value","RY",1000).Click();
        
        Get_OrdersBar_BtnReplace().Click();
  
        Check_Existence_DlgMessage();
   
        Close_Croesus_MenuBar();
    }
}




function Check_Existence_DlgMessage()
{
    Delay(200);

    if (Get_DlgInformation().Exists) {
        Log.Checkpoint("Croesus dialogbox has appeared.");
        aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Orders, "Order_replace", 2, language));
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Orders, "Order_replace", 3, language));
        var width=Get_DlgInformation().get_ActualWidth()
        var height=Get_DlgInformation().get_ActualHeight()
        Get_DlgInformation().Click(width/2,height-47);
    } else {
        Log.Error("Croesus dialogbox didn't appear.");
    }

}