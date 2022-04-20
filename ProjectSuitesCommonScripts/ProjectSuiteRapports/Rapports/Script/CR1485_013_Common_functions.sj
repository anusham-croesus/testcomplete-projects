//USEUNIT CR1485_Common_functions



/**
    !!!
    Ce fichier est aussi utilisé par les scripts CR1485_145_... :
        CR1485_145_Acc_AllTrans_DateModf_GroupEnrg_GroupSec_InclAcc
        CR1485_145_Cli_AllTrans_DateModf_GroupSec_InclAcc
        CR1485_145_Rel_AllTrans_DateDef_InclAcc
    !!!
*/

function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_TRANSACTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit)
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
            for (i = 0; i < arrayOfTransactionTypesToBeChecked.length; i++)
                Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfTransactionTypesToBeChecked[i])], 10).set_IsChecked(true);
        }
    }
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (GetBooleanValue(checkGroupByRecord) != undefined && GetBooleanValue(checkGroupByRecord) != Get_WinParameters_ChkGroupByRecord().IsChecked.OleValue)
        Get_WinParameters_ChkGroupByRecord().Click();
            
    if (GetBooleanValue(checkGroupByTransactionType) != undefined && GetBooleanValue(checkGroupByTransactionType) != Get_WinParameters_ChkGroupByTransactionType().IsChecked.OleValue)
        Get_WinParameters_ChkGroupByTransactionType().Click();
    
    if (GetBooleanValue(checkGroupBySecurity) != undefined && GetBooleanValue(checkGroupBySecurity) != Get_WinParameters_ChkGroupBySecurity().IsChecked.OleValue)
        Get_WinParameters_ChkGroupBySecurity().Click();
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkIncludeNonregisteredAccountsOnly != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().Click();
    
    if (checkDisplayCheckDigit != undefined && GetBooleanValue(checkDisplayCheckDigit) != undefined && GetBooleanValue(checkDisplayCheckDigit) != Get_WinParameters_ChkDisplayCheckDigit().IsChecked.OleValue)
        Get_WinParameters_ChkDisplayCheckDigit().Click();
    
    //Les états de certaines cases à cocher sont inter-dépendants, valider l'état final de cases à cocher
    if (GetBooleanValue(checkGroupByRecord) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupByRecord().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupByRecord), true, lmError);
        
    if (GetBooleanValue(checkGroupByTransactionType) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupByTransactionType().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupByTransactionType), true, lmError);
        
    if (GetBooleanValue(checkGroupBySecurity) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupBySecurity().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupBySecurity), true, lmError);
        
    if (checkIncludeNonregisteredAccountsOnly != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != undefined)
        CompareProperty(Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkIncludeNonregisteredAccountsOnly), true, lmError);
    
    Delay(1000);
    Get_WinParameters_BtnOK().Click();
}
