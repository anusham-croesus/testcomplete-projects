//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA



function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FBN_FISCAL_REPORT", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Table des matières
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_DOC_SUMMARY", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Sommaire (fin d'exercice)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_SUMMARY", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Mouvement de l'encaisse
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_CASH", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Analyse initiale du portefeuille
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_BEG_EVAL", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Analyse finale du portefeuille
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_END_EVAL", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Transactions (fin d'exercice)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_TRANSAC", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Revenus (fin d'exercice)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_INCOME", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Gains/Pertes non réalisés (fin d'exercice)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_GP_NON_REAL", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Intérêts encaissés
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_CASH_INT", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Intérêts courus sur les transactions
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_ACC_INT_TRAN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_QUARTERLY_REPORT_GP1859", "YES", vServerReportsCR1485);
    
    //Activer Rapport : Intérêts courus sur les obligations coupons détachés
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_ACC_INT_SBH", "YES", vServerReportsCR1485);
    MakeReportVisibleForAccounts("FBNFISC_ACC_INT_SBH", vServerReportsCR1485);
}
