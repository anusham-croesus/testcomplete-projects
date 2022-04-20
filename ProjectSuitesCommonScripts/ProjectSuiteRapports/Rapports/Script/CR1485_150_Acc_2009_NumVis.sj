//USEUNIT CR1485_150_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_150_Acc_2009_NumVis()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    Log.Message("Bug JIRA CROES-10781 : Le rapport 150 crash avec un user != UNI00");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 64);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select Accounts
        SelectAccounts(accountsNumbers.split("|"));
                
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 66);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 69, language);
        sortBy = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 70, language);
        currency = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 71, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 72, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 73, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 74, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 75, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 76, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 77, language);
        message = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 78, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 81, language);
        numbering = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 82, language);
        
        SetReportParameters(year, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 85);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 88, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "150_EXPECT_TAX_SLIPS_NRA", 89, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, numbering);
        
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