//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Ord_Toolbar_btnCreateBuyOrder


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.Afficher la fenêtre «Orders Module » par clique droite - btnCreateBuyOrder
Vérifier le texte et la présence des contrôles */

function Survol_Ord_btnCreateBuyOrder_ClickR()
{
    var type="buy";
    
    if (client == "RJ" || client == "BNC" || client == "CIBC" || client == "US" || client == "TD" )
    {
      Login(vServerOrders, userName , psw ,language);
      Get_ModulesBar_BtnOrders().Click();
    
      Get_OrderGrid().ClickR();
      Get_OrderGrid_ContextualMenu_CreateABuyOrder().Click();
  
      Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
    
      Get_WinFinancialInstrumentSelector().Close();
   
      Close_Croesus_X();
    }
}

