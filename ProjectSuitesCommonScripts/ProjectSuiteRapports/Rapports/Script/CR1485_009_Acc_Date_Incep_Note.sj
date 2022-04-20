//USEUNIT CR1485_009_Common_functions


/**
    Description : 
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\9. Sommaire du portefeuille\3.2 Comptes
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
    
    sprint 7
    version sur laquelle on a scripté: 	ref90-12-Hf-12--V9-croesus-co7x-1_8_2_653
*/

function CR1485_009_Acc_Date_Incep_Note()
{
    Log.Message("Bug JIRA CROES-3435");

    try {
        reportName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 258);
        DATE_INCEP=GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 257);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        
        //Activate Prefs
        
       Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORTFOLIO", "YES", vServerReportsCR1485);
         //Rouler les commandes SQL
            var SQLQuery = "";
           
                SQLQuery += "update b_compte set DATE_INCEP = \"" + DATE_INCEP + "\" where no_compte = (\"" + accountsNumbers + "\"" + ")\r\n";
         Log.Message("Rouler commandes SQL pour mettre à jour DATE_INCEP.", SQLQuery);
            Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
    
            //Repartir les services
            RestartServices(vServerReportsCR1485);
        //Login and goto the module and Select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(accountsNumbers);
        
        
         //************************* Generate Anglais report ********************************************************************************************//
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 260);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        var reportsWindowTitle = Get_WinReports().Title.OleValue;       
        
        
        //Reports options values
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 264, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 263, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Parameters values du premier rapport 
        firstCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 268, language);
        endDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 269, language);
        period = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 270, language);
        period1 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 271, language);
        period2 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 272, language);
        period3 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 273, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 274, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 275, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 276, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 277, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 278, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 279, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 280, language);
        numbering = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 281, language);
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
        //Changement des paramétres du rapport :sommaire du portefeuille 1
        SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 30000);
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
        //Parameters values du deuxième rapport 
        secondCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 282, language);
        SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        
        
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate french report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 284);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        
        //Reports options values
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 288, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 287, language);
        
        //Changement des options
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
        //Changement des paramétres du rapport :sommaire du portefeuille 1
        SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 30000);
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
          SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
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