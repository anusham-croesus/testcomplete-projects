//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9326

function CR1869_CalculEcartCible()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var compteAssocie = false;
  var nameModel = "CH CANADIAN EQUI";
  var numberCompte = "800049-NA";
  var cible1, cible2, vm1, vm2, ecart1, ecart2;
  if(language == "french")
  {
    cible1 = "Cible ($)";
    cible2 = "Cible (%)";
    vm1 = "VM ($)";
    vm2 = "VM (%)";
    ecart1 = "Écart cible ($)";
    ecart2 = "Écart cible (%)";
  }
  else
  {
    cible1 = "Target ($)";
    cible2 = "Target (%)";
    vm1 = "MV ($)";
    vm2 = "MV (%)";
    ecart1 = "Target dev. ($)";
    ecart2 = "Target dev. (%)";
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
    
    var dejaAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberCompte, 10).Exists;
    if(!dejaAssocie)
    {
      Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
      Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
      Get_WinPickerWindow_DgvElements().Keys(numberCompte.charAt(0));
      Get_WinQuickSearch_TxtSearch().keys(numberCompte.slice(1));
      Get_WinQuickSearch_BtnOK().Click();
      Get_WinPickerWindow_BtnOK().Click();
      Get_WinAssignToModel_BtnYes().Click();
      compteAssocie = true;
    }
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberCompte, 10).Click();
    
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
    
    var getGrid = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio();
    var getColumn = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*");
    
    var colonnes = getColumn.parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return b.ScreenTop - a.ScreenTop}).sort(function(a, b){return a.ScreenLeft - b.ScreenLeft});
  
    var index = [-1,-1,-1,-1,-1,-1];
    for(n = 0; n < colonnes.length; n++)
    {
      if(aqString.Compare(colonnes[n].WPFControlText, "", true) != 0)
      {
        if(aqString.Compare(colonnes[n].WPFControlText, cible1, true) == 0 && index[0] == -1)
          index[0] = n;
        if(aqString.Compare(colonnes[n].WPFControlText, cible2, true) == 0 && index[1] == -1)
          index[1] = n;
        if(aqString.Compare(colonnes[n].WPFControlText, vm1, true) == 0 && index[2] == -1)
          index[2] = n;
        if(aqString.Compare(colonnes[n].WPFControlText, vm2, true) == 0 && index[3] == -1)
          index[3] = n;
        if(aqString.Compare(colonnes[n].WPFControlText, ecart1, true) == 0 && index[4] == -1)
          index[4] = n;
        if(aqString.Compare(colonnes[n].WPFControlText, ecart2, true) == 0 && index[5] == -1)
          index[5] = n;
      }
      else
      {
        colonnes.shift();
        n--;
      }
    }
      Log.Message(index);
    
    var grid = Get_Grid_ContentArray(getGrid, getColumn, false);
  
    var correctLines = 0;
    for(n = 0; n < grid.length; n++)
    {
      var v1 = convertTextToNumber(grid[n][index[0]], 0);
      var v2 = convertTextToNumber(grid[n][index[1]], 0);
      var v3 = convertTextToNumber(grid[n][index[2]], 0);
      var v4 = convertTextToNumber(grid[n][index[3]], 0);
      var v5 = convertTextToNumber(grid[n][index[4]], 0);
      var v6 = convertTextToNumber(grid[n][index[5]], 0);
    
      var diff = 0.03; //différence maximale acceptée
      var resultFull = v5 - (v3 - v1);
      var resultPerc = v6 - (v4 - v2);
      if(resultFull > diff || resultFull < -diff)
        Log.Error("Écart $ incorrect - ligne " + (n + 1) + " (" + v5 + ")");
      if(resultPerc > diff || resultPerc < -diff)
        Log.Error("Écart % incorrect - ligne " + (n + 1) + " (" + v6 + ")");
      if(resultFull <= diff && resultFull >= -diff && resultPerc <= diff && resultPerc >= -diff)
        correctLines++;
    }
    Log.Checkpoint(correctLines + " lignes correctes sur " + grid.length);
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
  if(compteAssocie)
  {
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberCompte, 10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73)
  }
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}

