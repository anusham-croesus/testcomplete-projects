//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Gestionnaire de restrictions » 
en cliquant sur AccountsBar_Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_AccountsBar_Restrictions()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsAccountsBar_BtnRestrictions().Click();
  
  Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_AltF4();
}