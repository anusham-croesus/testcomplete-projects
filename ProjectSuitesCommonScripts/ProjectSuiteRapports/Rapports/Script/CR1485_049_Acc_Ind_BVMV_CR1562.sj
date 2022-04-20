//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_049_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_048_Cli_Ind_BVMV_CR1562


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Ayaz Sana
    Version du vserveur:ref90-16-2020-5-28--V9
*/

function CR1485_049_Acc_Ind_BVMV_CR1562()
{
   Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\49. Analyse de revenu des titres_TL\\3.1 Comptes", "CR1485_049_Acc_Ind_BVMV_CR1562()");
   Log.Link("https://jira.croesus.com/browse/TCVE-24", "Lien vers la story");
        
    
    
    try {
//  
        var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
       
//      Les variables  
        var accountNumber = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 213);
        var arrayOfAccountNumbers = accountNumber.split("|");
        var reportName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 214, language);
        var arrayOfReportsNames = reportName.split("|");
        var reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 222);
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 225, language);
        var sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 226, language);
        var currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 227, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 228, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 229, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 230, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 231, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 232, language);
      
        
         //Préparation de l'environnement
        Log.Message("Activation des PREFs");
        Activation_PREFS();
        
        Log.Message("Mise à jour de la BD");       
        Update_Database();
        
    
   
         //Login
        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
         
        
        //Dévalidation des rapports
        Log.Message("Dévalider les rapports");
        DevalidateReports_49();
        
        //Selectionner les comptes
        Log.Message("Sélectionner les 2 comptes :300001-NA et 800064-RE");
        SelectAccounts(arrayOfAccountNumbers);

                
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        //Selection des options pour le rapport
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients);
         //Sélection de tous les rapports nécessaires
        Log.Message("Sélection des rapports");
        SelectReports(arrayOfReportsNames);
        //Selection, déplacement et traitement des différents rapports
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[0] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        ChangingSecurityIncomeAnalysReportParameters(arrayOfReportsNames[0]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[1] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[1]); 
                
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[2] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[2]); 
                
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[3] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[3]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[3]);
           
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[4] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[4]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[4]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[5] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[5]));
        ChangingGainsAndLossesUnrealizedReportParameters(arrayOfReportsNames[5]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[6] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[6]));
        ChangingGainsAndLossesRealizedReportParameters(arrayOfReportsNames[6]);
        
        Log.Message("Validaton et sauvegarde des rapports");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);    
         
         //************************* Generate French report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 271);
          
          //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 274, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 275, language);
        
        //Selection des options pour le rapport
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients);
       
          //Sélection de tous les rapports nécessaires
        Log.Message("Sélection des rapports");
        SelectReports(arrayOfReportsNames);
        //Selection, déplacement et traitement des différents rapports
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[0] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        ChangingSecurityIncomeAnalysReportParameters(arrayOfReportsNames[0]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[1] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[1]); 
                
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[2] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[2]); 
                
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[3] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[3]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[3]);
           
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[4] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[4]));
        ChangingPortfolioEvaluationReportParameters(arrayOfReportsNames[4]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[5] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[5]));
        ChangingGainsAndLossesUnrealizedReportParameters(arrayOfReportsNames[5]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[6] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[6]));
        ChangingGainsAndLossesRealizedReportParameters(arrayOfReportsNames[6]);
        
        Log.Message("Validaton et sauvegarde des rapports");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);    
                  
        
  }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function DevalidateReports_49() {

    //Outils / Configurations / Rapports / Configurations des défauts / OK
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
    Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();  
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 45000);
    Get_WinDefaultConfiguration_BtnOK().Click();
    Get_WinConfigurations().Close();  
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "BaseFrame_4c01", 30000);
}

function Activation_PREFS(){
       
/*  0. Pref rapports (Niveau firme)
    PREF_REPORT_EVAL_POS_TOT_RET_TL=YES
    PREF_REPORT_EVAL_AVAN_TL=YES
    PREF_REPORT_EVAL_INTER_TL=YES
    PREF_REPORT_EVAL_SIMPLE_TL=YES
    PREF_REPORT_EVAL_VC_TL=YES
    PREF_REPORT_GP_NON_REALISES_TL=YES
    PREF_REPORT_GAIN_PERTE_TL=YES
    PREF_ADD_THEORETICAL_VALUE = YES
    PREF_TAX_LOT=YES 

*/  
     //Pref niveau firme
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_POS_TOT_RET_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_AVAN_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_INTER_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_SIMPLE_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EVAL_VC_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_GP_NON_REALISES_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_GAIN_PERTE_TL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TAX_LOT", "YES", vServerReportsCR1485);
       
        /*    1. *** Nievau firme ***
              PREF_REPORT_BVMV_IND = YES						
              PREF_LOT_DEFAULT_PRICE = NO						
              PREF_USE_DEFAULT_VALUES = NO	
              PREF_TAX_LOT = YES

*/  

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_USE_DEFAULT_VALUES", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TAX_LOT", "YES", vServerReportsCR1485);
//      Redémarrer les services  
        Log.Message("Redémarrage des services")
        RestartServices(vServerReportsCR1485);
        
        }
        
        
 
//Fonction qui permet de changer les paramètres du rapport: Gains et pertes (réalisés)        
        
function ChangingGainsAndLossesRealizedReportParameters(reportName) {
    
    var checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 263, language);
    var startDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 264, language);
    var endDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 265, language);
    var transactions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 266, language);
    
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
   SetReportParameters_Report_049_Acc_Ind_BVMV_CR1562("", "", "", "", "",checkPreviousCalendarYear, startDate, endDate,transactions)

} 
        
// Fonction qui permet de changer les paramètres du rapport: Analyse de revenu des titres       
               
function ChangingSecurityIncomeAnalysReportParameters(reportName) {
    
    var asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 240, language);
    var assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 241, language);
    var numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 242, language);
    var checkCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 243, language);
   
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_Report_049_Acc_Ind_BVMV_CR1562(asOfDate, assetAllocation, numbering,"",checkCostDisplayedTheoreticalValue, "", "", "", "")

} 


// Fonction qui permet de changer les paramètres des rapports: Évaluation du portefeuille (avancé),Évaluation du portefeuille (intermédiaire),Évaluation du portefeuille (simple)et Évaluation du portefeuille (valeur accumulée)
function ChangingPortfolioEvaluationReportParameters(reportName) {
    
    var asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 247, language);
    var assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 248, language);
    var numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 249, language);
    var sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 250, language);
    var checkCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 251, language);
   
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_Report_049_Acc_Ind_BVMV_CR1562(asOfDate, assetAllocation, numbering, sortBy, checkCostDisplayedTheoreticalValue,"", "", "", "")

} 


//Fonction qui permet de changer les paramètres du rapport:Gains et pertes (non réalisés)
function ChangingGainsAndLossesUnrealizedReportParameters(reportName) {
    
    var asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 255, language);
    var assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 256, language);
    var numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 257, language);
    var checkCostDisplayedTheoreticalValue= GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 258, language);
   
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
    SetReportParameters_Report_049_Acc_Ind_BVMV_CR1562(asOfDate, assetAllocation, numbering, "",checkCostDisplayedTheoreticalValue ,"", "", "", "")

} 


//Fonction qui permet de changer les paramètres des rapports  du cas de test :CR1485_049_Acc_Ind_BVMV_CR1562
function  SetReportParameters_Report_049_Acc_Ind_BVMV_CR1562(asOfDate, assetAllocation, numbering, sortBy,checkCostDisplayedTheoreticalValue, checkPreviousCalendarYear, startDate, endDate,transactions)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
// Au (As of)  
if (Trim(VarToStr(asOfDate)) != ""){
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
		
}		
    
//   Répartition d'actifs (Asset Allocation)
if (Trim(VarToStr(assetAllocation)) != ""){
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
}	
	
//  Pagination (Numbering)
 if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    }
	
//  Trier par (Sort by)
	
	if (Trim(VarToStr(sortBy)) != ""){
         if (Get_WinParameters_CmbSortBy2().Exists){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
        SelectComboBoxItem(Get_WinParameters_CmbSortBy2(), sortBy);
    }
    else
        SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    }
	
//Coût affiché - Valeur théorique (Cost Displayed - Theoretical Value)
	 if (Trim(VarToStr(checkCostDisplayedTheoreticalValue)) != "")
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
   
	
	
	
// Check box :Année civile précédente (Previous Calendar Year)
if (Trim(VarToStr(checkPreviousCalendarYear)) != ""){
    if (Get_WinParameters_ChkPreviousCalendarYear().IsEnabled)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(aqString.ToUpper(checkPreviousCalendarYear) == "VRAI" || aqString.ToUpper(checkPreviousCalendarYear) == "TRUE");
}

  
//  Date de début (Start Date)
if (Trim(VarToStr(startDate)) != ""){    
   SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
 
} 

// Date de fin (End Date)
if (Trim(VarToStr(endDate)) != ""){
   SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);  
}

   
//Transactions (Transactions)
if (Trim(VarToStr(transactions)) != ""){
   Get_WinParameters_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactions], 10).set_IsChecked(true);
       
}	
        
    Delay(300);  
    Get_WinParameters_BtnOK().Click();
}  

