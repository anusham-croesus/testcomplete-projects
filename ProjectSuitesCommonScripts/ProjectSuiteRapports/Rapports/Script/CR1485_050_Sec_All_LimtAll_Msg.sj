//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_050_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_050_Sec_All_LimtAll_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 10, language);
        currency = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 17, language);
        message = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkAllRecords = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 21, language);
        limit = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 22, language);
        
        SetReportParameters(checkAllRecords, limit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 25);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 28, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 29, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkAllRecords, limit);
        
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