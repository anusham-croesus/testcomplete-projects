//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_AddCriterion_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
  
  Terminate_IEProcess();
  
  Get_WinAddSearchCriterion_LblName().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  if(client == "TD")
  Log.Message("Fenêtre possède une aide en ligne incorrecte (erreur CROES-8489)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 13, columnID));
  
  Get_WinAddSearchCriterion().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
