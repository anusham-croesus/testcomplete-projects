//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
                  le bouton performance est visible dans Portefeuille après avoir mailler un compte externe.
    Auteur : Antoine Gélinas
*/
function CR1404_05_06_PrefLevel1Perf_BoutonPerformance_CompteExterne()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsGrid().keys("~~");
    Get_WinQuickSearch_TxtSearch().keys("E");
    Get_WinQuickSearch_BtnOK().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    var compteExterneCree = false;
    if(!Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName().Text.contains("~E"))
    {
      Get_ModulesBar_BtnClients().Click();
      Get_Toolbar_BtnAdd().Click();
      Get_Toolbar_BtnAdd_AddDropDownMenu_CreateExternalClient().Click();
      var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().keys("Test A" + UniqueID);
      Get_WinDetailedInfo_BtnOK().Click();
      Get_RelationshipsClientsAccountsGrid().keys("A");
      Get_WinQuickSearch_TxtSearch().keys(UniqueID);
      Get_WinQuickSearch_BtnOK().Click();
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Accounts().Click();
      Get_MenuBar_Modules_Accounts_DragSelection().Click();
      if(Get_DlgCroesus().Exists)
        Get_DlgCroesus().Close();
      Get_Toolbar_BtnAdd().Click();
      Get_WinDetailedInfo_BtnOK().Click();
      Delay(500);
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Portfolio().Click();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();
      
      compteFictifCree = true;
    }
    
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
    
    if(compteExterneCree)
    {
      Get_ModulesBar_BtnClients().Click();
      Get_Toolbar_BtnDelete().Click();
      Get_DlgConfirmAction_BtnDelete().Click();
    } 
    
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