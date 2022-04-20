//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_032_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_032_Acc_DateModf_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 64);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 66);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 69, language);
        sortBy = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 70, language);
        currency = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 71, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 72, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 73, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 74, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 75, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 76, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 77, language);
        message = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 78, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 81, language);
        numbering = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 82, language);
        
        SetReportParameters(asOfDate, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 85);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 88, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "032_GRAPH_DIST_BM", 89, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, numbering);
        
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