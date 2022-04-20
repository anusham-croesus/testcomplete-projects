//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/******************************************* ACCOUNTS GRID ************************************************/

//Entêtes de colonne de la grille des comptes (Accounts grid Column headers)

function Get_AccountsGrid_ChNoteIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_AccountsGrid_ChName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_AccountsGrid_ChPro(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10) }

function Get_AccountsGrid_ChAccountNo()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_AccountsGrid_ChIACode()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_AccountsGrid_ChType(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_AccountsGrid_ChPlan()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Régime"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Plan"], 10)}
}

function Get_AccountsGrid_ChTelephone1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_AccountsGrid_ChTelephone2()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 2"], 10)}
}

function Get_AccountsGrid_ChBalance()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_AccountsGrid_ChCurrency()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_AccountsGrid_ChMargin()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

function Get_AccountsGrid_ChTotalValue()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_AccountsGrid_ChJointAccount()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Compte conjoint"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Joint Account"], 10)}
}

function Get_AccountsGrid_ChCreationDate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Création"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

function Get_AccountsGrid_ChIAProgChangeDate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de chang. CP/Prog."], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA/Prog. Change Date"], 10)}
}

function Get_AccountsGrid_ChClosingDate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de fermeture"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Closing Date"], 10)}
}

function Get_AccountsGrid_ChLastTransaction()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dern. trans."], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Transaction"], 10)}
}

function Get_AccountsGrid_ChLastTrade()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier achat/vente"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Trade"], 10)}
}

function Get_AccountsGrid_ChSeparatelyManaged()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gestion séparée"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Separately Managed"], 10)}
}

function Get_AccountsGrid_ChManager()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gestionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Manager"], 10)}
}

function Get_AccountsGrid_ChLanguage()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Langue"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Language"], 10)}
}

function Get_AccountsGrid_ChMandate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mandat"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mandate"], 10)}
}

function Get_AccountsGrid_ChClientNo()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

function Get_AccountsGrid_ChFullName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_AccountsGrid_ChSleeves()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Segments"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeves"], 10)}
}

function Get_AccountsGrid_ChStatus()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_AccountsGrid_ChCheckDigit()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Chiffre vérificateur"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Check Digit"], 10)}
}

function Get_AccountsGrid_ChProduct()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Produit"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Product"], 10)}
}



function Get_AccountsGrid_ChDiscretionary()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discrétionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary"], 10)}
}

function Get_AccountsGrid_ChSecondaryProduct()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Produit secondaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Secondary Product"], 10)}
}

function Get_AccountsGrid_ChHobbies()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Loisirs"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Hobbies"], 10)}
}

function Get_AccountsGrid_ChDate(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "date"], 10)}

function Get_AccountsGrid_ChManagementStartDate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Début de gestion"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Management Start Date"], 10)}
}


//CR1709 Model 2.0 

function Get_AccountsGrid_ChWithdrawalFrequency2()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence retrait 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdrawal frequency 2"], 10)}
}

function Get_AccountsGrid_ChWithdrawalFrequency1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence retrait 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdrawal frequency 1"], 10)}
}

function Get_AccountsGrid_ChWithdrawalAmount2()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Montant retrait 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdrawal amount 2"], 10)}
}

function Get_AccountsGrid_ChWithdrawalAmount1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Montant retrait 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdrawal amount 1"], 10)}
}

function Get_AccountsGrid_ChWithdrFreqStartDate2()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Début fréq. retrait 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdr. freq. start date 2"], 10)}
}

function Get_AccountsGrid_ChWithdrFreqStartDate1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Début fréq. retrait 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Withdr. freq. start date 1"], 10)}
}

function Get_AccountsGrid_ChReserves()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Réserves"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reserves"], 10)}
}
//Menu contextuel des items des colonnes/champs

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "StatusDescription"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CreationDate(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "CreationDate"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Discretionary(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "IsDiscretionary"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Mandate(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "MandateDescription"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_ClosingDate(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "CloseDate"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Language(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "LanguageDescription"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CheckDigit(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "CheckDigit"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Product(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "Product"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_SecondaryProduct(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "SecondaryProduct"], 10)}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles()
{
  if (language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profils"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profiles"], 10)}
}

function Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles_Hobbies(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "LEISURE"], 10)}



//Menu contextuel sur le grid (Contextual menu on the grid)

function Get_AccountsGrid_ContextualMenu_Buy(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CustomizableMenu_0578", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_Stocks(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_caf9", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_GICs(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_49bd", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_MutualFunds(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_2294", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_NewIssues(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_eb1e", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_Options(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7600", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_Baskets(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_a78d", 10)}

function Get_AccountsGrid_ContextualMenu_Buy_FixedIncome(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0855", 10)}


function Get_AccountsGrid_ContextualMenu_Sell(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CustomizableMenu_ccd1", 10)}

function Get_AccountsGrid_ContextualMenu_Sell_MutualFunds(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_a906", 10)}

function Get_AccountsGrid_ContextualMenu_Sell_Options(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_2c5c", 10)}

function Get_AccountsGrid_ContextualMenu_Sell_Baskets(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_5dcf", 10)}

function Get_AccountsGrid_ContextualMenu_Sell_Stocks(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_20d4", 10)}

function Get_AccountsGrid_ContextualMenu_Sell_FixedIncome(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7224", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CustomizableMenu_021a", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_BookValueAdjustment(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_3737", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_ForeignExchange(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_d55d", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Contribution(){return Get_CroesusApp().FindChild("Uid", "CustomizableMenu_7362", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Contribution_CashRSP(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_dde5", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Contribution_SecurityRSP(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_5f27", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Contribution_CashESP(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0a20", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Contribution_SecurityESP(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_b410", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Delivery(){return Get_CroesusApp().FindChild("Uid", "CustomizableMenu_f21f", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Delivery_Client(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0b10", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Delivery_ThirdParty(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_3708", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Delivery_FinancialInstitution(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_3e14", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents(){return Get_CroesusApp().FindChild("Uid", "CustomizableMenu_8c86", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents_CSBCampaign(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_df1e", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents_ConversionRedemption(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_655a", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents_Offer(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0740", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents_DividendReinvestment(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_ebde", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_MarketEvents_Subscription(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_4ec5", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_TransactionsSearch(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_81c8", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_ChequeOrEFTFundsOut(){return Get_CroesusApp().FindChild("Uid", "CustomizableMenu_7427", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_ChequeOrEFTFundsOut_ChequeOrEFT(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_d741", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_ChequeOrEFTFundsOut_RSPWithdrawal(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_6e27", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_ChequeOrEFTFundsOut_RIFLIFWithdrawal(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_88fb", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_Substitution(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7b58", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_BankTransfer(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_1547", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_CashSecurityTransfer(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_fd94", 10)}


function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions(){return Get_CroesusApp().FindChild("Uid", "CustomizableMenu_cccd", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_OtherInvestFundsAdjustRollover(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_16d1", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_OptionExercise(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_b488", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_TaxSlipDuplicates(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7d9c", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_TaxSlipCorrections(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_adfa", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_RIFLIFModification(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_2bdd", 10)}

function Get_AccountsGrid_ContextualMenu_ExternalInstructions_OtherInstructions_Valnil(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_ce79", 10)}


function Get_AccountsGrid_ContextualMenu_Info(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_0800", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_5fb4", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Notes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_14a0", 10)}

function Get_AccountsGrid_ContextualMenu_Info_InvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_d1d7", 10)}

function Get_AccountsGrid_ContextualMenu_Info_DefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_7b00", 10)}

function Get_AccountsGrid_ContextualMenu_Info_DefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_eb9b", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Profiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_d0a4", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Dates(){return Get_CroesusApp().FindChild("Uid", "MenuItem_6813", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Holders(){return Get_CroesusApp().FindChild("Uid", "MenuItem_4315", 10)}

function Get_AccountsGrid_ContextualMenu_Info_PW1859(){return Get_CroesusApp().FindChild("Uid", "MenuItem_fc4a", 10)}

function Get_AccountsGrid_ContextualMenu_Info_Contributions(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1c24", 10)}


function Get_AccountsGrid_ContextualMenu_Add(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_4ce9", 10)}


function Get_AccountsGrid_ContextualMenu_SortBy_AccountNo()
{
  if (language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No compte"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Account No."], 10)}
}


function Get_AccountsGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_f890", 10)}

function Get_AccountsGrid_ContextualMenu_Functions_Alarms(){return Get_CroesusApp().FindChild("Uid", "MenuItem_33a7", 10)}




/*********************************** ACCOUNTS DETAILS (DÉTAILS COMPTES) ******************************************/

//Info tab (Onglet Info)

function Get_AccountsDetails_TabInfo(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_d1a6", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ScrollViewer_ad79", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblInvestmentObjective(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_220b", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblFollowUp(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_993f", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblContactPerson(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_5b4f", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblAccountManager(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_5f3e", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblAmounts(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_994f", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblBalance(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_ea35", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblTotalValue(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_7949", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_LblMargin(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_6e80", 10)}

//A compléter pour le survol (les 5 composants suivants)
function Get_AccountsDetails_TabInfo_TxtName(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBox_06a4", 10)}

function Get_AccountsDetails_TabInfo_LblType(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_8f33", 10)}

function Get_AccountsDetails_TabInfo_LblCreation(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_e179", 10)}

function Get_AccountsDetails_TabInfo_LblLastTransaction(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_39a8", 10)}

function Get_AccountsDetails_TabInfo_LblLastTrade(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_be76", 10)}


function Get_AccountsDetails_TabInfo_TxtType(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_55eb", 10)}

function Get_AccountsDetails_TabInfo_TxtCreation(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_8b90", 10)}

function Get_AccountsDetails_TabInfo_TxtLastTransaction(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBlock_4867", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtInvestmentObjective(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_8221", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtContactPerson(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_5e3f", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtAccountManager(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_67b1", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtBalance(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_97b8", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtTotalValue(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_c657", 10)}

function Get_AccountsDetails_TabInfo_ScrollViewer_TxtMargin(){return Get_AccountsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_c08e", 10)}




//Profile tab (Onglet Profil)

function Get_AccountsDetails_TabProfile(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_597f", 10)}



/**************************************** ACCOUNTS SUM WINDOW (FENÊTRE SOMMATION COMPTES) **********************************************/
//Les parties communes aux modules Clients, Relations et Comptes (même Uid) sont dans Common_Get_functions
//(Get_WinRelationshipsClientsAccountsSum(), Get_WinRelationshipsClientsAccountsSum_BtnClose())

function Get_WinAccountsSum_DgvDataGrid(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "DataGrid_f4b8", 10)}


function Get_WinAccountsSum_LblCreditBalance(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}

function Get_WinAccountsSum_LblDebitBalance(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10)}

function Get_WinAccountsSum_LblTotalBalance(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "5"], 10)}

function Get_WinAccountsSum_LblAccountsTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "6"], 10)}

function Get_WinAccountsSum_LblNumberOfAccounts(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "7"], 10)}


function Get_WinAccountsSum_LblTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinAccountsSum_TxtCreditBalanceTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinAccountsSum_TxtDebitBalanceTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

function Get_WinAccountsSum_TxtTotalBalanceTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10)}

function Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)}

function Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "7"], 10)}


function Get_WinAccountsSum_LblCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinAccountsSum_TxtCreditBalanceCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinAccountsSum_TxtDebitBalanceCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

function Get_WinAccountsSum_TxtTotalBalanceCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10)}

function Get_WinAccountsSum_TxtAccountsTotalValueCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)}

function Get_WinAccountsSum_TxtNumberOfAccountsCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "7"], 10)}


function Get_WinAccountsSum_LblUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinAccountsSum_TxtCreditBalanceUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinAccountsSum_TxtDebitBalanceUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

function Get_WinAccountsSum_TxtTotalBalanceUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10)}

function Get_WinAccountsSum_TxtAccountsTotalValueUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)}

function Get_WinAccountsSum_TxtNumberOfAccountsUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "7"], 10)}




/**************************************** ACCOUNTS BAR BUTTONS *****************************************/
//Les boutons communs aux trois modules Relations/Clients/Comptes (mêmes Uids) sont dans Common_Get_functions
//(Get_RelationshipsClientsAccountsBar(), Get_RelationshipsClientsAccountsBar_BtnPerformance(), Get_RelationshipsAccountsBar_BtnRestrictions(), Get_RelationshipsClientsAccountsBar_BtnActivities())

function Get_AccountsBar_BtnInfo(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "SplitDropDownButton_ea82", 10)}

function Get_AccountsBar_BtnAlarms(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "Button_7622", 10)}


//Liste déroulante du bouton Info de la barre de Comptes

function Get_AccountsBar_BtnInfo_ItemNotes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_9dfa", 10)}

function Get_AccountsBar_BtnInfo_ItemInvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_06f7", 10)}

function Get_AccountsBar_BtnInfo_ItemDefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_c238", 10)}

function Get_AccountsBar_BtnInfo_ItemDefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e967", 10)}

function Get_AccountsBar_BtnInfo_ItemProfiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_cb15", 10)}

function Get_AccountsBar_BtnInfo_ItemDates(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2344", 10)}

function Get_AccountsBar_BtnInfo_ItemHolders(){return Get_CroesusApp().FindChild("Uid", "MenuItem_5946", 10)}

function Get_AccountsBar_BtnInfo_ItemPW1859(){return Get_CroesusApp().FindChild("Uid", "MenuItem_c2de", 10)}

function Get_AccountsBar_BtnInfo_ItemContributions(){return Get_CroesusApp().FindChild("Uid", "MenuItem_14ec", 10)}



/**************************************** FENÊTRE ALARMES POUR LE COMPTE (ALARMS FOR ACCOUNT WINDOW) *****************************************/

function Get_WinAlarmsForAccount(){return Aliases.CroesusApp.winAlarmsForAccount}

function Get_WinAlarmsForAccount_BtnOK(){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinAlarmsForAccount_BtnCancel()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinAlarmsForAccount_BtnAddEdit()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Aj_outer ou modifier"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd or edit"], 10)}
}

function Get_WinAlarmsForAccount_BtnDelete()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}

function Get_WinAlarmsForAccount_BtnAddSecurity()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Ajouter _titre..."], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Add S_ecurity..."], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms(){return Get_WinAlarmsForAccount().FindChild("Uid", "FixedColumnListView_1b3e", 10)}

function Get_WinAlarmsForAccount_DgvAlarms_ChQuantity()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Quantité"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Quantity"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChSymbol()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Symbole"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Symbol"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChDescription(){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Description"], 10)}

function Get_WinAlarmsForAccount_DgvAlarms_ChInvestCost()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Invest. unitaire"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Invest. Cost"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChMarketPrice()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Prix du marché"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Market Price"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChSecurityCurrency()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Devise du titre"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Security Currency"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChLowPrice()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Prix bas"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Low Price"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChHighPrice()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Prix haut"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "High Price"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChExpiryDate()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Expiration"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Expiry Date"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChBid()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Acheteur"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Bid"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChClose()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Clôture"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Close"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChCreationDate()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Création"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Creation Date"], 10)}
}
// ajout de la fonction get de Unit Cost pour la US (90-04-49)
function Get_WinAlarmsForAccount_DgvAlarms_ChUnitCost()
{
  if (language=="french"){ Log.Warning("Le nom du champ Unit cost n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Unit Cost"], 10)}
}



function Get_WinAlarmsForAccount_DgvAlarms_ChACB()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "PBR"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "ACB"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChSecurity()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Titre"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Security"], 10)}
}

function Get_WinAlarmsForAccount_DgvAlarms_ChAsk()
{
  if (language=="french"){return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Vendeur"], 10)}
  else {return Get_WinAlarmsForAccount().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Ask"], 10)}
}


//*********************************fenêtre Ajouter/Modifier une alarme dans Comptes*********************************************************

function Get_winAddEditAlarmForAccount(){return Aliases.CroesusApp.winAddEditAlarmForAccount}

function Get_winAddEditAlarmForAccount_GrpPrice_LowPrice(){return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["DoubleTextBoxPS", "1", true], 10)}

function Get_winAddEditAlarmForAccount_GrpPrice_HighPrice(){return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_winAddEditAlarmForAccount_Date_ExpiryDate(){return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_winAddEditAlarmForAccount_BtnOK(){return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_winAddEditAlarmForAccount_BtnCancel()
{
  if (language=="french"){return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_winAddEditAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}

}
/*****************************************Fonctions GET pour les composant Ajouter titre ***************************************************************/

function Get_WinAddSecurityAlarmForAccount(){return Aliases.CroesusApp.WinAddSecurityAlarmForAccount}

function Get_WinAddSecurityAlarmForAccount_Security(){return Get_WinAddSecurityAlarmForAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["WPFControlOrdinalNo", "2"], 10)}

function Get_WinAddSecurityAlarmForAccount_BtnOk(){return Get_WinAddSecurityAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinAddSecurityAlarmForAccount_BtnCancel()
{
  if (language=="french"){return Get_WinAddSecurityAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAddSecurityAlarmForAccount().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinAddSecurityAlarmForAccount_DvgSecurity(){return Get_WinAddSecurityAlarmForAccount().FindChild("Uid", "FixedColumnListView_1b3e", 10)}

  
/**************************************** FENÊTRE INFO COMPTE (ACCOUNT INFO WINDOW) *****************************************/

function Get_WinAccountInfo(){return Aliases.CroesusApp.winAccountInfo}

function Get_WinAccountInfo_BtnOK(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinAccountInfo_BtnApply(){
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Appliquer"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Apply"], 10)}
}

function Get_WinAccountInfo_BtnCancel()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinAccountInfo_GrpAccount()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Compte"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Account"], 10)}
}

function Get_WinAccountInfo_GrpAccount_LblClientNo(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtClientNo(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinAccountInfo_GrpAccount_LblShortName(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtShortName(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinAccountInfo_GrpAccount_LblFullName(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtFullName(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinAccountInfo_GrpAccount_LblAccountNumber(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtAccountNumber(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}

function Get_WinAccountInfo_GrpAccount_LblClass(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtClass(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}

function Get_WinAccountInfo_GrpAccount_LblType(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtType(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}

function Get_WinAccountInfo_GrpAccount_CmbType(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)} //Pour les SysAdmin

function Get_WinAccountInfo_GrpAccount_CmbType_ItemCash() //Pour les SysAdmin
{
  if (language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Comptant"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Cash"], 10)}
}

function Get_WinAccountInfo_GrpAccount_CmbType_ItemRetirementIncomeFunds() //Pour les SysAdmin
{
  if (language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Fonds de revenu de retraite"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Retirement Income Funds"], 10)}
}

function Get_WinAccountInfo_GrpAccount_LblCurrency(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtCurrency(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10)}

function Get_WinAccountInfo_GrpAccount_LblIACode(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtIACode(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "8"], 10)}

function Get_WinAccountInfo_GrpAccount_LblStatus(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtStatus(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "9"], 10)}

function Get_WinAccountInfo_GrpAccount_LblSubtype(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinAccountInfo_GrpAccount_CmbSubtype(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinAccountInfo_GrpAccount_LblCode(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 10)}

function Get_WinAccountInfo_GrpAccount_TxtCode(){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "10"], 10)}


function Get_WinAccountInfo_GrpAmounts()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Montants"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Amounts"], 10)}
}

function Get_WinAccountInfo_GrpAmounts_LblBalance(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinAccountInfo_GrpAmounts_TxtBalance(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinAccountInfo_GrpAmounts_LblTotalValue(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinAccountInfo_GrpAmounts_TxtTotalValue(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinAccountInfo_GrpAmounts_TxtMarginOrExcessMargin()
{
  if (language == "french"){
    if (Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin().Text == "Marge:"){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}
    else {return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}
  } else {
    if (Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin().Text == "Margin:"){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}
    else {return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}
  }
}

function Get_WinAccountInfo_GrpAmounts_LblNetInvest(){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinAccountInfo_GrpAmounts_TxtNetInvest()
{
  if (language == "french"){
    if (Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin().Text == "Marge:"){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}
    else {return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}
  } else {
    if (Get_WinAccountInfo_GrpAmounts_LblMarginOrExcessMargin().Text == "Margin:"){return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}
    else {return Get_WinAccountInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}
  }
}


function Get_WinAccountInfo_GrpFollowUp()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Suivi"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Follow up"], 10)}
}

function Get_WinAccountInfo_GrpFollowUp_LblContactPerson(){return Get_WinAccountInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbContactPerson(){return Get_WinAccountInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemRonaldReagan(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Ronald Reagan"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemNothing(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", ""], 10)}

function Get_WinAccountInfo_GrpFollowUp_LblAccountManager(){return Get_WinAccountInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbAccountManager(){return Get_WinAccountInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbAccountManager_ItemGeorgeWashington(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "George Washington"], 10)}

function Get_WinAccountInfo_GrpFollowUp_CmbAccountManager_ItemNothing(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", ""], 10)}

function Get_WinAccountInfo_GrpAccount_CmbLegalEntity (){return Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "6"], 10)}


//*************************** Onglet Notes de la fenêtre Info Compte (Notes tab of the Account Info window) **************************

function Get_WinAccountInfo_TabNotes(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Notes"], 10)}

//Les fonctions Get de cet onglet sont dans Common_Get_functions ; elles sont communes avec la fenêtre Info Client/Relation



//*************************** Onglet Objectif de placement de la fenêtre Info Compte (Investment Objective tab of the Account Info window) **************************

function Get_WinAccountInfo_TabInvestmentObjective()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Objectif de placement"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Investment Objective"], 10)}
}

//Les fonctions Get de cet onglet sont dans Common_Get_functions ; elles sont communes avec la fenêtre Info Client/Relation



//*************************** Onglet Rapports par défaut de la fenêtre Info Compte (Default Reports tab of the Account Info window) **************************

function Get_WinAccountInfo_TabDefaultReports()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports par défaut"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Default Reports"], 10)}
}

//Les fonctions Get de cet onglet sont dans Common_Get_functions ; elles sont communes avec la fenêtre Info Client/Relation



//*************************** Onglet Indices par défaut de la fenêtre Info Compte (Default Indices tab of the Account Info window) **************************

function Get_WinAccountInfo_TabDefaultIndices()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Indices par défaut"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Default Indices"], 10)}
}

//Les autres fonctions Get de cet onglet sont dans Common_Get_functions ; elles sont communes avec la fenêtre Info Client/Relation



//*************************** Onglet Profil de la fenêtre Info Compte (Profile tab of the Account Info window) **************************

function Get_WinAccountInfo_TabProfile()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Profil"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Profile"], 10)}
}

function Get_WinAccountInfo_TabProfile_CompteExpander(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "compte"], 10)}

function Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte(){return Get_WinAccountInfo_TabProfile_CompteExpander().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "sous-compte"], 10)}

function Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte_LblSaxonLongDescription()
{
  if (language=="french"){return Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Description française longue"], 10)}
  else {return Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Saxon Long Description"], 10)}
}

function Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte_CmbSaxonLongDescription(){return Get_WinAccountInfo_TabProfile_CompteExpander_GrpSousCompte().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander()
{
    if (language == "french"){
        if (client == "TD" || client == "CIBC" || client == "RJ"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Defaut"], 10)}
        else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Défaut"], 10)}
    }
    else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Default"], 10)}
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies(){
  if (language=="french"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Loisirs"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
  else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Hobbies"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_CmbVieuxConfigurateur(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtPaf(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_ChkCheckbox(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtTT57915(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtLocomotiveTexte(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "6"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_DtpCanis(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "7"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_CmbPartnership(){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "8"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtBrokerAccountNumber()
{
  if (language=="french"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Numéro du compte du courtier"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
  else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Broker account number"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}

  //if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
  //else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "9"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtMiddlemanAccountNumber()
{
  if (language=="french"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Numéro du compte de l'intervenant"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
  else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Middleman account number"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
    
  //if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
  //else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "10"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtJointAccount()
{
  if (language=="french"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Compte conjoint"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
  else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", "Joint Account"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}

  //if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
  //else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "11"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtAccountDesignation()
{
    //if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
    //else {return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "12"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}
    if (client == "RJ" || client == "CIBC") 
        return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10) //EM : Depuis 90-07-23-CO
    else 
        return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "12"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)
}


function Get_WinAccountInfo_TabProfile_CaroleCompteExpander(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Carole compte"], 10)}

function Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount(){return Get_WinAccountInfo_TabProfile_CaroleCompteExpander().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "Carole S-G compte"], 10)}

function Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFeuille(){return Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFleur(){return Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtKYCFeeBasedType() {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}

//Les autres fonctions Get de cet onglet sont dans Common_Get_functions ; elles sont communes avec la fenêtre Info Client/Relation



//*************************** Onglet Dates de la fenêtre Info Compte (Dates tab of the Account Info window) **************************

function Get_WinAccountInfo_TabDates(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Dates"], 10)}

function Get_WinAccountInfo_TabDates_LblCreation(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinAccountInfo_TabDates_DtpCreation(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinAccountInfo_TabDates_LblLastTransaction(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinAccountInfo_TabDates_DtpLastTransaction(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinAccountInfo_TabDates_LblManagementStartDate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinAccountInfo_TabDates_DtpManagementStartDate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "3"], 10)}

function Get_WinAccountInfo_TabDates_LblLastTrade(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinAccountInfo_TabDates_DtpLastTrade(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "4"], 10)}

function Get_WinAccountInfo_TabDates_LblClosingDate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinAccountInfo_TabDates_DtpClosingDate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "5"], 10)}

function Get_WinAccountInfo_TabDates_LblUpdate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinAccountInfo_TabDates_DtpUpdate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "6"], 10)}



//*************************** Onglet Détenteurs de la fenêtre Info Compte (Holders tab of the Account Info window) **************************

function Get_WinAccountInfo_TabHolders()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Détenteurs"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Holders"], 10)}
}

function Get_WinAccountInfo_TabHolders_DgvHolders(){return Get_WinAccountInfo().FindChild("Uid", "FixedColumnListView_1b3e", 10)}

function Get_WinAccountInfo_TabHolders_DgvHolders_ChName()
{
  if (language=="french"){return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Nom"], 10)}
  else {return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Name"], 10)}
}

function Get_WinAccountInfo_TabHolders_DgvHolders_ChClientNo()
{
  if (language=="french"){return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No du client"], 10)}
  else {return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Client No."], 10)}
}

function Get_WinAccountInfo_TabHolders_DgvHolders_ChIACode()
{
  if (language=="french"){return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Code de CP"], 10)}
  else {return Get_WinAccountInfo_TabHolders_DgvHolders().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "IA Code"], 10)}
}



//*************************** Onglet GP1859 de la fenêtre Info Compte (PW1859 tab of the Account Info window) **************************

function Get_WinAccountInfo_TabPW1859()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "GP1859"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "PW1859"], 10)}
}

function Get_WinAccountInfo_TabPW1859_LblSeparatelyManaged(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBlock_77ee", 10)}

function Get_WinAccountInfo_TabPW1859_ChkSeparatelyManaged(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "CheckBox_3876", 10)}

function Get_WinAccountInfo_TabPW1859_LblAssetAllocation(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBlock_b69b", 10)}

function Get_WinAccountInfo_TabPW1859_TxtAssetAllocation(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBox_8280", 10)}

function Get_WinAccountInfo_TabPW1859_LblManager(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBlock_a33d", 10)}

function Get_WinAccountInfo_TabPW1859_TxtManager(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "UniComboBox_10ef", 10)}

function Get_WinAccountInfo_TabPW1859_LblMandate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBlock_8d5a", 10)}

function Get_WinAccountInfo_TabPW1859_TxtMandate(){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "UniComboBox_6f0a", 10)}



//*************************** Onglet Comptes enregistrés de la fenêtre Info Compte (Registered accounts tab of the Account Info window) **************************

function Get_WinAccountInfo_TabRegisteredAccounts()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Comptes enregistrés"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Registered accounts"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail(){return Get_WinAccountInfo().FindChild("Uid", "GroupBox_d40b", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChYear()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Année"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Year"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysContribution()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "60 premiers jours:\r\nCotisations"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "First 60 days:\r\nContribution"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysDeposits()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "60 premiers jours:\r\nDépôts"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "First 60 days:\r\nDeposits"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChFirst60DaysWithdrawals()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "60 premiers jours:\r\nRetraits"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "First 60 days:\r\nWithdrawals"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearContributions()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reste de l\'année:\r\nCotisations"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Remainder of the year:\r\nContributions"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearDeposits()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reste de l\'année:\r\nDépôts"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Remainder of the year:\r\nDeposits"], 10)}
}

function Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail_ChRemainderOfTheYearWithdrawals()
{
  if (language=="french"){return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reste de l\'année:\r\nRetraits"], 10)}
  else {return Get_WinAccountInfo_TabRegisteredAccounts_GrpDetail().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Remainder of the year:\r\nWithdrawals"], 10)}
}


function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander(){return Get_WinAccountInfo().FindChild("Uid", "Expander_2e33", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMinimumWithdrawal(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "TextBlock_0598", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMinimumWithdrawal(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "DoubleTextBox_f808", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblMaximumWithdrawal(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "TextBlock_be3e", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_TxtMaximumWithdrawal(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "DoubleTextBox_9cbb", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblPaymentMethod(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "TextBlock_d0b7", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbPaymentMethod(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "UniComboBox_7966", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_LblFrequency(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "TextBlock_2e50", 10)}

function Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander_CmbFrequency(){return Get_WinAccountInfo_TabRegisteredAccounts_InfoExpander().FindChild("Uid", "UniComboBox_71df", 10)}


//*************************** Onglet Sleeves  de la fenêtre Info Compte (Sleeves tab of the Account Info window) **************************

function Get_WinAccountInfo_TabSleeves()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Segments"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Sleeves"], 10)}
}

function Get_WinAccountInfo_TabSleeves_DgvAccountSleeves(){return Get_WinAccountInfo().FindChild("Uid", "DataGrid_53c3", 10)}


//*************************** Onglet Gestion de l'encaisse  de la fenêtre Info Compte (Cash management tab of the Account Info window) **************************
function Get_WinAccountInfo_TabCashManagement()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Gestion de l'encaisse"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Cash management"], 10)}
}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement(){return Get_WinAccountInfo().FindChild("Uid", "GroupBox_d8c5", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_LblFrequency(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "TextBlock_edff", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "CFComboBox_5f83", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "CFComboBox_797f", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_LblAmountCAD(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "TextBlock_ae26", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "DoubleTextBox_9a7d", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "DoubleTextBox_db08", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_LblStartDate(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "TextBlock_f357", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "DateField_20e6", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "DateField_4739", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "Button_7566", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear2(){return Get_WinAccountInfo_TabCashManagement_GrpCashManagement().FindChild("Uid", "Button_d0c8", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpFees(){return Get_WinAccountInfo().FindChild("Uid", "GroupBox_6e27", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpFees_LblAccountTotalValuePercentage(){return Get_WinAccountInfo_TabCashManagement_GrpFees().FindChild("Uid", "TextBlock_3665", 10)}

function Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(){return Get_WinAccountInfo_TabCashManagement_GrpFees().FindChild("Uid", "DoubleTextBox_0415", 10)}



//*************************** Onglet Type de produits de la fenêtre Info Compte (Product Types tab of the Account Info window) **************************

function Get_WinAccountInfo_TabProductTypes()
{
  if (language=="french"){return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Types de produits"], 10)}
  else {return Get_WinAccountInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Product Types"], 10)}
}

function Get_WinAccountInfo_TabProductTypes_DgvProductTypes(){return Get_WinAccountInfo().FindChild("Uid", "FixedColumnListView_1b3e", 10)}


function Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChProduct()
{
  if (language=="french"){return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Produit"], 10)}
  else {return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Product"], 10)}
}

function Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChSecondaryProduct()
{
  if (language=="french"){return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Produit secondaire"], 10)}
  else {return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Secondary Product"], 10)}
}

function Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChStartDate()
{
  if (language=="french"){return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date de début"], 10)}
  else {return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Start Date"], 10)}
}

function Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChEndDate()
{
  if (language=="french"){return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date de fin"], 10)}
  else {return Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "End Date"], 10)}
}



//********************* ACCOUNTS QUICK SEARCH (COMPTES - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinAccountsQuickSearch_RdoAccountNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - No compte"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - Account No."], 10)}
}

function Get_WinAccountsQuickSearch_RdoName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Name"], 10)}
}

function Get_WinAccountsQuickSearch_RdoIACode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - Code de CP"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - IA Code"], 10)}
}

function Get_WinAccountsQuickSearch_RdoCurrency()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Devise"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Currency"], 10)}
}

function Get_WinAccountsQuickSearch_RdoPlan()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "TYPE2 - Régime"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "TYPE2 - Plan"], 10)}
}

function Get_WinAccountsQuickSearch_RdoTelephone1()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER1 - Téléphone 1"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER1 - Telephone 1"], 10)}
}

function Get_WinAccountsQuickSearch_RdoTelephone2()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER2 - Téléphone 2"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER2 - Telephone 2"], 10)}
}

function Get_DlgConfirmation_LblMessage2(){return Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock","1"],10)}

/*************************************************************************************************/
/*************** Ajout de cette fonction car cette fonction a changé de info,2 à info,3 **********/
/*************** L'original de cette fonction est dans Common_Get_functions **********************/
function Get_MenuBar_Edit_FunctionsForAccounts_Info(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "3"], 100)}

