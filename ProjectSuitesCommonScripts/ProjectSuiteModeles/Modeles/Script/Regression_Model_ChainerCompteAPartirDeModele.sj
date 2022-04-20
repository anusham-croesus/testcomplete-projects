//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2374

function Regression_Model_ChainerCompteAPartirDeModele()
{
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnModels().Click();
  var nameModel = "*FALL BACK";
  var nameAccount = "800075-JJ";
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModel);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
  
  //Relation
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccount, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Relationships().Click();
  Get_MenuBar_Modules_Relationships_DragSelection().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleRelations", language))
    Log.Checkpoint("Module relation affiché.");
  else
    Log.Error("Module relation non affiché.");
  
  //Client
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccount, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Clients().Click();
  Get_MenuBar_Modules_Clients_DragSelection().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleClients", language))
    Log.Checkpoint("Module client affiché.");
  else
    Log.Error("Module client non affiché.");
  
  //Portefeuille
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccount, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  if(Get_PortfolioBar().Exists && Get_PortfolioBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModulePortefeuille", language))
    Log.Checkpoint("Module portefeuille affiché.");
  else
    Log.Error("Module portefeuille non affiché.");
  
  //Transaction
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccount, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Transactions().Click();
  Get_MenuBar_Modules_Transactions_DragSelection().Click();
  Delay(10000);
  if(Get_TransactionsBar().Exists && Get_TransactionsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleTransactions", language))
    Log.Checkpoint("Module transaction affiché.");
  else
    Log.Error("Module transaction non affiché.");
  
  Close_Croesus_MenuBar();
}