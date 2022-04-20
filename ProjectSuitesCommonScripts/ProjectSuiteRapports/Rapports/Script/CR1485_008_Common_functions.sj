//USEUNIT CR1485_Common_functions


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GRAPH_ASSET_INDC", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISABLE_INDUSTRY_CODE", "NO", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, type, industryCode, numbering)
{
    Log.Message("JIRA CROES-8424");
    if (client == "CIBC") Log.Message("JIRA CROES-9837");
    Log.Message("JIRA CROES-9282");
    Log.Message("JIRA CROES-9283");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
    
    SelectComboBoxItem(Get_WinParameters_CmbIndustryCode(), industryCode);
    
    if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    }
    
    Get_WinParameters_BtnOK().Click();
}



//SelectReports Temporary for Jira CROES-7597 RJ
function SelectReports(reportName)
{
    if (client != "RJ")
        return Common_functions.SelectReports(reportName);
    
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    var arrayOfAlwaysDefaultDisplayReports = (language == "french")? ["Rapport", "Rapports modèles", "Rapports titres"]: ["Report", "Model Reports", "Security Reports"];
    var isReportDisplayPerformanceSpecific = ((projet == "Performance") && GetIndexOfItemInArray(arrayOfAlwaysDefaultDisplayReports, Get_WinReports().Title) == -1);
    
    var isReportNameSelected = (isReportDisplayPerformanceSpecific)? Select_Report_Performance(reportName, false): SelectAReport(reportName);
    if (isReportNameSelected){
        Log.Message("JIRA CROES-7597 : Rapports - GICS - Espaces superflus dans le nom du rapport 008 '" + reportName + "'.");
        Log.Warning("Bug JIRA CROES-7597 résolu -> Mettre à jour les scripts en supprimant la function SelectReports() qui est dans le fichier CR1485_008_Common_functions.");
        return true;
    }
    
    var oldRreportName = (language == "french")? "Répartition des actions ( graphique par secteur )": "Stock Allocation ( Graph by Sector )";
    var isOldReportNameSelected = (isReportDisplayPerformanceSpecific)? Select_Report_Performance(oldRreportName, false): SelectAReport(oldRreportName);
    if (isOldReportNameSelected){
        Log.Warning("JIRA CROES-7597 : Rapports - GICS - Espaces superflus dans le nom du rapport 008 i.e. '" + oldRreportName + "' affiché au lieu de '" + reportName + "'.");
        Log.Warning("Scripts du rapport 008 à mettre à jour lorsque le bug JIRA CROES-7597 aura été résolu.");
        return false;
    }
    
    Log.Error("Echec de la sélection du rapport 008 pour RJ : ni '" + reportName + "', ni '" + oldRreportName + "' n'a été trouvé.");
    return false;
}
