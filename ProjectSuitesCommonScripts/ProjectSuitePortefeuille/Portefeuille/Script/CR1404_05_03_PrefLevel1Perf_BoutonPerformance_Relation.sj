//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
                  le bouton performance est visible dans Portefeuille après avoir mailler une relation.
    Auteur : Antoine Gélinas
*/
function CR1404_05_03_PrefLevel1Perf_BoutonPerformance_Relation()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  var relationshipNum = "A0006";
  
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    Get_ModulesBar_BtnRelationships().Click();
    
    if(client == "CIBC"){
        Get_RelationshipsClientsAccountsGrid().keys("0");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().keys(relationshipNum);
        Get_WinQuickSearch_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipNum,10).Click();
    }
    
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    Get_PortfolioBar_BtnPerformance().Click();
    
    if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Visible &&
       Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Enabled)
      Log.Checkpoint("Bouton \"par classe d'actifs\" est actif.");
    else
      Log.Error("Bouton \"par classe d'actifs\" devrait être actif.");
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
      Log.Checkpoint("Interface performance est affichée.");
    else
      Log.Error("Interface performance n'est pas affichée.");
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
    RestartServices(vServerPortefeuille);
  }
}