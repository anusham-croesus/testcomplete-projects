//USEUNIT CR1485_Common_functions



function CR1485_PreparationBD_Performance()
{
    try {
        Log.Message("CR1485_PreparationBD_Performance()");
        ActivatePrefsForPerformanceSummary();
        ExecuteSSHScriptForPerformanceSummary();
    }
    catch(exception_CR1485_PreparationBD_Performance) {
        Log.Error("Exception from CR1485_PreparationBD_Performance(): " + exception_CR1485_PreparationBD_Performance.message, VarToStr(exception_CR1485_PreparationBD_Performance.stack));
        exception_CR1485_PreparationBD_Performance = null;
        RestartServices(vServerReportsCR1485);
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function ActivatePrefsForPerformanceSummary()
{
    Log.Message("Activate Prefs For Performance Summary.");
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
    
    //Activer les prefs pour avoir toutes les cases à cocher du groupbox "Performance - Frais" activées
    EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
    
    //Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PERF_OBJINV", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_PERFSUMMARY_OBJ", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}


//For Performance Summary (Reports 76 and 78)
function ExecuteSSHScriptForPerformanceSummary()
{
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    Log.Message("Check if calendar is disabled for Performance Summary Report ; if so, 'cfLoader -PerformanceSummary' will be executed.", "", pmNormal, logAttributes);
    
    var performanceSummaryReportName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 1, language);
    var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
    
    Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
    Delay(5000);
    
    var arrayOfModulesButtons = [Get_ModulesBar_BtnRelationships(), Get_ModulesBar_BtnClients(), Get_ModulesBar_BtnAccounts()];
    var isCalendarDisabled = null;
    for (var j = 0; j < arrayOfModulesButtons.length; j++){
        var isCalendarDisabledForModule = IsPeriodEndDateCalendarDisabledForReport(performanceSummaryReportName, arrayOfModulesButtons[j])
        if (isCalendarDisabledForModule === true){
            isCalendarDisabled = true;
            break;
        }
        else if (isCalendarDisabledForModule !== false){
            isCalendarDisabled = null;
            break;
        }
        else {
            isCalendarDisabled = false;
        }
    }
    
    if (isCalendarDisabled === false)
        Log.Message("Calendar is not disabled for Performance Summary Report ; thus, 'cfLoader -PerformanceSummary' will not be executed.", "", pmNormal, logAttributes);
    else if (isCalendarDisabled === true){
        Log.Message("Calendar is disabled for Performance Summary Report ; thus, 'cfLoader -PerformanceSummary' will be executed.", "", pmNormal, logAttributes);
        var sshCommand = "cfLoader -PerformanceSummary -Firm=FIRM_1";
        var outputSuccessRegEx = '^.*INFO  \- Processing Summary Performance calculation for all accounts, clients and relationships ended: Success Elapsed time: \\d\\d:\\d\\d:\\d\\d\\.\\d\\d.*';
        ExecuteSSHCommand("cfLoader_PerformanceSummary_ForReports_076_078", vServerReportsCR1485, sshCommand, null, outputSuccessRegEx);
        RestartServices(vServerReportsCR1485);
        return Terminate_CroesusProcess();
    }
    else
        Log.Message("Unable to determine if Calendar is disabled for Performance Summary Report ; 'cfLoader -PerformanceSummary' will not be executed.", "", pmNormal, logAttributes);

    CloseCroesus();
}



function IsPeriodEndDateCalendarDisabledForReport(reportDisplayedName, moduleButton)
{
    var isCalendarDisabled = null;

    var numTry = 0;
    do {
        Delay(5000);
        moduleButton.Click();
    } while (++numTry < 3 && !moduleButton.WaitProperty("IsChecked", true, 100000))
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    var numTry = 0;
    do {
        Delay(5000);
        Get_Toolbar_BtnReportsAndGraphs().Click();
    } while (++numTry < 3 && !WaitReportsWindow())
    
    SelectReports(reportDisplayedName);
    
    var reportsWindowTitle = Get_WinReports().Title.OleValue;
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000))
        Log.Error("The Parameters button is disabled!");
    else {
        Delay(3000);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 60000);
        WaitReportParametersWindow(60000);
        var parametersWindowTitle = VarToStr(Get_WinParameters().Title);
    
        var numTry = 0;
        do {
            Delay(5000);
            Get_WinParameters_GrpPeriod_DtpEndDate().Click();
            Sys.Keys("[Tab][Enter]");
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        Get_Calendar().WaitProperty("VisibleOnScreen", true, 6000);
        
        var expectedDaysItemsCount = 42;
        Get_Calendar_LstDays().WaitProperty("wItemCount", expectedDaysItemsCount, 6000);
        var arrayOfDayListBoxItem = Get_Calendar_LstDays().FindAllChildren(["ClrClassName", "IsVisible"], ["ListBoxItem", true], 10).toArray();
        if (arrayOfDayListBoxItem.length != expectedDaysItemsCount)
            CheckEquals(arrayOfDayListBoxItem.length, expectedDaysItemsCount, "The number of days items found in the month calendar");
        for (var i = 1; i < arrayOfDayListBoxItem.length; i++){
            if (!arrayOfDayListBoxItem[i].IsEnabled)
                isCalendarDisabled = true;
            else {
                isCalendarDisabled = false;
                break;
            }
        }
        
        Get_Calendar_BtnCancel().Click();
        Get_WinParameters_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", parametersWindowTitle]);
    }
    
    Get_WinReports_BtnClose().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle])
    
    return isCalendarDisabled;
}
