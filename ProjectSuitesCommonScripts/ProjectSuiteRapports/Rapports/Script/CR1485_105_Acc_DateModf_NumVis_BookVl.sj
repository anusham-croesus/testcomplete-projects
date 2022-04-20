//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_105_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_105_Acc_DateModf_NumVis_BookVl()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 1, language);
        arrayOfReportsNames = reportName.split("|");
        accountNumber = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Summary (Year-End)" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 10, language);
        currency = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 17, language);
        message = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 23, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 25, language): GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 24, language);
        
        //Set the report parameters
        SetReportParameters(startDate, endDate, numbering, costCalculation);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Summary (Year-End)" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "105_FBNFISC_SUMMARY", 32, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, numbering, costCalculation);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}