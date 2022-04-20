//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//DEVPRJ-1782

function CR1869_ChangerAssignePortfProj()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","NO",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var clientAssocie1 = false;
  var clientAssocie2 = false;
  var nameModel = "CH BONDS";
  var numberClient1 = "800049";
  var nameClient1 = "ARMAND ARVIS";
  var numberClient2 = "800058";
  var nameClient2 = "BELLINI CARILYNE";
    
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
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    entreEtape4 = true;
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Exists; wait++)
      Delay(1000);
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameClient1, 10).Click();
    Log.Message("CROES-9776: Selon Mamoudou c'est correcte, il a été retiré pour le moment. Cette fonctionnalité va revenir mais on ne sait pas quand pour le moment")
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupBySecurity().Click();
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameClient2, 10).Click();
    Log.Message("CROES-9914: Croesus crash --> Corrigé sur Be-19")
    
    Log.Message("Le bouton Par Titre ne devrait pas rester actif quand on change de client sélectionné.");
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupBySecurity() , "IsChecked", cmpEqual, false);
    
    
    
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
