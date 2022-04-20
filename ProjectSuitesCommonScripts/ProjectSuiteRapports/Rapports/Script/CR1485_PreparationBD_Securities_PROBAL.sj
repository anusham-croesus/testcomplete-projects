//USEUNIT CR1485_Common_functions



//Configure l'indice PROBAL pour les rapports 137, 138, 139
function CR1485_PreparationBD_Securities_PROBAL()
{
    try {
        var subcategory = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 43, language);
        var frenchDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 44, language);
        var englishDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 45, language);
        var indexDescription = (language == "french")? frenchDescription: englishDescription;
        var country = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 46, language);
        var currency = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 47, language);
        var calculationFactor = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 48, language);
        var mainSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 49, language);
        
        var report_PerformanceSummarizedIA = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 2, language);
        var report_PerformanceSummarizedRegion = GetData(filePath_ReportsCR1485, "138_Summarized_Region", 2, language);
        var report_PerformanceSummarizedBranch = GetData(filePath_ReportsCR1485, "139_Summarized_Branch", 2, language);
        
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");

        Log.Message("Se connecter avec l'usager UNI00");
        Login(vServerReportsCR1485, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Vérifier s'il existe déjà un titre de même nom '" + indexDescription + "'.");
        Search_SecurityByDescription(indexDescription);
        if (Get_SecurityGrid().FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "Description", indexDescription], 10).Exists)
            Log.Error("Il existe, préalablement, un titre de même nom '" + indexDescription + "'.");
        else
            Log.Message("Il n'existe pas, préalablement, un titre de même nom '" + indexDescription + "'.");
        
        //1. Créer le titre 'PROBAL'
        Log.Message("1. Créer le titre 'PROBAL'");
        ClickOnToolbarAddButton();
        Get_WinCreateSecurity_GrpFinancialInstrument_RdoReal().set_IsChecked(true);
        Get_WinCreateSecurity_LstCategories_ItemIndex().set_IsSelected(true);
        Get_WinCreateSecurity_BtnOK().Click();
    
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), subcategory);
        if (client == "US")
            Get_WinInfoSecurity_GrpDescription_TxtDescription().Keys(englishDescription);
        else {
            Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
            Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
        }
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCountry(), country);
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), currency);
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), calculationFactor);
        Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol().Keys(mainSymbol);
        Get_WinInfoSecurity_BtnOK().Click();
        
        //2. Composition de l'index du titre 'PROBAL'
        Log.Message("2. Composition de l'index du titre 'PROBAL'");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Search_SecurityByDescription(indexDescription);
        Get_SecurityGrid().FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "Description", indexDescription], 10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabIndexComposition().Click();
        Get_WinInfoSecurity_TabIndexComposition().WaitProperty("IsSelected", true, 60000);
        
        var indexSECUFIRME = VarToStr(Get_WinInfoSecurity_GrpDescription_TxtSecurity().Text);
        Log.Message("SECUFIRME = '" + indexSECUFIRME + "'");
        if (Trim(indexSECUFIRME) == "")
            Log.Error("Le SECUFIRME de l'indice est vide.");
        
        var index1Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 52, language);
        var index1PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 53, language));
        SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl(), index1Description, index1PercentValue);
        
        var index2Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 54, language);
        var index2PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 55, language));
        SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl(), index2Description, index2PercentValue);
        
        var index3Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 56, language);
        var index3PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 57, language));
        SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl(), index3Description, index3PercentValue);
        
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Fermer Croesus
        CloseCroesus();
        
        //3. Valider que l'indice appartient à la catégorie 54 : select * from b_titre where catego=54
        var nbOfProbalRecordsSQL = "select count(*) as NB_RECORDS from B_TITRE where CATEGO = 54 and SECUFIRME = '" + indexSECUFIRME + "'";
        Log.Message("3. Valider que l'indice appartient à la catégorie 54 : select * from b_titre where catego=54", nbOfProbalRecordsSQL);
        var nbOfProbalRecords = Execute_SQLQuery_GetField(nbOfProbalRecordsSQL, vServerReportsCR1485, "NB_RECORDS");
        if (nbOfProbalRecords == 1)
            Log.Message("1 indice PROBAL dont CATEGO = 54 et SECUFIRME = '" + indexSECUFIRME + "' trouvé comme attendu.");
        else
            Log.Error(nbOfProbalRecords + " indice(s) PROBAL dont CATEGO = 54 et SECUFIRME = '" + indexSECUFIRME + "' trouvé(s) au lieu de : 1 attendu.");
        
        //4. Mettre à jour le symbole de l'indice : update b_titre set symbole = 'ProBal' where DESC_L1='PROBAL'
        var descriptionHeader = (language == "french")? "DESC_L1": "DESC_L2";
        var updateSQL = "update B_TITRE set SYMBOLE = '" + mainSymbol + "' where " + descriptionHeader + " = '" + indexDescription + "'";
        Log.Message("4. Mettre à jour le symbole de l'indice : update b_titre set symbole = 'ProBal'", updateSQL);
        Execute_SQLQuery(updateSQL, vServerReportsCR1485);
        var updateVerifSQL = "select SYMBOLE from B_TITRE where SECUFIRME = '" + indexSECUFIRME + "'";
        Log.Message("Vérifier si la mise à jour a été bien faite.", updateVerifSQL);
        var actualSymbol = Execute_SQLQuery_GetField(updateVerifSQL, vServerReportsCR1485, "SYMBOLE");
        if (actualSymbol == mainSymbol)
            Log.Message("La mise à jour s'est passée correctement : SYMBOLE = '" + actualSymbol + "' pour SECUFIRME = '" + indexSECUFIRME + "'");
        else
            Log.Error("La mise à jour ne s'est pas passée correctement : SYMBOLE = '" + actualSymbol + "' (au lieu de '" + mainSymbol + "') pour SECUFIRME = '" + indexSECUFIRME + "'");
        
        //5. Rouler le script "Performance sommaire (CR395)" afin de mettre à jour les paramètres des packages : https://confluence.croesus.com/pages/viewpage.action?pageId=3440650
        var CR395SqlFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR395.sql";
        Log.File(CR395SqlFilePath, "5. Rouler le script \"Performance sommaire (CR395)\" afin de mettre à jour les paramètres des packages : https://confluence.croesus.com/pages/viewpage.action?pageId=3440650");
        var strISQLOutput = ExecuteSQLFile_ThroughISQL(CR395SqlFilePath, vServerReportsCR1485);
        if (strISQLOutput !== null){
            var arrISQLOutputLines = strISQLOutput.split("\n");
            for (var i in arrISQLOutputLines){
                if (aqString.StrMatches("^Msg\\b\\z\,\\b\Level\\b\\z\,\\b\State\\b\\z\:$", Trim(arrISQLOutputLines[i]))){ //Example : "Msg 2812, Level 16, State 5:";
                    Log.Error("Présence de Message(s) d'erreur d'exécution SQL, fichier du script 'Performance sommaire (CR395)' : " + CR395SqlFilePath, strISQLOutput);
                    break;
                }
            }
        }
        
        //6. Restart des services
        Log.Message("6. Restart des services.");
        RestartServices(vServerReportsCR1485);
        
        //7. Avec l'user GP1859 valider que l'indice "PROBAL" et l'indice de référence "PROBAL" soient cochés dans les rapports concernés
        Log.Message("7. Avec l'user GP1859 valider que l'indice \"PROBAL\" et l'indice de référence \"PROBAL\" soient cochés dans les rapports concernés.");
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        
        Log.Message("Validate Index selection in Accounts module.");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedIA, indexDescription);
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedRegion, indexDescription);
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedBranch, indexDescription);
        Get_WinReports_BtnClose().Click();
        
        Log.Message("Validate Index selection in Clients module.");
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedIA, indexDescription);
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedRegion, indexDescription);
        ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedBranch, indexDescription);
        Get_WinReports_BtnClose().Click();
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(exception_CR1485_PreparationBD_Securities_PROBAL) {
        Log.Error("Exception from CR1485_PreparationBD_Securities_PROBAL(): " + exception_CR1485_PreparationBD_Securities_PROBAL.message, VarToStr(exception_CR1485_PreparationBD_Securities_PROBAL.stack));
        exception_CR1485_PreparationBD_Securities_PROBAL = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function ValidateThatIndexIsSelectedInReports(reportName, indexDescription)
{
    Log.Message("Validate that Index '" + indexDescription + "' is selected in reports '" + reportName + "'.");
    SelectFirmSavedReport(reportName);
    Get_Reports_GrpReports_BtnRemoveAllReports().WaitProperty("IsEnabled", true, 30000);
    var currentReportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.get_Count();
    for (var currentReportIndex = 1; currentReportIndex <= currentReportsCount; currentReportIndex++){
        var currentReport = Get_Reports_GrpReports_LvwCurrentReports().WPFObject("ListBoxItem", "", currentReportIndex);
        var currentReportName = VarToStr(currentReport.WPFControlText);
        currentReport.set_IsSelected(true);
        WaitObject(Get_Reports_GrpReports_GrpCurrentParameters_TxtCurrentParameters(), ["ClrClassName", "IsVisible"], ["UniLabel", true], 60000); //Attendre que les paramètres courants soient affichés pour le rapport sélectionné
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000);
        Delay(3000);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 60000);
        WaitReportParametersWindow(60000);
        
        //valider que l'indice est coché
        if (!Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", indexDescription], 10).IsChecked.OleValue)
            Log.Error("Index '" + indexDescription + "' is not checked for report at Position " + currentReportIndex + " (" + currentReportName + ").");
        
        //valider que l'indice est sélectionné comme Indice de référence
        if (Get_WinParameters_GrpComparative_CmbReferentialIndex().Text.OleValue != indexDescription)
            Log.Error("Index '" + indexDescription + "' is not selected as Comparative Referential Index for report at Position " + currentReportIndex + " (" + currentReportName + ").");
        
        Get_WinParameters_BtnCancel().Click();
    }
    Get_Reports_GrpReports_BtnRemoveAllReports().Click();
}


