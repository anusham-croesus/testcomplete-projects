//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Tableau de bord ». Afficher le menu contextuel en cliquant sur ToolBar-btnInternet. Vérifier la présence des contrôles dans le menu */
 
function Survol_Dash_ToolBar_btnInternet()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_Toolbar_BtnInternetAddresses().Click();
  
  //Check_ToolBarInternet_Properties();
  
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
}