//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2365

function Regression_Model_ChainerModelePlusieursComptes()
{
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnModels().Click();
  var nameModele = "CH AMERICAN EQUI";
  var nameAccounts = ["300005-NA", "800223-GT", "800238-FS", "800241-GT"];
  
  if (client == "CIBC")     //Ajouté par Amine
          Create_Model(nameModele);
  Log.Message(client)
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
  for(n = 0; n < nameAccounts.length; n++)
  {
    Get_WinPickerWindow_DgvElements().Keys(nameAccounts[n].charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(nameAccounts[n].slice(1));
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_DgvElements().FindChild("Value", nameAccounts[n], 10).Click(-1, -1, n == 0 ? skNoShift : skCtrl);
  }
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_DragSelection().Click();
  
  Get_Toolbar_BtnSum().Click();
  if(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD().Content == "" + nameAccounts.length)
    Log.Checkpoint("Tous les comptes associés sont visibles."); else Log.Error("Les comptes associés ne sont pas tous visibles.");
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
  
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccounts[0], 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_DragSelection().Click();
  var accountAssocie = Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameAccounts[0], 10);
  if(!accountAssocie.Exists)
    Log.Checkpoint("Le compte enlevé n'est pas visible."); else Log.Error("Le compte enlevé est visible.");
  
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Keys("^a");
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  if (client == "CIBC")         //Ajouté par Amine
          DeleteModelByName(nameModele);
  
  Close_Croesus_MenuBar();
}