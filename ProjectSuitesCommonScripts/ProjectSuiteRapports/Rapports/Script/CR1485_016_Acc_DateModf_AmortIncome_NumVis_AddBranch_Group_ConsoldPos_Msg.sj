//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_016_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_016_Acc_DateModf_AmortIncome_NumVis_AddBranch_Group_ConsoldPos_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "016_REVENUES", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "016_REVENUES", 68);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "016_REVENUES", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "016_REVENUES", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "016_REVENUES", 74, language);
        currency = GetData(filePath_ReportsCR1485, "016_REVENUES", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "016_REVENUES", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "016_REVENUES", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "016_REVENUES", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "016_REVENUES", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "016_REVENUES", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "016_REVENUES", 81, language);
        message = GetData(filePath_ReportsCR1485, "016_REVENUES", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "016_REVENUES", 85, language);
        endDate = GetData(filePath_ReportsCR1485, "016_REVENUES", 86, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "016_REVENUES", 87, language);
        numbering = GetData(filePath_ReportsCR1485, "016_REVENUES", 88, language);
        
        SetReportParameters(startDate, endDate, checkIncludeAmortizedIncome, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "016_REVENUES", 91);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "016_REVENUES", 94, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "016_REVENUES", 95, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkIncludeAmortizedIncome, numbering);
        
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