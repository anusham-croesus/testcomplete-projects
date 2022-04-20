//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Relationships », afficher la fenêtre « Gestionnaire de restrictions » 
par Menu Contextuel > Fonctions > Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Rel_ContextualMenu_Functions_Restrictions()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
 // Get_RelationshipsClientsAccountsGrid().ClickR();
  Get_RelationshipsClientsAccountsGrid().Keys("[Apps]");
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsAccountsGrid_ContextualMenu_Functions_Restrictions().Click();
  
  Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_X();
}
