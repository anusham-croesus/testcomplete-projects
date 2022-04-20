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

function CR1485_062_Acc_DateModf_Graph_BookVl_TheoVl_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 2, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 38);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 40);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 43, language);
        sortBy = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 44, language);
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 45, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 46, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 47, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 48, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 49, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 50, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 51, language);
        message = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 52, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 55, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 56, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 57, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 59, language): GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 58, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 60, language);
                
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 63);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 66, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "062_EVAL_SIMPLE_WEB", 67, language);
        
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