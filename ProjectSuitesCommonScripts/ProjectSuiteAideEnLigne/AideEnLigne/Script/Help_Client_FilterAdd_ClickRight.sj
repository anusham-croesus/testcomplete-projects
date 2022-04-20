//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_FilterAdd_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
  
  Terminate_IEProcess();
  
  Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();
  Get_WinCRUFilter_GrpDefinition_LblName().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne différente (erreur CROES-8490)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 14, columnID));
  
  Get_WinCRUFilter().Close();
  Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
