//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//CROES-9382

function CR1869_ColonnesCible()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var nameModel = "*FALL BACK";
  var numberAccount = "800075-JJ";
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
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberAccount, 10).Click();
    
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
                                     Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*"), false)
    
    var columnDesc = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*"), grid);
    var columnSymbol = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName("Symbol*"), grid);
    var column1 = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(cible1), grid);
    var column2 = Get_ColumnFromGridArray(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(cible2), grid);
    
    var currentValue1 = 0;
    var currentValue2 = 0;
    var currentGroup = "";
    var errors = false;
    for(n = 0; n < columnSymbol.length; n++)
    {
      if(aqString.Compare("", columnSymbol[n], true) == 0)
      {
        if(currentValue1 > 1 || currentValue2 > 1)
        {
          errors = true;
          Log.Error("Il manque des valeurs cibles dans le groupe " + currentGroup + ".");
        }
        currentGroup = columnDesc[n];
        currentValue1 = convertTextToNumber(column1[n]);
        currentValue2 = convertTextToNumber(column2[n]);
      }
      else
      {
        currentValue1 -= convertTextToNumber(column1[n]);
        currentValue2 -= convertTextToNumber(column2[n]);
      }
    }
    if(!errors)
        Log.Checkpoint("Toutes les valeurs cibles des positions semblent affichées normalement.");
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
