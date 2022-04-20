//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_013_Common_functions


function ActivatePrefs(prefsUserName)
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_TAX_TRANSACTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485);
}



function SetReportParametersSetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit)
{
    CR1485_013_Common_functions.SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit)
}
