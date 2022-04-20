//USEUNIT CR1958_2_Helper


/**
    Description : Steps #7 (Management Level = Client Profile). Validate if the Plugin and the new column added in Offside Account Report Client Relationship number,Client Relationship Name,Management level)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653
    Steps #7 (Management Level = Client Profile)
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6653_6073_Validate_in_OffsideAccountReport_OffsideTotalValueLogic_MgmtLevel_ClientProfile()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653", "Croes-6653 #7 - Client Profile : Validate the logic of total value in the accounts offside changed --> CR1958_2_6653_6073_Validate_in_OffsideAccountReport_OffsideTotalValueLogic_MgmtLevel_ClientProfile()");
    
    var managementLevel           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ManagementLevel_ClientProfile", language + client);
    var relationshipNumber        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_OffsideTotalValueLogic_MgmtLevel_ClientProfile_RelationshipNumber", language + client);
    var relationshipTotalValue    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_OffsideTotalValueLogic_MgmtLevel_ClientProfile_RelationshipTotalValue", language + client);
    var clientNumber              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_OffsideTotalValueLogic_MgmtLevel_ClientProfile_ClientNumber", language + client);
    var clientTotalValue          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_OffsideTotalValueLogic_MgmtLevel_ClientProfile_ClientTotalValue", language + client);
    
    CR1958_2_6653_6073_Validate_in_OffsideAccountReport_OffsideTotalValueLogic(managementLevel, relationshipNumber, relationshipTotalValue, clientNumber, clientTotalValue);
}






function CR1958_2_6653_6073_Validate_in_OffsideAccountReport_OffsideTotalValueLogic(managementLevel, relationshipNumber, relationshipTotalValue, clientNumber, clientTotalValue)
{
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        
        var Label_ColumnHeader_ManagementLevel              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ManagementLevel", language + client);
        var Label_ColumnHeader_ClientRelationshipNumber     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipNumber", language + client);
        var Label_ColumnHeader_TotalValue                   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_TotalValue", language + client);
        var Label_MenuItemField_ClientRelationshipNumber    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipNumber", language + client);
        var Label_MenuItemField_ReportType_OffsideAccounts  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ReportType_OffsideAccounts", language + client);
        var filterOperatorEqualTo = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client);
        
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        Log.Message("STEP #2 : Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button. Add and check new columns for Offside Accounts in Reports tab.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        DisplayRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts);
        AddAndCheckNewColumns(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TotalValue);
        
        Log.Message("STEP #7 : Validate the logic of total value in the accounts offside changed for Management Level = " + managementLevel + ".", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ApplyFilterForRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts, Label_MenuItemField_ClientRelationshipNumber, filterOperatorEqualTo, relationshipNumber);
        var nbOfVisibleRows = GetGridVisibleRowsCount(Get_WinRQS_TabReports_DgvOffsideAccounts());
        CheckEquals(nbOfVisibleRows, 1, "The number of displayed row in Offside grid")
        
        if (nbOfVisibleRows > 0){
            //Check Management Level column
            Log.Message("Validate if the Management Level in Offside grid is '" + managementLevel + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ManagementLevel);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellMgmtLevel(1).WPFObject("XamTextEditor", "", 1).DisplayText, managementLevel, "The Management Level in Offside grid");
        
            //Check Client Total Value column
            Log.Message("Validate if the Client Relationship Total Value in Offside grid is '" + relationshipTotalValue + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TotalValue);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellTotalValue(1).WPFObject("XamNumericEditor", "", 1).DisplayText, relationshipTotalValue, "The Client Relationship Total Value in Offside grid");
        
            //Check Client Relationship Number column
            Log.Message("Validate if the Client Relationship Number in Offside grid is '" + relationshipNumber + "'.");
            CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientRelationshipNumber);
            CheckEquals(Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelNo(1).WPFObject("XamTextEditor", "", 1).DisplayText, relationshipNumber, "The Client Relationship Number in Offside grid");
        
            //Check Client Total Value in Relationship Details
            Log.Message("Validate if the Client '" + clientNumber + "' Total Value in Relationship Details is '" + clientTotalValue + "'.");
            if (!Get_ModulesBar_BtnRelationships().VisibleOnScreen){
                var left = Get_ModulesBar_BtnRelationships().Left + Get_ModulesBar_BtnRelationships().Width + 5;
                var top = Get_WinRQS().Parent.Top;
                var width = Get_WinRQS().Parent.Width - left;
                var height = Get_WinRQS().Parent.Height;
                Get_WinRQS().Parent.Restore();
                CheckIfColumnsHeadersAreDisplayedInGrid(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_ClientRelationshipNumber);
                Get_WinRQS().Parent.Position(left, top, width, height);
            }
        
            Drag(Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelNo(1), Get_ModulesBar_BtnRelationships());
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 60000);
            Get_RelationshipsClientsAccountsDetails().set_IsExpanded(true);
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "Uid", "IsVisible", "WPFControlText"], ["CellValuePresenter", "ClientNumber", true, clientNumber], 30).Click();
            Get_ClientsDetails_TabInfo().Click();
            Get_ClientsDetails_TabInfo().WaitProperty("IsSelected", true, 60000);
            Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValue().HoverMouse(1, 1);
            CheckEquals(VarToStr(Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValue().Text), clientTotalValue, "Client '" + clientNumber + "' Total Value in Relationship Details");
            
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        }
        
        //Fermer Croesus
        Get_WinRQS().Parent.Keys("[Esc]");
        CloseCroesus();
        
        Log.Message("STEP #8 : Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button. Add and check new columns for Offside Accounts in Reports tab.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        DisplayRiskAndComplianceReportType(Label_MenuItemField_ReportType_OffsideAccounts);
        AddAndCheckNewColumns(Get_WinRQS_TabReports_DgvOffsideAccounts(), Label_ColumnHeader_TotalValue);
        SetDefaultConfigurationForGrid(Get_WinRQS_TabReports_DgvOffsideAccounts());
        
        //Fermer Croesus
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
