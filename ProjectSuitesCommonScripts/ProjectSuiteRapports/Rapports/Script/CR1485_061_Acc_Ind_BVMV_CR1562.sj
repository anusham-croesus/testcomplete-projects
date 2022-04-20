//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_061_Common_functions


/**
    Description : 
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\61. Évaluation du portefeuille (intermédiaire)\3.3 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
*/

function CR1485_061_Acc_Ind_BVMV_CR1562()
{
    try {
        /*Variables*/
        var accountsNumbers = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 348);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var reportNames = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 349);
        var arrayOfReportNames = reportNames.split("|");
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 354, language);
        var sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 355, language);
        var currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 356, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 357, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 358, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 359, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 360, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 361, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 362, language);
        var message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 362, language);
        
        //Parameters values
        var asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 366, language);
        var checkIncludeGraph = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 367, language);
        var type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 368, language);
        var checkComparative = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 369, language);
        var checkGroupByRegion = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 370, language);
        var checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 371, language);
        var groupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 372, language);
        var checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 373, language);
        var costCalculation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 374, language);
        var checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 376, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 377, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 378, language);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 379, language);
        var checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 380, language);
        var checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 381, language);
        var numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 382, language);
        var parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 383, language);
       
        
        //Activation des PREFS
        Log.Message("Activation des PREFS");
        Activate_PREFS();
             
        //Mise à jour de la BD
        Log.Message("Mise à jour de la base de données");
        Update_DataBase();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Dévalider les rapports
        Log.Message("Dévalidation des rapports");
        DevalidateReports();
        
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Select accounts
        Log.Message("Sélection des numéros de compte");
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate reports *********************
        Log.Message("Génération des rapports en anglais et en français");
        var reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 351);  
       
        /*Explication de la boucle for: La génération des rapports se fait en anglais et en français
        Donc il va y avoir 2 itérations:  une pour anglais, une pour français */
        for (i=0; i<2; i++) {
            
            //Open Reports window and Select report
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            
            //Selection des options pour le rapport
            Log.Message("Sélection des options du rapport");
            SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);             SelectReports(arrayOfReportNames);
               
            //Selection, déplacement et traitement des différents rapports
            Log.Message("Déplacer le rapport " + arrayOfReportNames[3] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[3]));
            SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[2] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[2]));
            SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[1] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[1]));
            SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[0] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[0]));
            SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
            
            Log.Message("Validaton et sauvegarde des rapports");
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
            
            //Changement de langue (Français)
            reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 387);
            currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 390, language);
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


function Activate_PREFS() {

    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_USE_DEFAULT_VALUES", "YES", vServerReportsCR1485);
}


function Update_DataBase(){
    
    //Mise à jour de la BD
    var SQLQuery_B_Portef = "update b_portef set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001)";
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
