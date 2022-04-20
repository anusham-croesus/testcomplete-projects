//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2351

function Regression_Model_ChainerModules()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Clients().Click();
  Get_MenuBar_Modules_Clients_DragSelection().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleClients", language))
    Log.Checkpoint("Module client affiché.");
  else
    Log.Error("Module client non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_DragSelection().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleComptes", language))
    Log.Checkpoint("Module compte affiché.");
  else
    Log.Error("Module compte non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Relationships().Click();
  Get_MenuBar_Modules_Relationships_DragSelection().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleRelations", language))
    Log.Checkpoint("Module relation affiché.");
  else
    Log.Error("Module relation non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  if(Get_PortfolioBar().Exists && Get_PortfolioBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModulePortefeuille", language))
    Log.Checkpoint("Module portefeuille affiché.");
  else
    Log.Error("Module portefeuille non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Close_Croesus_MenuBar();
}