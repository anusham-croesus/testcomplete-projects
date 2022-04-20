//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_062_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_062_Cli_DateModf_Graph_BookVl_TheoVl_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 2, language);
        clientNumber = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 10, language);
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 17, language);
        message = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 21, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 22, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 23, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 25, language): GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 24, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 26, language);
                
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 29);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 32, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 33, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue);
        
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