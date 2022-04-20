//USEUNIT Common_Get_functions


//****************************************** ORDERS BAR  **********************************************

function Get_OrdersBar(){return Aliases.CroesusApp.winMain.OrderEntryControl.barPadHeader}

function Get_OrdersBar_BtnCFO(){return Get_OrdersBar().FindChild("Uid", "Button_81ae", 10)}

function Get_OrdersBar_BtnView(){return Get_OrdersBar().FindChild("Uid", "Button_bac8", 10)}

function Get_OrdersBar_BtnFills(){return Get_OrdersBar().FindChild("Uid", "Button_b6d8", 10)}

function Get_OrdersBar_BtnCXL(){return Get_OrdersBar().FindChild("Uid", "Button_53a0", 10)}

function Get_OrdersBar_BtnReplace(){return Get_OrdersBar().FindChild("Uid", "Button_69cc", 10)}

function Get_OrdersBar_BtnRefresh(){return Get_OrdersBar().FindChild("Uid", "Button_afed", 10)}



//************************************************ ORDER GRID ****************************************************

function Get_OrderGrid(){return Aliases.CroesusApp.winMain.OrderEntryControl.OrderGrid}


//Entêtes de colonne de la grille des ordres (Order grid Column headers)

function Get_OrderGrid_ChStatus()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_OrderGrid_ChAccountNo()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_OrderGrid_ChAccountName()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom du compte"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Name"], 10)}
}

function Get_OrderGrid_ChCfoCxl(){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CFO/CXL"], 10)}

function Get_OrderGrid_ChType(){
   //return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)
   if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type d'ordre"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order Type"], 10)}
}

function Get_OrderGrid_ChTypeColor()//Story GDO-1205
{
  /*if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type (couleur)"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type (color)"], 10)}*/
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Progression"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Progress"], 10)}
}

function Get_OrderGrid_ChPro(){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10)}

function Get_OrderGrid_ChQuantity()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_OrderGrid_ChSymbol()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_OrderGrid_ChDescription(){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_OrderGrid_ChPrice()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix de l'ordre"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order price"], 10)}
}

function Get_OrderGrid_ChGoodTill()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée de validité"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Good Till"], 10)}
}

function Get_OrderGrid_ChExecutedQty()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté exécutée"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Executed Qty"], 10)}
}

function Get_OrderGrid_ChExecutedPrice()//la story GDO-769
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix moyen d'exécution"], 10)}//avant Prix d'exécution
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Average Fill Price"], 10)}//avant Executed Price
}

function Get_OrderGrid_ChMarket()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marché"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market"], 10)}
}

function Get_OrderGrid_ChLastModification()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière modification"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Modification"], 10)}
}

function Get_OrderGrid_ChExecutionDate()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date d'exécution"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Execution Date"], 10)}
}

function Get_OrderGrid_ChIACode()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_OrderGrid_ChSupplierNo()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du fournisseur"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Supplier No."], 10)}
}

function Get_OrderGrid_ChAlternativeOrderNo()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No ordre de rechange"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Alternative Order No."], 10)}
}

function Get_OrderGrid_ChSource(){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)}

function Get_OrderGrid_ChSettlementDate()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de règlement"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Settlement Date"], 10)}
}

function Get_OrderGrid_ChSupplier()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fournisseur"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Supplier"], 10)}
}

function Get_OrderGrid_ChFinancialInstrument()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_OrderGrid_ChExecutedMarket()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marché d'exécution"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Executed Market"], 10)}
}

function Get_OrderGrid_ChOurRole()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Notre rôle"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Our Role"], 10)}
}

function Get_OrderGrid_ChOrderNo()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro de l'ordre"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order No."], 10)}
}

function Get_OrderGrid_ChNextBusinessDay()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prochain jour ouvrable"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Next Business Day"], 10)}
}

function Get_OrderGrid_ChRate()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Taux"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rate"], 10)}
}

function Get_OrderGrid_ChSecurity()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_OrderGrid_ChCodedTrailer()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Notes struct."], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Coded Trailer"], 10)}
}

function Get_OrderGrid_ChSide()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Côté"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Side"], 10)}
}

function Get_OrderGrid_ChAverageFillPrice()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix moyen d'exécution"], 10)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Average fill price"], 10)}
}

//Menu contextuel sur le grid (Contextual menu on the grid)

function Get_OrderGrid_ContextualMenu(){return Get_SubMenus().Find("Uid", "ContextMenu_51ea", 10)}


function Get_OrderGrid_ContextualMenu_CreateABuyOrder(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_3d55", 10)}

function Get_OrderGrid_ContextualMenu_CreateASellOrder(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_3043", 10)}

function Get_OrderGrid_ContextualMenu_Copy(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_4079", 10)}

function Get_OrderGrid_ContextualMenu_CopyWithHeader(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_d485", 10)}

function Get_OrderGrid_ContextualMenu_ExportToFile(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_4fb5", 10)}

function Get_OrderGrid_ContextualMenu_ExportToMSExcel(){return Get_OrderGrid_ContextualMenu().Find("Uid", "CFMenuItem_44a6", 10)}


function Get_OrderGrid_ContextualMenu_Functions(){return Get_OrderGrid_ContextualMenu().Find("Uid", "MenuItem_bc45", 10)}

function Get_OrderGrid_ContextualMenu_Functions_CFO(){return Get_CroesusApp().Find("Uid", "MenuItem_1d83", 10)}

function Get_OrderGrid_ContextualMenu_Functions_View(){return Get_CroesusApp().Find("Uid", "MenuItem_d1b6", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Fills(){return Get_CroesusApp().Find("Uid", "MenuItem_a6ac", 10)}

function Get_OrderGrid_ContextualMenu_Functions_CXL(){return Get_CroesusApp().Find("Uid", "MenuItem_7b7c", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Replace(){return Get_CroesusApp().Find("Uid", "MenuItem_ffbc", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Models(){return Get_CroesusApp().Find("Uid", "CFMenuItem_3dff", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Relationships(){return Get_CroesusApp().Find("Uid", "CFMenuItem_bda4", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Clients(){return Get_CroesusApp().Find("Uid", "CFMenuItem_2d80", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Accounts(){return Get_CroesusApp().Find("Uid", "CFMenuItem_0382", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Portfolio(){return Get_CroesusApp().Find("Uid", "CFMenuItem_b13a", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Transactions(){return Get_CroesusApp().Find("Uid", "CFMenuItem_a9db", 10)}

function Get_OrderGrid_ContextualMenu_Functions_Securities(){return Get_CroesusApp().Find("Uid", "CFMenuItem_ede6", 10)}

function Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(){return Get_CroesusApp().Find("Uid", "MenuItem_abcd", 10)}

function Get_OrderGrid_ContextualMenu_Help()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Aide"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Help"], 10)}
}

function Get_OrderGrid_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_OrderGrid_ContextualMenu_Help_ContentsAndIndex()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}


function Get_OrderGrid_ContextualMenu_Print()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}


//************************************************ ORDER LOG GRID ****************************************************

function Get_OrderLogExpander(){return Aliases.CroesusApp.winMain.OrderEntryControl.OrderLogExpander}

function Get_OrderLogGrid(){return Aliases.CroesusApp.winMain.OrderEntryControl.OrderLogExpander.OrderLogGrid}


//Entêtes de colonne de la grille du log ordres (Order log grid Column headers)

function Get_OrderLogGrid_ChSupplierNo()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du fournisseur"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Supplier No."], 10)}
}

function Get_OrderLogGrid_ChOrderNo()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro de l'ordre"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order No."], 10)}
}

function Get_OrderLogGrid_ChStatus()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_OrderLogGrid_ChUser()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Utilisateur"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "User"], 10)}
}

function Get_OrderLogGrid_ChDate(){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)}

function Get_OrderLogGrid_ChTime()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Heure"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Time"], 10)}
}

function Get_OrderLogGrid_ChMessage(){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10)}

function Get_OrderLogGrid_ChAccountNo()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_OrderLogGrid_ChSecurity()
{
  if (language=="french"){return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_OrderLogGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}



//************************************************ ORDER ACCUMULATOR ****************************************************

function Get_OrderAccumulator(){return Aliases.CroesusApp.winMain.OrderEntryControl.accumulatorExpander}

function Get_OrderAccumulator_BtnVerify(){return Get_OrderAccumulator().FindChild("Uid", "Button_4407", 10)}

function Get_OrderAccumulator_BtnEdit(){return Get_OrderAccumulator().FindChild("Uid", "Button_64dd", 10)}

function Get_OrderAccumulator_BtnMerge(){return Get_OrderAccumulator().FindChild("Uid", "Button_41d9", 10)}

function Get_OrderAccumulator_BtnSplit(){return Get_OrderAccumulator().FindChild("Uid", "Button_8c48", 10)}

function Get_OrderAccumulator_BtnDelete(){return Get_OrderAccumulator().FindChild("Uid", "Button_1c02", 10)}


//Entêtes de colonne de la grille l'accumulateur des ordres (Order accumulator grid Column headers)

function Get_OrderAccumulatorGrid(){return Aliases.CroesusApp.winMain.OrderEntryControl.accumulatorExpander.accumulatorGrid}

function Get_OrderAccumulatorGrid_ChInclude()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inclure"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Include"], 10)}
}

function Get_OrderAccumulatorGrid_ChMessage(){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10)}

function Get_OrderAccumulatorGrid_ChPro(){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10)}

function Get_OrderAccumulatorGrid_ChAccountNo()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_OrderAccumulatorGrid_ChAccountName()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom du compte"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Name"], 10)}
}

function Get_OrderAccumulatorGrid_ChType(){
  //return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type d'ordre"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order Type"], 10)}
}

function Get_OrderAccumulatorGrid_ChSide()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Côté"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Side"], 10)}
}

function Get_OrderAccumulatorGrid_ChQuantity()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_OrderAccumulatorGrid_ChSymbol()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_OrderAccumulatorGrid_ChDescription(){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_OrderAccumulatorGrid_ChPrice()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix de l'ordre"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order price"], 10)}// Avant Prix/Price Story: GDO-769
}

function Get_OrderAccumulatorGrid_ChMarket()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marché"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market"], 10)}
}

function Get_OrderAccumulatorGrid_ChGoodTill()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée de validité"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Good Till"], 10)}//avant : Valable Story-GDO-768
}

function Get_OrderAccumulatorGrid_ChNextBusinessDay()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prochain jour ouvrable"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Next Business Day"], 10)}
}

function Get_OrderAccumulatorGrid_ChIACode()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_OrderAccumulatorGrid_ChSupplierNo()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du fournisseur"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Supplier No."], 10)}
}

function Get_OrderAccumulatorGrid_ChSource(){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)}

function Get_OrderAccumulatorGrid_ChLastModification()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière modification"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Modification"], 10)}
}

function Get_OrderAccumulatorGrid_ChOrderNo()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro de l'ordre"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order No."], 10)}
}

function Get_OrderAccumulatorGrid_ChCreatedBy()
{
  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé par"], 10)}
  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created By"], 10)}
}


function Get_OrderAccumulator_ContextualMenu_Copy()
{
  if (language == "french"){return Get_OrderAccumulator_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Co_pier"], 10)}
  else {return Get_OrderAccumulator_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Copy"], 10)}
}

function Get_OrderAccumulator_SubMenus(){return Aliases.CroesusApp.subMenus.WPFObject("ContextMenu", "", 1)}

function Get_WinQuickFilterEdition(){            return Get_CroesusApp().FindChild("Uid", "QuickFilterEditionWindow_d935", 10)}

function Get_WinQuickFilterEdition_TxtName(){    return Get_WinQuickFilterEdition().FindChild("Uid", "LocaleTextbox_fe73", 10)}

function Get_WinQuickFilterEdition_CmbField(){   return Get_WinQuickFilterEdition().FindChild("Uid", "ComboBox_f9c9", 10)}

function Get_WinQuickFilterEdition_LblOperator(){return Get_WinQuickFilterEdition().FindChild("Uid", "ComboBox_b9ca", 10)}

function Get_WinQuickFilterEdition_BtnOK(){      return Get_WinQuickFilterEdition().FindChild("Uid", "Button_ed99", 10)}

function Get_WinQuickFilterEdition_CmbAccess(){  return Get_WinQuickFilterEdition().FindChild("Uid", "PartyLevelComboBox_92f6", 10)}

function Get_OrderAccumulatorGrid_ToggleButtn(i){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", i], 10)}


//********************* SPLIT BLOCK () ****************************************************

function Get_WinSplitBlock(){return Aliases.CroesusApp.WinSplitBlock}

function Get_WinSplitBlock_DgvAccounts(){return Get_WinSplitBlock().FindChild("Uid", "DataGrid_0628", 10)}

function Get_WinSplitBlock_BtnCreateBlock(){return Get_WinSplitBlock().FindChild("Uid", "Button_ba6d", 10)}

function Get_WinSplitCancel(){return Get_WinSplitBlock().FindChild("Uid", "Button_5d69", 10)}



//********************* ORDERS SUM (ORDRES - SOMMATION) ***********************************

function Get_WinOrdersSum(){return Aliases.CroesusApp.winOrdersSum}

function Get_WinOrdersSum_BtnClose(){return Get_WinOrdersSum().FindChild("Uid", "Button_4df6", 10)}

function Get_WinOrdersSum_ChFinancialInstrument(){return Get_WinOrdersSum().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_WinOrdersSum_ChNumberOfTransactions()
{
  if (language=="french"){return Get_WinOrdersSum().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nombre de transactions"], 10)}
  else {return Get_WinOrdersSum().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number of Transactions"], 10)}
}


//********************* ORDERS QUICK SEARCH (ORDRES - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinOrdersQuickSearch_RdoAccountNo()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "AccountNumber - No de compte"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "AccountNumber - Account No."], 10)}
}

function Get_WinOrdersQuickSearch_RdoAlternativeOrderNo()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "AlterOrderNumber - No ordre de rechange"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "AlterOrderNumber - Alternative Order No."], 10)}
}

function Get_WinOrdersQuickSearch_RdoIACode()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - Code de CP"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - IA Code"], 10)}
}

function Get_WinOrdersQuickSearch_RdoMarket()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ExchangeName - Marché"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ExchangeName - Market"], 10)}
}

function Get_WinOrdersQuickSearch_RdoSupplierNo()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "WireNumber - No du fournisseur"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "WireNumber - Supplier No."], 10)}
}

function Get_WinOrdersQuickSearch_RdoSymbol()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "OrderSymbol - Symbole"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "OrderSymbol - Symbol"], 10)}
}



//************************************************ ORDERS FILLS (ORDRES - EXECUTIONS) ************************************************

function Get_WinOrderFills(){return Aliases.CroesusApp.winOrderFills}

function Get_WinOrderFills_BtnSave(){return Get_WinOrderFills().FindChild("Uid", "Button_dd13", 10)}

function Get_WinOrderFills_BtnCancel(){return Get_WinOrderFills().FindChild("Uid", "Button_9ef1", 10)}


function Get_WinOrderFills_GrpBuyOrSellOrder(){return Get_WinOrderFills().FindChild("Uid", "GroupBox_9112", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblSymbol(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_9aeb", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtSymbol(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_03ae", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblOrderNumber(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_4bfb", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtOrderNumber(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_eb5b", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblInitialQuantity(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_f691", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtInitialQuantity(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_7e6d", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblIACode(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_c63a", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtIACode(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_d6a6", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblPreviouslyExec(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_f442", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtPreviouslyExec(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_daa3", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblExpiration(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_8355", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtExpiration(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_57de", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblExecToday(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_4ac3", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtExecToday(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_0754", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblTodaysAvgPrice(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_be02", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtTodaysAvgPrice(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "DoubleTextBox_75fd", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblStatus(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_b3b4", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtStatus(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_ef4c", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_LblRemainingQuantity(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "TextBlock_ac0e", 10)}

function Get_WinOrderFills_GrpBuyOrSellOrder_TxtRemainingQuantity(){return Get_WinOrderFills_GrpBuyOrSellOrder().FindChild("Uid", "CustomTextBox_2acc", 10)}


function Get_WinOrderFills_GrpFills(){return Get_WinOrderFills().FindChild("Uid", "GroupBox_7b24", 10)}

function Get_WinOrderFills_GrpFills_LblDate(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_c19d", 10)}

function Get_WinOrderFills_GrpFills_CmbDate(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "ComboBox_af4f", 10)}

function Get_WinOrderFills_GrpFills_BtnAdd(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "Button_fbac", 10)}

function Get_WinOrderFills_GrpFills_BtnModify(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "Button_54d2", 10)}

function Get_WinOrderFills_GrpFills_BtnDelete(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "Button_7ca6", 10)}


function Get_WinOrderFills_GrpFills_LblRateOriginForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_f966", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_CmbRateOriginForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "UniComboBox_e17f", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblCodedTrailerForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_b7fc", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_TxtDefaultCodedTrailerForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_7816", 10)} //Dash (Tiret) // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_TxtCodedTrailerForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_aded", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblExchangeRateForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_07c7", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_TxtExchangeRateForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "DoubleTextBox_28af", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_adc1", 10)} //Example : $CAD / 1 $USD // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblAdditionalNoteForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_bd40", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_TxtAdditionalNoteForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_eabd", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblTotalToConvertForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_d87b", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_TxtTotalToConvertForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_058c", 10)} // Pour le type d'instrument financier Action

function Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForEquity(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_25be", 10)} //Example : USD$ to convert to CAD$ // Pour le type d'instrument financier Action


function Get_WinOrderFills_GrpFills_LblAdditionalNoteForStock(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_6902", 10)}

function Get_WinOrderFills_GrpFills_TxtAdditionalNoteForStock(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_adc9", 10)}

function Get_WinOrderFills_GrpFills_LblCodedTrailerForStock(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_18a1", 10)}

function Get_WinOrderFills_GrpFills_TxtCodedTrailer1ForStock(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_4d69", 10)}

function Get_WinOrderFills_GrpFills_TxtCodedTrailer2ForStock(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_e0f6", 10)}


function Get_WinOrderFills_GrpFills_LblRateOriginForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_cc7c", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_CmbRateOriginForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "UniComboBox_4614", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_CmbRateOriginForBond_ChNegociatedRate(){return Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 2)};

function Get_WinOrderFills_GrpFills_LblExchangeRateForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_5230", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_LblInternalNumberForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_f462", 10)}

function Get_WinOrderDetail_TabExchangeRate_GrpRate_LblInternalNumber(){return Get_WinOrderDetail_GrpRate().FindChild("Uid", "CustomTextBox_f462", 10)}	

function Get_WinOrderFills_GrpFills_TxtExchangeRateForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "DoubleTextBox_142c", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderDetail_TabExchangeRate_GrpRate_TxtExchangeRate(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_142c", 10)}

function Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_c842", 10)} //Example : $CAD / 1 $USD // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_LblAdditionalNoteForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_1d8b", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_TxtAdditionalNoteForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_286b", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_LblTotalToConvertForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_bcd0", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_TxtTotalToConvertForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "CustomTextBox_5cec", 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderDetail_TabExchangeRate_GrpRate_TxtTotalToConvert(){return Get_WinOrderDetail_GrpRate().FindChild("Uid", "CustomTextBox_5cec", 10)}

function Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForBond(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "TextBlock_b297", 10)} //Example : USD$ to convert to CAD$ // Pour le type d'instrument financier Obligation


function Get_WinOrderFills_GrpFills_DgvFills(){return Get_WinOrderFills_GrpFills().FindChild("Uid", "DataGrid_fb8a", 10)}

function Get_WinOrderFills_GrpFills_DgvFills_ChStatus()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChExecutionDate()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date d'exécution"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Execution Date"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChSettlementDate()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de règlement"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Settlement Date"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChQuantity()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChSymbol()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChTotal(){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total"], 10)}

function Get_WinOrderFills_GrpFills_DgvFills_ChMarket()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bourse"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChOurRole()
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Notre rôle"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Our role"], 10)}
}


function Get_WinOrderFills_GrpFills_DgvFills_ChPriceForEquity() // Pour le type d'instrument financier Action
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix d'exécution"], 10)} //Avant: Prix/Price 
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fill price"], 10)}//Story GDO769
}


function Get_WinOrderFills_GrpFills_DgvFills_ChIAPriceForBond() // Pour le type d'instrument financier Obligation
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix CP"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Price"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChClientPriceForBond() // Pour le type d'instrument financier Obligation
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix client"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client Price"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChANNPercentForBond(){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "ANN %"], 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_DgvFills_ChSAPercentForBond(){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "S/A %"], 10)} // Pour le type d'instrument financier Obligation

function Get_WinOrderFills_GrpFills_DgvFills_ChIndexationFactorForBond() // Pour le type d'instrument financier Obligation
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Coefficient d'indexation"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Indexation Factor"], 10)}
}

function Get_WinOrderFills_GrpFills_DgvFills_ChInventoryCodeForBond() // Pour le type d'instrument financier Obligation
{
  if (language=="french"){return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code d'inventaire"], 10)}
  else {return Get_WinOrderFills_GrpFills_DgvFills().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inventory Code"], 10)}
}


function Get_WinOrderFills_GrpAllocationExpander(){return Get_WinOrderFills().FindChild("Uid", "Expander_82df", 10)}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts(){return Get_WinOrderFills_GrpAllocationExpander().FindChild("Uid", "DataGrid_0628", 10)}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPro(){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10)}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChName()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChIACode()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChCurrency()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du compte"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Devise"
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Currency"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Currency"
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChRequestedQuantity()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité requise"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Requested Quantity"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChQuantityAllocatedToday()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité attribuée auj."], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity Allocated Today"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPreviouslyAllocatedQuantity()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité précédemment attribuée"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Previously Allocated Quantity"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChTodaysTotalValue()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale du jour"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Today's Total Value"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAveragePrice()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix moyen"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Average Price"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChSymbol()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChTodaysTotalValueNotConverted()
{
  if (language=="french"){return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale du jour (non convertie)"], 10)}
  else {return Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Today's Total Value (not converted)"], 10)}
}


//************************************************ La fenêtre ajouter une exécution  (Add Order) ************************************************

function Get_WinAddOrderFill(){return Aliases.CroesusApp.WinFill}

function Get_WinAddOrderFill_TxtQuantity(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_b3a2", 10)}

function Get_WinAddOrderFill_TxtClientPrice(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_cd1f", 10)}

function Get_WinAddOrderFill_TxtIAPrice(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_52c9", 10)}

function Get_WinAddOrderFill_TxtIndexationFactor(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_968b", 10)}

function Get_WinAddOrderFill_TxtYieldANN(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_a5a6", 10)}

function Get_WinAddOrderFill_TxtYieldSA(){return Get_WinAddOrderFill().FindChild("Uid", "DoubleTextBox_6510", 10)}

function Get_WinAddOrderFill_CmbInvetoryCode(){return Get_WinAddOrderFill().FindChild("Uid", "UniComboBox_6da6", 10)}

function Get_WinAddOrderFill_CmbInvetoryCode_ChCode(){return Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 1)};

function Get_WinAddOrderFill_CmbMarket(){return Get_WinAddOrderFill().FindChild("Uid", "UniComboBox_1d55", 10)}

function Get_WinAddOrderFill_CmbMarket_ChBource(){return Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 1)};

function Get_WinAddOrderFill_CmbOurRole(){return Get_WinAddOrderFill().FindChild("Uid", "UniComboBox_b204", 10)}

function Get_WinAddOrderFill_CmbOurRole_ChAgent(){return Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 1)};

function Get_WinAddOrderFill_BtnOK(){return Get_WinAddOrderFill().FindChild("Uid", "Button_c4bd", 10)}

function Get_WinAddOrderFill_BtnCancel(){return Get_WinAddOrderFill().FindChild("Uid", "Button_8d1c", 10)}

function Get_WinAddOrderFill_TxtExecutionDate(){return Get_WinAddOrderFill().FindChild("Uid", "DateField_f53a", 10)};

function Get_WinAddOrderFill_TxtSettlementDate(){return Get_WinAddOrderFill().FindChild("Uid", "DateField_8398", 10)};


//****************************************La fenêtre Accumulateur (la fenêtre s’ouvre après avoir clique sur le btn  Vérifier)*********************** 

function Get_WinAccumulator(){return Aliases.CroesusApp.winAccumulator}

function Get_WinAccumulator_DgvAccumulator(){return Get_WinAccumulator().FindChild("Uid", "DataGrid_66bd", 10)}

function Get_WinAccumulator_BtnSubmit(){return Get_WinAccumulator().FindChild("Uid", "Button_6d36", 10)}

function Get_WinAccumulator_BtnCancel(){return Get_WinAccumulator().FindChild("Uid", "Button_41fe", 10)}

function Get_WinAccumulator_LstMessages(){return Get_WinAccumulator().FindChild("Uid", "ListBox_e57d", 10)}//ok

//*************************************************************************************************

 function Get_GridHeader_ContextualMenu_AddColumn_Pro(){
        return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: AccountProStatus"], 10)}
        
 function  Get_SubMenus_ExportToExcel(){
      if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers MS Excel..."], 10)}
      else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to _MS Excel..."], 10)}}
      
 //***************************Fenêtre Ajout filtre**********************************************//
 
 //Bouton OK de la fenêtre ajouter un filtre des modules ordre et titre
function  Get_WinCRUFilter_BtnOK_ForSecuritiesAndOrders(){return Get_WinCRUFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}


//Liste deroulante du champ (Field)de  fenêtre ajouter un filtre des modules ordre et titre
function  Get_WinCRUFilter_GrpCondition_CmbField_ForSecuritiesAndOrders(){return Get_WinCRUFilter_GrpCondition_ForSecuritiesAndOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}


//Liste deroulante de Champ Operateur(Operator)de la fenêtre ajouter un filtre des modules ordre et titre
function  Get_WinCRUFilter_GrpCondition_CmbOperator_ForSecuritiesAndOrders(){return Get_WinCRUFilter_GrpCondition_ForSecuritiesAndOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 10)}

function  Get_WinCRUFilter_GrpCondition_CmbValue_ForSecuritiesAndOrders(){return Get_WinCRUFilter_GrpCondition_ForSecuritiesAndOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 10)}

//Fonction pour acceder à la grille condition de la fenetre ajouter un filtre dues modules ordres et titres
function  Get_WinCRUFilter_GrpCondition_ForSecuritiesAndOrders(){return Get_WinCRUFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Condition"], 10)}  


//function Get_WinCRUFilter(){return Aliases.CroesusApp.winAddFilterForRelationshipsClientsAccounts}// fonctionne pour les modules comptes clients et relations
function Get_WinCRUFilter(){return Aliases.CroesusApp.winAddFilter};// 06/02/2020 fonctionne pour tous les modules y compris titres et ordres 


//fonction qui permets d acceder au champ nom(Name)de la fenetre ajouter un filtre dues modules ordres et titres 
function  Get_WinCRUFilter_TextName_ForOrdersAndSecurities(){return Get_WinCRUFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}


//Fonction qui permets de selectionner dans la liste deroulante Champ(Field) la valeur "Côté"
function Get_WinCRUFilter_CmbField_ItemSide_ForOrdersAndSecurities()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Côté"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Side"], 10)}
}

//Fonction qui permets de selectionner dans la liste deroulante Champ(Field) la valeur "Side"
function Get_WinCRUFilter_CmbOperator_ItemEquals_ForOrdersAndSecurities()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "égale"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "equals"], 10)}
}
//Filtre par position
function Get_OrderAccumulatorGrid_BtnFilter(WPFControlOrdinalNo){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}

function Get_OrderAccumulatorGrid_BtnFilter_BtnRemove(WPFControlOrdinalNo){return Get_OrderAccumulatorGrid_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrFullClassName", "WPFControlOrdinalNo", "IsVisible"], ["System.Windows.Controls.Button", 2, true], 10)}

