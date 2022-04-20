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

function CR1485_104_Agn_DateModf_LINCOA()
{
    if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
        CR1485_104_Agn_DateModf_LINCOA_Steps(CR1485_REPORTS_LANGUAGE);
    else {
        CR1485_104_Agn_DateModf_LINCOA_Steps("english");
        CR1485_104_Agn_DateModf_LINCOA_Steps("french");
    }
}



function CR1485_104_Agn_DateModf_LINCOA_Steps(reportGenerationLanguage)
{
    try {
        tempLanguage = language;
        Global_variables.language = reportGenerationLanguage;
        
        reportName = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 1, language);
        
    
        userNameLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
        passwordLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw");
    
        //Activate Prefs
        ActivatePrefs(userNameLINCOA);
    
        //Login with user GP1859, open the Agenda
        Login(vServerReportsCR1485, userNameLINCOA, passwordLINCOA, language);
        Get_Toolbar_BtnAgenda().Click();
    
    
        //************************* Generate report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 25, language);
    
        //Open Reports window and Select report
        Get_WinAgenda_BtnReport().Click();
        WaitReportsWindow();
        SelectReports(reportName);
    
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 28, language);
        sortBy = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 29, language);
        currency = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 31, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 32, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 33, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 34, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 35, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 36, language);
        message = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 37, language);
    
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
    
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 40, language);
        endDate = GetData(filePath_ReportsCR1485, "104_FILE_PROCESSING", 41, language);
    
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