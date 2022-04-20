//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_017_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_017_Sec_InvstCap()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "017_HOLDERS", 1, language);
        securitiesNames = GetData(filePath_ReportsCR1485, "017_HOLDERS", 35, language);
        arrayOfSecuritiesNames = securitiesNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Select securities
        SelectSecurities(arrayOfSecuritiesNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "017_HOLDERS", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "017_HOLDERS", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "017_HOLDERS", 41, language);
        currency = GetData(filePath_ReportsCR1485, "017_HOLDERS", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "017_HOLDERS", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "017_HOLDERS", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "017_HOLDERS", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "017_HOLDERS", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "017_HOLDERS", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "017_HOLDERS", 48, language);
        message = GetData(filePath_ReportsCR1485, "017_HOLDERS", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkIncludePortfolioValue = GetData(filePath_ReportsCR1485, "017_HOLDERS", 52, language);
        costCalculation = GetData(filePath_ReportsCR1485, "017_HOLDERS", 53, language);
        
        //Set the report parameters
        SetReportParameters(checkIncludePortfolioValue, costCalculation);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "017_HOLDERS", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "017_HOLDERS", 59, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "017_HOLDERS", 60, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkIncludePortfolioValue, costCalculation);
        
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