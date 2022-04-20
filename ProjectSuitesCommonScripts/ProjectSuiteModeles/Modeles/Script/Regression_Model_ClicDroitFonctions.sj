//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2327

function Regression_Model_ClicDroitFonctions()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModel = "*FALL BACK";
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Info().Click();
  if(Get_WinModelInfo().Exists)
  {
    Log.Checkpoint("Fenêtre Info ouverte.");
    Get_WinModelInfo().Close();
  }
  else
    Log.Error("Fenêtre Info non ouverte.");
  
  if(client != "CIBC"){
        Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
        Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
        Get_ModelsGrid_ContextualMenu_Functions_UnderlyingPerformance().Click();
        if(Get_WinPerformance().Exists)
        {
          Log.Checkpoint("Fenêtre Performance ouverte.");
          Get_WinPerformance().Close();
        }
        else
          Log.Error("Fenêtre Performance non ouverte.");
  }
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Models().Click();
  if(Get_ModelsBar().Exists && Get_ModelsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleModèle", language))
    Log.Checkpoint("Module modèle affiché.");
  else
    Log.Error("Module modèle non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Relationships().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleRelations", language))
    Log.Checkpoint("Module relation affiché.");
  else
    Log.Error("Module relation non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Clients().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleClients", language))
    Log.Checkpoint("Module client affiché.");
  else
    Log.Error("Module client non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Accounts().Click();
  if(Get_RelationshipsClientsAccountsBar().Exists && Get_RelationshipsClientsAccountsBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModuleComptes", language))
    Log.Checkpoint("Module compte affiché.");
  else
    Log.Error("Module compte non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  Get_ModelsGrid_ContextualMenu_Functions_Positions().Click();
  if(Get_PortfolioBar().Exists && Get_PortfolioBar().Text == ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomModulePortefeuille", language))
    Log.Checkpoint("Module portefeuille affiché.");
  else
    Log.Error("Module portefeuille non affiché.");
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().FindChild("Value", nameModel, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Functions().HoverMouse();
  if(Get_ModelsGrid_ContextualMenu_Functions_Transactions().Enabled == false)
    Log.Checkpoint("Fonction transaction grisée.");
  else
    Log.Error("Fonction transaction non grisée.");
  Get_ModulesBar_BtnModels().Click();
  
  Close_Croesus_MenuBar();
}