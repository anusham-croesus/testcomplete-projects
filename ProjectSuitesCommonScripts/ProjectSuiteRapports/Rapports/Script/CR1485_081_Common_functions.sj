//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RESTRICTION_CRITERIA", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TRADE_RESTRICTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_CRITERIA_RESTRICTIONS_ACCESS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_GrpSeverity_ChkHard().IsEnabled)
        Get_WinParameters_GrpSeverity_ChkHard().set_IsChecked(aqString.ToUpper(checkSeverityHard) == "VRAI" || aqString.ToUpper(checkSeverityHard) == "TRUE");
    
    if (Get_WinParameters_GrpSeverity_ChkSoft().IsEnabled)
        Get_WinParameters_GrpSeverity_ChkSoft().set_IsChecked(aqString.ToUpper(checkSeveritySoft) == "VRAI" || aqString.ToUpper(checkSeveritySoft) == "TRUE");
    
    if (Get_WinParameters_GrpAccess_ChkFirm().IsEnabled)
        Get_WinParameters_GrpAccess_ChkFirm().set_IsChecked(aqString.ToUpper(checkAccessFirm) == "VRAI" || aqString.ToUpper(checkAccessFirm) == "TRUE");
    
    if (Get_WinParameters_GrpAccess_ChkIA().IsEnabled)
        Get_WinParameters_GrpAccess_ChkIA().set_IsChecked(aqString.ToUpper(checkAccessIA) == "VRAI" || aqString.ToUpper(checkAccessIA) == "TRUE");
    
    if (Get_WinParameters_GrpStatus_ChkTriggered().IsEnabled)
        Get_WinParameters_GrpStatus_ChkTriggered().set_IsChecked(aqString.ToUpper(checkStatusTriggered) == "VRAI" || aqString.ToUpper(checkStatusTriggered) == "TRUE");
    
    if (Get_WinParameters_GrpStatus_ChkNotTriggered().IsEnabled)
        Get_WinParameters_GrpStatus_ChkNotTriggered().set_IsChecked(aqString.ToUpper(checkStatusNotTriggered) == "VRAI" || aqString.ToUpper(checkStatusNotTriggered) == "TRUE");
    
    Get_WinParameters_BtnOK().Click();
}



//À supprimer, de même que la feuille PreparationBD_Rap081_Rel du fihcier Excel data_ReportsCR1485.xlsx
//L'ajout de restrictions se fait désormais par requêtes SQL
function AddRestrictionsToRelationships()
{
    //Récupérer du fichier Excel le nombre de restrictions à ajouter
    var Excel = Sys.OleObject("Excel.Application");
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Rap081_Rel").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfRestrictions = Math.round((RowCount - 1)/8);
    Log.Message("Nombre de restrictions à ajouter : " + NbOfRestrictions);
    
    //Ajouter les restrictions renseignées dans le fichier Excel
    for (i = 0; i < NbOfRestrictions; i++){
        offset = 3 + (8*i);
        relationshipName = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 1, language);
        securityDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 2, language);
        restrictionType = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 3, language);
        minimumValue = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 4, language);
        maximumValue = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 5, language);
        severity = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 6, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();
        Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
        
        Get_WinCRURestriction_GrpSecurity_RdoSecurity().set_IsChecked(true);
        
        Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Click();
        Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(securityDescription);
        Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        
        Get_WinCRURestriction_GrpSecurity().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", restrictionType], 10).set_IsChecked(true);
        
        if (Get_WinCRURestriction_GrpSecurity_RdoPercentageOfTotalValue().wChecked){
            Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum().Click();
            Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum().Keys(minimumValue);
            Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum().Click();
            Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum().Keys(maximumValue);
        }
        else if (Get_WinCRURestriction_GrpSecurity_RdoModifiedDuration().wChecked){
            Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMinimum().Click();
            Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMinimum().Keys(minimumValue);
            Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMaximum().Click();
            Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMaximum().Keys(maximumValue);
        }
        
        if (Get_WinCRURestriction_CmbSeverity().Text != severity){
            Get_WinCRURestriction_CmbSeverity().set_IsDropDownOpen(true);
            Get_SubMenus().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", severity], 10).Click();
        }
        
        Get_WinCRURestriction_BtnOK().Click();
        Get_WinRestrictionsManager_BtnClose().Click();
    } 
}



//À supprimer, de même que la feuille PreparationBD_Rap081_Rel du fihcier Excel data_ReportsCR1485.xlsx
//La suppression de restrictions se fait désormais par requêtes SQL
function DeleteRestrictionsForRelationships()
{
    //Récupérer du fichier Excel le nombre de restrictions
    var Excel = Sys.OleObject("Excel.Application");
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Rap081_Rel").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfRestrictions = Math.round((RowCount - 1)/8);
    Log.Message("Nombre de restrictions dans le fichier Excel : " + NbOfRestrictions);
    
    //Récupérer la liste des relations renseignées dans le fichier Excel
    arrayOfRelationshipsNames = new Array();
    for (i = 0; i < NbOfRestrictions; i++){
        offset = 3 + (8*i);
        relationshipName = GetData(filePath_ReportsCR1485, "PreparationBD_Rap081_Rel", offset + 1, language);
        
        isFound = false;
        for (j = 0; j < arrayOfRelationshipsNames.length; j++){
            if (relationshipName == arrayOfRelationshipsNames[j]){
                isFound = true;
                break;
            }   
        }
        
        if (!isFound)
            arrayOfRelationshipsNames.push(relationshipName);
    }
    
    //Supprimer les restrictions
    for (k = 0; k < arrayOfRelationshipsNames.length; k++){  
        relationshipName == arrayOfRelationshipsNames[k];
                
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();
        
        Get_WinRestrictionsManager().Click();
        Sys.Keys("^a");
        
        Delay(3000);
        
        if (Get_WinRestrictionsManager_BarPadHeader_BtnDelete().IsEnabled){
            Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }

        Get_WinRestrictionsManager_BtnClose().Click();
    } 
}
