﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_019_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_019_Agn_DateModf()
{
    if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
        CR1485_019_Agn_DateModf_Steps(CR1485_REPORTS_LANGUAGE);
    else {
        CR1485_019_Agn_DateModf_Steps("english");
        CR1485_019_Agn_DateModf_Steps("french");
    }
}



function CR1485_019_Agn_DateModf_Steps(reportGenerationLanguage)
{
    try {
        tempLanguage = language;
        Global_variables.language = reportGenerationLanguage;
    
        //Activate Prefs
        ActivatePrefs();
        
        reportName = GetData(filePath_ReportsCR1485, "019_TASK", 1, language);
        
        
        //Login and open the Agenda
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_Toolbar_BtnAgenda().Click();
        
        
        //************************* Generate report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "019_TASK", 6, language);
        
        //Open Reports window and Select report
        Get_WinAgenda_BtnReport().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "019_TASK", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "019_TASK", 10, language);
        currency = GetData(filePath_ReportsCR1485, "019_TASK", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "019_TASK", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "019_TASK", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "019_TASK", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "019_TASK", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "019_TASK", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "019_TASK", 17, language);
        message = GetData(filePath_ReportsCR1485, "019_TASK", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "019_TASK", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "019_TASK", 22, language);
        
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