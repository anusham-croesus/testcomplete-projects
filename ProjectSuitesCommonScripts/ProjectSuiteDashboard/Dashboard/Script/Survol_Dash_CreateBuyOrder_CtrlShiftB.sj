//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Afficher la fenêtre 
FinancialInstrumentSelector par Ctrl+Shift+B. Vérifier le texte et la présence des contrôles */

function Survol_Dash_CreateBuyOrder_CtrlShiftB()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
  {
    var type="buy";
    
    Login(vServerDashboard, userName, psw, language);
    Get_ModulesBar_BtnDashboard().Click();
    
    Get_MainWindow().Keys("^B");
    
    Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
    
    Get_WinFinancialInstrumentSelector().Close();
    
    Close_Croesus_MenuBar();
  }
}
