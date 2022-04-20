//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_106_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_106_Acc_DateModf_GP_BookVl_DateSettle_NumVis()
{
    Log.Message("Jira BNC-1498");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 40);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 42);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 45, language);
        sortBy = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 46, language);
        currency = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 47, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 48, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 49, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 50, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 51, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 52, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 53, language);
        message = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 54, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 57, language);
        endDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 58, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 59, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 60, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 62, language): GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 61, language);
        transactionDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 63, language);
        numbering = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 64, language);
        
        //Set the report parameters
        SetReportParameters(startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, costCalculation, transactionDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 67);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 70, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 71, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, costCalculation, transactionDate, numbering);
        
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