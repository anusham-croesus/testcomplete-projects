//USEUNIT Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_074_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_074_Cli_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 142);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        EnablePerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        
        //Login and goto Clients module and Select the clients
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 144);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 147, language);
        var sortBy = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 148, language);
        var currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 149, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 150, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 151, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 152, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 153, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 154, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 155, language);
        var message = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 156, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 160, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 161, language);
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 162, language).split(separatorChar);
        CompareProperty(CheckExcludeDataPrecedingTheManagementStartDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 163, language).split(separatorChar);
        CompareProperty(endDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 164, language).split(separatorChar);
        CompareProperty(period.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 165, language).split(separatorChar);
        CompareProperty(period1.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 166, language).split(separatorChar);
        CompareProperty(period2.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 167, language).split(separatorChar);
        CompareProperty(period3.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 168, language).split(separatorChar);
        CompareProperty(period4.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 169, language).split(separatorChar);
        CompareProperty(period5.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 170, language).split(separatorChar);
        CompareProperty(period6.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 171, language).split(separatorChar);
        CompareProperty(period7.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 172, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 173, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 174, language).split(separatorChar);
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 175, language).split(separatorChar);
        CompareProperty(checkTimeWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 176, language).split(separatorChar);
        CompareProperty(checkTimeWeightedGrossOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 177, language).split(separatorChar);
        CompareProperty(checkMoneyWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 178, language).split(separatorChar);
        CompareProperty(performanceCalculations.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 179, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], period6[i], period7[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], numbering[i]);
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

        var reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 182);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], period6[i], period7[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 185, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 186, language);
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
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        Terminate_CroesusProcess();
    }
    
}
