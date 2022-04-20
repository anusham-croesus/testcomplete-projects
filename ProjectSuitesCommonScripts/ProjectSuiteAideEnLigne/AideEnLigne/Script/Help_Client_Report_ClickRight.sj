//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Report_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnReportsAndGraphs().Click();
  
  Terminate_IEProcess();
  
  Get_WinReports_BtnClose().ClickR();
  Get_Win_ContextualMenu_Help().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  Log.Message("CROES-8580")
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 24, columnID));
  
  Get_WinReports().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
