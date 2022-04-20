//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_Split_F1()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  if(Get_OrderAccumulator_BtnSplit().IsEnabled != true)
  {
    Get_OrderAccumulatorGrid().keys("^a");
    Get_OrderAccumulatorGrid().Keys("[Down]");
    Get_OrderAccumulatorGrid().Keys("[Up]");
    for(var n = 0; Get_OrderAccumulator_BtnSplit().IsEnabled != true && n < 100; n++)
      Get_OrderAccumulatorGrid().Keys("[Down]");
  }
  Get_OrderAccumulator_BtnSplit().Click();
  
  Terminate_IEProcess();
  
  Get_WinSplitCancel().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinSplitBlock().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
