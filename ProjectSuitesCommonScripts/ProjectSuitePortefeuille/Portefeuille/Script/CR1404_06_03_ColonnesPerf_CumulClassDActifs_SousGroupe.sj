//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifie les colonnes d'un gourpe de positions dans le module Portefeuille avec la préférence Pref_Position_Level_Performance = 1,
                  le bouton performance activé, par classes d'actif, période cumulative, frais net et répartition d'actifs de base.
    Auteur : Antoine Gélinas
*/
function CR1404_06_03_ColonnesPerf_CumulClassDActifs_SousGroupe()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_TIME_MONEY_WEIGHTED","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_REPORT","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_DISPLAY","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS_IN_REPORT","YES",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
    
    Get_ModulesBar_BtnAccounts().Click();
    //Sélectionner un compte non fictif //EM: Modifié Depuis CO-90-07-22
    var max=0;
    var res =aqString.Find(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).dataContext.dataItem.AccountNumber,"~F");
    while(max < 50 && res != -1){ 
        max++;
        res =aqString.Find(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", max+1).dataContext.dataItem.AccountNumber,"~F"); 
        Get_RelationshipsClientsAccountsGrid().Keys("[Down]");        
    }
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    Get_PortfolioBar_BtnPerformance().Click();
    
    if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
    if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Cumulative")
    {
      Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
      Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Cumulative().Click();
    }
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Net")
    {
      Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
      Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Net().Click();
    }
    if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De base" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Basic")
    {
      Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
      Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Basic().Click();
    }
    
    Get_Portfolio_AssetClassesGrid().Click(5, 32);
    
    var columnList = Get_Portfolio_AssetClassesGrid_AssetGroup_ColumnList();
    for(n = 0; n < columnList.length; n++)
      if(aqString.Compare(columnList[n].Content, "", true) == 0)
        columnList.shift();
    
    var columnID; if(language == "french") columnID = 1; else columnID = 2;
    var values = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "ColonnesPerf", 1, columnID).split(";");
    
    if (client == "CIBC"){
        for(var n = 0; n < values.length; n++)
            aqObject.CheckProperty(columnList[n+1], "Content", cmpEqual, values[n]);
    }
    else{  
        for(var n = 0; n < columnList.length; n++)
        {
            //Log.Message("" + n + " = " + columnList[n].Content + ", visible = " + columnList[n].isVisible());
            aqObject.CheckProperty(columnList[n], "Content", cmpEqual, values[n]);
        }
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