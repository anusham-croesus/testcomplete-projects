//USEUNIT CR1485_123_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\123. Ajouter un fichier\0. Modèles\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_123_Mod_FichierPDF()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\123. Ajouter un fichier\\0. Modèles\\", "CR1485_123_Mod_FichierPDF()");
    Log.Message("Bug JIRA QAV-727 : GP1859 / Ajouter un fichier : Erreur de connexion (Impact aussi sur Autres rapports qui contiennent un document externe)");
    
    try {
        var coupledReportName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 2, language);
        var modelName = GetData(filePath_ReportsCR1485, "123_Add_a_File", 142);
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "123_Add_a_File", 147, language);
        var sortBy = GetData(filePath_ReportsCR1485, "123_Add_a_File", 148, language);
        var currency = GetData(filePath_ReportsCR1485, "123_Add_a_File", 149, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 150, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "123_Add_a_File", 151, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "123_Add_a_File", 152, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "123_Add_a_File", 153, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "123_Add_a_File", 154, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 155, language);
        var message = GetData(filePath_ReportsCR1485, "123_Add_a_File", 156, language);
        
        //External documents Parameters values
        var checkOneFilePerLanguage = GetBooleanValue(GetData(filePath_ReportsCR1485, "123_Add_a_File", 159, language));
        var arrayOfFilesNames = GetData(filePath_ReportsCR1485, "123_Add_a_File", 160, language).split("|");
        var arrayOfFilesFullPaths = new Array();
        for (var j in arrayOfFilesNames) arrayOfFilesFullPaths.push(GetExternalDocumentsDefaultFolderPath() + Trim(arrayOfFilesNames[j]));
        var numbering = null;
        var reportTitle = null;
        var checkUseDefaultTheme = GetBooleanValue(GetData(filePath_ReportsCR1485, "123_Add_a_File", 163, language));
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RESTRICTION_CRITERIA", "YES", vServerReportsCR1485);//Pour le rapport jumelé, Rapport 081.
        ActivatePrefs(userNameReportsCR1485);
        
        //Login and goto Models module and Select Model
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        SearchModelByName(modelName);
        Get_ModelsGrid().FindChild("Value", modelName, 10).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "123_Add_a_File", 144);
        
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
        
        var reportFileName = GetData(filePath_ReportsCR1485, "123_Add_a_File", 167);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "123_Add_a_File", 170, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "123_Add_a_File", 171, language);
        
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
    }
    
}
