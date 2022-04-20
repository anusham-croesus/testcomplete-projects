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

function CR1485_036_Rel_DateModf_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 10, language);
        currency = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 17, language);
        message = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 21, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 23, language);
        
        SetReportParameters(startDate, checkIncludeAmortizedIncome, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "036_GRAPH_ANNIC", 30, language);
        
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