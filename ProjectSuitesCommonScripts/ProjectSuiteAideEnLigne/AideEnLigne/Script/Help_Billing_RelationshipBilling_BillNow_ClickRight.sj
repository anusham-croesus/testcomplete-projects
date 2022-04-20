//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA
//USEUNIT Relations_Get_functions


function Help_Billing_RelationshipBilling_BillNow_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
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
  
  var BillNowEnabled = true;
  var OriginalFeeSchedule = Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtFeeSchedule().Text;
  var OriginalFeeScheduleIndex = -1;
  if(!Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Visible)
  {
    BillNowEnabled = false;
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
    Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Keys("[Home]");
    Get_WinBillingConfiguration_BtnOK().Click();
    if(Get_CroesusApp().FindChild(TemplateTypeWarningPropertyName, TemplateTypeWarningPropertyValue, 20).Exists)
      Get_DlgTemplateTypeWarning_BtnOK().Click();
    if(aqString.Compare(Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtFeeSchedule().Text, OriginalFeeSchedule, false) == 0)
      OriginalFeeScheduleIndex = 0;
    for(index = 1; !Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Visible && index < 20; index++)
    {
      Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Keys("[Down]");
      Get_WinBillingConfiguration_BtnOK().Click();
      if(Get_CroesusApp().FindChild(TemplateTypeWarningPropertyName, TemplateTypeWarningPropertyValue, 20).Exists)
        Get_DlgTemplateTypeWarning_BtnOK().Click();
      if(aqString.Compare(Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtFeeSchedule().Text, OriginalFeeSchedule, false) == 0)
        OriginalFeeScheduleIndex = index;
    }
  }
  Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
  
  Get_WinInstantBillingParameters_LblSelectABillingDate().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 42, columnID));
  
  Terminate_IEProcess();
  Get_WinInstantBillingParameters().Close();
  
  if(!BillNowEnabled)
  {
    if(OriginalFeeScheduleIndex >= 0)
    {
      Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Keys("[Home]");
      for(index = 0; index < OriginalFeeScheduleIndex; index++)
        Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Keys("[Down]");
      Get_WinBillingConfiguration_BtnOK().Click();
      if(Get_CroesusApp().FindChild(TemplateTypeWarningPropertyName, TemplateTypeWarningPropertyValue, 20).Exists)
        Get_DlgTemplateTypeWarning_BtnOK().Click();
    }
    else
    {
      for(index = 0; (aqString.Compare(Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtFeeSchedule().Text, OriginalFeeSchedule, false) != 0) && index < 30; index++)
      {
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
        Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Keys("[Down]");
        Get_WinBillingConfiguration_BtnOK().Click();
        if(Get_CroesusApp().FindChild(TemplateTypeWarningPropertyName, TemplateTypeWarningPropertyValue, 20).Exists)
          Get_DlgTemplateTypeWarning_BtnOK().Click();
      }
    }
  }
  
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
