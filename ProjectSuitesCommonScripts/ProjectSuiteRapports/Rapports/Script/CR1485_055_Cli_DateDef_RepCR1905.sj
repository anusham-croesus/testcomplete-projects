//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_055_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_055_Cli_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 157);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Activer CHECK DIGIT
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485)
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 159);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 162, language);
        sortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 163, language);
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 164, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 165, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 166, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 167, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 168, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 169, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 170, language);
        message = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 171, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 174, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 175, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 176, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 177, language);
        nameOrFullName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 178, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 179, language);
        customAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 180, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 181, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 182, language);
        numbering = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 183, language);
        
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 186);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 189, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 190, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", null, vServerReportsCR1485)
    }
    
}