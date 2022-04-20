//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//DEVPRJ-1783

function CR1869_ModifierPositionParTitre()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","NO",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var clientAssocie = false;
  var nameModel = "CH BONDS";
  var numberClient = "800049";
  var nameClient = "ARMAND ARVIS";
  var numberAccount1 = "800049-NA";
  var numberAccount2 = "800049-OB";
  var SymbolePosition = "B55410";
    
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    
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
      clientAssocie = true;
    }
    
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
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameClient, 10).Click();
    Log.Message("CROES-9776: Selon Mamoudou c'est correcte, il a été retiré pour le moment. Cette fonctionnalité va revenir mais on ne sait pas quand pour le moment")
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupBySecurity().Click();
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Keys(SymbolePosition.charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(SymbolePosition.slice(1));
    Get_WinQuickSearch_RdoSymbol().Click();
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().FindChild("Value", SymbolePosition, 10).Click();
    var lines = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
    for(n = 0; n < lines.length; n++)
    {
      if(lines[n].FindChild("Value", SymbolePosition, 10).Exists)
      {
        lines[n].Click(5, lines[n].height / 2);
        break;
      }
    }
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio_ExpandedElement().FindChild("Value", numberAccount1, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
    var Qty1 = Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Value;
    Get_WinModifyPosition_BtnCancel().Click();
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio_ExpandedElement().FindChild("Value", numberAccount2, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
    var Qty2 = Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Value;
    Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Keys("^a" + Qty1);
    Get_WinModifyPosition_BtnOK().Click();
    
    Log.Message("CROES-9776 : Selon Mamoudou c'est correcte, il a été retiré pour le moment. Cette fonctionnalité va revenir mais on ne sait pas quand pour le moment")
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupBySecurity().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Keys(SymbolePosition.charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(SymbolePosition.slice(1));
    Get_WinQuickSearch_RdoSymbol().Click();
    Get_WinQuickSearch_BtnOK().Click();
    var lines = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
    for(n = 0; n < lines.length; n++)
    {
      if(lines[n].FindChild("Value", SymbolePosition, 10).Exists && lines[n].FindChild("Value", numberAccount2, 10).Exists)
      {
        lines[n].Click();
        break;
      }
    }
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
    Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Keys("^a" + Qty2);
    Get_WinModifyPosition_BtnOK().Click();
    
  }
  catch(exc)
  {
    Log.Error("Exception: " + exc.message, VarToStr(exc.stack));
  }
  
  if(ouvertRequilibrage && Get_WinRebalance().exists)
  {
    Get_WinRebalance_BtnClose().Click();
    if(entreEtape4)
    {
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    }
  }
  if(clientAssocie)
  {
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberClient, 10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73)
  }
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}
