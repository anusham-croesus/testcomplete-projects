//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_048_Cli_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 1, language);
        var clientNumber = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 218);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Activer CHECK DIGIT
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485)
        
        //Login and goto Clients module and Select the Client
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 220);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 223, language);
        var sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 224, language);
        var currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 225, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 226, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 227, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 228, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 229, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 230, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 231, language);
        var message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 232, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 235, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 236, language);
        var asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 237, language).split(separatorChar);
        CompareProperty(asOfDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 238, language).split(separatorChar);
        CompareProperty(checkIncludeGraph.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 239, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 240, language).split(separatorChar);
        CompareProperty(checkComparative.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 241, language).split(separatorChar);
        CompareProperty(checkGroupByRegion.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 242, language).split(separatorChar);
        CompareProperty(checkGroupByIndustryCode.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 243, language).split(separatorChar);
        CompareProperty(groupByIndustryCode.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 245, language).split(separatorChar): GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 244, language).split(separatorChar);
        CompareProperty(costCalculation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 246, language).split(separatorChar);
        CompareProperty(checkCostDisplayedTheoreticalValue.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 247, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 248, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 249, language).split(separatorChar);
        CompareProperty(checkFundBreakdownClassBreakdown.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 250, language).split(separatorChar);
        CompareProperty(checkFundBreakdownAppendix.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 251, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], checkGroupByRegion[i], checkGroupByIndustryCode[i], groupByIndustryCode[i], costCalculation[i], checkCostDisplayedTheoreticalValue[i], assetAllocation[i], customAllocation[i], checkFundBreakdownClassBreakdown[i], checkFundBreakdownAppendix[i], numbering[i]);
        }
        
        //Configurer les options du rapport
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);

        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 254);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], checkGroupByRegion[i], checkGroupByIndustryCode[i], groupByIndustryCode[i], costCalculation[i], checkCostDisplayedTheoreticalValue[i], assetAllocation[i], customAllocation[i], checkFundBreakdownClassBreakdown[i], checkFundBreakdownAppendix[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 257, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 258, language);
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
               
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
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", null, vServerReportsCR1485)
    }
    
}
