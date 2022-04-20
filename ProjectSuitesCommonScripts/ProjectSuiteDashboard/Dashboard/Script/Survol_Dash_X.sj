//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Survol_Dash_AltF4


/*Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Affichage du module avec le titre "Tableau de bord".
Fermeture de l’application avec X*/

function Survol_Dash_X()
{
  Login(vServerDashboard, userName, psw, language);
  
  Get_ModulesBar_BtnDashboard().Click();
  
  Check_Properties(language);
  
  Close_Croesus_X();
}