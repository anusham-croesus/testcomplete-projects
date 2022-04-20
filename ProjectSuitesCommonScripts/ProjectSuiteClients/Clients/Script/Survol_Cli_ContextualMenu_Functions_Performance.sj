//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module "Clients",Afficher la fenêtre « Perfomance» pour le client qui est sélectionné par default (800300)
 par ContextualMenu_Functions_Perfomance. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Fermer*/

 function Survol_Cli_ContextualMenu_Functions_Performance()
 {
  var module="clients";
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
  WaitObject(Get_CroesusApp(), "Uid","CRMDataGrid_3071", true); 
  Get_RelationshipsClientsAccountsBar().Click();
  Get_MainWindow().Keys("[Apps]");
  WaitObject(Get_SubMenus(), "VisibleOnScreen", true);
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Performance().Click();
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_Performance_French(module)} //la fonction est dans CommonCheckpoints
  //Les points de vérification en anglais 
  //else {Check_Properties_Performance_English(module)} //la fonction est dans CommonCheckpoints
  //Les points de vérification
  //Check_Performance_Existence_Of_Controls(module) //la fonction est dans CommonCheckpoints
  
  Get_WinPerformance_BtnClose().Click();
  
  Close_Croesus_X();
 }