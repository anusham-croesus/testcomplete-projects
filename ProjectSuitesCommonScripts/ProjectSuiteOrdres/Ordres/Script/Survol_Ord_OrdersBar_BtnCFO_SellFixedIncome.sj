//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre de vente de revenu fixe et l'afficher avec le bouton "CFO" de la barre des Ordres.
    Vérifier le texte et la présence des contrôles.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnCFO_SellFixedIncome()
{
    var type = "fixedIncome";
    var module = "orders";
    var order = "sell";
    var calledFrom = "CFO";
    var orderStatus = "PartialFill";
    
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Search_Order_Symbol("B03774");
    
        Get_OrdersBar_BtnCFO().Click();
  
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
        Get_WinOrderDetail_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    }
}