//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AccountsBar_BtnInfo_PW1859


/* Description : Dans le module « Comptes », afficher l'onglet "GP1859" de la fenêtre « Info compte »  par
MenuBar > Edit > Functions > Info > GP1859. Vérifier que l'onglet "GP1859" est bien sélectionné. */

function Survol_Acc_MenuBar_Edit_Functions_Info_PW1859()
{
  if (client == "BNC" || client == "TD" ){
    Login(vServerAccounts, userName, psw, language);
  
    Get_MenuBar_Modules().OpenMenu();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_GoTo().Click();
  
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Functions().Click(); //Il y a un bug : le sous-menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le sous-menu.
    Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().Click();
    Get_MenuBar_Edit_FunctionsForAccounts_Info_PW1859().Click();
  
    Check_WinAccountInfo_TabPW1859_IsSelected();
  
    Get_WinAccountInfo().Close();
  
    Close_Croesus_MenuBar();
  }
}
