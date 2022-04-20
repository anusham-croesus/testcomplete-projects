//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2360

function Regression_Model_ChainerModeleClient_Relation()
{
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnModels().Click();
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameModel = "TEST-" + UniqueID;
  var nameRelation = "00004";
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModel);
  Get_WinModelInfo_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameRelation.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameRelation.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Clients().Click();
  Get_MenuBar_Modules_Clients_DragSelection().Click();
  
  Get_Toolbar_BtnSum().Click();
  
  if(client=="BNC")
     var NumberOfClients = Get_WinClientsSum_TxtNumberOfClients().Text;
  else
    var NumberOfClients = Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD().value; //EM : Modifié depuis 90-07-23-RJ
    
  if(NumberOfClients == "0")
    Log.Checkpoint("Aucun client visible après avoir chainé."); else Log.Error("Client visible après avoir chainé.");
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameRelation, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Get_Toolbar_BtnDelete().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Close_Croesus_MenuBar();
}