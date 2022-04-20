//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2344

function Regression_Model_ClientDejaAssocie()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModeles = ["CH AMERICAN EQUI", "CH BONDS"];
  var nameClient = "800232";
  
  if (client == "CIBC"){
      Create_Model("MODEL_CIBC");
      nameModeles = ["*FALL BACK", "MODEL_CIBC"];
  }
  
  //assigner le client à un premier modèle
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModeles[0]);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModeles[0], 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameClient.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameClient.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  
  //tenter d'assigner le client à un second modèle
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModeles[1]);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModeles[1], 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameClient.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameClient.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_BtnOK().Click();
  
  if(Get_WinAssignToModel_BtnYes().Exists && Get_WinAssignToModel_BtnYes().Visible)
    Log.Error("On ne devrait pas pouvoir associer.");
  else
    Log.Checkpoint("On ne peut pas associer.");
  Get_WinAssignToModel_BtnClose().Click();
  
  //enlever le client du premier modèle
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModeles[0]);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModeles[0], 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameClient, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  if (client == "CIBC")
        DeleteModelByName("MODEL_CIBC");
        
  Close_Croesus_MenuBar();
}