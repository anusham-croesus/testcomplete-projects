//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Afficher la fenêtre FinancialInstrumentSelector
 en cliquant sur le bouton Toolbar-btnCreateBuyOrder. Vérifier le texte et la présence des contrôles */

function Survol_Dash_Toolbar_btnCreateSellOrder()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
  {
    var type="sell";
    
    Login(vServerDashboard, userName, psw, language);
    Get_ModulesBar_BtnDashboard().Click();
    
    Get_Toolbar_BtnCreateASellOrder().Click();
  
    //Check_Properties_FinancialInstrumentSelector(language,type); // la fonction est dans le Common_functions
    
    Get_WinFinancialInstrumentSelector_BtnCancel().Click();
   
    Close_Croesus_AltF4();
  }
}
