//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Cli_MenuBar_EditSearch

 /* Description : A partir du module « Clients » , afficher la fenêtre « Rechercher » en cliquant sur Toolbar - btnSearch. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Cli_ToolBar_btnSearch()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
 
  //afficher la fenêtre « Rechercher » en cliquant sur Toolbar - btnSearch
  Get_Toolbar_BtnSearch().Click();
    
  //Les points de vérification 
  //Check_Properties(language) // la fonction est dans le script Survol_Cli_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();
 }