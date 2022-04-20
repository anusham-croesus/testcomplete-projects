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

function CR1485_062_Portf_DateDef_BookVl_TheoVl()
{
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 2, language);
        clientNumber = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 72);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        //Drag the client to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 74);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 79, language);
        asOfDate = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 89, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 77, language);
        sortBy = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 78, language);
        //currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 79, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 80, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 81, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 82, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 83, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 84, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 85, language);
        message = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 86, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 89, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 90, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 91, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 93, language): GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 92, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 94, language);
                
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 97);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 100, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 100, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 101, language);
        
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