//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Cli_ContextualMenu_Functions_Activities

 /* Description : A partir du module "Clients", afficher la fenêtre « Client activities» 
 par ClientsBar_Activities. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Fermer*/

 function Survol_Cli_ClientsBar_Activities()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
    
  Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
    
  //Les points de vérification
  //Check_Properties(language); // la fonction est dans Survol_Cli_ContextualMenu_Functions_Activities
  
  Get_WinActivities().Close();
  
  Close_Croesus_X();
 }
 
