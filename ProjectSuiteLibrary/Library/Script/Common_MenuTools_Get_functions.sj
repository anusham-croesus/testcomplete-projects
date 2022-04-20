//USEUNIT Global_variables
//USEUNIT Common_MenuEdit_Get_functions
//USEUNIT Common_MenuReports_Get_functions

//++++++++++++++++++++++++++++++++ MENU OUTILS (TOOLS MENU) ++++++++++++++++++++++++++++++++
function Get_CroesusApp(){return Aliases.CroesusApp}

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}

function Get_MenuBar_Tools(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_fcd0", 10)} //ok

function Get_MenuBar_Tools_ArchiveMyDocuments(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_0dde", 10)} //ok

function Get_MenuBar_Tools_Agenda(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_b500", 10)} //ok

function Get_MenuBar_Tools_BondCalculator(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2528", 10)} //ok

//For Orders and Models
function Get_MenuBar_Tools_OrderBook(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_8de9", 10)} 

function Get_MenuBar_Tools_ManageCampaigns(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_eb52", 10)} //ok

function Get_MenuBar_Tools_Configurations(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_9f7c", 10)} //ok

function Get_MenuBar_Tools_Billing(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_aefb", 10)}

//For Relationships, Clients, Accounts, Transactions
function Get_MenuBar_Tools_Internet(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_5998", 10)} //ok

//For Dashboard, Models, Portfolio, Securities, Orders
function Get_MenuBar_Tools_InternetAdresses(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_fb60", 10)} //ok

function Get_MenuBar_Tools_PlanPlus(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c468", 10)}

function Get_MenuBar_Tools_NaviPlan(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_7940", 10)} //ok

function Get_MenuBar_Tools_ExportTheAgenda(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_d1e4", 10)} //ok

function Get_MenuBar_Tools_SynchronizeTheAgenda(){return Get_SubMenus().FindChild("Uid", "w:CFMenuItem_47", 10)} //missing in Automation 8


//Sous-menu Internet

function Get_MenuBar_Tools_Internet_Quotes() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cotes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Quotes"], 10)}
}

function Get_MenuBar_Tools_Internet_Graphs() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphiques"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphs"], 10)}
}

function Get_MenuBar_Tools_Internet_Analysis() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analyse"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analysis"], 10)}
}

function Get_MenuBar_Tools_Internet_News() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Nouvelles"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "News"], 10)}
}

function Get_MenuBar_Tools_Internet_Company() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compagnie"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Company"], 10)}
}

function Get_MenuBar_Tools_Internet_AccessWebPage(WebPageAdress){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", WebPageAdress] , 10)} //no uid

function Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Aller à la page d'accueil de votre navigateur..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access your browser home page..."], 10)}
}

function Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aller à la page d'accueil de votre navigateur..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access the H_ome Page of Your Browser..."], 10)}
}

//function Get_MenuBar_Tools_Internet_ComposeAddress() //no uid
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Composer une adresse..."], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compose Address..."], 10)}
//}

function Get_MenuBar_Tools_Internet_ComposeAddress() //no uid
{
  if (language == "french"){return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Composer une adresse..."], 10)}
  else {return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compose Address..."], 10)}
}

function Get_MenuBar_Tools_Internet_ComposeAddressForTransactions() //no uid
{
  if (language == "french"){return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Composer une adresse..."], 10)}
  else {return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Compose Address..."], 10)}
}

//*************************************************** FENÊTRE COMPOSER UNE ADRESSE (COMPOSE ADDRESS WINDOW) *************************************************
//Tools--> Internet--> COMPOSE ADDRESS

function Get_WinComposeAddress(){return Aliases.CroesusApp.winComposeAddress}

function Get_WinComposeAddress_LblAddress(){return Get_WinComposeAddress().FindChild("Uid", "TextBlock_7056", 10)}

function Get_WinComposeAddress_TxtAddress(){return Get_WinComposeAddress().FindChild("Uid", "TextBox_5a7f", 10)}

function Get_WinComposeAddress_BtnLaunch(){return Get_WinComposeAddress().FindChild("Uid", "Button_71ad", 10)}

function Get_WinComposeAddress_BtnCancel(){return Get_WinComposeAddress().FindChild("Uid", "Button_329d", 10)}


//Les fonctions Get pour la fenêtre Composer une adresse du module Transactions

function Get_WinComposeAddress_LblAddressForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinComposeAddress_TxtAddressForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinComposeAddress_BtnLaunchForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinComposeAddress_BtnCancelForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

//****************************************** FENÊTRE CALCULATRICE D'OBLIGATIONS (BOND CALCULATOR) *****************************************
//Tools --> Bons Calculator 
function Get_WinBondCalculator(){return Aliases.CroesusApp.winBondCalculator}

function Get_WinBondCalculator_BtnClose() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"], 10)}
}

function Get_WinBondCalculator_BtnDaysBetweenDates() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Jours entre les dates"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Days Between Dates"], 10)}
}

function Get_WinBondCalculator_BtnCalculate() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Calculer"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Calculate"], 10)}
}

function Get_WinBondCalculator_BtnCopyBond() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Copier l'obligation..."], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copy _Bond..."], 10)}
}

function Get_WinBondCalculator_BtnReset() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Réi_nitialiser"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Reset"], 10)}
}


function Get_WinBondCalculator_LblBondType()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Type d'obligation:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Bond Type:"], 10)}
}

function Get_WinBondCalculator_LblInterestRate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Taux d'intérêt:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Interest Rate:"], 10)}
}

function Get_WinBondCalculator_LblFirstCouponDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date premier coupon:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "First Coupon Date:"], 10)}
}

function Get_WinBondCalculator_LblPurchaseDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'achat:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Purchase Date:"], 10)}
}

function Get_WinBondCalculator_LblMaturityDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'échéance:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Maturity Date:"], 10)}
}

function Get_WinBondCalculator_LblIssueDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'émission:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Issue date:"], 10)}
}

function Get_WinBondCalculator_LblCurrentDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date courante:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Current Date:"], 10)}
}

function Get_WinBondCalculator_LblConversionDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date de conversion:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Conversion Date:"], 10)}
}

function Get_WinBondCalculator_LblDayCount()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Format de calendrier:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Day Count:"], 10)}
}

function Get_WinBondCalculator_LblCompounding()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Composition:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Compounding:"], 10)}
}

function Get_WinBondCalculator_LblPurchasePrice()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Prix d'achat:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Purchase Price:"], 10)}
}

function Get_WinBondCalculator_LblMarketPrice()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Prix au marché:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Market Price:"], 10)}
}

function Get_WinBondCalculator_LblParValue()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Valeur au pair:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Par Value:"], 10)}
}

function Get_WinBondCalculator_LblCostYield()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. achat (%):"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Cost Yield (%):"], 10)}
}

function Get_WinBondCalculator_LblMarketYield()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. au marché (%):"], 10)}//La modification a été faite selon le fichier Excel Modification_Documentation 
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Market Yield (%):"], 10)}
}

function Get_WinBondCalculator_LblYieldToDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. à jour (%):"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Yld-to-Date (%):"], 10)}
}

function Get_WinBondCalculator_LblModifiedDuration()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Durée modifiée:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Modified Duration:"], 10)}
}

function Get_WinBondCalculator_LblAccInterest()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Int.courus/1000:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Acc. Int /1000:"], 10)}
}


function Get_WinBondCalculator_CmbBondABondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinBondCalculator_CmbBondBBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinBondCalculator_CmbBondCBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinBondCalculator_CmbBondDBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinBondCalculator_CmbBondADayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinBondCalculator_CmbBondBDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "6"], 10)}

function Get_WinBondCalculator_CmbBondCDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "7"], 10)}

function Get_WinBondCalculator_CmbBondDDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "8"], 10)}

function Get_WinBondCalculator_CmbBondACompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "9"], 10)}

function Get_WinBondCalculator_CmbBondBCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "10"], 10)}

function Get_WinBondCalculator_CmbBondCCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "11"], 10)}

function Get_WinBondCalculator_CmbBondDCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "12"], 10)}


function Get_WinBondCalculator_TxtBondAInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinBondCalculator_TxtBondBInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinBondCalculator_TxtBondCInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}

function Get_WinBondCalculator_TxtBondDInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "4"], 10)}

function Get_WinBondCalculator_TxtBondAPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "5"], 10)}

function Get_WinBondCalculator_TxtBondBPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "6"], 10)}

function Get_WinBondCalculator_TxtBondCPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "7"], 10)}

function Get_WinBondCalculator_TxtBondDPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "8"], 10)}

function Get_WinBondCalculator_TxtBondAMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "9"], 10)}

function Get_WinBondCalculator_TxtBondBMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "10"], 10)}

function Get_WinBondCalculator_TxtBondCMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "11"], 10)}

function Get_WinBondCalculator_TxtBondDMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "12"], 10)}

function Get_WinBondCalculator_TxtBondAParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "13"], 10)}

function Get_WinBondCalculator_TxtBondBParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "14"], 10)}

function Get_WinBondCalculator_TxtBondCParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "15"], 10)}

function Get_WinBondCalculator_TxtBondDParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "16"], 10)}

function Get_WinBondCalculator_TxtBondACostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "17"], 10)}

function Get_WinBondCalculator_TxtBondBCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "18"], 10)}

function Get_WinBondCalculator_TxtBondCCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "19"], 10)}

function Get_WinBondCalculator_TxtBondDCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "20"], 10)}

function Get_WinBondCalculator_TxtBondAMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "21"], 10)}

function Get_WinBondCalculator_TxtBondBMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "22"], 10)}

function Get_WinBondCalculator_TxtBondCMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "23"], 10)}

function Get_WinBondCalculator_TxtBondDMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "24"], 10)}

function Get_WinBondCalculator_TxtBondAYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "25"], 10)}

function Get_WinBondCalculator_TxtBondBYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "26"], 10)}

function Get_WinBondCalculator_TxtBondCYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "27"], 10)}

function Get_WinBondCalculator_TxtBondDYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "28"], 10)}

function Get_WinBondCalculator_TxtBondAModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "29"], 10)}

function Get_WinBondCalculator_TxtBondBModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "30"], 10)}

function Get_WinBondCalculator_TxtBondCModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "31"], 10)}

function Get_WinBondCalculator_TxtBondDModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "32"], 10)}

function Get_WinBondCalculator_TxtBondAAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "33"], 10)}

function Get_WinBondCalculator_TxtBondBAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "34"], 10)}

function Get_WinBondCalculator_TxtBondCAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "35"], 10)}

function Get_WinBondCalculator_TxtBondDAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "36"], 10)}


function Get_WinBondCalculator_DtpBondAFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinBondCalculator_DtpBondBFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinBondCalculator_DtpBondCFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "3"], 10)}

function Get_WinBondCalculator_DtpBondDFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "4"], 10)}

function Get_WinBondCalculator_DtpBondAPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "5"], 10)}

function Get_WinBondCalculator_DtpBondBPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "6"], 10)}

function Get_WinBondCalculator_DtpBondCPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "7"], 10)}

function Get_WinBondCalculator_DtpBondDPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "8"], 10)}

function Get_WinBondCalculator_DtpBondAMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "9"], 10)}

function Get_WinBondCalculator_DtpBondBMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "10"], 10)}

function Get_WinBondCalculator_DtpBondCMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "11"], 10)}

function Get_WinBondCalculator_DtpBondDMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "12"], 10)}

function Get_WinBondCalculator_DtpBondAIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "13"], 10)}

function Get_WinBondCalculator_DtpBondBIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "14"], 10)}

function Get_WinBondCalculator_DtpBondCIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "15"], 10)}

function Get_WinBondCalculator_DtpBondDIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "16"], 10)}

function Get_WinBondCalculator_DtpBondACurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "17"], 10)}

function Get_WinBondCalculator_DtpBondBCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "18"], 10)}

function Get_WinBondCalculator_DtpBondCCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "19"], 10)}

function Get_WinBondCalculator_DtpBondDCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "20"], 10)}

function Get_WinBondCalculator_DtpBondAConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "21"], 10)}

function Get_WinBondCalculator_DtpBondBConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "22"], 10)}

function Get_WinBondCalculator_DtpBondCConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "23"], 10)}

function Get_WinBondCalculator_DtpBondDConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "24"], 10)}

//************************************** FENÊTRE DOCUMENTS PERSONNELS (PERSONAL DOCUMENTS WINDOW) *********************************************
//Tools --> Archive me documents
function Get_WinPersonalDocuments(){return Aliases.CroesusApp.winPersonalDocuments}

function Get_WinPersonalDocuments_BtnOK(){return Get_WinPersonalDocuments().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}//no uid

//Les fonctions suivantes sont aussi communes aux fenêtres Info Client/Relation (onglet Documents) et Info modèle (onglet Documents)

function Get_PersonalDocuments_Toolbar(){return Get_CroesusApp().FindChild("Uid", "ToolBarTray_536b", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_4ecd", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnAddAFile(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_7d78", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnRemove(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_25cf", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnRefresh(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_c153", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnCut(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_1f07", 10)}

function Get_PersonalDocuments_Toolbar_BtnCopy(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_7b0f", 10)}

function Get_PersonalDocuments_Toolbar_BtnPaste(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_4c55", 10)}//ok

function Get_PersonalDocuments_Toolbar_TxtSearch(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "TextBox_dafe", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnSearch(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_3e39", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterAll(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_4b62", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterEmail(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_9796", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterPdf(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_5b0c", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterFile(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_ca4f", 10)}//ok


function Get_PersonalDocuments_GrpComments(){return Get_CroesusApp().FindChild("Uid", "GroupBox_4d7f", 10)}//ok

function Get_PersonalDocuments_GrpComments_TxtComment(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "TextBox_a547", 10)}//ok

function Get_PersonalDocuments_GrpComments_BtnEdit(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "Button_b3e0", 10)}//ok

function Get_PersonalDocuments_GrpComments_BtnSave(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "Button_d631", 10)}

function Get_PersonalDocuments_GrpDocumentProperties(){return Get_CroesusApp().FindChild("Uid", "GroupBox_efd1", 10)}

function Get_PersonalDocuments_GrpDocumentProperties_TxtPath(){return Get_PersonalDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_5e79", 10)}

function Get_WinPersonalDocuments_TvwDocuments(){return Get_WinPersonalDocuments().FindChild("Uid", "TreeView_bc22", 10)}//ok

function Get_WinPersonalDocuments_TvwDocuments_TviUser(){return Get_WinPersonalDocuments().FindChild("Uid", "TreeViewItem_5e70", 10)}

function Get_WinPersonalDocuments_TvwDocuments_TvReport(){return Get_CroesusApp().FindChild("Uid", "TreeViewItem_a6b2", 10)}

function Get_PersonalDocuments_TvwDocumentsForClientAndModel(){return Get_CroesusApp().FindChild("Uid", "TreeView_856c", 10)}

function Get_PersonalDocuments_LstDocuments(){return Get_CroesusApp().FindChild("Uid", "ListBox_25ba", 10)}//ok

function Get_PersonalDocuments_LstDocuments_ItemTopDocument(){return Get_PersonalDocuments_LstDocuments().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)} 

function Get_PersonalDocuments_LstDocuments_ContextMenu_NewFolder()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Nouveau dossier", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "New Folder", 10)}
}

function Get_PersonalDocuments_LstDocuments_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)} 

//************************ GESTIONNAIRE DE RESTRICTIONS POUR CONFIGURATIONS (RESTRICTIONS MANAGER FOR CONFIGURATIONS) *******************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions 
function Get_WinRestrictionsManagerForConfigurations(){return Aliases.CroesusApp.winRestrictionsManagerForConfigurations}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader(){return Get_WinRestrictionsManagerForConfigurations().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnEdit()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Mo_difier"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Edit"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnDelete()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BtnClose()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions(){return Get_WinRestrictionsManagerForConfigurations().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChName()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChDescription(){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinRestrictionsManagerForConfigurations_BtnOK()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BtnCancel()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}

//********************************* FENÊTRE GESTIONNAIRE DES RESTRICTIONS ASSIGNÉES (ASSIGNED RESTRICTIONS MANAGER WINDOW) **************************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions -->ASSIGNED RESTRICTIONS to criteria 
function Get_WinAssignedRestrictionsManager(){return Aliases.CroesusApp.winAssignedRestrictionsManager}

function Get_WinAssignedRestrictionsManager_BarPadHeader(){return Get_WinAssignedRestrictionsManager().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"], 10)}
}

function Get_WinAssignedRestrictionsManager_BarPadHeader_BtnDelete()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"], 10)}
}

function Get_WinAssignedRestrictionsManager_BtnClose()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinAssignedRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions(){return Get_WinAssignedRestrictionsManager().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChRestrictionName()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom de la restriction"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction Name"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChRestrictionDescription()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description de la restriction"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction Description"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChCriterionDescription()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du critère"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Criterion Description"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

//---> fin  MenuTools_Get_functions

//--->   MenuTools_Get_functions
//********************************* FENÊTRE ASSOCIER DES RESTRICTIONS (ASSIGN RESTRICTIONS WINDOW) **************************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions -->ASSIGNED RESTRICTIONS to criteria -->Add

function Get_WinAssignRestrictions(){return Aliases.CroesusApp.winAssignRestrictions}

function Get_WinAssignRestrictions_BtnOK(){return Get_WinAssignRestrictions().FindChild("Uid", "Button_c53d", 10)}

function Get_WinAssignRestrictions_BtnCancel(){return Get_WinAssignRestrictions().FindChild("Uid", "Button_dd22", 10)}


function Get_WinAssignRestrictions_GrpRestrictions(){return Get_WinAssignRestrictions().FindChild("Uid", "GroupBox_c8cb", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_BtnAdd(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "Button_4d20", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_BtnDelete(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "Button_3cc6", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "DataGrid_765a", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChName()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChDescription(){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}


function Get_WinAssignRestrictions_GrpSearchCriteria(){return Get_WinAssignRestrictions().FindChild("Uid", "GroupBox_3056", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "Button_0770", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_BtnDelete(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "Button_ed5e", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "DataGrid_e480", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChName()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChAccess()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accès"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChType(){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChCreation()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Création"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChModule(){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Module"], 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChModified()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modifié"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChGenerated()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Généré"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Generated"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChNoOfRecords()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre enreg."], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Records"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChCreated()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created"], 10)}
}

//**************************************** FENÊTRE PARAMÈTRES  (BILLING PARAMETERS WINDOW) ******************************************
//Tools-->Billing
function Get_WinBillingParameters(){return Aliases.CroesusApp.winBillingParameters}

function Get_WinBillingParameters_BtnOK(){return Get_WinBillingParameters().FindChild("Uid", "Button_0536", 10)}

function Get_WinBillingParameters_BtnCancel(){return Get_WinBillingParameters().FindChild("Uid", "Button_0dff", 10)}

function Get_WinBillingParameters_RdoInArrears(){return Get_WinBillingParameters().FindChild("Uid", "RadioButton_d478", 10)}

function Get_WinBillingParameters_RdoInAdvance(){return Get_WinBillingParameters().FindChild("Uid", "RadioButton_e5b0", 10)}

function Get_WinBillingParameters_LblPeriodEndingOrBeginningIn(){return Get_WinBillingParameters().FindChild("Uid", "TextBlock_7914", 10)}

//  function Get_WinBillingParameters_DtpBillingDate(){return Get_WinBillingParameters().FindChild("WPFControlName", "_billingDate", 10)} 
function Get_WinBillingParameters_DtpBillingDate(){return Get_WinBillingParameters().FindChild("Uid", "MonthYearField_dbd2", 10)} 

function Get_WinInstantBillingParameters_DtpSelectABillingDate(){return Get_WinInstantBillingParameters().FindChild("Uid", "DateField_35e0", 10)}

function Get_WinInstantBillingParameters_LblMessage(){return Get_WinInstantBillingParameters().FindChild("Uid", "TextBlock_1f3b", 10)}


//**************************************** FENÊTRE PARAMÈTRES DE FACTURATION (BILLING PARAMETERS WINDOW) ******************************************
//Tools-->Billing
function Get_WinBillingParameters_GrpFrequencies(){return Get_WinBillingParameters().FindChild("Uid", "GroupBox_e1ff", 10)}
function Get_WinBillingParameters_GrpFrequencies_ChkMonthly(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_0", 10)}
/*
function Get_WinBillingParameters_GrpFrequencies_ChkMonthly()
{
  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Mensuelle"], 10)}
  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Monthly"], 10)}
}*/
function Get_WinBillingParameters_GrpFrequencies_ChkQuarterly(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_1", 10)}
/*
function Get_WinBillingParameters_GrpFrequencies_ChkQuarterly()
{
  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Trimestrielle"], 10)}
  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Quarterly"], 10)}
}*/
function Get_WinBillingParameters_GrpFrequencies_ChkSemiannual(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_2", 10)}
/*
function Get_WinBillingParameters_GrpFrequencies_ChkSemiannual()
{
  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Semestrielle"], 10)}
  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Semiannual"], 10)}
}*/

function Get_WinBillingParameters_GrpFrequencies_ChkAnnual(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_3", 10)}

//*********************************************** CALENDRIER (CALENDRIER) *******************************************************
//Tools--> Billing-->le btn de calenrier 
function Get_Calendar(){return Get_SubMenus().FindChild("Uid", "MonthCalendar_80ce", 10)}

function Get_Calendar_BtnToday(){return Get_Calendar().FindChild("Uid", "Button_77f6", 10)}

function Get_Calendar_BtnOK(){return Get_Calendar().FindChild("Uid", "Button_92ab", 10)}

function Get_Calendar_BtnCancel(){return Get_Calendar().FindChild("Uid", "Button_9aa4", 10)}

function Get_Calendar_LstDays(){return Get_Calendar().FindChild("Uid", "ListBox_2f71", 10)}

function Get_Calendar_LstDays_Item(dayNumber){return Get_Calendar_LstDays().FindChild(["ClrClassName", "IsEnabled", "WPFControlText"], ["TextBlock", true, dayNumber], 10)}

function Get_Calendar_LstYears(){return Get_Calendar().FindChild("Uid", "ListBox_ee5c", 10)}

function Get_Calendar_LstYears_Item(yearNumber){return Get_Calendar_LstYears().FindChild(["ClrClassName", "DataContext.OleValue"], ["ListBoxItem", yearNumber], 10)}

function Get_Calendar_LstMonths(){return Get_Calendar().FindChild("Uid", "ListBox_ac36", 10)}

function Get_Calendar_LstMonths_Item(monthNumber){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", monthNumber], 10)}

function Get_Calendar_LstMonths_ItemJanuary(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 1], 10)}

function Get_Calendar_LstMonths_ItemFebruary(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10)}

function Get_Calendar_LstMonths_ItemMarch(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10)}

function Get_Calendar_LstMonths_ItemApril(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10)}

function Get_Calendar_LstMonths_ItemMay(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 5], 10)}

function Get_Calendar_LstMonths_ItemJune(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 6], 10)}

function Get_Calendar_LstMonths_ItemJuly(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 7], 10)}

function Get_Calendar_LstMonths_ItemAugust(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 8], 10)}

function Get_Calendar_LstMonths_ItemSeptember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 9], 10)}

function Get_Calendar_LstMonths_ItemOctober(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 10], 10)}

function Get_Calendar_LstMonths_ItemNovember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 11], 10)}

function Get_Calendar_LstMonths_ItemDecember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 12], 10)}

//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//**************************************** FENÊTRE FACTURATION (BILLING WINDOW) ******************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK 
function Get_WinBilling(){return Aliases.CroesusApp.winBilling}

function Get_WinBilling_BtnGenerate(){return Get_WinBilling().FindChild("Uid", "Button_7a8a", 10)}

function Get_WinBilling_BtnView(){return Get_WinBilling().FindChild("Uid", "Button_a7b7", 10)}

function Get_WinBilling_BtnCancel(){return Get_WinBilling().FindChild("Uid", "Button_6893", 10)}


function Get_WinBilling_GrpRelationships(){return Get_WinBilling().FindChild("Uid", "GroupBox_c21b", 10)}

function Get_WinBilling_GrpRelationships_DgvRelationships(){return Get_WinBilling_GrpRelationships().FindChild("Uid", "DataGrid_6e20", 10)}


function Get_WinBilling_GrpAccounts(){return Get_WinBilling().FindChild("Uid", "GroupBox_a81b", 10)}

function Get_WinBilling_GrpAccounts_DgvAccounts(){return Get_WinBilling_GrpAccounts().FindChild("Uid", "DataGrid_3ea8", 10)}

function Get_WinBilling_GrpAccounts_BtnEdit(){return Get_WinBilling_GrpAccounts().FindChild("Uid", "Button_4a0d", 10)}


function Get_WinBilling_GrpSummaryCAD(){return Get_WinBilling().FindChild("Uid", "GroupBox_2124", 10)}

function Get_WinBilling_GrpSummaryCAD_LblBillingDate(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_59ee", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtBillingDate(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_6fdd", 10)}

function Get_WinBilling_GrpSummaryCAD_LblTotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_990b", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtTotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_6fb5", 10)}

function Get_WinBilling_GrpSummaryCAD_LblIATotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_649c", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "ItemsControl_c0aa", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(){return Get_WinBilling_GrpSummaryCAD_TxtIATotalFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(){return Get_WinBilling_GrpSummaryCAD_TxtIATotalFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

//Fonction get pour la grille de la partie Messages
function Get_WinBilling_MessagesDgv(){return Get_WinBilling().FindChild("Uid", "DataGrid_1008", 10)}
//---> fin  MenuTools_Get_functions




//--->   MenuTools_Get_functions
//********************************** FENÊTRE DE SÉLECTION DE SORTIE - FACTURATION (OUTPUT SELECTION WINDOW - BILLING) ************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK -->Dans la fenêtre `Billing`cliquer sur generate.
function Get_WinOutputSelection(){return Aliases.CroesusApp.winOutputSelection}

function Get_WinOutputSelection_BtnOK(){return Get_WinOutputSelection().FindChild("Uid", "Button_c362", 10)}

function Get_WinOutputSelection_BtnCancel(){return Get_WinOutputSelection().FindChild("Uid", "Button_1e66", 10)}


function Get_WinOutputSelection_GrpOutput(){return Get_WinOutputSelection().FindChild("Uid", "GroupBox_c181", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToExcelSummarized(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_cf12", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_5f49", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_857c", 10)}
//--->  fin MenuTools_Get_functions




//--->   MenuTools_Get_functions
//********************************** FENÊTRE PARAMÈTRES DE FACTURATION DU COMPTE (ACCOUNT BILLING PARAMETERS WINDOW) ************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK -->Dans la fenêtre `Billing`cliquer sur Edit.
function Get_WinAccountBillingParameters(){return Aliases.CroesusApp.winAccountBillingParameters}

function Get_WinAccountBillingParameters_BtnOK(){return Get_WinAccountBillingParameters().FindChild("Uid", "Button_3c4b", 10)}

function Get_WinAccountBillingParameters_BtnCancel(){return Get_WinAccountBillingParameters().FindChild("Uid", "Button_557f", 10)}

function Get_WinAccountBillingParameters_LblAccountNo(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_b5e0", 10)}

function Get_WinAccountBillingParameters_TxtAccountNo(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_020d", 10)}

function Get_WinAccountBillingParameters_TxtAccountCurrency(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_5373", 10)}


function Get_WinAccountBillingParameters_GrpBillingParameters(){return Get_WinAccountBillingParameters().FindChild("Uid", "GroupBox_ff4a", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_ChkIncluded(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "CheckBox_5104", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblCalculatedFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_1b7e", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtCalculatedFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_9c36", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblBilledFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_d750", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtBilledFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_2eab", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblSpecialFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_e267", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtSpecialFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_4f47", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtCFAdjustment(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_716d", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblNote(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_8999", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtNote(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBox_7113", 10)}


//****************************************** FENÊTRE CONFIGURATIONS (CONFIGURATIONS WINDOW) ********************************************
//Tools--> Configurations
function Get_WinConfigurations(){return Aliases.CroesusApp.winConfigurations}

function Get_WinConfigurations_ToolBar(){return Get_WinConfigurations().FindChild("Uid", "ToolBar_1d40", 10)}

function Get_WinConfigurations_ToolBar_BtnDelete()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Supprimer"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Delete"], 10, true, 5000)}
}
function Get_WinConfigurations_ToolBar_BtnEdit(){
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Modifier une configuration"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Edit a Configuration"], 10, true, 5000)}
}
function Get_WinConfigurations_ToolBar_BtnAddAssetAllocation()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Ajouter une répartition d'actifs"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Add Asset Allocation"], 10, true, 5000)}
}

function Get_WinConfigurations_ToolBar_BtnAddInvestmentObjective()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Ajouter un objectif de placement"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Add Investment Objective"], 10, true, 5000)}
}

function Get_WinConfigurations_ToolBar_BtnMapClassification()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Assigner un classement"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Map Classification"], 10, true, 5000)}
}

function Get_WinConfigurations_TvwTreeview(){return Get_WinConfigurations().FindChildEx("Uid", "TreeView_f006", 10, true, 5000)}

function Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profils & Dictionnaires"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profiles & Dictionaries"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbUnifiedManagedAccounts()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Comptes à gestion unifiée"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Unified Managed Accounts"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbProductsAndServices()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Produits & Services"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Products & Services"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Catégorisation des titres"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Security categorisation"], 10)}
}



function Get_WinConfigurations_TvwTreeview_LlbRestrictions(){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Restrictions"], 10)}

function Get_WinConfigurations_TvwTreeview_LlbBilling()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Facturation"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Billing"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gestionnaire du risque et de la conformité"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Risk & Compliance Manager"], 10)}
}

function Get_WinConfigurations_LvwListView(){return Get_WinConfigurations().FindChildEx("Uid", "ListView_bc90", 10, true, -1)}

function Get_WinConfigurations_LvwListView_LlbProfiles()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profils"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profiles"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageRestrictions()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer les restrictions"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Restrictions"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageCriteria()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer les critères"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Criteria"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Assigner les restrictions aux critères"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Assign Restrictions to Criteria"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Groupes de profils"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Groups of Profiles"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbDictionaries()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Dictionnaires"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Dictionaries"], 10)}
}


function Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Catégorisation des titres"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Security categorisation"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageBilling()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer la facturation"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Billing"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Répartition des cotes de risque"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Risk Rating Allocation"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageValidationGrid()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer la grille de validation"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Validation Grid"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbOptions(){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Options"], 10)}

function Get_WinConfigurations_LvwListView_LlbMyOptions()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes options"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "My Options"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Répartitions et objectifs"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Asset Allocations and Objectives"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbGlobalClassifications()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements globaux"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Global Classifications"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbSubcategories()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Sous-catégories"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Subcategories"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbRegionalSettings()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Paramètres régionaux"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Regional Settings"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings(){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ListViewItem", 1], 10, true, 5000).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

function Get_WinConfigurations_LvwListView_LlbItem(itemName)
{
  return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", itemName], 10, true, 5000);
}

function Get_WinConfigurations_LvwListView_LlbMyAssetAllocations()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes répartitions"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "My Asset Allocations"], 10, true, 5000)}
}

function Get_WinConfigurations_LvwListView_LlbBasedOn()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Basé sur"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Based on"], 10, true, 5000)}
}


function Get_WinConfigurations_LvwListView_LlbMyObjectives()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes objectifs"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "My objectives"], 10, true, 5000)}
}


function Get_WinConfigurations_TvwTreeview_LlbReports()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Rapports"], 10, true, 5000)}
  else {return Get_WinConfigurations_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Reports"], 10, true, 5000)}
}

function Get_WinConfigurations_LvwListView_LlbDefaultConfiguration()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration des défauts"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Default Configuration"], 10, true, 5000)}
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE CONFIGURATION DES DÉFAUTS (DEFAULT CONFIGURATION WINDOW) **************
//Tools-->Configurations-->Default Configuration
function Get_WinDefaultConfiguration(){return Aliases.CroesusApp.winDefaultConfiguration}

function Get_WinDefaultConfiguration_RdoGlobal(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Global"], 10)}

function Get_WinDefaultConfiguration_CmbTheme(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinDefaultConfiguration_BtnImport()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniButton", "_Importer..."], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniButton", "_Import..."], 10, true, 5000)}
}

function Get_WinDefaultConfiguration_BtnOK(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinDefaultConfiguration_BtnCancel()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinDefaultConfiguration_TvwTreeview(){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", 1], 10, true, 5000)}

function Get_WinDefaultConfiguration_TvwTreeview_LlbTheme()
{
  if (language == "french"){return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Thème"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Theme"], 10, true, 5000)}
}

function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration()
{
  if (language == "french"){return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration spécifique"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Specific Configuration"], 10, true, 5000)}
}

/**
    Paramètre : itemLabel : Nom du sous-élément de Configuration Spécifique
*/
function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(itemLabel)
{
    var llbItemObjectParent = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration().Parent;
    llbItemObjectParent.set_IsExpanded(true);
    var arrayOfTreeviewItems = llbItemObjectParent.FindAllChildren(["ClrClassName", "IsVisible"], ["CFTreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, itemLabel]).Exists)
            return arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, itemLabel]);
    return Utils.CreateStubObject();
}

/**
    Paramètre : itemLabel : Nom du sous-élément de Configuration Spécifique
*/
function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem_LlbTheme(itemLabel)
{
    var labelTheme = (language == "french")? "Thème": "Theme";
    
    var llbItemObjectParent = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(itemLabel).Parent;
    llbItemObjectParent.set_IsExpanded(true);
    var arrayOfTreeviewItems = llbItemObjectParent.FindAllChildren(["ClrClassName", "IsVisible"], ["CFTreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, labelTheme]).Exists)
            return arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, labelTheme]);

    return Utils.CreateStubObject();
}

function Get_WinDefaultConfiguration_ChkUseDefault()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser le défaut"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use Default"], 10, true, 5000)}
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE AJOUT/MODIFICATION D'UN THÈME DE RAPPORT (ADD/EDIT A REPORT Theme WINDOW) **************
//Tools-->Configurations-->Default Configuration --> btnImport
function Get_WinAddOrEditAReportTheme(){return Aliases.CroesusApp.winAddOrEditAReportTheme}

function Get_WinAddOrEditAReportTheme_TxtFirm(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinAddOrEditAReportTheme_CmbLanguage(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinAddOrEditAReportTheme_TxtThemeName(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 10)}

function Get_WinAddOrEditAReportTheme_TxtFile(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 3], 10)}

function Get_WinAddOrEditAReportTheme_BtnOK(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE RISK ALLOCATION CONFIGURATION TOOLS ***********************************************************
//Tools --> Configirations --> RISK ALLOCATION
function Get_WinRiskAllocationConfigurationTool(){return Aliases.CroesusApp.winRiskAllocationConfigurationTool}

function Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation(){return Get_WinRiskAllocationConfigurationTool().FindChild("Uid", "DataGrid_8f5d", 10)}

function Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(){return Get_WinRiskAllocationConfigurationTool().FindChild("Uid", "DataGrid_478a", 10)}

function Get_WinRiskAllocationConfigurationTool_BtnSave()  
{
if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Sau_vegarder"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Sa_ve"], 10)}
}

function Get_WinRiskAllocationConfigurationTool_BtnCancel()
{
if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}

function Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevelWeightCell(securityRiskRatingName, riskAllocationLevelName)
{
    var securityRiskRatingColumnHeaderName = "";
    var securityRiskRatingColumnIndex = 1; //Default Index ; the actual one will be retrieved according to the securityRiskRatingColumnHeaderName (if not successfull, the default one will be used)
    
    var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    var columnHeadersCount = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderPresenter", 1], 10).DataContext.Cells.Count;
    
    //Find Risk Allocation Level Column
    var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
    if (!riskAllocationLevelColumnHeader.Exists){
        dgvRecordListControl.keys("[Home][Home][Home]");
        var keysCount = 0;
        do {
            dgvRecordListControl.keys("[Right]");
            riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
        } while (++keysCount <= (columnHeadersCount) && !riskAllocationLevelColumnHeader.Exists)
    }
    
    //var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
    if (!riskAllocationLevelColumnHeader.Exists)
        Log.Error(aqString.Quote(riskAllocationLevelName) + " Risk Allocation Level Header Label not found.");
    else {
        var riskAllocationLevelColumnIndex = riskAllocationLevelColumnHeader.WPFControlOrdinalNo;
        
        //Find Security Risk Rating Column
        var arrayOfSecurityRiskRatingColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindAllChildren(["ClrClassName", "WPFControlText"], ["LabelPresenter", securityRiskRatingColumnHeaderName], 10).toArray();
        if (arrayOfSecurityRiskRatingColumnHeader.length == 1)
            securityRiskRatingColumnIndex = arrayOfSecurityRiskRatingColumnHeader[0].WPFControlOrdinalNo;
        else {
            if (arrayOfSecurityRiskRatingColumnHeader.length == 0)
                Log.Warning("Security Risk Rating Header '" + securityRiskRatingColumnHeaderName + "' not found. Consider the default index, securityRiskRatingColumnIndex = " + securityRiskRatingColumnIndex);
            else
                Log.Warning("Security Risk Rating Header duplicate label '" + securityRiskRatingColumnHeaderName + "'. Consider the default index, securityRiskRatingColumnIndex = " + securityRiskRatingColumnIndex);
        }
        
        //Find Security Risk Rating Row and then return the cell component
        var rowsCount = dgvRecordListControl.Items.Count;
        var securityRiskRatingRow = GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount);
        if (securityRiskRatingRow.Exists){
            var riskAllocationLevelColumnHeaderLeftX = riskAllocationLevelColumnHeader.Left;
            var criskAllocationLevelColumnHeaderRightX = riskAllocationLevelColumnHeaderLeftX + riskAllocationLevelColumnHeader.Width;
            var arrayOfSecurityRiskRatingRowWeightCells = securityRiskRatingRow.FindAllChildren(["ClrClassName", "IsVisible"], ["CellValuePresenter", true], 10).toArray();
            for (var cellIndex = 0; cellIndex < arrayOfSecurityRiskRatingRowWeightCells.length; cellIndex++){
                var securityRiskRatingRowWeightCell = arrayOfSecurityRiskRatingRowWeightCells[cellIndex];
                var securityRiskRatingRowWeightCellMiddleX = securityRiskRatingRowWeightCell.Left + (securityRiskRatingRowWeightCell.Width/2);
                if (securityRiskRatingRowWeightCellMiddleX > riskAllocationLevelColumnHeaderLeftX && securityRiskRatingRowWeightCellMiddleX < criskAllocationLevelColumnHeaderRightX)
                    return securityRiskRatingRowWeightCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);
            }
        }
        
        Log.Error(aqString.Quote(securityRiskRatingName) + " Security Risk Rating row not found.");
    }
    
    return Utils.CreateStubObject();
    
    
    function GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount, numTry)
    {
        numTry = (numTry == undefined)? 1: numTry++;
        
        if (numTry > rowsCount)
            return Utils.CreateStubObject();
        
        var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        dgvRecordListControl.Refresh();
        var allSecurityRiskRatingRows = dgvRecordListControl.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["DataRecordPresenter", true], 10).toArray();
        for (var allSecurityRiskRatingRowsIndex = 0; allSecurityRiskRatingRowsIndex < allSecurityRiskRatingRows.length; allSecurityRiskRatingRowsIndex++){
            var DataRecordCellArea = allSecurityRiskRatingRows[allSecurityRiskRatingRowsIndex].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10);
            if (!DataRecordCellArea.Exists)
                continue;
            
            var securityRiskRatingRowLabelCell = DataRecordCellArea.FindChild(["ClrClassName", "WPFControlOrdinalNo", "WPFControlText"], ["CellValuePresenter", securityRiskRatingColumnIndex, securityRiskRatingName], 10);
            if (securityRiskRatingRowLabelCell.Exists)
                return allSecurityRiskRatingRows[allSecurityRiskRatingRowsIndex];
        }
        
        if (numTry == 1)
            dgvRecordListControl.Keys("[PageUp][PageUp][PageUp]");
        
        numTry++;
        dgvRecordListControl.Keys("[Down]");
        dgvRecordListControl.Refresh();
        return GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount, numTry);
    }
}



function Get_WinRiskAllocationConfigurationTool_DgvClientRiskObjectives_TxtRatingLevelMnemonicCodeCell(riskAllocationLevelName)
{    
    var riskAllocationLevelColumnHeaderName = (language == "french")? "Niveaux de répartition du risque (%)": "Risk allocation levels (%)";
    var mnemonicCodeColumnHeaderName = (language == "french")? "Codes Mnémoniques": "Mnemonic codes";
    var riskAllocationLevelColumnIndex = 1; //Default Index, the actual one will be retrieved according to the riskAllocationLevelColumnHeaderName (if not successfull, the default one will be used)
    var mnemonicCodeColumnIndex = 2; //Default Index, the actual one will be retrieved according to the mnemonicCodeColumnHeaderName (if not successfull, the default one will be used)
    
    var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);

    //Find Risk Allocation Level Column Index
    var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelColumnHeaderName], 10);
    if (riskAllocationLevelColumnHeader.Exists)
        riskAllocationLevelColumnIndex = riskAllocationLevelColumnHeader.WPFControlOrdinalNo;
    else
        Log.Warning("Risk Allocation Level Header '" + mnemonicCodeColumnHeaderName + "' not found. Consider the default index, riskAllocationLevelColumnIndex = " + riskAllocationLevelColumnIndex);
    
    //Find Mnemonic Code Column Index
    var mnemonicCodeColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", mnemonicCodeColumnHeaderName], 10);
    if (mnemonicCodeColumnHeader.Exists)
        mnemonicCodeColumnIndex = mnemonicCodeColumnHeader.WPFControlOrdinalNo;
    else
        Log.Warning("Mnemonic Code Header '" + mnemonicCodeColumnHeaderName + "' not found. Consider the default index, mnemonicCodeColumnIndex = " + mnemonicCodeColumnIndex);
    
    //Find Security Risk Allocation level Row and then return the according Mnemonic cell component
    var rowsCount = dgvRecordListControl.Items.Count;
    var riskAllocationLevelRow = GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount);
    if (riskAllocationLevelRow.Exists)
        return riskAllocationLevelRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", mnemonicCodeColumnIndex], 10).WPFObject("XamTextEditor", "", 1);
    
    Log.Error(aqString.Quote(riskAllocationLevelName) + " Security Risk Rating Allocation level row not found.");
    return Utils.CreateStubObject();
    
    
    function GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount, numTry)
    {
        numTry = (numTry == undefined)? 1: numTry++;
        
        if (numTry > rowsCount)
            return Utils.CreateStubObject();
        
        var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        dgvRecordListControl.Refresh();
        var allRiskAllocationLevelRows = dgvRecordListControl.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["DataRecordPresenter", true], 10).toArray();
        for (var allRiskAllocationLevelRowsIndex = 0; allRiskAllocationLevelRowsIndex < allRiskAllocationLevelRows.length; allRiskAllocationLevelRowsIndex++){
            var DataRecordCellArea = allRiskAllocationLevelRows[allRiskAllocationLevelRowsIndex].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10);
            if (!DataRecordCellArea.Exists)
                continue;
            
            var securityRiskRatingRowLabelCell = DataRecordCellArea.FindChild(["ClrClassName", "WPFControlOrdinalNo", "WPFControlText"], ["CellValuePresenter", riskAllocationLevelColumnIndex, riskAllocationLevelName], 10);
            if (securityRiskRatingRowLabelCell.Exists)
                return allRiskAllocationLevelRows[allRiskAllocationLevelRowsIndex];
        }
        
        if (numTry == 1)
            dgvRecordListControl.Keys("[PageUp][PageUp][PageUp]");
        
        numTry++;
        dgvRecordListControl.Keys("[Down]");
        dgvRecordListControl.Refresh();
        return GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount, numTry);
    }
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//****************************************** FENÊTRE RÉPARTITION D'ACTIFS (ASSET ALLOCATION WINDOW) ********************************************
//Tools --> Configurations 
function Get_WinAssetAllocation(){return Aliases.CroesusApp.winAssetAllocation}

function Get_WinAssetAllocation_LblDescription(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "Description:"], 10)}

function Get_WinAssetAllocation_TxtDescription(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinAssetAllocation_BtnLanguages(){return Get_WinAssetAllocation().FindChild("Uid", "Button_d168", 10)}

function Get_WinAssetAllocation_ChkReadOnly()
{
  if (language == "french"){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Lecture seulement"], 10)}
  else {return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Read-only"], 10)}
}

function Get_WinAssetAllocation_BtnOK(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinAssetAllocation_BtnCancel()
{
  if (language == "french"){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//---> fin  MenuTools_Get_functions



//--->   MenuTools_Get_functions
//****************************************** FENÊTRE DESCRIPTION (DESCRIPTION WINDOW) ********************************************
//Tools --> Configirations --> WinAssetAllocation --> clique sur la langue 
function Get_WinDescription(){return Aliases.CroesusApp.winDescription}

function Get_WinDescription_LblEnglishCanada(){return Get_WinDescription().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "English (Canada) :"], 10)}

function Get_WinDescription_TxtEnglishCanada(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinDescription_LblFrancaisCanada(){return Get_WinDescription().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "Français (Canada) :"], 10)}

function Get_WinDescription_TxtFrancaisCanada(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 10)}

function Get_WinDescription_BtnOK(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinDescription_BtnCancel()
{
  if (language == "french"){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//---> fin  MenuTools_Get_functions



//--->  MenuTools_Get_functions
//****************************************** FENÊTRE ASSIGNATION D'UN CLASSEMENT (MAP A CLASSIFICATION WINDOW) ********************************************
//Tools-->Configurations 
function Get_WinMapAClassification(){return Aliases.CroesusApp.winMapAClassification}

function Get_WinMapAClassification_LvwAccessLevel(){return Get_WinMapAClassification().FindChildEx(["ClrClassName", "Uid", "WPFControlOrdinalNo"], ["ListViewTable", "ListView_bc90", 1], 10)}

function Get_WinMapAClassification_LvwAccessLevel_LlbGlobalClassifications()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements globaux"], 10)}
  else {return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Global Classifications"], 10)}
}

function Get_WinMapAClassification_LvwAccessLevel_LlbFirmClassifications()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements de la firme"], 10)}
  else {return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Firm Classifications"], 10)}
}

function Get_WinMapAClassification_LvwAvailableClassifications(){return Get_WinMapAClassification().FindChildEx(["ClrClassName", "Uid", "WPFControlOrdinalNo"], ["ListViewTable", "ListView_bc90", 2], 10)}

function Get_WinMapAClassification_LvwAvailableClassifications_LlbSubcategories()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAvailableClassifications().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Sous-catégories"], 10)}
  else {return Get_WinMapAClassification_LvwAvailableClassifications().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Subcategories"], 10)}
}

function Get_WinMapAClassification_BtnOK(){return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinMapAClassification_BtnCancel()
{
  if (language == "french"){return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//****************************************** FENÊTRE OBJECTIF DE PLACEMENT (INVESTMENT OBJECTIVE WINDOW) ********************************************
//Tools--> Configuration
function Get_WinInvestmentObjective(){return Aliases.CroesusApp.winInvestmentObjective}

function Get_WinInvestmentObjective_BtnOK(){return Get_WinInvestmentObjective().FindChild("Uid", "Button_4800", 10)}

function Get_WinInvestmentObjective_BtnCancel(){return Get_WinInvestmentObjective().FindChild("Uid", "Button_5161", 10)}

function Get_WinInvestmentObjective_GrpInformation(){return Get_WinInvestmentObjective().FindChild("Uid", "GroupBox_f674", 10)}

function Get_WinInvestmentObjective_GrpInformation_TxtDescription(){return Get_WinInvestmentObjective_GrpInformation().FindChild("Uid", "LocaleTextbox_28a0", 10)}

function Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment(){return Get_WinInvestmentObjective_GrpInformation().FindChild("Uid", "IntegerTextBox_0d11", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass(){return Get_WinInvestmentObjective().FindChild("Uid", "GroupBox_9794", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass().FindChild("Uid", "DataGrid_8705", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass().FindChild("Uid", "GroupBox_d90d", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_ef48", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtMinimum(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_73f8", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtMaximum(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_bf2a", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(itemLabel)
{
    var itemObject = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", itemLabel], 10);
    
    if (!itemObject.Exists){
        Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Keys("[Home][Home]");
        do {
            var previousActiveRecordIndex = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Parent.ActiveRecord.Index;
            Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Keys("[PageDown]");
            var itemObject = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", itemLabel], 10);
            var newActiveRecordIndex = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Parent.ActiveRecord.Index;
        } while (!itemObject.Exists && newActiveRecordIndex != previousActiveRecordIndex)
    }
    
    return itemObject;
}

//---> fin  MenuTools_Get_functions


//---> MenuTools_Get_functions
//******************** FENÊTRE CONFIGURATION DES PROFILS ET DU DICTIONNAIRE (PROFILES AND DICTIONARY CONFIGURATION WINDOW) *********************
//Tools--> Configarations
function Get_WinProfilesAndDictionaryConfiguration(){return Aliases.CroesusApp.winProfilesAndDictionaryConfiguration}

function Get_WinProfilesAndDictionaryConfiguration_BtnClose(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_d7f6", 10)}


//Onglet Liste des profils (List of Profiles tab)

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_8ad0", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_87ea", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnAdd(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_70d5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnEdit(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_1ddd", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDelete(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_a526", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDetailedPreview(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2540", 10)}


//Onglet Groupes de profils (Groups of Profiles tab)

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_fd65", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_4d3d", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntEdit(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_6e21", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntDelete(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_3fe5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddSubGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2753", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_2aed", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "ComboBox_ffbe", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilGroupsGrid(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_e6c2", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnDeleteProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_204b", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilListGrid(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_9542", 10)}


//FENÊTRE ADD GROUP/ADD SUBGROUP

function Get_WinProfilGroupConfiguration(){return Aliases.CroesusApp.winProfilGroupConfiguration}

function Get_WinProfilGroupConfiguration_TxtDescription(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "LocaleTextbox_6523", 10)}

function Get_WinProfilGroupConfiguration_BtnOk(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "Button_9c0c", 10)}

function Get_WinProfilGroupConfiguration_BtnCancel(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "Button_7b3e", 10)}


//Onglet Dictionnaires (Dictionary tab)

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_2e9e", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_4d7b", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "DataGrid_b038", 10)}


//** Section Liste de dictionnaires **

//colonne Code
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colCode() {
    
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code"], 10)
}

//colonne French Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colFrenchDesc() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Description"], 10)
}

//colonne English Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colEnglishDesc() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Description"], 10)
}

//colonne Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colMnemonic() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnemonic"], 10)
}


//** Section Unités de dictionnaire **

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries(){
    return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_5964", 10);
}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(){
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries().FindChild("Uid", "DataGrid_ea69", 10);

}

//colonne Index
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colIndex() {
    
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Index"], 10)
}

//colonne Description en français / French Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchDesc() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Description"], 10)
}

//colonne Description en anglais / English Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishDesc() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Description"], 10)
}

//colonne Mnémonique en français / French Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchMnemonic() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Mnemonic"], 10)
}

//colonne Mnémonique en anglais / English Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishMnemonic() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Mnemonic"], 10)
}


function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnAdd(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_25bc", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnEdit(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_a5c5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnDelete(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_aa81", 10)}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENÊTRE AJOUTER/MODIFIER LE DICTIONNAIRE (ADD/EDIT DICTIONARY WINDOW) ************************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur ke btn Add 
function Get_WinCRUDictionary(){return Aliases.CroesusApp.winCRUDictionary}

function Get_WinCRUDictionary_BtnOK(){return Get_WinCRUDictionary().FindChild("Uid", "Button_7827", 10)}

function Get_WinCRUDictionary_BtnCancel(){return Get_WinCRUDictionary().FindChild("Uid", "Button_e0c7", 10)}

function Get_WinCRUDictionary_GrpDetail(){return Get_WinCRUDictionary().FindChild("Uid", "GroupBox_7589", 10)}

function Get_WinCRUDictionary_GrpDetail_LblFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_7696", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_9771", 10)}
}

function Get_WinCRUDictionary_GrpDetail_TxtFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_38e1", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_6ac3", 10)}
}

function Get_WinCRUDictionary_GrpDetail_LblEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_9771", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_7696", 10)}
}

function Get_WinCRUDictionary_GrpDetail_TxtEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_6ac3", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_38e1", 10)}
}

function Get_WinCRUDictionary_GrpDetail_LblMnemonic(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_8ee2", 10)}

function Get_WinCRUDictionary_GrpDetail_TxtMnemonic(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_cbd9", 10)}

function Get_WinCRUDictionary_GrpDetail_ChkReadOnly(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "CheckBox_e4cc", 10)}

function Get_WinCRUDictionary_GrpDetail_ChkLoadAtStartup(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "CheckBox_de0c", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "GroupBox_9e1e", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_a16b", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnEdit(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_f386", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnDelete(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_cee7", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "DataGrid_49a4", 10)}

//---> fin  MenuTools_Get_functions


//--->  MenuTools_Get_functions
//******************************* FENÊTRE AJOUTER/MODIFIER UNE UNITÉ DE DICTIONNAIRE (ADD/EDIT DICTIONARY ENTRY WINDOW) ****************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur ke btn Add 
//dans la fenêtre "Add Dictionary" --> cliquer sur le btn Add 
function Get_WinCRUDictionaryEntry(){return Aliases.CroesusApp.winCRUDictionaryEntry}

function Get_WinCRUDictionary_LblFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_b7c9", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_0b24", 10)}
}

function Get_WinCRUDictionary_TxtFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c5ec", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_9785", 10)}
}

function Get_WinCRUDictionary_LblEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_0b24", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_b7c9", 10)}
}

function Get_WinCRUDictionary_TxtEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_9785", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c5ec", 10)}
}

function Get_WinCRUDictionary_LblFrenchMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_6146", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_dfbb", 10)}
}

function Get_WinCRUDictionary_TxtFrenchMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_0ecd", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c4d9", 10)}
}

function Get_WinCRUDictionary_LblEnglishMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_dfbb", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_6146", 10)}
}

function Get_WinCRUDictionary_TxtEnglishMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c4d9", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_0ecd", 10)}
}

function Get_WinCRUDictionaryEntry_BtnOK(){return Get_WinCRUDictionaryEntry().FindChild("Uid", "Button_77ac", 10)}

function Get_WinCRUDictionaryEntry_BtnCancel(){return Get_WinCRUDictionaryEntry().FindChild("Uid", "Button_05e5", 10)}
//---> fin  MenuTools_Get_functions



//--->  MenuTools_Get_functions
//*********************************** FENÊTRE AJOUTER OU MODIFIER UN PROFIL (ADD OR EDIT PROFILE WINDOW) *************************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur la tab "List of Profiles" 
// --> cliquer sur le btn Add 
function Get_WinAddOrEditProfile(){return Aliases.CroesusApp.winAddOrEditProfile}

function Get_WinAddOrEditProfile_BtnOK(){return Get_WinAddOrEditProfile().FindChild("Uid", "Button_ecfc", 10)}

function Get_WinAddOrEditProfile_BtnCancel(){return Get_WinAddOrEditProfile().FindChild("Uid", "Button_5da3", 10)}


function Get_WinAddOrEditProfile_GrpProfile(){return Get_WinAddOrEditProfile().FindChild("Uid", "GroupBox_81dc", 10)}

function Get_WinAddOrEditProfile_GrpProfile_LblMnemonic(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "TextBlock_fc22", 10)}

function Get_WinAddOrEditProfile_GrpProfile_TxtMnemonic(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "TextBox_bf53", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDescription(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_b096", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_e958", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_1447", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblFrench(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_c699", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblEnglish(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_b79d", 10)}

//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_a528", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_0e09", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_b6eb", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_4843", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","1"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","2"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","3"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","4"], 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_5595", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblType(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_9ad0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "ComboBox_2ec0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblLenght(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_2a36", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtLenght(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "DoubleTextBox_e0f7", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblIncludingDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_937e", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblNumberOfDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_aa0b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtNumberOfDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "DoubleTextBox_7b44", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblDictionary(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_ce52", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtDictionaryCode(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBox_e283", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtDictionaryDescription(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBox_0e66", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_BtnChooseDictionary(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "Button_768a", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblAccessLevel(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_ac81", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "ComboBox_efc8", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemText()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Texte"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Text"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemNumeric()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Numérique"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Numeric"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemListDictionary()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Liste (Dictionnaire)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "List (Dictionary)"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemDate(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Date"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemCheckbox()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Case à cocher"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Checkbox"], 10)}
}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemOpenToAll(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_2749", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemReadOnly(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_efc4", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemRestrictedAccess(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_4401", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpModules(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_8615", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_LblGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "TextBlock_fd64", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_LblSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "TextBlock_0685", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkClients(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_0f0b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbClientsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_214a", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbClientsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_5759", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkAccounts(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_89a7", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbAccountsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_c956", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbAccountsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_4ff0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkRelationships(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_9347", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbRelationshipsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_a632", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbRelationshipsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_9fed", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkSecurities(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_bc10", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbSecuritiesGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_3a1b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbSecuritiesSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_6375", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_fbb6", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkExportToMSWord(){return Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn().FindChild("Uid", "CheckBox_235e", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkSearchCriteria(){return Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn().FindChild("Uid", "CheckBox_4ae2", 10)}


//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//******************** FENÊTRE D'AJOUT/ÉDITION DE CATÉGORIE DE TITRES (SECURITY CATEGORY EDIT WINDOW) *********************
//Tools--> Configurations 
function Get_WinAddSecurityCategorisation(){return Aliases.CroesusApp.winAddSecurityCategorisation}

function Get_WinAddSecurityCategorisationCancel(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "Button_78a8", 10)}

function Get_WinAddSecurityCategorisation_BtnSave(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "Button_ac14", 10)}


function Get_WinAddSecurityCategorisation_GrpDescription(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_ce60", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtEnglishDescription(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_5932", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtShortEnglishDesc(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_2b8c", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtFrenchDescription(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_4709", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtShortFrenchDesc(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_c35a", 10)}


function Get_WinAddSecurityCategorisation_GrpDefinition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_0de1", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbYield(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b46e", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbIntDivFrequency(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b742", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFactorSign(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_4773", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbDayCount(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_da6b", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "IntegerTextBox_900f", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_c8c0", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbDefaultCalculationFactor(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_8e31", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstr(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_e719", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstrDetail(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b1cc", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "IntegerTextBox_e02d", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_ae8d", 10)}


function Get_WinAddSecurityCategorisation_GrpDisplay(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_b99a", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbDisplayFactor(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_c360", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbNumberOfDecimals(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_d5c8", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_0664", 10)}


function Get_WinEditSecurityCategorisation_GrpInitialCondition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_6da7", 10)}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition(){return Get_WinEditSecurityCategorisation_GrpInitialCondition().FindChild("Uid", "ListBox_3457", 10)}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_BtnDelete(){return Get_WinEditSecurityCategorisation_GrpInitialCondition().FindChild("Uid", "Button_7198", 10)}


function Get_WinEditSecurityCategorisation_GrpSecondaryCondition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_499b", 10)}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions(){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition().FindChild("Uid", "ListView_af6b", 10)}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChFirstSecurityNo()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Premier no de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "First Security No"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChLastSecurityNo()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Dernier no de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Last Security No"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChType()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChSecurityClass()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Classe de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Security Class"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChFundCategory()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Catégorie du fonds"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Fund category"], 10)}
}




//DEFINITION DE LA CONDITION INITIALE DANS FENÊTRE D'ÉDITION DE CATÉGORIE DE TITRES(INITIAL CONDITION DEFINITION IN THE SECURITY CATEGORY EDIT WINDOW)

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl(partControlName)//Generic
{
    return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", partControlName], 10);
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(itemName) //Generic
{
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10);
}


function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbVerb()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Verbe>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Verb>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbField()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Champ>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Field>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbOperator()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Opérateur>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Operator>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbValue()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Valeur>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Value>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbNext()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Suivant>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Next>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbDot(){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl(".")}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_ItemDot(){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(".")}
//---> fin  MenuTools_Get_functions

//--->  MenuTools_Get_functions
//******************** FENÊTRE CONFIGURATION DE catégorisation des titres(SECURITY CATEGORISATION CONFIGURATION WINDOW) *********************

function Get_WinSecurityCategorisationConfigurations(){return Aliases.CroesusApp.winConfiguratorWindowSecurityCategorisation}

function Get_WinSecurityCategorisationConfigurationsBtnClose(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_f3fc", 10)}

function Get_WinSecurityCategorisationConfigurationsBtnAdd(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_b959", 10)}

function Get_WinSecurityCategorisationConfigurations_BtnEdit(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_33bd", 10)}

function Get_WinSecurityCategorisationConfigurations_BtnDelete(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_dfbb", 10)}
//---> fin  MenuTools_Get_functions

//--->   MenuTools_Get_functions
//******************** ARBORESCENCE DE LA FENÊTRE CONFIGURATION DE catégorisation des titres (SECURITY CATEGORISATION CONFIGURATION WINDOW TREEVIEW) *********************


function Get_WinSecurityCategorisationConfiguration_TvwTreeview(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "TreeView_d454", 10)}

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCurriencies()
{
  if (language == "french"){return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Devises"], 10)}
  else {return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Currencies"], 10)}
}

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCash()
{
  if (language == "french"){return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Encaisse"], 10)}
  else {return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Cash"], 10)}
}

/**
    Paramètre :
        categoryLabel : Nom réduit de la catégorie (exemple : 'Titres de croissance')
*/
function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel)
{
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].WPFObject("categoryLabel").WPFControlText == categoryLabel)
            return arrayOfTreeviewItems[i].WPFObject("categoryLabel");
    
    return Utils.CreateStubObject();
}



//Voir aussi la fonction : Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription)
function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription)
{
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems){
        var categoryLabel = arrayOfTreeviewItems[i].WPFObject("categoryLabel").WPFControlText;
        var objectSubcategoryDescription = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription);
        if (objectSubcategoryDescription.Exists)
            return objectSubcategoryDescription;
    }
    
    return Utils.CreateStubObject();;
}



/**
    Paramètres :
        categoryLabel : Nom réduit de la catégorie (exemple : 'Titres de croissance')
        subcategoryDescription : Nom simple ou Nom complet de la sous-catégorie (exemple : 'Actions ordinaires' ou 'Actions ordinaires (650)')
		
	Voir aussi la fonction : Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription)
*/
function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription)
{
	var nbOfDescriptionTextBlocks = (aqString.StrMatches(".+\\b\\(\\d+\\)", subcategoryDescription))? 4: 1;
	
    var categoryLabelObject = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel);
    if (!categoryLabelObject.Exists) Log.Message("Security Category label '" + categoryLabel + "' object not found");
    categoryLabelObject.Parent.set_IsExpanded(true);
    var arrayOfCategoryTreeviewItems = categoryLabelObject.Parent.FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfCategoryTreeviewItems){
        var currentSubcategoryFullDescription = ""
        for (var textBlockIndex = 1; textBlockIndex <= nbOfDescriptionTextBlocks; textBlockIndex++)
            currentSubcategoryFullDescription += arrayOfCategoryTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["TextBlock", true, textBlockIndex]).WPFControlText;
        
        if (Trim(currentSubcategoryFullDescription) == subcategoryDescription)
            return arrayOfCategoryTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["TextBlock", true, 1]);
    }
    
    return Utils.CreateStubObject();;
}
//---> fin  MenuTools_Get_functions

//--->  MenuTools_Get_functions
//******************************** FENÊTRE CONFIGURATION DE LA MATRICE DE FRAIS (FEE MATRIX CONFIGURATION WINDOW) ***************************************

function Get_WinFeeMatrixConfiguration(){return Aliases.CroesusApp.winFeeMatrixConfiguration}

function Get_WinFeeMatrixConfiguration_BtnOK(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_811d", 10)}

function Get_WinFeeMatrixConfiguration_BtnCancel(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_807a", 10)}

function Get_WinFeeMatrixConfiguration_BtnEdit(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_25b9", 10)}

function Get_WinFeeMatrixConfiguration_BtnMerge(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_289d", 10)}

function Get_WinFeeMatrixConfiguration_BtnSplit(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_7f40", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "GroupBox_8192", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions_LblAccruedID(){return Get_WinFeeMatrixConfiguration_GrpOptions().FindChild("Uid", "TextBlock_bc88", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID(){return Get_WinFeeMatrixConfiguration_GrpOptions().FindChild("Uid", "ComboBox_9e6b", 10)}

function Get_WinFeeMatrixConfiguration_GrpMinimumFees(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "GroupBox_0b37", 10)}
/*
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly()
{
  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Mensuelle:"], 10)}
  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Monthly:"], 10)}
}*/
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly(){return Get_WinFeeMatrixConfiguration().FindChild("WPFControlAutomationId", "TextBlock_967a_0", 10)}
//function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "1"], 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_0", 10)}
/*function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly()
{
  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Trimestrielle:"], 10)}
  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Quarterly:"], 10)}
}*/

function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_1", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_1", 10)}


//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "2"], 10)}
/*
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual()
{
  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Semestrielle:"], 10)}
  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Semiannual:"], 10)}
}*/
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_2", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_2", 10)}
//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "3"], 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_3", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_3", 10)}
/*
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual()
{
  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Annuelle:"], 10)}
  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Annual:"], 10)}
}*/

//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "4"], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "DataGrid_b3a1", 10)}


//***** En-têtes de colonne de la matrice de frais (Fee Matrix column headers) *****

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChTotalValue(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 1], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCash(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 2], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 3], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 4], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTerm(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 5], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 6], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 7], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTerm(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 8], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 9], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 10], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncome(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 11], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 12], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 13], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 14], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 15], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 16], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 17], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 18], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 19], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 20], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 21], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 22], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFund(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 23], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 24], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 25], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthers(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 26], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 27], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 28], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervals(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 29], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 30], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 31], 10)}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//******************************** FENÊTRE MODIFIER UNE VALEUR (EDIT FEE MATRIX RANGE WINDOW) ***************************************
//Tools/Configurations/Billing
function Get_WinEditRange(){return Aliases.CroesusApp.winEditRange}

function Get_WinEditRange_BtnOK(){return Get_WinEditRange().FindChild("Uid", "Button_0a82", 10)}

function Get_WinEditRange_BtnCancel(){return Get_WinEditRange().FindChild("Uid", "Button_beda", 10)}

function Get_WinEditRange_LblMessage(){return Get_WinEditRange().FindChild("Uid", "TextBlock_002c", 10)}

function Get_WinEditRange_LblMinimum(){return Get_WinEditRange().FindChild("Uid", "TextBlock_6b83", 10)}

function Get_WinEditRange_TxtMinimum(){return Get_WinEditRange().FindChild("Uid", "DoubleTextBox_8dba", 10)}

function Get_WinEditRange_LblMaximum(){return Get_WinEditRange().FindChild("Uid", "TextBlock_8fbd", 10)}

function Get_WinEditRange_TxtMaximum(){return Get_WinEditRange().FindChild("Uid", "DoubleTextBox_a5bc", 10)}



//************ BOITE DE DIALOGUE FUSIONNER UN INTERVALLE DE LA GRILLE DE VALIDATION (MERGE VALIDATION GRID RANGE DIALOG BOX) *************

function Get_DlgMergeValidationGridRange(){return Aliases.CroesusApp.dlgMergeValidationGridRange}

function Get_DlgMergeValidationGridRange_LblMessage(){return Get_DlgMergeValidationGridRange().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}

//******************************** FENÊTRE AJOUTER UNE VALEUR (ADD FEE MATRIX RANGE WINDOW) ***************************************

function Get_WinAddRange(){return Aliases.CroesusApp.winAddRange}

function Get_WinAddRange_BtnOK(){return Get_WinAddRange().FindChild("Uid", "Button_b71c", 10)}

function Get_WinAddRange_BtnCancel(){return Get_WinAddRange().FindChild("Uid", "Button_c380", 10)}

function Get_WinAddRange_LblSplitRangeAt(){return Get_WinAddRange().FindChild("Uid", "TextBlock_1f44", 10)}

function Get_WinAddRange_TxtSplitRangeAt(){return Get_WinAddRange().FindChild("Uid", "DoubleTextBox_31a6", 10)}

function Get_WinAddRange_LblMessage(){return Get_WinAddRange().FindChild("Uid", "TextBlock_150e", 10)}



//******************************** FENÊTRE CONFIGURATION DE LA FACTURATION (BILLING CONFIGURATION WINDOW) *********************************

function Get_WinBillingConfiguration(){return Aliases.CroesusApp.winBillingConfiguration}

function Get_WinBillingConfiguration_BtnOK(){return Get_WinBillingConfiguration().FindChild("Uid", "Button_30b2", 10)}

function Get_WinBillingConfiguration_BtnCancel(){return Get_WinBillingConfiguration().FindChild("Uid", "Button_36bf", 10)}


function Get_WinBillingConfiguration_TabFeeSchedule(){return Get_WinBillingConfiguration().FindChild("Uid", "TabItem_be16", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "DataGrid_9a9f", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_cc8f", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnEdit(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_3670", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnCopy(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_7eaa", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_9ba4", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_7d3d", 10)}


function Get_WinBillingConfiguration_TabValidationGrid(){return Get_WinBillingConfiguration().FindChild("Uid", "TabItem_7b14", 10)}

function Get_WinBillingConfiguration_TabValidationGrid_DgvFeeMatrix(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "DataGrid_b3a1", 10)}
//---> fin  MenuTools_Get_functions

//---> MenuTools_Get_functions
//******************************** FENÊTRE MISE À JOUR DU MODÈLE DE FRAIS (FEE TEMPLATE EDIT WINDOW) *********************************

function Get_WinFeeTemplateEdit(){return Aliases.CroesusApp.winFeeTemplateEdit}

function Get_WinFeeTemplateEdit_BtnOK(){return Get_WinFeeTemplateEdit().FindChild("Uid", "Button_80be", 10)}

function Get_WinFeeTemplateEdit_BtnCancel(){return Get_WinFeeTemplateEdit().FindChild("Uid", "Button_30b5", 10)}

function Get_WinFeeTemplateEdit_LblName(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_1a66", 10)}

function Get_WinFeeTemplateEdit_TxtName(){return Get_WinFeeTemplateEdit().FindChild("Uid", "LocaleTextbox_4095", 10)}

function Get_WinFeeTemplateEdit_LblAccess(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_3869", 10)}

function Get_WinFeeTemplateEdit_CmbAccess(){return Get_WinFeeTemplateEdit().FindChild("Uid", "PartyLevelComboBox_03e9", 10)}

function Get_WinFeeTemplateEdit_LblRatePattern(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_17c6", 10)}

function Get_WinFeeTemplateEdit_CmbRatePattern(){return Get_WinFeeTemplateEdit().FindChild("Uid", "ComboBox_1941", 10)}

function Get_WinFeeTemplateEdit_ChkTieredCalculationMethod(){return Get_WinFeeTemplateEdit().FindChild("Uid", "CheckBox_bb4c", 10)}

function Get_WinFeeTemplateEdit_ChkShowMinMax(){return Get_WinFeeTemplateEdit().FindChild("Uid", "CheckBox_dd31", 10)}

function Get_WinFeeTemplateEdit_DgvFeeTemplate(){return Get_WinFeeTemplateEdit().FindChild("Uid", "DataGrid_611f", 10)}



//************ BOITE DE DIALOGUE FACTURATION (BILLING DIALOG BOX) *************

function Get_DlgBilling(){return Aliases.CroesusApp.dlgBilling}

function Get_DlgBilling_LblMessage(){return Get_DlgBilling().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}

//************ BOITE DE DIALOGUE CONFIGURATION DE LA FACTURATION (BILLING CONFIGURATION DIALOG BOX) *************

function Get_DlgBillingConfiguration(){return Aliases.CroesusApp.dlgBillingConfiguration}

function Get_DlgBillingConfiguration_LblMessage(){return Get_DlgBillingConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}



//*** FENÊTRE DE MIGRATION DU MODÈLE DE FRAIS FENÊTRE CONVERTIR LA GRILLE DE VALIDATION (FEE TEMPLATE MIGRATION WINDOW - MIGRATE VALIDATION GRID WINDOW) ***

function Get_WinFeeTemplateMigration(){return Aliases.CroesusApp.winFeeTemplateMigration}

function Get_WinFeeTemplateMigration_BtnOK(){return Get_WinFeeTemplateMigration().FindChild("Uid", "Button_8cbe", 10)}

function Get_WinFeeTemplateMigration_BtnCancel(){return Get_WinFeeTemplateMigration().FindChild("Uid", "Button_7a82", 10)}


function Get_WinFeeTemplateMigration_GrpOutdatedGrid(){return Get_WinFeeTemplateMigration().FindChild("Uid", "GroupBox_38b7", 10)}

function Get_WinFeeTemplateMigration_GrpOutdatedGrid_ChkShowMinMax(){return Get_WinFeeTemplateMigration().FindChild("Uid", "CheckBox_4883", 10)}

function Get_WinFeeTemplateMigration_GrpOutdatedGrid_DgvOutdatedFeeTemplate(){return Get_WinFeeTemplateMigration_GrpOutdatedGrid().FindChild("Uid", "DataGrid_611f", 10)}


function Get_WinFeeTemplateMigration_GrpCurrentGrid(){return Get_WinFeeTemplateMigration().FindChild("Uid", "GroupBox_2b72", 10)}

function Get_WinFeeTemplateMigration_GrpCurrentGrid_ChkShowMinMax(){return Get_WinFeeTemplateMigration().FindChild("Uid", "CheckBox_134c", 10)}

function Get_WinFeeTemplateMigration_GrpCurrentGrid_DgvFeeTemplate(){return Get_WinFeeTemplateMigration_GrpCurrentGrid().FindChild("Uid", "DataGrid_611f", 10)}
//---> fin  MenuTools_Get_functions

//-->  MenuTools_Get_Functions
//**************************************** FENÊTRE AJOUTER UN FICHIER (ADD A FILE WINDOW) ********************************************
//Tools-->Archive me Documents --> icone Add
function Get_WinAddAFile(){return Aliases.CroesusApp.winAddAFile}

function Get_WinAddAFile_GrpFile(){return Get_WinAddAFile().FindChild("Uid", "GroupBox_e74d", 10)}

function Get_WinAddAFile_GrpFile_TxtFilePath(){return Get_WinAddAFile_GrpFile().FindChild("Uid", "TextBox_d91c", 10)}

function Get_WinAddAFile_GrpFile_BtnBrowse(){return Get_WinAddAFile_GrpFile().FindChild("Uid", "Button_c96e", 10)}

function Get_WinAddAFile_GrpComments(){return Get_WinAddAFile().FindChild("Uid", "GroupBox_e2dc", 10)}

function Get_WinAddAFile_GrpComments_TxtComments(){return Get_WinAddAFile_GrpComments().FindChild("Uid", "TextBox_e3f6", 10)}

function Get_WinAddAFile_BtnOK(){return Get_WinAddAFile().FindChild("Uid", "Button_a77f", 10)}

function Get_WinAddAFile_BtnCancel(){return Get_WinAddAFile().FindChild("Uid", "Button_1dd6", 10)}
//--> fin  MenuTools_Get_Functions

//****************************** Fonctions Get liés à la fenêtre Outils/Configuration/Profils et Dictionnaire/Groupes de Profils ****************************

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemRelation(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Relations"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Relationships"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemClient(){
   return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Clients"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemAccount(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Comptes"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Accounts"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemSecurity(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Titres"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Securities"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnAddProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2d47", 10)}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnEditProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_0a73", 10)}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnDetailledPreview(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_12fd", 10)}

//Ajout de fonctions Get pour les fenêtres Outils / Configurations / rapports / configuration des rapports / Niveau global / sélectionner le rapport
//Ajouté par Abdel
//Date 15/11/2019
function  Get_WinConfigurations_LvwListView_ReportConfiguration(){
          if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration des rapports"], 10)}
          else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Report Configuration"], 10)}
        }
function Get_WinReportConfiguration(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinReportConfiguration_BtnGroup(){ 
    if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName","WPFControlText"],["UniGroupBox","Groupe"],10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName","WPFControlText"],["UniGroupBox","Group"],10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
}

function Get_WinReportConfiguration_BtnCopyTo(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copier _vers..."], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copy _To..."], 10)}
}
function Get_WinReportConfiguration_BtnDelete(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}
function Get_WinReportConfiguration_BtnClose(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"], 10)}
}
function Get_WinReportConfiguration_BtnEdit(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier..."], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit..."], 10)}
}
function Get_WinReportConfiguration_UniList(){ 
  if (language == "french"){return Get_WinReportConfiguration().WPFObject("UniGroupBox", "Sélectionner un rapport", 2).WPFObject("UniList", "", 1)}
  else      return Get_WinReportConfiguration().WPFObject("UniGroupBox", "Select a Report", 2).WPFObject("UniList", "", 1);
}

function Get_WinCopyReport(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinCopyReport_CmbUser(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Utilisateur"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "User"], 100)}
}

function Get_WinCopyReport_ChkReadOnly(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Lecture seulement"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Read-Only"], 100)}
}

function Get_WinCopyReport_RdoFirm(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firme"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firm"], 100)}
}

function Get_WinCopyReport_RdoBranch(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Succursale"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Branch"], 100)}
}

function Get_WinCopyReport_RdoWorkgroup(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Équipe de travail"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Workgroup"], 100)}
}

function Get_WinCopyReport_ChkReportNotAvailable(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rapport non visible"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Report not Available"], 100)}
}

function Get_WinCopyReport_TxtDescriprion(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 100)}
}

function Get_WinCopyReport_BtnOK(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 100)}

function Get_WinCopyReport_BtnCancel(){
         if (language == "french"){return Get_WinCopyReport().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
         else {return Get_WinCopyReport().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}
function Get_WinReportConfigurationCopy(){return Get_CroesusApp().FindChild("Uid", "ReportConfigurationWindow", 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_5489", 10)}

//function Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_18a5", 10)}
function Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault(){return Get_WinReportConfigurationCopy().FindChild(["Uid","WPFControlName"],["CheckBox_18a5", "chkUsesDefaultLiabilityDisclaimer"], 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer(){return Get_WinReportConfigurationCopy().FindChild(["Uid", "WPFControlOrdinalNo"], ["LocaleTextbox_ff77", 1], 10)}
//function Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_ff77", 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers_TextBoxReportNotes(){
      return Get_WinReportConfigurationCopy().FindChild(["Uid",  "WPFControlOrdinalNo"], ["TextBox_990e", 1], 10)}
      
function Get_WinReportConfigurationCopy_TabLayout(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_b207", 10)}

function Get_WinReportConfigurationCopy_TabLayout_ChkUseDefault(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_e5eb", 10)}

function Get_WinReportConfigurationCopy_TabLayout_CmbReportLayout(){return Get_WinReportConfigurationCopy().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinReportConfigurationCopy_BtnCancel(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_620a", 10)}

function Get_WinReportConfigurationCopy_BtnAddToRight(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_6c18", 10)} 

function Get_WinReportConfigurationCopy_BtnAddToLeft(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_b18f", 10)}

function Get_WinReportConfigurationCopy_TabContent(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_02ec", 10)}

function Get_WinReportConfigurationCopy_TabContent_LstColumnsRight(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ListBox_e04f",10)}

function Get_WinReportConfigurationCopy_TabProperties(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_0b147", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportName(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_53a3", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_f592", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportNameWhenChkUseTheReportNameIsChecked(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TextBox_a606", 10)}

function Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_bc37", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtOwner(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TextBox_3664", 10)}

function Get_WinReportConfigurationCopy_Columns(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ListBox_8888", 10)}

function Get_WinReportConfigurationCopy_TabProperties_CmbOwner(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ComboBox_08ee", 10)}

function Get_WinReportConfigurationCopy_TabProperties_ChkReportNotAvailable(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_d447", 10)}

function Get_WinReportConfigurationCopy_BtnOK(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_02fe", 10)}

function Get_Reports_GrpReports_TabReports_LvwReport(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"], 10)} //no uid

function Get_WinReportConfigurationCopy_TabParameters(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_3985", 10)}

function Get_WinReportConfigurationCopy_TabParameters_ChkReportUsesDefault(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_2929", 10)}

function Get_WinReportConfigurationCopy_TabParameters_CmbEndDate(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ComboBox_2929", 10)}

function Get_WinReportConfiguration_BtnGroup_ItemUser(){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["MenuItem","Utilisateur"],10)}
    else {return Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["MenuItem","User"],10)}
} 

//***********************  Fenêtre Gestionnaire de campagnes  ************************************
//Outils --Gérer les campagnes
//function Get_WinCampaignManager(){ return CroesusApp.Findchild("Uid", "CampaignManager_61ee") }  //Ne fonctionne pas avec le Uid
function Get_WinCampaignManager(){return Aliases.CroesusApp.WPFObject("HwndSource: _campaignManager").WPFObject("_campaignManager")}

function Get_WinCampaignManager_btnAdd(){return Get_WinCampaignManager().FindChild("Uid", "Button_eb10", 10)}

function Get_WinCampaignManager_btnClose(){return Get_WinCampaignManager().FindChild("Uid", "Button_8de6", 10)}


//fenêtre Ajouter campagne
//function Get_WinAddCampaign(){ return CroesusApp.Findchild( "Uid", "CampaignEditor_9c54") }  //Ne fonctionne pas avec le Uid
function Get_WinAddCampaign() {return Aliases.CroesusApp.WPFObject("HwndSource: _campaignEditor").WPFObject("_campaignEditor")}

function Get_WinAddCampaign_Name() {return Get_WinAddCampaign().FindChild("Uid", "LocaleTextbox_44d8", 10)}

function Get_WinAddCampaign_btnClose() {return Get_WinAddCampaign().FindChild("Uid", "Button_f703", 10)}


//Onglet "Target clients"
function Get_WinAddCampaign_TabTargetClients() {return Get_WinAddCampaign().FindChild("Uid", "TabItem_6a57", 10)}

function Get_WinAddCampaign_TabTargetClients_btnAdd() {return Get_WinAddCampaign().FindChild("Uid", "Button_8cb4", 10)}


//Onglet "Activities"
function Get_WinAddCampaign_TabActivities() {return Get_WinAddCampaign().FindChild("Uid", "TabItem_a82c", 10)}

function Get_WinAddCampaign_TabActivities_btnAdd() {return Get_WinAddCampaign().FindChild("Uid", "Button_b6bb", 10)}


//Fenêtre "Ajouter une activité"
function Get_WinAddActivity() {
    if (language == "french")
        return Aliases.CroesusApp.WPFObject("HwndSource: StepWindow", "Ajouter une activité").WPFObject("StepWindow", "Ajouter une activité", 1)
    else
        return Aliases.CroesusApp.WPFObject("HwndSource: StepWindow", "Add an Activity").WPFObject("StepWindow", "Add an Activity", 1)        
}

function Get_WinAddActivity_Media() {return Get_WinAddActivity().FindChild("Uid", "ComboBox_9e60", 10)}

function Get_WinAddActivity_btnCancel() {return Get_WinAddActivity().FindChild("Uid", "Button_a26c", 10)}

function Get_WinAddActivity_btnOK() {return Get_WinAddActivity().FindChild("Uid", "Button_46ae", 10)}

//************************************* FENÊTRE Gabarits de comptes à gestion unifiée   (Unified managed account templates) *************************
//Outils/ Configurations/ Comptes à gestion unifiée
function Get_WinUnifiedManagedAccountTemplates(){return Get_CroesusApp().FindChild("Uid", "ManagerWindow_730e", 10)};

function Get_WinUnifiedManagedAccountTemplates_DgTemplates(){return Get_WinUnifiedManagedAccountTemplates().FindChild("Uid", "DataGrid_010e", 10)};

function Get_WinUnifiedManagedAccountTemplates_BtnAssign(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Associer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Assign"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnAdd(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Aj_outer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","_Add"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnEdit(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Mo_difier"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","_Edit"],10)}
} 


function Get_WinUnifiedManagedAccountTemplates_BtnDelete(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","S_upprimer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","De_lete"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnCopy(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Cop_ier"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Cop_y"],10)}
} 


//************************************* FENÊTRE Ajouter un gabarit de compte à gestion unifiée  (Add a unified managed account template) *************************
//Outils/ Configurations/ Comptes à gestion unifiée
function Get_WinAddUnifiedManagedAccountTemplate(){return Get_CroesusApp().FindChild("Uid", "SleevesManagerWindow_fbcd", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_DgSleeves(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "DataGrid_df77", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_TxtName(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "LocaleTextbox_c0e3", 10)};
        
function Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "CheckBox_af20", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_CmbAccess(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "ComboBox_0b3c", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnAdd(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_9c81", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnDelete(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_e77d", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnEdit(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_39ef", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnSave(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_b82c", 10)};