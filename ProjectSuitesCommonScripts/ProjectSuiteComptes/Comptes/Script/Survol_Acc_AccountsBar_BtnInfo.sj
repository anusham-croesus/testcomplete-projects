//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CommonCheckpoints


/** 
  Description : Dans le module « Comptes », afficher la fenêtre « Info compte » 
  en cliquant sur AccountBar_Info. Vérifier la présence des contrôles et des étiquettes.
  @author : christophe.paring@croesus.com
*/

function Survol_Acc_AccountsBar_BtnInfo()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_AccountsBar_BtnInfo().Click();
  
  Check_Properties_WinAccountInfo(language);
  
  Get_WinAccountInfo_BtnCancel().Click();
  
  Close_Croesus_AltF4();
}




function Check_Properties_WinAccountInfo(language)
{
  aqObject.CheckProperty(Get_WinAccountInfo(), "Title", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 2, language));
  aqObject.CheckProperty(Get_WinAccountInfo_BtnOK().Content, "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 3, language));
  aqObject.CheckProperty(Get_WinAccountInfo_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 4, language));
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount(), "header", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 6, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblClientNo(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 7, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblShortName(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 8, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblFullName(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 9, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblAccountNumber(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 10, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblClass(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 11, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblType(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 12, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblCurrency(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 13, language));
  if ( client == "US" ){Log.Message("USDEV-341");}// 90-04-49
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblIACode(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 14, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblStatus(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 15, language));
  if (client == "CIBC"){
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblSubtype(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 17, language));
    //  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblCode(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 32, language));
  }
  else{
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblSubtype(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 16, language));
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblCode(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 17, language));
  }  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts(), "header", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 19, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblBalance(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 20, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 21, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 22, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblNetInvest(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 23, language));
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp(), "header", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 25, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_LblContactPerson(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 26, language));
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo", 27, language));
  
  
  aqObject.CheckProperty(Get_WinAccountInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblClientNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblShortName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblFullName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblAccountNumber(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblClass(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblType(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblCurrency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblIACode(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblStatus(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblSubtype(), "IsVisible", cmpEqual, true);
  
  if (client != "CIBC")
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_LblCode(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblTotalValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_LblNetInvest(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_LblContactPerson(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_LblAccountManager(), "IsVisible", cmpEqual, true);
  
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtClientNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtShortName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtFullName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtAccountNumber(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtClass(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtType(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtCurrency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtIACode(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtStatus(), "IsVisible", cmpEqual, true);
  if (client != "CIBC")
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_CmbSubtype(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtCode(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_TxtBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_TxtTotalValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpAmounts_TxtNetInvest(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_CmbContactPerson(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_CmbAccountManager(), "IsVisible", cmpEqual, true);
  
  
  //ONGLET NOTES (NOTES TAB)
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabNotes(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabNotes(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Notes", 2, language));
  Get_WinAccountInfo_TabNotes().Click();
  Get_WinAccountInfo_TabNotes().WaitProperty("IsSelected", true, 20000);
  Check_Properties_WinInfo_Notes(language,"info");

  
  //ONGLET OBJECTIF DE PLACEMENT (INVESTMENT OBJECTIVE TAB)
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabInvestmentObjective(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabInvestmentObjective(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_InvestmentObjective", 2, language));
  Get_WinAccountInfo_TabInvestmentObjective().Click();
  Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 20000);
  Check_Properties_WinInfo_TabInvestmentObjective(language);
  
  
  //ONGLET RAPPORTS PAR DÉFAUT (DEFAULT REPORTS TAB)
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultReports(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultReports(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_DefaultReports", 2, language));
  Get_WinAccountInfo_TabDefaultReports().Click();
  Get_WinAccountInfo_TabDefaultReports().WaitProperty("IsSelected", "True", 30000);
  Check_Properties_GrpReports(language, "info");

  
  //ONGLET INDICES PAR DÉFAUT (DEFAULT INDICES TAB)

  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultIndices(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultIndices(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_DefaultIndices", 2, language));
  Get_WinAccountInfo_TabDefaultIndices().Click();
  Get_WinAccountInfo_TabDefaultIndices().WaitProperty("IsSelected", true, 20000);
  Check_Properties_WinInfo_TabDefaultIndices(language);
  
  
  //ONGLET PROFIL (PROFILE TAB)
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Profile", 2, language));
  Get_WinAccountInfo_TabProfile().Click();
  Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 20000);
  Check_Properties_WinInfo_TabProfile(language);
  
  
  //ONGLET DATES (DATES TAB)
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 2, language));
  Get_WinAccountInfo_TabDates().Click();
  Get_WinAccountInfo_TabDates().WaitProperty("IsSelected",true);
  Check_Properties_WinAccountInfo_TabDates(language);
  
  
  //ONGLET DÉTENTEURS (HOLDERS TAB)
  if (client == "BNC" ){
    aqObject.CheckProperty(Get_WinAccountInfo_TabHolders(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAccountInfo_TabHolders(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Holders", 2, language));
    Get_WinAccountInfo_TabHolders().Click();
    Get_WinAccountInfo_TabHolders().WaitProperty("IsSelected",true);
    Check_Properties_WinAccountInfo_TabHolders(language);
   
  //ONGLET GP1859 (PW1859 TAB) 
    aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_PW1859", 2, language));
    Get_WinAccountInfo_TabPW1859().Click();
    Get_WinAccountInfo_TabPW1859().WaitProperty("IsSelected",true);
    Check_Properties_WinAccountInfo_TabPW1859(language);
    
   //ONGLET COMPTES ENREGISTRÉS (REGISTERED ACCOUNTS TAB) 
    aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 2, language));
    Get_WinAccountInfo_TabRegisteredAccounts().Click();
    Get_WinAccountInfo_TabRegisteredAccounts().WaitProperty("IsSelected",true);
    Check_Properties_WinAccountInfo_TabRegisteredAccounts(language);
  }
}



function Check_Properties_WinAccountInfo_TabDates(language)
{
  Get_WinAccountInfo_TabDates_LblCreation().WaitProperty("IsVisible",true,1500);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblCreation(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 3, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblCreation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpCreation(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblLastTransaction(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 4, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblLastTransaction(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpLastTransaction(), "IsVisible", cmpEqual, true);
  if ( client == "US" ){
  Log.Message("D'aprés Sofia c'est le même texte qu'on a sur la US la prod donc on le garde en attendant de vérifier ça aprés");
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblManagementStartDate(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 9, language));}
   
  else {aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblManagementStartDate(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 5, language));}
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblManagementStartDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpManagementStartDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblLastTrade(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 6, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblLastTrade(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpLastTrade(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblClosingDate(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 7, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblClosingDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpClosingDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblUpdate(), "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Dates", 8, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_LblUpdate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpUpdate(), "IsVisible", cmpEqual, true);
}



function Check_Properties_WinAccountInfo_TabHolders(language)
{
  // Les en-têtes de colonne de la configuration par défaut
  Get_WinAccountInfo_TabHolders_DgvHolders_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
  
   //Ajouter les entêtes
  Get_WinAccountInfo_TabHolders_DgvHolders_ChName().ClickR();
  Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
  var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
  for(i=1; i<=count; i++){
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 10).Click(); 
    Get_WinAccountInfo_TabHolders_DgvHolders_ChName().ClickR(); 
  }
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabHolders_DgvHolders_ChName().Content, "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Holders", 5, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabHolders_DgvHolders_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Holders", 6, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabHolders_DgvHolders_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Accounts, "AccountInfo_Holders", 9, language));
  
}



function Check_Properties_WinAccountInfo_TabPW1859(language)
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblSeparatelyManaged(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_PW1859", 3, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblSeparatelyManaged(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_ChkSeparatelyManaged(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblAssetAllocation(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_PW1859", 4, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblAssetAllocation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_TxtAssetAllocation(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblManager(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_PW1859", 5, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblManager(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_TxtManager(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblMandate(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_PW1859", 6, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_LblMandate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859_TxtMandate(), "IsVisible", cmpEqual, true);
}



function Check_Properties_WinAccountInfo_TabRegisteredAccounts(language)
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 4, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail(), "IsVisible", cmpEqual, true);
  
  // Les en-têtes de colonne de la configuration par défaut
  Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChYear().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChYear(), "Content", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 5, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysContribution(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 6, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysDeposits(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 7, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysWithdrawals(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 8, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearContributions(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 9, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearDeposits(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 10, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearWithdrawals(), "Content", cmpMatches, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 11, language));
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander(), "Header", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 13, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMinimumWithdrawal(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 14, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMinimumWithdrawal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMinimumWithdrawal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMinimumWithdrawal(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMaximumWithdrawal(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 15, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMaximumWithdrawal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMaximumWithdrawal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMaximumWithdrawal(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblPaymentMethod(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 16, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblPaymentMethod(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbPaymentMethod(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbPaymentMethod(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblFrequency(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "AccountInfo_RegisteredAccounts", 17, language));
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblFrequency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbFrequency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbFrequency(), "IsEnabled", cmpEqual, true);
}