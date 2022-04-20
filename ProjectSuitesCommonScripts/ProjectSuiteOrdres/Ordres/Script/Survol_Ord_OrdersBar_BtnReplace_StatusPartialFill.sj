//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT Survol_Ord_OrdersBar_BtnReplace_StatusOpen


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre ayant le statut "Partial Fill" et cliquer sur le bouton "Replace" de la barre des Ordres.
    Vérifier que la boîte de dialogue Croesus s'affiche avec le message disant qu'il n'est pas possible d'exécuter l'opération correspondant au statut de l'ordre.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnReplace_StatusPartialFill()
{
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Get_OrderGrid().Click();
        Search_Order_Symbol("B03774");
        
        Get_OrderGrid().Find("Value","B03774",1000).Click();
    
        Get_OrdersBar_BtnReplace().Click();
  
        Check_Existence_DlgMessage(); //La fonction se trouve dans Survol_Ord_OrdersBar_BtnReplace_StatusOpen
   
        Close_Croesus_MenuBar();
    }
}
