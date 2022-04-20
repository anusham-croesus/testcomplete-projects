//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Address_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_ClientsBar_BtnInfo().Click();
  
  Terminate_IEProcess();
  
  Get_WinDetailedInfo_TabAddresses().Click();
  Delay(500);
  
  Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblType().ClickR();
  Get_Win_ContextualMenu_Help().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 10, columnID));
  
  Get_WinDetailedInfo().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
