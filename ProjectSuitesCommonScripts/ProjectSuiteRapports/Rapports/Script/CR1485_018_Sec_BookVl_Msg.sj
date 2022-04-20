//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_018_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_018_Sec_BookVl_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 2, language);
        securitiesNames = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 4, language);
        arrayOfSecuritiesNames = securitiesNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Select securities
        SelectSecurities(arrayOfSecuritiesNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 10, language);
        currency = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 17, language);
        message = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkIncludePortfolioValue = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 21, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 23, language): GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 22, language);
        
        SetReportParameters(checkIncludePortfolioValue, costCalculation);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "018_HOLDERS_WEB", 30, language);
        
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
