//USEUNIT CR1485_002_Common_functions


/**
    Description : 
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
    
      voir les spécifications dans le lien suivant

      https://docs.google.com/spreadsheets/d/1_qTiCo6-sBo88p4uW9nrAOEJpF2blN8Q_xviwZvPBN0/edit#gid=805552766

      Onglet:  Cas à ajouter

      Faire un filtre sur la colonne Sprint = TCVE-267

      Les Specifications sont sous la colonne: Lien
*/


function CR1485_002_Cli_ExclAccAddress_CR2242()
{
      try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 241);
        
        
        //Activate Prefs
       
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
    
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
       
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 243);
        
        //Open Reports window and Select report
       Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        
       //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 246, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 247, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 248, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 249, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 250, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 251, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 252, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 253, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 254, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 255, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values Paramètres du rapport: Gains et pertes (réalisés)1
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
        
        firstcheckPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 258, language);
        firststartDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 259, language);
        firstendDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 260, language);
        firstcheckIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 261, language);
        firstcheckIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 262, language);
        firstcheckIncludeNonRgisteredAccountsOnly= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 263, language);
        firstcheckGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 264, language);
        firstcheckOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 265, language);
        firstcostCalculation =GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 266, language);// (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): 
        firsttransactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 267, language);
        firstnumbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 268, language);
        firstcheckCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 269, language);
        firstcheckExcludeClientAddress=GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 270, language);
        
        SetReportParameters(firstcheckPreviousCalendarYear, firststartDate, firstendDate, firstcheckIncludeInterestAndDividends, firstcheckIncludeTotalGainAndLossBreakdown, firstcheckGroupBySecurity, firstcheckOneReportPerAccount, firstcostCalculation, firsttransactionDate, firstnumbering,firstcheckCostDisplayedTheoreticalValue,firstcheckIncludeNonRgisteredAccountsOnly,firstcheckExcludeClientAddress);
        
        /******************************sélectionner le deuxiéme rapport************************************************************************************/
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
          //Parameters values Paramètres du rapport: Gains et pertes (réalisés)2
          
        secondcheckPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 274, language);
        secondstartDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 275, language);
        secondendDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 276, language);
        secondcheckIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 277, language);
        secondcheckIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 278, language);
        secondcheckIncludeNonRgisteredAccountsOnly= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 279, language);
        secondcheckGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 280, language);
        secondcheckOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 281, language);
        secondcostCalculation =GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 282, language);// (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): 
        secondtransactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 283, language);
        secondnumbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 284, language);
        secondcheckCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 285, language);
        secondcheckExcludeClientAddress=GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 286, language);
        
        SetReportParameters(secondcheckPreviousCalendarYear, secondstartDate, secondendDate, secondcheckIncludeInterestAndDividends, secondcheckIncludeTotalGainAndLossBreakdown, secondcheckGroupBySecurity, secondcheckOneReportPerAccount, secondcostCalculation, secondtransactionDate, secondnumbering,secondcheckCostDisplayedTheoreticalValue,secondcheckIncludeNonRgisteredAccountsOnly,secondcheckExcludeClientAddress);
         
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 290);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
       
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 293, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 294, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
       
         //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        SetReportParameters(firstcheckPreviousCalendarYear, firststartDate, firstendDate, firstcheckIncludeInterestAndDividends, firstcheckIncludeTotalGainAndLossBreakdown, firstcheckGroupBySecurity, firstcheckOneReportPerAccount, firstcostCalculation, firsttransactionDate, firstnumbering,firstcheckCostDisplayedTheoreticalValue,firstcheckIncludeNonRgisteredAccountsOnly,firstcheckExcludeClientAddress);
       // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
        SetReportParameters(secondcheckPreviousCalendarYear, secondstartDate, secondendDate, secondcheckIncludeInterestAndDividends, secondcheckIncludeTotalGainAndLossBreakdown, secondcheckGroupBySecurity, secondcheckOneReportPerAccount, secondcostCalculation, secondtransactionDate, secondnumbering,secondcheckCostDisplayedTheoreticalValue,secondcheckIncludeNonRgisteredAccountsOnly,secondcheckExcludeClientAddress);
       
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