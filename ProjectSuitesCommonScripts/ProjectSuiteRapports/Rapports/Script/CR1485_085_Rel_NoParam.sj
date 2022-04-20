//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_085_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_085_Rel_NoParam()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 17, language);
        message = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 26, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "085_FBNGP_Q_GAIN_PERTE", 27, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
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