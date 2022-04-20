//USEUNIT CR1806_Helper



/**
    Description : Valider le format du extract -datahubextractor
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4548
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4548_Valider_le_format_du_extract_datahubextractor()
{
    Log.Message("CR1806_4548_Valider_le_format_du_extract_datahubextractor()");
    CR1806_4548_Valider_le_format_du_extract_datahubextractor_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4548_Valider_le_format_du_extract_datahubextractor_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4548", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    Log.Message("JIRA CROES-10234 : Le champ NB_RECORDS et IA_CODES de la table B_data_hub est vide lorsqu'on exporte vers le presse-papiers sans sélectionner aucune donnée.");

    
    try {
        NameMapping.TimeOutWarning = false;
        
        var fileName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4548_FileName", language + client);
        var extractDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
        var vserverFolder = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_VserverDefaultFolder", language + client);
        var DataHubExtractor_FileDelimiterChar = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_FileDelimiterChar", language + client);
        var DataHubExtractor_FileNbOfFields = VarToInt(ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_FileNbOfFields", language + client));
        var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4548_AccountNumber", language + client);
        
        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        
        var prefValue = "YES";
        var prefLevel = "USER";
        var shouldExportSuccess = true;
        var isCfLoaderCommandToBeChecked = true;
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, prefValue, prefLevel);
        
        //Login
        Login(vServerDataHub, userNameGP1859, passwordGP1859, language);
        
        //Faire les opération d'exportation de données
        ////À cette étape il n'est pas demandé de vérifier le contenu des champs de la table B_DATA_HUB ; mais pour le moment, les vérifications par défaut sont faites pour ne pas complexifier la fonction ou dupliquer une grande partie du code : à revoir éventuellement.
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Models){
            GotoModule(moduleName_Models);
            var arrayOfExportMethod = [exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Models, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            GotoModule(moduleName_Relationships);
            var arrayOfExportMethod = [exportMethod_X_Button_ExportToMSExcel, exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Relationships, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            GotoModule(moduleName_Clients);
            var arrayOfExportMethod = [exportMethod_X_Button_ExportToMSExcel, exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Clients, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Accounts){
            GotoModule(moduleName_Accounts);
            var arrayOfExportMethod = [exportMethod_X_Button_ExportToMSExcel, exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Accounts, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Portfolio){
            if (DragAccountsToPortfolio([])){
                var arrayOfExportMethod = [exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
                ExecuteManyExportsFromModule(userNameGP1859, moduleName_Portfolio, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
            }
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Transactions){
            GotoModule(moduleName_Transactions);
            var arrayOfExportMethod = [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Transactions, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Securities){
            GotoModule(moduleName_Securities);
            var arrayOfExportMethod = [exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel, exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Securities, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
            Log.Message("JIRA CROES-10233 : Lorsqu'on exporte vers excel via le blotter du module Ordres, la FUNCTION_ID = OrdreAccumulatorDataGrid au lieu de FUNCTION_ID = OrdreBlotterDataGrid qui est le comportement attendu.");
            Log.Message("JIRA CROES-10231 : Crash de l'application lorsqu'on fait une copie sur le datagrille vide du module Ordres.");
            GotoModule(moduleName_Orders);
            var arrayOfExportMethod = [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Orders, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        
            GotoModule(moduleName_Orders_Accumulator);
            var arrayOfExportMethod = [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C];
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Orders_Accumulator, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        
        //Étape 1 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate
        Log.Message("****** Étape 1 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileName, extractDate, vserverFolder);
        
        var expectedExtractionFileName = GetExpectedExtractionFileName(fileName, extractDate);
        var localExtractionFilePath = localFolder + expectedExtractionFileName;
        
        
        //Étape 4 : Vérifier le format de « flat file » fichier délimité par point-virgule (;)
        Log.Message("****** Étape 4 : Vérifier le format de « flat file » fichier délimité par " + DataHubExtractor_FileDelimiterChar);
        
        var strOfErroneousLines = "";
        var strOfWarningLines = "";
        var extractionFileContent = aqFile.ReadWholeTextFile(localExtractionFilePath, aqFile.ctANSI);
        var arrayOfExtractionFileLines = extractionFileContent.split("\n");
        for (var i = 0; i < arrayOfExtractionFileLines.length; i++){
            var currentLine = arrayOfExtractionFileLines[i];
            if (currentLine.split(DataHubExtractor_FileDelimiterChar).length == DataHubExtractor_FileNbOfFields)
                strOfErroneousLines += currentLine + "\n";
            else if (currentLine.split(DataHubExtractor_FileDelimiterChar).length > 1)
                strOfWarningLines += currentLine + "\n";
        }
        
        if (Trim(strOfErroneousLines) == "")
            Log.Checkpoint("File '" + expectedExtractionFileName + "' format is the expected one : every line fields are delimited by '" + DataHubExtractor_FileDelimiterChar + "' as required to be checked in the automated test.");
        if (Trim(strOfErroneousLines) != "")
            Log.Error("File '" + expectedExtractionFileName + "' format is not the expected one ; every line fields should be delimited by '" + DataHubExtractor_FileDelimiterChar + "'. The following lines don't contain " + DataHubExtractor_FileNbOfFields + " fields :", strOfErroneousLines);
        if (Trim(strOfWarningLines) != "")
            Log.Message("File '" + expectedExtractionFileName + "' is delimited by '" + DataHubExtractor_FileDelimiterChar + "' as required to be checked but the number of fields has evolved (not " + DataHubExtractor_FileNbOfFields + ") :", strOfWarningLines);

        //Étape 13 : Valider l'enregistrement d'extract dans windows
        Log.Message("****** Étape 13 : Valider l'enregistrement d'extract dans windows");
        
        //Supprimer un éventuel fichier de même nom
        var downloadExtractionFilePath = localFolder + expectedExtractionFileName;
        if (aqFile.Exists(downloadExtractionFilePath) && !aqFileSystem.DeleteFile(downloadExtractionFilePath)){
            Log.Error("Unable to delete file : " + downloadExtractionFilePath);
            return false;
        }
        
        //Se connecter àWinSCP
        TryConnexionAndTrustHostKeyThroughWinSCPAndSetTemporaryDirectory(vServerDataHub, true, 30000, localFolder);
        if (!ConnectToWinSCP(vServerDataHub))
               return Log.Error("The SSH WinSCP connexion to vserver '" + vServerDataHub + "' was not successful.");
        
        Get_WinWinSCP_PnlRemotePanel().Keys("~[F7]");
        Get_DlgWinSCPFileFind_GrpFilter_CmbSearchIn().Click();
        Get_DlgWinSCPFileFind_GrpFilter_CmbSearchIn().Keys("[Del]" + vserverFolder);
        Get_DlgWinSCPFileFind_GrpFilter_CmbFileMask().Click();
        Get_DlgWinSCPFileFind_GrpFilter_CmbFileMask().Keys("[Del]" + expectedExtractionFileName + "[Enter]");
        Get_DlgWinSCPFileFind_GrpFilter_LvwFileView().WaitProperty("wItemCount", 1, 30000);
        var nbOfFilesFound = Get_DlgWinSCPFileFind_GrpFilter_LvwFileView().wItemCount;
        var isFileFoundInRemoteFolder = (nbOfFilesFound == 1);
        if (!isFileFoundInRemoteFolder)
            Log.Error(nbOfFilesFound + " fichier(s) '" + expectedExtractionFileName + "' trouvé(s) au lieu de 1 dans le dossier : " + vserverFolder);
        else {
            CompareProperty(Get_DlgWinSCPFileFind_GrpFilter_LvwFileView().wItem(0, 0), cmpEqual, expectedExtractionFileName, true, lmError);
            Get_DlgWinSCPFileFind_GrpFilter_LvwFileView().SelectItem(0);
            Get_DlgWinSCPFileFind_BtnEdit().WaitProperty("Enabled", true, 60000);
            Get_DlgWinSCPFileFind_BtnEdit().Click();
            Get_DlgWinSCPFileFind().Close();
        
            //Valider que le fichier a été téléchargé dans le dossier temporaire
            var nbOfChecks = 0;
            do {Delay(1000);} while (!aqFile.Exists(downloadExtractionFilePath) && ++nbOfChecks < 120)
            if (aqFile.Exists(downloadExtractionFilePath))
                Log.Checkpoint("The file download was successful : " + downloadExtractionFilePath);
            else
                Log.Error("The file download was not successful : " + downloadExtractionFilePath);
        }
        
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Fermer l'application qui a été éventuellement ouverte à partir de la fenêtre WinSCP
        Sys.Refresh();
        if (isFileFoundInRemoteFolder != undefined && isFileFoundInRemoteFolder && Get_WinWinSCP().Exists && !Get_WinWinSCP().Focused){
            //Sys.Desktop.ActiveWindow().Close();
        }
            
        //Restore WinSCP configuration
        TryConnexionAndTrustHostKeyThroughWinSCPAndSetTemporaryDirectory(vServerDataHub, true, 30000, "");
        
        //Mettre la Pref à sa valeur par défaut
        if (userNameGP1859 != undefined) UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, null, prefLevel);
        
        //Fermer WinSCP
        TerminateProcess("WinSCP");
        
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        NameMapping.TimeOutWarning = true;
    }
}



/**
    Description : Initier une connexion sur le vserver et accepter éventuellement le hostkey
    Paramètres : vServerURL (URL du vserver)
                 isResultIsToBeLogged (true ou false, facultatif ; valeur par défaut : true)
                 timeOut (délai de réponse, facultatif, valeur par défaut : 30000 millisecondes)
                 temporaryDirectory (répertoire temporaraire)
    Résultat :  true (si la tentative de connexion a réussi)
                false (si la tentative de connexion n'a pas réussi)
*/
function TryConnexionAndTrustHostKeyThroughWinSCPAndSetTemporaryDirectory(vServerURL, isResultIsToBeLogged, timeOut, temporaryDirectory)
{
    if (isResultIsToBeLogged == undefined)
        isResultIsToBeLogged = true;
    
    if (timeOut == undefined)
        timeOut = 30000;
        
    Log.Message("Try Connexion And Trust HostKey Through WinSCP to : " + vServerURL);
        
    var WinSCPComFile = GetWinSCPComFilePath();
    if (!aqFileSystem.Exists(WinSCPComFile)){
        Log.Error("The file '" + WinSCPComFile + "' was not found.");
        return false;
    }
    
    var vServerRootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    CheckIfAllStringCharsAreAscii7(vServerRootPassword);
    var vserverHostName = GetVserverHostName(vServerURL);
    var WinSCPLogFilePath = Project.Path + vserverHostName +  "_WinSCP_Connexion_Try.log";
    if (aqFileSystem.Exists(WinSCPLogFilePath)) aqFileSystem.DeleteFile(WinSCPLogFilePath);
    
    var expectedStringForSuccessfullConnexion = "*Active session: [*] root@" + vserverHostName + "*";
    var expectedStringForHostKeyToBeTrusted = "*If you trust this host, press Yes. To connect without adding host key to the cache, press No. To abandon the connection press Cancel.*";
    var expectedStringForHostKeyUpdateToBeTrusted = "*If you were expecting this change, trust the new key and want to continue connecting to the server, either press Update to update cache*";
    
    //Try as many times as specified
    var numOfConnexionTry = 0;
    var maxNumOfConnexionTries = 3;
    var isTryConnexionAndTrustHostKeySuccessfull = false;
    do {
        numOfConnexionTry ++;
        Log.Message("TryConnexionAndTrustHostKeyThroughWinSCP Try Number " + numOfConnexionTry);
        isTryConnexionAndTrustHostKeySuccessfull = TryConnexionAndTrustHostKeyThroughWinSCP_Once(vServerURL, timeOut);
    } while (isTryConnexionAndTrustHostKeySuccessfull == false && numOfConnexionTry < maxNumOfConnexionTries)
    
    if (isResultIsToBeLogged){
        if (isTryConnexionAndTrustHostKeySuccessfull == true)
            Log.Checkpoint("Connexion to host '" + vserverHostName + "' Through WinSCP was successfull.");
        else
            Log.Error("Connexion to host '" + vserverHostName + "' Through WinSCP was not successfull.");
    }
    
    return isTryConnexionAndTrustHostKeySuccessfull;
    
    
    function CheckIfAllStringCharsAreAscii7(varPassword)
    {
        for (var i = 0; i < varPassword.length; i++)
            if (varPassword.charCodeAt(i) > 127){
                Log.Warning(varPassword + " : Tous les caractères du mot de passe ne sont pas ASCII ; vous pourriez rencontrer des problèmes de connexion SSH via WinSCP.");
                return false;
            }
    
        return true;
    }
    
    
    function TryConnexionAndTrustHostKeyThroughWinSCP_Once(vServerURL, timeOut)
    {
        var isConnexionSuccessfull = null;
        
        //Démarrer une nouvelle console de commandes
        var commandLineProcess = LaunchAndGetCommandLineProcess();
        if (!commandLineProcess.Exists)
            return false;
        
        //Essayer d'établir une connexion sur le vserver
        var commandLineConsole = commandLineProcess.Window("ConsoleWindowClass", "*", 1);
        
        //Open
        var vServerRootPasswordPercentEncoded = GetPercentEncodedString(vServerRootPassword);
        
        
        if (temporaryDirectory == undefined || Trim(VarToStr(temporaryDirectory)) == "")
            var connexionCommandLine = '"' + WinSCPComFile + '"' + " /rawconfig Interface\\DDTemporaryDirectory= Interface\\TemporaryDirectoryAppendSession=0 Interface\\TemporaryDirectoryAppendPath=1 Interface\\TemporaryDirectoryDeterministic=0 Interface\\LocaleSafe=0 Interface\\Locale=0409 /command" + ' "open sftp://root:' + vServerRootPasswordPercentEncoded + '@' + vserverHostName + '/" ' + ' "exit" '  + ' /log="' + WinSCPLogFilePath + '"';
        else
            var connexionCommandLine = '"' + WinSCPComFile + '"' + " /rawconfig Interface\\DDTemporaryDirectory=\"" + temporaryDirectory + "\" Interface\\TemporaryDirectoryAppendSession=0 Interface\\TemporaryDirectoryAppendPath=0 Interface\\TemporaryDirectoryDeterministic=1 Interface\\LocaleSafe=0 Interface\\Locale=0409 /command" + ' "open sftp://root:' + vServerRootPasswordPercentEncoded + '@' + vserverHostName + '/" ' + ' "exit" '  + ' /log="' + WinSCPLogFilePath + '"';
        
        Log.Message(aqString.Replace(connexionCommandLine, vServerRootPasswordPercentEncoded, vServerRootPassword), connexionCommandLine);
        Sys.Clipboard = connexionCommandLine;
        Delay(2000);
        commandLineConsole.Keys(" ^v[Enter]");
        
        var timeEllapsed = 0;
        var stepTimeout = 250;
        while (timeEllapsed < timeOut){
            //Vérifier si la connexion a réussi
            if (commandLineConsole.WaitProperty("wText", expectedStringForSuccessfullConnexion, 2*stepTimeout))
                break;
            timeEllapsed += 2*stepTimeout;
            
            //Accepter le hostkey si requis
            if (commandLineConsole.WaitProperty("wText", expectedStringForHostKeyToBeTrusted, stepTimeout)){
                Log.Message("Accept Host Key for '" + vserverHostName + "' by pressing 'Y'");
                commandLineConsole.Keys("Y");
                break;
            }
            timeEllapsed += stepTimeout;
            
            //Accepter le hostkey si requis
            if (commandLineConsole.WaitProperty("wText", expectedStringForHostKeyUpdateToBeTrusted, stepTimeout)){
                Log.Message("Update Host Key for '" + vserverHostName + "' by pressing 'U'");
                commandLineConsole.Keys("U");
                break;
            }
            timeEllapsed += stepTimeout;
        }
        
        //Attendre que le fichier texte de sortie soit correctement écrit
        var nbOfChecks = 0;
        do {
            Delay(1000);
        } while (!aqFileSystem.Exists(WinSCPLogFilePath) && ++nbOfChecks < 20)
        
        //Afficher le log
        if (aqFileSystem.Exists(WinSCPLogFilePath))
            Log.Message("WinSCP Log file content", aqFile.ReadWholeTextFile(WinSCPLogFilePath, aqFile.ctUTF8));
        
        //Fermer la nouvelle console de ligne de commande et retourner le résultat (vrai ou faux)
        isConnexionSuccessfull = commandLineConsole.WaitProperty("wText", expectedStringForSuccessfullConnexion, timeOut);
        commandLineProcess.Terminate();
        return isConnexionSuccessfull;
    }
}
