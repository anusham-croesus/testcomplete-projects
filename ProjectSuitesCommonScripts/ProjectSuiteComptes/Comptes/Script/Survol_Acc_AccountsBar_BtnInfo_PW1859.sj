//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions


/* Description : Dans le module « Comptes », afficher l'onglet "GP1859" de la fenêtre « Info compte » 
en cliquant sur AccountBar_Info > GP1859. Vérifier que l'onglet "GP1859" est bien sélectionné. */

function Survol_Acc_AccountsBar_BtnInfo_PW1859()
{
  if (client == "BNC" || client == "TD" ){
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
  
    Get_AccountsBar_BtnInfo().Click(61, 10);
    Get_AccountsBar_BtnInfo_ItemPW1859().Click();
  
    Check_WinAccountInfo_TabPW1859_IsSelected();
  
    Get_WinAccountInfo_BtnCancel().Click();
  
    Close_Croesus_AltF4();
  }
}



function Check_WinAccountInfo_TabPW1859_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859(), "IsSelected", cmpEqual, true);
}
