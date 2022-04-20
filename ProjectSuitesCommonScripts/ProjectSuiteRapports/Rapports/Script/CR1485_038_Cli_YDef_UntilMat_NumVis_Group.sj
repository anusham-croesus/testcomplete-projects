//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_038_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_038_Cli_YDef_UntilMat_NumVis_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 35);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 41, language);
        currency = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 48, language);
        message = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 52, language);
        checkUntilMaturity = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 54, language);
        
        SetReportParameters(year, checkUntilMaturity, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 60, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, checkUntilMaturity, numbering);
        
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