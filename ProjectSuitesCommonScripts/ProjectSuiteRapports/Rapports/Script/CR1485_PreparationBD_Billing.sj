//USEUNIT CR1485_Common_functions


/**
    Préparation pour les cas suivants :
    
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\33. Frais de gestion\1.1 Relations
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\46. Rapport sommaire de la facturation\1. Relations
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\46. Rapport sommaire de la facturation\2. Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\46. Rapport sommaire de la facturation\3. Comptes
*/
function CR1485_PreparationBD_Billing()
{
    try {
        ActivatePrefsForBilling();
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Ouvrir la fenêtre de Configurations
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
        
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(1000);
        Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
        
        //Get_WinFeeMatrixConfiguration().Parent.Maximize();
        EmptyBillingFeeMatrix();
        FillBillingFeeMatrix(filePath_ReportsCR1485, "PreparationBD_Rapport033", 2, 3);
        //Get_WinFeeMatrixConfiguration().Parent.Restore();
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Log.Message("Bug JIRA CROES-8999");
    
        Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
    
        //DeleteCR1485FeeSchedule();
    
        Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
    
        var name = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 46, language);
        var access = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 47, language);
        var ratePattern = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 48, language);
        var tieredCalculationMethod = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 49, language);
        var showMinMax = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 50, language);
    
        Get_WinFeeTemplateEdit_TxtName().Keys(name);
        SelectComboBoxItem(Get_WinFeeTemplateEdit_CmbAccess(), access);
        SelectComboBoxItem(Get_WinFeeTemplateEdit_CmbRatePattern(), ratePattern);
        Get_WinFeeTemplateEdit_ChkTieredCalculationMethod().set_IsChecked(tieredCalculationMethod == "VRAI" || tieredCalculationMethod == "TRUE");
        Get_WinFeeTemplateEdit_ChkShowMinMax().set_IsChecked(showMinMax == "VRAI" || showMinMax == "TRUE");
    
        Get_WinFeeTemplateEdit_BtnOK().Click();
        Get_WinBillingConfiguration_BtnOK().Click();
        Get_WinConfigurations().Close();
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(exception_CR1485_PreparationBD_Billing) {
        Log.Error("Bug JIRA CROES-8999");
        Log.Error("Exception from CR1485_PreparationBD_Billing(): " + exception_CR1485_PreparationBD_Billing.message, VarToStr(exception_CR1485_PreparationBD_Billing.stack));
        exception_CR1485_PreparationBD_Billing = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}


function ActivatePrefsForBilling()
{
    //Activer les prefs pour le billing (rapports 33 et 46)
    Activate_Inactivate_PrefBranch("0", "PREF_REPORT_BILLING_SUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefBranch("0", "PREF_BILLING", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefBranch("0", "PREF_BILLING_FEESCHEDULE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefBranch("0", "PREF_BILLING_GRID", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    Activate_Inactivate_PrefBranch("0", "PREF_BILLING_PROCESS", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);

    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);

    //redémarrer les services
    RestartServices(vServerReportsCR1485);
}



function RestoreBillingConfiguration()
{
    var numTry = 0;
    do {
        Delay(5000);
        Get_MenuBar_Tools().Click();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
    Get_WinConfigurations().Parent.Maximize();
    
    Delay(1000);
    Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
    Delay(1000);
    Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
    
    DeleteCR1485FeeSchedule();
    Get_WinBillingConfiguration_BtnOK().Click();
    
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    RestoreBillingFeeMatrixForUS();
    Get_WinConfigurations().Close();
}



/**
    excelFilePath : chemin d'accès du fichier de données Excel
    excelSheetName : nom de la feuille Excel
    nbrLignes : nombre de lignes de la matrice de frais
    j : offset des données du fichier Excel (première ligne moins un)
*/
function FillBillingFeeMatrix(excelFilePath, excelSheetName, nbrLignes, j)
{
    // boucler sur la grille selon le nombre de ligne de la grille
    for (k = 1; k <= nbrLignes; k++){
        //boucler sur les cellules de la grille selon la ligne
        i = 3;
        while (i < 31){
            for (p = 1; p <= 2; p++){
                j++;
                i = (p == 2)? i + 1 : i;
                excelValue = GetData(excelFilePath, excelSheetName, j, language);
                CellValuePresenter = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
                CellValuePresenter.Click();
                XamMaskedEditor = CellValuePresenter.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
                XamMaskedEditor.Keys(excelValue);
                i = (p == 2)? i + 2 : i;
            }
        }
    }
}



function RestoreBillingFeeMatrixForUS()
{
    try {
        //Get_WinFeeMatrixConfiguration().Parent.Maximize();
    
        EmptyBillingFeeMatrix();
    
        //Click on the first row
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
    
        //Create ranges (rows)
        for(j = 0; j < 5; j++){
            tailleGrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
            Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(tailleGrille - 2).set_IsSelected(true);
            Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(tailleGrille - 2).set_IsActive(true);
            Delay(1000);
            Get_WinFeeMatrixConfiguration_BtnSplit().Click();
            Delay(1000);
            Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing, "CR885", j + 303, language));
            Delay(1000);
            Get_WinAddRange_BtnOK().Click();
        }
    
        //Remplir les valeurs de la grille
        nbrLignes = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        FillBillingFeeMatrix(filePath_Billing, "CR885", nbrLignes, 111);
    
        //Get_WinFeeMatrixConfiguration().Parent.Restore();
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Log.Message("Bug JIRA CROES-8999");
    }
    catch(e) {
        Log.Error("Bug JIRA CROES-8999");
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
    }
} 



function EmptyBillingFeeMatrix()
{
    TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
    Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
    Delay(1000);
    
    while (Get_WinFeeMatrixConfiguration_BtnMerge().IsEnabled){
        Get_WinFeeMatrixConfiguration_BtnMerge().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        Delay(1000);
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
        Delay(1000);
    } 
} 



function DeleteCR1485FeeSchedule()
{
    feeScheduleName = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 46, language);
    searchResult = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild("Value", feeScheduleName, 10);
    
    if (!searchResult.Exists)
        Log.Message("Fee Schedule '" + feeScheduleName + "' not found.");
    else {
        searchResult.Click();
        Delay(500);
        if (!Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().IsEnabled)
            Log.Error("The Delete button of the fee schedule tab is disabled!")
        else {
            Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
    }
}


