//USEUNIT CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_003_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    
    var reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 373);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 410);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
    CR1485_CR1905_Acc_DateDef_RepCR1905(reportName, reportFileName_English, reportFileName_French);
}



function CR1485_CR1905_Acc_DateDef_RepCR1905(reportName, reportFileName_English, reportFileName_French)
{
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var accountNumber = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 371);
        
                
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        
        //Activer CHECK DIGIT
        Activate_Inactivate_CheckDigit(userNameReportsCR1485, "YES", accountNumber, null);
        
        //Login and goto Accounts module and Select the account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = reportFileName_English;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 376, language);
        var sortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 377, language);
        var currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 378, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 379, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 380, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 381, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 382, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 383, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 384, language);
        var message = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 385, language);
                
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 388, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 389, language);
        var asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 390, language).split(separatorChar);
        CompareProperty(asOfDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkIncludeGraph = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 391, language).split(separatorChar));
        CompareProperty(checkIncludeGraph.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 392, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkComparative = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 393, language).split(separatorChar));
        CompareProperty(checkComparative.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGroupByRegion = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 394, language).split(separatorChar));
        CompareProperty(checkGroupByRegion.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGroupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 395, language).split(separatorChar));
        CompareProperty(checkGroupByIndustryCode.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var groupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 396, language).split(separatorChar));
        CompareProperty(groupByIndustryCode.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGroupByAccountCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 397, language).split(separatorChar));
        CompareProperty(checkGroupByAccountCurrency.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 399, language).split(separatorChar): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 398, language).split(separatorChar);
        CompareProperty(costCalculation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkCostDisplayedTheoreticalValue = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 400, language).split(separatorChar));
        CompareProperty(checkCostDisplayedTheoreticalValue.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 401, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 402, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 403, language).split(separatorChar));
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkFundBreakdownClassBreakdown = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 404, language).split(separatorChar));
        CompareProperty(checkFundBreakdownClassBreakdown.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkFundBreakdownAppendix = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 405, language).split(separatorChar));
        CompareProperty(checkFundBreakdownAppendix.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 406, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 407, language).split(separatorChar);
        CompareProperty(parametersSortBy.length, cmpEqual, nbOfReportOcurrences, true, lmError);

        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], checkGroupByRegion[i], checkGroupByIndustryCode[i], groupByIndustryCode[i], checkGroupByAccountCurrency[i], costCalculation[i], checkCostDisplayedTheoreticalValue[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkFundBreakdownClassBreakdown[i], checkFundBreakdownAppendix[i], numbering[i], parametersSortBy[i]);
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
        
        var reportFileName = reportFileName_French;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], checkGroupByRegion[i], checkGroupByIndustryCode[i], groupByIndustryCode[i], checkGroupByAccountCurrency[i], costCalculation[i], checkCostDisplayedTheoreticalValue[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkFundBreakdownClassBreakdown[i], checkFundBreakdownAppendix[i], numbering[i], parametersSortBy[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 413, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 414, language);
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
        Activate_Inactivate_CheckDigit(userNameReportsCR1485, null, accountNumber, null);
    }
    
}


function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}

