//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Cli_MenuBar_EditSearch

 /* Description : A partir du module « Clients » , afficher la fenêtre « Rechercher » par le touche de clavier . 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Cli_Search_KeyboardSearch()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
  WaitObject(Get_CroesusApp(), "Uid","CRMDataGrid_3071", true); 
  Get_RelationshipsClientsAccountsBar().Click();

  //afficher la fenêtre « Rechercher »
  Get_MainWindow().Keys("F");
  
  //Les points de vérification 
  //Check_Properties(language) // la fonction est dans le script Survol_Cli_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Click();
  
  Close_Croesus_AltF4();
 }