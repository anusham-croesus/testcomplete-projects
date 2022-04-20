//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : 
    Auteur : Antoine Gélinas
*/
function CR1404_12_07_PerfCompteClassActifsBrut()
{
  var testNumber = "12-07-";
    
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  var undefinedPosition = "";
  var successfulTests = 0;
  try {
    Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_TIME_MONEY_WEIGHTED","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_REPORT","1",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_NET_GROSS_DISPLAY","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS","YES",vServerPortefeuille);
    Activate_Inactivate_PrefBranch("0","PREF_ENABLE_ALLOC_FUNDS_IN_REPORT","YES",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    
    Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username"),
                               ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"), language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsGrid().keys("3");
    Get_WinQuickSearch_TxtSearch().keys("00012-NA");
    Get_WinQuickSearch_BtnOK().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    Get_PortfolioBar_BtnPerformance().Click();
    
    if(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().isChecked != true) Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
    if(Get_PortfolioBar_BtnAll().isChecked != false) Get_PortfolioBar_BtnAll().Click();
    //if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().isChecked != false) Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click();
    if(Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Text != "USD")
    {
      Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
      Get_PortfolioGrid_BarToolBarTray_CmbCurrency_USD().Click();
    }
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixe" && Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Text != "Fixed")
    {
      Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod().Click();
      Get_PortfolioGrid_BarToolBarTray_CmbPerfPeriod_Fixed().Click();
    }
    if(Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Brut" && Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Text != "Gross")
    {
      Get_PortfolioGrid_BarToolBarTray_CmbPerfFees().Click();
      Get_PortfolioGrid_BarToolBarTray_CmbPerfFees_Gross().Click();
    }
//    if(Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "De la firme" && Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text != "Firm")
//    {
//      Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
//      Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Firm().Click();
//    }
    
    //Find columns placements
    var listCol = Get_Portfolio_AssetClassesGrid_ColumnList();
    var ColumnsEmptyLeft = 0;
    var ColumnDesc = -1;
    var ColumnMarketValue = -1;
    for(col = 0; col < listCol.length && (ColumnDesc < 0 || ColumnMarketValue < 0); col++)
    {
      if(listCol[col].WPFControlText == "")
        ColumnsEmptyLeft++;
      if(listCol[col].WPFControlText == "Description")
        ColumnDesc = col;
      if(listCol[col].WPFControlText == "Valeur de marché" || listCol[col].WPFControlText == "Market Value")
        ColumnMarketValue = col;
    }
    
    //read grid
    var arrayPositions = new Array();
    Get_Portfolio_AssetClassesGrid().Refresh();
    var listePosition = Get_Portfolio_AssetClassGrid_VisibleLines();
    for(n = 0; n < listePosition.length; n++)
    {
      var positionChildren = Get_Portfolio_Grid_LineContent(listePosition[n]);
      
      if(positionChildren.length > 0)
      {
        var arrayContentOfPosition = new Array();
        for(m = 0; m < positionChildren.length; m++)
          arrayContentOfPosition.push("" + positionChildren[m].WPFControlText);
        arrayPositions.push(arrayContentOfPosition);
      }
    }
    
    //begin tests
    for(y = 0; y < arrayPositions.length; y++)
    {
      for(x = 0; x + ColumnsEmptyLeft < arrayPositions[0].length; x++)
      {
        undefinedPosition = "y=" + y + ",x=" + x;
        var expected = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1404_" + client, testNumber + language + "-" + y, "colonne" + x);
        var detected = arrayPositions[y][x + ColumnsEmptyLeft];
        undefinedPosition = "y=" + y + ",x=" + x + ", expected = " + expected + ", detected = " + detected;
        
        if((detected == null || detected == "") && (expected == "" || expected == "n/d" || expected == "n/a")) detected = expected;
        detected = detected.replace(" 00:00:00", "").replace(" 12:00:00 AM", "");
        if(aqString.StrMatches("^-?\\d[\,\.]\\d+E-1\\d$", detected)) detected = 0;
        if(aqString.StrMatches("^-?\\d+[\,\.]\\d\\d\\d+$", detected))
        {
          if(language == "french") detected = detected.replace("\,", ".");
          if(x + ColumnsEmptyLeft == ColumnMarketValue) detected = "" + (Math.round(aqConvert.StrToFloat(detected) * 100) / 100);
          else detected = "" + (Math.round(aqConvert.StrToFloat(detected) * 1000) / 1000);
          if(language == "french") detected = detected.replace("\.", ",");
        }
        undefinedPosition = "y=" + y + ",x=" + x + ", expected = " + expected + ", detected = " + detected;
        if(aqString.Compare("" + expected, "" + detected, true) != 0)
        {
          Log.Error("expected = " + expected + ", detected = " + detected + " (y=" + y + ",x=" + x + ")");
        }
        else
          successfulTests++;
      }
    }
    
    Log.Message("Les valeurs Summary ne se mettent pas à jour correctement quand on change à Brut (CROES-8107)");
    var summaryResults = Get_Portfolio_Grid_Summary();
    for(x = 0; x < summaryResults.length; x++)
    {
      var expected = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1404_" + client, testNumber + language + "-summary", "colonne" + x);
      var detected = "" + summaryResults[x].DataContext.SummaryResult.Value;
      undefinedPosition = "y=summary ,x=" + x + ", expected = " + expected + ", detected = " + detected;
      if(aqString.Contains(detected, "(") == 0)
      {
        detected = aqString.replace(detected, "(", "");
        detected = aqString.replace(detected, ")", "");
        detected = "-" + detected;
      }
      undefinedPosition = "y=summary ,x=" + x + ", expected = " + expected + ", detected = " + detected;
      if(aqString.Compare(expected, detected, true) != 0)
      {
          Log.Error("expected = " + expected + ", detected = " + detected + " (y=summary,x=" + x + ")");
      }
      else
        successfulTests++;
    }
    
    Log.Checkpoint("" + successfulTests + " tests successful.");
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    Log.Message("position -> " + undefinedPosition);
  }
  finally {
    Terminate_CroesusProcess();
    Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
    RestartServices(vServerPortefeuille);
  }
}