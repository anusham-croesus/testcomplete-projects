//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Survol_Dash_AltF4


/*Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Affichage du module avec le titre "Tableau de bord".
Fermêture de l’application par SysClose*/

function Survol_Dash_SysClose()
{
  Login(vServerDashboard, userName, psw, language);
  
  Get_ModulesBar_BtnDashboard().Click();
  
  Check_Properties(language);
  
  Close_Croesus_SysMenu();
}