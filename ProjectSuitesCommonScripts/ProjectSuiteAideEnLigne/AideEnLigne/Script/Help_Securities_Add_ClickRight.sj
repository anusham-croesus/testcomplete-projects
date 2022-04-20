//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Securities_Add_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnSecurities().Click();
  Get_Toolbar_BtnAdd().Click();
  
  Terminate_IEProcess();
  
  Get_WinCreateSecurity().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne incorrecte (erreur CROES-7955)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 32, columnID));
  
  Get_WinCreateSecurity().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
