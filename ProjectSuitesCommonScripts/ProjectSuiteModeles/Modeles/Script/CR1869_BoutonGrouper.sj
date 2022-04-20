//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9377

function CR1869_BoutonGrouper()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DETAILED_LEVEL","3",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var nameModel = "SUBSTITUT_MOD2";
  
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
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
    
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
    
    var chk = Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked;
    if(chk == true)
      aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders(), "exists", cmpEqual, true);
    else
      aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders(), "exists", cmpEqual, true);
  
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
    var chk = Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked;
    if(chk == true)
      aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders(), "exists", cmpEqual, true);
    else
      aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders(), "exists", cmpEqual, true);
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
