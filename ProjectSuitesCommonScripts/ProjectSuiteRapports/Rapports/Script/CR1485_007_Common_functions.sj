//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DOCUMENT_SUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SHOW_DOCUMENT_SUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    
    //************************ Activer les prefs pour les rapports à jumeler *************************
    
    //Analyse de revenu des titres - Income Analysis
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_POS_TOT_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    
    //Analyse risque/rendement - Risk/Return Analysis
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GRAPH_RISK_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RISK_RETURN", "YES", vServerReportsCR1485);
    
    //Avis de non-responsabilité - Disclaimer
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISCLAIMER", "YES", vServerReportsCR1485);
    
    //Biens étrangers - Foreign Property
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FOREIGN_PROPERTY_SIMPLE", "YES", vServerReportsCR1485);
    
    //Performance du portefeuille - Portfolio Performance
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_PERFORMANCE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_PERFORMANCE_REPORT_DETAILS", "YES", vServerReportsCR1485);
    
    //Distribution par échéance (graphique) - Distribution by Maturity (Graph)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GRAPH_DIST_BM", "YES", vServerReportsCR1485);
    
    //Distribution par échéances - Distribution by Maturity
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DIST_BM", "YES", vServerReportsCR1485);
    
    //Évaluation du portefeuille (avancé) - Portfolio Evaluation (Advanced)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_AVAN", "YES", vServerReportsCR1485);
    //Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    
    //Pas de pref pour Évaluation du portefeuille (intermédiaire) - Portfolio Evaluation (Intermediate)
    
    //Évaluation du portefeuille (simple) - Portfolio Evaluation (Simple)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    //Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    
    //Évaluation du portefeuille (valeur accumulée) - Portfolio Evaluation (Accumulated Value)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_VC", "YES", vServerReportsCR1485);
    //Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
}

function ActivatePDFFirmPrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", REPORTS_FILES_FOLDER_PATH, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PDF_NAMING_CONVENTION", "RJ", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}

function DesactivatePDFFirmPrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PDF_NAMING_CONVENTION", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "NO", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(asOfDate, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}