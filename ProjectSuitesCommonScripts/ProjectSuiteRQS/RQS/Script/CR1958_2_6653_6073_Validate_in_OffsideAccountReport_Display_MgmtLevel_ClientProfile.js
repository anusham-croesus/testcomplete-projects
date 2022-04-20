//USEUNIT CR1958_2_Helper


/**
    Description : Steps #3 and #4 (Management Level = Client Profile). Validate if the Plugin and the new column added in Offside Account Report Client Relationship number,Client Relationship Name,Management level)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653
    Steps #3 and #4 (Management Level = Client Profile)
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display_MgmtLevel_ClientProfile()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653", "Croes-6653 Steps #3 and #4 - Client Profile : Validate display in Reports Offside grid --> CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display_MgmtLevel_ClientProfile()");
    
    var managementLevel         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ManagementLevel_ClientProfile", language + client);
    var clientNumber            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_ClientNumber", language + client);
    var clientInvRiskLow        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_ClientKYC_InvRiskLow", language + client);
    var clientInvRiskMed        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_ClientKYC_InvRiskMed", language + client);
    var clientInvRiskHigh       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_ClientKYC_InvRiskHigh", language + client);
    var relationshipNumber      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_RelationshipNumber", language + client);
    var relationshipShortName   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_RelationshipShortName", language + client);
    var clientRelationshipName  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_ClientProfile_ClientRelationshipName", language + client);
    var clientNumberInOffsideReports = "";
    
    CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display(managementLevel, clientNumber, clientInvRiskLow, clientInvRiskMed, clientInvRiskHigh, relationshipNumber, relationshipShortName, clientRelationshipName, clientNumberInOffsideReports);
}




function CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display(managementLevel, clientNumber, clientInvRiskLow, clientInvRiskMed, clientInvRiskHigh, relationshipNumber, relationshipShortName, clientRelationshipName, clientNumberInOffsideReports)
{
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var Label_ColumnHeader_ManagementLevel              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ManagementLevel", language + client);
        var Label_ColumnHeader_ClientRelationshipNumber     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipNumber", language + client);
        var Label_ColumnHeader_ClientRelationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipName", language + client);
        var Label_ColumnHeader_ClientNumber                   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientNumber", language + client);
        var Label_ColumnHeader_TargetLow                    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_TargetLow", language + client);
        var Label_ColumnHeader_TargetMedium                 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_TargetMedium", language + client);
        var Label_ColumnHeader_TargetHigh                   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_TargetHigh", language + client);
        
        var Label_MenuItemField_ClientRelationshipNumber    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipNumber", language + client);
        var Label_MenuItemField_ReportType_OffsideAccounts  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ReportType_OffsideAccounts", language + client);
        var filterOperatorEqualTo = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client);
        
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //STEP #2 : Add and validate new columns
        Log.Message("STEP #2 : Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button. Add and check new columns for Offside Accounts in Reports tab.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        DisplayRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts);
        AddAndCheckNewColumns(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientNumber);
        
        //STEP #3 or #5 : Validations in Relationship Details
        Log.Message("STEP #3 or #5 : Go to Relationships module, select Relationship '" + relationshipNumber + "' (" + relationshipShortName + "). In Relationship Details at bottom, select client '" + clientNumber + "' and then click on Profile tab.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);        
        SelectRelationships(relationshipNumber);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "IsVisible", "IsActive"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "ShortName"], 10), "WPFControlText", cmpEqual, relationshipShortName);
        Get_RelationshipsClientsAccountsDetails().set_IsExpanded(true);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "Uid", "IsVisible", "WPFControlText"], ["CellValuePresenter", "ClientNumber", true, clientNumber], 30).Click();
        Get_ClientsDetails_TabProfile().Click();
        Get_ClientsDetails_TabProfile().WaitProperty("IsSelected", true, 60000);
        Get_ClientsDetails_TabProfile_TpProfile_DefaultExpander().set_IsExpanded(false);
        Get_ClientsDetails_TabProfile_TpProfile_ClientExpander().set_IsExpanded(true);
        
        CheckEquals(VarToStr(Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskLow().Text), clientInvRiskLow, "Client " + clientNumber + " KYC 'Inv Risk Low %'");
        CheckEquals(VarToStr(Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskMed().Text), clientInvRiskMed, "Client " + clientNumber + " KYC 'Inv Risk Med %'");
        CheckEquals(VarToStr(Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskHigh().Text), clientInvRiskHigh, "Client " + clientNumber + " KYC 'Inv Risk High %'");
        
        //STEP #4 or #6 : Validations of display in Risk & Compliance Management Offside Report.
        Log.Message("STEP #4 or #6 : Validate display in Risk & Compliance Management Offside Report.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ApplyFilterForRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts, Label_MenuItemField_ClientRelationshipNumber, filterOperatorEqualTo, relationshipNumber);
        var nbOfVisibleRows = GetGridVisibleRowsCount(Get_WinRQS_TabReports_DgvOffsideAccounts());
        CheckEquals(nbOfVisibleRows, 1, "The number of displayed row in Offside grid");
        
        if (nbOfVisibleRows > 0){
            //Check Management Level column
            Log.Message("Validate that the Management Level in Offside grid is '" + managementLevel + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ManagementLevel);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellMgmtLevel(1).WPFObject("XamTextEditor", "", 1).DisplayText, managementLevel, "The Management Level in Offside grid");
            
            //Check Client Relationship Number column
            Log.Message("Validate that the Client Relationship Number in Offside grid is '" + relationshipNumber + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientRelationshipNumber);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelNo(1).WPFObject("XamTextEditor", "", 1).DisplayText, relationshipNumber, "The Client Relationship Number in Offside grid");
            
            //Check Client Relationship Name column
            Log.Message("Validate that the Client Relationship Name in Offside grid is '" + clientRelationshipName + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientRelationshipName);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelName(1).WPFObject("XamTextEditor", "", 1).DisplayText, clientRelationshipName, "The Client Relationship Name in Offside grid");
            
            //Check Client Number column
            Log.Message("Validate that the Client Number in Offside grid is '" + clientNumberInOffsideReports + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientNumber);
            CheckEquals(VarToStr(Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientNo(1).WPFObject("XamTextEditor", "", 1).DisplayText), clientNumberInOffsideReports, "The Client Number in Offside grid");
            
            //Check Target Low Percent column
            Log.Message("Validate that the Target Low Percent in Offside grid is '" + clientInvRiskLow + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TargetLow);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetLow(1).WPFObject("XamNumericEditor", "", 1).DisplayText, clientInvRiskLow, "The Target Low Percent in Offside grid");
            
            //Check Target Medium Percent column
            Log.Message("Validate that the Target Medium Percent in Offside grid is '" + clientInvRiskMed + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TargetMedium);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetMedium(1).WPFObject("XamNumericEditor", "", 1).DisplayText, clientInvRiskMed, "The Target Medium Percent in Offside grid");
            
            //Check Target High Percent column
            Log.Message("Validate that the Target High Percent in Offside grid is '" + clientInvRiskMed + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TargetHigh);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetHigh(1).WPFObject("XamNumericEditor", "", 1).DisplayText, clientInvRiskHigh, "The Target High Percent in Offside grid");
        }
        
        //Close Croesus
        Get_WinRQS().Parent.Keys("[Esc]");
        CloseCroesus();
        
        //STEP #8 : Reconnect to validate new columns adding
        Log.Message("STEP #8 : Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button. Add and check new columns for Offside Accounts in Reports tab.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        DisplayRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts);
        AddAndCheckNewColumns(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientNumber);
        SetDefaultConfigurationForGrid(Get_WinRQS_TabReports_DgvOffsideAccounts());
        
        //Close Croesus
        Get_WinRQS().Parent.Keys("[Esc]");
        CloseCroesus();
        
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
    }
    finally {
        Log.UnlockEvents();
        Terminate_CroesusProcess();
    }

}
