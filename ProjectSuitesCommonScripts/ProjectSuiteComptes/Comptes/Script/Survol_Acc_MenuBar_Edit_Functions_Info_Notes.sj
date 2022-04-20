//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AccountsBar_BtnInfo_Notes

/* Description : Dans le module « Comptes », afficher l'onglet "Notes" de la fenêtre « Info compte » 
MenuBar > Edit > Functions > Info > Notes. Vérifier que l'onglet "Notes" est bien sélectionné. */

function Survol_Acc_MenuBar_Edit_Functions_Info_Notes()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_GoTo().Click();
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click(); //Il y a un bug : le sous-menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le sous-menu.
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info_Notes().Click();
  
  Check_WinAccountInfo_TabNotes_IsSelected();
  
  Get_WinAccountInfo().Close();
  
  Close_Croesus_MenuBar();
}