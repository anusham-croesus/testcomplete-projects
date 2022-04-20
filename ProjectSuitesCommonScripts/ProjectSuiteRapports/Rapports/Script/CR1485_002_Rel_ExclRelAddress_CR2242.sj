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


function CR1485_002_Rel_ExclRelAddress_CR2242()
{
      try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 301);
        
        
                  //Activate Prefs
       
       Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
       Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
       Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
       Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
       RestartServices(vServerReportsCR1485);
    
        //Login and goto Clients module
       Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
       Get_ModulesBar_BtnRelationships().Click();
        
           
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 303);
        
        //Open Reports window and Select report
       Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une troisième fois le rapport
        
       //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 306, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 307, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 308, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 309, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 310, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 311, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 312, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 313, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 314, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 315, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values Paramètres du rapport: Gains et pertes (réalisés)1
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
        
        firstcheckPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 318, language);
        firststartDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 319, language);
        firstendDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 320, language);
        firstcheckIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 321, language);
        firstcheckIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 322, language);
        firstcheckIncludeNonRgisteredAccountsOnly= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 323, language);
        firstcheckGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 324, language);
        firstcheckOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 325, language);
        firstcostCalculation =GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 326, language);// (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): 
        firsttransactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 327, language);
        firstnumbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 328, language);
        firstcheckCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 329, language);
        firstcheckExcludeRelationshipAddress=GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 330, language);
        
        SetReportParameters(firstcheckPreviousCalendarYear, firststartDate, firstendDate, firstcheckIncludeInterestAndDividends, firstcheckIncludeTotalGainAndLossBreakdown, firstcheckGroupBySecurity, firstcheckOneReportPerAccount, firstcostCalculation, firsttransactionDate, firstnumbering,firstcheckCostDisplayedTheoreticalValue,firstcheckIncludeNonRgisteredAccountsOnly,null,firstcheckExcludeRelationshipAddress);
        
        /******************************sélectionner le deuxiéme rapport************************************************************************************/
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
        //Parameters values Paramètres du rapport: Gains et pertes (réalisés)2
          
        secondcheckPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 335, language);
        secondstartDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 336, language);
        secondendDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 337, language);
        secondcheckIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 338, language);
        secondcheckIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 339, language);
        secondcheckIncludeNonRgisteredAccountsOnly= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 340, language);
        secondcheckGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 341, language);
        secondcheckOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 342, language);
        secondcostCalculation =GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 343, language);// (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): 
        secondtransactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 344, language);
        secondnumbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 345, language);
        secondcheckCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 346, language);
        secondcheckExcludeRelationshipAddress=GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 347, language);
        
        SetReportParameters(secondcheckPreviousCalendarYear, secondstartDate, secondendDate, secondcheckIncludeInterestAndDividends, secondcheckIncludeTotalGainAndLossBreakdown, secondcheckGroupBySecurity, secondcheckOneReportPerAccount, secondcostCalculation, secondtransactionDate, secondnumbering,secondcheckCostDisplayedTheoreticalValue,secondcheckIncludeNonRgisteredAccountsOnly,null,secondcheckExcludeRelationshipAddress);
         
        
           // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "3",reportName],10).Click();
       // Parameters values Paramètres du rapport: Gains et pertes (réalisés)3
          
        thirdcheckPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 351, language);
        thirdstartDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 352, language);
        thirdendDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 353, language);
        thirdcheckIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 354, language);
        thirdcheckIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 355, language);
        thirdcheckIncludeNonRgisteredAccountsOnly= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 356, language);
        thirdcheckGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 357, language);
        thirdcheckOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 358, language);
        thirdcostCalculation =GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 359, language);// (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): 
        thirdtransactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 360, language);
        thirdnumbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 361, language);
        thirdcheckCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 362, language);
        thirdcheckExcludeRelationshipAddress=GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 363, language);
        
        SetReportParameters(thirdcheckPreviousCalendarYear, thirdstartDate, thirdendDate, thirdcheckIncludeInterestAndDividends, thirdcheckIncludeTotalGainAndLossBreakdown, thirdcheckGroupBySecurity, thirdcheckOneReportPerAccount, thirdcostCalculation, thirdtransactionDate, thirdnumbering,thirdcheckCostDisplayedTheoreticalValue,thirdcheckIncludeNonRgisteredAccountsOnly,null,thirdcheckExcludeRelationshipAddress);
         
        
        
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 367);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une troisième fois le rapport
       
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 370, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 371, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
       
         //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        SetReportParameters(firstcheckPreviousCalendarYear, firststartDate, firstendDate, firstcheckIncludeInterestAndDividends, firstcheckIncludeTotalGainAndLossBreakdown, firstcheckGroupBySecurity, firstcheckOneReportPerAccount, firstcostCalculation, firsttransactionDate, firstnumbering,firstcheckCostDisplayedTheoreticalValue,firstcheckIncludeNonRgisteredAccountsOnly,null,firstcheckExcludeRelationshipAddress);
         // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
        SetReportParameters(secondcheckPreviousCalendarYear, secondstartDate, secondendDate, secondcheckIncludeInterestAndDividends, secondcheckIncludeTotalGainAndLossBreakdown, secondcheckGroupBySecurity, secondcheckOneReportPerAccount, secondcostCalculation, secondtransactionDate, secondnumbering,secondcheckCostDisplayedTheoreticalValue,secondcheckIncludeNonRgisteredAccountsOnly,null,secondcheckExcludeRelationshipAddress);
        
        // sélectionner le  troisiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "3",reportName],10).Click();
        SetReportParameters(thirdcheckPreviousCalendarYear, thirdstartDate, thirdendDate, thirdcheckIncludeInterestAndDividends, thirdcheckIncludeTotalGainAndLossBreakdown, thirdcheckGroupBySecurity, thirdcheckOneReportPerAccount, thirdcostCalculation, thirdtransactionDate, thirdnumbering,thirdcheckCostDisplayedTheoreticalValue,thirdcheckIncludeNonRgisteredAccountsOnly,null,thirdcheckExcludeRelationshipAddress);
         
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