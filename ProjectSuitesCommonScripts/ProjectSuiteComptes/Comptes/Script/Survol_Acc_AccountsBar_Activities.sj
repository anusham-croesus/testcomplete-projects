//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module "Comptes", afficher la fenêtre « Account activities» 
par AccountsBar_Activities. Vérifier la présence des contrôles et des étiquettes.
Fermer la fenêtre en cliquant sur le btn Fermer. */

function Survol_Acc_AccountsBar_Activities()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
  
  //Les points de vérification
  Check_Properties_WinActivities(language);
  
  Get_WinActivities().Close();
  
  Close_Croesus_X();
}
