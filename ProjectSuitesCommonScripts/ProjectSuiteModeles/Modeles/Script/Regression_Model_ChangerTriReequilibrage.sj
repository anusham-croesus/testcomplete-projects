//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2433

function Regression_Model_ChangerTriReequilibrage()
{
  


  var enteredStepFour = false;
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModel = "*FALL BACK";
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModel);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
  Get_Toolbar_BtnRebalance().Click();
  
  try
  {
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Log.Message("étape 3");
    
    Get_WinRebalance_TabPositionsToRebalance_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    var ID = Get_WinRebalance_TabPositionsToRebalance_ChDescription();
    var grid = Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance();
    Log.Message("CROES-9570")
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent(), "Cible"); //EM: 90-06-Be-17 modifié selon le Jira CROES-9570 - avant "VM cible"
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChMVPercent(), "VM");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent(), "VM min");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent(), "VM max");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChDescription(), "description");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChSymbol(), "symbole");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories(), "catégories de base");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument(), "instrument financiers");
    
    if(client == "CIBC")
          testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChUpdatedOn(), "dernière mise à jour");
    else
          testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate(), "dernière mise à jour"); 
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChMaturity(), "échéance");
    testColonne(ID, grid, Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency(), "devise du titre");
    
    Get_WinRebalance_BtnNext().Click();
    Log.Message("étape 4");
    enteredStepFour = true;
    
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Exists; wait++)
      Delay(1000);
    
    var pnl = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser();
    var wnd = Get_WinRebalance();
    var posX = pnl.screenleft - wnd.screenleft;
    var posY = pnl.screentop - wnd.screentop;
    var dragDistance = ((wnd.width - pnl.width) / 10) * 9;
    wnd.drag(posX + pnl.width, posY + pnl.height / 2, dragDistance, 0);
  
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo();
    grid = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios();
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChRestriction(), "restriction");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMessages(), "message");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChName(), "nom");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo(), "numéro");
    testColonne(ID, grid, Get_WinRebalance_TabPortfoliosToRebalance_ChAssignedModel(), "modèle assigné");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChIACode(), "code de cp");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChBalance(), "solde");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMargin(), "marge");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChTotalValue(), "valeur totale");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCurrency(), "devise");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCashMgmt(), "gestion encaisse");
  
    wnd.drag(posX + pnl.width, posY + pnl.height / 2, -pnl.width, 0);
  
  
    Log.Message("étape 4 - ordres proposés - groupé");
    if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked == false)
      Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
  
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity();
    grid = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders();
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChType(), "type");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChQuantity(), "quantité");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityDescription(), "description du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSymbol(), "symbole");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity(), "titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChPriceSecurityCurrency(), "devise");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityCurrency(), "devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChAccruedInterestSecurityCurrency(), "intérets courus selon la devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChMarketValueSecurityCurrency(), "valeur de marché selon la devise du titre");
  
  
    Log.Message("étape 4 - ordres proposés - non groupé");
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
  
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity();
    grid = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders();
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude(), "inclure");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName(), "nom");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo(), "numéro de compte");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency(), "devise du compte");
    Log.Message("-------- Test de tri de la colonne Code de CP est désactivé jusqu'à la crrection du bug CROES-10569--------");
    //testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode(), "code de cp");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType(), "type");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity(), "quantité");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency(), "prix selon la devise");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency(), "devise du prix");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency(), "intérets courus selon la devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency(), "intérets courus selon la devise du compte");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription(), "description du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol(), "symbole");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity(), "titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency(), "devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate(), "date de rééquilibrage");
  
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Log.Message("étape 4 - portefeuille projeté - normal");
  
    if(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().IsChecked == true)
      Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().Click();
  
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription;
    grid = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio;
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation, "écart des quantités");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity, "quantité");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo, "numéro de compte");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode, "code de cp");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName, "nom");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType, "type");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription, "description");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol, "symbole");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition, "position bloquée");    
    Log.Message("-------------- On désactive le tri par colonne PBR pour le moment la colonne n'est pas triable et le même comportement dans le module Portefeuille BUG!!! peut être --------");
    Log.Message(" -------------- PF-1303 (clone  TCVE-810 -------------------------------");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB, "PBR");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice, "prix au marché");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBookValue, "valeur comptable");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue, "valeur de marché");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent, "VM %");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration, "durée mod");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc, "revenu annuel");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChNonRedeem, "non rachetable");
  
  
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().Click();
    Log.Message("étape 4 - portefeuille projeté - par classe d'actifs");
  
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription;
    grid = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_DgvProjectedPortfolio;
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription, "description");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChNoOfPositions, "nombre de positions");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestedCapital, "capital investi");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMarketValue, "valeur de marché");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMVPercent, "VM %");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestCapGL, "G/P capital investi");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAccruedID, "I/D courus");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAnnInc, "revenu annuel");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChBookValueACB, "valeur comptable");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChGLBookValue, "G/P valeur comptable");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMinObj, "objectif minimal");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMaxObj, "objectif minimal");
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetObj, "objectif cible");
    colonneCible = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetStatus()
    if(colonneCible.width < 30)
      colonneCible.drag(colonneCible.width - 1, colonneCible.height / 2, 30, 0);
    colonneCible.Click();
    testColonnePortefeuilleProjete(ID, grid, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetStatus, "cible");
  
    Get_WinRebalance_BtnNext().Click();
    Log.Message("étape 5");
  
    Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ID = Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription();
    grid = Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute();
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChName(), "nom");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChAccountNo(), "numéro de compte");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency(), "devise du compte");
    Log.Message("-------- Test de tri de la colonne Code de CP est désactivé jusqu'à la crrection du bug CROES-10569--------");
    //testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChIACode(), "code de CP");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChType(), "type");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChQuantity(), "quantité");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency(), "prix selon la devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency(), "devise du prix");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency(), "valeur de marché selon la devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency(), "intérets courus selon la devise du compte");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription(), "description du titre");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChSymbol(), "symbole");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChSecurity(), "titre");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency(), "devise du titre");
    testColonne(ID, grid, Get_WinRebalance_TabOrdersToExecute_ChRebalDate(), "date de rééquilibrage");
  }catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  Get_WinRebalance_BtnClose().Click();
  if(enteredStepFour)
  {
   /* var width = Get_DlgWarning().Get_Width();
    Get_DlgWarning().Click((width*(1/3)),73);*/  //EM : Modifié depuis CO: 90-07-22
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
  }
  
  Close_Croesus_MenuBar();
}

function testColonne(id, grid, colonne, nomTri)
{ 
 
  colonne.Click();
  Delay(1000);

  if(colonne.SortStatus != "NotSorted")
  {
    //var colonneData = Get_ColumnFromGrid(colonne, grid, id); //EM: 90-06-Be-26 : Empecher l'utilisation de Key [Home] car il pose un probleme 
	var colonneData = Get_ColumnFromGrid(colonne, grid, id, false);
    for(n = 0; n < colonneData.length; n++)
      if(colonneData[n].length > 0)
        colonneData[n] = convertToNumber(colonneData[n]);
    var detected = "" + colonneData;
    var expected = colonneData.sort(sortingNumbers);
    if(colonne.SortStatus == "Descending")
      expected.reverse();
    if(colonne.SortStatus != "NotSorted")
      if(aqString.Compare(detected, expected, true) == 0)
        Log.Checkpoint("Le tableau est trié par " + nomTri + ".");
      else
        Log.Error("Le tableau n'est pas trié par " + nomTri + ".", "detected order: " + detected + "\r\nexpected order: " + expected);
    else
      Log.Error("Le tableau n'est pas trié par " + nomTri + ".");
//    Log.Error("Test.", "detected order: " + detected + "\r\nexpected order: " + expected);
  }
  else{
    Log.Error("Le tableau n'est pas trié par " + nomTri + ".");
    Log.Message("Jira CROES-10569 : Problème de tri de colonne dans portefeuilles projetés")
  }
}

function convertToNumber(textValue)
{
  if(aqString.StrMatches("^\\(\\d?\\d?\\d( |\\,\\d\\d\\d)*\\,|\\.\\d\\d+\\)$", textValue))
    textValue = "-" + aqString.Replace(aqString.Replace(textValue, "(", "", true), ")", "", true);
  var regex;
  if(language == "french")
    regex = "^\\d?\\d?\\d( \\d\\d\\d)*\\,\\d\\d+$";
  else
    regex = "^\\d?\\d?\\d(\\,\\d\\d\\d)*\\.\\d\\d+$";
  
  if(aqString.StrMatches(regex, textValue))
    if(language == "french")
      return aqConvert.StrToFloat(aqString.Replace(aqString.Replace(textValue, " ", ""), ",", "."));
    else
      return aqConvert.StrToFloat(aqString.Replace(textValue, ",", ""));
  return textValue;
}

function sortingNumbers(a, b)
{
	if(a == b) return 0;
    if(a < b) return -1;
    if(a > b) return 1;
    return 0;
}

//deuxième version parce que dans portefeuille projeté faire [Home] quand la sélection est déjà en haut change d'onglet
function testColonnePortefeuilleProjete(id, grid, ColumnFunction, nomTri)
{
  var colonne = ColumnFunction();
  colonne.Click();
  if(colonne.SortStatus != "NotSorted")
  {
    var colonneData = Get_ColumnFromGridPortefeuilleProjete(ColumnFunction, grid(), id());
    colonne = ColumnFunction();
    for(n = 0; n < colonneData.length; n++)
      if(colonneData[n].length > 0)
        colonneData[n] = convertToNumber(colonneData[n]);
    var detected = "" + colonneData;
    var expected = colonneData.sort(sortingNumbers);
    if(colonne.SortStatus == "Descending")
      expected.reverse();
    if(colonne.SortStatus != "NotSorted")
      if(aqString.Compare(detected, expected, true) == 0)
        Log.Checkpoint("Le tableau est trié par " + nomTri + ".");
      else
        Log.Error("Le tableau n'est pas trié par " + nomTri + ".", "detected order: " + detected + "\r\nexpected order: " + expected);
    else
      Log.Error("Le tableau n'est pas trié par " + nomTri + ".", "SortStatus = " + colonne.SortStatus + "\r\nVoir image.");
//    Log.Error("Test.", "detected order: " + detected + "\r\nexpected order: " + expected);
  }
  else
    Log.Error("Le tableau n'est pas trié par " + nomTri + ".", "SortStatus = " + colonne.SortStatus + "\r\nVoir image.");
}
function Get_ColumnFromGridPortefeuilleProjete(ColumnFunction, grid, IDColumn)
{
  var gridArray = Get_Grid_ContentArrayPortefeuilleProjete(grid, IDColumn);
  return Get_ColumnFromGridArray(ColumnFunction(), gridArray);
}
function Get_Grid_ContentArrayPortefeuilleProjete(grid, IDColumn)
{
  //Find columns placements
  var listCol = Get_ColumnListAll(IDColumn);
  var ColumnsEmptyLeft = 0;
  var ColumnID = -1;
  for(col = 0; col < listCol.length && ColumnID < 0; col++)
  {
    if(listCol[col] == "")
      ColumnsEmptyLeft++;
    if(listCol[col] == IDColumn.WPFControlText)
      ColumnID = col;
  }
  
  for(homeKey = 0; homeKey < 5 && grid.exists && grid.visible; homeKey++)
    grid.Keys("[Home]");
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
  grid.Keys("[Up]");
  
  var arrayPositions = new Array();
  var ajoutsVides = 0; //nombres de scroll sans ajouts
  while(ajoutsVides < 3)
  {
    grid.Refresh();
    var listePositionCourante = Get_Grid_VisibleLines(grid);
    for(n = 0; n < listePositionCourante.length; n++)
    {
      var positionChildren = Get_Grid_LineContent(listePositionCourante[n]);
      var positionID = positionChildren[ColumnID].WPFControlText;
        
      var isVisible = positionChildren[ColumnID].VisibleOnScreen;
      if(isVisible)
      {
        var notAlreadyFound = true;
        for(findIndex = 0; findIndex < arrayPositions.length; findIndex++)
        {
          if(aqString.Compare(arrayPositions[findIndex][ColumnID - ColumnsEmptyLeft], positionID, true) == 0)
          {
            notAlreadyFound = false;
            break;
          }
        }
        if(notAlreadyFound)
        {
          var arrayContentOfPosition = new Array();
          for(m = ColumnsEmptyLeft; m < positionChildren.length; m++)
            arrayContentOfPosition.push("" + positionChildren[m].WPFControlText);
          arrayPositions.push(arrayContentOfPosition);
          ajoutsVides = 0;
        }
      }
    }
    ajoutsVides++;
    grid.Keys("[PageDown]");
  }
  return arrayPositions;
}