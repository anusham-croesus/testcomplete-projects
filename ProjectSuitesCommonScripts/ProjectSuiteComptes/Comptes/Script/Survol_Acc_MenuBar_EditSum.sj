//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Sommation des Comptes » 
en cliquant sur MenuBar - Edit - btnSum. Vérifier la présence des contrôles et des étiquettes */

function Survol_Acc_MenuBar_EditSum()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
    
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Sum().Click();
    
  Check_Properties();
    
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}
 
//Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties()
{
  aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Title", cmpEqual, GetData(filePath_Accounts, "Sum", 2, language));
  aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 3, language));
  aqObject.CheckProperty(Get_WinAccountsSum_LblCreditBalance(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 4, language));
  aqObject.CheckProperty(Get_WinAccountsSum_LblDebitBalance(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 5, language));
  aqObject.CheckProperty(Get_WinAccountsSum_LblTotalBalance(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 6, language));
  aqObject.CheckProperty(Get_WinAccountsSum_LblAccountsTotalValue(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 7, language));
  aqObject.CheckProperty(Get_WinAccountsSum_LblNumberOfAccounts(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 8, language));
  if ( client == "US"){aqObject.CheckProperty(Get_WinAccountsSum_LblTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 10, language));}
  else { aqObject.CheckProperty(Get_WinAccountsSum_LblTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "Sum", 9, language));}
  
  aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblCreditBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblDebitBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblTotalBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblAccountsTotalValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblNumberOfAccounts(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_LblTotalCAD(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "IsVisible", cmpEqual, true);
}
