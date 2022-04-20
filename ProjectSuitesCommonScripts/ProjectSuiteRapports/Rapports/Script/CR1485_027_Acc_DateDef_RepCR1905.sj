//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_027_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_027_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 152);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module and Select the account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 154);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 157, language);
        var sortBy = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 158, language);
        var currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 159, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 160, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 161, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 162, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 163, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 164, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 165, language);
        var message = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 166, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 169, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 170, language);
        var asOfDate = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 171, language).split(separatorChar);
        CompareProperty(asOfDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkIncludeGraph = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 172, language).split(separatorChar);
        CompareProperty(checkIncludeGraph.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 173, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkComparative = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 174, language).split(separatorChar);
        CompareProperty(checkComparative.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 175, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 176, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 177, language).split(separatorChar);
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 178, language).split(separatorChar);
        CompareProperty(checkFundBreakdownClassBreakdown.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 179, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);

        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkFundBreakdownClassBreakdown[i], numbering[i]);
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
        
        var reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 182);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(asOfDate[i], checkIncludeGraph[i], type[i], checkComparative[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkFundBreakdownClassBreakdown[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 185, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 186, language);
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
    }
    
}
