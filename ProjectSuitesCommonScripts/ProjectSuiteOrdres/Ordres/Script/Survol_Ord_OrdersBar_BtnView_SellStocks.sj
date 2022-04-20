﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre de vente d'actions et l'afficher avec le bouton "View" de la barre des Ordres.
    Vérifier le texte et la présence des contrôles.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnView_SellStocks()
{
    var type = "stocks";
    var module = "orders";
    var order = "sell";
    var calledFrom = "View";
    var orderStatus = "TraderApproval";
    var currency = "USD"
    
    if(client == "RJ" || client == "BNC" ||client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Search_Order_Symbol("MSFT");
    
        Get_OrdersBar_BtnView().Click();
  
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus,currency);// la fonction est dans CommonCheckpoints
    
        Get_WinOrderDetail_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    }
}