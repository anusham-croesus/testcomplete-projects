//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_015_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_015_Cli_NumHid()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 1, language);
        arrayOfReportsNames = reportName.split("|");
        clientNumber = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 33);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 35);
        
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
        destination = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 38, language);
        sortBy = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 39, language);
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 40, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 41, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 42, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 43, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 44, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 45, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 46, language);
        message = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 47, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        numbering = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 50, language);
        
        //Set the report parameters
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 53);
        
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
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 56, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 57, language);
        
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