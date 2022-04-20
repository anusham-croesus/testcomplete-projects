//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_048_Common_functions


/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.3 Clients"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
*/

function CR1485_048_Cli_Ind_BVMV_CR1562()
{
    try {
        
        /* Variables */
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        var clientsNumbers = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 445);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        var reportName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 444, language);
        var arrayOfReportsNames = reportName.split("|");
        var reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 447);
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 450, language);
        var sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 451, language);
        var currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 452, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 453, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 454, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 455, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 456, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 457, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 458, language);
        var message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 459, language);
        
        Log.Link("https://jira.croesus.com/browse/TCVE-24", "Lien vers la story");
        
        //Préparation de l'environnement
        Log.Message("Activation des PREFs");
        Activation_PREFS();
        
        Log.Message("Mise à jour de la BD");       
        Update_Database();

        //Login
        //Se connecter avec l'utilisateur DARWIC
        Login(vServerReportsCR1485, userName, password, language);
        
        //Dévalidation des rapports
        Log.Message("Dévalider les rapports");
        DevalidateReports();
        
        //Selection des clients
        Log.Message("Sélection des clients");
        SelectClients(arrayOfClientsNumbers);
        
        
         /*Explication de la boucle for: La génération des rapports se fait en anglais et en français
        Donc il va y avoir 2 itérations:  une pour anglais, une pour français */
        for (i=0; i<2; i++) {
            //Open Reports window and Select report
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
        
            //Selection des options pour le rapport
            Log.Message("Sélection des options du rapport");
            SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
            //Sélection de tous les rapports nécessaires
            Log.Message("Sélection des rapports");
            SelectReports(arrayOfReportsNames);
                
            //Selection, déplacement et traitement des différents rapports
            Log.Message("Déplacer le rapport " + arrayOfReportsNames[3] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[3]));
            Distribition_By_Maturity_Report(arrayOfReportsNames[3]);
        
            Log.Message("Déplacer le rapport " + arrayOfReportsNames[2] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
            Foreign_Property_Detailled_Report(arrayOfReportsNames[2]);
                
            Log.Message("Déplacer le rapport " + arrayOfReportsNames[1] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
            Foreign_Property_Report(arrayOfReportsNames[1]); 
                
            Log.Message("Déplacer le rapport " + arrayOfReportsNames[0] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
            Security_income_analysis_Report(arrayOfReportsNames[0]);
                    
            Log.Message("Validaton et sauvegarde des rapports");
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);    
              
            //Reports options values (Other options are the same as for the English report)
            reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 510);
            currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 513, language);
            reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 514, language);
        }
        
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}



function Activation_PREFS() {
     
    //Activation des prefs
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_POS_TOT_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SHOW_REPORT_FOREIGN_PROPERTY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_FOREIGN_PROPERTY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DIST_BM", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485);        

    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_USE_DEFAULT_VALUES", "NO", vServerReportsCR1485);
}


function Update_Database()  {
   
    //Mise à jour de la BD
    var SQLQuery_B_Portef = "update b_portef set BV_MV_IND = 'Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001)";						
    var SQLQuery_B_HISPO_DELTA = "update B_HISPO_DELTA set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001) and no_compte in ('300001-NA', '300002-OB', '800064-RE','800300-NA','800400-NA')";
    var SQLQuery_B_TRANS = "update B_TRANS set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001) and no_compte in ('300001-NA', '300002-OB', '800064-RE', '800300-NA','800400-NA')";
        
    Log.Message("Mise à jour de la BD");
    Execute_SQLQuery(SQLQuery_B_Portef, vServerReportsCR1485);
    Execute_SQLQuery(SQLQuery_B_HISPO_DELTA, vServerReportsCR1485);
    Execute_SQLQuery(SQLQuery_B_TRANS, vServerReportsCR1485);

    Log.Message("Redémarrage des services");
    RestartServices(vServerReportsCR1485); 
}


function DevalidateReports() {

    //Outils / Configurations / Rapports / Configurations des défauts / OK
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
    Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();

    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 35000);
    Get_WinDefaultConfiguration_BtnOK().Click();
    Get_WinConfigurations().Close();  
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "BaseFrame_4c01", 30000);
}

function Security_income_analysis_Report(reportName) {
    
    var asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 462, language);
    var checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 463, language);
    var type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 465, language);
    var checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 466, language);
    var checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 467, language);
    var checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 468, language);
    var groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 469, language);
    var costCalculation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 470, language);
    var checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 472, language);
    var assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 473, language);
    var customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 474, language);
    var checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 475, language);
    var checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 476, language);
    var numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 477, language);
    
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
}


function Foreign_Property_Report(reportName) {
    
    //Parameters values
    var startDateMonth = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 482, language);
    var startDateYear = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 483, language);
    var foreignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 484, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 88, language);
    var checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 486, language);
    var checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 488, language);
    var PaginationValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 487, language);
    var SummaryTableValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 489, language);
     
    //Sélection des paramètres
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_ForeignProperty(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
}


function Foreign_Property_Detailled_Report(reportName) {

    //Parameters values
    var prevCalendarYear = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 494, language);
    var startDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 495, language);
    var endDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 496, language);
    var sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 497, language);
    var numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 498, language);
    
    //Sélection des paramètres
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_ForeignPropertyDetailed(prevCalendarYear, startDate, endDate, sortBy, numbering);
}


function Distribition_By_Maturity_Report(reportName) {
    
    //Paramètres du rapport
    var asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 503, language);
    var calculationCost = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 504, language);
    var numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 505, language);
    var checkDigit = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 506, language);

    //Sélection des paramètres
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_DistributionMaturity(asOfDate, numbering, calculationCost, checkDigit);
}