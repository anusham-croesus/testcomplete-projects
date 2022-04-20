//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_023_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_023_Acc_Both()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 10, language);
        currency = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 17, language);
        message = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        sectionsToInclude = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 21, language);
        
        SetReportParameters(sectionsToInclude);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 24);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "023_ACC_SRV_Code", 28, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(sectionsToInclude);
        
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