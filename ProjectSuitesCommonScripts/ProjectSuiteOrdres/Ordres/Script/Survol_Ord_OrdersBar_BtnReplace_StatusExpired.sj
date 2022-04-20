﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT Survol_Ord_OrdersBar_BtnReplace_StatusCancelled


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre ayant le statut "Expired" et cliquer sur le bouton "Replace" de la barre des Ordres.
    Vérifier que la boîte de dialogue Croesus ne s'affiche pas.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnReplace_StatusExpired()
{
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Get_OrderGrid().Click();
        Search_Order_Symbol("FID227");
        Get_OrderGrid().Find("Value", "FID227", 1000).Click();
    
	      Log.Message("JIRA: GDO-2262");
        Get_OrdersBar_BtnReplace().Click();
  
        Check_NonExistence_DlgMessage(); //La fonction se trouve dans Survol_Ord_OrdersBar_BtnReplace_StatusCancelled
   
        Close_Croesus_MenuBar();
    }
}