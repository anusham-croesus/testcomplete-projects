﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_052_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_052_Acc_DateModf_PieGraph_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 66);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 68);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 71, language);
        sortBy = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 72, language);
        currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 73, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 74, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 75, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 76, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 77, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 78, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 79, language);
        message = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 80, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 83, language);
        type = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 84, language);
        numbering = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 85, language);
        
        SetReportParameters(asOfDate, type, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 92, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, type, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}