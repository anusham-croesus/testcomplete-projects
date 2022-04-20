//USEUNIT Common_Get_functions

//********************************* FENÊTRE AJOUTER UN TABLEAU (ADD BOARD WINDOW) *************************************

function Get_DlgAddBoard(){return Aliases.CroesusApp.dlgAddBoard}

function Get_DlgAddBoard_BtnDelete(){return Get_DlgAddBoard().FindChild("Uid", "Button_9d98", 10)}

function Get_DlgAddBoard_BtnOK(){return Get_DlgAddBoard().FindChild("Uid", "Button_40f3", 10)}

function Get_DlgAddBoard_BtnCancel(){return Get_DlgAddBoard().FindChild("Uid", "Button_73d7", 10)}

function Get_DlgAddBoard_LblSelectABoard(){return Get_DlgAddBoard().FindChild("Uid", "Label_f412", 10)}

function Get_DlgAddBoard_TvwSelectABoard(){return Get_DlgAddBoard().FindChild("Uid", "TreeView_6915", 10)}

function Get_DlgAddBoard_TvwSelectABoard_GrpAvailableBoards()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Tableaux disponibles"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Available Boards"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_GrpNewBoards()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Nouveaux tableaux"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "New Boards"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Sommaire de l'encaisse positive"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Positive Cash Balance Summary"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Comptes hors-tolérance de l'objectif de placement"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Account investment objective tolerance exceeded"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_SpecialDividends()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Dividendes exceptionnels"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Special Dividends"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_Calendar()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Calendrier"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Calendar"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Restrictions déclenchées"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Triggered Restrictions"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Sommaire de l'encaisse négative"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Negative Cash Balance Summary"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_CampaignManagement()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Gestion des campagnes"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Campaign Management"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_ExpiredOrders()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Ordres expirés"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Expired Orders"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_InternetAddress()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Adresse Internet"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Internet Address"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Basé sur un critère"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Based on a criterion"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariationModels()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Modèles hors-tolérance de l'objectif de placement"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Model investment objective tolerance exceeded"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_UnifiedManagedAccounts()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Comptes à gestion unifiés – Gestion des actifs non-attribués"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Unified Managed Accounts – Unallocated Assets Management"], 10)}
}

//**************************** DASHBOARD PLUGIN AND PADHEADER ***************************

function Get_DashboardPlugin(){return Aliases.CroesusApp.winMain.DashboardPlugin}

function Get_DashboardBar(){return Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.barPadHeader}



//**************************** MENU CONTEXTUEL DU TABLEAU DE BORD (DASHBOARD CONTEXTUAL MENU) ***************************

function Get_Dashboard_ContextualMenu(){return Get_SubMenus().Find(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 10)}


function Get_Dashboard_ContextualMenu_AssignTaskToMyself(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_e8ee", 10)} 

function Get_Dashboard_ContextualMenu_AssignTaskTo(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_bb66", 10)} 

function Get_Dashboard_ContextualMenu_CancelTaskAssignment(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_9357", 10)} 


function Get_Dashboard_ContextualMenu_View(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_46ba", 10)} 

function Get_Dashboard_ContextualMenu_View_Transactions(){return Get_CroesusApp().Find("Uid", "MenuItem_04cd", 10)} 

function Get_Dashboard_ContextualMenu_View_Portfolio(){return Get_CroesusApp().Find("Uid", "MenuItem_6775", 10)} 


function Get_Dashboard_ContextualMenu_CreateOrder(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_356d", 10)} 

function Get_Dashboard_ContextualMenu_ProduceReports(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_514e", 10)} 

function Get_Dashboard_ContextualMenu_SendEmail(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_7462", 10)} 

function Get_Dashboard_ContextualMenu_ExcludeThisAccount(){return Get_Dashboard_ContextualMenu().Find("Uid", "MenuItem_059d", 10)} 


function Get_Dashboard_ContextualMenu_Help() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Aide"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Help"], 10)}
}

function Get_Dashboard_ContextualMenu_Help_ContextSensitiveHelp() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_Dashboard_ContextualMenu_Help_ContentsAndIndex() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}


function Get_Dashboard_ContextualMenu_Print()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}



//**************************** TABLEAU SOMMAIRE DE L'ENCAISSE POSITIVE (POSITIVE CASH BALANCE SUMMARY BOARD) ************************************

function Get_Dashboard_PositiveCashBalanceSummaryBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "UpperCashBalanceSummaryBoard", 10)}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid(){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild("Uid", "DataGrid_b80f", 10)}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid_HeaderLabelArea(){return Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCheckBoxOnOff(){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChBalance()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAccountNo()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du compte"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account no."], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChName()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChIACode()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChTelephone1()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCurrency()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAssignedTo()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assignée à"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned to"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChDateOfBirth()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de naissance"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date of Birth"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAge()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Âge"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Age"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChLastContact()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier contact"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Contact"], 10)}
}

function Get_Dashboard_PositiveCashBalanceSummaryBoard_ChFullName()
{
  if (language=="french"){return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom long"], 10)}
  else {return Get_Dashboard_PositiveCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}



//**************************** TABLEAU SOMMAIRE DE L'ENCAISSE NEGATIVE (NEGATIVE CASH BALANCE SUMMARY BOARD) ************************************

function Get_Dashboard_NegativeCashBalanceSummaryBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "LowerCashBalanceSummaryBoard", 10)}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid(){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild("Uid", "DataGrid_ed81", 10)}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid_HeaderLabelArea(){return Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChCheckBoxOnOff(){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChBalance()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAccountNo()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du compte"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account no."], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChName()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChIACode()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChTelephone1()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChCurrency()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAssignedTo()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assignée à"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned to"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChDateOfBirth()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de naissance"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date of Birth"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAge()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Âge"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Age"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChLastContact()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier contact"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Contact"], 10)}
}

function Get_Dashboard_NegativeCashBalanceSummaryBoard_ChFullName()
{
  if (language=="french"){return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom long"], 10)}
  else {return Get_Dashboard_NegativeCashBalanceSummaryBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}


//**************************** TABLEAU OBJECTIFS DE PLACEMENT - ÉCARTS (INVESTMENT OBJECTIVE VARIATION BOARD) ************************************

function Get_Dashboard_InvestmentObjectiveVariationBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "UnsynchronizedAccountsBoard", 10)}

function Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid(){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild("Uid", "DataGrid_6736", 10)}

function Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid_HeaderLabelArea(){return Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChCheckBoxOnOff(){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChAccountNo()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du compte"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account no."], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChName()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChIACode()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChInvestmentObjective()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Objectif de placement"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Investment Objective"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChVariation()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écart"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Variation"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChTotalValue()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChCurrency()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Dashboard_InvestmentObjectiveVariationBoard_ChAssignedTo()
{
  if (language=="french"){return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assignée à"], 10)}
  else {return Get_Dashboard_InvestmentObjectiveVariationBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned to"], 10)}
}



//**************************** TABLEAU RESTRICTIONS DÉCLENCHÉES (TRIGGERED RESTRICTIONS BOARD) ************************************

function Get_Dashboard_TriggeredRestrictionsBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "RestrictionsBoard", 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid(){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild("Uid", "DataGrid_59dd", 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid_HeaderLabelArea(){return Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild("ClrClassName", "HeaderLabelArea", 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_ChCheckBoxOnOff(){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_ChAccountTypeIcon(){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_ChNumber()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChName()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChRestriction(){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction"], 10)}

function Get_Dashboard_TriggeredRestrictionsBoard_ChParameters()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Paramètres"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Parameters"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChCurrentlyHeld()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Détenu"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currently Held"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChCurrency()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChTotalValue()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChIACode()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Dashboard_TriggeredRestrictionsBoard_ChAssignedTo()
{
  if (language=="french"){return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assignée à"], 10)}
  else {return Get_Dashboard_TriggeredRestrictionsBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned to"], 10)}
}


//****************************** TABLEAU CALENDRIER (CALENDAR BOARD) ************************************

function Get_Dashboard_CalendarBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "ScheduleBoard", 10)}

function Get_Dashboard_CalendarBoard_TabBirthdays()
{
  if (language=="french"){return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Anniversaires"], 10)}
  else {return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Birthdays"], 10)}
}

function Get_Dashboard_CalendarBoard_TabMaturities()
{
  if (language=="french"){return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Échéances"], 10)}
  else {return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Maturities"], 10)}
}

function Get_Dashboard_CalendarBoard_TabSpecialDividends()
{
  if (language=="french"){return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Dividendes exceptionnels"], 10)}
  else {return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Special Dividends"], 10)}
}  

function Get_Dashboard_CalendarBoard_TabSpecialDividends_SpDivGrid(){return Get_Dashboard_CalendarBoard().FindChild("Uid", "DataGrid_f8ed",10)}
 
function Get_Dashboard_CalendarBoard_TabOptions(){return Get_Dashboard_CalendarBoard().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Options"], 10)}

function Get_Dashboard_CalendarBoard_MonthCalendar(){return Get_Dashboard_CalendarBoard().FindChild("Uid", "MonthCalendar_79f2", 10)}  

function Get_Dashboard_CalendarBoard_DgvBirthdays(){return Get_Dashboard_CalendarBoard().FindChild("Uid", "DataGrid_5ac6", 10)}

//****************************** TABLEAU GESTION DES CAMPAGNES (CAMPAIGN MANAGEMENT BOARD) ************************************

function Get_Dashboard_CampaignManagementBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "CampaignManagementBoard", 10)}



//****************************** TABLEAU ORDRES EXPIRÉS (EXPIRED ORDERS BOARD) ************************************

function Get_Dashboard_ExpiredOrdersBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "ExpiredOrdersBoard", 10)}



//************************ TABLEAU OBJECTIFS DE PLACEMENT - ÉCARTS - MODÈLES (INVESTMENT OBJECTIVE VARIATION - MODELS BOARD) *************************

function Get_Dashboard_InvestmentObjectiveVariationModelsBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "UnsynchronizedModelsBoard", 10)}



//****************************** TABLEAU ADRESSE INTERNET (INTERNET ADDRESS BOARD) ************************************

function Get_Dashboard_InternetAddress_WinComposeAdress(){return Get_CroesusApp().FindChild("Uid", "EditUri_ead5", 10)}

function Get_Dashboard_InternetAddress_WinComposeAdress_LblAddress(){return Get_Dashboard_InternetAddress_WinComposeAdress().FindChild("Uid", "Label_66b1", 10)}

function Get_Dashboard_InternetAddress_WinComposeAdress_TxtAddress(){return Get_Dashboard_InternetAddress_WinComposeAdress().FindChild("Uid", "TextBox_537c", 10)}

function Get_Dashboard_InternetAddress_WinComposeAdress_BtnOK(){return Get_Dashboard_InternetAddress_WinComposeAdress().FindChild("Uid", "Button_5648", 10)}

function Get_Dashboard_InternetAddress_WinComposeAdress_BtnCancel(){return Get_Dashboard_InternetAddress_WinComposeAdress().FindChild("Uid", "Button_3700", 10)}


//****************************** TABLEAU ADRESSE INTERNET (INTERNET ADDRESS BOARD) ************************************

function Get_Dashboard_UnallocatedPositionSleevesBoard(){return Get_DashboardPlugin().FindChild("ClrClassName", "UnallocatedPositionSleevesBoard", 10)}

function Get_Dashboard_DvgUnallocatedPositionSleevesBoard(){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild("Uid", "DataGrid_2090", 10)}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChAccountNo()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du compte"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChName()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChIACode()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChAccountTotalValue()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale du compte"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Total Value"], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChUnallocatedTotalValue()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale non-attribuée"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unallocated Total Value"], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChCurrency()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Dashboard_UnallocatedPositionSleevesBoard_ChAssignedTo()
{
  if (language == "french"){return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assignée à"], 10)}
  else {return Get_Dashboard_UnallocatedPositionSleevesBoard().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned to"], 10)}
}
//***************************************** FENÊTRE MES TÂCHES (MY TASKS WINDOW) ***************************************

function Get_WinMyTasks(){return Aliases.CroesusApp.winMyTasks}

function Get_WinMyTasks_ChStatus()
{
  if (language=="french"){return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinMyTasks_ChBoard()
{
  if (language=="french"){return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tableau"], 10)}
  else {return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Board"], 10)}
}

function Get_WinMyTasks_ChNumber()
{
  if (language=="french"){return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinMyTasks_ChName()
{
  if (language=="french"){return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinMyTasks_ChTelephone1()
{
  if (language=="french"){return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_WinMyTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}


//***************************************** FENÊTRE MES TÂCHES OUVERTES (MY OPEN TASKS WINDOW) ***************************************

function Get_WinMyOpenTasks(){return Aliases.CroesusApp.winMyTasks}

function Get_WinMyOpenTasks_ChStatus()
{
  if (language=="french"){return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinMyOpenTasks_ChBoard()
{
  if (language=="french"){return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tableau"], 10)}
  else {return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Board"], 10)}
}

function Get_WinMyOpenTasks_ChNumber()
{
  if (language=="french"){return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinMyOpenTasks_ChName()
{
  if (language=="french"){return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinMyOpenTasks_ChTelephone1()
{
  if (language=="french"){return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_WinMyOpenTasks().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}



function Get_Dashboard_InvestmentObjectiveVariationModels_BtnSaveAndRefresh(){
     return Get_CroesusApp().FindChild("Uid", "BasicCriteriaEditor_6401", 10).FindChild("Uid", "Button_d3b0", 10);
}