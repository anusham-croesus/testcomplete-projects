//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Alarmes pour le compte » 
en cliquant sur AccountBar_Alarms. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_AccountsBar_Alarms()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  Get_AccountsBar_BtnAlarms().Click();
  
  Check_Properties_WinAlarmsForAccount(language);
  
  Get_WinAlarmsForAccount_BtnCancel().Click();
  
  Close_Croesus_AltF4();
}

function Check_Properties_WinAlarmsForAccount(language)
{
  aqObject.CheckProperty(Get_WinAlarmsForAccount(), "Title", cmpStartsWith, GetData(filePath_Accounts, "Alarms", 2, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_BtnOK().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 3, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 4, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_BtnAddEdit().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 5, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_BtnDelete().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 6, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_BtnAddSecurity().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 7, language));
  
  //Les en-têtes de colonnes
  //Vérification des entêtes de colonnes par défaut 
  Get_WinAlarmsForAccount_DgvAlarms_ChQuantity().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
  
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChQuantity().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 10, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChSymbol().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 11, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 12, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChInvestCost().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 13, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChMarketPrice().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 14, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChSecurityCurrency().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 15, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChLowPrice().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 16, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChHighPrice().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 17, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChExpiryDate().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 18, language));
  
  //Ajouter les entêtes
  Get_WinAlarmsForAccount_DgvAlarms_ChQuantity().ClickR();
  Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
  var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
  for(i=1; i<=count; i++){
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 10).Click(); 
    Get_WinAlarmsForAccount_DgvAlarms_ChQuantity().ClickR(); 
  }
  
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChBid().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 19, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChClose().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 20, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChCreationDate().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 21, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChSecurity().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 23, language));
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChAsk().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 24, language));
  if( client == "US" )
  {
  //Vérification des entêtes de colonnes ajoutés
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChUnitCost().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 25, language));
  } 
  else {
  //Vérification des entêtes de colonnes ajoutés
  aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms_ChACB().Content, "Text", cmpEqual, GetData(filePath_Accounts, "Alarms", 22, language));
  }
}