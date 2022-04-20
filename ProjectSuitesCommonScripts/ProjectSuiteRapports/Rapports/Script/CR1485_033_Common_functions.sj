//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function EmptyBillingHistory()
{
    //Vider l'historique de facturation
    SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ViderFacturation.sql";
    ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
}



function BillNowRelationshipAndExportToPDFFormat(relationshipName, frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate, billingDate)
{
    //Make the relationship billable
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipName);
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
    Get_RelationshipsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().set_IsChecked(true);
    Get_WinDetailedInfo_BtnOK().Click();
        
    //Fill Billing tab
    SearchRelationshipByName(relationshipName);
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
    Get_RelationshipsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
        
    FillRelationshipBillingTab(frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate);
        
    //Bill now
    Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
    Get_WinInstantBillingParameters_DtpSelectABillingDate().set_Value(aqConvert.StrToDate(billingDate));
    Get_WinInstantBillingParameters_BtnOK().Click();
    
    //Wait until the Croesus dialog box closes
    Delay(3000);
    var maxWaitTime = 100000;
    WaitObject(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", 10000);
    var isNotFound = WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", maxWaitTime);
    if (isNotFound)
        Log.Message("Progress Croesus dialog box closed.");
    else
        Log.Message("Progress Croesus dialog box not closed after " + maxWaitTime + " ms.");
    
    Log.Message("S'il y a crash : Bug JIRA CROES-7761, normalement corrigé dans CX 90.04-79.");
    
    //Click on Generate button
    Get_WinBilling_BtnGenerate().Click();
    
    //Output selection
    SetIsCheckedForCheckbox(Get_WinOutputSelection_GrpOutput_ChkExportToExcelSummarized(), false)
    SetIsCheckedForCheckbox(Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed(), false)
    SetIsCheckedForCheckbox(Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat(), true)
    Get_WinOutputSelection_BtnOK().Click();
    
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
} 



function FillRelationshipBillingTab(frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate)
{
    windowHeight = Get_WinDetailedInfo().get_Height();
    Get_WinDetailedInfo().set_Height(800);

    if (Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Text != frequency){
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().set_IsDropDownOpen(true);
        Get_SubMenus().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", frequency], 10).Click();
    }
    
    if (Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Text != period){
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().set_IsDropDownOpen(true);
        Get_SubMenus().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", period], 10).Click();
    }
    
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
    
    isFeeScheduleFound = false;
    feeSchedulesCount = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (i = 0; i < feeSchedulesCount; i++){
        displayedFeeScheduleName = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Name();
        if (feeSchedule == displayedFeeScheduleName){
            Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            isFeeScheduleFound = true;
            break;
        }
    }
    
    if (!isFeeScheduleFound)
        Log.Error("The fee schedule '" + feeSchedule + "' was not found.");
        
    Get_WinBillingConfiguration_BtnOK().Click();
    
    accountsCount = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (i = 0; i < accountsCount; i++){
        isFound = false;
        displayedAccountNumber = VarToStr(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
        
        for (j = 0; j < arrayOfAccountsNumbers.length; j++){
            if (displayedAccountNumber == arrayOfAccountsNumbers[j]){
                isFound = true;
                break;
            }
        }
        
        //Check AUM (Cocher ASG)
        SetIsCheckedForCheckbox(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamCheckEditor", "", 1), isFound);
        
        //Check Billable (Cocher Facturable)
        SetIsCheckedForCheckbox(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 7).WPFObject("XamCheckEditor", "", 1), isFound);
        
        //Billing start date (Date de début de facturation)
        if (isFound){
            Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 8).WPFObject("XamDateTimeEditor", "", 1).DblClick();
            Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 8).WPFObject("XamDateTimeEditor", "", 1).Keys(billingStartDate);
        }
    }
    
    Get_WinDetailedInfo().set_Height(windowHeight);
}



function SetIsCheckedForCheckbox(checkboxObject, booleanValue)
{
    if (booleanValue != checkboxObject.IsChecked)
        checkboxObject.Click();
}