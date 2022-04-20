//USEUNIT CR1485_Common_functions


/**
    Préparer les titres pour les rapports 114 et 115
*/
function CR1485_PreparationBD_Securities_Morningstar()
{
    Log.Message("CR1485_PreparationBD_Securities_Morningstar()");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\114. Annexe Anatomie du portefeuille\\Configuration indices MorningStar\\1. Configuration indices MorningStar.txt", "Pour ouvrir le Document de la Configuration à faire relative à MorningStar, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        //Copier le fichier morningstar.pfx vers /etc/finansoft/ et /var/lib/finansoft/
        var morningstarVserverRemoteFolder = "/etc/finansoft/";
        var varLibFinansoftVserverRemoteFolder = "/var/lib/finansoft/";
        var morningstarLocalFolderPath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Morningstar\\";
        var morningstarFileName = "morningstar.pfx";
        TryConnexionAndTrustHostKeyThroughWinSCP(vServerReportsCR1485);
        CopyFileToVserverThroughWinSCP(vServerReportsCR1485, morningstarVserverRemoteFolder, morningstarLocalFolderPath + morningstarFileName);
        CopyFileToVserverThroughWinSCP(vServerReportsCR1485, varLibFinansoftVserverRemoteFolder, morningstarLocalFolderPath + morningstarFileName);
        
        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Activer les prefs pour l'intégration avec Morningstar (rapports 114 et 115)
        Activate_Inactivate_Pref(userNameGP1859, "PREF_ENABLE_INTEGRATIONS_TAB", "YES", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_MSTAR_XRAY", "YES", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_SHOW_MSTAR_XRAY", "1", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_MSTAR_SNAPSHOT", "YES", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_SHOW_MSTAR_SNAPSHOT", "1", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
        
        //Login
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        
        //Créer le titre 'GLOBAL BLEND'
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        ClickOnToolbarAddButton();
        
        Get_WinCreateSecurity_LstCategories_ItemIndex().set_IsSelected(true);
        Get_WinCreateSecurity_BtnOK().Click();
        
        var subcategory = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 4, language);
        var frenchDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 5, language);
        var englishDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 6, language);
        var country = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 7, language);
        var currency = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 8, language);
        var calculationFactor = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 9, language);
        var mainSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 10, language);
        var foreignProperty = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 11, language);
        
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
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), foreignProperty);
    
        Get_WinInfoSecurity_BtnOK().Click();
        
    
        //Composition de l'index du titre 'GLOBAL BLEND'
        Search_SecurityBySymbol(mainSymbol);
        Get_SecurityGrid().FindChild("Value", mainSymbol, 10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabIndexComposition().Click();
        Get_WinInfoSecurity_TabIndexComposition().WaitProperty("IsSelected", true, 60000);
    
        var index1Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 14, language);
        var index1PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 15, language));
        SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl(), index1Description, index1PercentValue);
    
        var index2Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 16, language);
        var index2PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 17, language));
        SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl(), index2Description, index2PercentValue);
    
        
        //Intégration du titre 'GLOBAL BLEND'
        Get_WinInfoSecurity_TabIntegrations().Click();
        Get_WinInfoSecurity_TabIntegrations().WaitProperty("IsSelected", true, 60000);
    
        var integrationPartner = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 20, language);
        var identifierType = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 21, language);
        var identifierValue = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 22, language);
        SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), integrationPartner);
        SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType(), identifierType);
        Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().SetText(identifierValue);
        Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().Keys("[Tab]");
    
        Get_WinInfoSecurity_BtnOK().Click();
    
        
        //Intégration des titres MS EAFE, S&P 500 et NASDAQ-100
        for (var i = 0; i < 3; i++){
            var offset = 24 + (i*6);
            var securityDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 1, language);
            var integrationPartner = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 2, language);
            var identifierType = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 3, language);
            var identifierValue = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 4, language);
    
            SetIntegrationForSecurity(securityDescription, integrationPartner, identifierType, identifierValue);
        }
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(exception_CR1485_PreparationBD_Securities_Morningstar) {
        Log.Error("Exception from CR1485_PreparationBD_Securities_Morningstar(): " + exception_CR1485_PreparationBD_Securities_Morningstar.message, VarToStr(exception_CR1485_PreparationBD_Securities_Morningstar.stack));
        exception_CR1485_PreparationBD_Securities_Morningstar = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}
