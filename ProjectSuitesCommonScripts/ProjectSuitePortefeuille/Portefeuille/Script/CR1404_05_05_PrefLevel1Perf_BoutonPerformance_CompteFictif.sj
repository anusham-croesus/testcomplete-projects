//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 1,
                  le bouton performance est visible dans Portefeuille après avoir mailler un compte fictif.
    Auteur : Antoine Gélinas
*/
function CR1404_05_05_PrefLevel1Perf_BoutonPerformance_CompteFictif()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsGrid().keys("~~");
    Get_WinQuickSearch_TxtSearch().keys("F");
    Get_WinQuickSearch_BtnOK().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    var compteFictifCree = false;
    if(!Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName().Text.contains("~F"))
    {
      Get_ModulesBar_BtnClients().Click();
      Get_Toolbar_BtnAdd().Click();
      Get_Toolbar_BtnAdd_AddDropDownMenu_CreateFictitiousClient().Click();
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
    
    if(Get_PortfolioBar_BtnPerformance().Visible && !Get_PortfolioBar_BtnPerformance().Enabled)
      Log.Checkpoint("Button performance est grisé.");
    else
      Log.Error("Button performance n'est pas grisé.");
    
    if(compteFictifCree)
    {
      Get_ModulesBar_BtnClients().Click();
      Get_Toolbar_BtnDelete().Click();
      //Get_DlgConfirmAction_BtnDelete().Click(); //EM : Modifié depuis CO: 90-07-22
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
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