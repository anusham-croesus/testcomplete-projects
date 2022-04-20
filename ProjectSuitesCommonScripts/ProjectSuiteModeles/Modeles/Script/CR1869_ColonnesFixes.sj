//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//DEVPRJ-1806

function CR1869_ColonnesFixes()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
  Activate_Inactivate_PrefBranch("0","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
  RestartServices(vServerModeles);
  
  var ouvertRequilibrage = false;
  var entreEtape4 = false;
  var relationAssocie = false;
  var nameModel = "CH BONDS";
  var numberRelation = "00003";
  var nameRelation = "#4 TEST";
    
  try
  {
    Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                          ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
    Get_ModulesBar_BtnModels().Click();
    
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
    Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
    
    var dejaAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberRelation, 10).Exists;
    if(!dejaAssocie)
    {
      Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
      Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
      Get_WinPickerWindow_DgvElements().Keys(numberRelation.charAt(0));
      Get_WinQuickSearch_TxtSearch().keys(numberRelation.slice(1));
      Get_WinQuickSearch_BtnOK().Click();
      Get_WinPickerWindow_BtnOK().Click();
      Get_WinAssignToModel_BtnYes().Click();
      relationAssocie = true;
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
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Value", nameRelation, 10).Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
    
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*").ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var colonneRelation = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName("*" + numberRelation);
    var max = colonneRelation.ScreenLeft + colonneRelation.width;
    var colonne = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(nameModel + "*");
    var colonnes = colonne.parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenTop - b.ScreenTop}).sort(function(a, b){return a.ScreenLeft - b.ScreenLeft});
    var colonnesFixes = [];
  
    for(n=0;n<colonnes.length;n++)
      if((colonnes[n].ScreenLeft + colonnes[n].width) <= max)
        colonnesFixes.push(colonnes[n]);
    var texteColonneNonFixe = colonnes[colonnesFixes.length].WPFControlText;
    
    var keysRight = "[Right]"
    for(n=0;n<7;n++)
      keysRight += keysRight;
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Keys(keysRight);
    
    Log.Message("Les colonnes fixes devraient rester visibles après un scroll vers la droite.")
    for(n=0;n<colonnesFixes.length;n++)
      if(colonnesFixes[n].VisibleOnScreen)
        Log.Checkpoint("\"" + colonnesFixes[n].WPFControlText + "\" visible");
      else
        Log.Error("not visible");
    colonnes[colonnesFixes.length].refresh();
    if(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(texteColonneNonFixe).exists &&
       Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_ChClientName(texteColonneNonFixe).VisibleOnScreen)
      Log.Error("colonne non-fixe encore visible");
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
  if(relationAssocie)
  {
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", numberRelation, 10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73)
  }
  
  Close_Croesus_MenuBar();
  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
  RestartServices(vServerModeles);
}

