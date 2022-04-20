//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Address_Delete_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_ClientsBar_BtnInfo().Click();
  
  Terminate_IEProcess();
  
  Get_WinDetailedInfo_TabAddresses().Click();
  Delay(500);
  var DeleteIsEnabled = Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Enabled;
  
  if(!DeleteIsEnabled)
  {
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
    var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
    Get_WinCRUAddress_CmbType().Keys("Test " + UniqueID);
    Get_WinCRUAddress_TxtStreet1().Keys("Test");
    Get_WinCRUAddress_BtnOK().Click();
    Delay(500);
  }
  
  Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
  Get_DlgConfirmation_BtnNo().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 1, columnID));
  
  if(!DeleteIsEnabled)
  {
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73) 
  }
  else
  {
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73) 
  }
  Get_WinDetailedInfo().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
