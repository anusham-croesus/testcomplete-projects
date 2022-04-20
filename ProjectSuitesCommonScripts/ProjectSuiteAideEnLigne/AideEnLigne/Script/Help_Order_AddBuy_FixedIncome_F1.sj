//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_AddBuy_FixedIncome_F1()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  Get_Toolbar_BtnCreateABuyOrder().Click();
  Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
  Get_WinFinancialInstrumentSelector_BtnOK().Click();
  
  Terminate_IEProcess();
  
  Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinOrderDetail().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
