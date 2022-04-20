//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions
//USEUNIT Comptes_Get_functions

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Vérifier les composants et les étiquetés dans la partie de détails . */

function Survol_Acc_MainWin_Details()
{
   Login(vServerAccounts, userName, psw, language);
   Get_ModulesBar_BtnAccounts().Click();
   WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
   //Delay(3000);
   
  //Les points de vérification en français 
  Check_Properties(language);
     
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent la partie de détails)
function Check_Properties(language)
{
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails(), "Header", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 2, language));
  
  Get_AccountsDetails_TabInfo().Click();
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo(), "Header", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 3, language));
  
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_TxtName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_LblType(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 4, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_LblCreation(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 5, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_LblLastTransaction(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 6, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_LblLastTrade(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 7, language));
  
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblInvestmentObjective(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 8, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblFollowUp(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 9, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblContactPerson(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 10, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 11, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblAmounts(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 12, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblBalance(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 13, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 14, language));
  aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_LblMargin(), "Text", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 15, language));
  
  Get_AccountsDetails_TabProfile().Click();
  aqObject.CheckProperty(Get_AccountsDetails_TabProfile(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_AccountsDetails_TabProfile(), "Header", cmpEqual, GetData(filePath_Accounts, "MainWin_Details", 17, language));
  
}