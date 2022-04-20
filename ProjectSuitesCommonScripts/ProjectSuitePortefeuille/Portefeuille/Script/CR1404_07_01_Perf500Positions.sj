//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie le message d'erreur quand on tente d'afficher la performance de plus de 500 positions 
                  dans le module portefeuille.
    Auteur : Antoine Gélinas
*/
function CR1404_07_01_Perf500Positions()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_PERF_MAX_POSITIONS","500",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    var filtre ="~F";
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize(); 
    //Création d'un filtre temporaire - Afficher juste Clients Non Fictifs //EM : Modifié depuis CO-90-07-22
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click(); 
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();   
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemNotContaining().Click();
    Get_WinCreateFilter_TxtValue().Click();
    Get_WinCreateFilter_TxtValue().SetText(filtre);
    Get_WinCreateFilter_BtnApply().Click();                
    
    var nbPositions = 0;
    for (nbClients = 2; nbClients < 30 && nbPositions < 500; nbClients++)
    {
      Get_ModulesBar_BtnClients().Click();
      Get_RelationshipsClientsAccountsGrid().Keys("[Home]");
      for (n = 0; n < nbClients; n++)
        Get_RelationshipsClientsAccountsGrid().Keys("![Down]");
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Portfolio().Click();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();
      Get_PortfolioBar_BtnAll().Click();
      Get_Toolbar_BtnSum().Click();
      nbPositions = Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions().Text;
      Get_WinPortfolioSum_BtnClose().Click();
    }
    Get_PortfolioBar_BtnPerformance().Click();
    
    var columnID; if(language == "french") columnID = 1; else columnID = 2;
    //aqObject.CheckProperty(Get_DlgCroesus_LblMessage(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 5, columnID).replace("\\r", "\r").replace("\\n", "\n")); //EM : Modifié depuis CO: 90-07-22
    aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 5, columnID).replace("\\r", "\r").replace("\\n", "\n"));
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(2/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(2/3)),73);
    
    if(!Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
      Log.Checkpoint("Interface performance n'est pas affichée après avoir appuyé sur non.");
    else
      Log.Error("Interface performance est affichée après avoir appuyé sur non.");
      
    Get_PortfolioBar_BtnPerformance().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    
    Delay(5000);
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Visible)
      Log.Checkpoint("Interface performance est affichée après avoir appuyé sur oui.");
    else
      Log.Error("Interface performance n'est pas affichée après avoir appuyé sur oui.");
       
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    //Supprimer le filtre temporaire
    Get_ModulesBar_BtnClients().Click();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
    
    Terminate_CroesusProcess();
    Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
    RestartServices(vServerPortefeuille);
  }
}
function Test(){
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click(); 
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();   
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemNotContaining().Click();
    Get_WinCreateFilter_TxtValue().Click();
    Get_WinCreateFilter_TxtValue().SetText("~F");
    Get_WinCreateFilter_BtnApply().Click(); 
}