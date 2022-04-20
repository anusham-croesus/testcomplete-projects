//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9734

function CR1869_AfficherCiblePanier()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var nameModel = "RECHANGE_PANIER";
  var numberClient = "800285";
  var panier = "PANIER OBLIG CORPOR";
  var cible1, cible2;
  if(language == "french")
  {
    cible1 = "Cible ($)";
    cible2 = "Cible (%)";
  }
  else
  {
    cible1 = "Target ($)";
    cible2 = "Target (%)";
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
    
    var grid = Get_Grid_ContentArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio(),
                                     Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*"), false);
    var colDesc = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*"), grid);
    var colCible1 = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(cible1), grid);
    var colCible2 = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(cible2), grid);
    
    var index;
    for(index = 0; index < colDesc.length; index++)
      if(aqString.Compare(panier, colDesc[index], true) == 0)
        break;
    
    if(index == colDesc.length)
      Log.Error("panier non trouvé (" + panier + ").");
    else
    {
      var val1 = convertTextToNumber(colCible1[index], 0);
      var val2 = convertTextToNumber(colCible2[index], 0);
      if(val1 == 0 || val2 == 0)
      {
        Log.Error("Les valeurs cibles du panier sont nulles.");
      }
      else
      {
        Log.Checkpoint("Les valeurs cibles du panier ne sont pas nulles.");
      }
    }
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
