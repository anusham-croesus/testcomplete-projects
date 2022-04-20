//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2328

function Regression_Model_AideContextuelle()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Terminate_IEProcess(); 
  Log.Message("Jira CROES-9172"); 
  Get_ModelsGrid().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerModeles), "contentText", cmpEqual,
                          ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "AideModele", language));
  
  Terminate_IEProcess();
  Get_ModelsGrid().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContentsAndIndex2().Click();
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerModeles), "contentText", cmpEqual,
                          ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "AideAccueil", language));
  
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}

