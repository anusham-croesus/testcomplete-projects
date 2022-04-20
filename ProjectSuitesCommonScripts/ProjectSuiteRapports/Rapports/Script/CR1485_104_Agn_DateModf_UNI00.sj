//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_104_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_104_Agn_DateModf_UNI00()
{
    if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
        CR1485_104_Agn_DateModf_UNI00_Steps(CR1485_REPORTS_LANGUAGE);
    else {
        CR1485_104_Agn_DateModf_UNI00_Steps("english");
        CR1485_104_Agn_DateModf_UNI00_Steps("french");
    }
}



function CR1485_104_Agn_DateModf_UNI00_Steps(reportGenerationLanguage)
{
    try {
        tempLanguage = language;
        Global_variables.language = reportGenerationLanguage;
        
        reportName = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 1, language);
        
    
        userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    
        //Activate Prefs
        ActivatePrefs(userNameUNI00);
    
        //Login with user GP1859, open the Agenda
        Login(vServerReportsCR1485, userNameUNI00, passwordUNI00, language);
        Get_Toolbar_BtnAgenda().Click();
    
    
        //************************* Generate report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 44, language);
    
        //Open Reports window and Select report
        Get_WinAgenda_BtnReport().Click();
        WaitReportsWindow();
        SelectReports(reportName);
    
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 47, language);
        sortBy = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 48, language);
        currency = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 49, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 50, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 51, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 52, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 53, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 54, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 55, language);
        message = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 56, language);
    
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
    
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 59, language);
        endDate = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 60, language);
    
        SetReportParameters(startDate, endDate);
    
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        //Close Application
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Global_variables.language = tempLanguage;
        Terminate_CroesusProcess();
    }
}