//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    !!!
    Ce fichier est aussi utilisé par les scripts CR1485_149_... :
        CR1485_149_Acc_2008_Group
        CR1485_149_Cli_2007
        CR1485_149_Rel_ParamDef
    !!!
*/



function ActivatePrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_FOREIGN_PROPERTY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function RestorePrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_FOREIGN_PROPERTY", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485); 
    RestartServices(vServerReportsCR1485);
}



/**
    !!!
    Ce fichier est aussi utilisé par les scripts CR1485_149_... :
        CR1485_149_Acc_2008_Group
        CR1485_149_Cli_2007
        CR1485_149_Rel_ParamDef
    !!!
*/
function SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    //Combobox : Date
    if (!Get_WinParameters_LblStartDate().Exists || !Get_WinParameters_LblStartDate().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Date de début:' non trouvé.": "'Start Date:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbStartDateMonth(), startDateMonth);
    SelectComboBoxItem(Get_WinParameters_CmbStartDateYear(), startDateYear);
    
    //Case à cocher : Inclure seulement les comptes non enregistrés
    checkIncludeNonregisteredAccountsOnly = Trim(VarToStr(checkIncludeNonregisteredAccountsOnly));
    var boolCheckIncludeNonregisteredAccountsOnly = (aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "VRAI" || aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "TRUE");
    var isCheckIncludeNonregisteredAccountsOnlyStateToBeChanged = false;
    if (checkIncludeNonregisteredAccountsOnly == ""){
        if (Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().Exists && Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsVisible && Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue === true){
            Log.Warning("No information provided about the checkIncludeNonregisteredAccountsOnly checkbox state, but it was checked -> Uncheck it.", "", pmNormal, null, Sys.Desktop.Picture());
            isCheckIncludeNonregisteredAccountsOnlyStateToBeChanged = true;
        }
    }
    else if (boolCheckIncludeNonregisteredAccountsOnly != Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue){
        isCheckIncludeNonregisteredAccountsOnlyStateToBeChanged = true;
    }
    
    if (isCheckIncludeNonregisteredAccountsOnlyStateToBeChanged){
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().Click();
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().WaitProperty("IsChecked.OleValue", boolCheckIncludeNonregisteredAccountsOnly, 5000);
        CompareProperty(Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue, cmpEqual, boolCheckIncludeNonregisteredAccountsOnly, true, lmError);
    }
    
    //Bouton radio : Valeur pour la section détaillée
    if (true !== Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", foreignPropertyValue], 10).IsChecked.OleValue){
        Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", foreignPropertyValue], 10).Click();
        Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", foreignPropertyValue], 10).WaitProperty("IsChecked.OleValue", true, 5000);
        CompareProperty(Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", foreignPropertyValue], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    }
    
    //Case à cocher : Inclure un tableau sommaire
    var boolCheckIncludeSummaryTable = (aqString.ToUpper(checkIncludeSummaryTable) == "VRAI" || aqString.ToUpper(checkIncludeSummaryTable) == "TRUE");
    if (boolCheckIncludeSummaryTable != Get_WinParameters_ChkIncludeSummaryTable().IsChecked.OleValue){
        Get_WinParameters_ChkIncludeSummaryTable().Click();
        Get_WinParameters_ChkIncludeSummaryTable().WaitProperty("IsChecked.OleValue", boolCheckIncludeSummaryTable, 5000);
        CompareProperty(Get_WinParameters_ChkIncludeSummaryTable().IsChecked.OleValue, cmpEqual, boolCheckIncludeSummaryTable, true, lmError);
    }
    
    //Bouton radio : Valeur pour le tableau sommaire
    if (true != Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", SummaryTableValue], 10).IsChecked.OleValue){
        Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", SummaryTableValue], 10).Click();
        Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", SummaryTableValue], 10).WaitProperty("IsChecked.OleValue", true, 5000);
        CompareProperty(Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", SummaryTableValue], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    }
    
    //Combobox : Pagination
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    Log.Link("https://jira.croesus.com/browse/TCVE-1201", "Bug JIRA TCVE-1201");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering3(), PaginationValue);
    
    ///////////////////////
    Log.Picture(Sys.Desktop.FocusedWindow(), "Fenêtre Paramètres Rapport 107.");
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}