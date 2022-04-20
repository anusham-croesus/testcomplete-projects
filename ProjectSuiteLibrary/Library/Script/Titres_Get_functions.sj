//USEUNIT Common_Get_functions


//******************************* BAR SECURITIES **********************************************
function Get_SecuritiesBar(){return Aliases.CroesusApp.winMain.SecurityPlugin.barPadHeader}

function Get_SecuritiesBar_BtnInfo(){return Get_SecuritiesBar().FindChild("Uid", "Button_57e0", 10)} //ok 

function Get_SecuritiesBar_BtnHistoricalData(){return Get_SecuritiesBar().FindChild("Uid", "Button_6672", 10)} //ok 

function Get_SecuritiesBar_BtnTotalHeld(){return Get_SecuritiesBar().FindChild("Uid", "Button_7f1d", 10)} //ok

function Get_SecuritiesBar_BtnExchangeRate(){return Get_SecuritiesBar().FindChild("Uid", "Button_dd38", 10)} //ok

function Get_SecuritiesBar_BtnRiskRatingManager(){return Get_SecuritiesBar().FindChild("Uid", "Button_f919", 10)}



//******************************* WIN CREATE SECURITY *****************************************  
function Get_WinCreateSecurity(){return Aliases.CroesusApp.winCreateSecurity}

function Get_WinCreateSecurity_BtnOK(){return Get_WinCreateSecurity().FindChild("Uid", "Button_3f1e", 10)} //ok 

function Get_WinCreateSecurity_BtnCancel(){return Get_WinCreateSecurity().FindChild("Uid", "Button_8510", 10)} //ok 

function Get_WinCreateSecurity_GrpFinancialInstrument(){return Get_WinCreateSecurity().FindChild("Uid", "GroupBox_3f6c", 10)}

function Get_WinCreateSecurity_GrpFinancialInstrument_RdoReal(){return Get_WinCreateSecurity_GrpFinancialInstrument().FindChild("Uid", "RadioButton_3ada", 10)}

function Get_WinCreateSecurity_GrpFinancialInstrument_RdoManual(){return Get_WinCreateSecurity_GrpFinancialInstrument().FindChild("Uid", "RadioButton_49be", 10)}

function Get_WinCreateSecurity_LstCategories(){return Get_WinCreateSecurity().FindChild("Uid", "ListBox_2582", 10)}

function Get_WinCreateSecurity_LstCategories_Item(financialInstrumentDisplayedName){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Value"], ["ListBoxItem", financialInstrumentDisplayedName], 10)} //Générique

function Get_WinCreateSecurity_LstCategories_ItemEquity(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Stock"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemMutualFund(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "MutualFund"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemBond(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Bond"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemOption(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Option"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemIndex(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Index"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemFutures(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Future"], 10)}

function Get_WinCreateSecurity_LstCategories_ItemOther(){return Get_WinCreateSecurity_LstCategories().FindChild(["ClrClassName", "DataContext.Key"], ["ListBoxItem", "Other"], 10)}



//***************************** FENÊTRE INFO TITRE (WIN : INFO SECURITY) *****************************************

function Get_WinInfoSecurity(){return Aliases.CroesusApp.winInfoSecurity}

function Get_WinInfoSecurity_BtnOK(){return Get_WinInfoSecurity().FindChild("Uid", "Button_7bb8", 10)} //ok

function Get_WinInfoSecurity_BtnCancel(){return Get_WinInfoSecurity().FindChild("Uid", "Button_17c0", 10)} //ok

function Get_WinInfoSecurity_BtnApply(){return Get_WinInfoSecurity().FindChild("Uid", "Button_f8e0", 10)} //ok

function Get_WinInfoSecurity_GrpDescription(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_fefc", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblSubCategory(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_905f", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_CmbSubCategory(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_06af", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblFrenchDescription() 
{
    if (language == "french")
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_1480", 10);
    else
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_f809", 10);
}

function Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription()
{
    if (language == "french")
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_f2a5", 10);
    else
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_8fad", 10);
}

function Get_WinInfoSecurity_GrpDescription_LblEnglishDescription()
{
    if (language == "french")
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_f809", 10);
    else
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_1480", 10);
}

function Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription()
{
    if (language == "french")
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_8fad", 10);
    else
        return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_f2a5", 10);
}

function Get_WinInfoSecurity_GrpDescription_LblDescription(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_1480", 10)}//for US

function Get_WinInfoSecurity_GrpDescription_TxtDescription(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_f2a5", 10)}//for US

//Non disponible pour les types d'instrument financier Option, Obligation
function Get_WinInfoSecurity_GrpDescription_LblIndustryCode(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_2599", 10)}//ok [secteur dans automation4]

//Non disponible pour les types d'instrument financier Option, Obligation
function Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_9196", 10)}//ok [secteur dans automation4]

function Get_WinInfoSecurity_GrpDescription_LblCountry(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_e7ac", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_CmbCountry(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_462a", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblCurrency(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_8ff6", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_CmbCurrency(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_f730", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblCalculationFactor(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_357f", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_5886", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblUpdatedOn(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_d72b", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_TxtUpdatedOn(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DateField_7b3a", 10)} //ok

//Disponible pour les types Action, Contrat à terme //Non disponible pour les types Fonds d'investissement, Option, Obligation, autre
function Get_WinInfoSecurity_GrpDescription_LblConversionDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_fc29", 10)} //ok

//Disponible pour les types Action, Contrat à terme //Non disponible pour les types Fonds d'investissement, Option, Obligation, autre
function Get_WinInfoSecurity_GrpDescription_TxtConversionDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DateField_2e0f", 10)} //ok

//Non disponible pour les types Action, Fonds d'investissement, Option, autre //Disponible pour les types Obligation, Contrat à terme
function Get_WinInfoSecurity_GrpDescription_LblIssueDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_a565", 10)} //ok

//Non disponible pour les types Action, Fonds d'investissement, Option, autre //Disponible pour les types Obligation, Contrat à terme
function Get_WinInfoSecurity_GrpDescription_TxtIssueDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DateField_bc75", 10)} //ok

//Disponible seulement pour le type Option
function Get_WinInfoSecurity_GrpDescription_LblOptionType(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_1aa7", 10)} //ok

//Disponible seulement pour le type Option
function Get_WinInfoSecurity_GrpDescription_CmbOptionType(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_138d", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblCreationDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_cadf", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtCreationDate(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DateField_c3e1", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblDiscrMgmt(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_58ff", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_7f3f", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblSecurity(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_209f", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtSecurity(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_064a", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblCUSIP(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_75a4", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtCUSIP(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_a076", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblTypeClass(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_c882", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtTypeClass(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_66f4", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_LblISIN(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_a264", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_TxtISIN(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CustomTextBox_0c3c", 10)} //ok

//Disponible pour les types Option, Contrat à terme
function Get_WinInfoSecurity_GrpDescription_LblStrikePrice(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_bf42", 10)}//ok

//Disponible pour les types Option, Contrat à terme
function Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DoubleTextBox_78a0", 10)}//ok

//Disponible pour le type Option
function Get_WinInfoSecurity_GrpDescription_LblExpiration(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_8cb2", 10)} //ok

//Disponible pour le type Option
function Get_WinInfoSecurity_GrpDescription_TxtExpiration(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "DateField_2d81", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_LblRiskRating(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_28cd", 10)}

function Get_WinInfoSecurity_GrpDescription_CmbRiskRating(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_c140", 10)}

function Get_WinInfoSecurity_GrpDescription_ChkOverwrite(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "CheckBox_8714", 10)}

function Get_WinInfoSecurity_GrpDescription_LblRiskRatingSource(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "TextBlock_8a18", 10)}

function Get_WinInfoSecurity_GrpDescription_CmbRiskRatingSource(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "UniComboBox_9a64", 10)}


function Get_WinInfoSecurity_GrpDescription_GrpMarket(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "GroupBox_a544", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainMarket(){return Get_WinInfoSecurity_GrpDescription_GrpMarket().FindChild("Uid", "TextBlock_1452", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(){return Get_WinInfoSecurity_GrpDescription_GrpMarket().FindChild("Uid", "UniComboBox_2c7e", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainSymbol(){return Get_WinInfoSecurity_GrpDescription_GrpMarket().FindChild("Uid", "TextBlock_ac1f", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(){return Get_WinInfoSecurity_GrpDescription_GrpMarket().FindChild("Uid", "CustomTextBox_d3c0", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(){return Get_WinInfoSecurity_GrpDescription_GrpMarket().FindChild("Uid", "Button_b79e", 10)}//ok


function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous(){return Get_WinInfoSecurity_GrpDescription().FindChild("Uid", "GroupBox_3663", 10)}//ok

//function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblNonRedeemable(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "TextBlock_520d", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "CheckBox_3b4a", 10)}//ok

//function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblExcludeFromTheForeignPropertyReport(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "TextBlock_0faf", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "CheckBox_ce32", 10)}//ok

function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblForeignProperty(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "TextBlock_f9bf", 10)} //ok

function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "UniComboBox_5c92", 10)}//ok

//N'existe pas dans le common (ref. Automation 7)
//function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblExcludeFromBilling(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "TextBlock_25", 10)} 

//N'existe pas dans le common (ref. Automation 7)
//function Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromBilling(){return Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().FindChild("Uid", "CheckBox_3", 10)} 


//Onglet Info (Info tab)

function Get_WinInfoSecurity_TabInfo(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_e492", 10)}//ok


function Get_WinInfoSecurity_TabInfo_GrpPrice(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_66fc", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_LblBid(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "TextBlock_d57c", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "DoubleTextBox_e894", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_LblAsk(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "TextBlock_9e2b", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "DoubleTextBox_8166", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_LblClose(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "TextBlock_ab7e", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "DoubleTextBox_63e0", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_LblCurrency(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "TextBlock_c328", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "UniComboBox_39d9", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_LblUpdatedOn(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "TextBlock_ab77", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpPrice_TxtUpdatedOn(){return Get_WinInfoSecurity_TabInfo_GrpPrice().FindChild("Uid", "DateField_c9be", 10)} //ok


//Groupe Achats disponible pour le type d'instrument financier Fonds d'investissement
function Get_WinInfoSecurity_TabInfo_GrpBuys(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_e32d", 10)} //ok

function Get_WinInfoSecurity_TabInfo_GrpBuys_LblInitialAmount(){return Get_WinInfoSecurity_TabInfo_GrpBuys().FindChild("Uid", "TextBlock_6fc3", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpBuys_TxtInitialAmount(){return Get_WinInfoSecurity_TabInfo_GrpBuys().FindChild("Uid", "DoubleTextBox_69b0", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpBuys_LblSubsequentAmount(){return Get_WinInfoSecurity_TabInfo_GrpBuys().FindChild("Uid", "TextBlock_cb72", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount(){return Get_WinInfoSecurity_TabInfo_GrpBuys().FindChild("Uid", "DoubleTextBox_16cb", 10)}//ok


// Tab Dividends
function Get_WinInfoSecurity_TabDividendsHistory_Grid(){return Get_WinInfoSecurity().FindChild("Uid","DataGrid_5c3f",10)}

function Get_WinInfoSecurity_TabDistributionHistory(){return Get_WinInfoSecurity().FindChild("Uid","TabItem_645b",10)}

function Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende exceptionnel"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Special Dividend"], 10)
}


function Get_WinInfoSecurity_TabDividendsHistory_ChSource(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)}

function Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu(){return Aliases.CroesusApp.subMenus.WPFObject("ColumnPickerMenu", "", 1);}
function Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn(){
  return Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu().WPFObject("MenuItem", "Add Column", 1);
}

function Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn_ChSpecialDividend(){
  return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: SpecialDividend"], 10);
}

function Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn_ChSource(){
  return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: SpecialDividendSource"], 10);
}


//Groupe Dividendes non disponible pour le type d'instrument financier Option
function Get_WinInfoSecurity_TabInfo_GrpDividends(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_3b4b", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpDividends_LblFrequency(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_6b07", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpDividends_CmbFrequency(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "UniComboBox_5c21", 10)} //ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblRate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_6b85", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DoubleTextBox_503b", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpDividends_LblCurrency(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_cf52", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCurrency(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "UniComboBox_b814", 10)}//ok

//Disponible pour le type d'instrument financier Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblExpiration(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_f2de", 10)}//ok

//Disponible pour le type d'instrument financier Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExpiration(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_bc39", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblMaturity(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_f2de", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_bc39", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblFirstCoupon(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_ab2a", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtFirstCoupon(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_ce59", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblCompoundingMethod(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_3404", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCompoundingMethod(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "UniComboBox_2417", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallPrice(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_d641", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtCallPrice(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DoubleTextBox_4f7d", 10)}//ok

//Non disponible pour les types d'instrument financier Fonds d'investissement, autre
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_532c", 10)}//ok

//Non disponible pour les types d'instrument financier Fonds d'investissement, autre
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtCallDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_d9f1", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblPrincipalFactor(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_7915", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPrincipalFactor(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DoubleTextBox_54cb", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblAccruedInterest(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_6526", 10)}//ok

//Disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtAccruedInterest(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DoubleTextBox_d597", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblAmountUnit(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_379c", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtAmountUnit(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DoubleTextBox_4a18", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblRecordDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_8206", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_4e48", 10)} //ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblExDividendDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_a7e3", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExDividendDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_e010", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_LblPaymentDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "TextBlock_f1a9", 10)}//ok

//Non disponible pour le type d'instrument financier Obligation
function Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPaymentDate(){return Get_WinInfoSecurity_TabInfo_GrpDividends().FindChild("Uid", "DateField_f7ab", 10)}//ok


//Groupe Rendement, non disponible pour le type d'instrument financier Option
function Get_WinInfoSecurity_TabInfo_GrpYield(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_3276", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketNominal(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "TextBlock_1725", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketNominal(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "DoubleTextBox_98b9", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketEffective(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "TextBlock_719f", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketEffective(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "DoubleTextBox_8dbf", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpYield_LblMarketYield(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "TextBlock_e208", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpYield_TxtMarketYield(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "DoubleTextBox_9c75", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Fonds d'investissement
function Get_WinInfoSecurity_TabInfo_GrpYield_LblModifiedDuration(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "TextBlock_93e1", 10)}//ok

//Disponible pour les types d'instrument financier Obligation, Fonds d'investissement
function Get_WinInfoSecurity_TabInfo_GrpYield_TxtModifiedDuration(){return Get_WinInfoSecurity_TabInfo_GrpYield().FindChild("Uid", "DoubleTextBox_2884", 10)}//ok


//Groupe Titre sous-jacent, disponible pour les types d'instrument financier Option, Contrat à terme
function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_f40d", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblDescription(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "TextBlock_e4c3", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtDescription(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "CustomTextBox_ff8b", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSecurity(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "TextBlock_6b41", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSecurity(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "CustomTextBox_4dd8", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSymbol(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "TextBlock_fcc3", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSymbol(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "CustomTextBox_d613", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblClose(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "TextBlock_25d8", 10)}//ok

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtClose(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "DoubleTextBox_464e", 10)}//ok

//N'existe pas dans le common (ref. Automation 7)
//function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange(){return Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().FindChild("Uid", "Button_5", 10)} 


//Onglet Répartition de l'actif (Asset Allocation tab) //Disponible pour les sous-catégories suivantes du type d'instrument financier Fonds d'investissement :
//Fonds d'actions canadiennes, Fonds d'actions européennes, Fonds d'actions américaines, Fonds d'actions nord-américaines, Fonds d'actions internationales,
//Fonds de placement équilibré, Fonds immobilier, Fonds d'actions globales, Fonds d'actions - Asie et côte pacifique, Fonds de placement spéciaux,
//Fonds de placement alternatifs, Fonds d'obligations internationales et fonds à revenu.

//FBN
function Get_WinInfoSecurity_TabAssetAllocation(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_6226", 10)}


//Onglet Composition de l'indice (Index Composition tab)
//Disponible pour les indices

function Get_WinInfoSecurity_TabIndexComposition(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_459b", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex1(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_54ed", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_77c0", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex1TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex1Value(){return Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex1ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex2(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_97aa", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_40ec", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex2TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex2Value(){return Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex2ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex3(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_f24d", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_0614", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex3TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex3Value(){return Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex3ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex4(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_66a4", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index4ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_1bae", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex4TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index4ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex4Value(){return Get_WinInfoSecurity_TabIndexComposition_Index4ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex4ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index4ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex5(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_9b24", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index5ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_6351", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex5TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index5ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex5Value(){return Get_WinInfoSecurity_TabIndexComposition_Index5ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex5ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index5ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex6(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_9c6b", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index6ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_17cb", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex6TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index6ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex6Value(){return Get_WinInfoSecurity_TabIndexComposition_Index6ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex6ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index6ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex7(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_825c", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index7ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_786e", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex7TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index7ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex7Value(){return Get_WinInfoSecurity_TabIndexComposition_Index7ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex7ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index7ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex8(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_cc4f", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index8ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_7d81", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex8TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index8ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex8Value(){return Get_WinInfoSecurity_TabIndexComposition_Index8ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex8ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index8ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex9(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_e872", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index9ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_f480", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex9TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index9ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex9Value(){return Get_WinInfoSecurity_TabIndexComposition_Index9ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex9ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index9ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_LblIndex10(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_6b4a", 10)}

function Get_WinInfoSecurity_TabIndexComposition_Index10ContentControl(){return Get_WinInfoSecurity().FindChild("Uid", "ContentControl_21d1", 10)}

function Get_WinInfoSecurity_TabIndexComposition_CmbIndex10TypePicker(){return Get_WinInfoSecurity_TabIndexComposition_Index10ContentControl().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinInfoSecurity_TabIndexComposition_TxtIndex10Value(){return Get_WinInfoSecurity_TabIndexComposition_Index10ContentControl().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabIndexComposition_BtnIndex10ListPicker(){return Get_WinInfoSecurity_TabIndexComposition_Index10ContentControl().FindChild("Uid", "ListPickerExec_9344", 10)}


function Get_WinInfoSecurity_TabIndexComposition_TxtTotalPercentValue(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_30cc", 10)}



//Onglet Historique de prix (Price History tab)

function Get_WinInfoSecurity_TabPriceHistory(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_5506", 10)}//ok
function GetWinEditHistoricalData(){return Aliases.CroesusApp.winEditHistoricalData}

function GetWinEditHistoricalDataTxtBid(){return GetWinEditHistoricalData().FindChild("Uid", "DoubleTextBox_95c7", 10)}
function GetWinEditHistoricalData_TxtAsk(){return GetWinEditHistoricalData().FindChild("Uid", "DoubleTextBox_59e5", 10)}
function GetWinEditHistoricalData_TxtClose(){return GetWinEditHistoricalData().FindChild("Uid", "DoubleTextBox_243e", 10)}
function GetWinEditHistoricalData_BtnCancel(){return GetWinEditHistoricalData().FindChild("Uid", "Button_63da", 10)}

//Non disponible pour les types d'instrument financier Obligation, Contrat à terme, autre
function Get_WinInfoSecurity_TabPriceHistory_BtnEdit(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_be28", 10)}//?

function Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_67f6", 10)}//?

function Get_WinInfoSecurity_TabPriceHistory_ChDate(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_ChBid(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_ChAsk(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_ChClose(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_ChCurrency(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "5"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "6"], 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_Grid_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)}

function Get_WinInfoSecurity_TabPriceHistory_Grid(){return Get_WinInfoSecurity().FindChild("Uid", "DataGrid_8414", 10)}//ok

function Get_WinInfoSecurity_TabPriceHistory_Grid_BtnQuickFilters_ContextMenu_Date(){return Get_WinInfoSecurity_TabPriceHistory_Grid_ContextMenu().FindChild("WPFControlText", "Date", 10)}

//Onglet Historique de dividendes (Dividends History tab) //Non disponible pour le type d'instrument financier Option

function Get_WinInfoSecurity_TabDividendsHistory(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_645b", 10)}//ok

function Get_WinInfoSecurity_TabDividendsHistory_ChRecordDate()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date d'enregistrement"], 10);
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Record Date"], 10);
}//ok

function Get_WinInfoSecurity_TabDividendsHistory_ChExDividendDate()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date ex-dividende"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ex-Dividend Date"], 10)
}//ok

function Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de versement"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Payment Date"], 10)
}//ok

function Get_WinInfoSecurity_TabDividendsHistory_ChDividend()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividendes"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividends"], 10)
}//ok

function Get_WinInfoSecurity_TabDividendsHistory_ChTotalDistributions()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total des distrib."], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Distributions"], 10)
}

function Get_WinInfoSecurity_TabDividendsHistory_ChCapitalGains()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gains en capital"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital Gains"], 10)
}

function Get_WinInfoSecurity_TabDividendsHistory_ChInterest()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêts"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)
}

function Get_WinInfoSecurity_TabDividendsHistory_ChROC(){
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RDC"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "ROC"], 10)
}

function Get_WinInfoSecurity_TabDividendsHistory_ChForeignDividends()
{
    if (language=="french") return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividendes étrangers"], 10)
    else return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Foreign Dividends"], 10)
}


//Onglet Événements corporatifs (Corporate Actions tab) //Non disponible pour les types d'instrument financier Option, Fonds d'investissement, Contrat à terme

function Get_WinInfoSecurity_TabCorporateActions(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_d1fb", 10)}//ok

function Get_WinInfoSecurity_TabCorporateActions_ChType(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)} //ok

function Get_WinInfoSecurity_TabCorporateActions_ChRatio(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinInfoSecurity_TabCorporateActions_ChEffectiveDate(){return Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}//ok


//Onglet Cotations de crédit (Credit Ratings tab) //Non disponible pour le type d'instrument financier Fonds d'investissement


function Get_WinInfoSecurity_TabRatings(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_b886", 10)} //ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_ff91", 10)}//ok

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource1(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_cc79", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource1(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_81f7", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating1(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_230b", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating1(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_6df5", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource2(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_25c8", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource2(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_ee2e", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating2(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_2565", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating2(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_9753", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource3(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_d0e3", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource3(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_7e95", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating3(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_5c77", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating3(){return Get_WinInfoSecurity().FindChild("Uid", "CustomTextBox_e957", 10)}//ok 

function Get_WinInfoSecurity_TabRatings_GrpRiskRating(){return Get_WinInfoSecurity().FindChild("Uid", "GroupBox_1045", 10)}//ok

function Get_WinInfoSecurity_tabRatings_GrpRiskRating_CmbRiskRating(){return Get_WinInfoSecurity().FindChild("Uid", "UniComboBox_49f0", 10)}//ok


//Onglet Profils (Profiles tab)

function Get_WinInfoSecurity_TabProfiles(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_6ead", 10)}//ok

function Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "CheckBox_9862", 10)}//ok

function Get_WinInfoSecurity_TabProfiles_BtnSetup(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_06f8", 10)}//ok


//Onglet Sites Internet (Internet Sites tab)

function Get_WinInfoSecurity_TabInternetSites(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_43da", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_LblAnalysis(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBlock_e9dc", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_TxtAnalysis(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBox_d22e", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_BtnAnalysis(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_7046", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_LblCompany(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBlock_b9bd", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_TxtCompany(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBox_c1f6", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_BtnCompany(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_534e", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_LblGraphs(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBlock_4033", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_TxtGraphs(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBox_45b2", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_BtnGraphs(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_ce2d", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_LblNews(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBlock_c9d4", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_TxtNews(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBox_0419", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_BtnNews(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_7a45", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_LblQuotes(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBlock_6e43", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_TxtQuotes(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "TextBox_6fad", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_BtnQuotes(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "Button_7a45", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses(){return Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).FindChild("Uid", "GroupBox_ac8f", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnAdd(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild("Uid", "Button_adb7", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnDelete(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild("Uid", "Button_c352", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnOpenURL(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild("Uid", "Button_92a7", 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChURL(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChDescription(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList(){return Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//ok


//Onglet Integration (automation7)

function Get_WinInfoSecurity_TabIntegrations(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_c83e", 10)} //ok automation7

function Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(){return Get_WinInfoSecurity().FindChild("Uid","TabControl_eced").FindChild("Uid","UniComboBox_55df",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_LblIndentifier() {return Get_WinInfoSecurity().FindChild("Uid","TextBlock_e8c4",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType() {return Get_WinInfoSecurity().FindChild("Uid","UniComboBox_5c86",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue() {return Get_WinInfoSecurity().FindChild("Uid", "TextBox_65ed", 10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_LblTradingCountry() {return Get_WinInfoSecurity().FindChild("Uid","TextBlock_4455",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_TxtTradingCountry() {return Get_WinInfoSecurity().FindChild("Uid","TextBox_38a1",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_LblSecurityType() {return Get_WinInfoSecurity().FindChild("Uid","TextBlock_9b0f",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_CmbSecurityType() {return Get_WinInfoSecurity().FindChild("Uid","UniComboBox_3c7e",10)} //For Morningstar integration

function Get_WinInfoSecurity_TabIntegrations_LblSymbol() {return Get_WinInfoSecurity().FindChild("Uid","TextBlock_2129",10)} //For Fund Allocation integration

function Get_WinInfoSecurity_TabIntegrations_TxtSymbol() {return Get_WinInfoSecurity().FindChild("Uid","TabControl_eced").FindChild("Uid","TextBox_8401",10)} //For Fund Allocation integration

function Get_WinInfoSecurity_TabIntegrations_LblCUSIP() {return Get_WinInfoSecurity().FindChild("Uid","TextBlock_c83d",10)} //For Fund Allocation integration

function Get_WinInfoSecurity_TabIntegrations_TxtCUSIP() {return Get_WinInfoSecurity().FindChild("Uid","TabControl_eced").FindChild("Uid","TextBox_5f36",10)} //For Fund Allocation integration


//Onglet GP1859 (PW1859 tab)

function Get_WinInfoSecurity_TabPW1859(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_8ba7", 10)}

function Get_WinInfoSecurity_TabPW1859_LblRemoveFromReports(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_bfc1", 10)}

function Get_WinInfoSecurity_TabPW1859_ChkRemoveFromReports(){return Get_WinInfoSecurity().FindChild("Uid", "CheckBox_88f5", 10)}

function Get_WinInfoSecurity_TabPW1859_LblAssetAllocation(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_5215", 10)}

function Get_WinInfoSecurity_TabPW1859_TxtAssetAllocation(){return Get_WinInfoSecurity().FindChild("Uid", "TextBox_8280", 10)}

function Get_WinInfoSecurity_TabPW1859_LblManager(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_6724", 10)}

function Get_WinInfoSecurity_TabPW1859_CmbManager(){return Get_WinInfoSecurity().FindChild("Uid", "UniComboBox_3a22", 10)}

function Get_WinInfoSecurity_TabPW1859_LblMandate(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_91d2", 10)}

function Get_WinInfoSecurity_TabPW1859_CmbMandate(){return Get_WinInfoSecurity().FindChild("Uid", "UniComboBox_799a", 10)}

function Get_WinInfoSecurity_TabPW1859_LblPerformanceIndex(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_965d", 10)}

function Get_WinInfoSecurity_TabPW1859_TxtPerformanceIndex(){return Get_WinInfoSecurity().FindChild("Uid", "ListPicker_123e", 10).FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinInfoSecurity_TabPW1859_LblReferenceAccount(){return Get_WinInfoSecurity().FindChild("Uid", "TextBlock_dff8", 10)}

function Get_WinInfoSecurity_TabPW1859_TxtReferenceAccount(){return Get_WinInfoSecurity().FindChild("Uid", "ListPicker_f818", 10).FindChild("Uid", "TextBox_f1d5", 10)}


//Onglet Notes (Notes tab)

function Get_WinInfoSecurity_Notes(){return Get_WinInfoSecurity().FindChild("Uid", "TabItem_bc2e", 10)}


//********************* SECURITIES QUICK SEARCH (TITRES - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinSecuritiesQuickSearch_RdoDescription(){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Description - Description"], 10)}

function Get_WinSecuritiesQuickSearch_RdoCurPrice()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PriceCurrency - Devise prix"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PriceCurrency - Cur. Price"], 10)}
}

function Get_WinSecuritiesQuickSearch_RdoSymbol()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Symbol - Symbole"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Symbol - Symbol"], 10)}
}

function Get_WinSecuritiesQuickSearch_RdoSecurity()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SecuFirm - Titre"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SecuFirm - Security"], 10)}
}

function Get_WinSecuritiesQuickSearch_RdoType(){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Type - Type"], 10)}



//************************* FENÊTRE SOMMATION DES TITRES (SECURITY SUM WINDOW) ***************************************

function Get_WinSecuritySum(){return Aliases.CroesusApp.winSecuritySum}

function Get_WinSecuritySum_BtnClose(){return Get_WinSecuritySum().FindChild("Uid", "Button_104c", 10)}//ok

function Get_WinSecuritySum_GrpFinancialInstruments(){return Get_WinSecuritySum().FindChild("Uid", "GroupBox_ff3f", 10)}//ok

function Get_WinSecuritySum_GrpFinancialInstruments_DgvFinancialInstrumentsSum(){return Get_WinSecuritySum_GrpFinancialInstruments().FindChild("Uid", "DataGrid_b282", 10)}

function Get_WinSecuritySum_chDescription(){return Get_WinSecuritySum().FindChild("WPFControlText", "Description", 10)}//ok

function Get_WinSecuritySum_chNumber()//ok
{
  if(language=="french"){return Get_WinSecuritySum().FindChild("WPFControlText", "Nombre", 10)}
  else {return Get_WinSecuritySum().FindChild("WPFControlText", "Count", 10)}
}

//************************** SECURITY GRID **************************************

function Get_SecurityGrid(){return Aliases.CroesusApp.winMain.SecurityPlugin.securityGrid}

//Entêtes de colonne (Column headers)

function Get_SecurityGrid_ChDescription(){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_SecurityGrid_ChSymbol()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_SecurityGrid_ChSecurity()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_SecurityGrid_ChSubCategory()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_SecurityGrid_ChType(){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_SecurityGrid_ChBid()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_SecurityGrid_ChAsk()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_SecurityGrid_ChClose()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_SecurityGrid_ChCurrencyPrice()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise prix"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cur. Price"], 10)}
}

function Get_SecurityGrid_ChMY()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RM (%)"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MY (%)"], 10)}
}

function Get_SecurityGrid_ChYTMMarket()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rend. éché. - Marché (%)"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "YTM - Market (%)"], 10)}
}

function Get_SecurityGrid_ChExcludeFromBilling()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclu de la facturation"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclude from Billing"], 10)}
}

function Get_SecurityGrid_ChMarket()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bourse"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market"], 10)}
}

function Get_SecurityGrid_ChDividendDate()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de dividende"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend Date"], 10)}
}

function Get_SecurityGrid_ChDividend()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_SecurityGrid_ChMaturity()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_SecurityGrid_ChFrequency()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_SecurityGrid_ChFinancialInstrument()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_SecurityGrid_ChInterest()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêt"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_SecurityGrid_ChInitialAmount()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Montant initial"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Initial Amount"], 10)}
}

function Get_SecurityGrid_ChSubsequentAmount()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Montant subséquent"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subsequent Amount"], 10)}
}

function Get_SecurityGrid_ChNonRedeemable()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non rachetable"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non-redeemable"], 10)}
}

function Get_SecurityGrid_ChRegion()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_SecurityGrid_ChDiscrMgmt()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gestion discr."], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discr. Mgmt"], 10)}
}

function Get_SecurityGrid_ChManager()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gestionnaire"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Manager"], 10)}
}

function Get_SecurityGrid_ChMandate()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mandat"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mandate"], 10)}
}

function Get_SecurityGrid_ChRiskRating()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Risk Rating"], 10)}
}

function Get_SecurityGrid_ChRiskRatingSource()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prov. de la cote de risque"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Risk Rating Source"], 10)}
}

function Get_SecurityGrid_ChOverwrite()
{
  if (language=="french"){return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écraser"], 10)}
  else {return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Overwrite"], 10)}
}

function Get_SecurityGrid_ChManualOverwrite(){
  if (language=="french") return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Manuel prioritaire"], 10)
  else  return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Manual overwrite"], 10)
}

function Get_SecurityGrid_ChLastRatingChange(){
  if (language=="french") return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière modification de cote"], 10)
  else  return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Rating Change"], 10)
}

function Get_SecurityGrid_ChAnalystCoverage(){
  if (language=="french") return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Suivi des analystes"], 10)
  else  return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Analyst Coverage"], 10)
}

//Menu contextuel sur le grid (Contextual menu on the grid)

function Get_SecurityGrid_ContextualMenu(){return Get_SubMenus().FindChild("Uid", "ContextMenu_473c", 10)}//ok


function Get_SecurityGrid_ContextualMenu_AddANote(){return Get_SecurityGrid_ContextualMenu().Find("Uid", "MenuItem_06c2", 10)}

function Get_SecurityGrid_ContextualMenu_Edit(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_e0de", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Detail(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_3031", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Add(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_f884", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Delete(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid","CFMenuItem_7e47", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Copy(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_c493", 10)}//ok

function Get_SecurityGrid_ContextualMenu_CopyWithHeader(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_4ef5",10)}//ok

function Get_SecurityGrid_ContextualMenu_ExportToFile(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_9577", 10)}//ok

function Get_SecurityGrid_ContextualMenu_ExportToMSExcel(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_584c", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Info(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_16a8", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Print(){return Get_SecurityGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFMenuItem", 19], 10)}//19 90-04-32 //CP : Modification pour Co (WPFControlOrdinalNo changé de 21 à 19)


function Get_SecurityGrid_ContextualMenu_SortBy(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "MenuItem_4dc9", 10)}//ok

function Get_SecurityGrid_ContextualMenu_SortBy_Description(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10)}//ok

function Get_SecurityGrid_ContextualMenu_SortBy_Symbol(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "2"], 10)}//ok

function Get_SecurityGrid_ContextualMenu_SortBy_Security(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "3"], 10)}//ok


function Get_SecurityGrid_ContextualMenu_Functions(){return Get_SecurityGrid_ContextualMenu().FindChild("Uid", "MenuItem_a7eb", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b089", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_HistoricalData(){return Get_CroesusApp().FindChild("Uid", "MenuItem_d1ea",10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_TotalHeld(){return Get_CroesusApp().FindChild("Uid", "MenuItem_4e01", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_ExchangeRate(){return Get_CroesusApp().FindChild("Uid", "MenuItem_faca", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Models(){return Get_CroesusApp().FindChild("Uid","CFMenuItem_7356", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Relationships(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_8eaf", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Clients(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_9384", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Accounts(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0fd8",10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Portfolio(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_e58e", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Transactions(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_354d", 10)}//ok

function Get_SecurityGrid_ContextualMenu_Functions_Securities(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_76db", 10)}//ok


function Get_SecurityGrid_ContextualMenu_Help(){return Get_SecurityGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "18"], 10)}//ok

function Get_SecurityGrid_ContextualMenu_Help_ContextSensitiveHelp()//ok
{
if(language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}
function Get_SecurityGrid_ContextualMenu_Help_ContentsAndIndex()//ok
{
if(language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}


//*********************************************************** FENÊTRE TOTAL DÉTENU (TOTAL HELD WINDOW) *************************************************************

function Get_WinTotalHeld(){return Aliases.CroesusApp.winTotalHeld}

function Get_WinTotalHeld_BtnClose(){return Get_WinTotalHeld().FindChild("Uid", "Button_77ab", 10)}//ok

function Get_WinTotalHeld_BtnCancel(){return Get_WinTotalHeld().FindChild("Uid", "Button_f3d0", 10)}//ok

//(ref. Automation 7)
function Get_WinTotalHeld_BtnCalculate(){return Get_WinTotalHeld().FindChild("Uid", "TextBlock_9aff", 10)}//ok

function Get_WinTotalHeld_LblDisplayCurrency(){return Get_WinTotalHeld().FindChild("Uid", "Label_5871", 10)}//ok

function Get_WinTotalHeld_CmbDisplayCurrency(){return Get_WinTotalHeld().FindChild("Uid", "ComboBox_09db", 10)}//ok

function Get_WinTotalHeld_LblNumberOfAccounts(){return Get_WinTotalHeld().FindChild("Uid", "Label_378b", 10)}//ok

function Get_WinTotalHeld_LblNumberOfAccountsValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_ec7b", 10)}//ok

function Get_WinTotalHeld_LblMarketValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_af91", 10)}//ok

function Get_WinTotalHeld_LblMarketValueValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_8056", 10)}//ok

function Get_WinTotalHeld_LblBookValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_67cd", 10)}//ok
// function get pour Cost Basis pour US
function Get_WinTotalHeld_LblCostBasis(){return Get_WinTotalHeld().FindChild("Uid", "Label_67cd", 10)}//ok

function Get_WinTotalHeld_LblBookValueValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_d034", 10)}//ok

function Get_WinTotalHeld_LblBalance(){return Get_WinTotalHeld().FindChild("Uid", "Label_9581", 10)}//ok

function Get_WinTotalHeld_LblBalanceValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_d034", 10)}//ok

function Get_WinTotalHeld_LblAccruedIntDiv(){return Get_WinTotalHeld().FindChild("Uid", "Label_8fae", 10)}//ok

function Get_WinTotalHeld_LblAccruedIntDivValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_a6d8", 10)}//ok

function Get_WinTotalHeld_LblAnnualIncome(){return Get_WinTotalHeld().FindChild("Uid", "Label_1ded", 10)}//ok

function Get_WinTotalHeld_LblAnnualIncomeValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_14b1", 10)}//ok

function Get_WinTotalHeld_LblTotalQuantity(){return Get_WinTotalHeld().FindChild("Uid", "Label_9351", 10)}//ok

function Get_WinTotalHeld_LblTotalQuantityValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_2242", 10)}//ok

//N'existe pas dans le common (ref. Automation 7)
function Get_WinTotalHeld_LblBeta(){return Get_WinTotalHeld().FindChild("Uid", "Label_21d3", 10)}

//N'existe pas dans le common (ref. Automation 7)
//function Get_WinTotalHeld_LblBetaValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_19", 10)}

function Get_WinTotalHeld_LblSecurityCurrency(){return Get_WinTotalHeld().FindChild("Uid", "Label_e638", 10)}//ok

function Get_WinTotalHeld_LblSecurityCurrencyValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_673f", 10)}//ok

function Get_WinTotalHeld_LblAverageCostYield(){return Get_WinTotalHeld().FindChild("Uid", "Label_72fb", 10)}//ok

function Get_WinTotalHeld_LblAverageCostYieldValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_1cb5", 10)}//ok

function Get_WinTotalHeld_LblModDurationAvg(){return Get_WinTotalHeld().FindChild("Uid", "Label_850e", 10)}//ok

function Get_WinTotalHeld_LblModDurationAvgValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_56c5", 10)}//ok

function Get_WinTotalHeld_LblAccumIntDiv(){return Get_WinTotalHeld().FindChild("Uid", "Label_2cee", 10)}//ok

function Get_WinTotalHeld_LblAccumIntDivValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_b5a4", 10)}//ok

function Get_WinTotalHeld_LblAccumulatedCommission(){return Get_WinTotalHeld().FindChild("Uid", "Label_616a", 10)}//ok

function Get_WinTotalHeld_LblAccumulatedCommissionValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_1736", 10)}//ok

function Get_WinTotalHeld_LblPercentOfTotalUnderManagement(){return Get_WinTotalHeld().FindChild("Uid", "Label_6615", 10)}//ok

function Get_WinTotalHeld_LblPercentOfTotalUnderManagementValue(){return Get_WinTotalHeld().FindChild("Uid", "Label_1761", 10)}//ok



//****************************************************** FENÊTRE TAUX DE CHANGE (EXCHANGE RATE WINDOW) *************************************************************

function Get_WinExchangeRate(){return Aliases.CroesusApp.winExchangeRate}

function Get_WinExchangeRate_BtnClose(){return Get_WinExchangeRate().FindChild("Uid", "Button_252e", 10)}//ok

function Get_WinExchangeRate_BtnSetup(){return Get_WinExchangeRate().FindChild("Uid", "Button_4b98", 10)}//ok


//Onglet Table d'équivalence (Equivalence Table tab)

function Get_WinExchangeRate_TabEquivalenceTable(){return Get_WinExchangeRate().FindChild("Uid", "TabItem_56ec", 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_LblCurrency(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_2ee3", 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency(){return Get_WinExchangeRate().FindChild("Uid", "UniComboBox_40ed", 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_LblDate(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_9ed3", 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_txtDate(){return Get_WinExchangeRate().FindChild("Uid", "DateField_6db1", 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_ChColumn1(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_ChColumn2(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinExchangeRate_TabEquivalenceTable_ChColumn3(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}//ok


//Onglet Cours croisés (Cross Rates tab)

function Get_WinExchangeRate_TabCrossRates(){return Get_WinExchangeRate().FindChild("Uid", "TabItem_a70f", 10)}//ok

function Get_WinExchangeRate_TabCrossRates_LblDate(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_ffce", 10)}//ok

function Get_WinExchangeRate_TabCrossRates_txtDate(){return Get_WinExchangeRate().FindChild("Uid", "DateField_c04c", 10)}//ok

function Get_WinExchangeRate_TabCrossRates_DgvRates(){return Get_WinExchangeRate().FindChild("Uid", "DataGrid_69c0", 10)}

function Get_WinExchangeRate_TabCrossRates_ChColumn1(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn2(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn3(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn4(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn5(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "5"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn6(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "6"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn7(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "7"], 10)}//ok
// SA:ajout des fonctions get pour CIBC

function Get_WinExchangeRate_TabCrossRates_ChColumn8(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "8"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn9(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "9"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn10(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "10"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn11(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "11"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn12(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "12"], 10)}//ok

function Get_WinExchangeRate_TabCrossRates_ChColumn13(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "13"], 10)}//ok

//Onglet Historique (History tab)

function Get_WinExchangeRate_TabHistory(){return Get_WinExchangeRate().FindChild("Uid", "TabItem_c56e", 10)}//ok

function Get_WinExchangeRate_TabHistory_LblCurrency(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_ed19", 10)}//ok

function Get_WinExchangeRate_TabHistory_CmbCurrency(){return Get_WinExchangeRate().FindChild("Uid", "UniComboBox_0126", 10)}//ok

function Get_WinExchangeRate_TabHistory_LblFrom(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_5e6b", 10)}//ok

function Get_WinExchangeRate_TabHistory_txtFrom(){return Get_WinExchangeRate().FindChild("Uid", "DateField_8234", 10)}//ok

function Get_WinExchangeRate_TabHistory_LblTo(){return Get_WinExchangeRate().FindChild("Uid", "TextBlock_9ed5", 10)}//ok

function Get_WinExchangeRate_TabHistory_txtTo(){return Get_WinExchangeRate().FindChild("Uid", "DateField_1eb2", 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn1(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn2(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn3(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn4(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn5(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "5"], 10)}//ok

function Get_WinExchangeRate_TabHistory_ChColumn6(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "6"], 10)}//ok


//Currency Selection window

function Get_WinCurrencySelection(){return Aliases.CroesusApp.winCurrencySelection}

function Get_WinCurrencySelection_BtnOK(){return Get_WinCurrencySelection().FindChild("Uid", "Button_f25c", 10)}

function Get_WinCurrencySelection_BtnCancel(){return Get_WinCurrencySelection().FindChild("Uid", "Button_241d", 10)}



//*********************************************************** FENÊTRE CRITÈRES DE CLASSIFICATION DU RISQUE (RISK RATING CRITERIA MANAGER WINDOW) *************************************************************

function Get_WinRiskRatingCriteriaManager(){return Aliases.CroesusApp.winRiskRatingCriteriaManager}

function Get_WinRiskRatingCriteriaManager_BarPadHeader(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "PadHeader_6d2a", 10)}

function Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(){return Get_WinRiskRatingCriteriaManager_BarPadHeader().FindChild("Uid", "Button_0fb7", 10)}

function Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(){return Get_WinRiskRatingCriteriaManager_BarPadHeader().FindChild("Uid", "Button_e6d4", 10)}

function Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(){return Get_WinRiskRatingCriteriaManager_BarPadHeader().FindChild("Uid", "Button_168c", 10)}

function Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(){return Get_WinRiskRatingCriteriaManager_BarPadHeader().FindChild("Uid", "Button_3560", 10)}

function Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnView(){return Get_WinRiskRatingCriteriaManager_BarPadHeader().FindChild("Uid", "Button_cf16", 10)}


function Get_WinRiskRatingCriteriaManager_LblRatingMethods(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "TextBlock_40db", 10)}

function Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_2a25", 10)}

function Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_8989", 10)}

function Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_d1cd", 10)}

function Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_dd7e", 10)}

function Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManual(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_5fb7", 10)}


function Get_WinRiskRatingCriteriaManager_BtnSendToProduction(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_6275", 10)}

function Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_61fd", 10)}

function Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_1cf0", 10)}

function Get_WinRiskRatingCriteriaManager_BtnClose(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "Button_000a", 10)}


function Get_WinRiskRatingCriteriaManager_TabProduction(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "TabItem_94fc", 10)}

function Get_WinRiskRatingCriteriaManager_TabSimulation(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "TabItem_af05", 10)}



//Entêtes de colonnes du grid "Sous-catégories par défaut" ("Default subcategories" grid Columns headers)

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "DataGrid_fe7c", 10)}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_HeaderLabelArea(){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChRating()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rating"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChCorrespondingSecurities()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titres correspondants"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Corresponding securities"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChProductionFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production final"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSimulationFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation final"], 10)}
}



//Entêtes de colonnes du grid "Critères simples et prioritaires" ("Basic/Overwrite criteria" grid Columns headers)

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "DataGrid_1797", 10)}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea(){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rating"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé par"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created by"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modifié"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction()
{
  return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production"], 10);
}

function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production final"], 10)}
}

//Only available for Simulation
function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Actif"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Active"], 10)}
}

//Only available for Simulation
function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation()
{
  return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation"], 10);
}

//Only available for Simulation
function Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation final"], 10)}
}



//Entêtes de colonnes du grid "Évaluation de risque externe" ("External risk rating feed" grid Columns headers)

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "DataGrid_c845", 10)}

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_HeaderLabelArea(){return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChRating()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rating"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChCorrespondingSecurities()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titres correspondants"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Corresponding securities"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChProductionFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Production final"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChSimulationFinal()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation - finale"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Simulation final"], 10)}
}



//Entêtes de colonnes du grid "Manuel" ("Manual" grid Columns headers)

function Get_WinRiskRatingCriteriaManager_DgvManual(){return Get_WinRiskRatingCriteriaManager().FindChild("Uid", "DataGrid_ea61", 10)}

function Get_WinRiskRatingCriteriaManager_DgvManual_HeaderLabelArea(){return Get_WinRiskRatingCriteriaManager_DgvManual().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_WinRiskRatingCriteriaManager_DgvManual_ChRating()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvManual().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvManual().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rating"], 10)}
}

function Get_WinRiskRatingCriteriaManager_DgvManual_ChCorrespondingSecurities()
{
  if (language == "french"){return Get_WinRiskRatingCriteriaManager_DgvManual().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titres correspondants"], 10)}
  else {return Get_WinRiskRatingCriteriaManager_DgvManual().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Corresponding securities"], 10)}
}



//*********************************************************** FENÊTRE EDITION DE CRITÈRES DE CLASSIFICATION DU RISQUE (RISK RATING CRITERIA EDITOR WINDOW) *************************************************************

function Get_WinRiskRatingCriteriaEditor(){return Aliases.CroesusApp.winRiskRatingCriteriaEditor}

function Get_WinRiskRatingCriteriaEditor_LblName(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TextBlock_97e2", 10)}

function Get_WinRiskRatingCriteriaEditor_TxtName(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "LocaleTextbox_b5e8", 10)}

function Get_WinRiskRatingCriteriaEditor_LblDescription(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TextBlock_e9f3", 10)}

function Get_WinRiskRatingCriteriaEditor_TxtDescription(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "LocaleTextbox_9422", 10)}

function Get_WinRiskRatingCriteriaEditor_LblCondition(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TextBlock_0961", 10)}

function Get_WinRiskRatingCriteriaEditor_LstCondition(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "ListBox_3457", 10)}

function Get_WinRiskRatingCriteriaEditor_BtnSimulateCriterion(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "Button_7bc9", 10)}

function Get_WinRiskRatingCriteriaEditor_BtnSave(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "Button_8471", 10)}

function Get_WinRiskRatingCriteriaEditor_BtnCancel(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "Button_4e0e", 10)}


function Get_WinRiskRatingCriteriaEditor_GrpStatus(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "GroupBox_64cf", 10)}

function Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive(){return Get_WinRiskRatingCriteriaEditor_GrpStatus().FindChild("Uid", "CheckBox_ad4a", 10)}

function Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwrite(){return Get_WinRiskRatingCriteriaEditor_GrpStatus().FindChild("Uid", "CheckBox_f35c", 10)}


function Get_WinRiskRatingCriteriaEditor_GrpRating(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "GroupBox_629d", 10)}

function Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow(){return Get_WinRiskRatingCriteriaEditor_GrpRating().FindChild("Uid", "RadioButton_9b60", 10)}

function Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium(){return Get_WinRiskRatingCriteriaEditor_GrpRating().FindChild("Uid", "RadioButton_d2a0", 10)}

function Get_WinRiskRatingCriteriaEditor_GrpRating_RdoHigh(){return Get_WinRiskRatingCriteriaEditor_GrpRating().FindChild("Uid", "RadioButton_4289", 10)}


function Get_WinRiskRatingCriteriaEditor_TabProduction(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TabItem_db1c", 10)}

function Get_WinRiskRatingCriteriaEditor_TabProductionFinal(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TabItem_8051", 10)}

function Get_WinRiskRatingCriteriaEditor_TabSimulation(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TabItem_ee3e", 10)}

function Get_WinRiskRatingCriteriaEditor_TabSimulationFinal(){return Get_WinRiskRatingCriteriaEditor().FindChild("Uid", "TabItem_d584", 10)}



//DEFINITION DES CONDITIONS (CONDITIONS DEFINITION)

function Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(partControlName)//Generic
{
 return Get_WinRiskRatingCriteriaEditor_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", partControlName], 10);
}

function Get_WinRiskRatingCriteriaEditor_LstCondition_Item(itemName) //Generic
{
  return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10);
}



//*********************************************************** FENÊTRE ENVOYER EN PRODUCTION (SEND TO PRODUCTION WINDOW) *************************************************************

function Get_WinSendCriteriaToProduction(){return Aliases.CroesusApp.winSendCriteriaToProduction}

function Get_WinSendCriteriaToProduction_LblPassword(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "TextBlock_7eaa", 10)}

function Get_WinSendCriteriaToProduction_TxtPassword(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "PasswordBox_a1e4", 10)}

function Get_WinSendCriteriaToProduction_BtnSendToProduction(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "Button_01a3", 10)}

function Get_WinSendCriteriaToProduction_BtnCancel(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "Button_873f", 10)}

function Get_WinSendCriteriaToProduction_LblNumberOfCriteria(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "TextBlock_ecc3", 10)}

function Get_WinSendCriteriaToProduction_LblMessage(){return Get_WinSendCriteriaToProduction().FindChild("Uid", "TextBlock_372a", 10)}



//*********************************************************** FENÊTRE MÉTHODE D'ÉVALUATION DE RISQUE (RISK RATING METHOD WINDOW) *************************************************************

function Get_WinRiskRatingMethod(){return Aliases.CroesusApp.winRiskRatingMethod}

function Get_WinRiskRatingMethod_BtnClose(){return Get_WinRiskRatingMethod().FindChild("Uid", "Button_47a2", 10)}

function Get_WinRiskRatingMethod_LblSubcategory(){return Get_WinRiskRatingMethod().FindChild("Uid", "TextBlock_29bd", 10)}

function Get_WinRiskRatingMethod_TxtSubcategory(){return Get_WinRiskRatingMethod().FindChild("Uid", "CustomTextBox_a815", 10)}

function Get_WinRiskRatingMethod_LblRating(){return Get_WinRiskRatingMethod().FindChild("Uid", "TextBlock_f969", 10)}

function Get_WinRiskRatingMethod_TxtRating(){return Get_WinRiskRatingMethod().FindChild("Uid", "CustomTextBox_cedf", 10)}

function Get_WinRiskRatingMethod_TabCorrespondingSecurities(){return Get_WinRiskRatingMethod().FindChild("Uid", "TabItem_1571", 10)}

function Get_WinRiskRatingMethod_TabProductionFinal(){return Get_WinRiskRatingMethod().FindChild("Uid", "TabItem_adfb", 10)}

function Get_WinRiskRatingMethod_TabSimulationFinal(){return Get_WinRiskRatingMethod().FindChild("Uid", "TabItem_55b4", 10)}



//***************************************** Ajout de fonctions Get Créés par Amine Alaoui pour Regression Titre ****************************************************
function Get_GridHeader_ContextualMenu_InsertField_MaturityDate(){
        return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: MaturityDate"], 10)
}
        

function Get_WinCurrencySelection_ListView(){return Get_WinCurrencySelection().FindChild("Uid", "ListView_0b10", 10)}
function Get_WinExchangeRate_TabEquivalenceTable_RecordList(){
        return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)
}
function Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency_Cad(){
        return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "CAD"], 10)
}

function Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange(){return Get_WinInfoSecurity().Find("Uid","Button_7462",10) }