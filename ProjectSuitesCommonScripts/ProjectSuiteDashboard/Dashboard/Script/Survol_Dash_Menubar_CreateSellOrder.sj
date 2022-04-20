//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Afficher la fenêtre FinancialInstrumentSelector
en cliquant sur le MenuBar-OrderEntryModule-CreateSellOrder. Vérifier le texte et la présence des contrôles */

function Survol_Dash_Menubar_CreateSellOrder()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
  {
    var type="sell";
    
    Login(vServerDashboard, userName, psw, language);
    Get_ModulesBar_BtnDashboard().Click();
    
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
    Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
  
    //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
    
    Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
   
    Close_Croesus_AltQ();
  }
}
