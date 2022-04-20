//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Comptes » , afficher la fenêtre « Ajouter un filtre »
en cliquant sur Toolbar - BtnQuickFilters. Vérifier la présence des contrôles et des étiquettes */
 
function Survol_Acc_ToolBar_BtnQuickFilters_AddFilter()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  //afficher la fenêtre « Ajouter un filtre » en cliquant sur Toolbar - BtnQuickFilters
  Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
  
  //Les points de vérification 
  //Check_AddFilterForRelationshipsClientsAccounts_Properties(language);//la fonction est dans CommonCheckpoints
  
  Get_WinCRUFilter_BtnCancel().Click();
  
  Close_Croesus_X();
}
