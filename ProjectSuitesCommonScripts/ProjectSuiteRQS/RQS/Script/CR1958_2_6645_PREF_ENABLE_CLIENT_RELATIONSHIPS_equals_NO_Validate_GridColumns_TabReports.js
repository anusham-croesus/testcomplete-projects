//USEUNIT CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #4 : Validate Grid Columns in Reports Tab)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #4 : Validate Grid Columns in Reports Tab
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_GridColumns_TabReports()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #4 - Validate Grid Columns in Reports Tab : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_GridColumns_TabReports()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var Label_ColumnHeader_ManagementLevel              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ManagementLevel", language + client);
        var Label_ColumnHeader_ClientRelationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipName", language + client);
        var Label_ColumnHeader_ClientRelationshipNumber     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipNumber", language + client);
        var count_NumberOfReportTypes                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Count_WinRiskAndComplianceManager_TabReports_NumberOfReportTypes", language + client);
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Preconditions
        CR1958_2_6645_PrepareDB();
        
        //Se loguer avec KEYNEJ, Cliquer sur le bouton Risk and Compliance Manager' (bouton en forme d'oeil)
        Log.Message("Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        
        //STEP #4 :
        //Cliquer sur l'onglet Reports --> Cliquer sur Display Report --> Aller sur l'entête des colonnes --> Right clic
        //Validate If 'Mgmt level' , 'Client rel. no.'  and  'Client rel. name' are not available in Grid of The Reports.
        var arrayOf_ReportsGrid_UnexpectedColumsHeaders = [Label_ColumnHeader_ManagementLevel, Label_ColumnHeader_ClientRelationshipName, Label_ColumnHeader_ClientRelationshipNumber];
        Log.Message("STEP #4 : Validate that the following columns are not available in Grid of The Reports. : " + arrayOf_ReportsGrid_UnexpectedColumsHeaders, arrayOf_ReportsGrid_UnexpectedColumsHeaders.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var nbOfTries = 0;
        do {
            Get_WinRQS_TabReports().Click();
        } while (++nbOfTries < 3 && !Get_WinRQS_TabReports().WaitProperty("IsSelected", true, 40000))
        
        //Retrieve all Report Types from Report Type combobox submenu
        Get_WinRQS_TabReports_CmbReportType().Click();
        var nbOfTries = 0;
        while (++nbOfTries < 5 && !Get_SubMenus().Exists)
            Get_WinRQS_TabReports_CmbReportType().Click();
        
        var arrayOfComboBoxItem = Get_SubMenus().FindAllChildren(["ClrClassName", "IsVisible"], ["ComboBoxItem", true]).toArray();
        var arrayOfReportTypes = [];
        for (var itemIndex = 0; itemIndex < arrayOfComboBoxItem.length; itemIndex++)
            arrayOfReportTypes.push(VarToStr(arrayOfComboBoxItem[itemIndex].FindChild(["ClrClassName", "IsVisible"], ["TextBlock", true], 10).WPFControlText));
        
        //Validate the number of Report Types retrieved
        if (!CheckEquals(arrayOfReportTypes.length, count_NumberOfReportTypes, "The number of Report Types in the Report Type combobox submenu")){
            if (arrayOfComboBoxItem.length == 0 || arrayOfReportTypes.length == 0){
                Log.Warning("No ComboBoxItem found in the Report Type combobox submenu.", "", pmHigher, null, Sys.Desktop.Picture());
                CheckIfColumnsHeadersAreNotAvailableForTabReportsGrid(arrayOf_ReportsGrid_UnexpectedColumsHeaders);
            }
        }
        
        //Peform validation for each retrieved Report Type
        for (var reportTypeIndex = 0; reportTypeIndex < arrayOfReportTypes.length; reportTypeIndex++){
            var reportType = arrayOfReportTypes[reportTypeIndex];
            Log.AppendFolder("For Report Type = " + reportType, "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
            CheckIfColumnsHeadersAreNotAvailableForTabReportsGrid(arrayOf_ReportsGrid_UnexpectedColumsHeaders, reportType);
            Log.PopLogFolder();
        }
        
        //Close Croesus
        Get_WinRQS().Parent.Keys("[Esc]");
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        CR1958_2_6645_RestoreDB();
    }
}



function CheckIfColumnsHeadersAreNotAvailableForTabReportsGrid(arrayOf_ReportsGrid_UnexpectedColumsHeaders, reportType)
{
    if (reportType != undefined)
        SelectComboBoxItem(Get_WinRQS_TabReports_CmbReportType(), reportType);
    
    var nbOfTries = 0;
    do {
        Delay(1000);
        Get_WinRQS_TabReports_BtnDisplayReport().Click();
        
        SetAutoTimeOut(3000);
        if (Get_DlgWarning().Exists){
            if (!Get_DlgWarning_LblTheFilterYouHaveAppliedContainsNoData().Exists)
                Log.Error("There was an unexpected Warning dialog box.");
            
            Get_DlgWarning_BtnOK().Click();
        }
        RestoreAutoTimeOut();
    
        WaitObject(Get_WinRQS(), ["Uid", "IsVisible"], ["ReportsControl_2034", true]);
        Get_WinRQS_TabReports_ReportsControl().Refresh();
        var gridRecordListControl = Get_WinRQS_TabReports_ReportsControl().FindChildEx(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", 1, true], 10, true, 10000);
    } while (++nbOfTries < 5 && !gridRecordListControl.Exists)
    
    CheckIfColumnsHeadersAreNotAvailableForGrid(gridRecordListControl, arrayOf_ReportsGrid_UnexpectedColumsHeaders);
}
