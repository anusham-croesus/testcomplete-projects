//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9503

function CR1869_AffichageSegmentModele()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_SLEEVE_ALLOW_CREATE","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_SLEEVE_ALLOW_VIEW","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_SLEEVE_ALLOW_SYNC","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_SLEEVE_ALLOW_DELETE","YES",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var sleeveAssocie = false;
  var nameModel = "CH AMERICAN EQUI";
  var numberAccount = "800066-GT";
  var nameAccount = "APPEL BERVERLY";
  var nameSleeve = "Test 9503";
  
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw"), language);
                          
    Get_ModulesBar_BtnAccounts().Click();
    SearchAccount(numberAccount);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount, 10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    Get_PortfolioBar_BtnSleeves().Click();
    var dejaSleeve = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value", nameSleeve, 10).Exists;
    if(!dejaSleeve)
    {
      Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
      Get_WinEditSleeve_TxtSleeveDescription().Keys(nameSleeve);
      Get_WinEditSleeve_TxtValueTextBox().Keys(nameModel + "[Tab]");
      Get_WinEditSleeve_BtOK().Click();
      sleeveAssocie = true;
    }
    Get_WinManagerSleeves_BtnSave().Click();
    
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
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameAccount, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation_Firm().Click();
    
    // colonne ~S non présent
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName("*~S-*") , "Exists", cmpEqual, false);
    
    // "..." est présent
    var soldeTrouve = false;
    for(find = 0; find < 40 && !soldeTrouve; find++)
    {
      var lines = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio());
      for(n = 0; n < lines.length; n++)
      {
        if(lines[n].FindChild("WPFControlText", "...", 10).Exists && lines[n].FindChild("WPFControlText", "...", 10).Visible)
        {
          lines[n].FindChild("WPFControlText", "...", 10).Click();
          soldeTrouve = true;
          break;
        }
      }
      if(!soldeTrouve)
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Keys("[PageDown]")
    }
    
    aqObject.CheckProperty(Get_WinModifyPosition(), "Exists", cmpEqual, true);
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
  if(sleeveAssocie)
  {
    Get_ModulesBar_BtnPortfolio().Click();
    Get_PortfolioBar_BtnSleeves().Click();
    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value", nameSleeve, 10).Click();
    Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)), 73);
    Get_WinManagerSleeves_BtnSave().Click();
  }
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}

