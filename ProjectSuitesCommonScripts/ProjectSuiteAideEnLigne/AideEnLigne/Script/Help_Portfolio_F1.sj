//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Portfolio_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  Terminate_IEProcess();
  
  Get_Portfolio_PositionsGrid().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 28, columnID));
  
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
