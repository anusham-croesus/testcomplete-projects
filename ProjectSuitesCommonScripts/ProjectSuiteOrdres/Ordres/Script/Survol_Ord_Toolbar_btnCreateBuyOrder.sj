//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
Vérifier le texte et la présence des contrôles */

function Survol_Ord_Toolbar_btnCreateBuyOrder()
{
    var type="buy"
    
    if (client == "RJ" || client == "BNC" || client == "CIBC" ||  client == "US" || client == "TD" )
    {
      Login(vServerOrders, userName , psw ,language);
      Get_ModulesBar_BtnOrders().Click()
    
      Get_Toolbar_BtnCreateABuyOrder().Click()
  
      Check_Properties_FinancialInstrumentSelector(language,type)// la fonction est dans le Common_functions
    
      Get_WinFinancialInstrumentSelector_BtnCancel().Click()
   
      Close_Croesus_AltF4()
    }
}

