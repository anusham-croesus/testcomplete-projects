//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhat_If 
vérifier le texte des en-têtes et vérifier les contrôles dans TOOLBARTRAY. */

function Survol_Por_PortfolioBar_btnWhatIf()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  //Rechercher un client 800300. 
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();
  
   //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //if(Get_PortfolioBar_BtnIntraday().Exists){Get_PortfolioBar_BtnIntraday().Click()}
  
  Get_PortfolioBar_BtnWhatIf().Click();
     
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  Check_Existence_Of_Controls();
   
  Close_Croesus_AltF4();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties_English()
{
   Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
   //Vérification des en-têtes pas default 
   Get_Portfolio_PositionsGrid_ChMVPercent().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQtyVariation().Content, "OleValue", cmpEqual, "Qty Variation");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   if( client !== "US"){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   if( client !== "US"){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "Invest. Cap. G/L (%)");}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "CCY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "YTM - Cost (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "YTD (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
   
   
//   Get_Portfolio_PositionsGrid_ChDescription().ClickR()
//   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
//   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 30);
    
   Add_AllColumns()
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQtyVariation().Content, "OleValue", cmpEqual, "Qty Variation");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChVariationPercent().Content, "OleValue", cmpEqual, "Variation (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
   //Ajout pour US Unit Cost
   if(client == "US" ){
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChUnitCost().Content, "OleValue", cmpEqual, "Unit Cost");} 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSector().Content, "OleValue", cmpEqual, "Sector");

   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRegion().Content, "OleValue", cmpEqual, "Region");
   // Pour US Ajout de Market Value Indicator 
   if(client == "US" ){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValueIndicator().Content, "OleValue", cmpEqual, "MV Ind."); }
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLastBuy().Content, "OleValue", cmpEqual, "Last Buy");
   if(client !== "US" ){ 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. Cost");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGL().Content, "OleValue", cmpEqual, "Invest. Cap. G/L");} 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterest().Content, "OleValue", cmpEqual, "Interest");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Losses");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/L (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Cost Yield (%)");
   //Ajout pour US Cost Basis
   if(client == "US"){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostBasis().Content, "OleValue", cmpEqual, "Cost Basis");}
    
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClose().Content, "OleValue", cmpEqual, "Close");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClientNo().Content, "OleValue", cmpEqual, "Client No.");
   if(client !== "US" ){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Book Value");}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBid().Content, "OleValue", cmpEqual, "Bid");
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta().Content, "OleValue", cmpEqual, "Beta");
   }
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAsk().Content, "OleValue", cmpEqual, "Ask");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   if(client !== "US" ){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "ACB"); } 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbol"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   if(client !== "US" ){  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");} 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   if(client !== "US" ){
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "Invest. Cap. G/L (%)");} 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "CCY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "YTM - Cost (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)");
   Scroll()
  // if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRiskRating().Content, "OleValue", cmpEqual, "Risk Rating"); //YR 90-04-32
  // }
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "YTD (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
        
}

function Check_Properties_French()
{
   Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
   //Vérification des en-têtes pas default 
   Get_Portfolio_PositionsGrid_ChMVPercent().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQtyVariation().Content, "OleValue", cmpEqual, "Écart des quantités");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché");  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "G/P cap. investi (%)");   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "RAC (%)"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "RAJ (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
   
//   Get_Portfolio_PositionsGrid_ChDescription().ClickR()
//   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
//   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 30);
    
   Add_AllColumns()

   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQtyVariation().Content, "OleValue", cmpEqual, "Écart des quantités");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChVariationPercent().Content, "OleValue", cmpEqual, "Écart (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSector().Content, "OleValue", cmpEqual, "Secteur");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Rend. à l'achat (%)"); 
   //region
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "PBR");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClientNo().Content, "OleValue", cmpEqual, "No client")
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. unitaire");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterest().Content, "OleValue", cmpEqual, "Intérêts");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Pertes");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGL().Content, "OleValue", cmpEqual, "G/P cap. investi");
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/P (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDividend().Content, "OleValue", cmpEqual, "Dividende"); 
   //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLastBuy().Content, "OleValue", cmpEqual, "Dernier achat");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClose().Content, "OleValue", cmpEqual, "Clôture");
    
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
   //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta().Content, "OleValue", cmpEqual, "Bêta");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "G/P cap. investi (%)");    
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "RAC (%)");
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Coût (%)");   
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta().Content, "OleValue", cmpEqual, "Bêta");
      //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRiskRating().Content, "OleValue", cmpEqual, "Cote de risque"); //YR 90-04-32
   }    
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "RAJ (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs"); 
}

function Scroll()
{
  var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_Portfolio_PositionsGrid().Click(ControlWidth-40, ControlHeight-5)}
}

function Check_Existence_Of_Controls()
{
    //Tab
    aqObject.CheckProperty(Get_Portfolio_Tab(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Portfolio_Tab(1), "IsSelected", cmpEqual, false);
    
    aqObject.CheckProperty(Get_Portfolio_Tab(2), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Portfolio_Tab(2), "IsSelected", cmpEqual, true);
    
    //Btns
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "IsEnabled", cmpEqual, true);
     
    aqObject.CheckProperty(Get_PortfolioBar_BtnTotalValue(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnTotalValue(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnSave(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnSave(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnCancel(), "IsEnabled", cmpEqual, true);
       
    //PORTFOLIO TOOLBARTRAY AND TOGGLEBUTTONTOOLBAR
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsVisible", cmpEqual, true);
     
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsEnabled", cmpEqual, true);    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsVisible", cmpEqual, false);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsVisible", cmpEqual, false);   
}

function Add_AllColumns()
{    
  Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
  {
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
     
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
    //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
     Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  }
}
