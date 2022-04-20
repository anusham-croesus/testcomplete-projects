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

function CR1485_106_Acc_DateDef_GP_BookVl_DateTrans()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 17, language);
        message = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 22, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 23, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 24, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 26, language): GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 25, language);
        transactionDate = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 27, language);
        numbering = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 28, language);
        
        //Set the report parameters
        SetReportParameters(startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, costCalculation, transactionDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 31);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 34, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "106_FBNFISC_GAIN_PERTE", 35, language);
        
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