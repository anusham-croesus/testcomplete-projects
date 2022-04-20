//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT Survol_Ord_OrdersBar_BtnFills_BuyBond


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre de vente d'obligation et cliquer sur le bouton "Exécutions" de la barre des Ordres.
    Vérifier les textes et la présence des contrôles de la fenêtre Exécutions.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnFills_SellBond()
{
    var type = "bond";
    var order = "sell";
    var securityDescription = GetData(filePath_Orders, "Order_Fills", 70, language);
    
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Search_Order_Symbol("B03774");
    
        Get_OrdersBar_BtnFills().Click();
  
        Check_Properties_OrderFills(language, type, order, securityDescription);// la fonction est dans Survol_Ord_OrdersBar_BtnFills_BuyBond
    
        Get_WinOrderFills_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    
}