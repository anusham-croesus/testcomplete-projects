//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module "Comptes", afficher la fenêtre « Account activities» 
par ContextualMenu_Functions_Activities. Vérifier la présence des contrôles et des étiquettes.
Fermer la fenêtre en cliquant sur le btn Fermer. */

function Survol_Acc_ContextualMenu_Functions_Activities()
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
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Activities().Click();
  
  //Les points de vérification
  //Check_Properties_WinActivities(language);
  
  Get_WinActivities_BtnClose().Click();
  
  Close_Croesus_AltQ();
}