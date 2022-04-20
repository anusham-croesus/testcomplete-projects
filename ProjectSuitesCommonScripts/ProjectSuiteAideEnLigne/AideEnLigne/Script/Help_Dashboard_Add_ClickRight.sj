//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Dashboard_Add_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_Toolbar_BtnAdd().Click();
  
  Terminate_IEProcess();
  
  Get_DlgAddBoard().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  Log.Message("CROES-8580")
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 31, columnID));
  
  Get_DlgAddBoard().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
