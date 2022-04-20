//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Gestionnaire de restrictions » 
par Menu Contextuel > Fonctions > Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_ContextualMenu_Functions_Restrictions()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsClientsAccountsGrid().ClickR();
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_RelationshipsClientsAccountsGrid().ClickR();
    numberOftries++;
  }
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsAccountsGrid_ContextualMenu_Functions_Restrictions().Click();
  
  //Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_X();
}
