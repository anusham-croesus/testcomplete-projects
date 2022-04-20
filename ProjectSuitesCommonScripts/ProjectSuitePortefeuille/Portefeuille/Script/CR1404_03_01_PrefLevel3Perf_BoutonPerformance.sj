//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie dans le module Portefeuille que avec la préférence Pref_Position_Level_Performance = 3,
                  le bouton performance n'est pas visible dans Portefeuille.
    Auteur : Antoine Gélinas
*/
function CR1404_03_01_PrefLevel3Perf_BoutonPerformance()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  var relationshipNum = "A0006";
  
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","3",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    if(!Get_PortfolioBar_BtnPerformance().Visible)
      Log.Checkpoint("Bouton \"Perf, par classe d'actifs\" n'est pas visible après maillage compte.");
    else
      Log.Error("Bouton \"Perf, par classe d'actifs\" ne devrait pas être visible après maillage compte.");
    
    Get_ModulesBar_BtnClients().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    if(!Get_PortfolioBar_BtnPerformance().Visible)
      Log.Checkpoint("Bouton \"Perf, par classe d'actifs\" n'est pas visible après maillage client.");
    else
      Log.Error("Bouton \"Perf, par classe d'actifs\" ne devrait pas être visible après maillage client.");
    
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
    
    if(!Get_PortfolioBar_BtnPerformance().Visible)
      Log.Checkpoint("Bouton \"Perf, par classe d'actifs\" n'est pas visible après maillage relation.");
    else
      Log.Error("Bouton \"Perf, par classe d'actifs\" ne devrait pas être visible après maillage relation.");
    
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