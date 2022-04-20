//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre de vente d'actions et l'afficher avec le bouton "CFO" de la barre des Ordres.
    Vérifier le texte et la présence des contrôles.
    @author : christophe.paring@croesus.com
*/

/*Avec l'utilisateur REAGAR, des composants sont actifs alors qu'ils ne devraient pas l'être ; anomalie en cours de validation avec Mamoudou*/

function Survol_Ord_OrdersBar_BtnCFO_SellStocks()
{
    var type = "stocks";
    var module = "orders";
    var order = "sell";
    var calledFrom = "CFO";
    var orderStatus = "Open";
    
    if(client == "RJ" || client == "BNC" ||client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Search_Order_Symbol("TD");
    
        Get_OrdersBar_BtnCFO().Click();
  
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
        Get_WinOrderDetail_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    }
}