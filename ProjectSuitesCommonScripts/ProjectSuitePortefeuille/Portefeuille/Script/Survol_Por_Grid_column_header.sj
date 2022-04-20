//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers) 
Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. Par la suite remettre la configuration par défaut */

function Survol_Por_Grid_column_header()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
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
       
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
      
  Close_Croesus_AltF4();

}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties_English()
{
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
  
  Get_Portfolio_PositionsGrid_ChAccountNo().ClickR()
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChName().Content, "OleValue", cmpEqual, "Name");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
  //Unit Cost pour US 
  if (client == "US" )
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChUnitCost().Content, "OleValue", cmpEqual, "Unit Cost");}
  if (client !== "US")
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "ACB");}
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
  //Cost Basis pour US
  if (client == "US" )
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostBasis().Content, "OleValue", cmpEqual, "Cost Basis");}
  if (client !== "US")
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Book Value");}
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Losses");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/L (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Cost Yield (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "CCY (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "YTM - Cost (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)");
  Scroll()
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "YTD (%)");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLockedPosition().Content, "OleValue", cmpEqual, "Locked Position");
  // ajout de point de vérification pour la US exclude pour billing Get_Portfolio_PositionsGrid_ChExcludeFromBilling()
  if (client == "US" )
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclude from billing");
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChNonRedeemable().Content, "OleValue", cmpEqual, "Non-redeemable");}
  
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
      var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
      for (i=1; i<=1; i++) {Get_Portfolio_PositionsGrid().Click(20, ControlHeight-5)}
  }
  
  Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
  
  if (client == "BNC" ){
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 29); //EM : 90.09.Er-9 Avant c'était 28. Modification fait suite à l'activation des PREF RQS sur notre Dump
  }
  else if (client == "US" ){
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 23);
  }
  else if(client == "CIBC"){
  Log.Message("CROES-7777")
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 31);
  }
  else{//RJ
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 27);
  }
  
  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
  Get_Portfolio_PositionsGrid().Click(20,ControlHeight)
    
   Add_AllColumns()
  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChTelephone2().Content, "OleValue", cmpEqual, "Telephone 2");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChTelephone1().Content, "OleValue", cmpEqual, "Telephone 1");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSector().Content, "OleValue", cmpEqual, "Sector");
   if(client == "BNC")
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRiskRating().Content, "OleValue", cmpEqual, "Risk Rating"); //EM : 90.09.Er-9 Avant n'était pas disponoble. Modification fait suite à l'activation des PREF RQS sur notre Dump
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRegion().Content, "OleValue", cmpEqual, "Region");
   // Ajout de point de vérification pour Market value indicator pour la US
   if (client == "US" )
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValueIndicator().Content, "OleValue", cmpEqual, "MV Ind.");}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLastBuy().Content, "OleValue", cmpEqual, "Last Buy");
   if(client !== "US" )
   {
       aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");
       aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. Cost");
       aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "Invest. Cap. G/L (%)");
       if(client != "CIBC") 
              aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGL().Content, "OleValue", cmpEqual, "Invest. Cap. G/L");
   }   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterestPortion().Content, "OleValue", cmpEqual, "Interest Portion");
   if (client == "US" )
   {  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
  Get_Portfolio_PositionsGrid().Click(20,ControlHeight)}
  else if (client == "TD" )
   {  var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
 Get_Portfolio_PositionsGrid().Click(ControlWidth-36, ControlHeight-5)}
   else {Scroll()}
  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterest().Content, "OleValue", cmpEqual, "Interest");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromProjectedIncome().Content, "OleValue", cmpEqual, "Exclude from Projected Income");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClose().Content, "OleValue", cmpEqual, "Close");
    if (client == "US")
    {  Scroll()}
    
    
  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClientNo().Content, "OleValue", cmpEqual, "Client No.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBid().Content, "OleValue", cmpEqual, "Bid");  
   if (client == "BNC" ){aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta().Content, "OleValue", cmpEqual, "Beta")};
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAsk().Content, "OleValue", cmpEqual, "Ask");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
   // Pour la US il faut ajouter Unit cost
   if (client == "US" )
  {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChUnitCost().Content, "OleValue", cmpEqual, "Unit Cost");}
   if(client !== "US" )
   {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "ACB");}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   if(client !== "US" )
   {
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Book Value");}
   // Pour la US il faut ajouter  cost basis
   if (client == "US" ){
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostBasis().Content, "OleValue", cmpEqual, "Cost Basis");
   }
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   if(client != "CIBC") 
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Losses");
   if(client == "CIBC") {Scroll()}
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/L (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Cost Yield (%)");
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "CCY (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "YTM - Cost (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)");  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "YTD (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLockedPosition().Content, "OleValue", cmpEqual, "Locked Position");
   // ajout de point de Exclude from billing et Non-reedemable pour la US
   if (client == "US" )
   {aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclude from billing");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChNonRedeemable().Content, "OleValue", cmpEqual, "Non-redeemable");}
   //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclude from billing"); BNC-56 
   
   Get_Portfolio_PositionsGrid_ChLockedPosition().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore()      
}

function Check_Properties_French()
{
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize()
    
    Get_Portfolio_PositionsGrid_ChAccountNo().ClickR()
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChName().Content, "OleValue", cmpEqual, "Nom");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "PBR");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché");//CROES-3714
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");//CROES-3714
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Pertes");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/P (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Rend. à l'achat (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "RAC (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Coût (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");
    Scroll()
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "RAJ (%)");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLockedPosition().Content, "OleValue", cmpEqual, "Position bloquée");
    // aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclure de la facturation"); BNC-56 
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize();
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
      var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
      for (i=1; i<=1; i++) {Get_Portfolio_PositionsGrid().Click(20, ControlHeight-5)}
    }    
    
    Get_Portfolio_PositionsGrid_ChDescription().ClickR()
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
    
    if (client == "CIBC" || client == "US" || client == "TD" ){
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 28);
    }
    else if(client == "BNC"){
     aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 30); //EM : 90.09.Er-9 Avant c'était 28. Modification fait suite à l'activation des PREF RQS sur notre Dump// Avant: 29 A.A
    }
    else{
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 27);
    }
  
    var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
    Get_Portfolio_PositionsGrid().Click(20,ControlHeight)
        
   Add_AllColumns()
   
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChName().Content, "OleValue", cmpEqual, "Nom");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");  
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChTelephone2().Content, "OleValue", cmpEqual, "Téléphone 2");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChTelephone1().Content, "OleValue", cmpEqual, "Téléphone 1");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSector().Content, "OleValue", cmpEqual, "Secteur");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRegion().Content, "OleValue", cmpEqual, "Région");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterestPortion().Content, "OleValue", cmpEqual, "Portion d'intéret");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClientNo().Content, "OleValue", cmpEqual, "No client")
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. unitaire");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInterest().Content, "OleValue", cmpEqual, "Intérêts");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGLPercent().Content, "OleValue", cmpEqual, "G/P cap. investi (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestCapGL().Content, "OleValue", cmpEqual, "G/P cap. investi");
   
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromProjectedIncome().Content, "OleValue", cmpEqual, "Exclure de la projection de liquidités"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChDividend().Content, "OleValue", cmpEqual, "Dividende"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLastBuy().Content, "OleValue", cmpEqual, "Dernier achat");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
   if(client == "BNC")
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChRiskRating().Content, "OleValue", cmpEqual, "Cote de risque"); //EM : 90.09.Er-9 Avant n'était pas disponoble. Modification fait suite à l'activation des PREF RQS sur notre Dump
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChClose().Content, "OleValue", cmpEqual, "Clôture");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta().Content, "OleValue", cmpEqual, "Bêta")};
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBid().Content, "OleValue", cmpEqual, "Acheteur"); 
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChACB().Content, "OleValue", cmpEqual, "PBR");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché");//CROES-3714
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");//CROES-3714
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGainsLosses().Content, "OleValue", cmpEqual, "Gains/Pertes");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChGLPercent().Content, "OleValue", cmpEqual, "G/P (%)");
   Scroll()
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCostYieldPercent().Content, "OleValue", cmpEqual, "Rend. à l'achat (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChCCYPercent().Content, "OleValue", cmpEqual, "RAC (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMCostPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Coût (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChYTDPercent().Content, "OleValue", cmpEqual, "RAJ (%)");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
   aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChLockedPosition().Content, "OleValue", cmpEqual, "Position bloquée");
   //aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclure de la facturation"); BNC-56 
}

function Scroll()
{
  var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_Portfolio_PositionsGrid().Click(ControlWidth-40, ControlHeight-5)}
}

function Add_AllColumns()
{    
  Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
  {
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
     
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
    //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
     Get_Portfolio_PositionsGrid_ChDescription().ClickR()
  }
}







