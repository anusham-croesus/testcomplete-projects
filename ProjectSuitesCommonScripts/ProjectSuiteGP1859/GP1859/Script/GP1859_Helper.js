//USEUNIT CR1485_Common_functions

var GP1859_DEFAULT_THEMES_ID = "Default_Themes";
var GP1859_WHITELABELS_THEMES_ID = "WhiteLabels_Themes";



/**
    Thèmes utilisés :
    FBN (WhiteLabels) : https://drive.google.com/drive/u/0/folders/1RdrVe09T6oV3d67zsJ4qWsRhDidUSZJJ
    GP1859 : https://drive.google.com/drive/u/0/folders/1NgN3bbGABvkiddQTnTaykCJf_9lJnSkQ

    Étapes pour changer le thème : 

    Préconditions : Les thèmes GP1859 sont déjà loadés dans le dump fournit
    
    Étapes pour changer les thèmes :
    User : UNI00
    1. Loader les thèmes FBN (WhiteLabels) au niveau « GLOBAL » : Outils / configurations / rapports / configurations des défauts / thème / Global / 
    2. Importer / Parcourir … / « Sélectionner le dossier où se trouvent les thèmes » / Pour chaque thème / Mettre le même nom du fichier PDF dans le champ « Nom du thème » dans les 2 langues / OK
    3. Répéter l’étape 2 selon le nombre de thèmes à importer
    4. Clique sur annuler (pour éviter de changer le thème des tous les rapports de la BD)
    5. Configurations des défauts / Configuration spécifique / Sélectionner le rapport « Évaluation du portefeuille (trimestriel) / déployer les options / Thème / décocher « Utiliser le défaut » / assigner les thèmes selon l’excel (DAS-4677_Thèmes.xlsx) / OK
    6. Faire un restart du vserver. 
*/

function ConfigureReportsThemes(themeID, importThemes, assignThemesToReports, verifyPriorAssignedThemes)
{
    
    try {
        UpdatePaths(themeID);
        var themesColumnName = client + "_" + VarToStr(themeID);
        var themesFolderPath = folderPath_Data + "ReportsThemes" + "\\" + client + "\\" + Trim("GP1859" + " " + VarToStr(Global_variables.GP1859_FOLDER_SUFFIX_THEME_ID));
        var detailedDescription = aqFile.ReadWholeTextFile(folderPath_Data + "ReportsThemes\\GP1859_Themes_Configuration.txt", aqFile.ctUTF8);
        Log.Link("https://jira.croesus.com/browse/QAS-55", "ConfigureReportsThemes()", detailedDescription);
    
        if (importThemes != undefined && importThemes == false && assignThemesToReports != undefined && assignThemesToReports == false && verifyPriorAssignedThemes != undefined && verifyPriorAssignedThemes == false)
            return;
                
        //Liste des rapports GP1859
        var arrayOfReportsGP1859 = [];
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        Excel.DisplayAlerts = false;
        Excel.Workbooks.Open(filePath_GP1859).Sheets.Item("ReportsThemes").Activate();
        var rowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
        for (var i = 2; i <= rowCount; i++)
            arrayOfReportsGP1859.push(VarToStr(Excel.Cells.Item(i, 1)));
        Excel.Quit();
        TerminateProcess("EXCEL");
        
        //Se connecter avec UNI00 (GP1859)
        var configUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var configUserPswd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Activer Prefs
        Log.Message("ACTIVER PREFS");
        var isUpdated_PREF_EDIT_FIRM_FUNCTIONS = null;
        var previousValue_PREF_EDIT_FIRM_FUNCTIONS = GetUserPrefValue(vServerGP1859, "PREF_EDIT_FIRM_FUNCTIONS", configUserName);
        if (previousValue_PREF_EDIT_FIRM_FUNCTIONS != "YES"){
            Activate_Inactivate_Pref(configUserName, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerGP1859);
            isUpdated_PREF_EDIT_FIRM_FUNCTIONS = !(previousValue_PREF_EDIT_FIRM_FUNCTIONS === GetUserPrefValue(vServerGP1859, "PREF_EDIT_FIRM_FUNCTIONS", configUserName));
        }
        
        var isUpdated_PREF_RPT_CONFIG_SAC = null;
        var previousValue_PREF_RPT_CONFIG_SAC = GetUserPrefValue(vServerGP1859, "PREF_RPT_CONFIG_SAC", configUserName);
        if (previousValue_PREF_RPT_CONFIG_SAC != "YES"){
            Activate_Inactivate_Pref(configUserName, "PREF_RPT_CONFIG_SAC", "YES", vServerGP1859);
            isUpdated_PREF_RPT_CONFIG_SAC = !(previousValue_PREF_RPT_CONFIG_SAC === GetUserPrefValue(vServerGP1859, "PREF_RPT_CONFIG_SAC", configUserName));
        }
        
        if (isUpdated_PREF_EDIT_FIRM_FUNCTIONS === true || isUpdated_PREF_RPT_CONFIG_SAC === true){
            Delay(30000);
            RestartServices(vServerGP1859);
        }
        
        //Ouvrir la fenêtre de Configurations
        Login(vServerGP1859, configUserName, configUserPswd, language);
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().Parent.Maximize();
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        
        //Importer les thèmes
        if (importThemes !== false){
            Log.Message("IMPORTER LES THÈMES");
            var nbOfThemeFileToImport = 0;
            var arrayOfThemesFilesPaths = [];
            for (var i = 0; i < arrayOfReportsGP1859.length; i++){
                var themeFileName = ReadDataFromExcelByRowIDColumnID(filePath_GP1859, "ReportsThemes", arrayOfReportsGP1859[i], themesColumnName);
                var themeFilePath = aqFileSystem.IncludeTrailingBackSlash(themesFolderPath) + themeFileName;
                if (!aqFileSystem.Exists(themeFilePath))
                    Log.Error("Fichier de thème '" + themeFileName + "' non trouvé : " + themeFilePath, "Fichier de thème '" + themeFileName + "' non trouvé : \r\n" + themeFilePath);
                else {
                    arrayOfThemesFilesPaths[aqFileSystem.GetFileNameWithoutExtension(themeFilePath)] = themeFilePath;
                    nbOfThemeFileToImport++;
                }
            }
            
            if (nbOfThemeFileToImport > 0){
                Delay(5000);
                var nbTries = 0;
                do {
                    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();
                } while((++nbTries) <= 3 && !Get_WinDefaultConfiguration().Exists)
                Get_WinDefaultConfiguration().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
                
                Get_WinDefaultConfiguration_TvwTreeview_LlbTheme().Click();
                if (true != Get_WinDefaultConfiguration_RdoGlobal().IsChecked.OleValue)
                    Get_WinDefaultConfiguration_RdoGlobal().Click();
                ImportThemesInDefaultConfigurationWindow(arrayOfThemesFilesPaths);
                Get_WinDefaultConfiguration_BtnCancel().Click();
            }
        }
        
        //Assigner à chaque rapport son thème
        if (assignThemesToReports !== false || verifyPriorAssignedThemes !== false){
            var nbOfReportsToAssignATheme = 0;
            var arrayOfReportsThemes = [];
            for (var i = 0; i < arrayOfReportsGP1859.length; i++){
                var reportName = ReadDataFromExcelByRowIDColumnID(filePath_GP1859, "ReportsThemes", arrayOfReportsGP1859[i], "ReportName_" + language).split("|")[0];
                var themeFileName = ReadDataFromExcelByRowIDColumnID(filePath_GP1859, "ReportsThemes", arrayOfReportsGP1859[i], themesColumnName);
                var themeFilePath = aqFileSystem.IncludeTrailingBackSlash(aqFileSystem.GetCurrentFolder()) + themeFileName;
                aqFile.WriteToTextFile(themeFilePath, themeFileName, aqFile.ctANSI, true);
                if (!aqFileSystem.Exists(themeFilePath))
                    Log.Error("Erreur lors de traitement relatif au rapport '" + reportName + "' : " + themeFilePath, "Erreur lors de traitement relatif au rapport '" + reportName + "' : \r\n" + themeFilePath);
                else {
                    arrayOfReportsThemes[reportName] = aqFileSystem.GetFileNameWithoutExtension(themeFilePath);
                    aqFileSystem.DeleteFile(themeFilePath);
                    nbOfReportsToAssignATheme++;
                }
            }
            
            if (nbOfReportsToAssignATheme > 0){
                Delay(5000);
                var nbTries = 0;
                do {
                    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();
                } while((++nbTries) <= 3 && !Get_WinDefaultConfiguration().Exists)
                Get_WinDefaultConfiguration().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
                
                if (verifyPriorAssignedThemes !== false){
                    Log.Message("VERIFIER LES THÈMES ASSIGNÉS AUX RAPPORTS");
                    for (var reportName in arrayOfReportsThemes){
                        var objSpecificConfigurationReportTheme = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem_LlbTheme(reportName);
                        objSpecificConfigurationReportTheme.HoverMouse();
                        objSpecificConfigurationReportTheme.Click();
                        Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(reportName).HoverMouse();
                        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
                        CheckEquals(VarToStr(Get_WinDefaultConfiguration_CmbTheme().Text), arrayOfReportsThemes[reportName], "Theme for report '" + reportName + "'");
                    }

                }
                
                if (assignThemesToReports !== false){
                    Log.Message("ASSIGNER LES THÈMES AUX RAPPORTS");
                    AssignSpecificConfigurationThemeToEachReport(arrayOfReportsThemes);
                }
                
                Get_WinDefaultConfiguration_BtnOK().Click();
            }
        }
        
        //Fermer la fenêtre de Configurations et Croesus
        Get_WinConfigurations().Close();
        CloseCroesus();
        
        //Redémarrer le vserver
        Log.Message("RESTAURER PREFS");
        if (isUpdated_PREF_EDIT_FIRM_FUNCTIONS !== null && isUpdated_PREF_EDIT_FIRM_FUNCTIONS === true)
            Activate_Inactivate_Pref(configUserName, "PREF_EDIT_FIRM_FUNCTIONS", previousValue_PREF_EDIT_FIRM_FUNCTIONS, vServerGP1859);
        
        if (isUpdated_PREF_RPT_CONFIG_SAC !== null && isUpdated_PREF_RPT_CONFIG_SAC === true)
            Activate_Inactivate_Pref(configUserName, "PREF_RPT_CONFIG_SAC", previousValue_PREF_RPT_CONFIG_SAC, vServerGP1859);
        
        RestartVserver(vServerGP1859);
    }
    catch(exception_ConfigureReportsThemes){
        Log.Error("Exception in ConfigureReportsThemes() : " + exception_ConfigureReportsThemes.message, VarToStr(exception_ConfigureReportsThemes.stack));
        exception_ConfigureReportsThemes = null;
        
        Log.Message("RESTAURER PREFS");
        if (isUpdated_PREF_EDIT_FIRM_FUNCTIONS !== null && isUpdated_PREF_EDIT_FIRM_FUNCTIONS === true)
            Activate_Inactivate_Pref(configUserName, "PREF_EDIT_FIRM_FUNCTIONS", previousValue_PREF_EDIT_FIRM_FUNCTIONS, vServerGP1859);
        
        if (isUpdated_PREF_RPT_CONFIG_SAC !== null && isUpdated_PREF_RPT_CONFIG_SAC === true)
            Activate_Inactivate_Pref(configUserName, "PREF_RPT_CONFIG_SAC", previousValue_PREF_RPT_CONFIG_SAC, vServerGP1859);
        
        RestartVserver(vServerGP1859);
    }
    finally {
        /*
        if (isUpdated_PREF_EDIT_FIRM_FUNCTIONS !== null && isUpdated_PREF_EDIT_FIRM_FUNCTIONS === true)
            Activate_Inactivate_Pref(configUserName, "PREF_EDIT_FIRM_FUNCTIONS", previousValue_PREF_EDIT_FIRM_FUNCTIONS, vServerGP1859);
        
        if (isUpdated_PREF_RPT_CONFIG_SAC !== null && isUpdated_PREF_RPT_CONFIG_SAC === true)
            Activate_Inactivate_Pref(configUserName, "PREF_RPT_CONFIG_SAC", previousValue_PREF_RPT_CONFIG_SAC, vServerGP1859);
        
        if ((isUpdated_PREF_EDIT_FIRM_FUNCTIONS !== null && isUpdated_PREF_EDIT_FIRM_FUNCTIONS === true) || (isUpdated_PREF_RPT_CONFIG_SAC !== null && isUpdated_PREF_RPT_CONFIG_SAC === true)){
            Delay(30000);
            RestartServices(vServerGP1859);
        }
        */
        
        Terminate_CroesusProcess();
    }
}




function UpdatePaths(themeID)
{
    Global_variables.WINDOWS_DISPLAY_LANGUAGE = GetWindowsDisplayLanguage();
    Global_variables.GP1859_FOLDER_SUFFIX_THEME_ID = Trim(VarToStr(themeID));
    Global_variables.REPORTS_FILES_FOLDER_PATH = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "_" + Global_variables.GP1859_FOLDER_SUFFIX_THEME_ID + "\\Temp_Reports\\";
    Global_variables.REPORTS_FILES_BACKUP_FOLDER_PATH = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "_" + Global_variables.GP1859_FOLDER_SUFFIX_THEME_ID + "\\Temp_BackupFromComputer_" + executionComputerName + "\\";
}
