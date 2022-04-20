//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9383

function CR1869_AffichageRepartitionsDActifsClient()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  Execute_SQLQuery("execute spBranchConfig '0', 'PREF_PROJECTED_DEF_REPAR', NULL\r\n" + 
                   "update b_succ set config_txt = str_replace(convert(varchar(16296), config_txt), 'PREF_PROJECTED_DEF_REPAR=' + case when right(convert(varchar(16296), config_txt), 1) = char(10) then char(10) else null end, null) from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var clientAssocie = false;
  var nameModel = "CH AMERICAN EQUI";
  var numberClient = "800270";
    
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
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberClient, 10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    var listePortefeuille = GetAllocationsList(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation, Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Growth, Get_PortfolioGrid_GrpSummary);
    
    Get_ModulesBar_BtnModels().Click();
    Get_Toolbar_BtnRebalance().Click();
    ouvertRequilibrage = true;
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    Get_WinRebalance_BtnNext().Click();
    entreEtape4 = true;
    for(wait = 0; wait < 40 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Exists; wait++)
      Delay(1000);
    
    var listeReequilib = GetAllocationsList(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation,
                                            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation_Growth,
                                            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary);
    
    if(listePortefeuille.length != listeReequilib.length)
      Log.Error("Longueur de la liste d'actifs dans portefeuille différente de la liste dans rééquilibrage");
    
    for(n = 0; n < listePortefeuille.length; n++)
    {
      if(aqString.Compare(listePortefeuille[n], listeReequilib[n], true) == 0)
        Log.Checkpoint("Actif identique: " + listePortefeuille[n]);
      else
        Log.Error("Actif différent entre les deux grilles: " + listePortefeuille[n] + ", " + listeReequilib[n],
                      "Grille portefeuille: " + listePortefeuille[n] + "\r\nGrille Rééquilibrage: " + listeReequilib[n]);
    }
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

function GetAllocationsList(comboList, comboFirm, grpSummary)
{
  comboList().Click();
  comboFirm().Click();
  grpSummary().refresh();
  var names = grpSummary().FindAllChildren("ClrClassName", "CellValuePresenter", 10).toArray().sort(function(a, b){return a.ScreenTop - b.ScreenTop});
  for(n = 0; n < names.length; n++)
    names[n] = names[n].WPFControlText;
  grpSummary().FindChild("ClrClassName", "CellValuePresenter", 10).Click();
  grpSummary().FindChild("ClrClassName", "CellValuePresenter", 10).Keys("[PageDown][PageDown]");
  var names2 = grpSummary().FindAllChildren("ClrClassName", "CellValuePresenter", 10).toArray().sort(function(a, b){return a.ScreenTop - b.ScreenTop});
  for(n = 0; n < names2.length; n++)
    names2[n] = names2[n].WPFControlText;
  while(names2.length > 0)
  {
    var present = false;
    for(n = 0; n < names.length && !present; n++)
      if(aqString.Compare(names2[0], names[n], true) == 0)
        present = true;
    if(present)
      names2.shift();
    else
      names.push(names2.shift());
  }
  var listNames = [];
  for(n = 0; n < names.length; n++)
    if(!aqString.StrMatches("^(\\#(\\w|\\d)(\\w|\\d)(\\w|\\d)(\\w|\\d)(\\w|\\d)(\\w|\\d)(\\w|\\d)(\\w|\\d))|" +
                            "(\\(?\\d+\\.?\\d*\\)?\\%)|" +
                            "(\\(?\\d+\\.?\\d*\\)?\\%\\ \\/\\ \\(?\\d+\\.?\\d*\\)?\\%)$", names[n]) &&
                              names[n].length > 0)
      listNames.push(names[n]);
  
  return listNames;
}
