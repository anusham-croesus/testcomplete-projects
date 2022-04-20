//USEUNIT Common_Get_functions



//**************************************** MODELS BAR  **********************************************

function Get_ModelsBar(){
    WaitModelsPlugin(); //Christophe : Stabilisation
    return Aliases.CroesusApp.winMain.ModelsPlugin.barPadHeader;
}

function Get_ModelsBar_BtnInfo(){return Get_ModelsBar().Find("Uid", "Button_3bdd", 10)} //ok

function Get_ModelsBar_BtnUnderlyingPerformance(){return Get_ModelsBar().Find("Uid", "Button_2ea8", 10)} //ok

function Get_ModelsBar_BtnDocuments(){return Get_ModelsBar().Find("Uid", "Button_9bae", 10)} //ok

function Get_ModelsBar_BtnRestrictions(){return Get_ModelsBar().Find("Uid", "Button_4909", 10)} //ok



//************************** MODELS GRID **************************************

function Get_ModelsPlugin(){return Aliases.CroesusApp.winMain.ModelsPlugin}

function Get_ModelsGrid(){
    WaitModelsPlugin(); //Christophe : Stabilisation
    return Aliases.CroesusApp.winMain.ModelsPlugin.modelListView;
}


//Entêtes de colonne de la grille des modèles (Models grid Column headers)

function Get_ModelsGrid_ColumnList()
{
  var colonne;
  if(Get_ModelsGrid_ChName().Exists) colonne = Get_ModelsGrid_ChName();
  else if(Get_ModelsGrid_ChCurrency().Exists) colonne = Get_ModelsGrid_ChCurrency();
  else colonne = Get_ModelsGrid_ChModelNo();
  return colonne.parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})
}

function Get_ModelsGrid_ChCreationDate()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

function Get_ModelsGrid_ChCurrency()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_ModelsGrid_ChExcessCash()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Excédent d'encaisse"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Excess Cash"], 10)}
}

function Get_ModelsGrid_ChFullName()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_ModelsGrid_ChIACode()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_ModelsGrid_ChLastUpdate()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Update"], 10)}
}

function Get_ModelsGrid_ChModelNo()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de modèle"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model No."], 10)}
}

function Get_ModelsGrid_ChName()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_ModelsGrid_ChType(){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_ModelsGrid_ChUnderlyingBalance()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde sous-jacent"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Underlying Balance"], 10)}
}

function Get_ModelsGrid_ChUnderlyingTotalValue()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale sous-jacente"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Underlying Total Value"], 10)}
}

function Get_ModelsGrid_ChInactive()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inactif"], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inactive"], 10)}
}
function Get_ModelsGrid_ChUpdatedOn()
{
  if (language=="french"){return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Updated on"], 10)}
}

//Menu contextuel sur le grid (Contextual menu on the grid)

function Get_ModelsGrid_ContextualMenu(){return Get_SubMenus().Find("Uid", "ContextMenu_1c89", 10)} //ok


function Get_ModelsGrid_ContextualMenu_Edit(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_e16c", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Detail(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_6241", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Add(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_5f8f", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Delete(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_c3fa", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Copy(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_48e4", 10)} //ok

function Get_ModelsGrid_ContextualMenu_CopyWithHeader(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_5121", 10)} //ok

function Get_ModelsGrid_ContextualMenu_ExportToFile(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_a571", 10)} //ok

function Get_ModelsGrid_ContextualMenu_ExportToMSExcel(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_d652", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Info(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "CFMenuItem_d055", 10)} //ok


function Get_ModelsGrid_ContextualMenu_SortBy(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "MenuItem_6de2", 10)} //ok

function Get_ModelsGrid_ContextualMenu_SortBy_Name() //no uid
{
  if (language=="french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Nom"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Name"], 10, true, -1)}
}

function Get_ModelsGrid_ContextualMenu_SortBy_ModelNo() //no uid
{
  if (language=="french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "No de modèle"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Model No."], 10, true, -1)}
}


function Get_ModelsGrid_ContextualMenu_Functions(){return Get_ModelsGrid_ContextualMenu().Find("Uid", "MenuItem_4f46", 10)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_b024", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_UnderlyingPerformance(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_a978", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Models(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_6c3f", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Relationships(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_abd1", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Clients(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_5d84", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Accounts(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_e415", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Positions(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_f33e", 10, true, -1)} //ok

function Get_ModelsGrid_ContextualMenu_Functions_Transactions(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_2660", 10, true, -1)} //ok


function Get_ModelsGrid_ContextualMenu_Help() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Aide"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Help"], 10)}
}

function Get_ModelsGrid_ContextualMenu_Help_ContextSensitiveHelp() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_ModelsGrid_ContextualMenu_Help_ContentsAndIndex() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}

function Get_ModelsGrid_ContextualMenu_Print() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}


//***************************************** DETAILS MODÈLES (MODELS DETAILS) ***********************************************

function Get_Models_Details(){
    WaitModelsPlugin(); //Christophe : Stabilisation
    return Get_ModelsPlugin().FindChild("Uid", "Expander_0229", 10);
}

function Get_Models_Details_DgvDetails(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", "1", true], 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts(){return Get_Models_Details().FindChild("Uid", "RQSCharts_e003", 10)}


//Risk Score Graph

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_LblTitle(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_794d", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblActual(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_c293", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblObjective(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_52c2", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_d923", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0804", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_GeneralRectangle(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, "GeneralRiskScoreRectangle"], 1)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_ActualRectangle(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, ""], 1)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskScore_ObjectiveTriangle(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Polygon", true, ""], 1)}


//Risk Objectives Graph

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_LblTitle(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_ab46", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent0(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4581", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent25(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4d32", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent50(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1d52", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent75(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0e22", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent100(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1dc3", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl(){return Get_Models_Details_TabSummary_PnlRQSCharts().FindChild("Uid", "ItemsControl_e375", 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskLabel){return Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["Rectangle", true, riskLabel], 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskLabel){return Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "Points.Count", "DataContext.RiskLabel"], ["Polygon", true, 3, riskLabel], 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskLabel){return Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel", "WPFControlText"], ["TextBlock", true, riskLabel, riskLabel], 10)}

function Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskLabel)
{
    var allTextBlockControls = Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindAllChildren(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["TextBlock", true, riskLabel], 10).toArray();
    for (var i in allTextBlockControls)
        if (allTextBlockControls[i].WPFControlText != riskLabel)
            return allTextBlockControls[i];
    return Utils.CreateStubObject();
}


//Assigned portfolios tab (Onglet Portefeuilles assignés)

function Get_Models_Details_TabAssignedPortfolios(){return Get_Models_Details().FindChild("Uid", "TabItem_7c41", 10)}

function Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios(){return Get_Models_Details().FindChild("Uid", "DataGrid_b351", 10)}

function Get_Models_Details_TabAssignedPortfolios_DdlAssign(){return Get_Models_Details().FindChild("Uid", "DropDownButton_3d8f", 10)}

function Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1abd", 10)}

function Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e993", 10)}

function Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts(){return Get_CroesusApp().FindChild("Uid", "MenuItem_8ea3", 10)}

function Get_Models_Details_TabAssignedPortfolios_BtnRemove(){return Get_Models_Details().FindChild("Uid", "Button_98d2", 10)}

function Get_Models_Details_TabAssignedPortfolios_BtnRestrictions(){return Get_Models_Details().FindChild("Uid", "Button_0d73", 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar(){return Get_Models_Details().FindChild("Uid", "ToolBar_a715", 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_LblFilter(){return Get_Models_Details_TabAssignedPortfolios_ToolBar().FindChild("Uid", "Label_26f5", 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter(){return Get_Models_Details_TabAssignedPortfolios_ToolBar().FindChild("Uid", "ComboBox_579d", 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemAll()
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.Text"], ["ComboBoxItem", "Tous"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.Text"], ["ComboBoxItem", "All"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemAccounts(){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.FilterValue"], ["ComboBoxItem", "ACCOUNT"], 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemClients(){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.FilterValue"], ["ComboBoxItem", "CLIENT"], 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemRelationships(){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.FilterValue"], ["ComboBoxItem", "LINK"], 10)}

function Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemSleeves(){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.FilterValue"], ["ComboBoxItem", "SLEEVE"], 10)}


function Get_Models_Details_TabAssignedPortfolios_ChPortfolioTypeIcon(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_Models_Details_TabAssignedPortfolios_ChName()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChNumber()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChIACode()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChCurrency()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChBalance()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChTotalValue()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChMargin()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier rééquilibrage"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Rebalancing"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChLastUser()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier utilisateur"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last User"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChNoOfDaysLate()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de jours de retard"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Days Late"], 10)}
}

function Get_Models_Details_TabAssignedPortfolios_ChPercentBalance()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance (%)"], 10)}
}

//Tab Assigned Portfolios DataGrid

function Get_Models_Details_TabsControler() {return Get_Models_Details().FindChild("ClrClassName", "TabControl", 10)}

function Get_Models_Details_TabAssignedPortfolios_RecordList() {return Get_Models_Details_TabsControler().FindChild("ClrClassName", "RecordListControl", 10)}

function Get_Models_Details_TabAssignedPortfolios_RecordListItem(ordinalNo) {return Get_Models_Details_TabAssignedPortfolios_RecordList().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", ordinalNo], 10)}


//Positions tab (Onglet Positions)

function Get_Models_Details_TabPositions(){return Get_Models_Details().FindChild("Uid", "TabItem_a693", 10)}

function Get_Models_Details_TabPositions_DgPosition(){return Get_CroesusApp().FindChild(["Uid","MetricLoggerTag","VisibleOnScreen"], ["DataGrid_67cd","StandardPositions_MAINWINDOW", true], 10)}

function Get_Models_Details_TabPositions_ToolBarTray(){return Get_Models_Details().FindChild("Uid", "ToolBarTray_ca7d", 10)}

function Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton(){return Get_Models_Details_TabPositions_ToolBarTray().FindChild("Uid", "Button_1b65", 10)}

function Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton_LblModelNoAndName(){return Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton().FindChild("Uid", "TextBlock_dbb7", 10)}

function Get_Models_Details_TabPositions_ToolBarTray_CmbCurrency(){return Get_Models_Details_TabPositions_ToolBarTray().FindChild("Uid", "ComboBox_761d", 10)}

function Get_Models_Details_TabPositions_ToolBarTray_dtpDate(){return Get_Models_Details_TabPositions_ToolBarTray().FindChild("Uid", "DateField_dd49", 10)}


function Get_Models_Details_TabPositions_ToggleButtonToolBar(){return Get_Models_Details().FindChild("Uid", "ToolBar_3f0c", 10)}

function Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnAll(){return Get_Models_Details_TabPositions_ToggleButtonToolBar().FindChild("Uid", "ToggleButton_ddc5", 10)}

function Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnBySecurity(){return Get_Models_Details_TabPositions_ToggleButtonToolBar().FindChild("Uid", "ToggleButton_79ce", 10)}

function Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass(){return Get_Models_Details_TabPositions_ToggleButtonToolBar().FindChild("Uid", "ToggleButton_4bd5", 10)}


//Positions tab - Btn ByAssetClass Off 

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChVariationPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écart (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Variation (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible (%)"], 10)} //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 -  avant "VM Cible (%)" 
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target (%)"], 10)}  //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 - avant "Target VM (%)" 
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible min. (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. Target (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible max. (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. Target (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM min. (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. MV (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM max. (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. MV (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChQuantity()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBeta()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bêta"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Beta"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAssetAllocation()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rép. d'actifs"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Asset Allocation"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketValue()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMYPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RM (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MY (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChYTMMarketPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rend. éché. - Marché (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "YTM - Market (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChIACode()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChName()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée mod."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mod. Duration"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAccruedID()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAsk()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBasicCategories()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBid()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChCUSIP(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChClose()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDividend()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFinancialInstrument()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFrequency()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Updated on"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaturity()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRegion()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSector()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Secteur"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sector"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSubcategory()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurityCurrency()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du prix"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Currency"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurity()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterest()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêts"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterestPortion()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Portion d'intéret"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest Portion"], 10)}
}
function Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRiskRating(){
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Risk Rating"], 10)}
}

//Positions tab - Btn ByAssetClass On

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChDescription(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChNoOfPositions()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de positions"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Positions"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestedCapital()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital investi"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invested Capital"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMarketValue()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}//CROES-3714
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMVPercent()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestCapGL()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P cap. investi"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cap. G/L"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAccruedID()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAnnInc()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChBookValueACB()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur comptable"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Book Value ACB"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChGLBookValue()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P valeur comptable"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/L Book Value"], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMinObj()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. min."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. Obj."], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMaxObj()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. max."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. Obj."], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetObj()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. cible"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target Obj."], 10)}
}

function Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetStatus()//CROES-3862
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target"], 10)}
}


//Summary tab (Onglet Sommaire)

function Get_Models_Details_TabSummary(){return Get_Models_Details().FindChild("Uid", "TabItem_3417", 10)}


function Get_Models_Details_TabSummary_ToolBar(){return Get_Models_Details().FindChild("Uid", "ToolBar_569b", 10)}

function Get_Models_Details_TabSummary_ToolBar_LblCurrency(){return Get_Models_Details_TabSummary_ToolBar().FindChild("Uid", "TextBlock_358a", 10)}


function Get_Models_Details_TabSummary_ToolBarTray(){return Get_Models_Details().FindChild("Uid", "ToolBarTray_c06c", 10)}

function Get_Models_Details_TabSummary_ToolBarTray_LblAssetAllocation(){return Get_Models_Details_TabSummary_ToolBarTray().FindChild("Uid", "TextBlock_549b", 10)}

function Get_Models_Details_TabSummary_ToolBarTray_CmbAssetAllocation(){return Get_Models_Details_TabSummary_ToolBarTray().FindChild("Uid", "ComboBox_9a34", 10)}

function Get_Models_Details_TabSummary_ToolBarTray_ChkFundAllocation(){return Get_Models_Details_TabSummary_ToolBarTray().FindChild("Uid", "CheckBox_4b53", 10)}

function Get_Models_Details_TabSummary_ToolBarTray_LblFundAllocation(){return Get_Models_Details_TabSummary_ToolBarTray().FindChild("Uid", "TextBlock_3c0b", 10)}


function Get_Models_Details_TabSummary_LblNumberOfPositions(){return Get_Models_Details().FindChild("Uid", "TextBlock_a840", 10)}

function Get_Models_Details_TabSummary_TxtNumberOfPositions(){return Get_Models_Details().FindChild("Uid", "TextBlock_4eb2", 10)}

function Get_Models_Details_TabSummary_LblModDurationAvg(){return Get_Models_Details().FindChild("Uid", "TextBlock_ce9a", 10)}

function Get_Models_Details_TabSummary_TxtModDurationAvg(){return Get_Models_Details().FindChild("Uid", "TextBlock_80ce", 10)}

function Get_Models_Details_TabSummary_LblBeta(){return Get_Models_Details().FindChild("Uid", "TextBlock_a803", 10)}

function Get_Models_Details_TabSummary_TxtBeta(){return Get_Models_Details().FindChild("Uid", "TextBlock_8777", 10)}


function Get_Models_Details_TabSummary_LblNumberOfPositionsForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_106d", 10)}

function Get_Models_Details_TabSummary_TxtNumberOfPositionsForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_b327", 10)}

function Get_Models_Details_TabSummary_LblMarketValueForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_3ddf", 10)}

function Get_Models_Details_TabSummary_TxtMarketValueForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_27c1", 10)}

function Get_Models_Details_TabSummary_LblModDurationAvgForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_2137", 10)}

function Get_Models_Details_TabSummary_TxtModDurationAvgForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_e37b", 10)}

function Get_Models_Details_TabSummary_LblAccruedIntDivForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_7023", 10)}

function Get_Models_Details_TabSummary_TxtAccruedIntDivForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_edbc", 10)}

function Get_Models_Details_TabSummary_LblAnnualIncomeForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_307c", 10)}

function Get_Models_Details_TabSummary_TxtAnnualIncomeForBasketType(){return Get_Models_Details().FindChild("Uid", "TextBlock_ff4d", 10)}



//Rebalancing Criteria tab (Onglet Critères de rééquilibrage)

function Get_Models_Details_TabRebalancingCriteria(){return Get_Models_Details().FindChild("Uid", "TabItem_486e", 10)}

function Get_Models_Details_TabRebalancingCriteria_BtnAssignManage(){return Get_Models_Details().FindChild("Uid", "Button_6b5a", 10)}

function Get_Models_Details_TabRebalancingCriteria_BtnRemove(){return Get_Models_Details().FindChild("Uid", "Button_4e98", 10)}

function Get_Models_Details_TabRebalancingCriteria_ChActive()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Actif"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Active"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChPriority()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Priorité"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Priority"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChName()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChDescription(){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Models_Details_TabRebalancingCriteria_ChSentence()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Phrase"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sentence"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChAccessLevel()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau d'accès"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access Level"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChCreationDate()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChLastUpdate()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Updated on"], 10)}
}

function Get_Models_Details_TabRebalancingCriteria_ChCreator()
{
  if (language=="french"){return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créateur"], 10)}
  else {return Get_Models_Details().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creator"], 10)}
}

function Get_Models_Details_TabRebalancingCriteriaDgRules(){return Get_Models_Details().FindChild("Uid", "DataGrid_3605", 10)}

//***********************La fenêtre Rebalancing Criteria Manger dans l’onglet Rebalancing Criteria (btn Assign/Manage)  *********************

function Get_WinRebalancingCriteriaManager(){return Aliases.CroesusApp.winRebalancingCriteriaManager}

function Get_WinRebalancingCriteriaManager_BtnAssign(){return Get_WinRebalancingCriteriaManager().FindChild("Uid", "Button_d885", 10)}

function Get_WinRebalancingCriteriaManager_BtnClose(){return Get_WinRebalancingCriteriaManager().FindChild("Uid", "Button_c2a4", 10)}

function Get_WinRebalancingCriteriaManager_PadHeader(){return Get_WinRebalancingCriteriaManager().FindChild("Uid", "PadHeader_bbd1", 10)}

function Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd(){return Get_WinRebalancingCriteriaManager_PadHeader().FindChild("Uid", "Button_3bd4", 10)}

function Get_WinRebalancingCriteriaManager_PadHeader_BtnEdit(){return Get_WinRebalancingCriteriaManager_PadHeader().FindChild("Uid", "Button_926c", 10)}

function Get_WinRebalancingCriteriaManager_PadHeader_BtnDelete(){return Get_WinRebalancingCriteriaManager_PadHeader().FindChild("Uid", "Button_b16e", 10)}

function Get_WinRebalancingCriteriaManager_DgRules(){return Get_WinRebalancingCriteriaManager().FindChild("Uid", "DataGrid_ffeb", 10)}

//***********************La fenêtre Account Rebalancing Criteria (cliquer sur btnAdd dans la fenêtre Rebalancing Criteria Manger *********************

function Get_WinAccountRebalancingCriteria(){return Aliases.CroesusApp.winAccountRebalancingCriteria}

function Get_WinAccountRebalancingCriteria_ChkAvoidSplittingTransactions(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "CheckBox_f989", 10)}

function Get_WinAccountRebalancingCriteria_BtnSave(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "Button_c708", 10)}

function Get_WinAccountRebalancingCriteria_BtnCancel(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "Button_aed0", 10)}

function Get_WinAccountRebalancingCriteria_TxtName(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "LocaleTextbox_05db", 10)}

function Get_WinAccountRebalancingCriteria_TxtAccess(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "TextBlock_b288", 10)}

function Get_WinAccountRebalancingCriteria_CmbAccess(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "ComboBox_0a2f", 10)}

function Get_WinAccountRebalancingCriteria_CmbIfNot(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "ComboBox_57fd", 10)}

function Get_WinAccountRebalancingCriteria_CmbIfNot_ItemDisplayWarningMessage()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Afficher un message d'avertissement"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Display a warning message"], 10)}
}

function Get_WinAccountRebalancingCriteria_TxtDescription(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "LocaleTextbox_8beb", 10)}

function Get_WinAccountRebalancingCriteria_LstCondition(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "ConditionList_1888", 10).FindChild("Uid", "ListBox_3457", 10)}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb_ItemHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "having"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbField()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbField_ItemSymbol()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "symbole"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "symbol"], 10)}
}


function Get_WinAccountRebalancingCriteria_LstCondition_LlbField_ItemPriceCurrency()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "devise de prix"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "price currency"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbAccount_ItemSameCurrency()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "un compte de même devise"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "an account of the same currency"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbOperator()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_ItemEqualTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "égal(e) à"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "equal to"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbValue()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbNext()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstCondition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", ","], 10)}



function Get_WinAccountRebalancingCriteria_LstAction(){return Get_WinAccountRebalancingCriteria().FindChild("Uid", "ConditionList_496a", 10).FindChild("Uid", "ListBox_3457", 10)}

function Get_WinAccountRebalancingCriteria_LstAction_LlbVerb()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)}
}



function Get_WinAccountRebalancingCriteria_LstAction_LlbAccount()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "un compte"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "an account"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "having"], 10)}
}


function Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemDot()
{
return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "."], 10)}



function Get_WinAccountRebalancingCriteria_LstAction_LlbField()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Informatif"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Informative"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative_ItemBusinessAccount()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "compte d'entreprise"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "business account"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative_ItemType()
{
  return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type"], 10)
}


function Get_WinAccountRebalancingCriteria_LstAction_LlbOperator()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_ItemEqualTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "égal(e) à"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "equal to"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_ItemNotInList()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "qui exclut"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "not in list"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbValue()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbValue_ItemYes()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Oui"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Yes"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbNext()
{
  if (language == "french"){return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)}
  else {return Get_WinAccountRebalancingCriteria_LstAction().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)}
}

function Get_WinAccountRebalancingCriteria_LstAction_LlbNext_ItemDot(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "."], 10)}

function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calcul"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calculation"], 10)}
}
function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation_ItemMargin()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "marge"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "margin"], 10)}
}
function Get_WinAccountRebalancingCriteria_LstAction_TxtField(){
     if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}
     else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)}

}



//***********************La fenêtre Selection (Symbol) (s'ouvre à partir de la fenêtre Account Rebalancing Criteria)  *********************

function Get_WinSelectionSymbol(){return Aliases.CroesusApp.winSelectionSymbol}

function Get_WinSelectionSymbol_DgAvailable(){return Get_WinSelectionSymbol().FindChild(["Uid","WPFControlName"], ["DataGrid_3d6d","_SecurityPropertyGrid"], 10)}

function Get_WinSelectionSymbol_LbSelected(){return Get_WinSelectionSymbol().FindChild("Uid", "ListBox_6ace", 10)} 

function Get_WinSelectionSymbol_BtnToRight(){return Get_WinSelectionSymbol().FindChild("Uid", "Button_5eba", 10)} 

function Get_WinSelectionSymbol_BtnToLeft(){return Get_WinSelectionSymbol().FindChild("Uid", "Button_3d6c", 10)} 

function Get_WinSelectionSymbol_BtnOk(){return Get_WinSelectionSymbol().FindChild("Uid", "Button_2735", 10)} 

function Get_WinSelectionSymbol_BtnCancel(){return Get_WinSelectionSymbol().FindChild("Uid", "Button_a238", 10)} 

/*La fenêtre Selection obtenu a partir du critére de réequilibrage*/
function Get_WinEnumRebalancingCriteria(){return Aliases.CroesusApp.winSelectionRebalancingCriteria}

function Get_WinEnumRebalancingCriteria_LstAvailable(){return Get_WinEnumRebalancingCriteria().FindChild(["Uid","WPFControlName"], ["ListBox_b6f0","AvailableList"], 10)}

function Get_WinEnumRebalancingCriteria_BtnToRight(){return Get_WinEnumRebalancingCriteria().FindChild("Uid", "Button_7e45", 10)}

function Get_WinEnumRebalancingCriteria_BtnToLeft(){return Get_WinEnumRebalancingCriteria().FindChild("Uid", "Button_b5a4", 10)} 

function Get_WinEnumRebalancingCriteria_BtnOk(){return Get_WinEnumRebalancingCriteria().FindChild("Uid", "Button_57e1", 10)} 

function Get_WinEnumRebalancingCriteria_BtnCancel(){return Get_WinEnumRebalancingCriteria().FindChild("Uid", "Button_0555", 10)} 
//********************* MODELS QUICK SEARCH (MODÈLES - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinModelsQuickSearch_RdoName() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "NAME - Nom"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Nom"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "NAME - Name"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Name"])}
}

function Get_WinModelsQuickSearch_RdoModelNo() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ACCOUNTNUMBER - No de modèle"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - No de modèle"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ACCOUNTNUMBER - Model No."], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - Model No."])}
}

function Get_WinModelsQuickSearch_RdoIACode() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "REPRESENTATIVENUMBER - Code de CP"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - Code de CP"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "REPRESENTATIVENUMBER - IA Code"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - IA Code"])}
}

//Pour la fenêtre Rechercher de l'assignation de relations à un modèle
function Get_WinModelsQuickSearch_RdoNameForAssigningRelationships() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "SHORTNAME - Nom"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "SHORTNAME - Nom"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "SHORTNAME - Name"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "SHORTNAME - Name"])}
}

//Apparaît dans la fenêtre Rechercher de l'assignation de relations à un modèle
function Get_WinModelsQuickSearch_RdoRelationshipNo() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "LINKNUMBER - No relation"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - No relation"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "LINKNUMBER - Relationship No."], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - Relationship No."])}
}

//Apparaît dans la fenêtre Rechercher de l'assignation de clients à un modèle
function Get_WinModelsQuickSearch_RdoClientNo() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "CLIENTNUMBER - No client"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - No client"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "CLIENTNUMBER - Client No."], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - Client No."])}
}

//Apparaît dans la fenêtre Rechercher de l'assignation de comptes à un modèle
function Get_WinModelsQuickSearch_RdoAccountNo() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ACCOUNTNUMBER - No compte"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - No compte"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ACCOUNTNUMBER - Account No."], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - Account No."])}
}



//*************************************** FENÊTRE RÉÉQUILIBRER (REBALANCE WINDOW) ************************************************

function Get_WinRebalance(){return Aliases.CroesusApp.winRebalance}

function Get_WinRebalance_LblModelName(){return Get_WinRebalance().FindChild("Uid", "TextBlock_0f05", 10)} //ok

function Get_WinRebalance_LblStep1Number(){return Get_WinRebalance().FindChild("Uid", "TextBlock_3598", 10)} //ok

function Get_WinRebalance_LblStep1Name(){return Get_WinRebalance().FindChild("Uid", "TextBlock_dda3", 10)} //ok

function Get_WinRebalance_LblStep2Number(){return Get_WinRebalance().FindChild("Uid", "TextBlock_5f46", 10)} //ok

function Get_WinRebalance_LblStep2Name(){return Get_WinRebalance().FindChild("Uid", "TextBlock_e67f", 10)} //ok

function Get_WinRebalance_LblStep3Number(){return Get_WinRebalance().FindChild("Uid", "TextBlock_5880", 10)} //ok

function Get_WinRebalance_LblStep3Name(){return Get_WinRebalance().FindChild("Uid", "TextBlock_de2c", 10)} //ok

function Get_WinRebalance_LblStep4Number(){return Get_WinRebalance().FindChild("Uid", "TextBlock_c964", 10)} //ok

function Get_WinRebalance_LblStep4Name(){return Get_WinRebalance().FindChild("Uid", "TextBlock_25c3", 10)} //ok

function Get_WinRebalance_LblStep5Number(){return Get_WinRebalance().FindChild("Uid", "TextBlock_97ac", 10)} //ok

function Get_WinRebalance_LblStep5Name(){return Get_WinRebalance().FindChild("Uid", "TextBlock_6725", 10)} //ok

function Get_WinRebalance_BtnPrevious(){return Get_WinRebalance().FindChild("Uid", "Button_559b", 10)} //ok

function Get_WinRebalance_BtnClose(){return Get_WinRebalance().FindChild("Uid", "Button_5f20", 10)} //ok

function Get_WinRebalance_BtnNext(){return Get_WinRebalance().FindChild("Uid", "Button_b879", 10)} //ok

function Get_WinRebalance_BtnGenerate(){return Get_WinRebalance().FindChild("Uid", "Button_021a", 10)} //ok


//Étape 1 (Paramètres)

function Get_WinRebalance_TabParameters_BarPadHeader(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "PadHeader_0e94", 10)} //ok

function Get_WinRebalance_TabParameters_RdoBasedOnTargetValue(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "RadioButton_e9b2", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRebalance(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GroupBox_1da2", 10)} 

function Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(){return Get_WinRebalance_TabParameters_GrpRebalance().FindChild("Uid", "UniComboBox_ef84", 10)} 

function Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(){return Get_WinRebalance_TabParameters_GrpRebalance().FindChild("Uid", "Label_41cc", 10)} 

function Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(){return Get_WinRebalance_TabParameters_GrpRebalance().FindChild("Uid", "TextBlock_26d0", 10)} 

function Get_WinRebalance_TabParameters_RdoBasedOnMarketValue(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "RadioButton_d6e1", 10)} //ok

function Get_WinRebalance_TabParameters_LblSystematicWithdrawals(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Label_eaba", 10)} //ok

function Get_WinRebalance_TabParameters_TxtSystematicWithdrawals(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "DoubleTextBox_1308", 10)} //ok

function Get_WinRebalance_TabParameters_LblMinimumOrderAmount(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Label_85db", 10)} //ok

function Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "DoubleTextBox_7abb", 10)} //ok

function Get_WinRebalance_TabParameters_LblValidateTargetRange(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Label_bc37", 10)} //ok

function Get_WinRebalance_TabParameters_ChkValidateTargetRange(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "CheckBox_0307", 10)} //ok

function Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "CheckBox_f310", 10)} //ok

function Get_WinRebalance_TabParameters_ChkApplyAccountFees(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "CheckBox_6b3f", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GroupBox_5597", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblStocks(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_5c9e", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtStocks(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_b478", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblBonds(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_ccfb", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtBonds(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_71bb", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblOptions(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_eb8a", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtOptions(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_e955", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblCoupons(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_d7cd", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtCoupons(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_ccc7", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblMutualFund(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_cd0c", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtMutualFund(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_f5bd", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_LblDebentures(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "Label_06f5", 10)} //ok

function Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtDebentures(){return Get_WinRebalance_TabParameters_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_eb96", 10)} //ok


//Étape 2 (Portefeuilles à rééquilibrer)

function Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "PadHeader_d781", 10)}//ok

function Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(){return Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader().FindChild("Uid", "ToggleButton_437a", 10)}//ok

function Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement(){return Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader().FindChild("Uid", "Button_2943", 10)}//ok

function Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts(){return Get_WinRebalance().FindChild("Uid", "DataGrid_7456", 10)}

function Get_WinRebalance_TabPortfoliosToRebalance_LblNbOfSelectedItems(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Label_5cdc", 10)}//ok

function Get_WinRebalance_TabPortfoliosToRebalance_ChPortfolioTypeIcon(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}//no uid

function Get_WinRebalance_TabPortfoliosToRebalance_ChName()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChAssignedModel()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modèle associé"], 10)}//Avant BE Modèle assigné: Selon Mélanie , associer est le bon terme 
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigned Model"], 10)}
}

//function Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription()//no uid
//{
//  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
//  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
//}

function Get_WinRebalance_TabPortfoliosToRebalance_ChNumber()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChIACode()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChBalance()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChMargin()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChTotalValue()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChCashMgmt()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gest. encaisse"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Mgmt"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}

// Les colonnes dans ExpandableFieldRecordPresenter, après avoir clique sur + 

function Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescriptionPlus()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChAssetAllocation()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Répartition d'actifs"], 10)} //EM: 90-06-Be-17  Modifié selon le Jira CROES-3484 - avant "Répartition d'actif"
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Asset Allocation"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChMinPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "% Min"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min %"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChTargePercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "% Cible"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target %"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChMaxPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "% Max"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max %"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChActualPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "% Actuel"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Actual %"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChModel()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modèle"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChMarketValue()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}


function Get_WinRebalance_TabPortfoliosToRebalance_ChCashBalance()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Balance"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChNoOfPositions()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de positions"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Positions"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalancePlus_ChCashMgmt()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gest. encaisse"], 10)}
  else {return Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Mgmt"], 10)}
}

function Get_WinRebalance_TabPortfoliosToRebalance_ChPercentBalance()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance (%)"], 10)}
}

function Get_WinRebalance_LblSelectedItems()
{
  return Get_WinRebalance().FindChild("Uid", "Label_5cdc", 100)
}

// Étape 2 - tab Portefeuille projeteé
function Get_WinRebalance_PositionsGrid(){return Get_WinRebalance().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_67cd","true"], 10)}

function Get_WinRebalance_RebalancePositionsGrid(){return Get_WinRebalance().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_c762","true"], 10)}

//Étape 2 - tab Portefeuille projeteé la fenêtre cash Management 

function Get_WinCashManagement(){return Aliases.CroesusApp.WinCashAmountOverride}

function Get_WinCashManagement_DgvOverrideCashAmountData(){return Get_WinCashManagement().Find("Uid","DataGrid_97b0",10)}

function Get_WinCashManagement_BtnOk(){return Get_WinCashManagement().Find("Uid","Button_0ca5",10)}

function Get_WinCashManagement_BtnCancel(){return Get_WinCashManagement().Find("Uid","Button_8187",10)}

function Get_WinCashManagement_ChName()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinCashManagement_ChSleeveDescription()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}

function Get_WinCashManagement_ChAccountNo()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinCashManagement_ChTotalValue()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_WinCashManagement_ChCashMgmt()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gest. encaisse"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Mgmt"], 10)}
}

function Get_WinCashManagement_ChIACode()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinCashManagement_ChCurrency()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_WinCashManagement_ChBalance()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_WinCashManagement_ChMargin()
{
  if (language=="french"){return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_WinCashManagement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

//Étape 3 (Positions à rééquilibrer)

function Get_WinRebalance_TabPositionsToRebalance_BarPadHeader(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "PadHeader_d55c", 10)}//ok

function Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll(){return Get_WinRebalance_TabPositionsToRebalance_BarPadHeader().FindChild("Uid", "ToggleButton_155e", 10)}//ok

function Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll(){return Get_WinRebalance_TabPositionsToRebalance_BarPadHeader().FindChild("Uid", "ToggleButton_add2", 10)}//ok

function Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices(){return Get_WinRebalance_TabPositionsToRebalance_BarPadHeader().FindChild("Uid", "Button_affd", 10)}//ok


function Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//no uid

function Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible (%)"], 10)} //EM: 90-06-Be-17 modifié selon le Jira CROES-9570 - avant "VM cible"
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target (%)"], 10)} //EM: 90-06-Be-17 modifié selon le Jira CROES-9570 - avant "Target MV (%)"
}

function Get_WinRebalance_TabPositionsToRebalance_ChMinTargetPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible min. (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. Target (%)"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMaxTargetPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible max. (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. Target (%)"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM min. (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. MV (%)"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM max. (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. MV (%)"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChDescription(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}//no uid

function Get_WinRebalance_TabPositionsToRebalance_ChSymbol()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMarketPrice()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Update"], 10)}
}

// Cette fonction est appellée dans le cas de CLIENT = CIBC
function Get_WinRebalance_TabPositionsToRebalance_ChUpdatedOn()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière m.-à-j."], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Updated on"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChMaturity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChBeta()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bêta"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Beta"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChAsk()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChAssetAllocation()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Répartition d'actifs"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Asset Allocation"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChBid()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChClose()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChCUSIP(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)}//no uid

function Get_WinRebalance_TabPositionsToRebalance_ChDividend()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChFrequency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChInterest()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêt"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChModifiedDuration()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée modifiée"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified Duration"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChRegion()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChSector()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Secteur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sector"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChSecurity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinRebalance_TabPositionsToRebalance_ChSubcategory()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

//tab Proposed Orders
function Get_WinRebalance_TabProposedOrders(){return Get_WinRebalance().FindChild("Uid", "TabControl_5bbf", 10)}

function Get_WinRebalance_TabProposedOrders_DgvProposedOrders(){return Get_WinRebalance().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_6f42",true], 10)}

//*************************************FENÊTRE Modifier les prix de l'étape 3 après avoir cliqué sur le btn 'Modifier les prix'******************************************

function Get_WinEditPrices(){return Aliases.CroesusApp.WinEditPrices}

function Get_WinEditPrices_DgvOverridePrice(){return Get_WinEditPrices().FindChild("Uid","DataGrid_32c2",10)}

function Get_WinEditPrices_BtnOk(){return Get_WinEditPrices().FindChild("Uid","Button_358a",10)}

function Get_WinEditPrices_BtnCancel(){return Get_WinEditPrices().FindChild("Uid","Button_e0e9",10)}

//Étape 4 (Portefeuilles projetés)

function Get_WinRebalance_TabProjectedPortfolios_BarPadHeader(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "PadHeader_7886", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(){return Get_WinRebalance().FindChild("Uid", "Button_d139", 10)}//ok //EM : Modifié depuis 90-08-15 Dy : Le parent n'est plus Get_WinRebalance_TabProjectedPortfolios_BarPadHeader()

function Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(){return Get_WinRebalance().FindChild("Uid", "Button_129b", 10)}//ok //EM : Modifié depuis 90-08-15 Dy : Le parent n'est plus Get_WinRebalance_TabProjectedPortfolios_BarPadHeader()

function Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(){return Get_WinRebalance().FindChild("Uid", "Button_d48a", 10)}//ok //EM : Modifié depuis 90-08-15 Dy : Le parent n'est plus Get_WinRebalance_TabProjectedPortfolios_BarPadHeader()

function Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(){return Get_WinRebalance().FindChild("Uid", "ToggleButton_c0e5", 10)}//ok


//Étape 4 - Browser panel
function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Expander_7bcc", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find(["Uid","VisibleOnScreen"],["DataGrid_d123",true],10)}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_BtnShowAll(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild("Uid", "Button_f8cc", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChRestriction(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMessages(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message(s)"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChPortfolioTypeIcon(){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChName()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChSleeveDescription()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChIACode()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChBalance()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMargin()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChTotalValue()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCashMgmt()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gest. encaisse"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Mgmt"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChPercentBalance()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde (%)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance (%)"], 10)}
}


//Étape 4 - Proposed Orders tab
function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_ValidateUnrestrictedSegment(sleeveLongTerm)
{
  var maxRetry = 5;
  //Valider que pour le segment sans restriction, le message ne s’affiche pas.
  for (i = 1; i <= maxRetry; i++) {
      Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveLongTerm,10).Click();       
      
      if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg().Exists) {
        if (i == maxRetry) {
          Log.Error("Un message bloquant s’affiche pour ce segment. On ne devrait pas avoir un message bloquant pour ce segment.")
        }
        else {}
       Log.Message("Un message bloquant s’affiche pour ce segment. " +i +" fois sur " +maxRetry +" essais.")
      }
      else{
       Log.Checkpoint("Il n'y a pas de message bloquant pour ce segment");
       break;
      }
      Delay(1000);
  }
}
        

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabItem_9881", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabCashMovements(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabItem_51c3", 10)}//pour le module Portfolio

function Get_WinRebalance_TabProjectedPortfolios_TabCashMovements_DgvCashMovements(){return Get_WinRebalance().FindChild("Uid", "DataGrid_dc40", 10)}//pour le module Portfolio

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Expander_0a4c", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "Button_830b", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "TextBlock_619e", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg1(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "TextBlock_0bb4", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_DgvRestriction(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "DataGrid_bddb", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "TextBlock_619e", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "Description", 10)} 

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblElementIdentifier(){return Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().FindChild("Uid", "ElementIdentifier", 10)} 


//block off - bouton Grouper désélectionné
function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild(["WPFControlName","VisibleOnScreen"],[ "_openOrdersGrid",true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", "1", true], 10)} //ok, no uid for recordlistcontrol (Infragistics)

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés ($)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L ($)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMessage(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inclure"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Include"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du prix"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérets courus selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued Interest Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérets courus selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued Interest Account Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Description"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de rééquilibrage"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rebal. Date"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAsk()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBid()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChClose()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChCUSIP(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChDividend()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFinancialInstrument()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFrequency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInterest()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêt"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueAccountCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value Account Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMaturity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceAccountCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Account Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChProjMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Proj. VM (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Proj. MV (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRegion()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSubcategory()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_openOrdersGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}


//block on - bouton Grouper sélectionné
function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild(["WPFControlName","VisibleOnScreen","Uid"], ["_bulkGroupsGrid",true,"DataGrid_6f42"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)} //ok, no uid for recordlistcontrol (Infragistics)

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChType(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChQuantity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityDescription()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Description"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSymbol()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChPriceSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChAccruedInterestSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérets courus selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued Interest Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChMarketValueSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("WPFControlName", "_bulkGroupsGrid", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_ChRealizedGL()//no uid
{
	if (language=="french") return Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés ($)"], 10)
	else return Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L ($)"], 10)
}
function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_ChrealizedGLPercent()//no uid
{
	if (language=="french") return Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés (%)"], 10)
	else return Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L (%)"], 10)
}


//Étape 4 - Projected Portfolio tab
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabItem_1dfc", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupBySecurity(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "ToggleButton_79ce", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "ToggleButton_8cb6", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "ToggleButton_4bd5", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnTreeviewButton(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "Button_1b65", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnTreeviewButton_LblProjectedPortfolioTitle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnTreeviewButton().FindChild("Uid", "TextBlock_dbb7", 10)}//ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_CmbCurrency(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "ComboBox_761d", 10)}//uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_LblBlinkingText(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TextBlock_ce68", 10)}//ok

// Étape 4 - Projected Portfolio tab - le btn 'par compte' est actif
 
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount(){return Get_WinRebalance().FindChild("Uid", "TabControl_5bbf", 10).FindChild(["Uid", "VisibleOnScreen"], ["ProjectedPortfolioByAccountGrid_74e4",true], 10)}//ok

//Summary
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_ScrollViewer(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "ScrollViewer_ca37", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "RQSCharts_e003", 10)}


//Risk Score Graph

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_LblTitle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_794d", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblActual(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_c293", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblObjective(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_52c2", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_d923", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0804", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_GeneralRectangle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, "GeneralRiskScoreRectangle"], 1)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_ActualRectangle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, ""], 1)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskScore_ObjectiveTriangle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Polygon", true, ""], 1)}


//Risk Objectives Graph

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblTitle(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_ab46", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent0(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4581", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent25(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4d32", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent50(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1d52", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent75(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0e22", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent100(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1dc3", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().FindChild("Uid", "ItemsControl_e375", 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskLabel){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["Rectangle", true, riskLabel], 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskLabel){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "Points.Count", "DataContext.RiskLabel"], ["Polygon", true, 3, riskLabel], 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskLabel){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel", "WPFControlText"], ["TextBlock", true, riskLabel, riskLabel], 10)}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskLabel)
{
    var allTextBlockControls = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindAllChildren(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["TextBlock", true, riskLabel], 10).toArray();
    for (var i in allTextBlockControls)
        if (allTextBlockControls[i].WPFControlText != riskLabel)
            return allTextBlockControls[i];
    return Utils.CreateStubObject();
}

//Étape 4 - Projected Portfolio tab, Grille
function Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GridSection_0466", 10)}

//Étape 4 - Projected Portfolio tab, BtnGroupByAssetClass Off
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GridSection_0466", 10).FindChild(["WPFControlName","VisibleOnScreen"],["PositionsGrid",true],10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio_ExpandedElement(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés ($)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L ($)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés (%)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P non réalisés ($)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unrealized G/L ($)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P non réalisés (%)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unrealized G/L (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écart des quantités"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty Variation"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Position bloquée"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Locked Position"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAssetAllocation()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rép. d'actifs"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Asset Allocation"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "PBR"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "ACB"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBookValue()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur comptable"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Book Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée mod."], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mod. Duration"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChNonRedeem()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non rachetable"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non-redeemable"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAsk()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBasicCategories()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBeta()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bêta"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Beta"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBid()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClientNo()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClose()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChCUSIP(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDividend()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChExcludeFromProjectedIncome()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclure de la projection de liquidités"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclude from Projected Income"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFinancialInstrument()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFrequency()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInterestPortion()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Portion d'intéret"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest Portion"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestCost()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. unitaire"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cost"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestedCapital()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital investi"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invested Capital"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLastBuy()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier achat"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Buy"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMaturity()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRegion()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSector()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Secteur"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sector"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurity()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurityCurrency()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSubcategory()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone1()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone2()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 2"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 2"], 10)}
}

//Étape 4 - Projected Portfolio tab, BtnGroupByAssetClass On
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GridSection_0466", 10).FindChild("WPFControlName", "_assetMixgrid").FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChNoOfPositions()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de positions"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Positions"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestedCapital()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital investi"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invested Capital"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMarketValue()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMVPercent()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestCapGL()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P cap. investi"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cap. G/L"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAccruedID()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAnnInc()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChBookValueACB()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur comptable"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Book Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChGLBookValue()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P valeur comptable"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/L Book Value"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMinObj()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. min."], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. Obj."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMaxObj()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. max."], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. Obj."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetObj()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. cible"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target Obj."], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetStatus()//no uid
{
  if (language=="french"){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible"], 10)}
  else {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target"], 10)}
}

//Étape 4 - Projected Portfolio tab, BtnGroupByAccount On
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "GridSection_0466", 10).FindChild("WPFControlName", "ProjectedPortfolioByAccountGrid", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}//no uid -- changé pour 90.07.23, était 'GridProjectedSimplified' à la place de 'ProjectedPortfolioByAccountGrid' avant

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(ClientColumnContent){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ClientColumnContent], 10)}//no uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "ComboBox_1509", 10)}//uid

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByAssetClass() //no uid
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Par classe d'actifs"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "By asset class"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByAssetGroup() //no uid
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Par groupe d'actifs"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "By asset group"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition() //no uid
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Par position"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "By position"], 10)}
}


//Étape 4 - Projected Portfolio tab - Summary

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "TabControl_5bbf", 10).FindChild("Uid", "Expander_0bf3", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblCurrency(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_358a", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMarketValue(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_af91", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_8056", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBookValue(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_67cd", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBookValue(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_2c92", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBalance(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_9581", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_3251", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccruedIntDiv(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_7a75", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAccruedIntDiv(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_bd28", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAnnualIncome(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_1ded", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAnnualIncome(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_02ef", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBeta(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_21d3", 10)} //missing in Automation 8

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBeta(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_ca9f", 10)} //missing in Automation 8

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAverageCostYield(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_72fb", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAverageCostYield(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_6ffe", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblModDurationAvg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_850e", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtModDurationAvg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_96b3", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblNetInvestment(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_a1e7", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtNetInvestment(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_fd52", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMargin(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_7b35", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMargin(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_2c00", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccumulatedCommission(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_80d2", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbAccumulatedCommission(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_ac66", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccumIntDiv(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_7a75", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbAccumIntDiv(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_7d32", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAssetAllocation(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_549b", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "ComboBox_9a34", 10)} //ok

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation_Firm() //no uid
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "De la firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Firm"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation_Growth()  //no uid
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance (Objectif)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Growth (Objective)"], 10)}
}

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_ChkFundAllocation(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "CheckBox_4b53", 10)} //missing in Automation 8 (pref??)

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_ChkFundAllocation_LblFundAllocation(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_ChkFundAllocation().FindChild("Uid", "TextBlock_3c0b", 10)} //missing in Automation 8 (pref??)

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_d503", 10)} //Avant 25 // AT -14 //YR: WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_1d9c", 10)} //Avant 26 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_b13f", 10)} //Avant 29 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_5e51", 10)} //jira uid Avant 57 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_d611", 10)} //jira uid Avant 59 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_1390", 10)} //jira uid Avant 61 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_7f35", 10)} //ok Avant 26 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_17a3", 10)} //ok Avant 28 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_b1d7", 10)} //ok // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLRegCalculated(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "Label_cdcf", 10)} //ok Avant 30 // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "CFTextBlock_904b", 10)} //jira uid Avant 58 // AT -14 //EM : 90-08-15 DY - Avant 33 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid","CFTextBlock_64c8", 10)} //jira uid Avant 60 // AT -14 //EM : 90-08-15 DY - Avant 34 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonReg(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "TextBlock_d0bd", 10)} //jira uid // AT -14 //YR WPFControlOrdinalNo Est différant sur 19.15.86 

function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonRegCalculated(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", "CFTextBlock_cdd5", 10)} //jira uid Avant 62 // AT -14  //EM : 90-08-15 DY - Avant 35 //YR WPFControlOrdinalNo Est différant sur 19.15.86 
//****************************************************WINDOW MODIFIY A POSITION*****************************************************************

function Get_WinModifyPosition(){return Aliases.CroesusApp.winPositionInfo}

function Get_WinModifyPosition_BtnOK(){return Get_WinModifyPosition().FindChild("Uid", "Button_11da", 10)} //ok

function Get_WinModifyPosition_BtnCancel(){return Get_WinModifyPosition().FindChild("Uid", "Button_dee6", 10)} //ok

function Get_WinModifyPosition_CmbCompte(){return Get_WinModifyPosition().FindChild("Uid", "ComboBox_3ae5", 10)} //ok

function Get_WinModifyPosition_GrpPositionInformation(){return Get_WinModifyPosition().FindChild("Uid", "GroupBox_202c", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtMarketPrice(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_3815", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_e845", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtQtyVariation(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_8b23", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_d06d", 10)}

//****************************************************WARNING WINDOW*****************************************************************************

function Get_WinWarningDeleteGeneratedOrders(){return Aliases.CroesusApp.winDeleteGeneratedOrders}

function Get_WinWarningDeleteGeneratedOrders_BtnYes(){return Get_WinWarningDeleteGeneratedOrders().FindChild("Uid","Button_2676",10)}

//Étape 5 (Ordres à exécuter)

function Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", "1", true], 10)}

function Get_WinRebalance_TabOrdersToExecute_ChInclude() //no uid, not available on FBN ?
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inclure"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Include"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChName() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChAccountNo() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChIACode() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChType(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)} //no uid

function Get_WinRebalance_TabOrdersToExecute_ChQuantity() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Security Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChPriceAccountCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Account Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du prix"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChMarketValueAccountCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value Account Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value Security Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChProjMVPercent() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Proj. VM (%)"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Proj. MV (%)"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestSecurityCurrency() //no uid, not available on FBN ?
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérets courus selon la devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued Interest Security Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérets courus selon la devise du compte"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued Interest Account Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Description"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChSymbol() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChSecurity() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChRebalDate()
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de rééquilibrage"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rebal. Date"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChSubcategory() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChFinancialInstrument() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChBid() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChDividend() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChInterest() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêt"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChAsk() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChClose() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChFrequency() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChMaturity() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChRegion() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChCUSIP(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)} //no uid

function Get_WinRebalance_TabOrdersToExecute_ChBasicCategories() //no uid
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_WinRebalance_TabOrdersToExecute_ChRebalanceNo() //no uid, not available on FBN ?
{
  if (language=="french"){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de rééquilibrage"], 10)}
  else {return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rebalance No"], 10)}
}


//******************************** FENÊTRE INFO MODÈLE (MODEL INFO WINDOW) ****************************************

function Get_WinModelInfo(){return Aliases.CroesusApp.winModelInfo}

function Get_WinModelInfo_BtnOK(){return Get_WinModelInfo().Find("Uid", "Button_dd2f", 10)} //ok

function Get_WinModelInfo_BtnCancel(){return Get_WinModelInfo().Find("Uid", "Button_620a", 10)} //ok

function Get_WinModelInfo_BtnClose(){return Get_WinModelInfo().Find("Uid", "Button_ad44", 10)} //missing (available for non editable models) 

function Get_WinModelInfo_GrpModel(){return Get_WinModelInfo().Find("Uid", "GroupBox_2d83", 10)} //ok

function Get_WinModelInfo_GrpModel_LblFullName(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_9885", 10)} //ok

function Get_WinModelInfo_GrpModel_TxtFullName(){return Get_WinModelInfo_GrpModel().Find("Uid", "CustomTextBox_701c", 10)} //ok

function Get_WinModelInfo_GrpModel_LblShortName(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_5326", 10)} //ok

function Get_WinModelInfo_GrpModel_TxtShortName(){return Get_WinModelInfo_GrpModel().Find("Uid", "CustomTextBox_1313", 10)} //ok

function Get_WinModelInfo_GrpModel_LblCurrency(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_6cd6", 10)} //ok

function Get_WinModelInfo_GrpModel_CmbCurrency(){return Get_WinModelInfo_GrpModel().Find("Uid", "ComboBox_18b9", 10)} //ok

function Get_WinModelInfo_GrpModel_LblType(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_6c08", 10)} //ok

function Get_WinModelInfo_GrpModel_CmbType(){return Get_WinModelInfo_GrpModel().Find("Uid", "ComboBox_ca19", 10)} //ok

function Get_WinModelInfo_GrpModel_LblCreation(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_f3cf", 10)} //ok

function Get_WinModelInfo_GrpModel_DtpCreation(){return Get_WinModelInfo_GrpModel().Find("Uid", "DateField_1a46", 10)} //ok

function Get_WinModelInfo_GrpModel_LblIACode(){return Get_WinModelInfo_GrpModel().Find("Uid", "TextBlock_b736", 10)} //ok

function Get_WinModelInfo_GrpModel_CmbIACode(){return Get_WinModelInfo_GrpModel().Find("Uid", "IACodeControl_1adb", 10)} //ok

function Get_WinModelInfo_GrpModel_ChkActive(){return Get_WinModelInfo_GrpModel().Find("Uid", "CheckBox_cce8", 10)} //ok


function Get_WinModelInfo_GrpUnderlyingAccountsSummary(){return Get_WinModelInfo().Find("Uid", "GroupBox_57e4", 10)} //ok

function Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblBalance(){return Get_WinModelInfo_GrpUnderlyingAccountsSummary().Find("Uid", "Label_7e09", 10)} //ok

function Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtBalance(){return Get_WinModelInfo_GrpUnderlyingAccountsSummary().Find("Uid", "CustomTextBox_5b43", 10)} //ok

function Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblTotalValue(){return Get_WinModelInfo_GrpUnderlyingAccountsSummary().Find("Uid", "Label_491d", 10)} //ok

function Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtTotalValue(){return Get_WinModelInfo_GrpUnderlyingAccountsSummary().Find("Uid", "CustomTextBox_aefb", 10)} //ok


function Get_WinModelInfo_TabNotes(){return Get_WinModelInfo().Find("Uid", "TabItem_0e95", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "TabItem_fc72", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate() //no uid
{
  if (language=="french"){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de référence"], 10)}
  else {return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Effective Date"], 10)}
}

function Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate() //no uid
{
  if (language=="french"){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

function Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy() //no uid
{
  if (language=="french"){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créée par"], 10)}
  else {return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created by"], 10)}
}

function Get_WinModelInfo_TabNotes_TabGrid_ChNote(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Note"], 10)} //no uid

function Get_WinModelInfo_TabNotes_TabGrid_ChModificationDate() //no uid
{
  if (language=="french"){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de modification"], 10)}
  else {return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modification Date"], 10)}
}

function Get_WinModelInfo_TabNotes_TabGrid_TxtNote(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "TextBox_b0b6", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid_BtnAdd(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "Button_ddd2", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid_BtnEdit(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "Button_2", 10)} //Missing in Automation 8 (pref?)

function Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "Button_309d", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "Button_8b6a", 10)} //ok

function Get_WinModelInfo_TabNotes_TabGrid_BtnPrint(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).Find("Uid", "Button_caf1", 10)} //ok

function Get_WinModelInfo_TabNotes_TabSummary(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).FindChild("Uid", "TabItem_a26f", 10)} //ok

function Get_WinModelInfo_TabNotes_TabSummary_TxtSummary(){return Get_WinModelInfo().FindChild("Uid", "TabControl_8db0", 10).FindChild("Uid", "TextBox_9bb1", 10)} //ok


function Get_WinModelInfo_TabInvestmentObjective(){return Get_WinModelInfo().Find("Uid", "TabItem_8753", 10)} //ok

function Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "CheckBox_fa4c", 10)} //ok

function Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "Button_d21d", 10)} //ok

function Get_WinModelInfo_TabInvestmentObjective_LblInvestmentObjective(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "Label_9e48", 10)} //ok


function Get_WinModelInfo_TabDocuments(){return Get_WinModelInfo().Find("Uid", "TabItem_b9d2", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar(){return Get_WinModelInfo().Find("Uid", "TabControl_416b", 10).Find("Uid", "ToolBarTray_536b", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnShowHideFolderView(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "ToggleButton_4ecd", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnAddAFile(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_7d78", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnRemove(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_25cf", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnRefresh(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_c153", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnCut(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_1f07", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnCopy(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_7b0f", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnPaste(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_4c55", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_TxtSearch(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "TextBox_dafe", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnSearch(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "Button_3e39", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnFilterAll(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "ToggleButton_4b62", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnFilterEmail(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "ToggleButton_9796", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnFilterPdf(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "ToggleButton_5b0c", 10)} //ok

//function Get_WinModelInfo_TabDocuments_Toolbar_BtnFilterFile(){return Get_WinModelInfo_TabDocuments_Toolbar().Find("Uid", "ToggleButton_ca4f", 10)} //ok

//function Get_WinModelInfo_TabDocuments_GrpComments(){return Get_WinModelInfo().Find("Uid", "TabControl_416b", 10).Find("Uid", "GroupBox_4d7f", 10)} //ok

//function Get_WinModelInfo_TabDocuments_GrpComments_TxtComment(){return Get_WinModelInfo_TabDocuments_GrpComments().Find("Uid", "TextBox_a547", 10)} //ok

//function Get_WinModelInfo_TabDocuments_GrpComments_BtnEdit(){return Get_WinModelInfo_TabDocuments_GrpComments().Find("Uid", "Button_b3e0", 10)} //ok

//function Get_WinModelInfo_TabDocuments_TvwDocuments(){return Get_WinModelInfo().Find("Uid", "TabControl_416b", 10).Find("Uid", "TreeView_856c", 10)} //ok

//function Get_WinModelInfo_TabDocuments_LstDocuments(){return Get_WinModelInfo().Find("Uid", "TabControl_416b", 10).Find("Uid", "ListBox_25ba", 10)} //ok

//Les fonctions Get pour les autres composants de l'onglet Documents, sont dans Common_Get_functions partie fenêtre Documents personnels

function Get_WinModelInfo_TabBasket(){return Get_WinModelInfo().Find("Uid", "TabItem_a780", 10)}

function Get_WinModelInfo_TabBasket_ChkAllowBuy(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "CheckBox_1d32", 10)} 

function Get_WinModelInfo_TabBasket_ChkAllowSell(){return Get_WinModelInfo().FindChild("Uid", "TabControl_416b", 10).FindChild("Uid", "CheckBox_5cf3", 10)} 

//********************************************* FENÊTRE ASSIGNER AU MODÈLE (ASSIGN TO MODEL WINDOW) **************************************************

function Get_WinAssignToModel(){return Aliases.CroesusApp.winAssignToModel}

function Get_WinAssignToModel_BtnYes(){return Get_WinAssignToModel().Find("Uid", "Button_90f7", 10)}

function Get_WinAssignToModel_BtnNo(){return Get_WinAssignToModel().Find("Uid", "Button_7367", 10)}

function Get_WinAssignToModel_BtnClose(){return Get_WinAssignToModel().Find("Uid", "Button_fb32", 10)}

function Get_WinAssignToModel_LblWarningMessage(){return Get_WinAssignToModel().Find("Uid", "Label_3f1d", 10)}

function Get_WinAssignToModel_Grid(){return Get_WinAssignToModel().Find("Uid", "DataGrid_4f59", 10)}

function Get_WinAssignToModel_ChAssign()
{
  if (language=="french"){return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assigner"], 10)}
  else {return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Assign"], 10)}
}

function Get_WinAssignToModel_ChConflict()
{
  if (language=="french"){return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Conflit"], 10)}
  else {return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Conflict"], 10)}
}

function Get_WinAssignToModel_ChName()
{
  if (language=="french"){return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignToModel_ChNumber()
{
  if (language=="french"){return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinAssignToModel_ChReasonOfConflict()
{
  if (language=="french"){return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Raison du conflit"], 10)}
  else {return Get_WinAssignToModel().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reason of Conflict"], 10)}
}

//La fenêtre Résultat du rééquilibrage 

function Get_WinGenerateOrders(){return Aliases.CroesusApp.winGenerateOrders}

function Get_WinGenerateOrders_BtnGenerate(){return Get_WinGenerateOrders().Find("Uid", "Button_0652", 10)}

function Get_WinGenerateOrders_BtnCancel(){return Get_WinGenerateOrders().Find("Uid", "Button_4e09", 10)}

function Get_WinGenerateOrders_GrpExcel(){return Get_WinGenerateOrders().Find("Uid", "GroupBox_4aab", 10)}

function Get_WinGenerateOrders_GrpExcel_ChkProjectedPortfolio(){return Get_WinGenerateOrders_GrpExcel().Find("Uid", "CheckBox_8439", 10)}

function Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders(){return Get_WinGenerateOrders_GrpExcel().Find("Uid", "CheckBox_e70f", 10)}

function Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders(){return Get_WinGenerateOrders_GrpExcel().Find("Uid", "CheckBox_fd34", 10)}

//function Get_WinGenerateOrders_GrpMode(){return Get_WinGenerateOrders().Find("Uid", "RadioButton_12d0", 10)}
function Get_WinGenerateOrders_GrpMode(){return Get_WinGenerateOrders().Find("Uid", "GroupBox_2d5e", 10)}//Modifier le 12/06/2019 par A.M

function Get_WinGenerateOrders_GrpMode_ChkGeneratedOrders(){return Get_WinGenerateOrders_GrpMode().Find("Uid", "RadioButton_12d0", 10)}

function Get_WinGenerateOrders_GrpMode_ChkPreview(){return Get_WinGenerateOrders_GrpMode().Find("Uid", "RadioButton_0a30", 10)}

function Get_WinGenerateOrders_GrpPDF(){return Get_WinGenerateOrders().Find("Uid", "GroupBox_9d88", 10)}

function Get_WinGenerateOrders_GrpPDF_ChkProjectedPortfolio(){return Get_WinGenerateOrders_GrpPDF().Find("Uid", "CheckBox_0fc2", 10)}

//La boite de dialogue «Modèle» 

function Get_DlgModel(){return Aliases.CroesusApp.dlgModel}



//la nouvelle fenetre lors du rééquilibrage 

function Get_WinWarningDeleteGeneratedOrders_BtnContinuAndKeepOrders(){return Get_WinWarningDeleteGeneratedOrders().Find("Uid", "Button_0ae2", 10)}

//la fenetre de modification d'ordre lors du rééquilibrage 
function Get_WinRebalance_TabProjectedPortfolios_WinEditOrders(){return Get_CroesusApp().FindChild("Uid", "InfoOrder_af45", 10)}
function Get_WinRebalance_TabProjectedPortfolios_WinEditOrders_TxtQuantity(){return Get_WinRebalance_TabProjectedPortfolios_WinEditOrders().FindChild("Uid", "DoubleTextBox_3838", 10)}
function Get_WinRebalance_TabProjectedPortfolios_WinEditOrders_BtnOK(){return Get_WinRebalance_TabProjectedPortfolios_WinEditOrders().FindChild("Uid", "Button_79c4", 10)}



//la fenetre de desactivation de modele lors d'ajout de positions 

function Get_DlgConfirmation_btnNo()
{
  if (language=="french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Non"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "No"], 10)}
}

function Get_DlgConfirmation_btnDesactive()
{
  if (language=="french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Désactiver"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Désactive"], 10)}
}

/**
    Description : Si le composant Get_ModelsPlugin() n'est pas trouvé, marque une pause
    Résultat : Boolean (true si le composant Get_ModelsPlugin() est finalement trouvé, false sinon)
    Auteur : Christophe Paring
*/
function WaitModelsPlugin()
{
    if (!(Get_ModelsPlugin().Exists)){//Christophe : Stabilisation
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 5000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 500000);
        Sys.Refresh();
    }
    return (Get_ModelsPlugin().Exists);
}
