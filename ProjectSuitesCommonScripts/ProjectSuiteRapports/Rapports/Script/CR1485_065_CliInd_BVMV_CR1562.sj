//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_065_Common_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT CR1485_053_Common_functions



/**
    Description : 
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\65. GAINS ET PERTES (NON RÉALISÉS)\2.1 Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice 
*/

function CR1485_065_CliInd_BVMV_CR1562()
{
    try {
        /*Variables*/
        var clientNumbers = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 181);
        var arrayOfClientNumbers = clientNumbers.split("|");
        var reportNames = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 182);
        var arrayOfReportNames = reportNames.split("|");
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 187, language);
        var sortBy = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 188, language);
        var currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 189, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 190, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 191, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 192, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 193, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 194, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 195, language);
        var message = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 196, language);
        
               
        //Activation des PREFS
        Log.Message("Activation des PREFS");
        Activate_PREFS();
             
        //Mise à jour de la BD
        Log.Message("Mise à jour de la base de données");
        Update_DataBase();
        
        //Login
        Log.Message("Se connecter à l'application");
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Dévalider les rapports
        Log.Message("Dévalidation des rapports");
        DevalidateReports();
               
        //Select clients
        Log.Message("Sélection des numéros de clients");
        SelectClients(arrayOfClientNumbers);       
        
        
        //************************* Generate reports *********************
        Log.Message("Génération des rapports en anglais et en français");
        var reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 184);  
       
        
        /*Explication de la boucle for: La génération des rapports se fait en anglais et en français
        Donc il va y avoir 2 itérations:  une pour anglais, une pour français */
        for (i=0; i<2; i++) {
            
            //Open Reports window and Select report
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            
            //Selection des options pour le rapport
            Log.Message("Sélection des options du rapport en " + reportLanguage);
            SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);             
            
            SelectReports(arrayOfReportNames);
               
            //Selection, déplacement et traitement des différents rapports
            Log.Message("Déplacer le rapport " + arrayOfReportNames[3] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[3]));
            transactions_ACB_and_Quantity(arrayOfReportNames[3]);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[2] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[2]));
            transactions_reports(arrayOfReportNames[2]);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[1] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[1]));
            Gains_Losses_Realized_Report(arrayOfReportNames[1]);
            
            Log.Message("Déplacer le rapport " + arrayOfReportNames[0] + " au top et sélectionner les paramètres" );
            MoveCurrentReportToTop(Trim(arrayOfReportNames[0]));
            Gains_Losses_Non_Realized_Report(arrayOfReportNames[0]);
            
            Log.Message("Validaton et sauvegarde des rapports");
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
            
            //Changement de langue (Français)
            reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 247);
            currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 250, language);
            reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 251, language);
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
    }
}



function Activate_PREFS() {

    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GP_NON_REALISES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GAIN_PERTE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_TRANSACTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_BOOK_PAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_BVMV_IND ", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_LOT_DEFAULT_PRICE ", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_USE_DEFAULT_VALUES ", "NO", vServerReportsCR1485);
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
        
    Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();
    
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 35000);
    Get_WinDefaultConfiguration_BtnOK().Click();
    Get_WinConfigurations().Close();  
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "BaseFrame_4c01", 30000);
}


function Gains_Losses_Non_Realized_Report(reportName) {
    
    //Parameters values
    var asOfDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 199, language);
    var checkGroupByRegion = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 200, language);
    var checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 201, language);
    var groupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 202, language);
    var costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 203, language): GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 67, language);
    var checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 205, language);
    var assetAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 206, language);
    var customAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 207, language);
    var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 208, language);
    var checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 209, language);
    var checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 210, language);
    var numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 211, language);
    var checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 212, language);
    
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    CR1485_065_Common_functions.SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
}


function Gains_Losses_Realized_Report(reportName) {
    
    //Parameters values
    var checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 216, language);
    var startDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 217, language);
    var endDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 218, language);
    var checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 219, language);
    var checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 220, language);
    var checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 228, language);
    var checkGroupBySecurity = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 222, language);
    var checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 223, language);
    var costCalculation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 224, language);
    var checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 225, language);
    var transactionDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 226, language);
    var numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 227, language);
        
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_Gains_Losses_Realized_Report(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly);
}


function transactions_reports(reportName) {
    
    //Parameters values
    var transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 231, language);
    var startDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 232, language);
    var endDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 233, language);
    var checkGroupByRecord = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 234, language);
    var checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 235, language);
    var checkGroupBySecurity = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 236, language);
    var numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 237, language);
    
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    CR1485_013_Common_functions.SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
}


function transactions_ACB_and_Quantity(reportName) {
     
    //Parameters values
    var asOfDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 241, language);
    var positionState = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 242, language);
    var numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 243, language);

    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    CR1485_053_Common_functions.SetReportParameters(asOfDate, positionState, numbering);
}


function SetReportParameters_Gains_Losses_Realized_Report(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();

    if (Get_WinParameters_ChkPreviousCalendarYear().IsEnabled)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(aqString.ToUpper(checkPreviousCalendarYear) == "VRAI" || aqString.ToUpper(checkPreviousCalendarYear) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_ChkIncludeInterestAndDividends().IsEnabled)
        Get_WinParameters_ChkIncludeInterestAndDividends().set_IsChecked(aqString.ToUpper(checkIncludeInterestAndDividends) == "VRAI" || aqString.ToUpper(checkIncludeInterestAndDividends) == "TRUE");
    
    if (Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().IsEnabled)
        Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().set_IsChecked(aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "VRAI" || aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "TRUE");
    
    if (checkIncludeNonregisteredAccountsOnly != undefined)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().set_IsChecked(aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "VRAI" || aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "TRUE");
        
    if (Get_WinParameters_ChkGroupBySecurity().IsEnabled)
        Get_WinParameters_ChkGroupBySecurity().set_IsChecked(aqString.ToUpper(checkGroupBySecurity) == "VRAI" || aqString.ToUpper(checkGroupBySecurity) == "TRUE");
        
    if (Get_WinParameters_ChkOneReportPerAccount().Exists && Get_WinParameters_ChkOneReportPerAccount().IsEnabled)
        Get_WinParameters_ChkOneReportPerAccount().set_IsChecked(aqString.ToUpper(checkOneReportPerAccount) == "VRAI" || aqString.ToUpper(checkOneReportPerAccount) == "TRUE");
        
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactionDate], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkCostDisplayedTheoreticalValue != undefined)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}