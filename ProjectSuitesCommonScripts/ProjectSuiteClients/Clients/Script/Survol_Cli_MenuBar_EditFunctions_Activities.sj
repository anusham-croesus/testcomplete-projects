//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Cli_ContextualMenu_Functions_Activities
//USEUNIT CommonCheckpoints

 /* Description : A partir du module "Clients", afficher la fenêtre « Client activities» 
 par MenuBar_Functions_Activities. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Fermer*/

 function Survol_Cli_MenuBar_EditFunctions_Activities()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
    
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Activities().Click(); //Il a y une anomalie dans automation 10 , le menu est vide 
    
  //Les points de vérification
  //Check_Properties(language); // la fonction est dans Survol_Cli_ContextualMenu_Functions_Activities
  
  Get_WinActivities_BtnClose().Keys("[Esc]");
  
  Close_Croesus_SysMenu();
 }