//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2353

function Regression_Model_AjouterObjectifPlacement()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_Toolbar_BtnSearch().Click();
  var nameUsed = "*FALL BACK"
  Get_WinQuickSearch_TxtSearch().keys(nameUsed);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameUsed, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Info().Click();
  Get_WinModelInfo_TabInvestmentObjective().Click();
  if(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective().IsChecked)
    Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective().Click();
  Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective().Click();
  Get_LstInvestmentObjectivesForRelationship_ItemBasic_Growth().Click();
  Get_WinModelInfo_BtnOK().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  var textGrowth = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "Croissance", language);
  if(!Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Text.Contains(textGrowth))
    Log.Error("La répartition d'actif devrait être Croissance.");
  else
    Log.Checkpoint("La répartition d'actif est bien Croissance.");
  
  Get_ModulesBar_BtnModels().Click();
  Get_ModelsGrid().FindChild("Value", nameUsed, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Info().Click();
  Get_WinModelInfo_TabInvestmentObjective().Click();
  Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective().Click();
  Get_WinModelInfo_BtnOK().Click();
  
  Close_Croesus_MenuBar();
}