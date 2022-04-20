//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Relationships », afficher la fenêtre « Restrictions Manager » 
en cliquant sur RelationshipsBar_Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Rel_RelationshipsBar_Restrictions()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_RelationshipsAccountsBar_BtnRestrictions().Click();
  
  //Les points des vérifications   
  //Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_AltF4();
}