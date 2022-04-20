//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Tableau de bord ». Afficher le menu Internet en cliquant sur MenuBar-Tools_Internet. Vérifier la présence des contrôles dans le menu */
 
function Survol_Dash_MenuBar_Tools_Internet()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_InternetAdresses().Click();
  
  Check_MenuBarToolsInternet_Properties();
  
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
}