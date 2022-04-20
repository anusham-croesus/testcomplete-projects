//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA
//USEUNIT Relations_Get_functions


function Help_Billing_RelationshipBilling_F1()
{
  Login(vServerHelp, userNameBilling, pswHelp, language);
  Get_ModulesBar_BtnRelationships().Click();
  Get_RelationshipsBar_BtnInfo().Click();
  
  Terminate_IEProcess();
  
  var billingActivated = true;
  if(!Get_WinDetailedInfo_TabBillingForRelationship().Exists)
  {
    billingActivated = false;
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
    Get_WinDetailedInfo_BtnApply().Click();
  }
  Get_WinDetailedInfo_TabBillingForRelationship().Click();
  
  Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 42, columnID));
  
  Terminate_IEProcess();
  
  if(!billingActivated)
  {
    Get_WinDetailedInfo_TabInfo().Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
    if(Get_DlgCroesus().Exists)
      Get_DlgCroesus().Close();
    Get_WinDetailedInfo_BtnApply().Click();
  }
  Get_WinDetailedInfo().Close();
  Close_Croesus_MenuBar();
}
