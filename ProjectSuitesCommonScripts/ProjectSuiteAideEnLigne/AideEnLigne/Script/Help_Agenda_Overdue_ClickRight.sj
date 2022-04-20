﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Agenda_Overdue_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_Toolbar_BtnAgenda().Click();
  Get_WinAgenda_ButtonBar_BtnOverdue().Click();
  
  Terminate_IEProcess();
  
  Get_WinAgenda().ClickR();
  Get_Win_ContextualMenu_Help().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 6, columnID));
  
  Get_WinAgenda().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
