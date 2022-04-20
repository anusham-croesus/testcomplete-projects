//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_015_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_015_Acc_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 1, language);
        arrayOfReportsNames = reportName.split("|");
        accountNumber = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 62);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 64);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Disclaimer report and move it to the top
        if (client == "CIBC") //PREF_USE_DISCLAIMER_COMPILATION : Permet d'empêcher ou non le déplacement du rapport dans la liste des rapports courants
            CheckIfCurrentReportIsStuckedAtBottom(Trim(arrayOfReportsNames[0]));
        else
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 67, language);
        sortBy = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 68, language);
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 69, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 70, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 71, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 72, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 73, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 74, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 75, language);
        message = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 76, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        numbering = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 79, language);
        
        //Set the report parameters
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 82);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Disclaimer report and move it to the top
        if (client == "CIBC") //PREF_USE_DISCLAIMER_COMPILATION : Permet d'empêcher ou non le déplacement du rapport dans la liste des rapports courants
            CheckIfCurrentReportIsStuckedAtBottom(Trim(arrayOfReportsNames[0]));
        else
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 85, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 86, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(numbering);
        
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