//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_036_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_036_Cli_DateModf_IncluAmort_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 35);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 41, language);
        currency = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 48, language);
        message = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 52, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 54, language);
        
        SetReportParameters(startDate, checkIncludeAmortizedIncome, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 60, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, checkIncludeAmortizedIncome, numbering);
        
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