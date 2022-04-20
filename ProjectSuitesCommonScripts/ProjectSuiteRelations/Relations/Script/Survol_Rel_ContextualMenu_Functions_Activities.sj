//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module "Relationship", afficher la fenêtre « Account activities» 
par ContextualMenu_Functions_Activities. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Rel_ContextualMenu_Functions_Activities()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_RelationshipsClientsAccountsGrid().ClickR();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Activities().Click();
  
  //Les points de vérification
  Check_Properties_WinActivities(language);
  
  Get_WinActivities_BtnClose().Click();
  
  Close_Croesus_AltQ();
}