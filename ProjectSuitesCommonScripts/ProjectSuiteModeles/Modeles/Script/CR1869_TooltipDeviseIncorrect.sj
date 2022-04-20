//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9398

function CR1869_TooltipDeviseIncorrect()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var nameModel = "SOUS_MODELE";
  var numberClient = "800038";
  var TileUID = "AccountMarketValue0";
  var colValCompte, colValTitre;
  if(language == "french")
  {
    colValCompte = "Valeur de marché selon la devise du compte";
    colValTitre = "Valeur de marché selon la devise du titre";
  }
  else
  {
    colValCompte = "Market Value Account Currency";
    colValTitre = "Market Value Security Currency";
  }
  
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberClient, 10).Click();
    
    Get_Toolbar_BtnRebalance().Click();
    ouvertRequilibrage = true;
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    entreEtape4 = true;
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Exists; wait++)
      Delay(1000);
    
    var pnl = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser();
    var wnd = Get_WinRebalance();
    var posX = pnl.screenleft - wnd.screenleft;
    var posY = pnl.screentop - wnd.screentop;
    wnd.drag(posX + pnl.width, posY + pnl.height / 2, -pnl.width, 0);
    
    if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked == true)
      Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
    
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    if(!Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueAccountCurrency().Exists)
    {
      Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().Click();
      Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName(colValCompte,colValCompte).Click();
    }
    if(!Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency().Exists)
    {
      Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().Click();
      Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName(colValTitre,colValTitre).Click();
    }
    
    var gridProposedOrders = Get_Grid_ContentArray(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders(),
                                                   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription(), false);
    var indexDeviseTitre = Get_ColumnIndex(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency());
    var indexDescription = Get_ColumnIndex(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription());
    var indexValCompte = Get_ColumnIndex(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueAccountCurrency());
    var indexValTitre = Get_ColumnIndex(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency());
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition().Click();
    
    var gridProposedOrdersUSD = [];
    var orderFound = [];
    var ordersFound = 0;
    for(n = 0; n < gridProposedOrders.length; n++)
      if(gridProposedOrders[n][indexDeviseTitre] == "USD")
      {
        gridProposedOrdersUSD.push(gridProposedOrders[n]);
        orderFound.push(false);
      }
    
    for(scroll = 0; scroll < 40 && ordersFound < gridProposedOrdersUSD.length; scroll++)
    {
      var grid = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio());
      for(order = 0; order < gridProposedOrdersUSD.length; order++)
      {
        if(orderFound[order] || !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().FindChild("WPFControlText", gridProposedOrdersUSD[order][indexDescription], 10).exists)
          continue;
        var found = false;
        for(n = 0; n < grid.length; n++)
          if(grid[n].FindChild("WPFControlText", gridProposedOrdersUSD[order][indexDescription], 10).exists)
          {
            grid[n].FindChild("UID", TileUID, 10).HoverMouse(5, 10);
            found = true;
            break;
          }
        if(found)
        {
          orderFound[order] = true;
          ordersFound++;
          var menu = Get_SubMenus().FindChild("WPFControlText", "*$*", 10).WPFControlText;
          var detected = getPriceFromTooltip(menu);
          var expected = convertTextToNumber(gridProposedOrdersUSD[order][indexValCompte], "invalid");
          expected = Math.abs(Math.floor(detected));
          if(expected == detected)
            Log.Checkpoint("Valeur de " + gridProposedOrdersUSD[order][indexDescription] + " correcte : " + detected);
          else
            Log.Error("Valeur de " + gridProposedOrdersUSD[order][indexDescription] + " incorrecte : expected=" + expected + "  detected=" + detected);
        }
      }
      Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Keys("[PageDown]");
    }
  }
  catch(exc)
  {
    Log.Error("Exception: " + exc.message, exc.message);
  }
  
  if(ouvertRequilibrage)
  {
    Get_WinRebalance_BtnClose().Click();
    if(entreEtape4)
    {
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    }
  }
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}

function getPriceFromTooltip(text)
{
  text = aqString.Replace(text, "\r\n", "\n");
  var index = aqString.Find(text, "\n");
  text = aqString.Remove(text, index, text.length - index);
  index = aqString.Find(text, " ");
  text = aqString.Remove(text, 0, index + 1);
  text = aqString.Replace(text, "$", "");
  
  text = convertTextToNumber(text, "invalid");
  
  return text;
}
