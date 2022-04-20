﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Agenda_Tasks_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_Toolbar_BtnAgenda().Click();
  Get_WinAgenda_ButtonBar_BtnTasks().Click();
  
  Terminate_IEProcess();
  
  Get_WinAgenda_ButtonBar_BtnTasks().keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 35, columnID));
  
  Get_WinAgenda().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
