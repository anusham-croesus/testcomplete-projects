//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9274

function CR1869_DeplacerPositionInactif()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var clientAssocie = false;
  var nameModel = "+FB_MONTAN_SUBS";
    
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    
    Get_Toolbar_BtnRebalance().Click();
    ouvertRequilibrage = true;
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    entreEtape4 = true;
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Exists; wait++)
      Delay(1000);
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation_Firm().Click();
    
    var soldeTrouve = false;
    for(find = 0; find < 40 && !soldeTrouve; find++)
    {
      var lines = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio());
      for(n = 0; n < lines.length; n++)
      {
        if(lines[n].FindChild("Value", "1CAD", 10).Exists)
        {
          lines[n].FindChild("WPFControlText", "...", 10).Click();
          soldeTrouve = true;
          break;
        }
      }
      if(!soldeTrouve)
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Keys("[PageDown]")
    }
    
    Log.Message("Déplacer la position devrait être impossible dans le portefeuille projeté Par Compte.");
    aqObject.CheckProperty(Get_WinModifyPosition_CmbCompte() , "Enabled", cmpEqual, false);
    
    Get_WinModifyPosition_BtnCancel().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
    
    Log.Message("Déplacer la position devrait être possible dans le portefeuille projeté.");
    aqObject.CheckProperty(Get_WinModifyPosition_CmbCompte() , "Enabled", cmpEqual, true);
    
    Get_WinModifyPosition_BtnCancel().Click();
  }
  catch(exc)
  {
    Log.Error("Exception: " + exc.message, VarToStr(exc.stack));
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

