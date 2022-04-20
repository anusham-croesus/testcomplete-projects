//USEUNIT CR1485_Common_functions
//USEUNIT DBA



function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_ENABLE_ADD_FILE_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function RestorePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_ENABLE_ADD_FILE_REPORT", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}


/**
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\123. Ajouter un fichier\Configuration à faire.txt
    Document de référence : https://confluence.croesus.com/pages/viewpage.action?pageId=10584857
*/
function ActivateDelegator(vServerURL)
{
    Log.Message("Activate Delegator on VServer : " + vServerURL);
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\123. Ajouter un fichier\\Configuration à faire.txt", "Pour ouvrir le Document de la Configuration à faire relative à l'activation du Delegator, cliquer sur le lien dans la colonne 'Link'.");
    
    //1. Suivre les étapes qui se trouvent dans Confluence (Delegator)
    Log.Link("https://confluence.croesus.com/pages/viewpage.action?pageId=10584857", "1 : Suivre les étapes qui se trouvent dans Confluence (Delegator)");
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | \"" + folderPath_ProjectSuiteCommonScripts + "plink.exe\" -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ActivateDelegator.sh > ActivateDelegator_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Rapport123_Documents_externes\\ActivateDelegator.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    ExecuteBatchFile(plinkBatchFilePath);
    
    //2. Rouler la requête suivante afin de corriger les données dans la BD (fix du CROES-10740)
    Log.Message("2 : Bug JIRA CROES-10740 : Rouler la requête suivante afin de corriger les données dans la BD (fix du CROES-10740)");
    ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Rapport123_Documents_externes\\ConfigurationCROES-10740.sql", vServerURL);
    
    //3. 12 enregistrements doivent se créer dans la BD
    Log.Message("3 : 12 enregistrements doivent se créer dans la BD");
    var expectedNbOfRecords = 12;
    var queryString = "select count(*) as nbOfRecords from b_struc where tablesrc in ('B_PROFIL', 'B_PROCOM', 'B_PROREL', 'B_PROSEC') and nom_rubr in ('CODE', 'VALEUR', 'TYPE') and index_rub > 1000";
    
    var timeOutForTableUpdate = 60000;
    var timeElapsedDB = 0;
    do {
        var actualNbOfRecords = Execute_SQLQuery_GetField(queryString, vServerURL, "nbOfRecords");
        
        if (aqObject.CompareProperty(actualNbOfRecords, cmpEqual, expectedNbOfRecords, true, lmNone)){
            Delay(5000); //Attendre encore un petit temps pour voir s'il n'y aura pas d'enregistrements supplémentaires
            var actualNbOfRecords = Execute_SQLQuery_GetField(queryString, vServerURL, "nbOfRecords");
            break;
        }
        
        Delay(3000);
        timeElapsedDB += 3000;
    } while (timeElapsedDB < timeOutForTableUpdate)
    
    aqObject.CompareProperty(actualNbOfRecords, cmpEqual, expectedNbOfRecords, true, lmError);
    RestartServices(vServerURL);
}



function GetExternalDocumentsDefaultFolderPath()
{
    return folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Rapport123_Documents_externes\\";
}



/**
    Pour le moment, supporte un fichier commun à toutes les langues
*/
function GetExternalDocumentReportName(fileFullPath)
{
    if (!DoesExternalDocumentMatchExpected(fileFullPath))
        return null;
    
    var externalDocumentReportName = (language == "french")? "Document externe (": "External Document (";
    return externalDocumentReportName + aqFileSystem.GetFileName(fileFullPath) + ")";
}



function DoesExternalDocumentMatchExpected(fileFullPath)
{
    if (!aqFileSystem.Exists(fileFullPath)){
        Log.Error("The specified file '" + fileFullPath + "' does not exist.");
        return false;
    }
    
    var supportedFileExtensions = ["PDF", "DOC", "DOCX"];
    var fileExtension = aqFileSystem.GetFileExtension(fileFullPath);
    if (GetIndexOfItemInArray(supportedFileExtensions, aqString.ToUpper(fileExtension)) == -1){
        Log.Error("File '" + fileFullPath + "' type not supported, supported file extensions : " + supportedFileExtensions);
        return false;
    }
    
    return true;
}



/**
    Pour le moment, supporte un fichier commun à toutes les langues (checkOneFilePerLanguage = false)
    Pour le moment, supporte un titre commun à toutes les langues
*/
function SetReportParameters(fileFullPath, reportTitle, numbering, checkUseDefaultTheme, checkOneFilePerLanguage)
{
    checkOneFilePerLanguage = false; //Pour le moment, supporte un fichier commun à toutes les langues
    
    if (!DoesExternalDocumentMatchExpected(fileFullPath)){
        if (WaitReportParametersWindow(10000))
            Get_WinParameters_BtnCancel().Click();
        
        return;
    }
    
    WaitReportParametersWindow();
    
    if (checkOneFilePerLanguage != undefined)
        Get_WinParameters_ChkOneFilePerLanguage().set_IsChecked(checkOneFilePerLanguage);
    
    Delay(200);
    Get_WinParameters_TxtFileName().Clear();
    Get_WinParameters_TxtFileName().Keys(fileFullPath);
    
    if (reportTitle != undefined){
        Get_WinParameters_TxtReportTitle().Clear();
        Get_WinParameters_TxtReportTitle().Keys(reportTitle);
    }
    
    if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    }
    
    if (checkUseDefaultTheme != undefined)
        Get_WinParameters_ChkUseDefaultTheme().set_IsChecked(checkUseDefaultTheme);
    
    var initialCurrentReportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.Count;
    Delay(300);
    Get_WinParameters_BtnOK().Click();
    
    Delay(2000);
    var nbOfChecks = 0;
    while ((++nbOfChecks < 12) && !(Get_Reports_GrpReports_LvwCurrentReports().Items.Count > initialCurrentReportsCount)){
        Delay(5000);
    }
    
    if (initialCurrentReportsCount < Get_Reports_GrpReports_LvwCurrentReports().Items.Count){
        Log.Message("External document added.");
    }
    else {
        Log.Error("Number of Current Reports did not increase by timeout.");
    }
}



function AddExternalDocumentsReportsWithSameParameters(arrayOfFilesFullPaths, reportTitle, numbering, checkUseDefaultTheme, checkOneFilePerLanguage, clearCurrentReportsListBeforeAddingExternalDocuments)
{
    var reportNameAddAFile = GetData(filePath_ReportsCR1485, "123_Add_a_File", 1, language);
    
    if (clearCurrentReportsListBeforeAddingExternalDocuments == undefined)
        clearCurrentReportsListBeforeAddingExternalDocuments = false;
    
    if (GetVarType(arrayOfFilesFullPaths) != varArray && GetVarType(arrayOfFilesFullPaths) != varDispatch)
        arrayOfFilesFullPaths = new Array(arrayOfFilesFullPaths);
    
    Log.Message("Add report(s) the following external documents :\n" + arrayOfFilesFullPaths.join("\n"), arrayOfFilesFullPaths.join("\n"));
    
    Delay(3000);
    Get_Reports_GrpReports_TabReports().Click();
    Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
    
    if (clearCurrentReportsListBeforeAddingExternalDocuments && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    for (var i in arrayOfFilesFullPaths){
        var fileFullPath = arrayOfFilesFullPaths[i];
        SelectAReport(reportNameAddAFile, true);
        SetReportParameters(fileFullPath, reportTitle, numbering, checkUseDefaultTheme, checkOneFilePerLanguage);
    }
}
