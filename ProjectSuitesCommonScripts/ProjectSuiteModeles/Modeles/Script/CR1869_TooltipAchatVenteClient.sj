//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9311

function CR1869_TooltipAchatVenteClient()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var nameModel = "RECHANGE_PANIER";
  var numberClient = "800285";
  var TileUID = "AccountMarketValue0";
  var namePosition, textClient, textAccount;
  if(language == "french")
  {
    namePosition = "FID CDA H S-12 T/V 15SP10";
    textClient = "% du client";
    textAccount = "% du compte";
  }
  else
  {
    namePosition = "CDA HSG S-12 F/R   15SP10";
    textClient = "% of the client";
    textAccount = "% of the account";
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
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition().Click();
    
    var grid = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio());
    for(n = 0; n < grid.length; n++)
      if(grid[n].FindChild("WPFControlText", namePosition, 10).exists)
      {
        grid[n].FindChild("UID", TileUID, 10).HoverMouse(5, 10);
        break;
      }
    
    var menu = Get_SubMenus().FindChild("WPFControlText", "*$*", 10);
    aqObject.CheckProperty(menu , "WPFControlText", cmpContains, textClient);
    aqObject.CheckProperty(menu , "WPFControlText", cmpContains, textAccount);
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
