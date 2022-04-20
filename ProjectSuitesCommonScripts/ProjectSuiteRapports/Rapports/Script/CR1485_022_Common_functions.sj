﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_SHOW_REPORT_TRANS_SECURITY_WEB", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_TRANS_SECURITY_WEB", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //By default this report is only visible in Web application 
    MakeReportVisibleForSecurities("TRANS_SECURITY_WEB", vServerReportsCR1485);
}



function SetReportParameters(transactionTypesToBeChecked, startDate, endDate)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    var allTransactionTypes = Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes().FindAllChildren(["ClrClassName"], ["UniCheckBox"], 10).toArray();
    if (aqString.ToUpper(transactionTypesToBeChecked) == "TOUS" || aqString.ToUpper(transactionTypesToBeChecked) == "ALL"){
        Get_WinParameters_GrpTransactionTypes_BtnSelectAll().Click();
        Log.Message("JIRA CROES-10786 : Crash quand on clique sur Get_WinParameters_GrpTransactionTypes_BtnSelectAll().Click();");
        //for (var j in allTransactionTypes) allTransactionTypes[j].set_IsChecked(true);
    }
    else {
        Get_WinParameters_GrpTransactionTypes_BtnRemoveAll().Click();
        Log.Message("JIRA CROES-10786 : Crash quand on clique sur Get_WinParameters_GrpTransactionTypes_BtnRemoveAll().Click();");
        //for (var j in allTransactionTypes) allTransactionTypes[j].set_IsChecked(false);
        if (Trim(transactionTypesToBeChecked) != "" && aqString.ToUpper(transactionTypesToBeChecked) != "AUCUN" && aqString.ToUpper(transactionTypesToBeChecked) != "NONE"){
            arrayOfTransactionTypesToBeChecked = transactionTypesToBeChecked.split("|");
            for (var i = 0; i < arrayOfTransactionTypesToBeChecked.length; i++)
                Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfTransactionTypesToBeChecked[i])], 10).set_IsChecked(true);
        }
    }
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    Get_WinParameters_BtnOK().Click();
}