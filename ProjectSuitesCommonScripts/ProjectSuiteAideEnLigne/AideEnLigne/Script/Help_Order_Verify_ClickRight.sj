//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_Verify_ClickRight()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  Get_OrderAccumulatorGrid().keys("^a");
  Get_OrderAccumulatorGrid().Keys("[Down]");
  Get_OrderAccumulatorGrid().Keys("[Up]");
  Get_OrderAccumulator_BtnVerify().Click();
  
  Terminate_IEProcess();
  
  Get_WinAccumulator().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinAccumulator().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
