//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Relationship », afficher la fenêtre « Gestionnaire de restrictions » 
par MenuBar > Edit > Functions > Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Rel_MenuBar_EditFunctions_Restrictions()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndAccounts_Restrictions().Click(); //Il y a un bug : le menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le menu.
  
  //Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_AltF4();
}