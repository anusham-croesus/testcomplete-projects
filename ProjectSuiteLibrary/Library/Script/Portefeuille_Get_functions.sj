//USEUNIT Common_Get_functions


//************************** PORTFOLIO GRID **************************************

function Get_PortfolioPlugin(){return Aliases.CroesusApp.winMain.PortfolioPlugin}

function Get_Portfolio_PositionsGrid(){return Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").WPFObject("MainWindow").WPFObject("contentContainer").WPFObject("tabControl").WPFObject("portfolioPluginWindow").WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1)}

function Get_Portfolio_ProjectedAnnualIncomeGrid(){return Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").WPFObject("MainWindow").WPFObject("contentContainer").WPFObject("tabControl").WPFObject("portfolioPluginWindow").WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("projectedAnnualIncomeGrid").WPFObject("RecordListControl", "", 1)}

function Get_Portfolio_Tab(Index){return Get_PortfolioPlugin().Find(["ClrClassName", "WPFControlOrdinalNo"], ["PortfolioTabItem", Index], 10)}

function Get_Portfolio_AssetClassesGrid(){return Get_PortfolioPlugin().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_67cd","true"], 10)}

function Get_Portfolio_ComparisonGrid(){return Get_PortfolioPlugin().FindChild("Uid", "ComparisonDataGrid_c0b7", 10)}

function Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement(){return Get_Portfolio_ComparisonGrid().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 10)}

function Get_Portfolio_ProjLiquiditesGrid(){return Get_PortfolioPlugin().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_e480","true"], 10)}

function Get_Portfolio_PerSleeveGrid() {return Get_PortfolioPlugin().FindChild("Uid", "DataGrid_67cd", 10)}

//Contenu grid

function Get_Portfolio_Grid_VisibleLines()
{
  var array = Get_Portfolio_PositionsGrid().FindAllChildren("ClrClassName", "DataRecordPresenter").toArray().sort(function(a, b){return (a.visible ? a.ScreenTop : -1000) - (b.visible ? b.ScreenTop : -1000)});
  while (array.length > 0 && !array[0].visible) array.shift();
  return array;
}

function Get_Portfolio_AssetClassGrid_VisibleLines()
{
  var array = Get_Portfolio_AssetClassesGrid().FindAllChildren("ClrClassName", "DataRecordPresenter", 10).toArray().sort(function(a, b){return (a.visible ? a.ScreenTop : -1000) - (b.visible ? b.ScreenTop : -1000)});
  while (array.length > 0 && !array[0].visible) array.shift();
  return array;
}

function Get_Portfolio_PositionsGrid_Column(header)
{
  return Get_Portfolio_ProjLiquiditesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", header], 10)
}

function Get_Portfolio_Grid_LineContent(DataRecordPresenter){return DataRecordPresenter.FindAllChildren("ClrClassName", "CellValuePresenter", 10).toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}

function Get_Portfolio_Grid_Summary(){return Get_Portfolio_PositionsGrid().findChild("ClrClassName", "SummaryRecordPresenter", 15).findAllChildren("ClrClassName", "SummaryResultPresenter", 15).toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}

//PREF_POSITION_LEVEL_PERFORMANCE=2
function Get_Portfolio_Grid_Summary_PerfPerAssetClass(){return Get_Portfolio_AssetClassesGrid().findChild("ClrClassName", "SummaryRecordPresenter", 15).findAllChildren("ClrClassName", "SummaryResultPresenter", 15).toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}


//Entêtes de colonne de la grille des positions (Position grid Column headers)

function Get_Portfolio_PositionsGrid_ColumnList(){return Get_Portfolio_PositionsGrid_ChDescription().parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}

function Get_Portfolio_PositionsGrid_ChAccountNo()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_Portfolio_PositionsGrid_ChIACode()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_Portfolio_PositionsGrid_ChName()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_Portfolio_PositionsGrid_ChType(){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_Portfolio_PositionsGrid_ChQuantity()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_Portfolio_PositionsGrid_ChDescription(){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Portfolio_PositionsGrid_ChSymbol()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_Portfolio_PositionsGrid_ChAssetAllocation()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rép. d'actifs"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Asset Allocation"], 10)}
}

function Get_Portfolio_PositionsGrid_ChACB()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "PBR"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "ACB"], 10)}
}
// ajout de la fonction get pour Unit Cost pour la US 90-04-49
function Get_Portfolio_PositionsGrid_ChUnitCost()
{
  if (language=="french"){Log.Warning("Le nom du champ Unit cost n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unit Cost"], 10)}
}
// ajout de la fonction get pour Cost Basis pour la US 90-04-49
function Get_Portfolio_PositionsGrid_ChCostBasis()
{
  if (language=="french"){Log.Warning("Le nom du champ Cost Basis n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cost Basis"], 10)}
} 
// Ajout de fonction get pour Market value indicator
function Get_Portfolio_PositionsGrid_ChMarketValueIndicator()
{
  if (language=="french"){Log.Warning("Le nom du champ Market value indicator n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV Ind."], 10)}
} 
function Get_Portfolio_PositionsGrid_ChMarketPrice()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price"], 10)}
}

function Get_Portfolio_PositionsGrid_ChBookValue()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur comptable"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Book Value"], 10)}
}

function Get_Portfolio_PositionsGrid_ChMarketValue()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)}
}

function Get_Portfolio_PositionsGrid_ChMVPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChGainsLosses()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gains/Pertes"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gains/Losses"], 10)}
}

function Get_Portfolio_PositionsGrid_ChGLPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/L (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChCostYieldPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rend. à l'achat (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cost Yield (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChMYPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RM (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MY (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChCCYPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RAC (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CCY (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChYTMCostPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rend. éché. - Coût (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "YTM - Cost (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChYTMMarketPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rend. éché. - Marché (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "YTM - Market (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChYTDPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RAJ (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "YTD (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChModDuration()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée mod."], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mod. Duration"], 10)}
}

function Get_Portfolio_PositionsGrid_ChAccruedID()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D"], 10)}
}

function Get_Portfolio_PositionsGrid_ChAnnInc()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_Portfolio_PositionsGrid_ChLockedPosition()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Position bloquée"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Locked Position"], 10)}
}
// ajout de la fonction get pour Non-redeemable suite a l'exécution de 90-04-49
function Get_Portfolio_PositionsGrid_ChNonRedeemable()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non rachetable"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Non-redeemable"], 10)}
}

function Get_Portfolio_PositionsGrid_ChExcludeFromBilling()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclure de la facturation"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclude from billing"], 10)}
}

function Get_Portfolio_PositionsGrid_ChBid()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Acheteur"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bid"], 10)}
}

function Get_Portfolio_PositionsGrid_ChBeta()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bêta"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Beta"], 10)}
}

function Get_Portfolio_PositionsGrid_ChInvestedCapital()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital investi"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invested Capital"], 10)}
}

function Get_Portfolio_PositionsGrid_ChBasicCategories()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Catégories de base"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Basic Categories"], 10)}
}

function Get_Portfolio_PositionsGrid_ChClose()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Clôture"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Close"], 10)}
}

function Get_Portfolio_PositionsGrid_ChCUSIP(){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CUSIP"], 10)}

function Get_Portfolio_PositionsGrid_ChLastBuy()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernier achat"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Buy"], 10)}
}

function Get_Portfolio_PositionsGrid_ChSecurityCurrency()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du titre"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security Currency"], 10)}
}

function Get_Portfolio_PositionsGrid_ChPriceCurrency()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du prix"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price Currency"], 10)}
}

function Get_Portfolio_PositionsGrid_ChDividend()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_Portfolio_PositionsGrid_ChMaturity()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échéance"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Maturity"], 10)}
}

function Get_Portfolio_PositionsGrid_ChExcludeFromProjectedIncome()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclure de la projection de liquidités"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exclude from Projected Income"], 10)}
}

function Get_Portfolio_PositionsGrid_ChFrequency()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_Portfolio_PositionsGrid_ChInvestCapGL()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P cap. investi"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cap. G/L"], 10)}
}

function Get_Portfolio_PositionsGrid_ChInvestCapGLPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P cap. investi (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cap. G/L (%)"], 10)}
}

function Get_Portfolio_PositionsGrid_ChFinancialInstrument()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Instrument financier"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Financial Instrument"], 10)}
}

function Get_Portfolio_PositionsGrid_ChInterest()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Intérêts"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest"], 10)}
}

function Get_Portfolio_PositionsGrid_ChInvestCost()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. unitaire"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cost"], 10)}
}

function Get_Portfolio_PositionsGrid_ChClientNo()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

function Get_Portfolio_PositionsGrid_ChInterestPortion()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Portion d'intéret"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interest Portion"], 10)}
}

function Get_Portfolio_PositionsGrid_ChRegion()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Région"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Region"], 10)}
}

function Get_Portfolio_PositionsGrid_ChSector()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Secteur"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sector"], 10)}
}

function Get_Portfolio_PositionsGrid_ChSubcategory()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sous-catégorie"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Subcategory"], 10)}
}

function Get_Portfolio_PositionsGrid_ChTelephone1()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_Portfolio_PositionsGrid_ChTelephone2()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 2"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 2"], 10)}
}

function Get_Portfolio_PositionsGrid_ChSecurity()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_Portfolio_PositionsGrid_ChAsk()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Vendeur"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ask"], 10)}
}

function Get_Portfolio_PositionsGrid_ChRiskRating() //Disponible pour FBN
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cote de risque"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Risk Rating"], 10)}
}

//Seulement disponible pour les simulations (only available for what-if)
function Get_Portfolio_PositionsGrid_ChQtyVariation()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écart des quantités"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty Variation"], 10)}
}

//Seulement disponible pour les simulations (only available for what-if)
function Get_Portfolio_PositionsGrid_ChVariationPercent()
{
  if (language=="french"){return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Écart (%)"], 10)}
  else {return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Variation (%)"], 10)}
}



//Entêtes de colonne de la grille de la projection de liquidités (Cash Flow Projection grid Column headers)

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChDescription(){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChDay()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Jour"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Day"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChJanuary()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Janv. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Jan. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChFebruary()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Févr. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Feb. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChMarch()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mars ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "March ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChApril()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Avr. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Apr. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChMay()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mai ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "May ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChJune()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Juin ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "June ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChJuly()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Juill. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Jul. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChAugust()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Août ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Aug. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChSeptember()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sept. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sep. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChOctober(){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Oct. ??"], 10)}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChNovember(){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nov. ??"], 10)}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChDecember()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Déc. ??"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dec. ??"], 10)}
}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChTotal(){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total"], 10)}

function Get_Portfolio_ProjectedAnnualIncomeGrid_ChMatured()
{
  if (language=="french"){return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Échue"], 10)}
  else {return Get_Portfolio_ProjectedAnnualIncomeGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Matured"], 10)}
}


//Entêtes de colonne de la grille des classes d'actif (asset class Column headers)

function Get_Portfolio_AssetClassesGrid_ColumnList(){return Get_Portfolio_AssetClassesGrid_ChDescription().parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}

function Get_Portfolio_AssetClassesGrid_AssetGroup_ColumnList()
{
  var column;
  if (language=="french")column = Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10);
  else column = Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10);
  return column.parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft});
}

function Get_Portfolio_AssetClassesGrid_ChDescription(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Portfolio_AssetClassesGrid_ChNoPositions()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de positions"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Positions"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChInvestedCapital()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Capital investi"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invested Capital"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChDividend()
{
   if (language=="french") {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividende"], 10)}
   else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dividend"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChMarketValue()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur de marché"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market value"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChMV()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%)"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%)"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChInvestCap()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P cap. investi"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Invest. Cap. G/L"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChAccruedID()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChAnnInc()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rev. ann."], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Ann. Inc."], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChBookValue()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur comptable"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Book value"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChGLBookValue()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "D/P valeur comptable"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/L Book Value"], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChMinObj()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. min."], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Min. Obj."], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChMaxObj()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. max."], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Max. Obj."], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChTargetObj()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Obj. cible"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target Obj."], 10)}
}

function Get_Portfolio_AssetClassesGrid_ChTarget()
{
  if (language=="french"){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cible"], 10)}
  else {return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Target"], 10)}
}


//Entêtes de colonne de la grille de la comparaison (Comparison grid Column headers)

function Get_Portfolio_ComparisonGrid_ChDescription(){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Portfolio_ComparisonGrid_ChSymbol()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChDiff(){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Diff."], 10)}

function Get_Portfolio_ComparisonGrid_ChInitQty()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté init."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Qty"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChFinalQty()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Qty"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChQtyDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_ChInitMarketPrice()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché init."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Market Price"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChFinalMarketPrice()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Market Price"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChMarketPriceDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_ChInitMVPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) init."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. MV (%)"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChFinalMVPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final MV (%)"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChMVDiffPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%) - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_ChInitMVCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) init."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. MV ($)"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChFinalMVCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final MV ($)"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChMVDiffCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV ($) - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_ChInitAccruedID()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus init."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Accrued I/D"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChFinalAccruedID()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Accrued I/D"], 10)}
}

function Get_Portfolio_ComparisonGrid_ChAccruedIDDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_ChRealizedGL()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés"], 10)}
  else {return Get_Portfolio_ComparisonGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L"], 10)}
}

//Entêtes de colonne de la grille déroulé de la comparaison par class d'actif (Comparison grid by asset class expanded element Column headers)

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChDescription(){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChSymbol()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChDiff(){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Diff."], 10)}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChInitQty()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté init."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Qty"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChFinalQty()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Qty"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChQtyDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qté - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChInitMarketPrice()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché init."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Market Price"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChFinalMarketPrice()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Market Price"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChMarketPriceDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix au marché - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChInitMVPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) init."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. MV (%)"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChFinalMVPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final MV (%)"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChMVDiffPercent()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM (%) - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV (%) - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChInitMVCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) init."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. MV ($)"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChFinalMVCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final MV ($)"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChMVDiffCash()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "VM ($) - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MV ($) - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChInitAccruedID()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus init."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Init. Accrued I/D"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChFinalAccruedID()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus fin."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Final Accrued I/D"], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChAccruedIDDiff()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "I/D courus - Diff."], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accrued I/D - Diff."], 10)}
}

function Get_Portfolio_ComparisonGrid_AssetClassExpandedElement_ChRealizedGL()
{
  if (language=="french"){return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/P réalisés"], 10)}
  else {return Get_Portfolio_ComparisonGrid_AssetClass_ExpandedElement().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Realized G/L"], 10)}
}


//Menu contextuel sur le grid (Contextual menu on the grid)

function Get_PortfolioGrid_ContextualMenu(){return Get_SubMenus().Find("Uid", "ContextMenu_90ed", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Buy(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_2425", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Edit(){return Get_PortfolioGrid_ContextualMenu().Find(["Uid","WPFControlText"], ["CFMenuItem_9938","_Edit..."], 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Detail(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_fd7f", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Add(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_9938", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Delete(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_c774", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Copy(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_f387", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_CopyWithHeader(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_891d", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ExportToFile(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_4e41", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ExportToMSExcel(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_fa74", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_CloseCurrentTab(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_9f1f", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Info(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "CFMenuItem_1ba5", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_AddANote(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_0273", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_OrderEntryModule(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_5074", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_OrderEntryModule_CreateABuyOrder(){return Get_CroesusApp().Find("Uid", "CFMenuItem_de30", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_OrderEntryModule_CreateASellOrder(){return Get_CroesusApp().Find("Uid", "CFMenuItem_d8d1", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_OrderEntryModule_Switch(){return Get_CroesusApp().Find("Uid", "CFMenuItem_b27a", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_7fac", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_ExcludeFromProjectedIncome(){return Get_CroesusApp().Find("Uid", "MenuItem_01b8", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_IncludeInProjectedIncome(){return Get_CroesusApp().Find("Uid", "MenuItem_a67d", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_ManageLockedPositions(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_a1f0", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition(){return Get_CroesusApp().Find("Uid", "MenuItem_8785", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition(){return Get_CroesusApp().Find("Uid", "MenuItem_ade4", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_Billing(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_17", 10)} //submenu Billing is missing in Automation 8

function Get_PortfolioGrid_ContextualMenu_Billing_IncludeInBilling(){return Get_CroesusApp().Find("Uid", "MenuItem_18", 10)} //submenu Billing is missing in Automation 8

function Get_PortfolioGrid_ContextualMenu_Billing_ExcludeFromBilling(){return Get_CroesusApp().Find("Uid", "MenuItem_19", 10)} //submenu Billing is missing in Automation 8


function Get_PortfolioGrid_ContextualMenu_SortBy(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_8491", 10)} //ok
//function  get pour Create sleeves
function Get_PortfolioGrid_ContextualMenu_CreateSleeves(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_f067", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_SortBy_Category() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Catégorie"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Category"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_SortBy_MaturityIndustry() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Éch./sect. activité"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Mat./Industry"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_SortBy_MarketValue() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Valeur au marché"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Market Value"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_SortBy_Description(){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Description"], 10)} //no uid


function Get_PortfolioGrid_ContextualMenu_Functions(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_c71c", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().Find("Uid", "MenuItem_6a14", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_TotalValue(){return Get_CroesusApp().Find("Uid", "MenuItem_99fd", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_TradeDateBalance(){return Get_CroesusApp().Find("Uid", "MenuItem_47b7", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_CashFlowProject(){return Get_CroesusApp().Find("Uid", "MenuItem_ef40", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_All(){return Get_CroesusApp().Find("Uid", "MenuItem_356f", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_WhatIf(){return Get_CroesusApp().Find("Uid", "MenuItem_8911", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Compare(){return Get_CroesusApp().Find("Uid", "MenuItem_28", 10)} //Compare is missing in Automation 8

function Get_PortfolioGrid_ContextualMenu_Functions_Save(){return Get_CroesusApp().Find("Uid", "MenuItem_e0df", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Cancel(){return Get_CroesusApp().Find("Uid", "MenuItem_5248", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_GroupBySecurity(){return Get_CroesusApp().Find("Uid", "MenuItem_950f", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_GroupByAssetClass(){return Get_CroesusApp().Find("Uid", "MenuItem_00f4", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_GroupByBasket(){return Get_CroesusApp().Find("Uid", "MenuItem_5304", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_ShowAssetClassRelativePercentage(){return Get_CroesusApp().Find("Uid", "MenuItem_5479", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Models(){return Get_CroesusApp().Find("Uid", "CFMenuItem_4b1c", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Relationships(){return Get_CroesusApp().Find("Uid", "CFMenuItem_6501", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Clients(){return Get_CroesusApp().Find("Uid", "CFMenuItem_91c5", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Accounts(){return Get_CroesusApp().Find("Uid", "CFMenuItem_64b5", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Transactions(){return Get_CroesusApp().Find("Uid", "CFMenuItem_0123", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_Securities(){return Get_CroesusApp().Find("Uid", "CFMenuItem_07fa", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_Functions_ButtonBar(){return Get_CroesusApp().Find("Uid", "MenuItem_e7ad", 10)} //ok


function Get_PortfolioGrid_ContextualMenu_GroupBy(){return Get_PortfolioGrid_ContextualMenu().Find("Uid", "MenuItem_09bd", 10)} //ok

function Get_PortfolioGrid_ContextualMenu_GroupBy_Basic() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "De base"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Basic"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_Firm() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "De la firme"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Firm"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_Currency() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Devise"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Currency"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_ModifiedDuration() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Durée modifiée"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Modified Duration"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_FinancialInstrument() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Instrument Financier"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Financial Instrument"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_Region() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Région"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Region"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_AllocationMaturity() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Répartition - Échéances"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Allocation - Maturity"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_BasicSet() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Ensemble de base (Secteur)"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Basic Set (Sector)"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_GroupBy_FirmSet() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Ensemble de la firme (Secteur)"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Firm Set (Sector)"], 10)}
}


function Get_PortfolioGrid_ContextualMenu_Help() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Aide"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Help"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_Help_ContextSensitiveHelp() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_PortfolioGrid_ContextualMenu_Help_ContentsAndIndex() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}


function Get_PortfolioGrid_ContextualMenu_Print() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}


//Menu contextuel sur le grid en mode comparaison (Contextual menu on the grid in comparison mode)

function Get_PortfolioGrid_Comparison_ContextualMenu_Edit() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "_Modifier..."], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "_Edit..."], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Display() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Consulter"], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Display"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Copy() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Co_pier"], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "_Copy"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_CopyWithHeader() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Cop_ier avec en-tête"], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Copy with _Header"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_ExportToFile() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers fichier..."], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to File..."], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_ExportToMSExcel() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers MS Excel..."], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to _MS Excel..."], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Info(){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Inf_o..."], 10)} //no uid

function Get_PortfolioGrid_Comparison_ContextualMenu_Help() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Help_ContextSensitiveHelp() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Help_ContentsAndIndex() //no uid
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}

function Get_PortfolioGrid_Comparison_ContextualMenu_Print() //no uid
{
  if (language=="french"){return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}


//************************* GRILLE DES CLASSES D'ACTIFS (ASSET CLASSES GRID) ********************************

function Get_Portfolio_AssetClassesGrid_DgvCashAndCashEquivalents(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvMediumTerm(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvLongTerm(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvOtherFixedIncome(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 4], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvCanadianEquity(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 5], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvAmericanEquity(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 6], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvForeignEquity(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 7], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvOther(){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 8], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}

function Get_Portfolio_AssetClassesGrid_DgvItem(position){return Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", position], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)}


//***************************** LABEL CLIGNOTANT (BLINKING LABEL) ***************************************
// Texte "modèle" clignotant après avoir chainé un modèle

function Get_PortfolioGrid_LblBlinkingText(){return Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").WPFObject("MainWindow").WPFObject("contentContainer").WPFObject("tabControl").WPFObject("portfolioPluginWindow").WPFObject("tabCtrl").WPFObject("gridSection").FindChild("Uid", "TextBlock_ce68", 10)}


//************************* SOMMAIRE DU PORTEFEUILLE (PORTFOLIO SUMMARY) ********************************

function Get_PortfolioGrid_GrpSummary(){return Get_PortfolioPlugin().Find("Uid", "Expander_c19c", 10)} //ok

function Get_PortfolioGrid_GrpSummary_ScrollViewer(){return Get_PortfolioGrid_GrpSummary().FindChild("Uid", "ScrollViewer_8402", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ScrollViewer(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "ScrollViewer_ca37", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts(){return Get_PortfolioGrid_GrpSummary().FindChild("Uid", "RQSCharts_e003", 10)}


//Risk Score Graph

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblTitle(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_794d", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblActual(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_c293", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblObjective(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_52c2", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_d923", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0804", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_GeneralRectangle(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, "GeneralRiskScoreRectangle"], 1)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ActualRectangle(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Rectangle", true, ""], 1)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ObjectiveTriangle(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild(["ClrClassName", "IsVisible", "WPFControlName"], ["Polygon", true, ""], 1)}


//Risk Objectives Graph

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblTitle(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_ab46", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent0(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4581", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent25(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_4d32", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent50(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1d52", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent75(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_0e22", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent100(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "TextBlock_1dc3", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl(){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().FindChild("Uid", "ItemsControl_e375", 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskLabel){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["Rectangle", true, riskLabel], 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskLabel){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "Points.Count", "DataContext.RiskLabel"], ["Polygon", true, 3, riskLabel], 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskLabel){return Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindChild(["ClrClassName", "IsVisible", "DataContext.RiskLabel", "WPFControlText"], ["TextBlock", true, riskLabel, riskLabel], 10)}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskLabel)
{
    var allTextBlockControls = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindAllChildren(["ClrClassName", "IsVisible", "DataContext.RiskLabel"], ["TextBlock", true, riskLabel], 10).toArray();
    for (var i in allTextBlockControls)
        if (allTextBlockControls[i].WPFControlText != riskLabel)
            return allTextBlockControls[i];
    return Utils.CreateStubObject();
}


//Partie à compléter avec les fonctions Get des composants des valeurs

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "ComboBox_9a34", 10)} 

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "De base"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Basic"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Currency()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Devise"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Currency"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_ETravail()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "E. Travail"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "E. Travail"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_FinancialInstrument()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Instrument Financier"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Financial Instrument"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Firm()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "De la firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Firm"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_ModifiedDuration()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Durée modifiée"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Modified Duration"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Region()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Région"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Region"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Allocation1859()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Répartition - 1859"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Allocation - 1859"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_AllocationInstrumentFinancier()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Répartition - 'Instrument financier'"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Allocation - 'Instrument financier'"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_AllocationMaturity()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Répartition - Échéances"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Allocation - Maturity"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_BasicSet()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Ensemble de base (Secteur)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Basic Set (Sector)"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_FirmSet()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Croissance (Objectif)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Growth (Objective)"], 10)}
}

function Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Sleeves()  //no uid
{
  if (language=="french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Segments"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Sleeves"], 10)}
}


function Get_PortfolioGrid_GrpSummary_LblCurrency(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "TextBlock_358a", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblMarketValue(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_af91", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtMarketValue(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_8056", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblBookValue(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_67cd", 10)} //ok

// Ajout de fonction get de  Cost Basis spécifique pour la US 90-04-49
function Get_PortfolioGrid_GrpSummary_LblCostBasis(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_67cd", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtBookValue(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_2c92", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblBalance(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_9581", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtBalance(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_3251", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblAccruedIntDiv(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_8fae", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_a411", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblAnnualIncome(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_1ded", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtAnnualIncome(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_02ef", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblBeta(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_21d3", 10)} //Beta is missing is Automation 8 (pref??)

function Get_PortfolioGrid_GrpSummary_TxtBeta(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_ca9f", 10)}

function Get_PortfolioGrid_GrpSummary_LblAverageCostYield(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_72fb", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtAverageCostYield(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_6ffe", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblModDurationAvg(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_850e", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtModDurationAvg(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_96b3", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblNetInvestment(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_a1e7", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LlbNetInvestment(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "TextBlock_e832", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtNetInvestment(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_fd52", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblMargin(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_7b35", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtMargin(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_2c00", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblAccumulatedCommission(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_80d2", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LlbAccumulatedCommission(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "TextBlock_ac66", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtAccumulatedCommission(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_dcfb", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LblAccumIntDiv(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_7a75", 10)} //ok

function Get_PortfolioGrid_GrpSummary_LlbAccumIntDiv(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "TextBlock_7d32", 10)} //ok

function Get_PortfolioGrid_GrpSummary_TxtAccumIntDiv(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "Label_b4ba", 10)} //ok

function Get_PortfolioGrid_GrpSummary_ChkFundAllocation(){return Get_PortfolioGrid_GrpSummary().Find("Uid", "CheckBox_4b53", 10)} 



//************************* SOMMAIRE DU PORTEFEUILLE EN MODE COMPARAISON (PORTFOLIO COMPARISON SUMMARY) ********************************

function Get_PortfolioGrid_Comparison_GrpSummary(){return Get_PortfolioPlugin().Find("Uid", "Expander_c9ce", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_cb43", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_84db", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_00a1", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblMarketValue(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_6879", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtMarketValueFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_1d71", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtMarketValueTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_4783", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtMarketValueDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_0053", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblBookValue(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_36d5", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBookValueFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_9fd2", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBookValueTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_5a4d", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBookValueDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_708e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblBalance(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_fdd6", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBalanceFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_cdf4", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBalanceTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_c38c", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtBalanceDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_45bb", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblAccruedIntDiv(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_2b47", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccruedIntDivFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_ba53", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccruedIntDivTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_3688", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccruedIntDivDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_e3bb", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblAnnualIncome(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_961a", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAnnualIncomeFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_e81e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAnnualIncomeTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_8b4b", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAnnualIncomeDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_f5aa", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblAccumComm(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_855b", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LlbAccumCommIntDivFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "TextBlock_edaf", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumCommFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_ddf4", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LlbAccumCommIntDivTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "TextBlock_f217", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumCommTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_74ac", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumCommDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_7c58", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblAccumIntDiv(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_420a", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumIntDivFrom(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_4733", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumIntDivTo(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_f1ce", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtAccumIntDivDiff(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_fb31", 10)} //ok

//For the period
function Get_PortfolioGrid_Comparison_GrpSummary_LblForThePeriod(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "TextBlock_e81d", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblGL(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_b07a", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtGL(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_cc04", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblROI(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_4192", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtROI(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_973e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblStandardDeviation(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_fefe", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtStandardDeviation(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_98c6", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_LblSharpeIndex(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_b2b5", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_TxtSharpeIndex(){return Get_PortfolioGrid_Comparison_GrpSummary().Find("Uid", "Label_9531", 10)} //ok

//Valeur du tooltip du graphique de répartition d'actifs
function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblTitle(){return Get_SubMenus().Find("Uid", "TextBlock_2b6d", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblFrom(){return Get_SubMenus().Find("Uid", "TextBlock_8a93", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblTo(){return Get_SubMenus().Find("Uid", "TextBlock_0500", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblMarketValuePercent(){return Get_SubMenus().Find("Uid", "TextBlock_4a4b", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtMarketValuePercentFrom(){return Get_SubMenus().Find("Uid", "TextBlock_bd2a", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtMarketValuePercentTo(){return Get_SubMenus().Find("Uid", "TextBlock_0b1d", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblMarketValue(){return Get_SubMenus().Find("Uid", "TextBlock_7f8e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtMarketValueFrom(){return Get_SubMenus().Find("Uid", "TextBlock_682e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtMarketValueTo(){return Get_SubMenus().Find("Uid", "TextBlock_d0df", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblBookValue(){return Get_SubMenus().Find("Uid", "TextBlock_02be", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtBookValueFrom(){return Get_SubMenus().Find("Uid", "TextBlock_10b2", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtBookValueTo(){return Get_SubMenus().Find("Uid", "TextBlock_e8f8", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblInvestedCapital(){return Get_SubMenus().Find("Uid", "TextBlock_d580", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtInvestedCapitalFrom(){return Get_SubMenus().Find("Uid", "TextBlock_0341", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtInvestedCapitalTo(){return Get_SubMenus().Find("Uid", "TextBlock_1173", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblGLBookValue(){return Get_SubMenus().Find("Uid", "TextBlock_4bc3", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtGLBookValueFrom(){return Get_SubMenus().Find("Uid", "TextBlock_28e0", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtGLBookValueTo(){return Get_SubMenus().Find("Uid", "TextBlock_ac7c", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblGLInvestedCapital(){return Get_SubMenus().Find("Uid", "TextBlock_584e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtGLInvestedCapitalFrom(){return Get_SubMenus().Find("Uid", "TextBlock_5c4b", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtGLInvestedCapitalTo(){return Get_SubMenus().Find("Uid", "TextBlock_9c91", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblAnnualIncome(){return Get_SubMenus().Find("Uid", "TextBlock_8b24", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtAnnualIncomeFrom(){return Get_SubMenus().Find("Uid", "TextBlock_7bdc", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtAnnualIncomeTo(){return Get_SubMenus().Find("Uid", "TextBlock_83eb", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblAccruedID(){return Get_SubMenus().Find("Uid", "TextBlock_eabe", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtAccruedIDFrom(){return Get_SubMenus().Find("Uid", "TextBlock_d2a5", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtAccruedIDTo(){return Get_SubMenus().Find("Uid", "TextBlock_7b28", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_LblNoOfPositions(){return Get_SubMenus().Find("Uid", "TextBlock_a3aa", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtNoOfPositionsFrom(){return Get_SubMenus().Find("Uid", "TextBlock_b21e", 10)} //ok

function Get_PortfolioGrid_Comparison_GrpSummary_AssetAllocation_GraphicTooltip_TxtNoOfPositionsTo(){return Get_SubMenus().Find("Uid", "TextBlock_b6de", 10)} //ok


//**************** FENÊTRE SOMMATION POSITIONS (POSITIONS SUM WINDOW) ***********************

function Get_WinPortfolioSum(){return Aliases.CroesusApp.winPositionsSum}

function Get_WinPortfolioSum_BtnClose(){return Get_WinPortfolioSum().Find("Uid", "Button_9e07", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency(){return Get_WinPortfolioSum().Find("Uid", "GroupBox_e324", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblNumberOfPositions(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_378b", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_ec7b", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblMarketValue(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_af91", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtMarketValue(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_8056", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblBookValue(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_67cd", 10)} //ok
//Ajout fonction get pour Cost Basis pour la US 90-04-49
function Get_WinPortfolioSum_GrpCurrency_LblCostBasis(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_67cd", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtBookValue(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_2c92", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblBalance(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_9581", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtBalance(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_3251", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblAccruedIntDiv(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_8fae", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtAccruedIntDiv(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_a411", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblAnnualIncome(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_1ded", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtAnnualIncome(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_02ef", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblBeta(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_21d3", 10)} //Beta is missing is Automation 8 (pref??)

function Get_WinPortfolioSum_GrpCurrency_TxtBeta(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_ca9f", 10)} //Beta is missing is Automation 8 (pref??)

function Get_WinPortfolioSum_GrpCurrency_LblAverageCostYield(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_72fb", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtAverageCostYield(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_6ffe", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblModDurationAvg(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_850e", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtModDurationAvg(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_96b3", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblAccumIntDiv(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_2cee", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtAccumIntDiv(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_4bf0", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumIntDiv(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "TextBlock_3c68", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_LblAccumulatedCommission(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_616a", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_TxtAccumulatedCommission(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "Label_b3a6", 10)} //ok

function Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumulatedCommission(){return Get_WinPortfolioSum_GrpCurrency().Find("Uid", "TextBlock_1f0f", 10)} //ok


//********************* PORTFOLIO QUICK SEARCH (PORTEFEUILLE - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinPortfolioQuickSearch_RdoDescription(){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "SecurityDescription - Description"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "SecurityDescription - Description"])} //no uid

function Get_WinPortfolioQuickSearch_RdoSecurity() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "SecuFirm - Titre"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "SecuFirm - Titre"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "SecuFirm - Security"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "SecuFirm - Security"])}
}
  
function Get_WinPortfolioQuickSearch_RdoSymbol() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Symbol - Symbole"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "Symbol - Symbole"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Symbol - Symbol"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "Symbol - Symbol"])}
}

function Get_WinPortfolioQuickSearch_RdoName() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ClientShortName - Nom"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ClientShortName - Nom"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "ClientShortName - Name"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "ClientShortName - Name"])}
}

function Get_WinPortfolioQuickSearch_RdoType(){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "AccountType - Type"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "AccountType - Type"])} //no uid

function Get_WinPortfolioQuickSearch_RdoAccountNo() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "AccountNumber - No compte"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "AccountNumber - No compte"])}
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "AccountNumber - Account No."], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "AccountNumber - Account No."])}
}

function Get_WinPortfolioQuickSearch_RdoIACode() //no uid
{
  if (language=="french"){return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "RepresentativeNumber - Code de CP"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - Code de CP"])} //EM: Modifié pour 90-06-Be-9 - avant : "WPFControlText" = "RepresentativeId - Code de CP"
  else {return Get_WinQuickSearch().Find(["ClrClassName", "WPFControlText"], ["ListBoxItem", "RepresentativeNumber - IA Code"], 10).Find(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - IA Code"])} //EM: Modifié pour 90-06-Be-9 - avant : "WPFControlText" = "RepresentativeId - Code de CP"
}



//******************************* BAR PORTFOLIO **********************************************

function Get_PortfolioBar(){return Get_PortfolioPlugin().FindChild("Uid", "PadHeader_ed03", 10)} 

function Get_PortfolioBar_BtnIntraday(){return Get_PortfolioBar().Find("Uid", "ToggleButton_20da", 10)} 

function Get_PortfolioBar_BtnInfo(){return Get_PortfolioBar().Find("Uid", "Button_4191", 10)} //ok

function Get_PortfolioBar_BtnTradeDateBalance(){return Get_PortfolioBar().Find("Uid", "Button_c9fd", 10)} //ok

function Get_PortfolioBar_BtnCashFlowProject(){return Get_PortfolioBar().Find("Uid", "ToggleButton_9646", 10)} //ok

function Get_PortfolioBar_BtnAll(){return Get_PortfolioBar().Find("Uid", "ToggleButton_b1fd", 10)} //ok

function Get_PortfolioBar_BtnWhatIf(){return Get_PortfolioBar().Find("Uid", "Button_fcc6", 10)} //ok

function Get_PortfolioBar_BtnCompare(){return Get_PortfolioBar().Find("Uid", "Button_b9d0", 10)} //Btn Compare is missing in Automation 8

function Get_PortfolioBar_BtnSleeves(){return Get_PortfolioBar().Find("Uid", "Button_fef4", 10)}

function Get_PortfolioBar_BtnPerformance(){return Get_PortfolioBar().Find("Uid", "ToggleButton_6ecd", 10)}

//What-if (Simulation)
function Get_PortfolioBar_BtnTotalValue(){return Get_PortfolioBar().Find("Uid", "Button_7f52", 10)} //ok

function Get_PortfolioBar_BtnSave(){return Get_PortfolioBar().Find("Uid", "Button_c28c", 10)} //ok

function Get_PortfolioBar_BtnCancel(){return Get_PortfolioBar().Find("Uid", "Button_25f5", 10)} //ok

function Get_PortfolioBar_BtnReinitializeMV(){return Get_PortfolioBar().FindChild("Uid", "Button_a147", 10)}



//**************************** PORTFOLIO TOOLBARTRAY AND TOGGLEBUTTONTOOLBAR *****************************

function Get_PortfolioGrid_BarToolBarTray(){return Get_PortfolioPlugin().Find("Uid", "ToolBarTray_ca7d", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "TextBlock_dbb7", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "Button_1b65", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "ComboBox_761d", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency_CAD(){return Get_SubMenus().FindChild("WPFControlText", "CAD")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency_USD(){return Get_SubMenus().FindChild("WPFControlText", "USD")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency_EUR(){return Get_SubMenus().FindChild("WPFControlText", "EUR")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency_NOK(){return Get_SubMenus().FindChild("WPFControlText", "NOK")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbCurrency_SEK(){return Get_SubMenus().FindChild("WPFControlText", "SEK")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_dtpDate(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "DateField_dd49", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "ComboBox_4246", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Cumulative(){return Get_SubMenus().FindChild("WPFControlText", "[Cumulative, Cumulative]")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Fixed() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "[Fixed, Fixe]");
  else return Get_SubMenus().FindChild("WPFControlText", "[Fixed, Fixed]");
}

function Get_PortfolioGrid_BarToolBarTray_CmbPerfFees(){return Get_PortfolioGrid_BarToolBarTray().Find("Uid", "ComboBox_3f56", 10)} //ok

function Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Net(){return Get_SubMenus().FindChild("WPFControlText", "[NetOfFeePerformance, Net]")} //No Uid

function Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Gross() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "[GrossOfFeePerformance, Brut]");
  else return Get_SubMenus().FindChild("WPFControlText", "[GrossOfFeePerformance, Gross]");
}

function Get_PortfolioGrid_BarToggleButtonToolBar(){return Get_PortfolioPlugin().Find("Uid", "ToolBar_3f0c", 10)} //ok

function Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(){return Get_PortfolioGrid_BarToggleButtonToolBar().Find("Uid", "ToggleButton_79ce", 10)} //ok

function Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(){return Get_PortfolioGrid_BarToggleButtonToolBar().Find("Uid", "ToggleButton_4bd5", 10)} //ok

function Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(){return Get_PortfolioGrid_BarToggleButtonToolBar().Find("Uid", "ToggleButton_2564", 10)} //ok

function Get_PortfolioGrid_BarToolBarTrayComparison(){return Get_PortfolioPlugin().Find("Uid", "ToolBarTray_16b8", 10)} //ok

function Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod(){return Get_PortfolioGrid_BarToolBarTrayComparison().Find("Uid", "ComboBox_dc36", 10)} //ok

function Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod_LastQuarter() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "Dernier trimestre", 10);
  else return Get_SubMenus().FindChild("WPFControlText", "Last Quarter", 10);
}

function Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod_YearToDate() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "Cumul annuel", 10);
  else return Get_SubMenus().FindChild("WPFControlText", "Year to Date", 10);
}

function Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod_SinceInception() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "Depuis le début", 10);
  else return Get_SubMenus().FindChild("WPFControlText", "Since Inception", 10);
}

function Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod_CustomPeriod() //No Uid
{
  if (language=="french") return Get_SubMenus().FindChild("WPFControlText", "Période sélectionnée", 10);
  else return Get_SubMenus().FindChild("WPFControlText", "Custom period", 10);
}

function Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom(){return Get_PortfolioGrid_BarToolBarTrayComparison().Find("Uid", "DateField_ddc2", 10)} //ok

function Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateTo(){return Get_PortfolioGrid_BarToolBarTrayComparison().Find("Uid", "DateField_eb2b", 10)} //ok

function Get_PortfolioGrid_BarToggleButtonToolBarComparison(){return Get_PortfolioPlugin().Find("Uid", "ToolBar_b235", 10)} //ok

function Get_PortfolioGrid_BarToggleButtonToolBarComparison_BtnByAssetClass(){return Get_PortfolioGrid_BarToggleButtonToolBarComparison().Find("Uid", "ToggleButton_0abb", 10)} //ok



//*************************** FENÊTRE SOLDE (BALANCE WINDOW) *************************************

function Get_WinBalance(){return Aliases.CroesusApp.winBalance}

function Get_WinBalance_BtnClose(){return Get_WinBalance().FindChild("Uid", "Button_eb9f", 10)} //ok

function Get_WinBalance_GrpTradeDate(){return Get_WinBalance().FindChild("Uid", "GroupBox_1c08", 10)} //ok

function Get_WinBalance_GrpTradeDate_LblSettlementDateBalance(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "Label_5ad0", 10)} //ok

function Get_WinBalance_GrpTradeDate_TxtSettlementDateBalance(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "CustomTextBox_fcde", 10)} //ok

function Get_WinBalance_GrpTradeDate_LblReviewedTransactions(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "Label_670d", 10)} //ok

function Get_WinBalance_GrpTradeDate_TxtReviewedTransactions(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "CustomTextBox_c30f", 10)} //ok

function Get_WinBalance_GrpTradeDate_LblTradeDateBalance(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "Label_bc26", 10)} //ok

function Get_WinBalance_GrpTradeDate_TxtTradeDateBalance(){return Get_WinBalance_GrpTradeDate().FindChild("Uid", "CustomTextBox_135c", 10)} //ok


function Get_WinBalance_GrpAdjustedSettlementDate(){return Get_WinBalance().FindChild("Uid", "GroupBox_e725", 10)} //Disponible pour FBN

function Get_WinBalance_GrpAdjustedSettlementDate_LblSettlementDateBalance(){return Get_WinBalance_GrpAdjustedSettlementDate().FindChild("Uid", "Label_74c6", 10)}

function Get_WinBalance_GrpAdjustedSettlementDate_TxtSettlementDateBalance(){return Get_WinBalance_GrpAdjustedSettlementDate().FindChild("Uid", "CustomTextBox_4dfb", 10)}

function Get_WinBalance_GrpAdjustedSettlementDate_LblAdjustedSettlementDateBalance(){return Get_WinBalance_GrpAdjustedSettlementDate().FindChild("Uid", "Label_bfdf", 10)}

function Get_WinBalance_GrpAdjustedSettlementDate_TxtAdjustedSettlementDateBalance(){return Get_WinBalance_GrpAdjustedSettlementDate().FindChild("Uid", "CustomTextBox_d669", 10)}



//*************************** FENÊTRE VALEUR TOTALE - SIMULATION (TOTAL VALUE WINDOW - WHAT-IF) *************************************

function Get_WinTotalValue(){return Aliases.CroesusApp.winTotalValue}

function Get_WinTotalValue_LblTotalValue(){return Get_WinTotalValue().Find("Uid", "Label_57b8", 10)} //ok

function Get_WinTotalValue_TxtTotalValue(){return Get_WinTotalValue().Find("Uid", "DoubleTextBox_68c3", 10)} //ok

function Get_WinTotalValue_BtnOK(){return Get_WinTotalValue().Find("Uid", "Button_51d0", 10)} //ok

function Get_WinTotalValue_BtnCancel(){return Get_WinTotalValue().Find("Uid", "Button_0293", 10)} //ok



//************************** FENÊTRE CHOIX DE CONTEXTE DE COMPARAISON (COMPARISON CONTEST CHOOSER WINDOW) - MISSING IN AUTOMATION 8******************************

function Get_WinComparisonContextChooser(){return Aliases.CroesusApp.winComparisonContextChooser}

function Get_WinComparisonContextChooser_BtnOK(){return Get_WinComparisonContextChooser().Find("Uid", "Button_2aed", 10)}

function Get_WinComparisonContextChooser_BtnCancel(){return Get_WinComparisonContextChooser().Find("Uid", "Button_1348", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions(){return Get_WinComparisonContextChooser().Find("Uid", "GroupBox_8359", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoLastQuarter(){return Get_WinComparisonContextChooser_GrpHistoricalOptions().Find("Uid", "RadioButton_38e3", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoYearToDate(){return Get_WinComparisonContextChooser_GrpHistoricalOptions().Find("Uid", "RadioButton_7b2a", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoSinceInception(){return Get_WinComparisonContextChooser_GrpHistoricalOptions().Find("Uid", "RadioButton_f184", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoCustom(){return Get_WinComparisonContextChooser_GrpHistoricalOptions().Find("Uid", "RadioButton_9880", 10)}

function Get_WinComparisonContextChooser_GrpHistoricalOptions_TxtCustomDate(){return Get_WinComparisonContextChooser_GrpHistoricalOptions().Find("Uid", "DateField_ed7f", 10)}



//*************************************** FENÊTRE SAUVEGARDER LA SIMULATION (WHAT-IF SAVE WINDOW) *******************************************

function Get_WinWhatIfSave(){return Aliases.CroesusApp.winWhatIfSave}

function Get_WinWhatIfSave_BtnDetailedSave(){return Get_WinWhatIfSave().Find("Uid", "Button_71f8", 10)} //ok

function Get_WinWhatIfSave_BtnOK(){return Get_WinWhatIfSave().Find("Uid", "Button_e670", 10)} //ok

function Get_WinWhatIfSave_BtnCancel(){return Get_WinWhatIfSave().Find("Uid", "Button_2fa9", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation(){return Get_WinWhatIfSave().Find("Uid", "GroupBox_82b7", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation_LblShortName(){return Get_WinWhatIfSave_GrpAccountInformation().Find("Uid", "TextBlock_db33", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation_TxtShortName(){return Get_WinWhatIfSave_GrpAccountInformation().Find("Uid", "CustomTextBox_4d5d", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation_LblIACode(){return Get_WinWhatIfSave_GrpAccountInformation().Find("Uid", "TextBlock_3df3", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation_CmbIACode(){return Get_WinWhatIfSave_GrpAccountInformation().Find("Uid", "IACodeControl_d421", 10)} //ok

function Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount() //no uid
{
  if (language=="french"){return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "Nouveau compte fictif"], 10)}
  else {return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "New Fictitious Account"], 10)}
}
  
function Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel() //no uid
{
  if (language=="french"){return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "Nouveau modèle"], 10)}
  else {return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "New Model"], 10)}
}

function Get_WinWhatIfSave_GrpAccountInformation_RdoNewFirmModel() //no uid
{
  if (language=="french"){return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "Nouveau modèle de firme"], 10)}
  else {return Get_WinWhatIfSave_GrpAccountInformation().Find(["ClrClassName", "WPFControlText"], ["RadioButton", "New Firm Model"], 10)}
}

function Get_WinWhatIfSave_ChkReactivateTheModelAfterSaving(){return Get_WinWhatIfSave().Find("Uid", "CheckBox_2861", 10)}



//************************************************* FENÊTRE AJOUTER UNE POSITION (ADD A POSITION WINDOW) ****************************************************

function Get_WinAddPosition(){return Aliases.CroesusApp.winAddPosition}

function Get_WinAddPosition_BtnOK(){return Get_WinAddPosition().Find("Uid", "Button_1304", 10)} //ok

function Get_WinAddPosition_BtnCancel(){return Get_WinAddPosition().Find("Uid", "Button_e9b2", 10)} //ok

function Get_WinAddPosition_GrpAccount(){return Get_WinAddPosition().Find("Uid", "GroupBox_0e53", 10)} 

function Get_WinAddPosition_GrpAccount_CmbAccount(){return Get_WinAddPosition().Find("Uid", "ComboBox_2016", 10)} 

function Get_WinAddPosition_GrpSecurityInformation(){return Get_WinAddPosition().Find("Uid", "GroupBox_8f76", 10)} //

function Get_WinAddPosition_GrpSecurityInformation_LblSecurity(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "Label_8cc6", 10)}

function Get_WinAddPosition_GrpSecurityInformation_DlListPicker(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "ListPickerExec_9344", 10)} //ok

function Get_WinAddPosition_GrpSecurityInformation_CmbTypePicker(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "ListPickerCombo_ae94", 10)} //ok

function Get_WinAddPosition_GrpSecurityInformation_TxtQuickSearchKey(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "TextBox_f1d5", 10)} //ok

function Get_WinAddPosition_GrpAdd_TxtQuickSearchKey(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "ListPicker_123e", 10).Find("Uid", "TextBox_f1d5", 10)}

function Get_WinAddPosition_GrpAdd_CmbTypePicker(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "ListPicker_123e", 10).Find("Uid", "ListPickerCombo_ae94", 10)} 

function Get_WinAddPosition_GrpAdd_DlSecurityListPicker(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "ListPicker_123e", 10).Find("Uid", "ListPickerExec_9344", 10)}

//Added
function Get_WinAddPosition_GrpSecurityInformation_BtnSearch(){return Get_WinAddPosition_GrpSecurityInformation().Find("Uid", "Button_2f56", 10)} //ok


function Get_WinAddPosition_GrpPositionInformation(){return Get_WinAddPosition().Find("Uid", "GroupBox_674c", 10)} //GroupBox_f093

function Get_WinAddPosition_GrpPositionInformation_LblTotalValuePercent(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_c9d6", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblQuantity(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_d3fa", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblHeldIn(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_93b4", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblInvestCost(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_6cf0", 10)} //ok
// Ajout fonction get de Unit Cost spécifique pour US 90-04-49
function Get_WinAddPosition_GrpPositionInformation_LblUnitCost(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_9f0e", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblACB(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_9f0e", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblMarket(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_0b22", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblPrice(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_090f", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblValue(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_e4bb", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblYield(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_bdfc", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_LblLastBuy(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "Label_1825", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_43ec", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtQuantity(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_1414", 10)} //ok

// Ajout de la fonction get du texte Price Unit Cost 
function Get_WinAddPosition_GrpPositionInformation_TxtUnitCostPrice(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_98a6", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtInvestCostPrice(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_7122", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtACBPrice(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_98a6", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtMarketPrice(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "CustomTextBox_78d1", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtInvestCostValue(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_2bb0", 10)}

//Ajout de fonction get du texte Unit Cost Value 
function Get_WinAddPosition_GrpPositionInformation_TxtUnitCostValue(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_38fe", 10)}

function Get_WinAddPosition_GrpPositionInformation_TxtACBValue(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_38fe", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtMarketValue(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DoubleTextBox_0edf", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtInvestCostYield(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "CustomTextBox_06a9", 10)} //ok

//Ajout de fonction get du texte de Unit Cost Yield
function Get_WinAddPosition_GrpPositionInformation_TxtUnitCostYield(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "CustomTextBox_6da5", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_TxtACBYield(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "CustomTextBox_6da5", 10)} //ok

function Get_WinAddPosition_GrpPositionInformation_DtpLastBuy(){return Get_WinAddPosition_GrpPositionInformation().Find("Uid", "DateField_1ede", 10)} //ok

//Fenêtre de gestionnaire de segement 

function Get_WinManagerSleeves(){return Aliases.CroesusApp.winSleevesManager}

function Get_WinManagerSleeves_GrpSleeves(){return Get_WinManagerSleeves().Find(["Uid","VisibleOnScreen"], ["GroupBox_ff64",true], 10)} 

function Get_WinManagerSleeves_GrpSleeveCreation(){return Get_WinManagerSleeves().Find(["Uid","VisibleOnScreen"], ["GroupBox_a5f9",true], 10)} 

function Get_WinManagerSleeves_GrpSleeveCreation_RdoManual(){return Get_WinManagerSleeves_GrpSleeveCreation().Find(["Uid","VisibleOnScreen"], ["RadioButton_6e61",true], 10)} 

function Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate(){return Get_WinManagerSleeves_GrpSleeveCreation().Find(["Uid","VisibleOnScreen"], ["RadioButton_c06c",true], 10)} 

function Get_WinManagerSleeves_GrpSleeveCreation_TxtUsingAtemplate(){return Get_WinManagerSleeves_GrpSleeveCreation().Find(["Uid","VisibleOnScreen"], ["TextBox_44fd",true], 10)}

function Get_WinManagerSleeves_GrpSleeves_DgvSleeves(){return Get_WinManagerSleeves_GrpSleeves().FindChild(["Uid","VisibleOnScreen"], ["DataGrid_df77",true], 10)}//ok


function Get_WinManagerSleeves_ChSleeveDescription()
{
  if (language=="french"){return Get_WinManagerSleeves().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du segment"], 10)}
  else {return Get_WinManagerSleeves().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sleeve Description"], 10)}
}


function Get_WinManagerSleeves_GrpSleeves_LblAssetAllocation(){return Get_WinManagerSleeves_GrpSleeves().Find("Uid", "Label_0621", 10)} 

function Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(){return Get_WinManagerSleeves_GrpSleeves().Find("Uid", "ComboBox_c6b8", 10)}

function Get_WinManagerSleeves_GrpSleeves_LblRemainingTargetPercent(){return Get_WinManagerSleeves_GrpSleeves().Find("Uid", "Label_4d41", 10)} 

function Get_WinManagerSleeves_GrpSleeves_TxtRemainingTargetPercent(){return Get_WinManagerSleeves_GrpSleeves().Find("Uid", "DoubleTextBox_d6b4", 10)} 

function Get_WinManagerSleeves_GrpUnderlyingSecurities(){return Get_WinManagerSleeves().Find(["Uid","VisibleOnScreen"], ["GroupBox_b05c",true], 10)} 

function Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities(){return Get_WinManagerSleeves().Find(["Uid","WPFControlName"], ["DataGrid_f5fb","_securitiesGrid"], 10)} 

function Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove(){return Get_WinManagerSleeves().Find("Uid", "Button_bdc0", 10)} 

function Get_WinManagerSleeves_BtnSave(){return Get_WinManagerSleeves().Find("Uid", "Button_b82c", 10)} 

function Get_WinManagerSleeves_GrpSleeves_BtnEdit(){return Get_WinManagerSleeves().Find("Uid", "Button_39ef", 10)} 

function Get_WinManagerSleeves_GrpSleeves_BtnDelete(){return Get_WinManagerSleeves().Find("Uid", "Button_e77d", 10)} 

function Get_WinManagerSleeves_GrpSleeves_BtnAdd(){return Get_WinManagerSleeves().Find("Uid", "Button_9c81", 10)}

function Get_WinManagerSleeves_BtnCancel() {return Get_WinManagerSleeves().Find("Uid", "Button_4ff9", 10)}


// Fenêtre modifier un segement

function Get_WinEditSleeve(){return Aliases.CroesusApp.winEditSleeve};

function Get_WinEditSleeve_TxtSleeveDescription(){return Get_WinEditSleeve().FindChild("Uid", "LocaleTextbox_fcdc", 10)} 

function Get_WinEditSleeve_CmbAssetClass(){return Get_WinEditSleeve().FindChild("Uid", "UniComboBox_4c99", 10)} 

function Get_WinEditSleeve_TxtValueTextBox(){return Get_WinEditSleeve().FindChild("Uid", "TextBox_f1d5", 10)} 

function Get_WinEditSleeve_TxtTargerPercent(){return Get_WinEditSleeve().FindChild("Uid", "DoubleTextBox_a979", 10)} 

function Get_WinEditSleeve_TxtMinPercent(){return Get_WinEditSleeve().FindChild("Uid", "DoubleTextBox_7ab8", 10)}

function Get_WinEditSleeve_TxtMaxPercent(){return Get_WinEditSleeve().FindChild(["Uid","WPFControlOrdinalNo"], ["DoubleTextBox_dfd8",3], 10)}

function Get_WinEditSleeve_TxtTargetCashPercent(){return Get_WinEditSleeve().FindChild(["Uid","WPFControlOrdinalNo"], ["DoubleTextBox_dfd8",4], 10)}

function Get_WinEditSleeve_BtnQuickSearchListPicker(){return Get_WinEditSleeve().FindChild("Uid", "ListPickerExec_9344", 10)} 

function Get_WinEditSleeve_BtOK(){return Get_WinEditSleeve().FindChild("Uid", "Button_185a", 10)} 

//Fenêtre Move Securities

function Get_WinMoveSecurities(){return Aliases.CroesusApp.WinMoveSecurities};

function Get_WinMoveSecurities_CmbToSleeve(){return Get_WinMoveSecurities().FindChild("Uid", "UniComboBox_06eb", 10)} 

function Get_WinMoveSecurities_GrpSecurities(){return Get_WinMoveSecurities().Find("Uid", "GroupBox_dcb8", 10)}

function Get_WinMoveSecurities_GrpSecurities_DgvListView(){return Get_WinMoveSecurities().Find(["Uid","VisibleOnScreen"], ["ListView_a557",true], 10)}

function Get_WinMoveSecurities_BtnOk(){return Get_WinMoveSecurities().Find("Uid", "Button_ba63", 10)} 

function Get_WinMoveSecurities_BtnCancel(){return Get_WinMoveSecurities().Find("Uid", "Button_b309", 10)} 


//Fenêtre Add a Security/Submodel

function Get_WinAddPositionSubmodel(){return Aliases.CroesusApp.winAddPositionSubmodel};

function Get_WinAddPositionSubmodel_GrpAdd(){return Get_WinAddPositionSubmodel().FindChild("Uid", "GroupBox_b4fc",10)}

function Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker(){return Get_WinAddPositionSubmodel().Find("Uid","ListPicker_123e",10).FindChild("Uid","ListPickerCombo_ae94",10)}

function Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker(){return Get_WinAddPositionSubmodel().Find("Uid","ListPicker_123e",10).FindChild("Uid", "TextBox_f1d5",10)}

function Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker(){return Get_WinAddPositionSubmodel().Find("Uid","ListPicker_123e",10).FindChild("Uid", "ListPickerExec_9344",10)}

function Get_WinAddPositionSubmodel_GrpPositionInformation(){return Get_WinAddPositionSubmodel().FindChild("Uid", "GroupBox_b23e",10)}              

function Get_WinAddPositionSubmodel_TxtSubmodel(){return Get_WinAddPositionSubmodel().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinAddPositionSubmodel_TxtValuePercent(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_722c", 10)}

function Get_WinAddPositionSubmodel_TxtMarketValue(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_e49f", 10)}

function Get_WinAddPositionSubmodel_BtnOK(){return Get_WinAddPositionSubmodel().FindChild("Uid", "Button_bd72", 10)}

function Get_WinAddPositionSubmodel_BtnCancel(){return Get_WinAddPositionSubmodel().FindChild("Uid", "Button_ebdf", 10)}

function Get_WinAddPositionSubmodel_GrpSubstitutionSecurities(){return Get_WinAddPositionSubmodel().FindChild("Uid", "GroupBox_5023",10)} 

function Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit(){return Get_WinAddPositionSubmodel().FindChild("Uid", "Button_9141",10)}

function Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_DgvSubstitution(){return Get_WinAddPositionSubmodel().FindChild(["Uid","VisibleOnScreen"], ["SubstitutionDataGrid_087c",true],10)}

function Get_WinAddPositionSubmodel_TxtToleranceMin(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_0a82", 10)}

function Get_WinAddPositionSubmodel_TxtToleranceMax(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_70fc", 10)}


//Fenêtre substitution security
function Get_WinSubstitutionSecurities(){return Aliases.CroesusApp.winSubstitutionSecurities}; 

function Get_WinSubstitutionSecurities_BtnAdd(){return Get_WinSubstitutionSecurities().FindChild("Uid", "Button_286a", 10)};
function Get_WinSubstitutionSecurities_BtnEdit(){return Get_WinSubstitutionSecurities().FindChild("Uid", "Button_50ee", 10)};
function Get_WinSubstitutionSecurities_BtnRemove(){return Get_WinSubstitutionSecurities().FindChild("Uid", "Button_080a", 10)};

function Get_WinSubstitutionSecurities_BtnOK(){return Get_WinSubstitutionSecurities().FindChild("Uid", "Button_3350", 10)};

function Get_WinSubstitutionSecurities_BtnCancel(){return Get_WinSubstitutionSecurities().FindChild("Uid", "Button_a4fe", 10)};

function Get_WinSubstitutionSecurities_DgvSubstitutions(){return Get_WinSubstitutionSecurities().FindChild(["Uid","VisibleOnScreen"], ["SubstitutionDataGrid_878f",true], 10)};

function Get_WinSubstitutionSecurities_ChRank()
{
  if (language=="french"){return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rang"], 10)}
  else {return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rank"], 10)}
}

function Get_WinSubstitutionSecurities_ChSubstitutionType()
{
  if (language=="french"){return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type de substitution"], 10)}
  else {return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Substitution type"], 10)}
}

function Get_WinSubstitutionSecurities_ChSymbol()
{
  if (language=="french"){return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinSubstitutionSecurities_ChDescription()
{
  if (language=="french"){return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}
  else {return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}
}

function Get_WinSubstitutionSecurities_ChFallbackSecurityReplacement()
{
  if (language=="french"){return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre de rechange d'un remplacement"], 10)}
  else {return Get_WinSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fallback security of a replacement"], 10)}
}

//Fenêtre Add substitution security
function Get_WinReplacement(){return Aliases.CroesusApp.winReplacement}; 

function Get_WinReplacement_BtnOK(){return Get_WinReplacement().FindChild("Uid", "Button_1304", 10)};

function Get_WinReplacement_BtnCancel(){return Get_WinReplacement().FindChild("Uid", "Button_e9b2", 10)};

function Get_WinReplacement_GrpSubstitutionSecurity(){return Get_WinReplacement().FindChild("Uid", "GroupBox_9f98", 10)};

function Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity(){return Get_WinReplacement_GrpSubstitutionSecurity().FindChild("Uid", "TextBox_f1d5", 10)};

function Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker(){return Get_WinReplacement_GrpSubstitutionSecurity().FindChild("Uid", "ListPickerCombo_ae94", 10)};


function Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch(){return Get_WinReplacement_GrpSubstitutionSecurity().FindChild("Uid", "ListPickerExec_9344", 10)};

function Get_WinReplacement_GrpSubstitutionType(){return Get_WinReplacement().FindChild("Uid", "GroupBox_a662", 10)};

function Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "RadioButton_288c", 10)};

function Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(){return Get_WinReplacement_GrpSubstitutionType().FindChild(["Uid","WPFControlOrdinalNo"], ["RadioButton_c0f1",2], 10)};

function Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(){return Get_WinReplacement_GrpSubstitutionType().FindChild(["Uid","WPFControlOrdinalNo"], ["RadioButton_c0f1",3], 10)};

function Get_WinReplacement_GrpSubstitutionType_TxtFallbackMessage(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "TextBlock_f392", 10)};

function Get_WinReplacement_GrpSubstitutionType_TxtReplacementSecurity(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "TextBlock_8dc5", 10)};

function Get_WinReplacement_GrpSubstitutionType_TxtComplementSecurity(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "TextBlock_df1f", 10)};

function Get_WinReplacement_GrpSubstitutionType_TxtSubstitutionType(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "TextBox_f1d5", 10)};

function Get_WinReplacement_GrpSubstitutionType_TxtTitleSubstitutionType(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "TextBlock_03eb", 10)};

function Get_WinReplacement_GrpSubstitutionType_CmbSecurityPicker(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "ListPickerCombo_ae94", 10)};

function Get_WinReplacement_GrpSubstitutionType_BtnSearch(){return Get_WinReplacement_GrpSubstitutionType().FindChild("Uid", "ListPickerExec_9344", 10)};

//Fenêtre submodel Info
function Get_WinSubModelInfo(){return Aliases.CroesusApp.winSubModelInfo};

function Get_WinSubModelInfo_BtnOK(){return Get_WinSubModelInfo().FindChild("Uid", "Button_cc76", 10)}

function Get_WinSubModelInfo_BtnCancel(){return Get_WinSubModelInfo().FindChild("Uid", "Button_3590", 10)}

function Get_WinSubModelInfo_GrpSubstitutionSecurities(){return Get_WinSubModelInfo().FindChild("Uid", "GroupBox_5023", 10)}

function Get_WinSubModelInfo_GrpSubstitutionSecurities_DgvSubstitution(){return Get_WinSubModelInfo_GrpSubstitutionSecurities().FindChild(["Uid","VisibleOnScreen"], ["SubstitutionDataGrid_087c",true], 10)}

function Get_WinSubModelInfo_GrpSubstitutionSecurities_BtnEdit(){return Get_WinSubModelInfo_GrpSubstitutionSecurities().FindChild("Uid", "Button_9141", 10)}

