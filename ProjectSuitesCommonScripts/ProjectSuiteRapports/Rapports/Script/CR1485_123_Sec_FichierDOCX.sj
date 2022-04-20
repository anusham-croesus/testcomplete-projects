//USEUNIT CR1485_123_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\123. Ajouter un fichier\5. Titres\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_123_Sec_FichierDOCX()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\123. Ajouter un fichier\\5. Titres\\", "CR1485_123_Sec_FichierDOCX()");
    var logAttributesBold = Log.CreateNewAttributes();
    logAttributesBold.Bold = true;
    Log.Message("Pré-requis : CR1485_123_Common_functions.ActivateDelegator() exécutée dans CR1485_PreparationBD_Misc().", "", pmNormal, logAttributesBold);
    Log.Link("https://jira.croesus.com/browse/SUP-6156", "En cas d'échec de la génération de rapport, la cause pourrait être associée au WordGenerator (VMqawin down), dont la vérification du bon fonctionnement n'est pas automatisée. Voir par exemple Jira SUP-6156.", "", pmNormal, logAttributesBold);
    Log.Message("Jira : SUP-6156, SUP-6086, SUP-5997, TCVE-6739, TCVE-6405, CROES-10740");
    Log.Message("Bug JIRA QAV-727 : GP1859 / Ajouter un fichier : Erreur de connexion (Impact aussi sur Autres rapports qui contiennent un document externe)");
    
    try {
        var coupledReportName = GetData(filePath_ReportsCR1485, "050_SECURITY_HELD", 1, language);
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "123_Add_a_File", 113, language);
        var sortBy = GetData(filePath_ReportsCR1485, "123_Add_a_File", 114, language);
        var currency = GetData(filePath_ReportsCR1485, "123_Add_a_File", 115, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 116, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "123_Add_a_File", 117, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "123_Add_a_File", 118, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "123_Add_a_File", 119, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "123_Add_a_File", 120, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 121, language);
        var message = GetData(filePath_ReportsCR1485, "123_Add_a_File", 122, language);
        
        //External documents Parameters values
        var checkOneFilePerLanguage = GetBooleanValue(GetData(filePath_ReportsCR1485, "123_Add_a_File", 125, language));
        var arrayOfFilesNames = GetData(filePath_ReportsCR1485, "123_Add_a_File", 126, language).split("|");
        var arrayOfFilesFullPaths = new Array();
        for (var j in arrayOfFilesNames) arrayOfFilesFullPaths.push(GetExternalDocumentsDefaultFolderPath() + Trim(arrayOfFilesNames[j]));
        var numbering = null;
        var reportTitle = null;
        var checkUseDefaultTheme = GetBooleanValue(GetData(filePath_ReportsCR1485, "123_Add_a_File", 129, language));
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SECURITY_HELD", "YES", vServerReportsCR1485); //Pour le rapport jumelé, Rapport 050.
        ActivatePrefs(userNameReportsCR1485);
        
        //Login and goto Securities module and Select no security
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "123_Add_a_File", 110);
        
        //Open Reports window and Select reports
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        AddExternalDocumentsReportsWithSameParameters(arrayOfFilesFullPaths, reportTitle, numbering, checkUseDefaultTheme, checkOneFilePerLanguage, true);
        SelectAReport(coupledReportName);
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "123_Add_a_File", 133);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "123_Add_a_File", 136, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 137, language);
        
        //Open Reports window and Select reports
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        AddExternalDocumentsReportsWithSameParameters(arrayOfFilesFullPaths, reportTitle, numbering, checkUseDefaultTheme, checkOneFilePerLanguage, true);
        SelectAReport(coupledReportName);
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefs(userNameReportsCR1485);
        Terminate_CroesusProcess();
        
        //Log.Message("Redémarrer le vserver car sur la version 'ref90-09-Er-3--V9-croesus-co7x-1_4_546', il a été observé que l'activation du Delegator fait crasher le service 'cfreportgenerator'.");
        //RestartVserver(vServerReportsCR1485);
    }
    
}
