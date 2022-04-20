﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_091_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_091_Rel_NoParam_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 10, language);
        currency = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 17, language);
        message = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 26, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "091_FBNGP_Q_ASSETMIX", 27, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
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