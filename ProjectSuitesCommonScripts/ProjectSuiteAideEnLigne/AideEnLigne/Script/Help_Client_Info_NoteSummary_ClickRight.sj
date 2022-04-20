﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Info_NoteSummary_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_ClientsBar_BtnInfo().Click();
  
  Terminate_IEProcess();
  
  Get_WinInfo_Notes_TabSummary().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 1, columnID));
  
  Get_WinDetailedInfo().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
