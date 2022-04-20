//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_110_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_110_Acc_DateModf_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 1, language);
        arrayOfReportsNames = reportName.split("|");
        accountsNumbers = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 62);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 64);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "PIMG Cover Page" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 67, language);
        sortBy = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 68, language);
        currency = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 69, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 70, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 71, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 72, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 73, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 74, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 75, language);
        message = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 76, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 79, language);
        
        //Set the report parameters
        SetReportParameters(asOfDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 82);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "PIMG Cover Page" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 85, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 86, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate);
        
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