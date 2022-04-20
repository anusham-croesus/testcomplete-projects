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

function CR1485_050_Sec_All_Limt25()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 36);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 39, language);
        sortBy = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 40, language);
        currency = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 41, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 42, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 43, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 44, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 45, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 46, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 47, language);
        message = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 48, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkAllRecords = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 51, language);
        limit = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 52, language);
        
        SetReportParameters(checkAllRecords, limit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 55);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 58, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 59, language);
        
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