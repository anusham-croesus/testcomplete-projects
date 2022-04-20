//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9297

function CR1869_AfficherUnCompteParCompte()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var clientAssocie1 = false;
  var clientAssocie2 = false;
  var nameModel = "CH CANADIAN EQUI";
  var numberClient1 = "800238";
  var nameClient1 = "BEAUCH RAYMOND";
  var numberClient2 = "800255";
  var nameClient2 = "BLANCHARD CARMEN";
  var numberAccount1 = "800238-GT";
  var numberAccount2 = "800255-FS";
  
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    
    clientAssocie1 = associerClient(numberClient1);
    clientAssocie2 = associerClient(numberClient2);
    
    Get_Toolbar_BtnRebalance().Click();
    ouvertRequilibrage = true;
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Click();
    Get_WinRebalance_TabParameters_ChkValidateTargetRange().Click();
    Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().Click();
    Get_WinRebalance_TabParameters_ChkApplyAccountFees().Click();
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
    wnd.drag(posX + pnl.width, posY + pnl.height / 2, 100, 0);
    
    testerColonneCompte(numberClient1, numberAccount1);
    testerColonneCompte(numberClient2, numberAccount2);
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
  if(clientAssocie1)
    enleverClient(numberClient1);
  if(clientAssocie2)
    enleverClient(numberClient2);
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT",null,vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW",null,vServerModeles);
  RestartServices(vServerModeles);
}

function associerClient(numberClient)
{
  var dejaAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberClient, 10).Exists;
  if(!dejaAssocie)
  {
    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
    Get_WinPickerWindow_DgvElements().Keys(numberClient.charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(numberClient.slice(1));
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAssignToModel_BtnYes().Click();
    return true;
  }
  return false;
}

function enleverClient(numberClient)
{
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberClient, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)), 73);
}

function testerColonneCompte(numberClient, numberAccount)
{
    var lines = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator());
    for(n = 0; n < lines.length; n++)
    {
      if(lines[n].FindChild("Value", numberClient, 10).Exists)
      {
        lines[n].Click(5, lines[n].height / 2);
        break;
      }
    }
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().FindChild("Value", numberAccount, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
    var colonneCompte = Get_ColumnFromGrid(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo(),
                                           Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio(),
                                           Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol(), false);
    var tousCorrects = true;
    for(n = 0; n < colonneCompte && tousCorrects; n++)
      tousCorrects &= aqString.Compare(colonneCompte[n], numberAccount, true);
    if(tousCorrects)
      Log.Checkpoint("Les positions affichées appartiennent toutes au compte " + numberAccount + ".");
    else
      Log.Error("Les positions affichées n'appartiennent pas toutes au compte " + numberAccount + ".");
}
