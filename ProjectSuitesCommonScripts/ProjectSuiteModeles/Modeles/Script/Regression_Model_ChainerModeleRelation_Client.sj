//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2359

function Regression_Model_ChainerModeleRelation_Client()
{
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnRelationships().Click();
  Get_Toolbar_BtnAdd().Click();
  Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameRelation = "TEST-" + UniqueID;
  var nameClient = "800300";
  Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(nameRelation);
  Get_WinDetailedInfo_BtnOK().Click();
  Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", nameRelation, 10, true, -1).Click();
  Get_Toolbar_BtnAdd().Click();
  Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameClient.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameClient.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_DgvElements().FindChild("Value", nameClient, 10).Click();
  Get_WinPickerWindow_DgvElements().Keys("![Down]");
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToARelationship_BtnYes().Click();
  
  Get_ModulesBar_BtnModels().Click();
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameModel = "TEST-" + UniqueID;
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModel);
  Get_WinModelInfo_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameClient.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameClient.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Relationships().Click();
  Get_MenuBar_Modules_Relationships_DragSelection().Click();
  
  Get_Toolbar_BtnSum().Click();
  if(Get_WinRelationshipsSum_TxtNumberOfRelationshipsTotalCAD().Value == "0")
  Log.Checkpoint("Aucune relation visible après avoir chainé."); else Log.Error("Relation visible après avoir chainé.");
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
  Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
  Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", nameRelation, 10, true, -1).Click();
  Get_Toolbar_BtnDelete().Click();
  //Get_DlgConfirmAction_BtnOK().Click(); //EM : Modifié depuis CO: 90-07-22
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Get_ModulesBar_BtnModels().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameClient, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/  //EM : Modifié depuis CO: 90-07-22
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Get_Toolbar_BtnDelete().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/  //EM : Modifié depuis CO: 90-07-22
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Close_Croesus_MenuBar();
}