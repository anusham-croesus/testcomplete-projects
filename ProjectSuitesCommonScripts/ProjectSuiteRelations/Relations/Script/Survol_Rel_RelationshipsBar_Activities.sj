//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module "Relationship", afficher la fenêtre « Relationship activities» 
par AccountsBar_Activities. Vérifier la présence des contrôles et des étiquettes.*/

function Survol_Rel_RelationshipsBar_Activities()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
  
  //Les points de vérification
  //Check_Properties_WinActivities(language);
  
  Get_WinActivities().Close();
  
  Close_Croesus_X();
}