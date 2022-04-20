//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9391

function CR1869_ChangerCompteOrdresProj()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DETAILED_LEVEL","3",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var compteAssocie1 = false;
  var compteAssocie2 = false;
  var nameModel = "CH AMERICAN EQUI";
  var numberAccount1 = "800238-GT";
  var nameAccount1 = "BEAUCH RAYMOND";
  var numberAccount2 = "800255-FS";
  var nameAccount2 = "BLANCHARD CARMEN";
  
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    
    compteAssocie1 = associerCompte(numberAccount1);
    compteAssocie2 = associerCompte(numberAccount2);
    
    Get_Toolbar_BtnRebalance().Click();
    ouvertRequilibrage = true;
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    entreEtape4 = true;
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Exists; wait++)
      Delay(1000);
    
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameAccount1, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
    var gridBefore = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders());
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameAccount2, 10).Click();
    var gridAfter = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders());
    for(n = 0; gridAfter.length == gridBefore.length && n < 5; n++)
    {
      gridAfter = Get_Grid_VisibleLines(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders());
      Delay(100);
    }
    
    Log.Message("The grid must be visible.");
    aqObject.CheckProperty(gridAfter , "length", cmpGreater, 0);
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
  if(compteAssocie1)
    enleverCompte(numberAccount1);
  if(compteAssocie2)
    enleverCompte(numberAccount2);
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}

function associerCompte(numberAccount)
{
  var dejaAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberAccount, 10).Exists;
  if(!dejaAssocie)
  {
    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
    Get_WinPickerWindow_DgvElements().Keys(numberAccount.charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(numberAccount.slice(1));
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAssignToModel_BtnYes().Click();
    return true;
  }
  return false;
}

function enleverCompte(numberAccount)
{
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberAccount, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)), 73);
}
