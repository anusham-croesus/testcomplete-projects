//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AccountsBar_Alarms
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Alarmes pour le compte » 
par Menu contextuel > Fonctions > Alarmes. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_ContextualMenu_Functions_Alarms()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsClientsAccountsGrid().ClickR();
  //Get_RelationshipsClientsAccountsGrid().ClickR();
 
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_AccountsGrid_ContextualMenu_Functions_Alarms().Click();
  
  //Check_Properties_WinAlarmsForAccount(language);
  
  Get_WinAlarmsForAccount_BtnCancel().Click();
  
  Close_Croesus_X();
}
