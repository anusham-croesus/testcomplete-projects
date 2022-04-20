//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Dashboard_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  
  Terminate_IEProcess();
  
  if(!Get_Dashboard_CalendarBoard().Exists)
  {
    Get_Toolbar_BtnAdd().Click();
    Get_DlgAddBoard_TvwSelectABoard_Calendar().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Get_Dashboard_CalendarBoard_TabBirthdays().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 30, columnID));
  
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
