//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions


/* Description : Dans le module « Comptes », afficher l'onglet "Dates" de la fenêtre « Info compte » 
en cliquant sur AccountBar_Info > Dates. Vérifier que l'onglet "Dates" est bien sélectionné. */

function Survol_Acc_AccountsBar_BtnInfo_Dates()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_AccountsBar_BtnInfo().Click(61, 10);
  Get_AccountsBar_BtnInfo_ItemDates().Click();
  
  Check_WinAccountInfo_TabDates_IsSelected();
  
  Get_WinAccountInfo_BtnCancel().Click();
  
  Close_Croesus_AltF4();
}




function Check_WinAccountInfo_TabDates_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates(), "IsSelected", cmpEqual, true);
}