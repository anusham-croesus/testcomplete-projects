//USEUNIT Common_Get_functions
//USEUNIT Titres_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT Portefeuille_Get_functions
//USEUNIT Clients_Get_functions
//USEUNIT Modeles_Get_functions
//USEUNIT Dashboard_Get_functions
//USEUNIT Transactions_Get_functions
//USEUNIT Ordres_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Relations_Get_functions




function LoginTimeoutTimer()
{
    //Temp
    var currentScriptFileName = GetCurrentScriptFileName();
    var emailBodyContent = "The Login timeout has been reached:\r\nComputer = " + executionComputerName + "\r\nScript File = " + currentScriptFileName;                        
    SendMail("youlia.raisper@croesus.com;xian.wei@croesus.com", "mail.croesus.com", "LoginTimeoutTimer", "testauto@croesus.com", aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + " " + VarToStr(client) + " LoginTimeoutTimer", emailBodyContent);
    if (Trim(aqString.ToLower(currentScriptFileName)) == "preexecution"){
        throw new Error("The Login timeout has been reached!");
    }
    else {
        Log.Error("The Login timeout has been reached... Stopping the test.");
        Runner.Stop(true);
    }
}



function DisableLoginTimeOutTimer()
{
    //Procéder seulement lors de l'exécution d'un projet ; il ne se passera rien si on exécute individuellement un script
    if (Project.TestItems.Current != undefined && typeof TIMER_TIMEOUT_LOGIN != 'undefined' && TIMER_TIMEOUT_LOGIN != null && TIMER_TIMEOUT_LOGIN.Enabled){
        TIMER_TIMEOUT_LOGIN.Enabled = false;
    }
}



function EnableLoginTimeOutTimer(intervalInMilliseconds)
{
    if (intervalInMilliseconds == undefined)
        intervalInMilliseconds = 900000;
    
        //Procéder seulement lors de l'exécution d'un projet ; il ne se passera rien si on exécute individuellement un script
    if (Project.TestItems.Current != undefined){
        if (typeof TIMER_TIMEOUT_LOGIN == 'undefined' || TIMER_TIMEOUT_LOGIN == null){
            Log.Message("Add TIMER_TIMEOUT_LOGIN: " + intervalInMilliseconds + " ms.");
            TIMER_TIMEOUT_LOGIN = Utils.Timers.Add(intervalInMilliseconds, "Common_functions.LoginTimeoutTimer", true);
            TIMER_TIMEOUT_LOGIN.Name = "TIMER_TIMEOUT_LOGIN";
        }
        else {
            if (TIMER_TIMEOUT_LOGIN.Enabled){
                Log.Message("Disable TIMER_TIMEOUT_LOGIN.");
                TIMER_TIMEOUT_LOGIN.Enabled = false;
                Delay(1000);
            }
            
            if (TIMER_TIMEOUT_LOGIN.Interval != intervalInMilliseconds){
                Log.Message("Update TIMER_TIMEOUT_LOGIN interval to: " + intervalInMilliseconds + " ms.");
                TIMER_TIMEOUT_LOGIN.Interval = intervalInMilliseconds;
            }
            
            Log.Message("Enable TIMER_TIMEOUT_LOGIN: " + intervalInMilliseconds + " ms.");
            TIMER_TIMEOUT_LOGIN.Enabled = true;
        }
    }
}



function GetCurrentScriptFileName()
{
    try {
        var currentScriptFileName = "SCRIPT_FILE_NAME_UNDEFINED_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
        if (Project.TestItems.Current != undefined){
            currentScriptFileName = Project.TestItems.Current.ElementToBeRun.Caption.split('\\')[1].split('-')[0];
        }
        else {
            Log.SaveToDisk();
            Delay(1000);
            if (Project.Logs.LogItemsCount > 0)
                currentScriptFileName = VarToStr(Project.Logs.LogItem(Project.Logs.LogItemsCount - 1).Name).split('[')[1].split('\\')[0];
        }
    }
    catch(e_GetCurrentScriptFileName){
        Log.Error("Exception from GetCurrentScriptFileName() : " + e_GetCurrentScriptFileName.message, VarToStr(e_GetCurrentScriptFileName.stack));
        e_GetCurrentScriptFileName = null;
    }
    finally {
        return currentScriptFileName;
    }
}



function GeneralEvents_OnTimeout(Sender, Params)
{
    //Temp, To Be Deleted
    ///*
    var emailBodyContent = "Computer = " + executionComputerName + "\r\nScript File = " + GetCurrentScriptFileName();                        
    SendMail("youlia.raisper@croesus.com;xian.wei@croesus.com", "mail.croesus.com", "GeneralEvents_OnTimeout", "testauto@croesus.com", aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + " " + VarToStr(client) + " GeneralEvents_OnTimeout", emailBodyContent);
    //*/    
    
    Log.Error("The Test timeout has been reached... Stopping the test.");
    Runner.Stop(true);
}



function GeneralEvents_OnUnexpectedWindow(Sender, Window, LogParams)
{
    if (Project.TestItems.Current != undefined && aqFileSystem.GetFileNameWithoutExtension(Project.FileName) == "Rapports" && Get_WinReminder().Exists){
        if (Get_WinReminder_GrpAction_ChkDontShowThisReminderAnymore().IsChecked.OleValue !== true){
            Get_WinReminder_GrpAction_ChkDontShowThisReminderAnymore().Click();
            Get_WinReminder_GrpAction_ChkDontShowThisReminderAnymore().WaitProperty("IsChecked.OleValue", true, 5000);
        }
        Get_WinReminder_BtnOK().Click();
        WaitObjectPropertyExistsToFalse(Get_WinReminder(), 15000);
    }
}



/**
    Cette fonction est un gestionnaire d'événements qui permet
    lorsque le projet d'exécution est réexécuté, d'exécuter seulement
    les scripts qui ont échoué lors de l'exécution précédente.
    
    Pour son utilisation, l'ajouter au gestionnaire d'événements :
    'OnStopTest' (du groupe d'événements 'Test Engine Events')
*/
function GeneralEvents_OnStopTest(Sender)
{
    //La variable globale LOGIN_ERROR_COUNT_TO_DISCARD est renseignée dans dans fontion Login advenant la levée d'une exception
    var errorsCountToDiscard = (typeof LOGIN_ERROR_COUNT_TO_DISCARD == 'undefined' || LOGIN_ERROR_COUNT_TO_DISCARD == undefined)? 0: LOGIN_ERROR_COUNT_TO_DISCARD;
    LOGIN_ERROR_COUNT_TO_DISCARD = null;
    RestoreAutoTimeOut();
    
    //Procéder seulement lors de l'exécution d'un projet ; il ne se passera rien si on exécute individuellement un script
    DisableLoginTimeOutTimer(); //Désactiver le timer du Login timeout
    if (Project.TestItems.Current != undefined){
        //Si ce n'est pas encore fait, créer le fichier contenant les scripts qui ont échoué et le fichier de commande pour réexécuter des scripts
        if (typeof runStartDateTime == "undefined"){
            if (!ProjectSuite.Variables.VariableExists("runStartDateTime")){
                ProjectSuite.Variables.AddVariable("runStartDateTime", "String");
                ProjectSuite.Variables.runStartDateTime = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
            }
            runStartDateTime = ProjectSuite.Variables.runStartDateTime;
            failedTestsRunBatchFile = Project.Path + "FailedTestsRun_" + runStartDateTime + ".bat"; //Fichier contenant les lignes de commande pour réexécuter individuellement chaque script tombé en erreur
            failedTestsListFile = Project.Path + "FailedTestsList_" + runStartDateTime + ".txt"; //Fichier contenant la liste des noms de scripts tombés en erreur
            aqFile.Delete(failedTestsRunBatchFile);
            aqFile.Delete(failedTestsListFile);
            aqFile.Create(failedTestsRunBatchFile);
            aqFile.Create(failedTestsListFile);
            TESTEXECUTE_PATH = '"C:\\Program Files (x86)\\SmartBear\\TestExecute 14\\Bin\\TestExecute.exe"'; 
            TC_PARAMS = '/r /e /ns /SilentMode';
        }
        
        //Si ce n'est pas encore fait, récupérer les chemins d'accès des scripts et faire  
        //Sauvegarde du dossier des scripts réputés situés dans ProjectSuiteCommonScripts
        if (typeof CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY == "undefined"){
            CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY = GetallTcScriptsUnitsPathsArray();
            for (var i in CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY.paths){
                var scriptsPath = aqFileSystem.GetFileFolder(CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY.paths[i]);
                if (aqFileSystem.Exists(scriptsPath) && "ProjectSuiteLibrary" != aqFileSystem.GetFolderInfo(scriptsPath).ParentFolder.ParentFolder.Name){
                    var scriptsBakPath = aqFileSystem.GetFolderInfo(scriptsPath).ParentFolder.Path + "BAK_" + runStartDateTime + "\\";
                    if (!aqFileSystem.Exists(scriptsBakPath))
                        aqFileSystem.CopyFolder(aqFileSystem.ExcludeTrailingBackSlash(scriptsPath), scriptsBakPath);
                }
            }
        }
        
        //Récupérer le nom de l'unité (fichier) en cours d'exécution et de la routine (fonction) principale exécutée
        var projectName = aqFileSystem.GetFileNameWithoutExtension(Project.FileName);
        var unitName = Trim(Project.TestItems.Current.ElementToBeRun.Caption.split ('\\')[1].split('-')[0]);
        var routineName = Trim(Project.TestItems.Current.ElementToBeRun.Caption.split ('\\')[1].split('-')[1]);
        
        //Exclure de ce traitement les scripts : PreExecution, ExecutionLog, et éventuellement d'autres (à mettre à jour au besoin)
        if (unitName != "PreExecution" && aqString.Find(unitName, "ExecutionLog") != 0){
            
            //S'il y a eu au moins une erreur (excluant les erreurs du premier essai de Login) lors de l'exécution du script, renseigner les fichiers failedTestsRunBatchFile et failedTestsListFile
            if ((Log.ErrCount - errorsCountToDiscard) > 0){
                var scriptExecutionCommandLine = TESTEXECUTE_PATH + ' "' + ProjectSuite.FileName + '" /project:' + projectName + ' /unit:' + unitName + ' /routine:' + routineName + ' ' + TC_PARAMS + "\n";
                aqFile.WriteToTextFile (failedTestsRunBatchFile, scriptExecutionCommandLine, aqFile.ctANSI);
                aqFile.WriteToTextFile (failedTestsListFile, unitName + "\n", aqFile.ctANSI);
            }
            
            //S'il n'y a pas eu d'erreur lors de l'exécution, faire un backup du script, simuler un contenu vide pour que lors d'une prochaine réexécution, il ne se passe rien pour ce script
            else {
                var unitFilePath = CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY.paths[GetIndexOfItemInArray(CURRENT_PROJECT_TCSCRIPTS_UNITS_ARRAY.names, unitName)];
                if (!aqFileSystem.Exists(unitFilePath)){
                    Log.Warning("GeneralEvents_OnStopTest() : Le fichier de script '" + unitFilePath + "' n'a pas été trouvé.", unitFilePath);
                }
                else {
                    var unitBakFilePath = aqFileSystem.GetFileInfo(unitFilePath).ParentFolder.Path  +   "BAK_" + aqFileSystem.GetFileName(unitFilePath);
                    var emptyStubContentWarningMessage = (Log.WrnCount < 1)? "": "Log.Warning('There was at least " + Log.WrnCount + " warning(s) during a previous project execution.');"
                    var emptyStubContent = "function " + routineName + "(){" + emptyStubContentWarningMessage + "}";
                    var previousFileContent = Trim(aqFile.ReadWholeTextFile(unitFilePath, aqFile.ctUTF8));
    				var isUnitFileEmpty = (!aqFileSystem.Exists(unitBakFilePath))? false: (-1 != aqString.Find(previousFileContent, emptyStubContent));
                    
    				if (!aqString.StrMatches("function\\b" + routineName + "\\(\\).*", previousFileContent))
    					Log.Warning("Veuillez supprimer les espaces en trop dans la définition de la fonction principale du script : " + routineName);
                    else if (!isUnitFileEmpty){
                        if (aqFileSystem.Exists(unitBakFilePath)) aqFile.Delete(unitBakFilePath);
                        aqFileSystem.CopyFile(unitFilePath, unitBakFilePath);
                        if (0 != aqFile.SetFileAttributes(unitFilePath, 128)) aqFile.Delete(unitFilePath);
                        var routineNamePosInFile = aqString.Find(previousFileContent, "function " + routineName + "()") + 9;
                        var fakeEmptyFileContent = emptyStubContent + "\r\n\r\n" + aqString.Insert(previousFileContent, "BAK_", routineNamePosInFile);
                        aqFile.WriteToTextFile(unitFilePath, fakeEmptyFileContent, aqFile.ctUTF8, true);
                    }
                }
            }
        }
    }
}



//Testée sur la version : TestComplete 14.0.308.7
function GetallTcScriptsUnitsPathsArray(tcScriptFilePath)
{
    var xmlRelevantKeys = {name: "name", value: "path"};
    
    if (tcScriptFilePath == undefined) tcScriptFilePath = Project.Path + "Script\\Script.tcScript";
    
    if (!aqFileSystem.Exists(tcScriptFilePath)){
        Log.Error("Le fichier n'a pas été trouvé : " + tcScriptFilePath);
        return null;
    }
    
    //var Doc = Sys.OleObject("Msxml2.DOMDocument.4.0");
    var xmlDoc = Sys.OleObject("Msxml2.DOMDocument.6.0");
    xmlDoc.async = false;
    xmlDoc.load(tcScriptFilePath);
    
    if (xmlDoc.parseError.errorCode == 0){
        var allTcScriptsUnitsPathsArray = ProcessTcScriptNode(xmlDoc.documentElement, xmlRelevantKeys);
        for (var i in allTcScriptsUnitsPathsArray.paths)
            allTcScriptsUnitsPathsArray.paths[i] = GetProjectItemAbsolutePathFromTcScriptFileInfo(allTcScriptsUnitsPathsArray.paths[i], tcScriptFilePath);
        
        return allTcScriptsUnitsPathsArray;
    }
    else {
        var errorInfo = "Reason:\t" + xmlDoc.parseError.reason + "\n" +
        "Line:\t" + aqConvert.VarToStr(xmlDoc.parseError.line) + "\n" + 
        "Pos:\t" + aqConvert.VarToStr(xmlDoc.parseError.linePos) + "\n" + 
        "Source:\t" + xmlDoc.parseError.srcText;
        Log.Error("Il a été impossible de parser le fichier : " + tcScriptFilePath, errorInfo);
        return null;
    }
    
    
    //Inner function : Pour le traitement récursif des noeuds du fichier XML ...\Script\Script.tcScript
    function ProcessTcScriptNode(XMLNode, xmlRelevantKeys, xmlMapObject)
    {
        if (xmlMapObject == undefined) xmlMapObject = {names: [], paths: []}
    
        //Exclure les lignes de commentaires
        if (XMLNode.nodeName.charAt(0) != "\#"){
            var nodeAttributes = XMLNode.attributes;
        
            //Si toutes les clés pertinentes ont été trouvées, alors enregistrer la valeur du nom (name) et celle du chemin d'accès (path)
            var xmlMapObjectKey = null, xmlMapObjectValue = null;
            for (var i = 0; i < nodeAttributes.length; i++){
                var nodeAttributeItem = nodeAttributes.item(i);
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.name)
                    xmlMapObjectKey = nodeAttributeItem.nodeValue;
            
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.value)
                    xmlMapObjectValue = nodeAttributeItem.nodeValue;
            }
        
            if (xmlMapObjectKey !== null && xmlMapObjectValue !== null){
                xmlMapObject.names[xmlMapObject.names.length] = xmlMapObjectKey;
                xmlMapObject.paths[xmlMapObject.paths.length] = xmlMapObjectValue;
            }
        }
    
        // Obtenir les noeuds enfants et faire le même traitement de façon récursive
        var XMLChildNodes = XMLNode.childNodes;
        for(var i = 0; i < XMLChildNodes.length; i++)
            xmlMapObject = ProcessTcScriptNode(XMLChildNodes.item(i), xmlRelevantKeys, xmlMapObject); 
    
        return xmlMapObject;
    }
    
    
    //Inner function : Pour obtenir le chemin d'accès absolu de l'item de test, à partir de la valeur Path renseignée dans le fichier ...\Script\Script.tcScript
    function GetProjectItemAbsolutePathFromTcScriptFileInfo(pathValueFromXML, tcScriptFilePath)
    {
        if (tcScriptFilePath == undefined) tcScriptFilePath = Project.Path + "Script\\Script.tcScript";
    
        if (!aqFileSystem.Exists(tcScriptFilePath)){
            Log.Error("Le fichier n'a pas été trouvé : " + tcScriptFilePath);
            return null;
        }
    
        var scriptFileAbsolutePath = null;
        var relativeParentsCount = (aqString.Find(pathValueFromXML, "..\\") == -1)? 0: pathValueFromXML.split("..\\").length - 2;
        var relativePathPosition = (aqString.FindLast(pathValueFromXML, "..\\") == -1)? 0 : aqString.FindLast(pathValueFromXML, "..\\") + 3;
    
        if (relativeParentsCount == 0)
            scriptFileAbsolutePath = aqFileSystem.GetFileInfo(tcScriptFilePath).ParentFolder.Path + pathValueFromXML;
        else {
            var relativeParentsPath = aqFileSystem.GetFileInfo(tcScriptFilePath).ParentFolder.ParentFolder.Path;
            for (var i = 0; i < relativeParentsCount; i++)
                relativeParentsPath = aqFileSystem.GetFolderInfo(relativeParentsPath).ParentFolder.Path;
            scriptFileAbsolutePath = relativeParentsPath + pathValueFromXML.substring(relativePathPosition);
        }
    
        return scriptFileAbsolutePath;
    }
}



/**
Returns true if the project language is JavaScript,
        or false if it is JScript
*/
function isJavaScript()
{
  return (typeof Symbol === 'function') && (typeof Symbol.toStringTag === 'symbol');
}



/**
    Get Windows Display language
    Updates Global variable WINDOWS_DISPLAY_LANGUAGE (if not set)
    Returns "french" or "english" if successful, otherwise returns null if exception, or ""
*/
function GetWindowsDisplayLanguage()
{
    if (typeof WINDOWS_DISPLAY_LANGUAGE != 'undefined' && Trim(VarToStr(WINDOWS_DISPLAY_LANGUAGE)) != ""){
        return WINDOWS_DISPLAY_LANGUAGE;
    }
    
    try {
        var languageWindowsUser = "";
        var arrCommandsWindowsLanguage = [];
        arrCommandsWindowsLanguage.push('("$PSUICulture" -Split "-")[0].Trim().ToLower();');
        //arrCommandsWindowsLanguage.push('("$((Get-WinUILanguageOverride).Name)" -Split "-")[0].Trim().ToLower();'); //TBD
        //arrCommandsWindowsLanguage.push('("$((Get-WinUserLanguageList)[0].LanguageTag)" -Split "-")[0].Trim().ToLower();'); //TBD
        
        for (var j = 0; j < arrCommandsWindowsLanguage.length; j++){
            var strCmdLineLanguageWinUser = arrCommandsWindowsLanguage[j];
            var powershellObject = GetPowerShellObject();
            powershellObject.AddScript(strCmdLineLanguageWinUser);
            var powershellResults = powershellObject.Invoke();
            if (powershellObject.HadErrors){
                Log.Error("Error while running this Powershell command: " + strCmdLineLanguageWinUser);
                for (var i = 0; i < powershellObject.ErrorBuffer.Count; i++)
                    Log.Error(VarToStr(powershellObject.ErrorBuffer.Item(i).FullyQualifiedErrorId) + ": " + VarToStr(powershellObject.ErrorBuffer.Item(i).TargetObject));
            }
            powershellObject.Dispose();
            
            if (powershellResults.Items.Count == 0){
                Log.Error("Error: No powershell result item found, powershellResults.Items.Count = 0");
            }
            else {
                languageWindowsUser = Trim(VarToStr(powershellResults.Items.Item(0).BaseObject));
                if (languageWindowsUser != ""){
                    break;
                }
            }
        }
    }
    catch (exceptionLanguageWindowsUser){
        Log.Error("Exception: " + exceptionLanguageWindowsUser.message, VarToStr(exceptionLanguageWindowsUser.stack));
        exceptionLanguageWindowsUser = null;
        WINDOWS_DISPLAY_LANGUAGE = null;
    }
    finally {
        if (languageWindowsUser == "fr" || languageWindowsUser == "en"){
            WINDOWS_DISPLAY_LANGUAGE = (languageWindowsUser == "fr")? "french": "english";
        }
        else {
            Log.Error("The windows user language expected to be 'fr' or 'en', found: '" + languageWindowsUser + "'.");
            WINDOWS_DISPLAY_LANGUAGE = (WINDOWS_DISPLAY_LANGUAGE === null)? null: "";
        }
        Global_variables.WINDOWS_DISPLAY_LANGUAGE = WINDOWS_DISPLAY_LANGUAGE;
        Log.Message("The Windows Display Language is '" + VarToStr(WINDOWS_DISPLAY_LANGUAGE) + "'.");
    }
    
    return WINDOWS_DISPLAY_LANGUAGE;
}



//+++++++++++++++++++++++++++++++ CONNECTION ++++++++++++++++++++++++++++++++++++++++


/*
function RestartServices(vServerURL)
{
    return RestartServicesSSH(vServerURL);
}
*/

function RestartServices(nomVServer)//!!!!!!  Il faut Turn off Pop-Up Blocker of IE !!!!!!!!!!
{
	
	DisconnectIfLogoutButtonExists(nomVServer)
	
    Log.Message("Restart services of Vserver : " + nomVServer);
    var url = nomVServer + "cfadm/";
    
    //Aller à l'URL et Vérifier si la page login est là (version au délà de Hf-25 et In-7)
    var isAdminConsoleDisplayed = LaunchUrlAndVerifyAndFillAdminConsole(url);
    
    //Execute Restart All services script of the web page
    var browser = Sys.Browser("iexplore");
    aqUtils.Delay(1000);
    var page = browser.Page("*");
    page.contentDocument.Script.eval("cfadm('ALL', 'restart')");

    if (isAdminConsoleDisplayed) {
        //Wait for OK button
        aqUtils.Delay(2000);
        var restartActionPage = browser.Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart");
        if (restartActionPage.Exists)
            WaitObject(restartActionPage, "ObjectIdentifier", "Ok", 150000);
        
        var j = 1;
        do {
            j++;
            aqUtils.Delay(2000);
            obj = Sys.Browser("iexplore").Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok", 10);
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser("iexplore").Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok", 10).Click();
    }
    else {
        //Wait for OK button
        aqUtils.Delay(2000);
        var restartActionPage = browser.Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart");
        if (restartActionPage.Exists)
            WaitObject(restartActionPage, "ObjectIdentifier", "Ok", 150000);

        var j = 1;
        do {
            j++;
            aqUtils.Delay(2000);
            obj = Sys.Browser("iexplore").Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok");
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser("iexplore").Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart").Button("Ok").Click();
		VerifyCfadmRestartScriptOnPage();
		
    }
    aqUtils.Delay(1000);
    Terminate_IEProcess();
    aqUtils.Delay(2000);
    
    
function LaunchUrlAndVerifyAndFillAdminConsole(restartServicesURL)
    {
        var isNewPageFound = false;
        var isSuccessfull = false;
        var nbOfTriesLeft = 2;
        
        do {
            Terminate_IEProcess();
            aqUtils.Delay(1000);
            nbOfTriesLeft --;
            
            //Launch the specified browser and opens the specified URL in it.
            Log.Message("Launch the specified browser and opens the specified URL in it.");
            Browsers.Item("iexplore").Run(restartServicesURL);
            Sys.Browser(browserName).Page("*").Wait();
        
            Log.Message("Validate if login page viewed so the new procedure of RestartServices must executed.");
            isNewPageFound = false;
            var nbOfTries = 0;
            do {
                nbOfTries ++;
                Sys.Refresh();
                var pageObject = Sys.Browser(browserName).Page("*");
                isNewPageFound = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 8000).Exists;
                
                if (!isNewPageFound)
                    isSuccessfull = VerifyCfadmRestartScriptOnPage(8000);
            } while (!isNewPageFound && !isSuccessfull && nbOfTries < 8)
            
            if (isNewPageFound) {
            
             Log.Message("login Page exist");
               isAdminConsoleDisplayed = true;
                //Fill Login form

                  pageObject.FindChildEx("idStr", "Username", 10, true, 5000).Click()
                  pageObject.Keys("UNI00");
                  pageObject.FindChildEx("idStr", "Password", 10, true, 5000).Click()
                  if (psw != null)
                  pageObject.Keys(psw); 
                  pageObject.Keys("[Enter]");
            }
            
            //Check if the cfadm page is successfully loaded
            if (!isSuccessfull)
                isSuccessfull = VerifyCfadmRestartScriptOnPage();
            if (!isSuccessfull && nbOfTriesLeft > 0){
                Log.Warning("Page '" + restartServicesURL + "' may have not been loaded. Retry " + nbOfTriesLeft + " time(s) again.", "", pmHigher, null, Sys.Desktop.Picture());
                aqUtils.Delay(15000);
            }
        }while (!isSuccessfull && nbOfTriesLeft > 0)
        
        if (!isSuccessfull) {
            var logAttributes = Log.CreateNewAttributes();
            logAttributes.Bold = true;
            Log.Warning("RestartServices may not be successfull ; page '" + restartServicesURL + "' may have failed to load.", "", pmHigher, logAttributes, Sys.Desktop.Picture());
        }
        
        return isNewPageFound;
    }

    
function VerifyCfadmRestartScriptOnPage(waitDelay)
    {
        if (waitDelay == undefined)
            waitDelay = 60000;
        var browser = Sys.Browser("iexplore");
        aqUtils.Delay(1000);
        var page = browser.Page("*");
        return WaitObject(page, "href", "javascript:cfadm('ALL', 'restart')", waitDelay);
    }
}

function DisconnectIfLogoutButtonExists(vServer)
{
  //lancer l'url vserver
   Browsers.Item("iexplore").Run(vServer);
   
   var maxNbOfTries = 3;
   //Change Language if needed
    var pageObject = Sys.Browser().Page("*");
    
        pageObject.Wait();
        Delay(1000);
   //Wait for either Header panel or Login panel
        var headerAndLoginPanelChecksLeft = (2 * maxNbOfTries);
        var headerPanel = Utils.CreateStubObject();
	//var loginPanel = Utils.CreateStubObject();
        do {
            pageObject.Refresh();
            headerPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "header", "header", true], 20, true, 3000);
            if (!headerPanel.Exists){
                loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 3000);
            }            
        } while (!headerPanel.Exists && !loginPanel.Exists && --headerAndLoginPanelChecksLeft > 0)
        
        if (headerPanel.Exists){//Disconnect
            var disconnectPanel = headerPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "0", true], 10, true, 1000);
            disconnectPanel.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Button", "0", true], 10).Click();
            var disconnectSubmenu = disconnectPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "myDropdown", true], 10, true, 5000);
            var signOutButton = disconnectSubmenu.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", "0", true], 10, true, 3000);
            signOutButton.HoverMouse();
            signOutButton.Click();
            //If the Click on Sign Out button did not succeed (button is still displayed), try once again
            signOutButton.Refresh();
            if (signOutButton.Exists && !WaitObjectPropertyExistsToFalse(signOutButton, 10000) && !signOutButton.WaitProperty("VisibleOnScreen", false, 5000)){
                signOutButton.Refresh();
                if (signOutButton.Exists && signOutButton.VisibleOnScreen){
                    signOutButton.Click();
                }
            }
       }
 }

function RestartServicesSSH(vServerURL)
{
    try {
        var isExceptionThrown = false;
        var isRestartServicesOutputFileContentAsExpected = false;
        Indicator.Show();
        Indicator.PushText("SSH Restart Services of " + vServerURL + " ...");
        Log.Message("SSH Restart Services of " + vServerURL + " ...");
        var vServerHostname = GetVserverHostName(vServerURL);
        
        //Delete any file having the same name as the SSH Restart Services Output File
        var restartServicesOutputFile = Project.Path + 'RestartServicesAndGetStatusOutputFor_' + vServerHostname + '.txt';
        if (aqFileSystem.Exists(restartServicesOutputFile) && !aqFileSystem.DeleteFile(restartServicesOutputFile))
            Log.Error("Unable to delete a file having the same name as the Restart Services output file.", restartServicesOutputFile);
        
        //Check if SSH Restart Services Expected Output File exists
        var restartServicesExpectedOutputFile = folderPath_Data + 'RestartServicesAndGetStatusExpectedOutput_' + client + '.txt';
        if (!aqFileSystem.Exists(restartServicesExpectedOutputFile))
            Log.Error("SSH Restart Services expected output file not found (" + restartServicesExpectedOutputFile + ").", restartServicesExpectedOutputFile);
            
        //Prepare Command to be executed
        var arrayOfReplaceTokens = ["PLINK_FILE_TO_BE_SPECIFIED", "VSERVER_HOSTNAME_TO_BE_SPECIFIED", "VSERVER_ROOT_PASSWORD_TO_BE_SPECIFIED", "OUTPUT_FILE_TO_BE_SPECIFIED"];
        var arrayOfReplaceValues = ['"' + folderPath_ProjectSuiteCommonScripts + 'PLINK.EXE"', vServerHostname, GetBatchEscapedCharsString(GET_VSERVER_SSH_ROOT_PSWD()), '"' + restartServicesOutputFile + '"'];
        var restartServicesAndGetStatusPlinkCommand = Trim(aqFile.ReadWholeTextFile(folderPath_Data + 'RestartServicesAndGetStatusStub.bat', aqFile.ctUTF8));
        for (var i = 0; i < arrayOfReplaceTokens.length; i++)
            restartServicesAndGetStatusPlinkCommand = aqString.Replace(restartServicesAndGetStatusPlinkCommand, arrayOfReplaceTokens[i], arrayOfReplaceValues[i]);
            
        //Execute Command
        Log.Message("Execute SSH Restart Services Batch Command for host '" + vServerHostname + "'.", restartServicesAndGetStatusPlinkCommand);
        WshShell.Run('CMD /C ' + restartServicesAndGetStatusPlinkCommand, 0, true);
            
        //Check Command execution successfulness
        var actualOutput = Trim(aqString.Replace(aqFile.ReadWholeTextFile(restartServicesOutputFile, aqFile.ctUTF8), "\r\n", "\n"));
        var expectedOutput = Trim(aqString.Replace(aqFile.ReadWholeTextFile(restartServicesExpectedOutputFile, aqFile.ctUTF8), "\r\n", "\n")); 
        if (expectedOutput == actualOutput)
            isRestartServicesOutputFileContentAsExpected = true;
        else {
            actualOutput = Trim(aqString.Replace(actualOutput, ":   Stopping ", ":   \nStopping "));
            var arrayOfActualOutput = actualOutput.split("\n");
                
            expectedOutput = Trim(aqString.Replace(expectedOutput, ":   Stopping ", ":   \nStopping "));
            var arrayOfExpectedOutput = expectedOutput.split("\n");
			                
			//Expected against Actual
			var startIndexForStoppingLines = GetIndexOfItemInArray(arrayOfExpectedOutput, "Determining Croesus Finansoft package list for run level 3... done.", false, 0);
			var startIndexForStartingLines = GetIndexOfItemInArray(arrayOfExpectedOutput, "Sleeping 5 seconds... done.", false, startIndexForStoppingLines);
			var startIndexForCheckingLines = GetIndexOfItemInArray(arrayOfExpectedOutput, "Determining Croesus Finansoft package list for run level 3... done.", false, startIndexForStartingLines);
			var arrayOfExpectedButNotFoundServicesStatus = [];
			var arrayOfExpectedButNotFoundServicesStopping = [];
			var arrayOfExpectedButNotFoundServicesStarting = [];
            var arrayOfExpectedButNotFoundUnrecognizedLines = [];
			
			var arrayOfExpectedButNotFound = GetExtraLines(arrayOfActualOutput, arrayOfExpectedOutput);
			for (var key in arrayOfExpectedButNotFound){
				var lineContent = arrayOfExpectedButNotFound[key];
				var lineFirstWord = Trim(aqString.SubString(lineContent, 0, aqString.Find(lineContent, " ")));
				if (GetIndexOfItemInArray(["Stopping", "Starting"], lineFirstWord) == -1  && startIndexForCheckingLines <= key)
					arrayOfExpectedButNotFoundServicesStatus.push(lineFirstWord);
			}
			
			for (var key in arrayOfExpectedButNotFound){
				var lineContent = arrayOfExpectedButNotFound[key];
				var lineFirstWord = Trim(aqString.SubString(lineContent, 0, aqString.Find(lineContent, " ")));
				if (GetIndexOfItemInArray(["Stopping", "Starting"], lineFirstWord) != -1){
					var serviceNameDetailed =  Trim(aqString.SubString(lineContent, lineFirstWord.length, aqString.Find(lineContent, "(") - lineFirstWord.length));
					var serviceName =  (aqString.Find(serviceNameDetailed, "CROESUS ") != 0)? serviceNameDetailed: Trim(aqString.Remove(serviceNameDetailed, 0, "CROESUS ".length));
					serviceName = aqString.toLower(aqString.Replace(serviceName, " ", ""));
                    
					switch(serviceName){
						case "": serviceCmdName = "cfcroesus"; break;
						case "router": serviceCmdName = "cfctprouter"; break;
						default: serviceCmdName = "cf" + serviceName; break;
					}
				    
					if (GetIndexOfItemInArray(arrayOfExpectedButNotFoundServicesStatus, serviceCmdName) == -1)
                        arrayOfExpectedButNotFoundUnrecognizedLines.push(lineContent);
                    else {
						if (lineFirstWord == "Stopping" && startIndexForStoppingLines <= key && key < startIndexForStartingLines)
							arrayOfExpectedButNotFoundServicesStopping.push(lineContent);
						else if (lineFirstWord == "Starting" && startIndexForStartingLines <= key && key < startIndexForCheckingLines)
							arrayOfExpectedButNotFoundServicesStarting.push(lineContent);
                        else
                            arrayOfExpectedButNotFoundUnrecognizedLines.push(lineContent);
					}
				}
                else if (key < startIndexForCheckingLines && GetIndexOfItemInArray([startIndexForStoppingLines, startIndexForStartingLines, startIndexForCheckingLines], key) == -1){
                    arrayOfExpectedButNotFoundUnrecognizedLines.push(lineContent);
                }
			}
			
            //Result
            var expectedButNotFoundServicesCount = arrayOfExpectedButNotFoundServicesStatus.length;
            var stringOfExpectedButNotFound = "";
            for (var key in arrayOfExpectedButNotFound)
                stringOfExpectedButNotFound += "\r\n" + arrayOfExpectedButNotFound[key];
            stringOfExpectedButNotFound = Trim(stringOfExpectedButNotFound);
            
			isRestartServicesOutputFileContentAsExpected = (stringOfExpectedButNotFound == "" || (expectedButNotFoundServicesCount != 0 && expectedButNotFoundServicesCount == arrayOfExpectedButNotFoundServicesStopping.length && expectedButNotFoundServicesCount == arrayOfExpectedButNotFoundServicesStarting.length && arrayOfExpectedButNotFoundUnrecognizedLines.length == 0));
            if (isRestartServicesOutputFileContentAsExpected){
                //Expected against Actual
				if (stringOfExpectedButNotFound != "")
					Log.Message("SSH Restart Services output is missing the '" + arrayOfExpectedButNotFoundServicesStatus.join("' and '") + "' information, in regard to the Expected output file (" + restartServicesExpectedOutputFile + ").", stringOfExpectedButNotFound);
                    //Avant, c'était Log.Warning (Changé en Log.Message pour éviter les messages en jaune en attendant de revoir éventuellement la fonction) [Christophe]
                
			    //Actual against Expected
                var arrayOfNotExpectedButFound = GetExtraLines(arrayOfExpectedOutput, arrayOfActualOutput);
                var stringOfNotExpectedButFound = "";
                for (var key in arrayOfNotExpectedButFound)
                    stringOfNotExpectedButFound += "\r\n" + arrayOfNotExpectedButFound[key];
                stringOfNotExpectedButFound = Trim(stringOfNotExpectedButFound);
				if (stringOfNotExpectedButFound != "")
					Log.Message("SSH Restart Services output contains some extra content, in regard to the Expected output file (" + restartServicesExpectedOutputFile + ").", stringOfNotExpectedButFound);
                    //Avant, c'était Log.Warning (Changé en Log.Message pour éviter les messages en jaune en attendant de revoir éventuellement la fonction) [Christophe]
			}
        }
        
        //Log Command execution Result
        if (isRestartServicesOutputFileContentAsExpected)
            Log.Message("SSH Restart of host '" + vServerHostname + "' Services was successful.");
        else {
            if (Trim(actualOutput) == "")
                Log.Error("Please, make sure the VServer '" + vServerURL + "' is actually running.");
            else if (aqString.Find(actualOutput, "root@" + vServerHostname + "'s password:", 0, false) != -1)
                Log.Error("Please, make sure '" + vServerHostname + "' actual password (for user 'root') is the same as the password mentioned for the 'script'.");
            
            Log.Error("SSH Restart of host '" + vServerHostname + "' Services output file content is not as expected.",
            "Actual Output File content : " + restartServicesOutputFile + "\r\n--------------------------------------------------------------------------------------------------------------------------------------\r\n" + 
            aqFile.ReadWholeTextFile(restartServicesOutputFile, aqFile.ctUTF8) + "\r\n\r\n" + 
            "Expected Output File content : " + restartServicesExpectedOutputFile + "\r\n--------------------------------------------------------------------------------------------------------------------------------------\r\n" + 
            aqFile.ReadWholeTextFile(restartServicesExpectedOutputFile, aqFile.ctUTF8));
        }
		
		
		
		function GetExtraLines(referenceOutputLinesArray, comparedOutputLinesArray)
		{
            var arrayOfExtraLines = [];
            for (var k = 0; k < comparedOutputLinesArray.length; k++){
				var isExtraLine = true;
                var arrayOfPossibleExtraLines = (aqString.Find(comparedOutputLinesArray[k], "Stopping ") != 0)? new Array(comparedOutputLinesArray[k]): new Array(comparedOutputLinesArray[k], comparedOutputLinesArray[k] + "[  Ok  ]", comparedOutputLinesArray[k].split("[  Ok  ]")[0]);
                for (var p = 0; p < arrayOfPossibleExtraLines.length; p++){
                    if (-1 != GetIndexOfItemInArray(referenceOutputLinesArray, arrayOfPossibleExtraLines[p])){
                        isExtraLine = false;
                        break;
                    }
                }
				
                if (isExtraLine)
                    arrayOfExtraLines[k] = comparedOutputLinesArray[k];
            }
			
            return arrayOfExtraLines;
		}
    }
    catch(e_RestartServicesSSH){
        isExceptionThrown = true;
        Log.Error("Exception from RestartServicesSSH() : " + e_RestartServicesSSH.message, VarToStr(e_RestartServicesSSH.stack));
        e_RestartServicesSSH = null;
        
        if (restartServicesOutputFile != undefined && aqFileSystem.Exists(restartServicesOutputFile)){
            Log.Message("SSH Restart Services output file content (" + restartServicesOutputFile + ").", aqFile.ReadWholeTextFile(restartServicesOutputFile, aqFile.ctUTF8));
            if (Trim(actualOutput) == "")
                Log.Error("Please, make sure the VServer '" + vServerURL + "' is actually running.");
            else if (aqString.Find(actualOutput, "root@" + vServerHostname + "'s password:", 0, false) != -1)
                Log.Error("Please, make sure '" + vServerHostname + "' actual password (for user 'root') is the same as the password mentioned for the 'script'.");
        }
    }
    finally {
        Indicator.PopText();
        
        //Temp, To Be Deleted
        ///*
        if (!isRestartServicesOutputFileContentAsExpected && aqString.Find(executionComputerName, "VMAUTO", 0, false) != -1){
            var emailBodyContent = "Computer = " + executionComputerName + "\r\nScript File = " + GetCurrentScriptFileName() + "\r\nvServerURL = " + VarToStr(vServerURL);
            if (restartServicesOutputFile != undefined && aqFileSystem.Exists(restartServicesOutputFile))
                emailBodyContent += "\r\n\r\nRestart Services Output File content\r\n------------------------------------------------------------------------\r\n" + aqFile.ReadWholeTextFile(restartServicesOutputFile, aqFile.ctUTF8);
                                         
            SendMail("youlia.raisper@croesus.com;xian.wei@croesus.com", "mail.croesus.com", "RestartServicesSSH Error", "testauto@croesus.com", aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + " " + VarToStr(client) + " RestartServicesSSH Error", emailBodyContent);
        }
        //*/
        
        if (isExceptionThrown)
            throw new Error("There was exception from RestartServicesSSH.");
        
        return isRestartServicesOutputFileContentAsExpected;
    }
}



function RestartServicesWEB(nomVServer)//!!!!!!  Il faut Turn off Pop-Up Blocker of IE !!!!!!!!!!
{
    Log.Message("WEB Restart services of Vserver : " + nomVServer);
    var url = nomVServer + "cfadm/";
    
    //Aller à l'URL et Vérifier si la page login est là (version au délà de Hf-25 et In-7)
    var isAdminConsoleDisplayed = LaunchUrlAndVerifyAndFillAdminConsole(url);
    
    //Execute Restart All services script of the web page
    var browser = Sys.Browser("iexplore");
    aqUtils.Delay(1000);
    var page = browser.Page("*");
    page.contentDocument.Script.eval("cfadm('ALL', 'restart')");

    if (isAdminConsoleDisplayed) {
        //Wait for OK button
        aqUtils.Delay(2000);
        var restartActionPage = browser.Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart");
        if (restartActionPage.Exists)
            WaitObject(restartActionPage, "ObjectIdentifier", "Ok", 150000);
        
        var j = 1;
        do {
            j++;
            aqUtils.Delay(2000);
            obj = Sys.Browser("iexplore").Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok", 10);
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser("iexplore").Page(nomVServer + "cfadm/serviceRunner.php?service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok", 10).Click();
    }
    else {
        //Wait for OK button
        aqUtils.Delay(2000);
        var restartActionPage = browser.Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart");
        if (restartActionPage.Exists)
            WaitObject(restartActionPage, "ObjectIdentifier", "Ok", 150000);

        var j = 1;
        do {
            j++;
            aqUtils.Delay(2000);
            obj = Sys.Browser("iexplore").Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok");
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser("iexplore").Page(nomVServer + "cfadm/?mode=service&service=ALL&action=restart").Button("Ok").Click();
    }
    aqUtils.Delay(1000);
    Terminate_IEProcess();
    aqUtils.Delay(2000);
    
    
    function LaunchUrlAndVerifyAndFillAdminConsole(restartServicesURL)
    {
        var isNewPageFound = false;
        var isSuccessfull = false;
        var nbOfTriesLeft = 2;
        
        do {
            Terminate_IEProcess();
            aqUtils.Delay(1000);
            nbOfTriesLeft --;
            
            //Launch the specified browser and opens the specified URL in it.
            Log.Message("Launch the specified browser and opens the specified URL in it.");
            Browsers.Item("iexplore").Run(restartServicesURL);
            Sys.Browser(browserName).Page("*").Wait();
        
            Log.Message("Validate if login page viewed so the new procedure of RestartServices must executed.");
            isNewPageFound = false;
            var nbOfTries = 0;
            do {
                nbOfTries ++;
                Sys.Refresh();
                var pageObject = Sys.Browser(browserName).Page("*");
                isNewPageFound = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 8000).Exists;
                if (!isNewPageFound)
                    isSuccessfull = VerifyCfadmRestartScriptOnPage(8000);
            } while (!isNewPageFound && !isSuccessfull && nbOfTries < 8)
            
            if (isNewPageFound) {
                var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
                var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
                Log.Message("login Page exist");
                isAdminConsoleDisplayed = true;
                //Fill Login form
                loginForm.Click(10, 10);
                loginForm.Keys("[Tab]^a[Del]UNI00[Tab]");
                if (psw != null)
                          loginForm.Keys(psw); ;
                loginForm.Keys("[Enter]");
            }
            
            //Check if the cfadm page is successfully loaded
            if (!isSuccessfull)
                isSuccessfull = VerifyCfadmRestartScriptOnPage();
            if (!isSuccessfull && nbOfTriesLeft > 0){
                Log.Warning("Page '" + restartServicesURL + "' may have not been loaded. Retry " + nbOfTriesLeft + " time(s) again.", "", pmHigher, null, Sys.Desktop.Picture());
                aqUtils.Delay(15000);
            }
        }while (!isSuccessfull && nbOfTriesLeft > 0)
        
        if (!isSuccessfull) {
            var logAttributes = Log.CreateNewAttributes();
            logAttributes.Bold = true;
            Log.Warning("RestartServices may not be successfull ; page '" + restartServicesURL + "' may have failed to load.", "", pmHigher, logAttributes, Sys.Desktop.Picture());
        }
        
        return isNewPageFound;
    }

function VerifyCfadmRestartScriptOnPage(waitDelay)
    {
        if (waitDelay == undefined)
            waitDelay = 30000;
        var browser = Sys.Browser("iexplore");
        aqUtils.Delay(1000);
        var page = browser.Page("*");
        return WaitObject(page, "href", "javascript:cfadm('ALL', 'restart')", waitDelay);
    }
}


function GetPowerShellObject()
{
    return dotNET.System_Management_Automation.PowerShell.Create();
}



function SetPowerShellExecutionPolicyToUnrestricted()
{
    return ExecuteCommandsOnPowerShell("Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force");
}



function SetPowerShellExecutionPolicyToUndefined()
{
    return ExecuteCommandsOnPowerShell("Set-ExecutionPolicy Undefined -Scope CurrentUser -Force");
} 



function ExecuteCommandsOnPowerShell(arrayOfCommands)
{
    if (arrayOfCommands != undefined && GetVarType(arrayOfCommands) != varArray && GetVarType(arrayOfCommands) != varDispatch)
        arrayOfCommands = new Array(arrayOfCommands);
    
    var powershellObject = GetPowerShellObject();
    for (var i = 0; i < arrayOfCommands.length; i++)
        powershellObject.AddScript(arrayOfCommands[i]);
    
    var psResults = powershellObject.Invoke();
    var isSuccessful = !powershellObject.HadErrors;
    if (!isSuccessful){
        Log.Error("Some error(s) occurred while running Powershell command(s): " + arrayOfCommands.join("\n"), arrayOfCommands.join("\n"));
        for (var i = 0; i < powershellObject.ErrorBuffer.Count; i++)
            Log.Error(VarToStr(powershellObject.ErrorBuffer.Item(i).FullyQualifiedErrorId) + ": " + VarToStr(powershellObject.ErrorBuffer.Item(i).TargetObject));
        
        GetPowerShellEventLog(psResults);
    }
    
    powershellObject.Dispose();
    return isSuccessful;
}



function GetPowerShellEventLog(resultsPowerShell)
{
  var oEvent, i;
  Log.Message("PowerShell: Nb d'erreurs du Résultat de l'exécution = " + resultsPowerShell.Count);
  for (i = 0; i < resultsPowerShell.Count; i++)
  {
     oEvent = resultsPowerShell.Item(i).ImmediateBaseObject;

     Log.AppendFolder("Source: " + oEvent.Source);
     Log.Message("Type: " + oEvent.EntryType);
     Log.Message("Time: " + aqConvert.VarToStr(oEvent.TimeGenerated));
     Log.Message("Index: " + aqConvert.VarToStr(oEvent.Index));
     Log.Message("InstanceID: " + aqConvert.VarToStr(oEvent.InstanceID));
     Log.Message("MachineName: " + oEvent.MachineName);
     Log.Message("Message: (See Details)", oEvent.Message);
     Log.Message("UserName: " + oEvent.UserName);
     Log.Message("EventID: " + aqConvert.VarToStr(oEvent.EventID));
     Log.PopLogFolder();
  }
}



function GetDevOpsDeploymentImportModuleCmdLine()
{
    return 'Import-Module "' + devOpsDeploymentFilePath + '" -Force';
}



function GetVServerObject(vServerURL)
{
    SetPowerShellExecutionPolicyToUnrestricted();
    
    var PowerShellObject = GetPowerShellObject();
    
    PowerShellObject.AddScript(GetDevOpsDeploymentImportModuleCmdLine());
    PowerShellObject.Invoke();
    
    PowerShellObject.AddScript('Get-VServer "' + GetVserverHostName(vServerURL) + '"');
    var vServerObject = PowerShellObject.Invoke();
    
    PowerShellObject.Dispose();
    
    SetPowerShellExecutionPolicyToUndefined();
    
    return vServerObject;
}


function GetVServerStatus(vServerURL)
{
    var isVserverRunning = true;
    /*
    var vserverObjectVariableName = "tempVserverObject";
    var cmdlines = GetDevOpsDeploymentImportModuleCmdLine();
    cmdlines += "\r\n" + '$' + vserverObjectVariableName + '=Get-VServer "' + GetVserverHostName(vServerURL) + '"'
    cmdlines += "\r\n" + 'Update-VServer $' + vserverObjectVariableName;
    cmdlines += "\r\n" + '$' + vserverObjectVariableName + '.IsRunning';
    
    var commandsFilePath = Project.Path + "Powershell_Get_Vserver_Status.ps1";
    if (!aqFile.WriteToTextFile(commandsFilePath, cmdlines, aqFile.ctANSI, true))
        Log.Error("Unable to create Commands file : " + commandsFilePath, cmdlines);
     else {
        SetPowerShellExecutionPolicyToUnrestricted();
        
        var oExec = WshShell.Exec("powershell -file " + "\"" + commandsFilePath + "\"");
        oExec.StdIn.Close(); // Close standard input before reading output
        var strOutput = oExec.StdOut.ReadAll();
        var strError = oExec.StdErr.ReadAll();
        
        if (Trim(strError) != ""){
            Log.Error("There was an error running this file on PowerShell : " + commandsFilePath, cmdlines);
            Log.Error(strError, strError);
        }
        
        SetPowerShellExecutionPolicyToUndefined();
        
        //Retrieve the output last line
        var arrayOfOutputLines = Trim(strOutput).split("\n");
        var outputLastLine = Trim(arrayOfOutputLines[arrayOfOutputLines.length - 1]);
        if (aqString.ToUpper(outputLastLine) == "TRUE")
            isVserverRunning = true;
        else if (aqString.ToUpper(outputLastLine) == "FALSE")
            isVserverRunning = false;
        else
            Log.Error("There was an unexpected output result, expecting 'True' or 'False', got : " + outputLastLine, strOutput);
     }
    */
    return isVserverRunning;
}



function GetVServerReference(vServerURL)
{
    var referenceName = "undefined";
    /*
    try {
        var vServerObject = GetVServerObject(vServerURL);
        referenceName = vServerObject.Item(0).ImmediateBaseObject.Reference.Name;
    }
    catch (exc_GetVServerReference){
        Log.Error("Exception from GetVServerReference(): " + exc_GetVServerReference.message, VarToStr(exc_GetVServerReference.stack));
        exc_GetVServerReference = null;
    }
    referenceName = VarToStr(referenceName);
    Log.Message("The vserver reference name is: " + referenceName);
    */
    return referenceName;
}



function GetVServerAssembleScript(vServerURL)
{
    var vServerObject = GetVServerObject(vServerURL);
    
    var vserverAssembleScript = vServerObject.Item(0).ImmediateBaseObject.AssembleScript;
    Log.Message("The vserver Assemble Script is in the Details section.", vserverAssembleScript);
    
    return vserverAssembleScript;
}

function StopVserver(vServer)
  {
      var stopVserverURL = "https://autoref.croesus.local/cgi-bin/rvserver.cgi?master=qaapp1&group=auto&vserver=" + aqString.SubString(vServer, 7, 14) + "&action=stop stop remove";
      var browser = "iexplore";
      Sys.WaitBrowser(browser); 
      //Launch the specified browser and opens the specified URL in it.
      Log.Message("Launch the specified browser and opens the specified URL in it.");
      Browsers.Item(browser).Run(stopVserverURL);
      Sys.Browser(browser).Page("*").Wait();
      
      //Wait for OK button
      aqUtils.Delay(2000);
      var stopActionPage = Sys.Browser(browser).Page(stopVserverURL);
      if (stopActionPage.Exists)
          WaitObject(stopActionPage, "ObjectIdentifier", "Ok", 600000);
      
      var j = 1;
        do {
            j++;
            aqUtils.Delay(4000);
            obj = Sys.Browser(browser).Page(stopVserverURL).FindChild("ObjectIdentifier", "Ok");
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser(browser).Page(stopVserverURL).Button("Ok").Click();
    
    aqUtils.Delay(1000);
    Terminate_IEProcess();
    aqUtils.Delay(2000);  
  }
  
function StartVserver(vServer)
  {
      var startVserverURL = "https://autoref.croesus.local/cgi-bin/rvserver.cgi?master=qaapp1&group=auto&vserver=" + aqString.SubString(vServer, 7, 14) + "&action=push assemble start";
      var browser = "iexplore";
      Sys.WaitBrowser(browser); 
      //Launch the specified browser and opens the specified URL in it.
      Log.Message("Launch the specified browser and opens the specified URL in it.");
      Browsers.Item(browser).Run(startVserverURL);
      Sys.Browser(browser).Page("*").Wait();
      
      //Wait for OK button
      aqUtils.Delay(2000);
      var startActionPage = Sys.Browser(browser).Page(startVserverURL);
      if (startActionPage.Exists)
          WaitObject(startActionPage, "ObjectIdentifier", "Ok", 600000);
      
      var j = 1;
        do {
            j++;
            aqUtils.Delay(4000);
            obj = Sys.Browser(browser).Page(startVserverURL).FindChild("ObjectIdentifier", "Ok");
            if (j == 90) {
                Log.Error("L'élément button OK n'est pas présent sur la page");
                break;
            }
        } while (!obj.Exists);

        //Click on OK button
        Sys.Browser(browser).Page(startVserverURL).Button("Ok").Click();
    
    aqUtils.Delay(1000);
    Terminate_IEProcess();
    aqUtils.Delay(2000);  
  }

function StartVserver1(vServerURL, checkSSHConnexion, maxTries)
{
    if (checkSSHConnexion == undefined)
        checkSSHConnexion = true;
    
    if (maxTries == undefined)
        maxTries = 4;
    
    Log.Message("Start-VServer " + vServerURL + " (maxTries = " + maxTries + ", checkSSHConnexion = " + checkSSHConnexion + ")...");
    var commandsArray, isCommandSuccessful, isVserverRunning, isStartVserverSuccessful;
    
    //Essayer une fois Start-VServer
    SetPowerShellExecutionPolicyToUnrestricted();
    commandsArray = new Array();
    commandsArray.push(GetDevOpsDeploymentImportModuleCmdLine());
    commandsArray.push('Start-VServer "' + GetVserverHostName(vServerURL) + '"');
    isCommandSuccessful = ExecuteCommandsOnPowerShell(commandsArray);
    Delay(10000);
    isVserverRunning = GetVServerStatus(vServerURL);
    SetPowerShellExecutionPolicyToUndefined();
    
    //Résultat du Start-VServer
    Log.Message("Did the Start-VServer command succeed? " + isCommandSuccessful);
    Log.Message("Upon Start-VServer, is VServer running? " + isVserverRunning);
    isStartVserverSuccessful = (isCommandSuccessful && isVserverRunning);
    if (isStartVserverSuccessful && checkSSHConnexion){
        isStartVserverSuccessful = TestSSHConnexions(vServerURL);
    }
    
    //En cas d'échec de Start-VServer, faire Restart-VServer au maximum le nombre de fois restant
    if (maxTries > 1 && !isStartVserverSuccessful){
        Log.Message("The Start-VServer may have failed, trying to Restart-VServer...");
        Delay(30000);
        return RestartVserver(vServerURL, checkSSHConnexion, (maxTries - 1));
    }
    else {
        Log.Message("Is the Start-VServer successful? " + isStartVserverSuccessful);
        return isStartVserverSuccessful;
    }
}



function StopVserver1(vServerURL)
{
    Log.Message("Stop the Vserver : " + vServerURL);
    
    SetPowerShellExecutionPolicyToUnrestricted();
    
    var commandsArray = new Array();
    commandsArray.push(GetDevOpsDeploymentImportModuleCmdLine());
    commandsArray.push('Stop-VServer "' + GetVserverHostName(vServerURL) + '"');
    
    var isCommandSucceeded = ExecuteCommandsOnPowerShell(commandsArray);
    
    if (isCommandSucceeded){
        var isVserverRunning = GetVServerStatus(vServerURL);
        if (!isVserverRunning)
            Log.Message("The Vserver is actually not running.");
        else{
            Log.Error("The Stop Vserver command succeeded but the vserver did not stop.");
            isCommandSucceeded = false;
        }
    }
    
    SetPowerShellExecutionPolicyToUndefined();
    
    return isCommandSucceeded;
}

function RestartVserver(vServer, checkSSHConnexion, maxTries)
{
    if (checkSSHConnexion == undefined)
        checkSSHConnexion = true;
    
    if (maxTries == undefined)
        maxTries = 4;

    StopVserver(vServer);
	StartVserver(vServer);
}

/*
function RestartVserver1(vServerURL, checkSSHConnexion, maxTries)
{
    if (checkSSHConnexion == undefined)
        checkSSHConnexion = true;
    
    if (maxTries == undefined)
        maxTries = 4;
    
    Log.Message("Restart-VServer " + vServerURL + " (maxTries = " + maxTries + ", checkSSHConnexion = " + checkSSHConnexion + ")...");
    var commandsArray, isCommandSuccessful, isVserverRunning, isRestartVserverSuccessful;
    
    //Essayer jusqu'à maxTries fois si échec
    SetPowerShellExecutionPolicyToUnrestricted();
    commandsArray = new Array();
    commandsArray.push(GetDevOpsDeploymentImportModuleCmdLine());
    commandsArray.push('Restart-VServer "' + GetVserverHostName(vServerURL) + '"');
    var countTries = 0;
    do {
        countTries ++;
        Log.Message("Restart-VServer, attempt N°" + countTries + "/" + maxTries + "...");
        if (countTries > 1)
            Delay(30000);
        isCommandSuccessful = ExecuteCommandsOnPowerShell(commandsArray);
        Delay(10000);
        isVserverRunning = GetVServerStatus(vServerURL);
    } while (!(isCommandSuccessful && isVserverRunning) && countTries < maxTries)
    SetPowerShellExecutionPolicyToUndefined();
    
    //Résultat
    Log.Message("Did the Restart-VServer command succeed? " + isCommandSuccessful);
    Log.Message("Upon Restart-VServer, is VServer running? " + isVserverRunning);
    isRestartVserverSuccessful = isVserverRunning;
    if (isVserverRunning === true){
        if (checkSSHConnexion){
            isRestartVserverSuccessful = TestSSHConnexions(vServerURL);
        }
        else {
            isRestartVserverSuccessful = (isCommandSuccessful)? true: undefined;
        }
        Delay(100000);
    }
    
    Log.Message("Is the Restart-VServer successful? " + isRestartVserverSuccessful);
    return isRestartVserverSuccessful;
}
*/


function UpdateVserverAssembleScript(vServerURL, assembleScript)
{
    Log.Message("Update Vserver '" + vServerURL + "' Assemble Script.", assembleScript);
    
    SetPowerShellExecutionPolicyToUnrestricted();
    
    var commandsArray = new Array();
    commandsArray.push(GetDevOpsDeploymentImportModuleCmdLine());
    commandsArray.push('Edit-VServer -VServerName "' + GetVserverHostName(vServerURL) + '" ' + "-AssembleScript \"" + assembleScript + "\"");
    
    var result = ExecuteCommandsOnPowerShell(commandsArray);
    
    SetPowerShellExecutionPolicyToUndefined();
    
    return result;
}



function UpdateClientVserverAssembleScript(vServerURL, isRestartVserverToBeAlwaysExecuted)
{
    var assembleScriptFilePath = folderPath_Data + "AssembleScript_" + client + "_" + versionReference + ".txt";
    Log.Message("Update Vserver '" + vServerURL + "' Assemble Script for client '" + client + "', from file: " + assembleScriptFilePath, assembleScriptFilePath);
    
    if (aqFile.Exists(assembleScriptFilePath)){
        var assembleScriptFileOriginalContent = aqFile.ReadWholeTextFile(assembleScriptFilePath, aqFile.ctANSI);
    }
    else {
        Log.Error("The Assemble Script file was not found: " + assembleScriptFilePath);
        return false;
    }
    
    var assembleScriptFileContent = aqString.Replace(assembleScriptFileOriginalContent, "\r", "");
    assembleScriptFileContent = aqString.Replace(assembleScriptFileContent, "\n", "");
    assembleScriptFileContent = aqString.Replace(assembleScriptFileContent, "FOR_TESTS_AUTO_VSERVER_ROOT_PSWD_TO_BE_SPECIFIED", GET_VSERVER_SSH_ROOT_PSWD());
    assembleScriptFileContent = aqString.Replace(assembleScriptFileContent, "FOR_TESTS_AUTO_VSERVER_URL_TO_BE_SPECIFIED", vServerURL);
    
    var assembleScriptFileContentEscaped = aqString.Replace(assembleScriptFileOriginalContent, '"', '`"');
    assembleScriptFileContentEscaped = aqString.Replace(assembleScriptFileContentEscaped, '$', '`$');
    assembleScriptFileContentEscaped = aqString.Replace(assembleScriptFileContentEscaped, "FOR_TESTS_AUTO_VSERVER_ROOT_PSWD_TO_BE_SPECIFIED", GET_VSERVER_SSH_ROOT_PSWD());
    assembleScriptFileContentEscaped = aqString.Replace(assembleScriptFileContentEscaped, "FOR_TESTS_AUTO_VSERVER_URL_TO_BE_SPECIFIED", vServerURL);
    
    var vserverAssembleScript = GetVServerAssembleScript(vServerURL)
    vserverAssembleScript = aqString.Replace(vserverAssembleScript, "\r", "");
    vserverAssembleScript = aqString.Replace(vserverAssembleScript, "\n", "");
        
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    var triesCount = 0;
    var triesMax = 3;
    var isSuccessful;
    do {
        triesCount++;
        isSuccessful = false;
        Log.Message("UpdateClientVserverAssembleScript: ATTEMPT N°" + IntToStr(triesCount), "", pmNormal, logAttributes);
        if (triesCount > 1)
            Delay(60000);
        
        try {
            if (aqString.Compare(assembleScriptFileContent, vserverAssembleScript, true) != 0){
                isSuccessful = (UpdateVserverAssembleScript(vServerURL, assembleScriptFileContentEscaped) && RestartVserver(vServerURL));
            }
            else {
                Log.Message("The new Assemble Script is the same as the existing one.");
        		isSuccessful = (!isRestartVserverToBeAlwaysExecuted)? TestSSHConnexions(vServerURL): RestartVserver(vServerURL);
            }
        }
        catch(e_UpdateClientVserverAssembleScript){
            Log.Error("Exception from UpdateClientVserverAssembleScript(): " + e_UpdateClientVserverAssembleScript.message, VarToStr(e_UpdateClientVserverAssembleScript.stack), pmNormal, null, Sys.Desktop.Picture());
            e_UpdateClientVserverAssembleScript = null;
            isSuccessful = false;
        }
        
    } while (!isSuccessful && triesCount < triesMax)
    
    return isSuccessful;
}



function GET_VSERVER_SSH_ROOT_PSWD()
{
    var rowIDInExcel;
    var projectName = aqFileSystem.GetFileNameWithoutExtension(Project.FileName);
    
    if (aqString.Find(aqFileSystem.GetFileName(ProjectSuite.FileName), "ProjectSuitePerformance") == 0)
        rowIDInExcel = "Performance";
    else if (projectName == "TransitionWeb")
        rowIDInExcel = "CR1755";
    else if (projectName == "SmokeTestStaging")
        rowIDInExcel = "SmokeTest";
    else
        rowIDInExcel = projectName;
    
    if (typeof VSERVER_SSH_ROOT_PSWD == 'undefined' || VSERVER_SSH_ROOT_PSWD == undefined)
        VSERVER_SSH_ROOT_PSWD = [];
    
    if (VarToStr(VSERVER_SSH_ROOT_PSWD[rowIDInExcel]) == "")
        VSERVER_SSH_ROOT_PSWD[rowIDInExcel] = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "COMMON_SCRIPTS", rowIDInExcel, "ROOT_PSWD");
        
    if (Trim(VarToStr(VSERVER_SSH_ROOT_PSWD[rowIDInExcel])) != ""){
        CheckPasswordStrength(VSERVER_SSH_ROOT_PSWD[rowIDInExcel]);
        return VSERVER_SSH_ROOT_PSWD[rowIDInExcel];
    }
    
    CheckPasswordStrength(VSERVER_SSH_ROOT_DEFAULT_PSWD);
    return VSERVER_SSH_ROOT_DEFAULT_PSWD;
}



function CheckPasswordStrength(varPassword)
{
    var specialChars = ['!', '#', '$', '%', '&', "'", '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~'];
    var lowerChars = ["a", "b ", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
    var upperChars = ["A", "B ", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    var digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    var notRecommandedChars = [' ', '"'];
    var nbCharMin = 15;
    
    var isNotRecommandedCharFound = false;
    var isSpecialCharFound = false;
    var isLowerAlphabetFound = false;
    var isUpperAlphabetFound = false;
    var isDigitFound = false;
    var isNbOfCharsOK = false;
    var arrayPassword = varPassword.split("");
    if (arrayPassword.length >= nbCharMin)
        isNbOfCharsOK = true
    for (var i in arrayPassword){
        if (GetIndexOfItemInArray(specialChars, arrayPassword[i]) != -1)
            isSpecialCharFound = true;
        else if (GetIndexOfItemInArray(lowerChars, arrayPassword[i]) != -1)
            isLowerAlphabetFound = true;
        else if (GetIndexOfItemInArray(upperChars, arrayPassword[i]) != -1)
            isUpperAlphabetFound = true;
        else if (GetIndexOfItemInArray(digits, arrayPassword[i]) != -1)
            isDigitFound = true;
        else if (GetIndexOfItemInArray(notRecommandedChars, arrayPassword[i]) != -1)
            isNotRecommandedCharFound = true;
    }
    
    var isPasswordStrengthOK = (isNbOfCharsOK === true && isSpecialCharFound === true && isLowerAlphabetFound === true && isUpperAlphabetFound === true && isDigitFound === true);
    
    if (isPasswordStrengthOK == false){
        var msgIssue = "Le mot de passe : " + varPassword;
        if (isNbOfCharsOK == false)
            msgIssue += "\r\nn'a pas au moins " + nbCharMin +   " caractères.";
        if (isSpecialCharFound == false)
            msgIssue += "\r\nne contient pas de caractère spécial.";
        if (isLowerAlphabetFound == false)
            msgIssue += "\r\nne contient pas de caractère alphabétique minuscule.";
        if (isUpperAlphabetFound == false)
            msgIssue += "\r\nne contient pas de caractère alphabétique majuscule.";
        if (isDigitFound == false)
            msgIssue += "\r\nne contient pas de chiffre.";
        Log.Warning("Le mot de passe " + varPassword + " ne respecte pas les contraintes (au moins " + nbCharMin +   " caractères, au moins un caractère spécial/minuscule/majuscule/chiffre).", msgIssue);
    }
    
    if (isNotRecommandedCharFound === true){
        var notRecommandedCharsString = "";
        for (var k in notRecommandedChars)
            notRecommandedCharsString += " '" + notRecommandedChars[k] + "'";
        Log.Warning("Le mot de passe " + varPassword + " contient un ou des caractères non recommandés dans le projet :" + notRecommandedCharsString);
    }
    
    return isPasswordStrengthOK;
}



function TerminateProcess_TestExecute()
{
    if (Project.TestItems.Current != undefined){
        Log.Message("TerminateProcess_TestExecute()...");
        
        Log.Message('WshShell.Run: CMD /C IF EXIST %temp%\\tcResults1.mht DEL /F /Q %temp%\\tcResults1.mht', 'CMD /C IF EXIST %temp%\\tcResults1.mht DEL /F /Q %temp%\\tcResults1.mht');
		WshShell.Run('CMD /C IF EXIST %temp%\\tcResults1.mht DEL /F /Q %temp%\\tcResults1.mht', 1, true);
        
		var powershellScript = '"$TimeOut = (Get-Date).AddMinutes(2); while (-not (Test-Path $env:temp\\tcResults1.mht) -and (Get-Date) -lt $TimeOut){Start-Sleep 10}; Start-ScheduledTask -TaskName Task_Kill_Process_TestExecute.bat"';
        Log.Message('WshShell.Run: CMD /C powershell -command ' + powershellScript, 'CMD /C powershell -command ' + powershellScript);
		WshShell.Run('CMD /C powershell -command ' + powershellScript, 0, false);
	}
}



//Close Browser
function CloseBrowser(browserName)
{
    TerminateProcess(browserName);
}


//Terminate IE process
function Terminate_IEProcess()
{
    TerminateProcess("iexplore");
}


//Ternimate Croesus Application process
function Terminate_CroesusProcess()
{
    //if (Sys.WaitProcess("CroesusClient", 5000).Exists)
    //{
    //    Sys.Process("CroesusClient").Terminate();
    //}
    //TerminateProcess("CroesusClient"); //Mis en commentaire, best practice: Il faut éviter de faire l'encapsulation d'une seule function. De plus, TerminateProcess est browser oriented. Sys.process built in TC est plus rapide pour l'app WFC Croesus.
    //Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Le WaitProcess dans cette fonction atteint ce but.
    
    TerminateProcess("CroesusClient"); //Une raison de l'utilisation de la fonction TerminateProcess(), c'est pour s'assurer de fermer toutes instances du processus au cas où il y en aurait plusieurs.
}



function TerminateProcess(processName)
{
    try {
        Log.Message("Terminate process '" + processName + "'...");
        var timerTerminateProcess = HISUtils.StopWatch;
        var timeTerminateProcess = 0;
        var loopsCount = 0;
        var waitProcessName = ("edge" == aqString.ToLower(Trim(processName)))? "ms" + Trim(processName): processName;
        var timeoutWaitProcessToClose = (GetIndexOfItemInArray(["iexplore", "chrome", "croesusclient"], aqString.ToLower(Trim(waitProcessName))) != -1)? 30000: 15000;
        var timeOutTerminateProcess = (typeof maxWaitTime == 'undefined' || maxWaitTime < 90000)? 90000: maxWaitTime;
        
        do {
            timerTerminateProcess.Start();
            loopsCount++;
            //Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Les instructions dans ce loop donnent déjà le temps au process de se fermer.
            Delay(5000); //Avant d'avoir éventuellement fait une validation précise, il vaut mieux pour le moment conserver ce temps d'attente statique de 5 secondes car il a permis une sensible réduction de messages d'erreurs indésirables.
            Sys.Refresh();
            var processInstance = Sys.WaitProcess(waitProcessName, 300);
            if (processInstance.Exists){
                //First try to Close() the found process instance if process not in the following list: "excel", "firefox", "acrobat", "acrord32", "onenotem", "dfsvc"
                if (GetIndexOfItemInArray(["excel", "firefox", "acrobat", "acrord32", "onenotem", "dfsvc"], aqString.ToLower(Trim(waitProcessName))) == -1){
                    Log.Message("Terminating process '" + waitProcessName + "', execute: Close()...");
                    processInstance.Close(timeoutWaitProcessToClose);
                    
                    //In case of CroesusClient, validate Confirmation dialog box, if prompted
                    if (aqString.ToLower(Trim(waitProcessName)) == "croesusclient"){
                        var previousAutoTimeout = Options.Run.Timeout;
                        SetAutoTimeOut();
                        if (Get_DlgConfirmation().Exists){
                            Log.Message("Confirmation dialog box found, validate...")
                            Get_DlgConfirmation_BtnYes().HoverMouse();
                            Get_DlgConfirmation_BtnYes().Click();
                            Delay(5000);
                            Sys.Refresh();
                        }
                        RestoreAutoTimeOut(previousAutoTimeout);
                    }
                    
                    WaitObjectPropertyExistsToFalse(processInstance, 5000); //Wait some time for the process to actually disappear
                }
                
                //If the found process instance instance still exists (because directly elligible for termination or because of previous close command failure), try to Terminate() it
                processInstance.Refresh();
                if (processInstance.Exists){
                    Log.Message("Terminating process '" + waitProcessName + "', execute: Terminate()...");
                    processInstance.Terminate();
                    WaitObjectPropertyExistsToFalse(processInstance, 5000); //Wait some time for the process to actually disappear
                }
            }
            
            timeTerminateProcess = timerTerminateProcess.Stop();
            Delay(100);
        } while (timeTerminateProcess < timeOutTerminateProcess && Sys.WaitProcess(waitProcessName, 300).Exists)
    }
    catch (excTerminateProcess) {
        Log.Warning("Exception from TerminateProcess('" + processName + "'). " + excTerminateProcess.message, VarToStr(excTerminateProcess.stack), pmNormal, null, Sys.Desktop.Picture());
        excTerminateProcess = null;
    }
    finally {
        timerTerminateProcess.Reset();
        Delay(100);
        if (Sys.WaitProcess(waitProcessName).Exists){
            Log.Warning("Process '" + waitProcessName + "' not terminated by " + timeTerminateProcess + "ms.", "", pmNormal, null, Sys.Desktop.Picture());
        }
        
        if (timeTerminateProcess >= timeOutTerminateProcess){
            Log.Message("TimeOut (" + timeOutTerminateProcess + "ms) reached while terminating process '" + processName + "'.");
            if (loopsCount > 1)
                Log.Message("TerminateProcess: Le loopsCount est de " + loopsCount + " répétitions.");
                
            //Temp, To Be Deleted
            ///*
            var executionComputerName = "ComputerNameUndefined";
            try {executionComputerName = VarToStr(Sys.HostName);} catch (sys_e){executionComputerName = "ComputerNameUndefined"; sys_e = null;}
            SendMail("youlia.raisper@croesus.com;xian.wei@croesus.com", "mail.croesus.com", "TerminateProcess TimeOut", "testauto@croesus.com", aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + " TerminateProcess TimeOut", "Computer = " + executionComputerName + "\r\nProject = " + aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + "\r\n" + timeTerminateProcess + "ms => TimeOut (" + timeOutTerminateProcess + "ms) reached while terminating process '" + processName + "'.\r\nloopsCount = " + loopsCount);
            //*/
                
            var hangingProcess = Sys.WaitProcess(waitProcessName, 300);
            if (hangingProcess.Exists){
                if (GetIndexOfItemInArray(["iexplore", "chrome", "firefox", "edge"], aqString.ToLower(Trim(processName))) == -1)
                    hangingProcess.SaveDumpToLog();
                else
                    Sys.Browser(processName).SaveDumpToLog();
            }
        }
        
        Delay(100);
        Sys.Refresh();
    }
}



/**
    Description : Ouvre une session sur l'application Croesus
    Paramètres : vServerURL (URL du VServer)
                 userName (ID de d'utilisateur)
                 psw (Mot de passe de l'utilisateur)
                 language (langue de la session : french/english)
                 browserName (navigateur : iexplore/chrome/firefox..)
                 debugMode (permet d'activer le debugMode)
                 maxTries (nombre maximum de tentatives en cas d'échec ; valeur par défaut : 2)
    Résultat :  true (si l'ouverture de session a réussi)
                false (si l'ouverture de session n'a pas réussi)
    Auteur : Christophe Paring
*/
function Login(vServerURL, userName, psw, language, browserName, debugMode, maxTries)
{
    var isLoginSuccessful;
    var maxTimeAllowedForLogin = 900000; //In milliseconds
    var waitTimeBetweenTries = 120000; //In milliseconds
    if (maxTries == undefined)
        maxTries = 2;
    
	try {
        if (typeof LOGIN_ERROR_COUNT_TO_DISCARD == 'undefined' || LOGIN_ERROR_COUNT_TO_DISCARD == undefined){
            LOGIN_ERROR_COUNT_TO_DISCARD = 0;
        }
        
        var countTries = 0;
        EnableLoginTimeOutTimer(maxTimeAllowedForLogin);
        do {
            try {
                var LogErrCountBeforeLoginTry = Log.ErrCount;
                countTries ++;
                isLoginSuccessful = false;
                Login_Once(vServerURL, userName, psw, language, browserName, debugMode);
                isLoginSuccessful = true;
                DisableLoginTimeOutTimer();
            }
            catch(excLoginOnce) {
                if (countTries >= maxTries){
                    throw excLoginOnce;
                }
                else if (!isLoginSuccessful){
                    Log.Warning("Login has previously failed during attempt N°" + countTries + "/" + maxTries + ". " + excLoginOnce.message + ". Trying again...", VarToStr(excLoginOnce.stack), pmNormal, null, Sys.Desktop.Picture());
                    //Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Ces validations sont dans Login_Once et les functions qu'il utilise.
                    Delay(waitTimeBetweenTries); //Avant d'avoir éventuellement fait une validation précise, il vaut mieux pour le moment conserver ce temps d'attente statique car il contribue à une meilleure stabilité.
                    excLoginOnce = null;
                }
            }
            finally {
                if (countTries < maxTries){
                    LOGIN_ERROR_COUNT_TO_DISCARD += Log.ErrCount - LogErrCountBeforeLoginTry;
                }
            }
        } while (!isLoginSuccessful && countTries < maxTries)
    }
    catch(excLogin) {
        Log.Error("Exception during Login attempt N°" + countTries + "/" + maxTries + ". " + excLogin.message, VarToStr(excLogin.stack), pmNormal, null, Sys.Desktop.Picture());
        excLogin = null;
	}
    finally {
        if (!isLoginSuccessful){
            Log.Error("Issue encountered during Login.", "", pmNormal, null, Sys.Desktop.Picture());
            DisableLoginTimeOutTimer();
        }
        
        return isLoginSuccessful;
    }
}



/**
    Description : Effectue une tentative d'ouverture de session sur l'application Croesus
    Paramètres : vServerURL (URL du VServer)
                 userName (ID de d'utilisateur)
                 psw (Mot de passe de l'utilisateur)
                 language (langue de la session : french/english)
                 browserName (navigateur : iexplore/chrome/firefox..)
                 debugMode (permet d'activer le debugMode)
    Résultat :  true (si l'ouverture de session a réussi)
                false (si l'ouverture de session n'a pas réussi)
    Auteur : Christophe Paring
*/
function Login_Once(vServerURL, userName, psw, language, browserName, debugMode)
{
    Log.Message("Croesus Login with: " + userName, "VServer URL =  " + vServerURL);
    
    //Launch the specified browser and open the specified URL in it.
    Login_InitializeAndLaunchBrowser(vServerURL, language, browserName, debugMode);
    
    var isUserNameAutoFilled = false; //Mettre à true au cas où le nom d'utilisateur ne doit pas être saisi, une vérification sera alors faite pour s'assurer que le nom d'utilisateur affiché est bien celui avec lequel on veut se connecter.
    
    //Fill Webpage and Launch Croesus.
    switch (versionReference){
        case "MAINLINE-90-18-45":
            Login_FillAndLaunchCroesus_Version_MAINLINE_90_18_45(vServerURL, userName, psw, language, browserName, isUserNameAutoFilled);
            break;
            
        case "FM-13":
            Login_FillAndLaunchCroesus_Version_FM13(vServerURL, userName, psw, language, browserName, isUserNameAutoFilled);
            break;
            
        default:
            throw new Error("Variable versionReference value not supported: '" + VarToStr(versionReference) + "'.");
    }
    
    //Run Click Once.
    Login_RunClickOnce();
    
    //End Login
    Login_End();
}



function Login_InitializeAndLaunchBrowser(vServer, language, browserName, debugMode)
{
    var maxNbOfTries = 3;
    var debudModeString = (debugMode)? debugMode: "";
    
    //Internet Explorer is the browser to be used by default
    if (browserName == undefined)
        browserName = "iexplore";
    
    //Close Processes
    TerminateProcess("dfsvc");
    Terminate_CroesusProcess();
    
    //Launch the specified browser and opens the specified URL in it
    Log.Message("Launch browser '" + browserName + "' and navigate to the '" + vServer + debudModeString + "' page...");
    var nbOfTries = 0;
    do {
        nbOfTries++;
        CloseBrowser(browserName);
        if (nbOfTries > 1){
            Log.Warning("Navigating to the " + vServer + " page may have previously failed. Try " + nbOfTries + "/" + maxNbOfTries + "...", "", pmNormal, null, Sys.Desktop.Picture());
            Delay(30000);
        }
        
        Browsers.Refresh();
        Browsers.Item(browserName).Run();
        if (!Sys.WaitBrowser(browserName, 60000).Exists || !Sys.WaitBrowser(browserName).WaitBrowserWindow(0, 60000).Exists)
            Browsers.Item(browserName).Run();
        
        if (Sys.WaitBrowser(browserName, 60000).Exists && Sys.WaitBrowser(browserName).WaitBrowserWindow(0, 60000).Exists)
            Browsers.Item(browserName).Navigate(vServer + debudModeString);
        else
            Browsers.Item(browserName).Run(vServer + debudModeString);
        
    } while ((nbOfTries < maxNbOfTries) && !(Sys.Browser().WaitPage(vServer + "*", 60000).Exists));
    
    //Check if VServer webpage exists
    if (!(Sys.Browser().WaitPage(vServer + "*", 60000).Exists)){
        throw new Error("Navigating to the " + vServer + " page failed by timeout.");
    }
    
    //Wait until the browser loads the page and is ready to accept user input.
    Sys.Browser().Page(vServer + "*").Wait();
    Sys.Browser().BrowserWindow(0).Restore();
    Sys.Browser().BrowserWindow(0).Maximize();
    
    //Load Input form
    Login_LoadInputForm(language);
}



function Login_LoadInputForm(language)
{
    if (versionReference == "FM-13"){
        return Login_LoadInputForm_Version_FM13(language);
    }
    
    var maxNbOfTries = 3;
    
    //Change Language if needed
    var pageObject = Sys.Browser().Page("*");
    var languageChangeTriesLeft = maxNbOfTries;
    do {
        pageObject.Wait();
        Delay(1000);
        
        //Wait for either Header panel or Login panel
        var headerAndLoginPanelChecksLeft = (2 * maxNbOfTries);
        var headerPanel = Utils.CreateStubObject();
        var loginPanel = Utils.CreateStubObject();
        do {
            pageObject.Refresh();
            headerPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "header", "header", true], 20, true, 3000);
            if (!headerPanel.Exists){
                loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 3000);
            }            
        } while (!headerPanel.Exists && !loginPanel.Exists && --headerAndLoginPanelChecksLeft > 0)
        
        if (headerPanel.Exists){//Disconnect
            var disconnectPanel = headerPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "0", true], 10, true, 1000);
            disconnectPanel.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Button", "0", true], 10).Click();
            var disconnectSubmenu = disconnectPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "myDropdown", true], 10, true, 5000);
            var signOutButton = disconnectSubmenu.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", "0", true], 10, true, 3000);
            signOutButton.HoverMouse();
            signOutButton.Click();
            //If the Click on Sign Out button did not succeed (button is still displayed), try once again
            signOutButton.Refresh();
            if (signOutButton.Exists && !WaitObjectPropertyExistsToFalse(signOutButton, 10000) && !signOutButton.WaitProperty("VisibleOnScreen", false, 5000)){
                signOutButton.Refresh();
                if (signOutButton.Exists && signOutButton.VisibleOnScreen){
                    signOutButton.Click();
                }
            }
            
            //Wait for Login panel
            loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 15000);
        }
        
        if (!loginPanel.Exists)
            throw new Error("Login panel (for Username and Password input) not displayed.");
        
        var alternateLanguageLabel = (language == "french")? "language English": "language Français";
        var isAlternateLanguageButtonDisplayed = (loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", alternateLanguageLabel, true], 20, true, 5000).Exists);
        if(!isAlternateLanguageButtonDisplayed){//Change Language
            var languageLabel = (language == "french")? "language Français": "language English";
            loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", languageLabel, true], 20, true, 5000).Click();
            pageObject.Wait();
            isAlternateLanguageButtonDisplayed = (loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", alternateLanguageLabel, true], 20, true, 5000).Exists);
        }
    } while (!isAlternateLanguageButtonDisplayed && --languageChangeTriesLeft > 0);
}



//Login >= MAINLINE-90-18-45
function Login_FillAndLaunchCroesus_Version_MAINLINE_90_18_45(vServer, userName, psw, language, browserName, isUserNameAutoFilled)
{    
    //Input UserName and Password, and Sign In
    var pageObject = Sys.Browser().Page("*");
    var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 3000);
    var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "1", "", true], 10, true, 5000);
    var txtUsername = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Textbox", "Username", true], 10, true, 5000);
    var txtPassword = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["PasswordBox", "Password", true], 10, true, 5000);
    var signInLabel = (language == "french")? "Se connecter": "Sign in";
    var signButton = loginForm.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", signInLabel, true], 10, true, 5000);
    
    if (isUserNameAutoFilled){
        Log.Message("As 'isUserNameAutoFilled' is enabled, the userName will not be filled; instead, the userName box Text will be checked against the login userName '" + userName + "'.");
        txtUsername.WaitProperty("Text", userName, 10000);
        CheckEquals(txtUsername.Text, userName, "The login UserName");
    }
    else {
      txtUsername.Click();
      txtUsername.Keys("^a[BS]");
      txtUsername.Keys(userName);
    }
    
    txtPassword.Click();
    txtPassword.Keys("^a[BS]");
    txtPassword.Keys(psw);
    signButton.Click();
    pageObject.Wait();
    
    //If Firefox browser, click on the Fx Click Once button
    if (browserName == "firefox"){
        Log.Message("For FireFox browser, click on the 'Fx Click Once' button");
        Sys.Browser(browserName).WaitWindow("MozillaDialogClass", "Opening CroesusClient.application", -1, 5000);
        var clickOnceInstallButton = Sys.Browser(browserName).FindChild("Name", 'button("FxClickOnce_RunButton")', 100);
        if (clickOnceInstallButton.Exists)
            clickOnceInstallButton.Click();
        else
            Log.Message("Firefox browser : The 'Fx Click Once' button was not found.");
    }
            
    //If no "Launch Croesus Advisor" button, check if PREF_MAX_USER error message is displayed
    if (!WaitObject(pageObject, "idStr", "launcher")){
        if (language == "french")
            var PREF_MAX_USER_errorMsg = "Un utilisateur s’est connecté avec le nom d'utilisateur " + userName + ". Le nombre maximum de sessions a été atteint. Vous avez été déconnecté.";
        else
            var PREF_MAX_USER_errorMsg = "A user signed in with the username " + userName + ". The maximum number of sessions is exceeded. You have been signed out.";
        
        loginForm.Click(10, 10);
        Delay(2000);
        loginForm.Keys("[Tab][Tab][Tab][Tab]");
        Delay(2000);
        var tempSavedClipboard = Sys.Clipboard;
        Sys.Clipboard = "";
        loginForm.Keys("^a^c");
        loginForm.Click(10, 10);
        var nbClipboardChecksLeft = 400;
        do {
            Delay(50);
            var is_PREF_MAX_USER_errorMsg_found = (GetVarType(Sys.Clipboard) == varOleStr && aqString.Find(Sys.Clipboard, PREF_MAX_USER_errorMsg) != -1);
        } while (!is_PREF_MAX_USER_errorMsg_found && --nbClipboardChecksLeft > 0);
        Sys.Clipboard = tempSavedClipboard;
        
        if (is_PREF_MAX_USER_errorMsg_found){
            Log.Error(PREF_MAX_USER_errorMsg);
            Log.Error("JIRA : CROES-11379 / CROES-10330 / CROES-6618 / CROES-5664");
            
            //Execute SQL to cleanup user connections
            var connectionsCleanupSQL = "";
            connectionsCleanupSQL += "declare @now datetime set @now = getdate() \r\n";
            connectionsCleanupSQL += "declare @today datetime set @today = convert(varchar, @now, 101) \r\n";
            connectionsCleanupSQL += "update b_login set status='0', disconnect_date = @today where STATION_ID = '" + userName + "' and STATUS = '1' and SOFTWARE_ID = 3 and CONNECT_DATE > @today \r\n";
            Log.Message("Execute SQL to cleanup " + userName + " connections.", connectionsCleanupSQL);
            Execute_SQLQuery(connectionsCleanupSQL, vServer);
        }
    }
    
    //Click on "Launch Croesus Advisor" button
    Sys.Refresh();
    if (Sys.WaitProcess("dfsvc", 1000).Exists){
        Sys.WaitProcess("dfsvc").Refresh();
        Delay(1000);
    }
    pageObject.Refresh();
    if (!(pageObject.FindChildEx("idStr", "launcher", 100, true, 15000).Exists))
        throw new Error("Launcher button not found.");
    
    pageObject.FindChild("idStr", "launcher", 100).Click();
    
    
    //From DBA
    function GetDBAConnectionString(vServerURL)
    {
        var source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
        if (client == "CIBC") 
               source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb02";
        if (projet == "PerformanceNFR" || projet == "Performance"){
            //return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
            return source;
        }
        else if (projet == "General"){
            var BDNum = aqString.SubString(vServerURL, 19, 2);
            return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + BDNum;
        }
        else {
            Log.Error("Valeur '" + projet + "' non supportée pour la variable globale : projet.");
            return "";
        }
    }
    
    //From DBA
    function Execute_SQLQuery(queryString, vServer) 
    {
        var query= queryString;
        var Qry =ADO.CreateADOQuery();
        Qry.ConnectionString =GetDBAConnectionString(vServer);
        Qry.SQL=query;
        Qry.ExecSQL();
    }
}



function Login_LoadInputForm_Version_FM13(language)
{
    var maxNbOfTries = 3;
    
    //Change Language if needed
    var pageObject = Sys.Browser().Page("*");
    var languageChangeTriesLeft = maxNbOfTries;
    do {
        pageObject.Wait();
        Delay(1000);
        var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        if (!loginPanel.Exists){
            throw new Error("Login panel (for Username and Password input) not displayed.");
        }
        
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        var isDisplayedLanguageTheExpected = (aqString.Find(VarToStr(loginForm.innerHTML), 'language="' + aqString.SubString(language, 0, 2) + '-') != -1);
        if (!isDisplayedLanguageTheExpected){
            loginForm.Click(10, 10);
            Delay(1000);
            loginForm.Keys("[Tab][Tab][Tab][Tab][Tab]");
            Delay(1000);
            loginForm.Keys("[Enter]");
        }
    } while (!isDisplayedLanguageTheExpected && --languageChangeTriesLeft > 0);
}



//Login FM-13
function Login_FillAndLaunchCroesus_Version_FM13(vServer, userName, psw, language, browserName, isUserNameAutoFilled)
{
    var maxNbOfTries = 3;
    var pageObject = Sys.Browser().Page("*");
    var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
    var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
    
    //Input userName    
    if (isUserNameAutoFilled){
        var displayedUserName = null;
        Log.Message("As 'isUserNameAutoFilled' is enabled, the userName will not be filled; instead, the userName box Text will be checked against the login userName '" + userName + "'.");
    }
    
    var userNameInputTriesLeft = maxNbOfTries;
    do {
        loginForm.Click(10, 10);
        Delay(2000);
        var tempSavedClipboard = Sys.Clipboard;
        Sys.Clipboard = "";
        
        if (isUserNameAutoFilled){
            loginForm.Keys("[Tab]^a^c[Tab]");
        }
        else {
            loginForm.Keys("[Tab]^a[Del]" + userName + "^a^c[Tab]");
        }
        
        var nbClipboardChecksLeft = 400;
        do {
            Delay(50);
            var displayedUserName = Sys.Clipboard;
            var isInputUserNameTheExpected = (GetVarType(Sys.Clipboard) == varOleStr && Sys.Clipboard == userName);
        } while (!isInputUserNameTheExpected && --nbClipboardChecksLeft > 0);
        Sys.Clipboard = tempSavedClipboard;
    } while (!isInputUserNameTheExpected && --userNameInputTriesLeft > 0);
    
    
    if (isUserNameAutoFilled){
        CheckEquals(displayedUserName, userName, "The login UserName");
    }
    
    //Input Password and validate
    Delay(1000);
    if (psw != null)
        loginForm.Keys(psw);
    Delay(1000);
    loginForm.Keys("[Enter]");
    pageObject.Wait();
    
    //If Firefox browser, click on the Fx Click Once button
    if (browserName == "firefox"){
        Log.Message("For FireFox browser, click on the 'Fx Click Once' button");
        Sys.Browser(browserName).WaitWindow("MozillaDialogClass", "Opening CroesusClient.application", -1, 5000);
        var clickOnceInstallButton = Sys.Browser(browserName).FindChild("Name", 'button("FxClickOnce_RunButton")', 100);
        if (clickOnceInstallButton.Exists)
            clickOnceInstallButton.Click();
        else
            Log.Message("Firefox browser : The 'Fx Click Once' button was not found.");
    }
            
    //If no "Launch Croesus Advisor" button, check if PREF_MAX_USER error message is displayed
    if (!WaitObject(pageObject, "idStr", "launcher")){
        if (language == "french")
            var PREF_MAX_USER_errorMsg = "Un utilisateur s’est connecté avec le nom d'utilisateur " + userName + ". Le nombre maximum de sessions a été atteint. Vous avez été déconnecté.";
        else
            var PREF_MAX_USER_errorMsg = "A user signed in with the username " + userName + ". The maximum number of sessions is exceeded. You have been signed out.";
        
        loginForm.Click(10, 10);
        Delay(2000);
        loginForm.Keys("[Tab][Tab][Tab][Tab]");
        Delay(2000);
        var tempSavedClipboard = Sys.Clipboard;
        Sys.Clipboard = "";
        loginForm.Keys("^a^c");
        loginForm.Click(10, 10);
        var nbClipboardChecksLeft = 400;
        do {
            Delay(50);
            var is_PREF_MAX_USER_errorMsg_found = (GetVarType(Sys.Clipboard) == varOleStr && aqString.Find(Sys.Clipboard, PREF_MAX_USER_errorMsg) != -1);
        } while (!is_PREF_MAX_USER_errorMsg_found && --nbClipboardChecksLeft > 0);
        Sys.Clipboard = tempSavedClipboard;
        
        if (is_PREF_MAX_USER_errorMsg_found){
            Log.Error(PREF_MAX_USER_errorMsg);
            Log.Error("JIRA : CROES-11379 / CROES-10330 / CROES-6618 / CROES-5664");
            
            //Execute SQL to cleanup user connections
            var connectionsCleanupSQL = "";
            connectionsCleanupSQL += "declare @now datetime set @now = getdate() \r\n";
            connectionsCleanupSQL += "declare @today datetime set @today = convert(varchar, @now, 101) \r\n";
            connectionsCleanupSQL += "update b_login set status='0', disconnect_date = @today where STATION_ID = '" + userName + "' and STATUS = '1' and SOFTWARE_ID = 3 and CONNECT_DATE > @today \r\n";
            Log.Message("Execute SQL to cleanup " + userName + " connections.", connectionsCleanupSQL);
            Execute_SQLQuery(connectionsCleanupSQL, vServer);
        }
    }
    
    //Click on "Launch Croesus Advisor" button
    Sys.Refresh();
    if (Sys.WaitProcess("dfsvc", 1000).Exists){
        Sys.WaitProcess("dfsvc").Refresh();
        Delay(1000);
    }
    pageObject.Refresh();
    if (!(pageObject.FindChildEx("idStr", "launcher", 100, true, 15000).Exists))
        throw new Error("Launcher button not found.");
    
    pageObject.FindChild("idStr", "launcher", 100).Click();
    
    
    //From DBA
    function GetDBAConnectionString(vServerURL)
    {
        var source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
        if (client == "CIBC") 
               source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb02";
        if (projet == "PerformanceNFR" || projet == "Performance"){
            //return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
            return source;
        }
        else if (projet == "General"){
            var BDNum = aqString.SubString(vServerURL, 19, 2);
            return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + BDNum;
        }
        else {
            Log.Error("Valeur '" + projet + "' non supportée pour la variable globale : projet.");
            return "";
        }
    }
    
    //From DBA
    function Execute_SQLQuery(queryString, vServer) 
    {
        var query= queryString;
        var Qry =ADO.CreateADOQuery();
        Qry.ConnectionString =GetDBAConnectionString(vServer);
        Qry.SQL=query;
        Qry.ExecSQL();
    }
}



function Login_RunClickOnce()
{
    var maxNbOfTries = 3;
    
    //Delay(3000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. WaitProcess pour dfsvc joue déjà ce rôle.
    Sys.Refresh();
    var dfsvcProcess = Sys.WaitProcess("dfsvc", 15000); //Passé à 15 secondes d'attente du process pour contrebalancer le 3 sec delay au besoin.
    if (!dfsvcProcess.Exists){
        return;
    }
    
    var languageWindowsUser = GetWindowsDisplayLanguage();
    var wndCaptionSecurityWarning = (languageWindowsUser == "french")? "Fichier ouvert - Avertissement de sécurité": "Open File - Security Warning";
    var winSecurityWarning = dfsvcProcess.WaitWindow("#32770", wndCaptionSecurityWarning, 1, 5000);
    if (!winSecurityWarning.Exists){
        //If you run a vServer for the first time, click on Install button and wait longer for "Open File - Security Warning"
        Sys.Refresh();
        dfsvcProcess.Refresh();
        var winTrustManagerPromptUI = dfsvcProcess.WaitWinFormsObject("TrustManagerPromptUI", 5000);
        if (winTrustManagerPromptUI.Exists){
            var installClickTriesLeft = maxNbOfTries;
            while (winTrustManagerPromptUI.Exists && --installClickTriesLeft > 0){
                winTrustManagerPromptUI.Refresh();
                Delay(1000);
                winTrustManagerPromptUI.WinFormsObject("tableLayoutPanelOuter").WinFormsObject("tableLayoutPanelButtons").WinFormsObject("btnInstall").Click();
                WaitObjectPropertyExistsToFalse(winTrustManagerPromptUI, 10000);
            }
            
            Sys.Refresh();
            dfsvcProcess.Refresh();
            var winUserInterfaceForm = dfsvcProcess.WaitWinFormsObject("UserInterfaceForm", 5000);
            if (winUserInterfaceForm.Exists){
                var nbOfWinSecurityWarningChecks = 0;
                do {
                    dfsvcProcess.Refresh();
                    winSecurityWarning = dfsvcProcess.WaitWindow("#32770", wndCaptionSecurityWarning, 1, 5000);
                } while (++nbOfWinSecurityWarningChecks < 30 && !winSecurityWarning.Exists && !Sys.WaitProcess("CroesusClient", 5000).Exists)
            }
        }
    }
    
    //If the "Open File - Security Warning" is displayed, click on Run button
    var runClickTriesLeft = maxNbOfTries;
    while (winSecurityWarning.Exists && --runClickTriesLeft > 0){
        winSecurityWarning.Refresh();
        Delay(1000);
        if (languageWindowsUser == "french")
            winSecurityWarning.Window("Button", "&Exécuter", 1).Click();
        else
            winSecurityWarning.Window("Button", "&Run", 1).Click();
        
        WaitObjectPropertyExistsToFalse(winSecurityWarning, 10000);
    }
}



function Login_End()
{
    //Delay(3000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. WaitProcess pour CroesusClient joue déjà ce rôle.
    Sys.Refresh();
    if (!Sys.WaitProcess("CroesusClient", 65000).Exists){ //Passé à 65 secondes d'attente du process pour contrebalancer le 3 sec delay au besoin.
        throw new Error("CroesusClient process not found by timeout (" + 65000 + " ms).");
    }
    
    //Wait for Croesus App Main Window
    WaitObject(Get_CroesusApp(), "Uid", "Window_5bbd");
    var countWaitMainWindow = 0;
    do {
        if (Get_MainWindow().Exists){
            break;
        }
        
        if (Get_DlgError().Exists){
            throw new Error("Error dialog box found!");
        }
    } while ((++countWaitMainWindow) < 3)
    
    //Check if Croesus App Main Window exists
    if (!(Get_MainWindow().Exists)){
        throw new Error("Login_End: Croesus App Main Window not found.");
    }
    
    Log.Message("Login_End: Croesus App Main Window found.");
    Get_MainWindow().WaitProperty("VisibleOnScreen", true, 20000);
    WaitObject(Get_MainWindow(), "Uid", "WPFWindowContainer_7458", 30000);
    
    //Close What's new dialog box
    if (Get_WinWhatsNew().Exists){
        Get_WinWhatsNew_ChkDoNotShowThisDialogBoxAgain().set_IsChecked(true);
        Get_WinWhatsNew_BtnClose().Keys("[Enter]");
    }
    
    //Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Valider_Presence_Dashboards joue ce rôle.
    Get_MainWindow().Maximize();
    Valider_Presence_Dashboards();
    
    //Check if Croesus App crashed
    var previousAutoTimeout = Options.Run.Timeout;
    SetAutoTimeOut(15000);
    var isCrashDetectedOrMainWindowNotFound = ((Get_DlgError().Exists) || !(Get_MainWindow().Exists));
    RestoreAutoTimeOut(previousAutoTimeout);
    if (isCrashDetectedOrMainWindowNotFound)
        throw new Error("Croesus App may have crashed.");
}



function Valider_Presence_Dashboards()
{
    var isFound1 = false
    var isFound2 = false
    var isFound3 = false
    var isFound4 = false
    var maxTime = 15000
    var timer = HISUtils.StopWatch;
    var timeSpent = 0;
    
    
    do {
        timer.Start();
        
        if (!isFound1)
            isFound1 = WaitObject(Get_CroesusApp(), "ClrClassName", "UpperCashBalanceSummaryBoard", 200);
        if (!isFound2)
            isFound2 = WaitObject(Get_CroesusApp(), "ClrClassName", "UnsynchronizedAccountsBoard", 200);
        if (!isFound3)
            isFound3 = WaitObject(Get_CroesusApp(), "ClrClassName", "ScheduleBoard", 200);
        if (!isFound4)
            isFound4 = WaitObject(Get_CroesusApp(), "ClrClassName", "LowerCashBalanceSummaryBoard", 200);
            
        timeSpent = timer.Stop();
            
        if (isFound1 && isFound2 && isFound3 && isFound4){
            Log.Message("Croesus Application boards found after " + timeSpent + " ms.");
            break;
        }
        else {
            if (timeSpent >= maxTime)
                Log.Message("Some boards still missing after " + timeSpent + " ms.");
        }
    } while((!isFound1 || !isFound2 || !isFound3 || !isFound4) && timeSpent < maxTime);
    
}



//+++++++++++++++++++++++++++++++ CLOSE APPLICATION CROESUS  ++++++++++++++++++++++++++++++++++++++++

function Close_Croesus_X()
{
    Get_MainWindow().SetFocus();
    NameMapping.Sys.CroesusClient.HwndSource_MainWindow.Close();
}


function Close_Croesus_SysMenu()
{
    Get_MainWindow().SetFocus();
    if (typeof WINDOWS_DISPLAY_LANGUAGE != 'undefined' && WINDOWS_DISPLAY_LANGUAGE == "french")
        NameMapping.Sys.CroesusClient.HwndSource_MainWindow.SystemMenu.Click("Fermer");
    else
        NameMapping.Sys.CroesusClient.HwndSource_MainWindow.SystemMenu.Click("Close");
}


function Close_Croesus_AltF4()
{
    Get_MainWindow().SetFocus();
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Keys("~[F4]");
}


function Close_Croesus_AltQ()
{
    Get_MainWindow().SetFocus();
    NameMapping.Sys.CroesusClient.HwndSource_MainWindow.Keys("~q");
}


function Close_Croesus_MenuBar()
{
    Get_MainWindow().SetFocus();
    Get_MenuBar_File().OpenMenu();
    Delay(500);
    Get_MenuBar_File_Close().Click();
}

function CloseConfirmationMsg(answer){
    var msgFr = "Il y a des ordres ouverts ou partiellements executés...\r\n\r\nVoulez-vous quitter?"
    var msgEn = "There are opened or partially executed orders ...\r\n\r\nDo you want to quit?"
    
    Log.Message("Valider la présence d'une fenêtre de Confirmation.")
    if (WaitObject(Get_CroesusApp(), ["WndCaption","VisibleOnScreen"], ["Confirmation","true"])){
        if(Get_DlgConfirmation_LblMessage1().WPFControlText == msgFr || Get_DlgConfirmation_LblMessage1().WPFControlText == msgEn){
            if((answer == "Yes" || answer == "Y") && WaitObject(Get_DlgConfirmation(), ["ClrClassName", "WPFControlName"], ["Button", "PART_Yes"], 2000, false)){
                Log.Message("Cliquer sur " +Get_DlgConfirmation_BtnYes().WPFControlText)
                Get_DlgConfirmation_BtnYes().Click();
            }
            if((answer == "No" || answer == "N") && WaitObject(Get_DlgConfirmation(), ["ClrClassName", "WPFControlName"], ["Button", "PART_No"], 2000, false)){
               Log.Message("Cliquer sur " +Get_DlgConfirmation_BtnNo().WPFControlText);
               Get_DlgConfirmation_BtnCancel().Click(); //Bouton Non
            }
        }
        else
            Log.Warning("Une fenêtre de Confirmation inconnue à été détectée.")
    }
    else{
        Log.Message("Fenêtre de Confirmation non détectée.");
    }
}


//+++++++++++++++++++++++++++++++ Maths +++++++++++++++++++++++++++++++++++++++++++++++++

/*
 une fonction qui permet d'arrondir à N chiffre après la virgule (2 décimales par défaut), 
 en fournissant la précision en second paramètre (optionnel) 
*/
function roundDecimal(nombre, NBDecimal){
    var NBDecimal = NBDecimal || 2;
    var tmp = Math.pow(10, NBDecimal);
    return Math.round( nombre*tmp )/tmp;
}

//+++++++++++++++++++++++++++++++ SECURITY ++++++++++++++++++++++++++++++++++++++++

function Search_Security(Security)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(Security);
  Get_WinSecuritiesQuickSearch_RdoSecurity().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}



function Search_SecurityBySymbol(SecuritySymbol)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(SecuritySymbol);
  Get_WinSecuritiesQuickSearch_RdoSymbol().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}



function Search_SecurityByDescription(SecurityDescription)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(SecurityDescription);
  Get_WinSecuritiesQuickSearch_RdoDescription().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}



//+++++++++++++++++++++++++++++++ CLIENTS ++++++++++++++++++++++++++++++++++++++++

function Search_Client(client)
{
  ClickOnToolbarSearchButton();
  WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);
  Get_WinQuickSearch_TxtSearch().SetText(client);
  Get_WinClientsQuickSearch_RdoClientNo().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}



function SearchClientByName(clientName)
{
    ClickOnToolbarSearchButton();
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_WinQuickSearch().Exists){
        ClickOnToolbarSearchButton(); 
        numberOftries++;
    }
    WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);        
    Get_WinQuickSearch_TxtSearch().SetText(clientName);
    Get_WinClientsQuickSearch_RdoName().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}

function FilterClientByClientRelationshipNo(ClientRelationshipNo)
{
    ClickOnToolbarSearchButton();
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_WinQuickSearch().Exists){
        ClickOnToolbarSearchButton(); 
        numberOftries++;
    }
    WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);
            
    Get_WinQuickSearch_TxtSearch().SetText(ClientRelationshipNo);
    Get_WinClientsQuickSearch_RdoClientRelationshipNo().set_IsChecked(true);
    Get_WinQuickSearch_BtnFilter().Click();
}

//+++++++++++++++++++++++++++++++ ACCOUNTS ++++++++++++++++++++++++++++++++++++++++

function SearchAccount(accountNumber)
{
  ClickOnToolbarSearchButton();
  WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);
  Get_WinQuickSearch_TxtSearch().SetText(accountNumber);
  Get_WinAccountsQuickSearch_RdoAccountNo().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}

function Get_AccountNO(accountName){
    
     SearchClientByName(accountName);
     var accNo=Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountName, 10).DataContext.DataItem.AccountNumber.OleValue;
     return accNo;
}


//+++++++++++++++++++++++++++++++ RELATIONSHIPS ++++++++++++++++++++++++++++++++++++++++

function SearchRelationshipByName(relationshipName)
{
    ClickOnToolbarSearchButton();
    WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);
    //Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(relationshipName);
    Get_WinRelationshipsQuickSearch_RdoName().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}

function Get_RelationshipNo(relationship){

    SearchRelationshipByName(relationship);  
    var relNo=Get_RelationshipsClientsAccountsGrid().Find("Value",relationship,10).DataContext.DataItem.LinkNumber.OleValue;
    return relNo;
}



function SearchRelationshipByNo(relationShipNo)
{
    ClickOnToolbarSearchButton();
    WaitObject(Get_CroesusApp(),"Uid","QuickSearchWindow_b326",60000);
    //Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(relationShipNo);
    Get_WinRelationshipsQuickSearch_RdoRelationshipNo().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}

//++++++++++++++++++++++++++++++++++ RESTRICTION ++++++++++++++++++++++++++++++++++++++
function AddRestriction(security,percentageOfTotalValueMin,percentageOfTotalValueMax, Severity){
    //ajouter une restriction                    
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","DataGrid_9865");
    var count = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count
    WaitObject(Get_CroesusApp(),"Uid","TextBox_f1d5");
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");    
    SetAutoTimeOut();
    if(Get_SubMenus().Exists){
      WaitObject(Get_SubMenus(),["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"]);
      Get_SubMenus().Find("Value",security,10).DblClick();
    } 
    RestoreAutoTimeOut();
    Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum().Keys(percentageOfTotalValueMin);
    Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum().Keys(percentageOfTotalValueMax);
    if(Severity != undefined)
    {
      Get_WinCRURestriction_CmbSeverity().Click();
      Get_SubMenus().Find("WPFControlText",Severity,10).Click();
    }
    Get_WinCRURestriction_BtnOK().Click();   
    aqObject.CheckProperty(Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items, "Count",cmpEqual,count+1);
    Get_WinRestrictionsManager_BtnClose().Click();
}



/**
    Ajouter une restriction de 'Groupe ou classe' à partir du Gestionnaire de restrictions
*/
function AddGroupOrClassRestriction(groupOrClassCategory, groupOrClassName, percentageOfTotalValueMin, percentageOfTotalValueMax)
{
    Log.Message("Ajouter une restriction de 'Groupe ou classe' : " + groupOrClassCategory + " -> " + groupOrClassName + "; Minimum = " + percentageOfTotalValueMin + "% ; Maximum = " + percentageOfTotalValueMax + "%.");
    
    var formerNbOfRestrictions = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count;
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    Get_WinCRURestriction_GrpGroupClass_RdoGroupClass().Click();
    
    //Sélectionner Groupe/Classe
    Get_WinCRURestriction_GrpGroupClass_BtnClass().Click();
    var DgvGroupOrClassCategory = Get_WinCRURestriction_GrpGroupClass_DgvClassificationClass().FindChild(["ClrClassName", "DataContext.DataItem.Description"], ["DataRecordPresenter", groupOrClassCategory], 10);
    DgvGroupOrClassCategory.set_IsExpanded(true);
    var DgvGroupOrClassCategoryExpandableField = DgvGroupOrClassCategory.WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
    var lastGroupOrClassNameOfGroupOrClassCategory = VarToStr(DgvGroupOrClassCategoryExpandableField.Items.Item(DgvGroupOrClassCategoryExpandableField.Items.Count - 1).DataItem.Description);
    
    var scrollBarX = Get_WinCRURestriction_GrpGroupClass_DgvClassificationClass().Width - 10;
    var scrollBarY = Get_WinCRURestriction_GrpGroupClass_DgvClassificationClass().Height - 40;
    while (!DgvGroupOrClassCategoryExpandableField.FindChild(["ClrClassName", "VisibleOnScreen", "WPFControlText"], ["CellValuePresenter", true, lastGroupOrClassNameOfGroupOrClassCategory], 10).Exists){
        if (DgvGroupOrClassCategoryExpandableField.FindChild(["ClrClassName", "VisibleOnScreen", "WPFControlText"], ["CellValuePresenter", true, groupOrClassName], 10).Exists)
            break;
        
        Get_WinCRURestriction_GrpGroupClass_DgvClassificationClass().Click(scrollBarX, scrollBarY);
    }
    
    DgvGroupOrClassCategoryExpandableField.FindChild(["ClrClassName", "VisibleOnScreen", "WPFControlText"], ["CellValuePresenter", true, groupOrClassName], 10).Focus();
	
    //Saisir les pourcentages Minimun/Maximum
    Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMinimum().Keys(percentageOfTotalValueMin);
    Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMaximum().Keys(percentageOfTotalValueMax);
    
    //Valider
	CheckEquals(Get_WinCRURestriction_GrpGroupClass_BtnClass_LblClass().WPFControlText, groupOrClassCategory + " -> " + groupOrClassName, "The Group or Class selection");
    Get_WinCRURestriction_BtnOK().Click();   
    aqObject.CheckProperty(Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, formerNbOfRestrictions + 1);
    Get_WinRestrictionsManager_BtnClose().Click();
}



function DeleteRestriction(restriction){

  if(Get_WinRestrictionsManager_DgvRestriction().Find("Value",restriction,10).Exists)
  {
     var count = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count;
     Get_WinRestrictionsManager_DgvRestriction().Find("Value",restriction,10).Click();
     Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
     Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
     //var width = Get_DlgConfirmAction().Get_Width(); //CP : Changé pour CO
     //Get_DlgConfirmAction().Click((width*(1/3)),73); //CP : Changé pour CO   
     aqObject.CheckProperty(Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items, "Count",cmpEqual,count-1);
  } 
  Get_WinRestrictionsManager_BtnClose().Click();  
} 



//+++++++++++++++++++++++++++++++ PORTFOLIO ++++++++++++++++++++++++++++++++++++++++

function Search_Position(symbol)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(symbol);
  Get_WinPortfolioQuickSearch_RdoSymbol().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}



function SetPortfolioCurrencyAndDate(portfolioCurrency, portfolioAsOfDate, doNotCorrectFileNameLanguageSuffix)
{
    if (doNotCorrectFileNameLanguageSuffix == undefined)
        doNotCorrectFileNameLanguageSuffix = false;
    
    if (portfolioCurrency != undefined){
        //Choisir le bon portfolioCurrency lorsqu'on veut produire en une seule langue
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE && !doNotCorrectFileNameLanguageSuffix){
            if (CR1485_REPORTS_LANGUAGE == "english")
                portfolioCurrency = "USD";
            else if (CR1485_REPORTS_LANGUAGE == "french")
                portfolioCurrency = "CAD";
        }
    
        Get_PortfolioGrid_BarToolBarTray_CmbCurrency().set_IsDropDownOpen(true);
        Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", portfolioCurrency], 10).Click();
    }
    
    if (portfolioAsOfDate != undefined){
        Get_PortfolioGrid_BarToolBarTray_dtpDate().Click();
        SetDateInDateTimePicker(Get_PortfolioGrid_BarToolBarTray_dtpDate(), portfolioAsOfDate);
    }
}



function Search_PositionByDescription(positionDescription)
{
    ClickOnToolbarSearchButton();
    Get_WinQuickSearch_TxtSearch().SetText(positionDescription);
    Get_WinPortfolioQuickSearch_RdoDescription().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}



function Search_PositionByAccountNo(positionAccountNo)
{
    ClickOnToolbarSearchButton();
    Get_WinQuickSearch_TxtSearch().SetText(positionAccountNo);
    Get_WinPortfolioQuickSearch_RdoAccountNo().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}


//Recherche sur la grille Portefeuille Projeté
function PP_Search(symbol){

   Get_WinRebalance_PositionsGrid().Keys("F");
   Get_WinQuickSearch_TxtSearch().Clear();
   Get_WinQuickSearch_TxtSearch().Keys(symbol);
   Get_WinPortfolioQuickSearch_RdoSymbol().set_IsChecked(true);
   Get_WinQuickSearch_BtnOK().Click();
}

//Recherche sur la grille Portefeuille Projeté par description
function PP_SearchByDescription(description){

   Get_WinRebalance_PositionsGrid().Keys("F");
   Get_WinQuickSearch_TxtSearch().Clear();
   Get_WinQuickSearch_TxtSearch().Keys(description);
   Get_WinPortfolioQuickSearch_RdoDescription().set_IsChecked(true);
   Get_WinQuickSearch_BtnOK().Click();
}



//Recherche sur la grille des Ordres Proposés
function PO_Search(symbol){

   Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Keys("F");
   Get_WinQuickSearch_TxtSearch().Clear();
   Get_WinQuickSearch_TxtSearch().Keys(symbol);
   Get_WinPortfolioQuickSearch_RdoSymbol().set_IsChecked(true);
   Get_WinQuickSearch_BtnOK().Click();
}
function PO_SearchBySecurity(security){

   Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Keys("F");
   Get_WinQuickSearch_TxtSearch().Clear();
   Get_WinQuickSearch_TxtSearch().Keys(security);
   Get_WinPortfolioQuickSearch_RdoSecurity().set_IsChecked(true);
   Get_WinQuickSearch_BtnOK().Click();
}

function LockUnLockPosition(position, account, status){
  //bloquer position 
  Search_Position(position);
  var rowContent=FindRowByMultipleValues(Get_Portfolio_PositionsGrid(), [account, position]);
    if(rowContent != -1)
        Get_Portfolio_PositionsGrid().WPFObject("DataRecordPresenter", "", rowContent.index).Click();
    else 
        Log.Error("Aucun portefeuille pour compte = "+account+" et symbole = "+position);
  Get_PortfolioBar_BtnInfo().Click();
  Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(status);
  Get_WinPositionInfo_BtnOK().Click();
        
  //Valider que la position est bloquée   
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(rowContent.row.DataContext.Index).DataItem, "IsBlocked", cmpEqual,status);
        
}

//Supprimer un segment dans le WinSleevesManager
function DeleteSleeveWinSleevesManager(sleeveDescription)
{          
    SelectSleeveWinSleevesManager(sleeveDescription) 
    Get_WinManagerSleeves().Click();
    
    //Cliquer sur le bouton Supprimer
    Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
    
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
}

//Supprimer tous les segments crées
function Delete_AllSleeves_WinSleevesManager()
{   
    //Cliquer sur le bouton segment
    Get_PortfolioBar_BtnSleeves().Click();
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
      Get_PortfolioBar_BtnSleeves().Click();
      numberOftries++;
    } 
    Get_WinManagerSleeves().Parent.Maximize();  
    
    count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;    
    if(count>1){
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Keys("^a");
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsSelected(false);        
        Get_WinManagerSleeves().Click();    
        //Cliquer sur le bouton Supprimer
        Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        
        if(!Get_DlgConfirmation().VisibleOnScreen){
          Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        } 
     
        var messageText = Get_DlgConfirmation_LblMessage().Message;
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
    
    aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
    
    //Sauvgarder
    Get_WinManagerSleeves_BtnSave().Click();
    return messageText;
}

//Ajouter/Modifier des segments 
function AddEditSleeveWinSleevesManager(sleeveDescription,assetClass,target,min,max,model)
{
   if (Trim(VarToStr(sleeveDescription))!== ""){     
      Get_WinEditSleeve_TxtSleeveDescription().set_Text(sleeveDescription); 
   }
   
     //Ajouter un segment  
    if (Trim(VarToStr(assetClass))!== ""){ 
        Get_WinEditSleeve_CmbAssetClass().set_IsDropDownOpen(true);
        var count=Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Count
        for(var i=1;i<count;i++){
        Log.Message(VarToString(Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Item(i).LongDescription))
          if(VarToString(Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Item(i).LongDescription)==VarToString(assetClass)){
             Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "",i+1).Click();
             break;
           }
        }
           
        //Aliases.CroesusApp.subMenus.Find("Value",assetClass,10).Click();
//      Get_WinEditSleeve_CmbAssetClass().Keys(assetClass);
//      Get_WinEditSleeve_CmbAssetClass().Keys(assetClass);
//      Get_WinEditSleeve_CmbAssetClass().Keys("[Enter]");
   }
    
   if (Trim(VarToStr(target))!== ""){       
      Get_WinEditSleeve_TxtTargerPercent().Keys(target);
   }
   if(Trim(VarToStr(min))!== ""){
      Get_WinEditSleeve_TxtMinPercent().set_Text(min);
   }
   if(Trim(VarToStr(max))!== ""){
      Get_WinEditSleeve_TxtMaxPercent().set_Text(max);
   }
     
    //Mettre le modéle 
   if(Trim(VarToStr(model))!== ""){
        Get_WinEditSleeve_TxtValueTextBox().Keys(model);
        Get_WinEditSleeve_BtnQuickSearchListPicker().Click();
   
       SetAutoTimeOut();
       if(Get_SubMenus().Exists)
            Get_SubMenus().Find("Value",model,10).DblClick();
       RestoreAutoTimeOut();
   }        
   Log.Message("L'anomalie ouverte par Karima- CROES-8314")
   Get_WinEditSleeve_BtOK().Click();
   SetAutoTimeOut();
   if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);      
   } 
   RestoreAutoTimeOut();

}



//Sélection un segment par description 
function SelectSleeveWinSleevesManager(description)
{
    //Sélectionner le segment
    var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    for (var i = 1; i < count; i++){          
          if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(description)){

              Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
              Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true)
              Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).Click();
              break;
          }        
    }
}
 
function ChangeNonRedeemable(position,isChecked)
{
  Search_Position(position)
  Drag(Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(position),10), Get_ModulesBar_BtnSecurities());
  Get_SecuritiesBar_BtnInfo().Click();
  Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().Set_IsChecked(isChecked);
  Get_WinInfoSecurity_BtnOK().Click(); 
  Get_ModulesBar_BtnPortfolio().Click();
  
}

function EditNonRedeemableSecurityStatus(position, status){
  Search_Position(position);
  Get_SecurityGrid().Find("Value",position,10).Click();  
  Get_SecuritiesBar_BtnInfo().Click();
  WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
  Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(status);
  Get_WinInfoSecurity_BtnOK().Click();
  aqObject.CheckProperty(Get_SecurityGrid().Find("Value",position,10).DataContext.DataItem,"IsBlocked", cmpEqual,status);
}



//Fenêtre Titre de substitution - Ajout complément, remplacement ou rechange
function AddSubstitutionSecuritiesByType(typePicker,securityDescription,securitySymbol,substituteType)
{
    Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);
    if (Trim(VarToStr(securitySymbol)) !== ""){
        Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
        Get_SubMenus().Find("Text",typePicker,10).Click();
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securitySymbol);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
            if (Trim(VarToStr(securityDescription))!== "")
                Get_SubMenus().Find("Value",securityDescription,10).DblClick();
            else
                Get_SubMenus().Find("Value",securitySymbol,10).DblClick();
        }
        RestoreAutoTimeOut();
    }
    else {
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityDescription);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
    }
     
    // Type = Complement, Replacement ou Fullback security
     if (substituteType==ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client))
         aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(), "IsChecked", cmpEqual,true);
     else if (substituteType==ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client)){
         Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().Set_IsChecked(true);
         aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(), "IsChecked", cmpEqual,true);
     }         
     else if (substituteType==ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client)){
         Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().Set_IsChecked(true);
         aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "IsChecked", cmpEqual,true);  
     }
     else
        Log.Message("Type error"); 
     
     Get_WinReplacement_BtnOK().Click();
     aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteType)
     Get_WinSubstitutionSecurities_BtnOK().Click();   
}


  
function AddComplement(typePicker,position,securityDescription,securitySymbol,complement)
{ 
     Get_Portfolio_PositionsGrid().Find("Value",position,10).Click();
     Get_PortfolioBar_BtnInfo().Click();
     Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
     Get_WinSubstitutionSecurities_BtnAdd().Click();
     
     Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);
     Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
     Get_SubMenus().Find("Text",typePicker,10).Click();     
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securitySymbol);
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
     SetAutoTimeOut();
     if (Get_SubMenus().Exists){
        if (Trim(VarToStr(securityDescription))!== "")
            Get_SubMenus().Find("Value",securityDescription,10).DblClick();
        else
            Get_SubMenus().Find("Value",securitySymbol,10).DblClick();
     }
     RestoreAutoTimeOut();
     aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(), "IsChecked", cmpEqual,true);       
     Get_WinReplacement_BtnOK().Click();
     aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, complement)
     Get_WinSubstitutionSecurities_BtnOK().Click();     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, complement)
     Get_WinPositionInfo_BtnOK().Click(); 
}


 
//Ajouter Titre de remplacement 
function AddReplacementSecurity(typePicker,position,securityDescription,securitySymbol,Replacement)
{
     Get_Portfolio_PositionsGrid().Find("Value",position,10).Click();
     Get_PortfolioBar_BtnInfo().Click();
     Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
     Get_WinSubstitutionSecurities_BtnAdd().Click();
     Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityDescription);
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
     Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().set_IsChecked(true);       
     Get_WinReplacement_BtnOK().Click();
     aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, Replacement)
     Get_WinSubstitutionSecurities_BtnOK().Click();     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, Replacement)
     Get_WinPositionInfo_BtnOK().Click(); 
 }
 
 //Ajouter Titre de rechange de remplacement  
function AddFallbackReplacementSecurity(replacementPosition,altsecurity,typePicker,securityAltDescription)
{
    //Sélectionner Titre de remplacement 
    Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",replacementPosition,10).Click();
    Get_WinSubstitutionSecurities_BtnEdit().Click();
    //Rechercher Titre de rechange de remplacement
    Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);
    Get_WinReplacement_GrpSubstitutionType_CmbSecurityPicker().Click();
    Get_SubMenus().Find("Text",typePicker,10).Click();
    Get_WinReplacement_GrpSubstitutionType_TxtSubstitutionType().Keys(altsecurity);
    Get_WinReplacement_GrpSubstitutionType_BtnSearch().Click();
    SetAutoTimeOut();
    if (Get_SubMenus().Exists){
        if (Trim(VarToStr(securityAltDescription))!== "")
            Get_SubMenus().Find("Value",securityAltDescription,10).DblClick();
        else
            Get_SubMenus().Find("Value",altsecurity,10).DblClick();
    }
    RestoreAutoTimeOut();
    Delay(1500);
    Get_WinReplacement_BtnOK().Click();
    Get_WinSubstitutionSecurities_BtnOK().Click();
    //Valider que le Titre de rechange de remplacement a été ajouté
    if (Trim(VarToStr(securityAltDescription)) !== "")
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",replacementPosition,10).DataContext.DataItem.SecurityAltDescription,"OleValue",cmpEqual, securityAltDescription)
    else  
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",replacementPosition,10).DataContext.DataItem.SecurityAltSymbol,"OleValue",cmpEqual, altsecurity)
        
    Get_WinPositionInfo_BtnOK().Click();
}



function Get_ModelNo(modelName)
{
    SearchModelByName(modelName);  
    var modelNo=Get_ModelsGrid().Find("Value",modelName,10).DataContext.DataItem.AccountNumber.OleValue;
    return modelNo;
}
 

//+++++++++++++++++++++++++++++++ TRANSACTIONS ++++++++++++++++++++++++++++++++++++++++

function Search_Transactions_Account(account)
{
  ClickOnToolbarSearchButton();
  //Dans le cas, si le click ne fonctionne pas  
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_WinTransactionsQuickSearch().Exists){
      ClickOnToolbarSearchButton(); 
      numberOftries++;
  }
  WaitObject(Get_CroesusApp(), "Uid", "QuickSearchWindow_7bf0");
  Get_WinTransactionsQuickSearch_TxtSearch().SetText(account);
  Get_WinTransactionsQuickSearch_RdoAccountNo().set_IsChecked(true);
  Get_WinTransactionsQuickSearch_BtnOK().Click();
  Delay(3000);
}
 
function Search_Transactions_Type(type)
{
  ClickOnToolbarSearchButton();
  Get_WinTransactionsQuickSearch_TxtSearch().SetText(type);
  Get_WinTransactionsQuickSearch_RdoType().set_IsChecked(true);
  Get_WinTransactionsQuickSearch_BtnOK().Click();
  Delay(3000);
}


function Delete_Transactions(Account)
{
  // Search_Transactions_Account(Account);
  Get_MainWindow().Click();
  Get_MainWindow().Keys("^a");
  Get_Toolbar_BtnDelete().Click();
  Get_WinDeleteTransaction_GrpAction_rdoDelete().Click(); 
  Get_WinDeleteTransaction_GrpAction_BtnOK().Click();
  
}

function Cancel_Transactions(Account)
{
  // Search_Transactions_Account(Account);
  Get_MainWindow().Click();
  Get_MainWindow().Keys("^a");
  Get_Toolbar_BtnDelete().Click();
  Get_WinDeleteTransaction_GrpAction_rdoAnnulled(); 
  Get_WinDeleteTransaction_GrpAction_BtnOK().Click();
  
}

function Create_Transaction(TansType, TansAccount, TranSec, Quantity, Prix, Currency)
{

    if (TansType != undefined && Trim(VarToStr(TansType)) !== ""){
    Get_WinAddTransaction_GrpType_cmbType().Click(); 
    
    SetAutoTimeOut();
    if (Get_SubMenus().Exists){
        Get_SubMenus().Find("WPFControlText",TansType,10).Click();
    }
    else {
        Log.Message("The "+ TansType +" does not exist.");
    }
    RestoreAutoTimeOut();
    
    if (Trim(VarToStr(TansAccount)) !== ""){
      Get_WinAddTransaction_GrpAccounts_TxtFromAccount().Click();
      Get_WinAddTransaction_GrpAccounts_TxtFromAccount().set_Text(TansAccount);
    }
    
    if (Trim(VarToStr(TranSec)) !== ""){
      Get_WinAddTransaction_GrpSecurity_TxtSecurity().Click();
      Get_WinAddTransaction_GrpSecurity_TxtSecurity().set_Text(TranSec);
    }

    if (Trim(VarToStr(Quantity)) !== ""){
      Get_WinAddTransaction_GrpAmounts_TxtQuantity().Click();
      Get_WinAddTransaction_GrpAmounts_TxtQuantity().set_Text(Quantity);
    }  
    
    if (Trim(VarToStr(Prix)) !== ""){
      Get_WinAddTransaction_GrpAmounts_TxtPrix().Click();
      Get_WinAddTransaction_GrpAmounts_TxtPrix().set_Text(Prix);
    }

    if (Currency != undefined && Trim(VarToStr(Currency)) !== ""){
        Get_WinAddTransaction_GrpAmounts_cmbCurrency().Click(); 
    
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
            Get_SubMenus().Find("WPFControlText",Currency,10).Click();
        }
        else {
            Log.Message("The "+ Currency +" does not exist.");
        }
        RestoreAutoTimeOut();
    }

    Get_WinAddTransaction_BtnOK().Click();
}
}

function Modifier_Transaction(Quantity, Prix, Currency, Commission)
{
    if (Trim(VarToStr(Quantity)) !== ""){
      Get_WinEditTransaction_GrpAmounts_TxtQuantity().Click();
      Get_WinEditTransaction_GrpAmounts_TxtQuantity().set_Text(Quantity);
    }  
    
    if (Trim(VarToStr(Prix)) !== ""){
      Get_WinEditTransaction_GrpAmounts_TxtPrix().Click();
      Get_WinEditTransaction_GrpAmounts_TxtPrix().set_Text(Prix);
    }

    if (Currency != undefined && Trim(VarToStr(Currency)) !== ""){
        Get_WinEditTransaction_GrpAmounts_cmbCurrency().Click(); 
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
            Get_SubMenus().Find("WPFControlText",Currency,10).Click();
        }
        else {
            Log.Message("The "+ Currency +" does not exist.");
        }
        RestoreAutoTimeOut();
    }
    
    if (Trim(VarToStr(Commission)) !== ""){
    Get_WinEditTransaction_GrpAmounts_TxtCommission().Click();
    Get_WinEditTransaction_GrpAmounts_TxtCommission().set_Text(Commission);
    }
    
    Get_WinEditTransaction_BtnOK().Click();
}

function Validate_Transaction(TansAccount, TansType, TranSec, Quantity, Prix, Currency, Total, Commission)
{
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, TansAccount);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 5), "Text", cmpEqual, TansType);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, TranSec);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 7), "Text", cmpEqual, Quantity);
  //aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 8), "Text", cmpEqual, Prix+",000");
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 8), "Text", cmpEqual, Prix);     //Modifié par Amine A.
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 9), "Text", cmpEqual, Currency);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 10), "Text", cmpEqual, Total);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 11), "Text", cmpEqual, Commission);
}

function Check_Info_Redisplay_Transactions(Quantity, Prix, Prix2, Taux, Interet, Commission, Frais, FraisComm, MontantNet, Note)
{
        Get_TransactionsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbQuantity(), "Text", cmpEqual, Quantity);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCost(), "Text", cmpEqual, Prix);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtGrossAmount(), "Text", cmpEqual, Prix2);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbRate(), "Text", cmpEqual, Taux);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbAccruedInterest(), "Text", cmpEqual, Interet);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommission(), "Text", cmpEqual, Commission);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFees(), "Text", cmpEqual, Frais);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(), "Text", cmpEqual, FraisComm);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "Text", cmpEqual, MontantNet);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TxtNote(), "Text", cmpEqual, Note);
        Get_WinEditTransaction_BtnOK().Click();
}

function Create_RapideFilter(Compte, Champ, Operator, Value)
{
        Get_Toolbar_BtnQuickFilters().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
       // WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]);
    
        //Creation filtre rapide

        Get_WinAddFilter_TxtName().Click();
        Get_WinAddFilter_TxtName().set_Text(Compte);
        
        if (Champ != undefined && Trim(VarToStr(Champ)) !== ""){
        Get_WinAddFilter_GrpCondition_CmbField().Click(); 
        
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
            Get_SubMenus().Find("WPFControlText",Champ,10).Click();
        }
        else {
            Log.Message("The "+ Champ +" does not exist.");
        }
        RestoreAutoTimeOut();
    
        if (Operator != undefined && Trim(VarToStr(Operator)) !== ""){
            Get_WinAddFilter_GrpCondition_CmbOperator().Click(); 
            SetAutoTimeOut();
            if (Get_SubMenus().Exists){
                Get_SubMenus().Find("WPFControlText",Operator,10).Click();
            }
            else {
                Log.Message("The "+ Operator +" does not exist.");
            }
            RestoreAutoTimeOut();
        }
    
    
        if (Value != undefined && Trim(VarToStr(Value)) !== "" && Champ != "Date de transaction" && Champ != "Transaction Date"){
            Get_WinAddFilter_GrpCondition_CmbValue().Click(); 
            SetAutoTimeOut();
            if (Get_SubMenus().Exists){
               Get_SubMenus().Find("WPFControlText",Value,10).Click();
            }
            else {
                Log.Message("The "+ Value +" does not exist.");
            }
            RestoreAutoTimeOut();
        }
        
        if (Value != undefined && Trim(VarToStr(Value)) !== "" && (Champ == "Date de transaction" || Champ == "Transaction Date")){
        Get_WinAddFilter_GrpCondition_DateValue().Click(); 
        Get_WinAddFilter_GrpCondition_DateValue().set_StringValue(Value);
        }
        }
        Get_WinAddFilter_BtnOK().Click();
              
}


//+++++++++++++++++++++++++++++++ MODELS ++++++++++++++++++++++++++++++++++++++++

function Search_Model(modelNo)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(modelNo);
  Get_WinModelsQuickSearch_RdoModelNo().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}

function SearchModelByName(modelName)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(modelName);
  Get_WinModelsQuickSearch_RdoName().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}

function DeleteModelByName(modelName)
{        
  Get_ModulesBar_BtnModels().Click();
  Get_MainWindow().Maximize();
                        
  SearchModelByName(modelName);
  if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
      //Sélectionner le modèle 
      Get_ModelsGrid().Find("Value",modelName,10).Click();        
      Get_Toolbar_BtnDelete().Click();
       /* if(Get_DlgCroesus().Exists){
       var width = Get_DlgCroesus().Get_Width();
       Get_DlgCroesus().Click((width*(1/3)),73)
       }*/ //EM : Modifié depuis CO: 90-07-22-Be-1
       if(Get_DlgConfirmation().Exists){
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);}
       
       WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
           
       SearchModelByName(modelName);
       if(Get_ModelsGrid().Find("Value",modelName,10).Exists)
          Log.Error("Le modèle n’a pas été supprimé")
       else
         Log.Checkpoint("Le modèle a été supprimé")
  
  }
  else
    Log.Error("Le modèle "+modelName+" n'existe pas.")
  
}



function Create_Model(modelName, modelType, IACode, currencyValue)
{
    ClickOnToolbarAddButton();
   
    if (Trim(VarToStr(modelName)) !== "")
      Get_WinModelInfo_GrpModel_TxtFullName().Keys(modelName);
      
    Get_WinModelInfo_GrpModel_TxtShortName().Click();
   
    if (currencyValue != undefined && Trim(VarToStr(currencyValue)) !== "")
      SelectComboBoxItem(Get_WinModelInfo_GrpModel_CmbCurrency(), currencyValue);
   
    if (Trim(VarToStr(modelType)) !== "")
      SelectComboBoxItem(Get_WinModelInfo_GrpModel_CmbType(), modelType);
   
    if (IACode != undefined && Trim(VarToStr(IACode)) !== ""){
        Get_WinModelInfo_GrpModel_CmbIACode().Click(); 
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
          Get_SubMenus().Find("Content",IACode,10).Click();
        }
        else {
          Get_WinModelInfo_GrpModel_CmbIACode().set_IACode(IACode);
        }
        RestoreAutoTimeOut();
      }
    Get_WinModelInfo_BtnOK().Click();
}


function AddPositionToModel(security,percentage,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  SetAutoTimeOut();
  if (Get_SubMenus().Exists){
      if (Trim(VarToStr(securityDescription))!== "")
         Get_SubMenus().Find("Value",securityDescription,10).DblClick();
      else
         Get_SubMenus().Find("Value",security,10).DblClick();
  }
  RestoreAutoTimeOut();
  Delay(1500);
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
}



function AddCashPositionToModel(security,typePicker,securityDescription){
    
    Get_WinPositionInfo_ExcessCash_CmbTypePicker().Click();
    Get_SubMenus().Find("Text",typePicker,10).Click();
    Get_WinPositionInfo_ExcessCash_TxtQuickSearchKey().Keys(security);
    Get_WinPositionInfo_ExcessCash_DlListPicker().Click();
    SetAutoTimeOut();
    if (Get_SubMenus().Exists){
      if (Trim(VarToStr(securityDescription))!== "")
         Get_SubMenus().Find("Value",securityDescription,10).DblClick();
      else
         Get_SubMenus().Find("Value",security,10).DblClick();
    }
    RestoreAutoTimeOut();
    Get_WinPositionInfo_BtnOK().Click();
}

function AddPosition(security,percentage,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
} 

function AddSubModelToModel(subModel, valuePercent, marketValue ){

  Get_WinAddPositionSubmodel_TxtSubmodel().Click();
  Get_WinAddPositionSubmodel_TxtSubmodel().Keys(subModel);
  Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]");
  SetAutoTimeOut();
  if (Get_SubMenus().Exists){
    Get_SubMenus().Find("Value",subModel,10).DblClick();
  }
  RestoreAutoTimeOut();
  if(valuePercent != undefined && Trim(VarToStr(valuePercent))!== ""){
    Get_WinAddPositionSubmodel_TxtValuePercent().Keys(valuePercent);
  }
  if(marketValue != undefined &&Trim(VarToStr(marketValue))!== ""){
    Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValue);
  }
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
} 

function SetModelTolerances(model, positionSolde, tolMin, tolMax)
{
  Log.Message("*** Sélectionner le modele "+model+" et mailler dans Portefeuille");
  SearchModelByName(model);
  FindResult = Get_ModelsGrid().Find("Value",model,10);
  if(!FindResult.Exists){
    Log.Error("Le modèle "+model+" n'existe pas.");
    return;
  }
  Drag(Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
  
  var ModelMinPercent = Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem.ModelMinPercent.OleValue;
  var ModelMaxPercent = Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem.ModelMaxPercent.OleValue;
  
  Log.Message("Séléctionner la position solde et cliquer sur Info");
  Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).Click();
  Get_PortfolioBar_BtnInfo().Click();
  if(Get_DlgConfirmation().Exists){
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(2/3)),73); 
  }
  
  Log.Message("Sous la colonne écart : Modifier Tolérance min. (%) = "+tolMin+" - Tolérance max. (%) = "+tolMax);
  Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMin().Set_Text(tolMin);
  Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMax().Set_Text(tolMax);
  Get_WinPositionInfo().Click();
  Get_WinPositionInfo_BtnOK().WaitProperty("IsEnabled", true, 3000); 
  Get_WinPositionInfo_BtnOK().Click();
  
  Get_PortfolioBar_BtnSave().Click();
  Get_WinWhatIfSave_BtnOK().Click();
  
}

function ActivateDeactivateModel(model,boolean){
    SearchModelByName(model);
    Get_ModelsGrid().Find("Value",model,10).Click()
    Delay(2000);
    Get_ModelsBar_BtnInfo().Click();
    Get_WinModelInfo_GrpModel_ChkActive().set_IsChecked(boolean);
    Get_WinModelInfo_BtnOK().Click(); 
    aqObject.CheckProperty(Get_ModelsGrid().Find("Value",model,10).DataContext.DataItem, "IsActive", cmpEqual, boolean);                              
} 


function AssociateAccountWithModel(model,account){
    SearchModelByName(model);
    FindResult = Get_ModelsGrid().Find("Value",model,10);
    if(FindResult.Exists){  
      
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
    
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(account);
        Get_WinQuickSearch_RdoAccountNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click()  
    
        Get_WinPickerWindow_DgvElements().Find("Value",account,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10), "Exists", cmpEqual, true);
    }
    else Log.Error("Le modèle "+model+" n'existe pas.");    
} 

function AssociateClientWithModel(model,client){
    SearchModelByName(model);
    FindResult = Get_ModelsGrid().Find("Value",model,10);
    if(FindResult.Exists){             
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
    
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(client);
        Get_WinQuickSearch_RdoClientNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click()  
    
        Get_WinPickerWindow_DgvElements().Find("Value",client,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
    }
    else Log.Error("Le modèle "+model+" n'existe pas.");
} 

function AssociateRelationshipWithModel(model,relationship){
    SearchModelByName(model);
    FindResult = Get_ModelsGrid().Find("Value",model,10);
    if(FindResult.Exists){
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
    
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(relationship);
        Get_WinQuickSearch_RdoRelationshiptNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click()  
    
        Get_WinPickerWindow_DgvElements().Find("Value",relationship,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();  
    }
    else Log.Error("Le modèle "+model+" n'existe pas.");
    
}


function RemoveAccountFromModel(accountNo, modelNo)
{
    Get_ModulesBar_BtnModels().Click();
    //Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    SearchModelByName(modelNo);
    if(Get_ModelsGrid().FindChild("Value", modelNo, 10).Exists){
            
          Get_ModelsGrid().FindChild("Value", modelNo, 10).Click();
          FindResult = Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10);
          if (FindResult.Exists == true){
              Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10).Click();
              Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              //Get_DlgCroesus().Click(150, 70); //EM : Modifié depuis CO: 90-07-22-Be-1
                if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);
                }
          }
          else  Log.Error("Account No " + accountNo + " not assigned to model No " + modelNo);      
    }
    else Log.Error("Le modèle no "+modelNo+" n'existe pas.");
}

//Fonction pour enlever un client d'un modèle
function RemoveClientFromModel(clientNo, modelName)
{
    Get_ModulesBar_BtnModels().Click();
    SearchModelByName(modelName);
    if(Get_ModelsGrid().FindChild("Value", modelName, 10).Exists){
            
          Get_ModelsGrid().FindChild("Value", modelName, 10).Click();
          FindResult = Get_Models_Details_DgvDetails().FindChild("Value", clientNo, 10);
          if (FindResult.Exists == true){
              Get_Models_Details_DgvDetails().FindChild("Value", clientNo, 10).Click();
              Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              //Get_DlgCroesus().Click(150, 70); //EM : Modifié depuis CO: 90-07-22-Be-1
                if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);
                }
          }
          else  Log.Error("Client No " + clientNo + " not assigned to model No " + modelName);      
    }
    else Log.Error("Le modèle no "+modelName+" n'existe pas.");
}


//Valider que la position présente dans le modèle 
function CheckPresenceofPosition(security){

     var positionExistence=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",security,100).Exists       
     if(positionExistence==true){
        Log.Checkpoint("La position a été ajoutée")
     }
     else{
        Log.Error("La position n'a pas été ajoutée")
     } 
} 

//Valider que la position est non rachetable
function CheckNonRedeemableSecurity(position){
  Search_Position(position)
  Drag(Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(position),10), Get_ModulesBar_BtnSecurities());
  Get_SecuritiesBar_BtnInfo().Click();
  aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsChecked", cmpEqual, true);
  Get_WinInfoSecurity_BtnOK().Click(); 
  Get_ModulesBar_BtnPortfolio().Click();
}

//+++++++++++++++++++++++++++++++ ORDERS ++++++++++++++++++++++++++++++++++++++++

function Search_Order_Symbol(symbol)
{
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(symbol);
  Get_WinOrdersQuickSearch_RdoSymbol().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);
}

function CreateEditStocksOrder(account,quantity,securityDescription,securitySymbol)
{                
    var security = "";
    
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre.
    //***Emna IHM: Remplacé par la recherche par symbol/security car La recherche par description ne fonctionne pas correctement, 
    //***C'est peut être lié au bug de la recherche par description détecté dernièrement (Pour plus de détails Voir le fichier d'analyse ref90-28-2021-12-49)
    if(securitySymbol == null || securitySymbol == "") {   
      Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
      Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
      security = securityDescription;
    }
    else
      security = securitySymbol;

    //Creation d'ordre 
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if (Trim(VarToStr(quantity))!== ""){  
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    }
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(security))!== ""){  
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
      SetAutoTimeOut();
      if(Get_SubMenus().Exists){  
        Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
      }
      RestoreAutoTimeOut();
    }    
    Get_WinOrderDetail_BtnSave().WaitProperty("IsEnabled",true,30000);
    Get_WinOrderDetail_BtnSave().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_66bd", true]);
 }

function EditOrderStatusToExecuted(dateFormat, status, security, quantityFill, price, market, rateOrigin, exchangeRate, interneNo, role){
    
    Search_Order_Symbol(security);
    var orderDate= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,dateFormat)   
    if(orderDate == aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat)){
        Get_OrdersBar_BtnFills().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["AllocationWindow_48f4", true]);
        
        Get_WinOrderFills_GrpFills_BtnAdd().Click();    
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["FillWindow_f40d", true]);             
        
        Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFill);
        Get_WinAddOrderFill_TxtClientPrice().Keys(price);
        Get_WinAddOrderFill_CmbMarket().set_Text(market);     
        if (role != undefined && Trim(VarToStr(role))!== "")    
            Get_WinAddOrderFill_CmbOurRole().set_Text(role);
        
        Get_WinAddOrderFill_BtnOK().Click();            
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["AllocationWindow_48f4", true]);
        
        Get_WinOrderFills_GrpFills_CmbRateOriginForBond().Keys(rateOrigin);
        Get_WinOrderFills_GrpFills_TxtExchangeRateForBond().Keys(exchangeRate);        
        Get_WinOrderFills_GrpFills_LblInternalNumberForBond().Keys(interneNo);
        
        Get_WinOrderFills_BtnSave().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
        
        Log.Message("Vérifier le changement du statut")
        Get_OrderGrid().Find("Value",security,10).Click();
        aqObject.CompareProperty(orderDate,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,status);
    }
    else
        Log.Error("L’ordre symbole = "+security+" date = "+orderDate+" n’existe pas");

}

function CreateBuyOrder(securitySymbol, quantity, account){
   
   Get_ModulesBar_BtnSecurities().Click();
   Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
   WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
   
   Search_SecurityBySymbol(securitySymbol); 
   if(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbol,10).Exists){ 
          
      Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbol,10).Click();   
      
      Get_Toolbar_BtnCreateABuyOrder().Click();
      WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
      
      if (Trim(VarToStr(account))!== "")    
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
          
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
      if (Trim(VarToStr(quantity))!== "") 
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
        
      Get_WinOrderDetail_BtnSave().Click();
      WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
   }
   else 
      Log.Error("The security symbol "+securitySymbol+" does not exists.");
    

}

function CheckPresenceOrderInAccumulator(account,quantity,security,financialInstrument,orderType)
{
  var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
  var found=false;
  for(var i=0;i<count;i++){
    if(VarToString(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber)==VarToString(account))
    {
        found=true;    
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "OrderSymbol", cmpEqual,security);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "FinancialInstrument", cmpEqual,financialInstrument);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,orderType);
   }
  }
  return found;
}       

function VerifySubmitOrder(account){ 
    
    Get_OrderAccumulatorGrid().Find("Value",account,10).DblClick();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
    Get_WinOrderDetail_BtnVerify().Click();
    //Soumettre
    Get_WinOrderDetail_BtnVerify().WaitProperty("IsEnabled", true, 5000);
    Get_WinOrderDetail_BtnVerify().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
}

function ApproveCheckOrderStatus(security, status, dateFormat){
    //Choisir l'order créé aujourd’hui    
    Search_Order_Symbol(security);
    var orderDate= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,dateFormat)   
    if(orderDate == aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat)){
        
        Get_OrderGrid().Find("Value",security,10).Click()    
        
        Get_OrdersBar_BtnView().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
        Get_WinOrderDetail_BtnApprove().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
        
        Log.Message("Vérifier le changement du statut")
        Get_OrderGrid().Find("Value",security,10).Click()
        aqObject.CompareProperty(orderDate,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,status);
    
    }
    else
        Log.Error("L’ordre n’a pas été créé");
    

} 
 
 
 
//+++++++++++++++++++++++++++++++ TABLEAU DE BORD (DASHBOARD) ++++++++++++++++++++++++++++++++++++++++

/* Vider le tableau de bord */
function Clear_Dashboard()
{
  Close_Board(Get_Dashboard_PositiveCashBalanceSummaryBoard())
  Close_Board(Get_Dashboard_NegativeCashBalanceSummaryBoard())
  Close_Board(Get_Dashboard_InvestmentObjectiveVariationBoard())
  Close_Board(Get_Dashboard_TriggeredRestrictionsBoard())
  Close_Board(Get_Dashboard_CalendarBoard())
  Close_Board(Get_Dashboard_CampaignManagementBoard())
  Close_Board(Get_Dashboard_ExpiredOrdersBoard())
  Close_Board(Get_Dashboard_InvestmentObjectiveVariationModelsBoard())
}


/* Sur le tableau de bord, fermer un tableau s'il est ouvert */
function Close_Board(Board)
{
  if (Board.Exists) { Board.Click(Board.get_ActualWidth()-17, 13) }
}


/* Au tableau de bord, ajouter le tableau "Sommaire de l'encaisse positive" */
function Add_PositiveCashBalanceSummaryBoard()
{
  if (!Get_Dashboard_PositiveCashBalanceSummaryBoard().Exists)
  {
    ClickOnToolbarAddButton();
    Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Delay(1000);
  Get_Dashboard_PositiveCashBalanceSummaryBoard().Click(70, 60);
}


/* Au tableau de bord, ajouter le tableau "Sommaire de l'encaisse négative" */
function Add_NegativeCashBalanceSummaryBoard()
{
  if (!Get_Dashboard_NegativeCashBalanceSummaryBoard().Exists)
  {
    ClickOnToolbarAddButton();
    Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Delay(1000);
  Get_Dashboard_NegativeCashBalanceSummaryBoard().Click(70, 60);
}

/*
 Description: Ajout de fonctions au tableau de bord pour ajouter (afficher dans le tableau de bord) le calendrier, objectifs de placement et Triggered Restrictions
 Auteur: Abdel Matmat
*/
function Add_CalendarBoard()
{
  if (! Get_Dashboard_CalendarBoard().Exists)
  {
    ClickOnToolbarAddButton();
    Get_DlgAddBoard_TvwSelectABoard_Calendar().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Delay(1000);
  Get_Dashboard_CalendarBoard().Click(70, 60);
}
function Add_InvestmentObjectiveVariationBoard()
 {
  if (! Get_Dashboard_InvestmentObjectiveVariationBoard().Exists)
  {
    ClickOnToolbarAddButton();
    Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Delay(1000);
  Get_Dashboard_InvestmentObjectiveVariationBoard().Click(70, 60);
}
function Add_TriggeredRestrictionsBoard()
 {
  if (! Get_Dashboard_TriggeredRestrictionsBoard().Exists)
  {
    ClickOnToolbarAddButton();
    Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions().Click();
    Get_DlgAddBoard_BtnOK().Click();
  }
  Delay(1000);
  Get_Dashboard_TriggeredRestrictionsBoard().Click(70, 60);
}


//++++++++++++++++++++++++++++ GRID++++++++++++++++++++++++++++++++++++++++++++++
function Check_alphabeticalSort(grid)//Check if an array is sorted alphabetically
{
   var count= grid.WPFObject("RecordListControl", "", 1).Items.Count;
   var arr = []; 
   for(var i=0; i<=count-1; i++) 
   { 
     arr.push(grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description); 
   }
   
    for (var i = 1; i < count-1; i++)
    {
        if (arr[i] < arr[i-1])
        {
        return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique ascendant");
        }
    }
    return Log.Checkpoint("Le grid  est trié par l’ordre alphabétique ascendant");
}



//La fonction peut être utilisée pour les nombres 
function Check_columnAlphabeticalSort(grid, columnName, itemColumnName ) //columnName - Le nom visible, c.-à-d. il est différant en français en en anglais ; itemColumnName- Les colonnes définis dans le code, ils sont même pour deux langues  
{
    var count= grid.WPFObject("RecordListControl", "", 1).Items.Count
    var arr = []; 
    var arrNotSupportedProperty = [];
    for (var i = 0; i < count; i++){
        var DataItem = grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem;
        if (aqObject.IsSupported(DataItem, itemColumnName)){
            if (isNaN(VarToStr(aqObject.GetPropertyValue(DataItem, itemColumnName))))
                arr.push(VarToStr(aqObject.GetPropertyValue(DataItem, itemColumnName)));
            else
                arr.push(aqObject.GetPropertyValue(DataItem, itemColumnName));
        }
        else
            arrNotSupportedProperty.push(i);
    }
    if (arrNotSupportedProperty.length > 0){
        Log.Error("Les éléments dont l'index est listé dans la partie Details ne supportent pas la propriété '" + itemColumnName + "'.", arrNotSupportedProperty, pmNormal, null, Sys.Desktop.Picture());
    }
    
    var actualColumnStatus = VarToStr(grid.Find("WPFControlText", columnName, 100).get_SortStatus());
    if (actualColumnStatus == "Ascending"){
        for (var i = 1; i < arr.length; i++){
            //if (aqString.ToUpper(arr[i]) < aqString.ToUpper(arr[i-1]) && aqString.GetChar(arr[i-1], 0) != "~"){  échoue avec les colonnes numériques Total value Balance etc..
            if (arr[i] < arr[i-1] && aqString.GetChar(arr[i-1], 0) != "~"){
                Log.Message("------------" + arr[i] + "------------------------" + arr[i-1] + "------------------------")
                Log.Message("Il se pourrait que l'objet utilisé dans cette fonction : 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("La colonne " + columnName + " n'est pas trié par l’ordre alphabétique ascendant");
            }
        }
        return Log.Checkpoint("La colonne " + columnName + " est trié par l’ordre alphabétique ascendant");  
    }
    else if (actualColumnStatus == "Descending"){
        for (var i = 1; i < arr.length; i++){
            if (arr[i-1] < arr[i] && aqString.GetChar(arr[i], 0) != "~"){
                Log.Message("Il se pourrait que l'objet utilisé dans cette fonction : 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("La colonne " + columnName + " n'est pas trié par l’ordre alphabétique descendant");
            }
        }
        return Log.Checkpoint("La colonne " + columnName + " est trié par l’ordre alphabétique descendant");  
    }
    else {
        Log.Warning("Le statut de la colonne '" + columnName + "' n'est ni 'Ascending' ni 'Descending', il est '" + actualColumnStatus + "'.", "", pmNormal, null, Sys.Desktop.Picture());
    }
}

 

//**************** fonction adaptée le 20/06/2019 par A.M suite au échecs de tri qui est lié au poids de la majiscule et caractères accentueux ****************************
//MAJ ce 2021/03/26 par Christophe suite discussion avec Abdel
function Check_columnAlphabeticalSort_CR1483(grid, columnName, itemColumnName ) //columnName - Le nom visible, c.-à-d. il est différant en français en en anglais ; itemColumnName- Les colonnes définis dans le code, ils sont même pour deux langues  
{
    var count = grid.WPFObject("RecordListControl", "", 1).Items.Count
    var arr = []; 
    var arrNotSupportedProperty = [];
    for (var i = 0; i < count; i++){
        var DataItem = grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem;
        if (!(aqObject.IsSupported(DataItem, itemColumnName)))
            arrNotSupportedProperty.push(i);
        else {
            if (isNaN(VarToStr(aqObject.GetPropertyValue(DataItem, itemColumnName))))
                arr.push(VarToStr(aqObject.GetPropertyValue(DataItem, itemColumnName)));
            else
                arr.push(aqObject.GetPropertyValue(DataItem, itemColumnName));
        }
            
    }
   
    if (arrNotSupportedProperty.length > 0){
        Log.Error("Les éléments dont l'index est listé dans la partie Details ne supportent pas la propriété '" + itemColumnName + "'.", arrNotSupportedProperty, pmNormal, null, Sys.Desktop.Picture());
    }
    
    var actualColumnStatus = VarToStr(grid.Find("WPFControlText", columnName, 100).get_SortStatus());
    if (actualColumnStatus == "Ascending"){
        for (var i = 1; i < arr.length; i++){
            if (arr[i-1] == null) arr[i-1] = "";
            if (arr[i] == null) arr[i] = "";
            arr[i-1] = RemoveAccentsInString(arr[i-1]);
            arr[i] = RemoveAccentsInString(arr[i]);
            if (aqString.Compare(arr[i],arr[i-1],false) == -1 && aqString.GetChar(arr[i-1], 0) != "_") {  // &&...etc Ajouté par Amine A.
                Log.Message("------------- Erreur de tri à:"+arr[i]+" et "+arr[i-1]+"------------------------");
                Log.Message("Il se pourrait que l'objet utilisé dans cette fonction : 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique ascendant");
            }
        }
        return Log.Checkpoint("Le grid  est trié par l’ordre alphabétique ascendant");  
    }
    else if (actualColumnStatus == "Descending"){
        for (var i = 1; i < arr.length; i++){
            if (arr[i-1] == null) arr[i-1] = "";
            if (arr[i] == null) arr[i] = "";
            arr[i-1] = RemoveAccentsInString(arr[i-1]);
            arr[i] = RemoveAccentsInString(arr[i]);
            if (aqString.Compare(arr[i-1],arr[i],false) == -1 && aqString.GetChar(arr[i], 0) != "_"){         // &&...etc Ajouté par Amine A.
			    Log.Message("------------- Erreur de tri à:"+arr[i]+" et "+arr[i-1]+"------------------------");
                Log.Message("Il se pourrait que l'objet utilisé dans cette fonction : 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique descendant");
            }
        }
        return Log.Checkpoint("Le grid  est trié par l’ordre alphabétique descendant");  
    }
    else {
        Log.Warning("Le statut de la colonne '" + columnName + "' n'est ni 'Ascending' ni 'Descending', il est '" + actualColumnStatus + "'.", "", pmNormal, null, Sys.Desktop.Picture());
    }
    
    
    function RemoveAccentsInString(str)
    {
        if (!isNaN(VarToStr(str)) || Trim(str) == ""){
            return str;
        }
        else {
            var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
            var accentsOut = "aaaaaaaaaaaaoooooooooooooeeeeeeeeeccdiiiiiiiiuuuuuuuunnssyyyzz";
            str = str.split('');
            var strLen = str.length;
            var i, x;
            for (i = 0; i < strLen; i++) {
                if ((x = accents.indexOf(str[i])) != -1)
                    str[i] = accentsOut[x];
            }
            return str.join('');
        }
    }
}



//La fonction peut être utilisée pour les nombres 
function Check_columnAlphabeticalSort_old(grid,columnName,itemColumnName) //columnName - Le nom visible, c.-à-d. il est différant en français en en anglais ; itemColumnName- Les colonnes définis dans le code, ils sont même pour deux langues  
{
   Log.Error("SVP, ne pas utiliser la présente function 'Check_columnAlphabeticalSort_old()' car elle sera supprimée. Celle qui la remplace est : 'Check_columnAlphabeticalSort()'. Merci."); //Christophe
   return Check_columnAlphabeticalSort(grid, columnName, itemColumnName);
   
   var count= grid.WPFObject("RecordListControl", "", 1).Items.Count
   var arr = []; 
   for(var i=0; i<=count-1; i++) 
   { 
     //arr.push(grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.itemColumnName); //Old
     arr.push(GetPropertyValue(grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, itemColumnName));
   }
   
   if(grid.Find("WPFControlText",columnName,100).get_SortStatus()=="Ascending"){
    for (i = 1; i<=count; i++){
       
            if (arr[i] < arr[i-1])
            {
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique ascendant");
            }
    }
    return Log.Checkpoint("Le grid  est trié par l’ordre alphabétique ascendant");  
 }
 
 if(grid.Find("WPFControlText",columnName,100).get_SortStatus()=="Descending"){
    for (i = 1; i<=count; i++){
       
            if (arr[i-1] < arr[i])
            {
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique descendant");
            }
    }
    return Log.Checkpoint("Le grid  est trié par l’ordre alphabétique descendant");  
 }
}




function FindLastModifiedFileInFolder(FolderPath, FileNameContains)
{    
    var FolderObject = aqFileSystem.GetFolderInfo(FolderPath); //The folder to look in
    var FileItems = FolderObject.Files;     //Collection of all the files in the folder
    var found;
    
    //Builds up the arrays with the filnames containing FileNameContains reg exp
    for (var i=0; i < FileItems.Count ; i++){ 
        if (i == FileItems.Count-1){
            found = FileItems.Item(i).Path;
        }
        else if ((FileItems.Item(i).Name.search(FileNameContains) > -1) && (FileItems.Item(i+1).Name.search(FileNameContains) <= -1)){
            found = FileItems.Item(i).Path;
            break;
        } 
    }
    return aqString.Replace(found, ".csv", ".txt");// SA: Cette fonction est modifié parce qu’à partir de CX le fichier .csv n'est plus généré. Zakaria a vérifié auprès de l'équipe d'architecture et ils ont confirmé que c'est voulu.
  // return aqString.Replace(found, ".txt", ".csv");
}     

//La fonction retourne un tableau de derniers fichiers générés  
function FindLastModifiedFilesInFolder(FolderPath, FileNameContains)
{    
    var FolderObject = aqFileSystem.GetFolderInfo(FolderPath); //The folder to look in
    var FileItems = FolderObject.Files;     //Collection of all the files in the folder
    var filesArray = new Array();
    
    //Builds up the arrays with the filnames containing FileNameContains reg exp
    for (var i = 0; i < FileItems.Count ; i++)
        if (FileItems.Item(i).Name.search(FileNameContains) > -1)
            filesArray.push(FileItems.Item(i).Path);
    
    return filesArray;
}

function FolderFinder(path,SearchPattern)
{
  var foundFolders, aFolder;
  foundFolders = aqFileSystem.FindFolders(path,SearchPattern);
  if (foundFolders != null)
    while (foundFolders.HasNext())
    {
      aFolder = foundFolders.Next();
      Log.Message(aFolder.Path);
      return aFolder.Path
    }
  else
    Log.Message("No folders were found.");
}



function CheckEquals(actualValue, expectedValue, valueDescription, picture)
{
    if (actualValue == expectedValue){
        Log.CallStackSettings.EnableStackOnCheckpoint = true;
        Log.Checkpoint(valueDescription + " is the expected : '" + expectedValue + "'",
        "Actual value :\r\n\r\n" + actualValue + "\r\n\r\nmatches Expected value :\r\n\r\n" + expectedValue + "\r\n");
        Log.CallStackSettings.EnableStackOnCheckpoint = false;
        return true;
    }
    else {
        if (picture == undefined)
            picture = null;
        
        Log.Error(valueDescription + " is not the expected. Expecting '" + expectedValue + "', got '" + actualValue + "'",
        "Actual value :\r\n\r\n" + actualValue + "\r\n\r\ndoes not match Expected value :\r\n\r\n" + expectedValue + "\r\n",
        pmNormal, null, picture);
        return false;
    }
}



function CheckEqualsToOneArrayItem(actualValue, arrayOfExpectedValues, valueDescription, picture)
{
    if (arrayOfExpectedValues != undefined && GetVarType(arrayOfExpectedValues) != varArray && GetVarType(arrayOfExpectedValues) != varDispatch)
        arrayOfExpectedValues = new Array(arrayOfExpectedValues);
    
    var strExpectedValues = VarToStr(arrayOfExpectedValues[0]);
    for (var j = 1; j < arrayOfExpectedValues.length; j++)
        strExpectedValues += "\r\n" + VarToStr(arrayOfExpectedValues[j]);
    
    for (var i = 0; i < arrayOfExpectedValues.length; i++){
        var expectedValue = arrayOfExpectedValues[i];
        if (actualValue == expectedValue){
            Log.CallStackSettings.EnableStackOnCheckpoint = true;
            Log.Checkpoint(valueDescription + " is the expected : '" + expectedValue + "'",
            "Actual value :\r\n\r\n" + actualValue + "\r\n\r\nmatches one of the expected values :\r\n\r\n" + strExpectedValues + "\r\n");
            Log.CallStackSettings.EnableStackOnCheckpoint = false;
            return true;
        }
    }
    
    if (picture == undefined)
        picture = null;
    
    Log.Error(valueDescription + " is not the expected. Got '" + actualValue + "' while expecting one of the following values '" + strExpectedValues + "'",
    "Actual value :\r\n\r\n" + actualValue + "\r\n\r\ndoes not match any of the expected values :\r\n\r\n" + strExpectedValues + "\r\n", pmNormal, null, picture);
    return false;
}



function CreateExternalClient(clientName, IACode)
{
    Log.Message("Create an external client (" + clientName + ").");
    Get_ModulesBar_BtnClients().Click();
	Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    ClickOnToolbarAddButton();
    Get_Toolbar_BtnAdd_AddDropDownMenu_CreateExternalClient().Click();
        
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(clientName);
	
    if (IACode != undefined){
        //Si le code CP est un Combobox (when IA Code is a Combobox)
        if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation().IsVisible)
            SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation(), IACode);
        else //Si le code CP est un Textbox (when IA Code is a Texbox)
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClientCreation().set_Text(IACode);
	}
	
    Get_WinDetailedInfo_BtnOK().Click();
}




function CreateFictitiousClient(clientName)
{
    Log.Message("Create a fictitious client (" + clientName + ").");
    Get_ModulesBar_BtnClients().Click();
	Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    ClickOnToolbarAddButton();
    Get_Toolbar_BtnAdd_AddDropDownMenu_CreateFictitiousClient().Click();
        
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(clientName);
    Get_WinDetailedInfo_BtnOK().Click();
}



function DeleteSubcategoryInSecurityCategorisation(subcategoryDescription, categoryLabel)
{
    if (categoryLabel == undefined)
        var llbSubcategory = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription);
    else
        var llbSubcategory = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription);
    
    if (!llbSubcategory.Exists)
        return Log.Message("Subcategory '" + subcategoryDescription + "' not found.");
    
    llbSubcategory.Click();
    Get_WinSecurityCategorisationConfigurations_BtnDelete().Click();
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), Get_DlgConfirmation().get_ActualHeight()-45);
    Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
}



function DeleteSecurityByDescription(securityDescription)
{
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Search_SecurityByDescription(securityDescription);
    var securityDescriptionCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild(["Uid", "Value"], ["Description", securityDescription], 10);
    if (!securityDescriptionCell.Exists)
        return Log.Message("Security '" + securityDescription + "' not found.");
    
    securityDescriptionCell.Click();
    Get_Toolbar_BtnDelete().Click();
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    Delay(1000);
}



function DeleteClient(clientName)
{
    Log.Message("Delete client " + clientName + ". The related accounts will be automatically deleted.");

    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    SearchClientByName(clientName);
    resultClientSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
    if (resultClientSearch.Exists == true){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        //Get_DlgConfirmAction_BtnDelete().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
    }
    else
        Log.Message("The client " + clientName + " does not exist.");
}


function DeleteClientByNumber(clientNumber)
{
    Log.Message("Delete client " + clientNumber + ". The related accounts will be automatically deleted.");

    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    Search_Client(clientNumber);
    resultClientSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10);
    if (resultClientSearch.Exists == true){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
        Get_Toolbar_BtnDelete().Click();
       
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
    }
    else
        Log.Message("The client " + clientNumber + " does not exist.");

}

function DeleteAccount(accountNumber)
{
    Log.Message("Delete Account '" + accountNumber + "'.");

    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");    
    SearchAccount(accountNumber);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    var accountCellInGrid = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10);
    
    if (!accountCellInGrid.Exists){
        Log.Message("The account '" + accountNumber + "' does not exist.");
        return;
    }

    accountCellInGrid.Click();
    Get_Toolbar_BtnDelete().Click();
    //Get_DlgConfirmAction_BtnDelete().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
}




function DeleteAccountByName(accountName)
{
    Log.Message("Delete Account '" + accountName + "'.");

    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    Get_AccountNO(accountName)
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    var accountCellInGrid = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountName, 10);
    
    if (!accountCellInGrid.Exists){
        Log.Message("The account '" + accountName + "' does not exist.");
        return;
    }

    accountCellInGrid.Click();
    Get_Toolbar_BtnDelete().Click();
    //Get_DlgConfirmAction_BtnDelete().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
}




function GetAllDisplayedAccountsNumbers()
{
    var isEndOfGriReached = false;
    var arrayOfAllDisplayedAccountsNumbers = new Array();
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    
    while (!isEndOfGriReached){
        accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < accountsPageCount; i++){
            displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            if (GetIndexOfItemInArray(arrayOfAllDisplayedAccountsNumbers, displayedAccountNumber) == -1)
                arrayOfAllDisplayedAccountsNumbers.push(displayedAccountNumber);
        }

        var firstRowAccountBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        
        if (firstRowAccountBeforeScroll == firstRowAccountAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        }
        
        isEndOfGriReached = (firstRowAccountBeforeScroll == firstRowAccountAfterScroll);
    }
    
    return arrayOfAllDisplayedAccountsNumbers;
}



function AssignAccountToModel(accountNo, modelNo)
{
    Log.Message("Assign " + accountNo + " account to " + modelNo + " model.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
	SearchAccount(accountNo);
    var searchResultAccount = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10);
    if (!searchResultAccount.Exists){
        Log.Error("The " + accountNo + " account was not displayed.");
        return false;
    }
        
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).ClickR();
        
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
        
    Get_WinPickerWindow().FindChild("Value", modelNo, 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
        
    if (Get_WinAssignToModel_BtnClose().IsVisible){
        Log.Error("Unable to assign account No " + accountNo + " to model No " + modelNo);
        Get_WinAssignToModel_BtnClose().Click();
        return false;
    }
        
    Get_WinAssignToModel_BtnYes().Click();
    return true;
}




function AssignRelationshipToModel(relationshipName, modelNo)
{
    Log.Message("Assign the relationship " + relationshipName + " to the model " + modelNo + ".");
    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    SearchRelationshipByName(relationshipName);
    var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (!searchResultRelationship.Exists){
        Log.Error("The relationship " + relationshipName + " was not displayed.");
        return false;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
    
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
    
    Get_WinPickerWindow().FindChild("Value", modelNo, 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    
    if (Get_WinAssignToModel_BtnClose().IsVisible){
        Log.Error("Unable to assign the relationship " + relationshipName + " to model No " + modelNo);
        Get_WinAssignToModel_BtnClose().Click();
        return false;
    }
    
    Get_WinAssignToModel_BtnYes().Click();
    return true;
}



function AssignRelationshipToModelByName(relationshipName, modelName)
{
    Log.Message("Assign the relationship " + relationshipName + " to the model " + modelName + ".");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(relationshipName);
    var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (!searchResultRelationship.Exists){
        Log.Error("The relationship " + relationshipName + " was not displayed.");
        return false;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
    
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
    
    Get_WinPickerWindow().Click();
    Sys.Keys(modelName);
    Get_WinQuickSearch_TxtSearch().SetText(modelName);
    Get_WinModelsQuickSearch_RdoName().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    
    var modelNameObject = Get_WinPickerWindow().FindChild("Value", modelName, 10);
    if (!modelNameObject.Exists){
        Log.Error("The model name '" + modelName + "' was not found in the Picker Window.");
        return false;
    }
    
    modelNameObject.Click();
    Get_WinPickerWindow_BtnOK().Click();
    
    if (Get_WinAssignToModel_BtnClose().IsVisible){
        Log.Error("Unable to assign the relationship " + relationshipName + " to Model name " + modelName);
        Get_WinAssignToModel_BtnClose().Click();
        return false;
    }
    
    Get_WinAssignToModel_BtnYes().Click();
    return true;
}



function CreateRelationship(RelationshipName, IACode, currency, relationshipLanguage, isBillable)
{
    Log.Message("Create the relationship \"" + RelationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(RelationshipName);
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    if (searchResult.Exists){
        Log.Message("The relationship " + RelationshipName + " already exists.");
        return;
    }
    
    var nbTries = 0;
    do {
        var nbSubMenuTries = 0;
        do {
            Delay(3000);
            ClickOnToolbarAddButton();
        } while ((++nbSubMenuTries) < 4 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
        
        if (Get_SubMenus().Exists && Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Exists){
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        }
    } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
    
    Delay(5000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationshipName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(RelationshipName);
    
    if (IACode != undefined){
        if (relationshipLanguage != undefined){
            if (language == "french"){
                if (relationshipLanguage.toUpperCase() == "FRANÇAIS" || relationshipLanguage.toUpperCase() == "FRANCAIS")
                    relationshipLanguage = "Français";
                else if (relationshipLanguage.toUpperCase() == "ANGLAIS")
                    relationshipLanguage = "Anglais";
                else
                    Log.Error(relationshipLanguage + " relationshipLanguage not covered.");
            }
            else {
                if (relationshipLanguage.toUpperCase() == "FRENCH")
                    relationshipLanguage = "French";

                else if (relationshipLanguage.toUpperCase() == "ENGLISH")
                    relationshipLanguage = "English";
                else
                    Log.Error(relationshipLanguage + " relationshipLanguage not covered.");
            }
        }
        
        //Déterminer si le composant du code CP est un Textbox (en vérifiant la liste du combobox de la Langue lorsque le code CP est un Textbox ; cette liste devrait correspondre à la liste des langues)
        var IsIACodeTextbox = false;
        if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().IsVisible){
            var arrayOfExpectedLanguages = (language == "french")? ["Français", "Anglais"]: ["English", "French"];            
            var itemsCount = Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().Items.Count;
            if (itemsCount != arrayOfExpectedLanguages.length)
                IsIACodeTextbox = false;
            else {
                var languagesCount = 0;
                for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++)
                    if (GetIndexOfItemInArray(arrayOfExpectedLanguages, VarToStr(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().Items.Item(itemIndex).WPFControlText)) != -1)
                        languagesCount++;
                IsIACodeTextbox = (languagesCount == arrayOfExpectedLanguages.length);
            }
        }
    
        //Si le code CP est un Combobox (when IA Code is a Combobox)
        if (!IsIACodeTextbox){
            SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), IACode);
            
            if (currency != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationship(), currency);
            
            if (relationshipLanguage != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationship(), relationshipLanguage);
        }
        
        //Si le code CP est un Textbox (when IA Code is a Texbox)
        else {
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACode);
            
            if (currency != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox(), currency);
            
            if (relationshipLanguage != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox(), relationshipLanguage);
        }
    }
    
    if (isBillable != undefined)
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().set_IsChecked(isBillable);
    
    Get_WinDetailedInfo_BtnOK().Click();
    
    var previousAutoTimeOut = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgInformation().Exists){
        Log.Error("There was an error while creating the relationship.");
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        Get_WinDetailedInfo_BtnCancel().Click();
    }
    SetAutoTimeOut(previousAutoTimeOut);
}



function CreateGroupedRelationship(GroupedRelationName, IACode)
{
    Log.Message("Create the grouped relationship \"" + GroupedRelationName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    SearchRelationshipByName(GroupedRelationName);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10);
    if (searchResult.Exists) {
        Log.Message("The relationship " + GroupedRelationName + " already exists.");
		return;
	}
	
    var nbTries = 0;
    do {
        var nbSubMenuTries = 0;
        do {
            Delay(3000);
            ClickOnToolbarAddButton();
        } while ((++nbSubMenuTries) < 4 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
        
        if (Get_SubMenus().Exists && Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Exists){
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        }
    } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
    
	Delay(5000);
	Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(GroupedRelationName);
	Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(GroupedRelationName);
	
	if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().IsVisible)
		Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Click();
	else
		Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox().Click();
	
	Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation().Click();

    if (IACode != undefined){
        //Si le code CP est un Combobox (when IA Code is a Combobox)
        if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().IsVisible)
            SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), IACode);
        //Si le code CP est un Textbox (when IA Code is a Texbox)
        else
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACode);
    }
	
	Get_WinDetailedInfo_BtnOK().Click();
	
    var previousAutoTimeOut = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgInformation().Exists){
        Log.Error("There was an error while creating the relationship.");
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        Get_WinDetailedInfo_BtnCancel().Click();
    }
    SetAutoTimeOut(previousAutoTimeOut);
}



function JoinToAGroupedRelationship(RelationshipName, GroupedRelationName)
{
    Log.Message("Join the relationship '" + RelationshipName + "' to the grouped relationship '" + GroupedRelationName + "'.");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(GroupedRelationName);
    if (!Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", GroupedRelationName, 10, true, 10000).Exists){
        Log.Error("Relationship '" + GroupedRelationName + "' not found.");
        return false;
    }
    
    SearchRelationshipByName(RelationshipName);
    if (!Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", RelationshipName, 10, true, 10000).Exists){
        Log.Error("Relationship '" + RelationshipName + "' not found.");
        return false;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", RelationshipName, 10, true, 10000).Click();
    var numTry = 0;
    do {
        Delay(3000);
        ClickOnToolbarAddButton();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    
    Delay(1000);
    Get_Toolbar_BtnAdd_AddDropDownMenu_JoinToAGroupedRelationship().Click();
    Delay(1000);
    
    Sys.Keys(GroupedRelationName);
    Get_WinQuickSearch_TxtSearch().SetText(GroupedRelationName);
    Get_WinQuickSearch_BtnOK().Click();
    
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAssignToARelationship_BtnYes().Click();
}



function JoinAccountToRelationship(AccountNameOrNumber, RelationshipName, isAccountName)
{
    Log.Message("Join the account " + AccountNameOrNumber + " to the relationship " + RelationshipName + ".");
    if (isAccountName == undefined)
        isAccountName = false;
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(RelationshipName);
    if (!Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", RelationshipName, 10, true, 10000).Exists){
        Log.Error("Relationship '" + RelationshipName + "' not found.");
        return false;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", RelationshipName, 10, true, 10000).Click();
    var numTry = 0;
    do {
        Delay(3000);
        ClickOnToolbarAddButton();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    
    Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Click();
    Delay(1000);
        
    //Vérifier que la fenêtre Comptes est ouverte
    Log.Message("Verify that he picker window is displayed.");
    if (!(Get_WinPickerWindow().Exists)){
        Log.Error("The picker window was not displayed.");
        return false;
    }
        
    //Choisir un compte et cliquer sur OK
    Sys.Keys(".");
    if (!Get_WinQuickSearch().Exists){
        Get_WinPickerWindow().Focus();
        Sys.Keys(".");
    }
    
    if (isAccountName){
        Get_WinAccountsQuickSearch_RdoName().set_IsChecked(true);
    }
    
    Get_WinQuickSearch_TxtSearch().SetText(AccountNameOrNumber);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow().FindChildEx("Value", AccountNameOrNumber, 10, true, 10000).Click();
    Get_WinPickerWindow_BtnOK().Click();
        
    //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
    Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
    if (!(Get_WinAssignToARelationship().Exists)){
        Log.Error("The 'Assign to a relationship' window was not displayed.");
        return false;
    }
        
    Get_WinAssignToARelationship_BtnYes().Click();
    
    return true;
}



function JoinClientToRelationship(clientNameOrNumber, relationshipName, isClientName)
{
    Log.Message("Join the client " + clientNameOrNumber + " to the relationship " + relationshipName + ".");
    if (isClientName == undefined)
        isClientName = false;
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(relationshipName);
    
    var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (!searchResultRelationship.Exists){
        Log.Error("The relationship " + relationshipName + " was not displayed.");
        return false;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
    var numTry = 0;
    do {
        Delay(3000);
        ClickOnToolbarAddButton();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    
    Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
    Delay(1000);
    
    //Vérifier que la fenêtre Comptes est ouverte
    Log.Message("Verify that he picker window is displayed.");
    if (!(Get_WinPickerWindow().Exists)){
        Log.Error("The picker window was not displayed.");
        return false;
    }
    
    //Choisir un client et cliquer sur OK
    Sys.Keys(".");
    if (!Get_WinQuickSearch().Exists){
        Get_WinPickerWindow().Focus();
        Sys.Keys(".");
    }
    
    if (isClientName){
        Get_WinClientsQuickSearch_RdoName().set_IsChecked(true);
    }
    
    Get_WinQuickSearch_TxtSearch().SetText(clientNameOrNumber);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow().FindChildEx("Value", clientNameOrNumber, 10, true, 10000).Click();
    Get_WinPickerWindow_BtnOK().Click();
    
    //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
    Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
    if (!(Get_WinAssignToARelationship().Exists)){
        Log.Error("The 'Assign to a relationship' window was not displayed.");
        return false;
    }
    
    Get_WinAssignToARelationship_BtnYes().Click();
    
    return true;
}



function DeleteRelationship(RelationshipName)
{
    Log.Message("Delete the relationship \"" + RelationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    SearchRelationshipByName(RelationshipName);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    if (searchResult.Exists){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        Delay(100);
        
        /*if (Get_DlgConfirmAction_BtnOK().Exists)
            Get_DlgConfirmAction_BtnOK().Click();
        else if (Get_DlgConfirmAction_BtnDelete().Exists)
            Get_DlgConfirmAction_BtnDelete().Click();*/
            
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().WaitProperty("VisibleOnScreen",true,5000);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
    }
    else
        Log.Message("The relationship " + RelationshipName + " does not exist.");
}



function AddDocumentToClient(ClientNo, FilePath)
{
    Log.Message("Add the document \"" + FilePath + "\" to the client No \"" + ClientNo + "\".");
    
    Get_ModulesBar_BtnClients().Click();
    Delay(100);
    
    Sys.Keys(ClientNo);
    Get_WinQuickSearch_TxtSearch().SetText(ClientNo);
    Get_WinQuickSearch_BtnOK().Click();
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", ClientNo, 10);
    if (searchResult.Exists == false){
        Log.Message("The client " + ClientNo + " does not exist.");
    }
    else {
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", ClientNo, 10).Click();
        Get_ClientsBar_BtnInfo().Click(60, 11);
        Get_ClientsBar_BtnInfo_ItemDocuments().Click();
        Delay(100);
        Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
        Delay(100);
        Get_WinAddAFile_GrpFile_BtnBrowse().Click();
        Delay(100);
        Get_DlgOpen_CmbFileName().Keys(FilePath);
        Get_DlgOpen_BtnOpen().Click();
        Delay(100);
        Get_WinAddAFile_BtnOK().Click();
        
        if (Get_DlgError().Exists) {
            Log.Warning("This client already has a reference to this document.");
            Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, 70);
        }
        
        Get_WinDetailedInfo_BtnOK().Click();
    }
}



function RemoveAllDocumentsOfClient(ClientNo)
{
    Log.Message("Remove all documents of the client \"" + ClientNo + "\".");
    
    Get_ModulesBar_BtnClients().Click();
    Delay(100);
    
    Sys.Keys(ClientNo);
    Get_WinQuickSearch_TxtSearch().SetText(ClientNo);
    Get_WinQuickSearch_BtnOK().Click();
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", ClientNo, 10);
    if (searchResult.Exists == false){
        Log.Message("The client " + ClientNo + " does not exist.");
    }
    else {
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", ClientNo, 10).Click();
        Get_ClientsBar_BtnInfo().Click(60, 11);
        Get_ClientsBar_BtnInfo_ItemDocuments().Click();
        Delay(100);
        
        while (Get_PersonalDocuments_LstDocuments_ItemTopDocument().Exists) {
            Get_PersonalDocuments_LstDocuments_ItemTopDocument().Click();
            Get_PersonalDocuments_Toolbar_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
            Delay(100);
        }
        
        Get_WinDetailedInfo_BtnOK().Click();
    }
}

//Valide la présence des onglets dans une fenêtre 
function CheckNonPresenceOfTab(component,tabDescription)// component qui contient des tab. Exemple :Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1) 
{
   var found=false;   
   var count = component.Items.Count
  
   for(var i=0; i<count; i++){  
      //Log.Message(component.Items.Item(i).WPFControlText)
      if(component.Items.Item(i).WPFControlText==tabDescription){
          found=true;
          break;
      }
   }
   return found;
}


//Maillage 
function Drag(draggedObj, destinationObj)
{
    var isPerformance = ((aqString.Find(projet, "Performance") == 0) || (aqString.Find(aqFileSystem.GetFileName(ProjectSuite.FileName), "ProjectSuitePerformance") == 0));
    if (!isPerformance){
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        Sys.Refresh();
    }
    
    var dragX = (draggedObj.Width)/2;
    var dragY = (draggedObj.Height)/2;
    var destinationX = -(draggedObj.ScreenLeft + dragX - (destinationObj.ScreenLeft + ((destinationObj.Width)/2)));
    var destinationY = -(draggedObj.Top + dragY - (destinationObj.Top + ((destinationObj.Height)/2)));
    draggedObj.HoverMouse(dragX, dragY);
    draggedObj.Drag(dragX, dragY, destinationX, destinationY);
    
    if (!isPerformance){
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 10000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 180000);
        Sys.Refresh();
    }
}

/**
    Description : Agrandir une fenêtre (Parfois la fct Maximize() de testComplete ne s'applique pas sur des fenêtres.)
    Paramètres :
            - WindowObject : La fonction Get de la fenêtre qu'on veut l'agrandir           
*/
function WindowMaximize(WindowObject){
  var draggedObj = WindowObject;
  var dragX = (draggedObj.Width)-20;
  var dragY = draggedObj.Height-40;
  var destinationX = dragX+15;
  var destinationY = dragY+15;
  draggedObj.HoverMouse(dragX, dragY);
  draggedObj.Click(dragX, dragY);
  draggedObj.Drag(dragX, dragY, destinationX, destinationY);

}

function Search_Account(account)
{
    ClickOnToolbarSearchButton();
    Get_WinQuickSearch_TxtSearch().SetText(account);
    Get_WinAccountsQuickSearch_RdoAccountNo().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}


function Search_AccountByName(account)
{
    ClickOnToolbarSearchButton();
    //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinQuickSearch().Exists){
            ClickOnToolbarSearchButton(); 
            numberOftries++;
    }
    Get_WinQuickSearch_TxtSearch().SetText(account);
    Get_WinAccountsQuickSearch_RdoName().set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    Delay(3000);
}


/*À supprimer à terme (To be deleted eventually)*/
function Select_Report(reportName)
{
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    Get_Reports_GrpReports_TabReports_LvwReports().Keys("[Home]");
    for (var i = 1; i < reportsCount; i++){
        var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
        if (currentReportName == reportName){
            Get_Reports_GrpReports_BtnAddAReport().Click();
            break;
        }

        Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
    }
}


/**
    removeAllReportsBeforeSelection : true/false
*/
function Select_Report_Performance(reportName, removeAllReportsBeforeSelection)
{
    if (removeAllReportsBeforeSelection == undefined)
        removeAllReportsBeforeSelection = true;
        
    if (removeAllReportsBeforeSelection && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
//    Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1).WPFObject("CFTreeViewItem", "", 2).WPFObject("TextBlock", "Global", 1).set_IsExpanded(true);    
    
//    if (language == 'french'){
//            var list = Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1).WPFObject("CFTreeViewItem", "", 2);   
//    } else if (language == 'english'){
//            var list = Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Reports", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1).WPFObject("CFTreeViewItem", "", 2);   
//    } 

    var list = Get_Reports_GrpReports().WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1).WPFObject("CFTreeViewItem", "", 2);
    mySavedReportsAllChildren = list.FindAllChildren("ClrClassName", "CFTreeViewItem", 1).toArray();
    
    isFound = false;
    for (i = 0; i < mySavedReportsAllChildren.length; i++){
        reportNameSearch = mySavedReportsAllChildren[i].FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", reportName]);
        if (reportNameSearch.Exists){
            mySavedReportsAllChildren[i].set_IsSelected(true);
            isFound = true;
            break;
        }
    }
    
    if (isFound)
        Get_Reports_GrpReports_BtnAddAReport().Click();
    else
        Log.Warning("The report '" + reportName + "' was not found!");
        
    return isFound;
}



function VarToStringWithoutInvisibleCharacters(varMessage)
{
    var arrayOfStringLines = VarToString(varMessage).split("\n");
    for (var i in arrayOfStringLines)
        arrayOfStringLines[i] = Trim(arrayOfStringLines[i]);
    return arrayOfStringLines.join("\n");
}



/**
    Description : remplace les caractères accentués par leurs équivalents non accentués
    Paramètres :
        - str : la chaîne de caractères
    Résultat : Caractères accentués remplacés par leurs équivalents non accentués
    Auteur : Christophe Paring
*/
function RemoveAccentsInString(str)
{
    var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
    str = str.split('');
    var strLen = str.length;
    var i, x;
    for (i = 0; i < strLen; i++) {
        if ((x = accents.indexOf(str[i])) != -1)
            str[i] = accentsOut[x];
    }
    
    return str.join('');
}



/**
    Description : Sélectionne un rapport
    Paramètres :
        - reportName : le nom du rapport à sélectionner
    Résultat : Rapport sélectionné
    Auteur : Christophe Paring
*/
function SelectAReportInCurrentReportsPanel(reportName)
{   
    var reportNameWithoutAccents = RemoveAccentsInString(reportName);
    var reportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.get_Count();
    
    //Hit first character
    var reportNameFirstChar = aqString.ToLower(aqString.GetChar(reportName, 0));
    Get_Reports_GrpReports_LvwCurrentReports().Click();
    Get_Reports_GrpReports_LvwCurrentReports().Keys(reportNameFirstChar);
    
    //Get row Index
    var selectedRow = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]);
    if (selectedRow.Exists){
        var fromRowIndex = selectedRow.WPFControlOrdinalNo;
        
        //Look for the report name
        for (var i = fromRowIndex; i <= reportsCount; i++){
            var currentReportName = VarToStr(Get_Reports_GrpReports_LvwCurrentReports().WPFObject("ListBoxItem", "", i).WPFControlText);
            
            if (!Get_Reports_GrpReports_LvwCurrentReports().WPFObject("ListBoxItem", "", i).WaitProperty("IsSelected", true, 30000))
                Log.Error("ListBoxItem " + i + ", report name '" + currentReportName + "' was not highlighted until 30000 seconds, in the current reports panel.");
            
            var currentReportNameWithoutAccents = RemoveAccentsInString(currentReportName);
            var currentReportNameFirstChar = aqString.ToLower(aqString.GetChar(currentReportName, 0));
            
            if (currentReportName == reportName){
                Log.Message("Report '" + currentReportName + "' selected in the current reports panel.");
                return true;
            }
        
            Get_Reports_GrpReports_LvwCurrentReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
        }
    }
    
    Log.Error("Report '" + reportName + "' not found!");
    return false;
}



/**
    Description : Sélectionne un rapport
    Paramètres :
        - reportName : le nom du rapport à sélectionner
    Résultat : Rapport sélectionné
    Auteur : Christophe Paring
*/
function SelectAReport(reportName, doNotValidateCurrentReportsIncrease)
{
    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    
    //Hit first character
    var reportNameFirstChar = aqString.ToLower(aqString.GetChar(reportName, 0));
    Get_Reports_GrpReports_TabReports_LvwReports().Click();
    Get_Reports_GrpReports_TabReports_LvwReports().Keys(reportNameFirstChar);
    
    //Get row Index
    var selectedRow = Get_Reports_GrpReports_TabReports_LvwReports().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]);
    if (selectedRow.Exists){
        var fromRowIndex = selectedRow.WPFControlOrdinalNo;
        
        //Look for the report name
        for (var i = fromRowIndex; i <= reportsCount; i++){
            var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
            
            if (!Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WaitProperty("IsSelected", true, 30000))
                Log.Error("ListBoxItem " + i + ", report name '" + currentReportName + "' was not highlighted until 30000 seconds.");
            
            var currentReportNameFirstChar = aqString.ToLower(aqString.GetChar(currentReportName, 0));
            
            if (currentReportNameFirstChar != reportNameFirstChar)
                break;
            
            if (currentReportName == reportName){
                Delay(3000);
                var initialCurrentReportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.Count;
                Get_Reports_GrpReports_BtnAddAReport().Click();
                if (doNotValidateCurrentReportsIncrease){
                    Log.Message("Report '" + currentReportName + "' selected.");
                    return true;
                }
                else {
                    Delay(2000);
                    var nbOfChecks = 0;
                    while ((++nbOfChecks < 12) && !(Get_Reports_GrpReports_LvwCurrentReports().Items.Count > initialCurrentReportsCount)){
                        Delay(5000);
                    }
                    
                    if (initialCurrentReportsCount < Get_Reports_GrpReports_LvwCurrentReports().Items.Count){
                        Log.Message("Report '" + currentReportName + "' added.");
                        return true;
                    }
                    else {
                        Log.Error("Number of Current Reports did not increase by timeout.");
                        return false;
                    }
                }
            }
            
            Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
        }
    }
    
    Log.Error("Report '" + reportName + "' not found!");
    return false;
}



/**
    Description : Sélectionne un ou plusieurs rapports
    Paramètres :
        - arrayOfReportsNames : tableau contenant les noms des rapports à sélectionner
        - isSavedReportSelected : true si un rapport sauvegardé a été sélectionné avant, false sinon (valeur par défaut) 
    Résultat : Rapports sélectionnés
    Auteur : Christophe Paring
*/
function SelectReports(arrayOfReportsNames, isSavedReportSelected)
{
    if (isSavedReportSelected == undefined)
        isSavedReportSelected = false;
    
    if (arrayOfReportsNames != undefined && GetVarType(arrayOfReportsNames) != varArray && GetVarType(arrayOfReportsNames) != varDispatch)
        arrayOfReportsNames = new Array(arrayOfReportsNames);
        
    Log.Message("Select the following report(s) : " + arrayOfReportsNames);
    
    //WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
    Delay(3000);
    Get_Reports_GrpReports_TabReports().Click();
    Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
    
    if (!isSavedReportSelected && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    var nbOfSelectedReports = 0;
    for (var j = 0; j < arrayOfReportsNames.length; j++){
        //Les rapports Agenda, Modèles et Titres se présentent de la même façon que le projet soit Performance ou General
        var arrayOfAlwaysDefaultDisplayReports = (language == "french")? ["Rapport", "Rapports modèles", "Rapports titres"]: ["Report", "Model Reports", "Security Reports"];
        var isReportDisplayPerformanceSpecific = ((projet == "Performance") && GetIndexOfItemInArray(arrayOfAlwaysDefaultDisplayReports, Get_WinReports().Title) == -1);
        var isReportSelected = (isReportDisplayPerformanceSpecific)? Select_Report_Performance(arrayOfReportsNames[j], false): SelectAReport(arrayOfReportsNames[j]);
        if (isReportSelected) nbOfSelectedReports ++;
    }
    
    if (nbOfSelectedReports < arrayOfReportsNames.length){
        Log.Warning("Only " + nbOfSelectedReports + " out of " + arrayOfReportsNames.length + " reports have been selected!");
        Log.Warning("La sélection des rapports a été en date testée seulement pour les projets : 'General' et 'Performance' ; pas pour 'PerformanceNFR' ni 'PerformanceEVOL'.");
    }
    return (nbOfSelectedReports == arrayOfReportsNames.length);
}



/**
    Description : Sélectionne un rapport dans l'arbre "Firme" des rapports sauvegardés
    Paramètre : savedReportName (string - nom du rapport à sélectionner)
    Résultat : Rapport sélectionné
    Auteur : Christophe Paring
*/
function SelectFirmSavedReport(savedReportName, removePreviouslySelectedReports, doNotValidateCurrentReportsIncrease)
{
    //WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
    
    Log.Message("Select Firm Saved Report ; saved report name : '" + savedReportName + "'.");
    
    Delay(3000);
    Get_Reports_GrpReports_TabSavedReports().Click();
    Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 60000);
    
    if (removePreviouslySelectedReports && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwMySavedReports().set_IsExpanded(false);
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm().set_IsExpanded(true);
    
    var firmAllChildren = Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm().FindAllChildren("ClrClassName", "CFTreeViewItem", 1).toArray();
    var isFound = false;
    for (var i = 0; i < firmAllChildren.length; i++){
        var reportNameSearch = firmAllChildren[i].FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", savedReportName]);
        if (reportNameSearch.Exists){
            firmAllChildren[i].set_IsSelected(true);
            isFound = true;
            break;
        }
    }
    
    if (!isFound){
        Log.Warning("The saved report '" + savedReportName + "' was not found!");
        return false;
    }
    else {
        Delay(3000);
        var initialCurrentReportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.Count;
        Get_Reports_GrpReports_BtnAddAReport().Click();
        Delay(2000);
        if (doNotValidateCurrentReportsIncrease){
            Log.Message("Report '" + savedReportName + "' selected.");
            return true;
        }
        else {
            var nbOfChecks = 0;
            while ((++nbOfChecks < 12) && !(Get_Reports_GrpReports_LvwCurrentReports().Items.Count > initialCurrentReportsCount)){
                Delay(5000);
            }
            
            if (initialCurrentReportsCount < Get_Reports_GrpReports_LvwCurrentReports().Items.Count){
                Log.Message("Report '" + savedReportName + "' added.");
                Delay(1000);
                return true;
            }
            else {
                Log.Error("Number of Current Reports did not increase by timeout.");
                return false;
            }
        }
        
    }
    
    return false;
}



/**
    Description : Sélectionne un rapport dans l'arbre "Mes rapports sauvegardés" des rapports sauvegardés
    Paramètre : savedReportName (string - nom du rapport à sélectionner)
    Résultat : Rapport sélectionné
    Auteur : Christophe Paring
*/
function SelectMySavedReport(savedReportName, removePreviouslySelectedReports)
{
    //WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
    
    Log.Message("Select My Saved Report ; saved report name : '" + savedReportName + "'.");
    
    Delay(3000);
    Get_Reports_GrpReports_TabSavedReports().Click();
    Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 60000);
    
    if (removePreviouslySelectedReports && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwMySavedReports().set_IsExpanded(true);
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm().set_IsExpanded(false);
    
    var mySavedReportsAllChildren = Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwMySavedReports().FindAllChildren("ClrClassName", "CFTreeViewItem", 1).toArray();
    var isFound = false;
    for (var i = 0; i < mySavedReportsAllChildren.length; i++){
        var reportNameSearch = mySavedReportsAllChildren[i].FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", savedReportName]);
        if (reportNameSearch.Exists){
            mySavedReportsAllChildren[i].set_IsSelected(true);
            isFound = true;
            break;
        }
    }
    
    if (isFound){
        Get_Reports_GrpReports_BtnAddAReport().Click();
        Log.Message("Saved report '" + savedReportName + "' selected.");
    }
    else
        Log.Warning("The saved report '" + savedReportName + "' was not found!");
    
    return isFound;
}



function SaveDefaultReportForRelationships(reportName, savedReportName)
{
    if (savedReportName == undefined)
        savedReportName = reportName;
    
    Log.Message("Save Default Report for Relationships. Report name : '" + reportName + "' ; saved report name : '" + savedReportName + "'.");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    Get_RelationshipsBar_BtnInfo().WaitProperty("IsEnabled", true, 10000);
    Get_RelationshipsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsSelected", true, 60000);
    
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    SelectReports(reportName);
    
    Get_Reports_GrpReports_BtnSave().Click();
    Get_WinSaveReports_TxtSaveAs().set_Text(savedReportName);
    Get_WinSaveReports_BtnOK().Click();
    
    Get_WinDetailedInfo_BtnOK().Click();
}



function DeleteSavedDefaultReportForRelationships(savedReportName)
{
    Log.Message("Delete Saved Default Report for Relationships. Saved report name : '" + savedReportName + "'.");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    Get_RelationshipsBar_BtnInfo().WaitProperty("IsEnabled", true, 10000);
    Get_RelationshipsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsSelected", true, 60000);
    
    SelectMySavedReport(savedReportName);
    
    Get_Reports_GrpReports_TabSavedReports_BtnDelete().Click();
    //Get_DlgConfirmAction_BtnYes().Click(); //CP : Modifié pour CO
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    
    Get_WinDetailedInfo_BtnOK().Click();
} 



/**
    Description : Déplace un rapport au sommet de la liste des rapports courants.
    Paramètre : currentReportName (string - nom du rapport à déplacer)
    Résultat : Rapport déplacé en tête de liste
    Auteur : Christophe Paring
*/
function MoveCurrentReportToTop(currentReportName)
{
    Log.LockEvents(5);
    
    Log.Message("Move Current Report '" + currentReportName + "' to the top.");
    Delay(3000);
    if (true === SelectAReportInCurrentReportsPanel(currentReportName)){
        var nbClick = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]).WPFControlOrdinalNo;
        while (nbClick > 1){
            Get_Reports_GrpReports_BtnMoveTheReportUp().Click();
            Delay(3000);
            nbClick--;
        }
        
        Get_Reports_GrpReports_LvwCurrentReports().Keys("[Home]");
    }

    var isCurrentReportNameAtTop = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "IsSelected", "WPFControlOrdinalNo"], ["ListBoxItem", currentReportName, true, 1]).Exists;
    if (isCurrentReportNameAtTop)
        Log.Message("Current Report '" + currentReportName + "' moved to the top.");
    else
        Log.Error("Current Report '" + currentReportName + "' not moved to the top.");
    
    Log.UnlockEvents();
    return isCurrentReportNameAtTop;
}




// Creates the folder and checks if it has been created successfully  
function Create_Folder(folderPath)
{
    if (aqFileSystem.CreateFolder(folderPath) == 0)
        Log.message("Le dossier " + folderPath + " a été créé.");
    else
        Log.message("Le dossier " + folderPath + " existe déjà.");
}



function SaveAs_AcrobatReader(pathReportName, backupFolder)
{
    var reportFullPath = pathReportName + ".pdf";
    
    //S'il existe un fichier de même nom, le supprimer ; sinon en créer le dossier parent si ce dernier n'existe pas
    if (aqFile.Exists(reportFullPath)){
        if (!aqFileSystem.DeleteFile(reportFullPath)){
            Log.Error("Issue while deleting an existing file with the same name: " + reportFullPath);
        }
    }
    else if (!aqFileSystem.Exists(aqFileSystem.GetFileFolder(reportFullPath))){
        Create_Folder(aqFileSystem.GetFileFolder(reportFullPath));
    }
    
    //Si la langue d'affichage de Windows n'est pas connue, mettre à jour la variable globale y relative : WINDOWS_DISPLAY_LANGUAGE
    //Car le bouton "Enregistrer" de la boîte de dialogue "Enregistrer sous" s'affiche dans cette langue
    GetWindowsDisplayLanguage();
    
    //Faire CTRL + SHIFT + S et sauvegarder le fichier
    var AcrobatSDIWindow = Sys.FindChild("WndClass", "AcrobatSDIWindow", 10);
    var nbOfTries = 0;
    do {
        Delay(1000);
        AcrobatSDIWindow.Keys("^S");
        Delay(3000);
    }
    while (++nbOfTries < 5 && !Get_AcrobatReader_DlgSaveAs().Exists) 
    
    Get_AcrobatReader_DlgSaveAs().WaitProperty("Visible", true, 10000);
    Get_AcrobatReader_DlgSaveAs().SetFocus();
    Get_AcrobatReader_DlgSaveAs_CmbFileName().SetText(pathReportName);
    Get_AcrobatReader_DlgSaveAs_BtnSave().Click();
    
    //Fermer Acrobat Reader
    Delay(1000);
    AcrobatSDIWindow.WaitProperty("Enabled", true, 10000);
    AcrobatSDIWindow.Keys("~[F4]");
    WaitObjectPropertyExistsToFalse(AcrobatSDIWindow, 10000);
    TerminateAcrobatProcess();
    
    //Vérifier l'existence effective du fichier PDF
    if (!aqFile.Exists(reportFullPath)){
        Log.Error("File not successfully saved: " + reportFullPath);
    }
    else {
        Log.Checkpoint("File successfully saved: " + reportFullPath);
        if (backupFolder != undefined){
            if (aqFileSystem.CopyFile(reportFullPath, aqFileSystem.IncludeTrailingBackSlash(backupFolder), false)){
                Log.Checkpoint("File successfully saved in backup folder: " + backupFolder);
            }
            else {
                Log.Error("File not successfully saved in backup folder: " + backupFolder);
            }
        }
    }
}



function ValidateAndSaveReportAsPDF(reportFilePath, backupFolder, isDestinationPDFFile, findExactFileName, doNotCorrectFileNameLanguageSuffix)
{
    if (isDestinationPDFFile == undefined)
        isDestinationPDFFile = false;
    
    if (findExactFileName == undefined)
        findExactFileName = true;
    
    if (doNotCorrectFileNameLanguageSuffix == undefined)
        doNotCorrectFileNameLanguageSuffix = false;
    
    if (isDestinationPDFFile){
        //Validate and look for the report file
        var reportGenerationTime = ValidateReportWithDestinationAsPDFFile(reportFilePath, backupFolder, findExactFileName);
    }
    else {
        //Mettre le bon suffixe au nom du rapport lorsqu'on veut produire en une seule langue
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE && !doNotCorrectFileNameLanguageSuffix){
            var reportFilePathPrefix = (aqString.FindLast(aqFileSystem.GetFileNameWithoutExtension(reportFilePath), "_") == -1)? reportFilePath + "_" : aqString.SubString(reportFilePath, 0, aqString.FindLast(reportFilePath, "_") + 1);
            var reportFileNameSuffix = "";
            if (CR1485_REPORTS_LANGUAGE == "english")
                reportFileNameSuffix = "EN";
            else if (CR1485_REPORTS_LANGUAGE == "french")
                reportFileNameSuffix = "FR";
        
            reportFilePath = reportFilePathPrefix + reportFileNameSuffix;
        }
        
        //Validate and Save the report
        var reportGenerationTime = ValidateReport(false, false, aqFileSystem.GetFileNameWithoutExtension(reportFilePath));
        if (reportGenerationTime != ""){
            Log.Checkpoint("PDF affiché.");
            SaveAs_AcrobatReader(reportFilePath, backupFolder);
        }
    }
    
    //Save reportGenerationTime in Excel
    if (projet == "General" || projet == "Performance" || projet == "PerformanceNFR" || projet == "PerformanceEVOL"){
        var rowID = aqFileSystem.GetFileNameWithoutExtension(reportFilePath + ".pdf");
        var sheetName = (aqFileSystem.GetFileNameWithoutExtension(Project.FileName) == "GP1859")? Trim("GP1859" + " " + VarToStr(Global_variables.GP1859_FOLDER_SUFFIX_THEME_ID)): "Rapports" + projet;
        var saveDataMaxTries = 3;
        var saveDataTriesLeft = saveDataMaxTries;
        while (saveDataTriesLeft > 0){
            try {
                if (saveDataTriesLeft < saveDataMaxTries){
                    Log.Message("Saving report generation time in Excel sheet may have previously failed. " + saveDataTriesLeft + " attempts left, Trying again...", "", pmNormal, null, Sys.Desktop.Picture());
                    CloseExcel();
                    Delay((20000 * (saveDataMaxTries - saveDataTriesLeft)));
                }
                SaveDataInExcelSheet(filePath_Performance, sheetName, rowID, "'" + reportGenerationTime);
                saveDataTriesLeft = 0;
            }
            catch (e_SaveDataInExcelSheet){
                saveDataTriesLeft--;
                if (saveDataTriesLeft == 0){
                    var exceptionLogMsg = "Exception dans SaveDataInExcelSheet(). Feuille '" + sheetName + "', ligne '" + rowID + "', reportGenerationTime = " + reportGenerationTime + " (Fichier : " + filePath_Performance + ")";
                    if (Trim(VarToStr(e_SaveDataInExcelSheet.message)) == 'The remote server machine does not exist or is unavailable')
                        Log.Warning(exceptionLogMsg, e_SaveDataInExcelSheet.message + "\r\n\r\n" + VarToStr(e_SaveDataInExcelSheet.stack));
                    else
                        Log.Error(exceptionLogMsg, e_SaveDataInExcelSheet.message + "\r\n\r\n" + VarToStr(e_SaveDataInExcelSheet.stack));
                }
                e_SaveDataInExcelSheet = null;
            }
        }
    }
    
    if (!isDestinationPDFFile)
        TerminateAcrobatProcess();
}



/**
    Description : Valider le rapport dans le cas où la destination est "Fichier PDF" et non pas "Aperçu"
    Paramètres : reportFilePath = Chemin d'accès du fichier, sans l'extension .pdf
                 backupFolder = dossier de sauvegarde redondante
                 findExactFileName = indique s'il faut cherche exactement le nom de fichier fourni par reportFilePath
                 maxWaitTime = temps de recherche maximum (timeout)
    Retourne : Temps de génération du rapport (format = hh:mm:ss.mmm)
                Chaîne de caractères vide si rapport non généré.
*/
function ValidateReportWithDestinationAsPDFFile(reportFilePath, backupFolder, findExactFileName, reportFileNameFinal, maxWaitTime)
{
    if (findExactFileName == undefined)
        findExactFileName = true;
    
    if (maxWaitTime == undefined)
        maxWaitTime = CR1485_REPORTS_TIMEOUT;
    
    var reportFullPath = reportFilePath + ".pdf";
    var reportFolderPath = aqFileSystem.GetFileFolder(reportFilePath);
    var reportFileName = aqFileSystem.GetFileName(reportFullPath);
    Log.Message("ValidateReportWithDestinationAsPDFFile : " + reportFileName);
    
    //Delete existing file with the same expected name
    if (aqFileSystem.Exists(reportFullPath) && !aqFileSystem.DeleteFile(reportFullPath))
            Log.Error("Unable to delete an existing file having the same expected name : " + reportFullPath);
    
    //Delete existing file with the same final name
    if (reportFileNameFinal != undefined){
        reportFileNameFinal = reportFileNameFinal + ".pdf";
        var reportFullPathFinal = aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + reportFileNameFinal;
        if (aqFileSystem.Exists(reportFullPathFinal) && !aqFileSystem.DeleteFile(reportFullPathFinal))
            Log.Error("Unable to delete an existing file having the same final name : " + reportFullPathFinal);
    }
    
    //Get existing files
    var arrayOfOlderFiles = GetArrayOfFolderFilesNames(reportFolderPath);
    
    //Validate report
    var reportGenerationTimer = HISUtils.StopWatch;
    var reportGenerationTime = "";
    var waitTime = 0;
    var reportsWindowTitle = Get_WinReports().Title.OleValue;
    Get_Reports_GrpReports_BtnRemoveAllReports().WaitProperty("IsEnabled", true, 15000);
    Sys.Refresh();
    Get_WinReports_BtnOK().WaitProperty("IsEnabled", true, 15000);
    Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    Get_WinReports_BtnOK().Click();
    reportGenerationTimer.Start();
    
    //La fenêtre des rapports devrait disparaître après 5 secondes au maximum
    SetAutoTimeOut(3000);
    if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000)){
        //Si la fenêtre des rapports est encore affichée, vérifier s'il y a eu affichage de la boîte de dialogue Validation et attendre qu'elle disparaisse le cas échéant
        if (WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 2000))
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 30000);
        
        //Si la fenêtre des rapports est encore affichée, vérifier s'il y a eu affichage d'une ou plusieurs boîtes de dialogue inattendues
        if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000)){
            if (!Get_WinReports().IsActive)
                CheckUnexpectedDialogBoxes(Get_WinReports());
            
            //Annuler la génération du rapport au cas où la fenêtre des rapports serait encore affichée
            Get_CroesusApp().WaitProperty("CPUUsage", 10, 5000);
            Get_CroesusApp().WaitProperty("CPUUsage", 0, 50000);
            if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 60000)){
                Log.Error("ANNULER RAPPORT (car après validation, la fenêtre '" + reportsWindowTitle + "' est restée affichée au-delà du temps maximum). " + reportFileName, reportFileName);
                Get_WinReports_BtnClose().Click();
                reportGenerationTimer.Stop();
                reportGenerationTimer.Reset();
                RestoreAutoTimeOut();
                return reportGenerationTime;
            }
        }
    }
    
    //Wait until there is some new file in the folder
    var isNewFileFound = false;
    waitTime = reportGenerationTimer.Stop();
    Delay(300);
    do {
        reportGenerationTimer.Start();
        Delay(300);
        var folderFiles = aqFileSystem.GetFolderInfo(reportFolderPath).Files;
        var folderFilesCount = (folderFiles == null)? 0: aqFileSystem.GetFolderInfo(reportFolderPath).Files.Count;
        isNewFileFound = (folderFilesCount > arrayOfOlderFiles.length);
        waitTime = reportGenerationTimer.Stop();
        if (isNewFileFound){
            Delay(15000);
            break;
        }
    } while (waitTime < maxWaitTime)
    
    //Get new files
    if (!isNewFileFound)
        reportGenerationTimer.Start();
    
    var arrayOfNewFiles = [];
    var arrayOfCurrentFiles = GetArrayOfFolderFilesNames(reportFolderPath);
    for (var j = 0; j < arrayOfCurrentFiles.length; j++)
        if (GetIndexOfItemInArray(arrayOfOlderFiles, arrayOfCurrentFiles[j]) == -1)
            arrayOfNewFiles.push(arrayOfCurrentFiles[j]);
    
    if (!isNewFileFound){
        isNewFileFound = (arrayOfNewFiles.length > 0);
        waitTime = reportGenerationTimer.Stop();
    }
    
    //Put reportGenerationTime in format hh:mm:ss.mmm
    if (isNewFileFound){
        reportGenerationTime = reportGenerationTimer.ToString();
        Log.Message("Report generated within : " + reportGenerationTime + " (hh:mm:ss.mmm).");
    }
    reportGenerationTimer.Reset();
    
    //Validate the expected number of new files
    if (!CheckEquals(arrayOfNewFiles.length, 1, "The number of new file(s)")){
        if (arrayOfNewFiles.length > 1)
            Log.Error("Following new files were found " + arrayOfNewFiles, arrayOfNewFiles);
    }
    
    //In case file name does not matter, Rename the file found (only the first one if many)
    if (!findExactFileName && arrayOfNewFiles.length > 0){
        if (aqFileSystem.RenameFile(aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + arrayOfNewFiles[0], reportFullPath, false)){
            arrayOfNewFiles[0] = reportFileName;
            Log.Message("File renamed from '" + arrayOfNewFiles[0] + "' to '" + reportFileName + "'.");
        }
        else
            Log.Error("Issue while renaming file from '" + arrayOfNewFiles[0] + "' to '" + reportFileName + "'.");
    }
    
    //Check if file actually exists and save it to the backup folder
    var renameFromIndex;
    if (aqFileSystem.Exists(reportFullPath)){
        renameFromIndex = 1;
        Log.Checkpoint("File successfully generated : " + reportFileName, reportFullPath);
        if (reportFileNameFinal != undefined){
            if (aqFileSystem.RenameFile(reportFullPath, reportFullPathFinal, false)){
                arrayOfNewFiles[0] = reportFileNameFinal;
                Log.Message("File renamed from '" + reportFileName + "' to '" + reportFileNameFinal + "'.");
            }
            else
                Log.Error("Issue while renaming file from '" + reportFileName + "' to '" + reportFileNameFinal + "'.");
        }
    }
    else {
        renameFromIndex = 0;
        if (!findExactFileName)
            Log.Error("This report File generation has failed : " + reportFileName, reportFullPath);
        else {
            Log.Error("Expected File not found : " + reportFileName, reportFullPath);
            if (isNewFileFound)
                Log.Error("But following File(s) were found : " + arrayOfNewFiles, arrayOfNewFiles);
        }
    }
    
    //Rename new files
    if (isNewFileFound){
        var newFileRenamedNameSuffix = "_UNEXPECTED_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");// + "_FOR_EXPECTED_FILE_" + reportFileName;
        for (var p = renameFromIndex; p < arrayOfNewFiles.length; p++){
            var newFileName = arrayOfNewFiles[p];
            var newFileRenamedName = newFileName + newFileRenamedNameSuffix + "." + aqFileSystem.GetFileExtension(aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + newFileName);
            if (aqFileSystem.RenameFile(aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + newFileName, aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + newFileRenamedName, false)){
                arrayOfNewFiles[p] = newFileRenamedName;
                Log.Message("File renamed from '" + newFileName + "' to '" + newFileRenamedName + "'.");
            }
            else
                Log.Error("Issue while renaming file from '" + newFileName + "' to '" + newFileRenamedName + "'.");
        }
    }
    
    //Copy new files to the backup folder
    if (isNewFileFound && backupFolder != undefined){
        var arrayOfBackupFilesSuccess = [];
        var arrayOfBackupFilesFailure = [];
        for (var k = 0; k < arrayOfNewFiles.length; k++){
            var newFileName = arrayOfNewFiles[k];
            if (aqFileSystem.CopyFile(aqFileSystem.IncludeTrailingBackSlash(reportFolderPath) + newFileName, aqFileSystem.IncludeTrailingBackSlash(backupFolder), false))
                arrayOfBackupFilesSuccess.push(newFileName);
            else
                arrayOfBackupFilesFailure.push(newFileName);
        }
        
        if (arrayOfBackupFilesSuccess.length > 0)
            Log.Checkpoint("File(s) successfully saved in backup folder : " + backupFolder + " : " + arrayOfBackupFilesSuccess);
            
        if (arrayOfBackupFilesFailure.length > 0)
            Log.Error("File(s) not successfully saved in backup folder : " + backupFolder + " : " + arrayOfBackupFilesFailure);
    }
    
    //Check if the report generation has crashed
    SetAutoTimeOut(1000);
    if (Get_DlgPrintingStatusMessageLogs().Exists && Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().Exists){
        Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().HoverMouse();
        Delay(1000);
        Log.Error("RAPPORT EN ERREUR. " + reportFileName, reportFileName);
        Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
    }
    
    //Check if there was some reports that contains no data
    if (Get_DlgPrintingStatusMessageLogs().Exists && Get_DlgPrintingStatusMessageLogs_TxtMessageReportNoData().Exists){
        Get_DlgPrintingStatusMessageLogs_TxtMessageReportNoData().HoverMouse();
        Delay(1000);
        Log.Warning("AU MOINS UN RAPPORT NE CONTENAIT AUCUNE DONNÉE. " + reportFileName, reportFileName, pmNormal, null, Sys.Desktop.Picture());
        Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
    }
    RestoreAutoTimeOut();
    
    return reportGenerationTime;
    
    
    /**
        Returns a folder files names as Array
    */
    function GetArrayOfFolderFilesNames(aFolderPath)
    {
        var arrayOfFolderFiles = [];
        var folderFiles = aqFileSystem.GetFolderInfo(aFolderPath).Files;
        if (folderFiles != null)
            for (var i = 0; i < folderFiles.Count; i++)
                arrayOfFolderFiles.push(folderFiles.Item(i).Name);
        return arrayOfFolderFiles;
    }
    
    
    function GetRapportsScriptFileName()
    {
        if (aqFileSystem.GetFileNameWithoutExtension(Project.FileName) != "Rapports"){
            Log.Error("This function was being used only for project 'Rapports'.");
            return GetCurrentScriptFileName();
        }
        else {
            //The Global variable CR1485_REPORTS_LANGUAGE_FOR_DESTINATION_AS_FILE is updated in function SetReportsOptionsNew
            var reportFileNameSuffix = (CR1485_REPORTS_LANGUAGE_FOR_DESTINATION_AS_FILE == "Français (Canada)")? "_FR": "_EN";
            return GetCurrentScriptFileName() + reportFileNameSuffix + ".pdf";
        }
    }
}



/**
    Description : Valider le rapport
    Retourne : Temps de génération du rapport (format = hh:mm:ss.mmm)
                Chaîne de caractères vide si rapport non généré.
*/
function ValidateReport(killAcrobatProcessAtEnd, logErrorIfAcrobatDoesNotStart, reportFileName)
{
    if (killAcrobatProcessAtEnd == undefined)
        killAcrobatProcessAtEnd = false;
    
    if (logErrorIfAcrobatDoesNotStart == undefined)
        logErrorIfAcrobatDoesNotStart = true;
        
    if (reportFileName == undefined)
        reportFileName = "";

    Log.Message("ValidateReport " + reportFileName);
    TerminateAcrobatProcess();
    Delay(1000);
    
    var acrobatProcessName = GetAcrobatProcessName();
    var reportsWindowTitle = Get_WinReports().Title.OleValue;
    var reportGenerationTimer = HISUtils.StopWatch;
    var reportGenerationTime = "";
    var isPDFFileDisplayed = false;
    SetAutoTimeOut(3000);
    
    //Valider le rapport
    Get_Reports_GrpReports_BtnRemoveAllReports().WaitProperty("IsEnabled", true, 15000);
    Sys.Refresh();
    Get_WinReports_BtnOK().WaitProperty("IsEnabled", true, 15000);
    Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    Get_WinReports_BtnOK().Click();
    reportGenerationTimer.Start();
    
    //D'abord vérifier si le PDF est affiché
    var acrobatProcess = Sys.WaitProcess(acrobatProcessName, PROJECT_AUTO_WAIT_TIMEOUT / 2);
    Sys.Refresh();
    if (acrobatProcess.Exists && Sys.FindChildEx(["WndClass", "Visible"], ["AcrobatSDIWindow", true], 10, true, PROJECT_AUTO_WAIT_TIMEOUT / 2).Exists)
        isPDFFileDisplayed = true;
    else {
        //La fenêtre des rapports devrait disparaître après 5 secondes au maximum
        if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000)){
            //Si la fenêtre des rapports est encore affichée, vérifier s'il y a eu affichage de la boîte de dialogue Validation et attendre qu'elle disparaisse le cas échéant
            if (WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 5000))
                WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 120000);
        
            //Si la fenêtre des rapports est encore affichée, vérifier s'il y a eu affichage d'une ou plusieurs boîtes de dialogue inattendues
            if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 30000)){
                if (!Get_WinReports().IsActive)
                    CheckUnexpectedDialogBoxes(Get_WinReports());
                
                //Annuler la génération du rapport au cas où la fenêtre des rapports serait encore affichée
                Get_CroesusApp().WaitProperty("CPUUsage", 10, 5000);
                Get_CroesusApp().WaitProperty("CPUUsage", 0, 50000);
                if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 60000)){
                    Log.Error("ANNULER RAPPORT (car après validation, la fenêtre '" + reportsWindowTitle + "' est restée affichée au-delà du temps maximum). " + reportFileName, reportFileName);
                    Get_WinReports_BtnClose().Click();
                    reportGenerationTimer.Stop();
                    reportGenerationTimer.Reset();
                    RestoreAutoTimeOut();
                    return reportGenerationTime;
                }
            }
        }
        
        //Vérifier si le PDF est affiché
        acrobatProcess = Sys.WaitProcess(acrobatProcessName, PROJECT_AUTO_WAIT_TIMEOUT / 2);
        Sys.Refresh();
        if (acrobatProcess.Exists && Sys.FindChildEx(["WndClass", "Visible"], ["AcrobatSDIWindow", true], 10, true, PROJECT_AUTO_WAIT_TIMEOUT / 2).Exists)
            isPDFFileDisplayed = true;
        else {
            //Wait for Acrobat Reader process to start
            SetAutoTimeOut(CR1485_REPORTS_TIMEOUT)
            if (Get_MainWindow_StatusBar_ProgressBar().WaitProperty("IsVisible", true, PROJECT_AUTO_WAIT_TIMEOUT / 2) && !Get_MainWindow_StatusBar_ProgressBarPercentValue100().Exists)
                Log.Message("The ProgressBarPercentValue in the StatusBar did not reach until timeout.");
    
            //Check if the report generation has crashed
            SetAutoTimeOut(1000);
            if (Get_DlgPrintingStatusMessageLogs().Exists && Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().Exists){
                Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().HoverMouse();
                Delay(1000);
                Log.Error("RAPPORT EN ERREUR. " + reportFileName, reportFileName);
                Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
            }
    
            //Check if the PDF file is displayed
            if (!Sys.WaitProcess(acrobatProcessName, PROJECT_AUTO_WAIT_TIMEOUT / 2, 1).Exists){
                if (logErrorIfAcrobatDoesNotStart)
                    Log.Error("Acrobat Reader process ('" + acrobatProcessName + "') has not started!");
                else
                    Log.Warning("Acrobat Reader process ('" + acrobatProcessName + "') has not started!", "", pmNormal, null, Sys.Desktop.Picture());
            }
            else {
                Sys.Refresh();
                if (Sys.FindChildEx(["WndClass", "Visible"], ["AcrobatSDIWindow", true], 10, true, 100000).Exists)
                    isPDFFileDisplayed = true;
                else {
                    if (logErrorIfAcrobatDoesNotStart)
                        Log.Error("Acrobat Reader process ('" + acrobatProcessName + "') has started but the PDF file was not displayed!");
                    else
                        Log.Warning("Acrobat Reader process ('" + acrobatProcessName + "') has started but the PDF file was not displayed!", "", pmNormal, null, Sys.Desktop.Picture());
                }
            }
        }
    }
    
    reportGenerationTimer.Stop();
    if (isPDFFileDisplayed){
        reportGenerationTime = reportGenerationTimer.ToString();
        Log.Message("Report PDF generated within : " + reportGenerationTime + " (hh:mm:ss.mmm).");
    }
    
    reportGenerationTimer.Reset();
    SetAutoTimeOut(1000);
    
    //Check if the report generation has crashed
    if (Get_DlgPrintingStatusMessageLogs().Exists && Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().Exists){
        Get_DlgPrintingStatusMessageLogs_TxtMessageReportError().HoverMouse();
        Delay(1000);
        Log.Error("RAPPORT EN ERREUR. " + reportFileName, reportFileName);
        Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
    }
    
    //Check if there was some reports that contains no data
    if (Get_DlgPrintingStatusMessageLogs().Exists && Get_DlgPrintingStatusMessageLogs_TxtMessageReportNoData().Exists){
        Get_DlgPrintingStatusMessageLogs_TxtMessageReportNoData().HoverMouse();
        Delay(1000);
        Log.Warning("AU MOINS UN RAPPORT NE CONTENAIT AUCUNE DONNÉE. " + reportFileName, reportFileName, pmHigher, null, Sys.Desktop.Picture());
        Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
    }
    RestoreAutoTimeOut();
    
    if (killAcrobatProcessAtEnd === true)
        TerminateAcrobatProcess();
    
    return reportGenerationTime;
}



function CheckUnexpectedDialogBoxes(fromParentObject, maxNbOfChecks)
{
    Delay(800);
    if (fromParentObject != undefined && (!fromParentObject.Exists || fromParentObject.IsActive))
        return;
    
    try {
        if (maxNbOfChecks == undefined)
            maxNbOfChecks = 15;
        var previousAutoTimeOut = Options.Run.Timeout;
        SetAutoTimeOut(500);
        var nbOfChecks = 0;
        do {
            var isDialogBoxDisplayed = false;
            
            if (Get_DlgInformation().Exists && Get_DlgInformation().IsActive){
                Log.Error("La boîte de dialogue 'Information' s'est affichée.");
                Get_DlgInformation().Keys("[Enter]");
                isDialogBoxDisplayed = true;
            }
            
            if (fromParentObject != undefined && (!fromParentObject.Exists || fromParentObject.IsActive))
                break;
            
            if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive){
                Log.Error("La boîte de dialogue 'Avertissement' s'est affichée.");
                Get_DlgWarning().Keys("[Enter]");
                isDialogBoxDisplayed = true;
            }
            
            if (fromParentObject != undefined && (!fromParentObject.Exists || fromParentObject.IsActive))
                break;
            
            if (Get_DlgError().Exists && Get_DlgError().IsActive){
                Log.Error("La boîte de dialogue 'Erreur' s'est affichée.");
                Get_DlgError().Keys("[Enter]");
                isDialogBoxDisplayed = true;
            }
            
            if (fromParentObject != undefined && (!fromParentObject.Exists || fromParentObject.IsActive))
                break;
            
            if (Get_DlgCroesus().Exists && Get_DlgCroesus().IsActive){
                Log.Error("La boîte de dialogue 'Croesus' s'est affichée.");
                Get_DlgCroesus().Keys("[Enter]");
                isDialogBoxDisplayed = true;
            }
            
            if (fromParentObject != undefined && (!fromParentObject.Exists || fromParentObject.IsActive))
                break;
         
        } while (isDialogBoxDisplayed && ++nbOfChecks < maxNbOfChecks)
    }
    catch(exceptionFromCheckUnexpectedDialogBox) {
        Log.Error("Exception from : function CheckUnexpectedDialogBox()", exceptionFromCheckUnexpectedDialogBox.message);
        exceptionFromCheckUnexpectedDialogBox = null;
    }
    finally {
        SetAutoTimeOut(previousAutoTimeOut);
    }
}



function SaveDataInExcelSheet(filePath, sheetName, rowID, dataToSave)
{
    //Récupérer le numéro de la colonne où écrire
    if (typeof DATA_PERFORMANCE_COLUMN_NUM == "undefined" || DATA_PERFORMANCE_COLUMN_NUM === null){
        CloseExcel();
        if (0 != aqFile.SetFileAttributes(filePath, 128))
            Log.Error("Il y a eu erreur lors de la modification d'attributs du fichier : " + filePath);
        var excelApp = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("EXCEL", 30000);
        excelApp.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();
        DATA_PERFORMANCE_COLUMN_NUM = excelApp.ActiveSheet.UsedRange.Columns.Count + 1;
        excelApp.Quit();
        CloseExcel();
        WriteExcelSheet(filePath, sheetName, 1, DATA_PERFORMANCE_COLUMN_NUM, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S"));
    }
    
    //Récupérer le numéro de la ligne où écrire
    var searchedRowNum = FindExcelRow(filePath, sheetName, rowID, false);
    CloseExcel();
    if (searchedRowNum === null){
        var excelApp = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("EXCEL", 30000);
        excelApp.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();
        searchedRowNum = excelApp.ActiveSheet.UsedRange.Rows.Count + 1;
        excelApp.Quit();
        CloseExcel();
        WriteExcelSheet(filePath, sheetName, searchedRowNum, 3, rowID);
    }
    
    //Écrire la donnée à sauvegarder
    WriteExcelSheet(filePath, sheetName, searchedRowNum, DATA_PERFORMANCE_COLUMN_NUM, dataToSave);
}



/**
    Cette fonction réalise une reconnaissance de texte (OCR) dans une image, via l'application Microsoft OneNote
    Paramètres :
        pictureObj : objet correspondant à l'image (exemple : méthode Picture() sur un composant visible à l'écran)
        resizeFactor : facultatif, nombre qui permet de redimensionner l'image préalablement à la conversion
*/
function GetOcrTextFromPicture(pictureObj, resizeFactor)
{
    var retrievedText = null;
    
    try {
        //Redimensionner au besoin l'image
        if (resizeFactor != undefined){
            Log.Message("GetOcrTextFromPicture Through Microsoft OneNote (picture resizeFactor = " + resizeFactor + ").");
            var newWidth = pictureObj.Size.Width * resizeFactor;
            var newHeight = pictureObj.Size.Height * resizeFactor;
            pictureObj.Stretch(newWidth, newHeight, true);
        }
        else {
            Log.Message("GetOcrTextFromPicture Through Microsoft OneNote.");
        }
    
        TerminateProcess("ONENOTE");
    	TerminateProcess("ONENOTEM");    
    
        //Coller le contenu du presse-papier dans une petite fenêtre de OneNote et en copier le texte de l'image
        var OneNoteRegistryKey = Storages.Registry("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\ONENOTE.EXE", HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
        var OneNotePath = OneNoteRegistryKey.GetOption("Path", "C:\\Program Files (x86)\\Microsoft Office\\Office15\\") + "ONENOTE.EXE";
        
        pictureObj.SaveToClipboard();
        WshShell.Run('"' + OneNotePath + '" /sidenote /paste');
        var OneNoteProcess = Sys.WaitProcess("ONENOTE", 10000);
        if (OneNoteProcess.Exists){
            var OneNoteFrameWindow = OneNoteProcess.WaitWindow("Framework::CFrame", "* OneNote", 1, 3000);
            if (!OneNoteFrameWindow.Exists){
                var OneNoteWindow = OneNoteProcess.WaitWindow("*", "*", 1, 3000);
                if (OneNoteWindow.Exists){
                    OneNoteWindow.Keys("[Enter]");
                    OneNoteFrameWindow = OneNoteProcess.WaitWindow("Framework::CFrame", "* OneNote", 1, 10000);
                }
            }
        
            if (OneNoteFrameWindow.Exists){
                OneNoteFrameWindow.SetFocus();
                OneNoteFrameWindow.Keys("[Up][Apps][Down][Down][Enter]");
        
                //Attendre que le presse-papier soit mis à jour et en récupérer le contenu
                var nbOfTries = 0;
                while (nbOfTries < 30){
                    nbOfTries++;
            		retrievedText = Sys.Clipboard;
                    if (GetVarType(retrievedText) == varOleStr){
                        break;
                    }
                
                    retrievedText = null;
                    Delay(200);
                }
            }
        }
    }
    catch(excOCR) {
        Log.Error("GetOcrTextFromPicture() exception: " + excOCR.message, VarToStr(excOCR.stack));
        excOCR = null;
    }
    finally {
        if (retrievedText === null){
            Log.Error("GetOcrTextFromPicture: no text retrieved, some issue may have occurred.");
        }
        TerminateProcess("ONENOTE");
    	TerminateProcess("ONENOTEM");
    }
    
    if (retrievedText === null){
        throw new Error("No text retrieved through GetOcrTextFromPicture().");
    }
    
    if (retrievedText === ""){
        Log.Message("GetOcrTextFromPicture: the retrieved text is empty.");
    }
    else {
        Log.Message("GetOcrTextFromPicture: some text is retrieved, it is logged in the Details panel.", retrievedText);
    }
    
    return retrievedText;
}



function FindFileInFolder(folderName, reportName)
{ 
    foundFiles = aqFileSystem.FindFiles([folderName], [reportName]);
    if (foundFiles != null)
        while (foundFiles.HasNext()){
            aFile = foundFiles.Next();
            Log.Checkpoint("The file was found");
        }
    else
        Log.Error("No files were found.");
}



function SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message, doNotCorrectFileNameLanguageSuffix)
{
    if (doNotCorrectFileNameLanguageSuffix == undefined)
        doNotCorrectFileNameLanguageSuffix = false;
    
    //Choisir le bon currency et le bon reportLanguage lorsqu'on veut produire le rapport en une seule langue
    if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE && !doNotCorrectFileNameLanguageSuffix){
        if (CR1485_REPORTS_LANGUAGE == "english"){
            if (currency != undefined) currency = "USD";
            if (reportLanguage != undefined) reportLanguage = "English (Canada)";
        }
        else if (CR1485_REPORTS_LANGUAGE == "french"){
            if (currency != undefined) currency = "CAD";
            if (reportLanguage != undefined) reportLanguage = "Français (Canada)";
        }
    }
    
    if (destination != undefined && Get_WinReports_GrpOptions_CmbDestination().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbDestination(), destination);
    
    if (sortBy != undefined && Get_WinReports_GrpOptions_CmbSortBy().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSortBy(), sortBy);
    
    if (currency != undefined && Get_WinReports_GrpOptions_CmbCurrency().Exists && Get_WinReports_GrpOptions_CmbCurrency().IsEnabled)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbCurrency(), currency);
    
    if (reportLanguage != undefined && client != "US" && Get_WinReports_GrpOptions_CmbLanguage().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbLanguage(), reportLanguage);
    
    if (checkAddBranchAddress != undefined && Get_WinReports_GrpOptions_ChkAddBranchAddress().Exists && Get_WinReports_GrpOptions_ChkAddBranchAddress().IsEnabled)
        Get_WinReports_GrpOptions_ChkAddBranchAddress().set_IsChecked(aqString.ToUpper(checkAddBranchAddress) == "VRAI" || aqString.ToUpper(checkAddBranchAddress) == "TRUE");
    
    if (checkGroupInTheSameReport != undefined && Get_WinReports_GrpOptions_ChkGroupInTheSameReport().Exists && Get_WinReports_GrpOptions_ChkGroupInTheSameReport().IsEnabled)
        Get_WinReports_GrpOptions_ChkGroupInTheSameReport().set_IsChecked(aqString.ToUpper(checkGroupInTheSameReport) == "VRAI" || aqString.ToUpper(checkGroupInTheSameReport) == "TRUE");
    
    if (checkConsolidatePositions != undefined && Get_WinReports_GrpOptions_ChkConsolidatePositions().Exists && Get_WinReports_GrpOptions_ChkConsolidatePositions().IsEnabled)
        Get_WinReports_GrpOptions_ChkConsolidatePositions().set_IsChecked(aqString.ToUpper(checkConsolidatePositions) == "VRAI" || aqString.ToUpper(checkConsolidatePositions) == "TRUE");
    
    if (checkGroupUnderlyingClients != undefined && Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().Exists && Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().IsEnabled)
        Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().set_IsChecked(aqString.ToUpper(checkGroupUnderlyingClients) == "VRAI" || aqString.ToUpper(checkGroupUnderlyingClients) == "TRUE");
        
    if (message != undefined && Trim(VarToStr(message)) != "" && Get_WinReports_GrpOptions_GrpMessage_BtnEdit().Exists && Get_WinReports_GrpOptions_GrpMessage_BtnEdit().IsEnabled){
        var nbTries = 0;
        do {
            Get_WinReports_GrpOptions_GrpMessage_BtnEdit().Click();
        } while ((++nbTries) <= 3 && !Get_WinMessage().Exists)
        
        if (client != "US")
            SelectComboBoxItem(Get_WinMessage_CmbLanguage(), reportLanguage);
        
        Get_WinMessage_TxtMessage().set_Text(message);
        Get_WinMessage_BtnOK().Click();
        Get_WinReports().WaitProperty("IsActive", true, 30000);
    }
    
    if (checkIncludeMessage != undefined && Get_WinReports_GrpOptions_GrpMessage().Exists){
        if (Get_WinReports_GrpOptions_GrpMessage_ChkInclude().Exists && Get_WinReports_GrpOptions_GrpMessage_ChkInclude().IsEnabled)
            Get_WinReports_GrpOptions_GrpMessage_ChkInclude().set_IsChecked(aqString.ToUpper(checkIncludeMessage) == "VRAI" || aqString.ToUpper(checkIncludeMessage) == "TRUE");
    }
}



function SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title,checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message, doNotCorrectFileNameLanguageSuffix)
{
    if (doNotCorrectFileNameLanguageSuffix == undefined)
        doNotCorrectFileNameLanguageSuffix = false;
    
    //Choisir le bon currency et le bon reportLanguage lorsqu'on veut produire le rapport en une seule langue
    if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE && !doNotCorrectFileNameLanguageSuffix){
        if (CR1485_REPORTS_LANGUAGE == "english"){
            if (currency != undefined) currency = "USD";
            if (reportLanguage != undefined) reportLanguage = "English (Canada)";
        }
        else if (CR1485_REPORTS_LANGUAGE == "french"){
            if (currency != undefined) currency = "CAD";
            if (reportLanguage != undefined) reportLanguage = "Français (Canada)";
        }
    }
    
    //This Global variable is used in function ValidateReportWithDestinationAsPDFFile, for adding FR ou EN to the PDF file name
    CR1485_REPORTS_LANGUAGE_FOR_DESTINATION_AS_FILE = reportLanguage;
    
    if (destination != undefined && Get_WinReports_GrpOptions_CmbDestination().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbDestination(), destination);

    if (checkArchiveRepport != undefined && Get_WinReports_GrpOptions_ChkArchiveReports().Exists && Get_WinReports_GrpOptions_ChkArchiveReports().IsEnabled)
        Get_WinReports_GrpOptions_ChkArchiveReports().set_IsChecked(aqString.ToUpper(checkArchiveRepport) == "VRAI" || aqString.ToUpper(checkArchiveRepport) == "TRUE");

    if (checkPrintDuplex != undefined && Get_WinReports_GrpOptions_ChkPrintDuplex().Exists && Get_WinReports_GrpOptions_ChkPrintDuplex().IsEnabled)
        Get_WinReports_GrpOptions_ChkPrintDuplex().set_IsChecked(aqString.ToUpper(checkPrintDuplex) == "VRAI" || aqString.ToUpper(checkPrintDuplex) == "TRUE");

    if (sortBy != undefined && Get_WinReports_GrpOptions_CmbSortBy().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSortBy(), sortBy);

    if (currency != undefined && Get_WinReports_GrpOptions_CmbCurrency().Exists && Get_WinReports_GrpOptions_CmbCurrency().IsEnabled)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbCurrency(), currency);

    if (reportLanguage != undefined && client != "US" && Get_WinReports_GrpOptions_CmbLanguage().Exists)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbLanguage(), reportLanguage);
    
    if (source != undefined && Get_WinReports_GrpOptions_CmbSource().Exists && Get_WinReports_GrpOptions_CmbSource().IsEnabled)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSource(), source);
        
    if (accountCriteria != undefined && Get_WinReports_GrpOptions_CmbAccountCriteria().Exists && Get_WinReports_GrpOptions_CmbAccountCriteria().IsVisible)
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbAccountCriteria(), accountCriteria);        

    if (checkRemoveName != undefined && Get_WinReports_GrpHeader_ChkRemoveName().Exists && Get_WinReports_GrpHeader_ChkRemoveName().IsEnabled)
        Get_WinReports_GrpHeader_ChkRemoveName().set_IsChecked(aqString.ToUpper(checkRemoveName) == "VRAI" || aqString.ToUpper(checkRemoveName) == "TRUE");

    if (title != undefined && Trim(VarToStr(title)) != "" && Get_WinReports_GrpHeader_CmbTitle().Exists)
        SelectComboBoxItem(Get_WinReports_GrpHeader_CmbTitle(), title);  
    
        
    if (checkAddBranchAddress != undefined && Get_WinReports_GrpOptions_ChkAddBranchAddress().Exists && Get_WinReports_GrpOptions_ChkAddBranchAddress().IsEnabled)
        Get_WinReports_GrpOptions_ChkAddBranchAddress().set_IsChecked(aqString.ToUpper(checkAddBranchAddress) == "VRAI" || aqString.ToUpper(checkAddBranchAddress) == "TRUE");    
            
    if (checkGroupInTheSameReport != undefined && Get_WinReports_GrpOptions_ChkGroupInTheSameReport().Exists && Get_WinReports_GrpOptions_ChkGroupInTheSameReport().IsEnabled)
        Get_WinReports_GrpOptions_ChkGroupInTheSameReport().set_IsChecked(aqString.ToUpper(checkGroupInTheSameReport) == "VRAI" || aqString.ToUpper(checkGroupInTheSameReport) == "TRUE");
    
    if (checkConsolidatePositions != undefined && Get_WinReports_GrpOptions_ChkConsolidatePositions().Exists && Get_WinReports_GrpOptions_ChkConsolidatePositions().IsEnabled)
        Get_WinReports_GrpOptions_ChkConsolidatePositions().set_IsChecked(aqString.ToUpper(checkConsolidatePositions) == "VRAI" || aqString.ToUpper(checkConsolidatePositions) == "TRUE");
        
    if (checkGroupUnderlyingClients != undefined && Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().Exists && Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().IsEnabled)
        Get_WinReports_GrpOptions_ChkGroupUnderlyingClients().set_IsChecked(aqString.ToUpper(checkGroupUnderlyingClients) == "VRAI" || aqString.ToUpper(checkGroupUnderlyingClients) == "TRUE");
    
    if (checkUsePDFFileNamingConvention != undefined){
        if (Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention().IsChecked.OleValue != (aqString.ToUpper(checkUsePDFFileNamingConvention) == "VRAI" || aqString.ToUpper(checkUsePDFFileNamingConvention) == "TRUE")){
            if (!Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention().WaitProperty("IsEnabled", true, 5000))
                Log.Error("The Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention() component is disabled.");
            Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention().Click();
        }
    }
        
    if (message != undefined && Trim(VarToStr(message)) != "" && Get_WinReports_GrpOptions_GrpMessage_BtnEdit().Exists && Get_WinReports_GrpOptions_GrpMessage_BtnEdit().IsEnabled){
        var nbTries = 0;
        do {
            Get_WinReports_GrpOptions_GrpMessage_BtnEdit().Click();
        } while ((++nbTries) <= 3 && !Get_WinMessage().Exists)
        
        if (client != "US")
            SelectComboBoxItem(Get_WinMessage_CmbLanguage(), reportLanguage);
        
        Get_WinMessage_TxtMessage().set_Text(message);
        Get_WinMessage_BtnOK().Click();
        Get_WinReports().WaitProperty("IsActive", true, 30000);
    }
    
    if (checkIncludeMessage != undefined && Get_WinReports_GrpOptions_GrpMessage().Exists){
        if (Get_WinReports_GrpOptions_GrpMessage_ChkInclude().Exists && Get_WinReports_GrpOptions_GrpMessage_ChkInclude().IsEnabled)
            Get_WinReports_GrpOptions_GrpMessage_ChkInclude().set_IsChecked(aqString.ToUpper(checkIncludeMessage) == "VRAI" || aqString.ToUpper(checkIncludeMessage) == "TRUE");
    }
}

/**
    Description : Permet d'attendre qu'un object disparaisse avant de poursuivre l'exécution du script,
                  Cette fonction vérifie, par le truchement de la propriété "VisibleOnScreen", si le composant est visible à l'écran.
                  Si pour une raison ou une autre, "VisibleOnScreen" est utilisée comme propriété indentificatrice,
                  alors la valeur désirée pour "VisibleOnScreen" fournie dans les paramètres a préséance.
    Paramètres :
        - parentObject : référence de l'objet parent dans lequel la recherche de l'objet cible est effectuée
        - properties : nom(s) du ou des propriétés dont les valeurs seront recherchées (string ou tableau de strings)
        - propertiesValues : valeur des propriétés de l'objet recherché (types variés ou tableau de types variés)
        - maxWaitTime : temps maximum d'attente, en millisecondes (facultatif, valeur par défaut : 30000)
    Résultat : Affichage de message indiquant le temps d'attente
               - true si l'objet a disparu
               - false si l'objet n'a pas disparu
    Auteur : Christophe Paring
*/
function WaitUntilObjectDisappears(parentObject, properties, propertiesValues, maxWaitTime, showWaitTime)
{
    
    Log.CallStackSettings.EnableStackOnMessage = true;
    
    if (properties != undefined && GetVarType(properties) != varArray && GetVarType(properties) != varDispatch)
        properties = new Array(properties);
        
    if (propertiesValues != undefined && GetVarType(propertiesValues) != varArray && GetVarType(propertiesValues) != varDispatch)
        propertiesValues = new Array(propertiesValues);
    
    if (GetIndexOfItemInArray(properties, "VisibleOnScreen") == -1){
        properties.push("VisibleOnScreen");
        propertiesValues.push(true);
    }
    
    
    if (maxWaitTime == undefined)
        maxWaitTime = 30000;
    
    var timer = HISUtils.StopWatch;
    var waitTime = 0;
    
    do {
        timer.Start();
        Delay(100);
        var isFound = parentObject.FindChild(properties, propertiesValues, 100).Exists;
        waitTime = timer.Stop();
        
        if (!isFound)
            break;
        
    } while (waitTime < maxWaitTime)
    
    timer.Reset();
    
    if (showWaitTime || showWaitTime == undefined){
      if (isFound)
          Log.Message("Object having properties '" + properties + "=" + propertiesValues + "' did not disappear after " + waitTime + " ms.");
      else
          Log.Message("Object having properties '" + properties + "=" + propertiesValues + "' disappeared after " + waitTime + " ms.");
    }
    
    Log.CallStackSettings.EnableStackOnMessage = false;
    
    return !isFound;
}



function WaitObjectWithPersistenceCheck(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject, maxWaitTimeForWaitUntilObjectDisappears)
{
    return (WaitObject(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject) && !WaitUntilObjectDisappears(parentObject, properties, propertiesValues, maxWaitTimeForWaitUntilObjectDisappears));
}



/**
    Description : Permet d'attendre que la fenêtre des rapports soit affichée avant de poursuivre l'exécution du script
    Paramètre : maxWaitTime (temps maximum de recherche, en millisecondes ; facultatif, valeur par défaut : 120000)
    Résultat : true/false
    Auteur : Christophe Paring
*/
function WaitReportsWindow(maxWaitTime)
{
    if (maxWaitTime == undefined)
        maxWaitTime = 120000;
    
    SetAutoTimeOut(maxWaitTime);
    var isFound = Get_WinReports().Exists;
    RestoreAutoTimeOut();
    if (!isFound) Log.Message("Reports window not displayed by Auto-wait timeout.");
    return isFound;
}



/**
    Description : Permet d'attendre que la fenêtre des paramètres du rapport soit affichée avant de poursuivre l'exécution du script
    Paramètre : maxWaitTime (temps maximum de recherche, en millisecondes ; facultatif, valeur par défaut : 60000)
    Résultat : true/false
    Auteur : Christophe Paring
*/
function WaitReportParametersWindow(maxWaitTime)
{
    if (maxWaitTime == undefined){
        maxWaitTime = (Options.Run.Timeout < 30000)? 30000: Options.Run.Timeout;
    }
    
    var isPerformance = ((aqString.Find(projet, "Performance") == 0) || (aqString.Find(aqFileSystem.GetFileName(ProjectSuite.FileName), "ProjectSuitePerformance") == 0));
    if (!isPerformance){
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    }
    
    SetAutoTimeOut(maxWaitTime);
    var isFound = Get_WinParameters().Exists;
    RestoreAutoTimeOut();
    if (!isFound){
        Log.Message("Report Parameters window not displayed by Auto-wait timeout.");
    }
    
    return isFound;
}



/**
    Description : Sélectionne un ou plusieurs titres
    Paramètre : arrayOfSecuritiesNamesToBeSelected (tableau contenant les noms des titres à sélectionner)
                Attention : il ne doit pas y avoir de doublons dans le tableau arrayOfSecuritiesNamesToBeSelected
    Résultat : Titres sélectionnés
    Auteur : Christophe Paring
*/
function SelectSecurities(arrayOfSecuritiesNamesToBeSelected)
{
    if (arrayOfSecuritiesNamesToBeSelected != undefined && GetVarType(arrayOfSecuritiesNamesToBeSelected) != varArray && GetVarType(arrayOfSecuritiesNamesToBeSelected) != varDispatch)
        arrayOfSecuritiesNamesToBeSelected = new Array(arrayOfSecuritiesNamesToBeSelected);
        
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (var i = 0; i < arrayOfSecuritiesNamesToBeSelected.length; i++){
        var securityNameToBeSelected = arrayOfSecuritiesNamesToBeSelected[i];
        Search_SecurityByDescription(securityNameToBeSelected);
        var objSecurityToBeSelected = Get_SecurityGrid().FindChildEx("Value", securityNameToBeSelected, 10, true, 30000);
        if (objSecurityToBeSelected.Exists)
            objSecurityToBeSelected.Click(-1, -1, skCtrl);
        else
            Log.Error("Security description '" + securityNameToBeSelected + "' not found");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements != arrayOfSecuritiesNamesToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfSecuritiesNamesToBeSelected.length + " securities have been actually selected!");
    
    return (nbOfSelectedElements == arrayOfSecuritiesNamesToBeSelected.length);
}



/**
    Description : Coche un ou plusieurs titres
    Paramètre : arrayOfSecuritiesNamesToBeChecked (tableau contenant les noms des titres à cocher)
                Attention : il ne doit pas y avoir de doublons dans le tableau arrayOfSecuritiesNamesToBeChecked
    Résultat : Titres cochés
    Auteur : Christophe Paring
*/
function CheckSecurities(arrayOfSecuritiesNamesToBeChecked)
{
    if (arrayOfSecuritiesNamesToBeChecked != undefined && GetVarType(arrayOfSecuritiesNamesToBeChecked) != varArray && GetVarType(arrayOfSecuritiesNamesToBeChecked) != varDispatch)
        arrayOfSecuritiesNamesToBeChecked = new Array(arrayOfSecuritiesNamesToBeChecked);
    
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (var i = 0; i < arrayOfSecuritiesNamesToBeChecked.length; i++){
        var securityNameToBeChecked = arrayOfSecuritiesNamesToBeChecked[i];
        
        Search_SecurityByDescription(securityNameToBeChecked);
        var objSecurityToBeChecked = Get_SecurityGrid().FindChildEx("Value", securityNameToBeChecked, 10, true, 30000);
        if (objSecurityToBeChecked.Exists){
            objSecurityToBeChecked.Click();
            objSecurityToBeChecked.Keys(" ");
        }
        else
            Log.Error("Security description '" + securityNameToBeChecked + "' not found");
    }
    
    var nbOfCheckedSecurities = StrToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().Text);
    if (nbOfCheckedSecurities < arrayOfSecuritiesNamesToBeChecked.length)
        Log.Warning("Only " + nbOfCheckedSecurities + " out of " + arrayOfSecuritiesNamesToBeChecked.length + " securities have been actually checked!");
    
    return (nbOfCheckedSecurities == arrayOfSecuritiesNamesToBeChecked.length);
}



/**
    Description : Sélectionne une ou plusieurs relations
    Paramètre : arrayOfRelationshipsNamesToBeSelected (tableau contenant les noms des relations à sélectionner)
    Résultat : Relations sélectionnées
    Auteur : Christophe Paring
*/
function SelectRelationships(arrayOfRelationshipsNamesToBeSelected)
{
    if (arrayOfRelationshipsNamesToBeSelected != undefined && GetVarType(arrayOfRelationshipsNamesToBeSelected) != varArray && GetVarType(arrayOfRelationshipsNamesToBeSelected) != varDispatch)
        arrayOfRelationshipsNamesToBeSelected = new Array(arrayOfRelationshipsNamesToBeSelected);
    
    //Aller au module Relations et enlever toute sélection
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Error("The Relationships data grid is empty.");
        return false;
    }
    
    //Sélectionner les relations désirées
    for (var i in arrayOfRelationshipsNamesToBeSelected){
        SearchRelationshipByName(arrayOfRelationshipsNamesToBeSelected[i]);
        var relationshipsNameCell = Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", arrayOfRelationshipsNamesToBeSelected[i], 10, true, 30000);
        if (relationshipsNameCell.Exists)
            relationshipsNameCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The relationship Name '" + arrayOfRelationshipsNamesToBeSelected[i] + "' cell was not found.");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements != arrayOfRelationshipsNamesToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfRelationshipsNamesToBeSelected.length + " relationships have been selected!");
    
    
    return (nbOfSelectedElements == arrayOfRelationshipsNamesToBeSelected.length);
}



/**
    Description : Sélectionne un ou plusieurs clients
    Paramètre : arrayOfClientsNumbersToBeSelected (tableau contenant les numéros des clients à sélectionner)
    Résultat : Clients sélectionnées
    Auteur : Christophe Paring
*/
function SelectClients(arrayOfClientsNumbersToBeSelected)
{
    if (arrayOfClientsNumbersToBeSelected != undefined && GetVarType(arrayOfClientsNumbersToBeSelected) != varArray && GetVarType(arrayOfClientsNumbersToBeSelected) != varDispatch)
        arrayOfClientsNumbersToBeSelected = new Array(arrayOfClientsNumbersToBeSelected);
    
    //Aller au module Clients et enlever toute sélection
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 150000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Error("The Clients data grid is empty.");
        return false;
    }
    
    //Sélectionner les Clients désirés
    for (var i in arrayOfClientsNumbersToBeSelected){
        Search_Client(arrayOfClientsNumbersToBeSelected[i]);
        var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", arrayOfClientsNumbersToBeSelected[i], 10, true, 30000);
        if (clientNumberCell.Exists)
            clientNumberCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The Client number '" + arrayOfClientsNumbersToBeSelected[i] + "' cell was not found.");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements < arrayOfClientsNumbersToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfClientsNumbersToBeSelected.length + " clients have been selected!");
    
    return (nbOfSelectedElements == arrayOfClientsNumbersToBeSelected.length);
}



/**
    Description : Sélectionne un ou plusieurs comptes
    Paramètre : arrayOfAccountsNumbersToBeSelected (tableau contenant les numéros de comptes à sélectionner)
    Résultat : Comptes sélectionnés
    Auteur : Christophe Paring
*/
function SelectAccounts(arrayOfAccountsNumbersToBeSelected)
{
    if (arrayOfAccountsNumbersToBeSelected != undefined && GetVarType(arrayOfAccountsNumbersToBeSelected) != varArray && GetVarType(arrayOfAccountsNumbersToBeSelected) != varDispatch)
        arrayOfAccountsNumbersToBeSelected = new Array(arrayOfAccountsNumbersToBeSelected);
    
    //Aller au module Comptes et enlever toute sélection
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Error("The Accounts data grid is empty.");
        return false;
    }
    
    //Sélectionner les comptes désirés
    for (var i in arrayOfAccountsNumbersToBeSelected){
        SearchAccount(arrayOfAccountsNumbersToBeSelected[i]);
        var accountNumberCell = Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", arrayOfAccountsNumbersToBeSelected[i], 10, true, 30000);
        if (accountNumberCell.Exists)
            accountNumberCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The Account number '" + arrayOfAccountsNumbersToBeSelected[i] + "' cell was not found.");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements < arrayOfAccountsNumbersToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfAccountsNumbersToBeSelected.length + " accounts have been selected!");
    
    return (nbOfSelectedElements == arrayOfAccountsNumbersToBeSelected.length);
}



/**
    Description : Sélectionne un certain nombre de comptes
    Paramètre : nbOfAccountsToBeSelected (Nombre de comptes à sélectionner)
    Résultat : Comptes sélectionnés
    Auteur : Christophe Paring
*/
function SelectNbOfAccounts(nbOfAccountsToBeSelected)
{
    Log.Message("Select " + nbOfAccountsToBeSelected + " accounts.")

    Get_ModulesBar_BtnAccounts().Click();
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 50, 55);
    Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(false);
    
    Get_Toolbar_BtnSum().Click();
    accountsTotalCount = Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountAcc();
    Log.Message("The Accounts total count is : " + accountsTotalCount);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    Sys.Desktop.KeyDown(0x11); //Press Ctrl
    nbOfSelectedAccounts = 0;
    arrayOfAllAccountsNumbers = new Array();
    
    while (arrayOfAllAccountsNumbers.length < accountsTotalCount){
        accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (i = 0; i < accountsPageCount; i++){
            displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            isFound = false;
            for (j = 0; j < arrayOfAllAccountsNumbers.length; j++){
                if (displayedAccountNumber == arrayOfAllAccountsNumbers[j]){ 
                    isFound = true;
                    break;
                }
            }
			
            if (!isFound){
                arrayOfAllAccountsNumbers.push(displayedAccountNumber);
                Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                nbOfSelectedAccounts ++;
			}
            
            if (nbOfSelectedAccounts == nbOfAccountsToBeSelected)
                break;
        }
        
        if (nbOfSelectedAccounts == nbOfAccountsToBeSelected)
            break;

        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
    
    }
    
    Sys.Desktop.KeyUp(0x11); //Release Ctrl
    
    if (nbOfSelectedAccounts < nbOfAccountsToBeSelected)
        Log.Warning("Only " + nbOfSelectedAccounts + " out of " + nbOfAccountsToBeSelected + " accounts have been selected!");
}


/**
    Description : Sélectionne un ou plusieurs ordres
    Paramètre : arrayOfOrdersToBeSelected (tableau contenant les symboles des ordres à sélectionner)
    Résultat : Ordres sélectionnés
    Auteur : Philippe Maurice
*/

function SelectOrders(arrayOfOrdersToBeSelected)
{
    if (arrayOfOrdersToBeSelected != undefined && GetVarType(arrayOfOrdersToBeSelected) != varArray && GetVarType(arrayOfOrdersToBeSelected) != varDispatch)
        arrayOfOrdersToBeSelected = new Array(arrayOfOrdersToBeSelected);
    
    Get_ModulesBar_BtnOrders().Click();
    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (var i = 0; i < arrayOfOrdersToBeSelected.length; i++) {
        var orderToBeSelected = arrayOfOrdersToBeSelected[i];
        Search_Order_Symbol(orderToBeSelected);
        
        var objOrderToBeSelected = Get_OrderGrid().FindChildEx("Value", orderToBeSelected, 10, true, 30000);
        
        if (objOrderToBeSelected.Exists)
            objOrderToBeSelected.Click(-1, -1, skCtrl);
        else
            Log.Error("Order Symbol '" + orderToBeSelected + "' not found");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    
    if (nbOfSelectedElements != arrayOfOrdersToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfOrdersToBeSelected.length + " order have been actually selected!");
    
    return (nbOfSelectedElements == arrayOfOrdersToBeSelected.length);
}


/**
    Description : Récupère le nom d'hôte utilisé pour se connecter au VServeur via SSH
    Paramètre : URL du VServeur
    Résultat : Nom d'hôte du Vserveur
    Auteur : Christophe Paring
*/
function GetVserverHostName(vServerURL)
{
    //Log.Message("VServer URL is : " + vServerURL);
    var hostname = aqString.Replace(aqString.Replace(aqString.Replace(vServerURL, ".croesus.local", "", false), "http://", "", false), "/", "", false);
    //Log.Message("VServer host name is : " + hostname);
    return hostname;
}



/**
    Description : Crée un fichier et y écrit le texte spécifié ;
                  si le fichier existe, il est écrasé.
    Paramètres : 
        - filePath : chemin d'accès du fichier
        - text : chaîne de caractères à écrire dans le fichier
    Résultat : Fichier créé et texte écrit.
               Affichage d'un message indiquant si l'opération a réussi
    Auteur : Christophe Paring
*/
function CreateFileAndWriteText(filePath, text)
{
    Log.Message("Create the file : " + filePath + ", and write the following text to it :", text);
    var isCreateFileAndWriteTextSuccessfull = aqFile.WriteToTextFile(filePath, text, aqFile.ctANSI, true);
    
    if (isCreateFileAndWriteTextSuccessfull)
        Log.Message("File created and text written to it successfully.");
    else
        Log.Error("Failed to create file and write text to it.");
    
    return isCreateFileAndWriteTextSuccessfull;
}



/**
    Description : Exécute un fichier batch.
                  Pour utiliser l'utilitaire PLINK (permettant d'exécuter des scripts Shell Linux),
                  il faut que le fichier PLINK.EXE soit présent dans le même dossier que le fichier batch.
                  ATTENTION: Besoin des droits d'admin pour ce script. Il ne peut donc être exécuté que sur les VM et non sur les poste de travail personnels.
    Paramètres : batchFilePath (Chemin d'accès du fichier batch)
    Résultat : Fichier batch exécuté
    Auteur : Christophe Paring
*/
function ExecuteBatchFile(batchFilePath)
{
    Log.Message("Execute batch file : " + batchFilePath);
    
    var defaultCurrentFolder = aqFileSystem.GetCurrentFolder();
    var batchFileFolderPath = aqFileSystem.GetFileInfo(batchFilePath).ParentFolder.Path;
    
    //Log.Message("Set current folder to : " + batchFileFolderPath);
    aqFileSystem.SetCurrentFolder(batchFileFolderPath);
    
    batchFilePath = "\"" + batchFilePath + "\"";
    
    //Log.Message("Execute file : " + batchFilePath);
    var shellObj = (isJavaScript())? getActiveXObject("WScript.Shell"): Sys.OleObject("WScript.Shell");
    shellObj.Run(batchFilePath, 1, true);
    //2eme paramètre de Run : 0 = n'affiche pas de fenêtre DOS ; 1 = affiche une fenêtre DOS (défaut)
    //3eme paramètre de Run : true = attend la fin de l'exécution ; false = n'attend pas la fin de l'exécution (défaut)
    
    //Log.Message("Set current folder back to : " + defaultCurrentFolder);
    aqFileSystem.SetCurrentFolder(defaultCurrentFolder);
}



/**
    Description : Démarrer une nouvelle console de ligne de commande
    Résultat : Objet correspondant au processus de la nouvelle console démarrée
*/
function LaunchAndGetCommandLineProcess()
{
    //Trouver l'index du prochain processus de la ligne de commande
    Sys.Refresh();
    var commandLineNewProcessIndex = Sys.FindAllChildren("ProcessName", "cmd").toArray().length + 1;
    
    //Démarrer une nouvelle console de ligne de commande
    if (0 != WshShell.Run("cmd", 3, false)){
        Log.Error("Issue encountered when trying to open a new Command line shell.");
        return Utils.CreateStubObject();
    }
    
    return Sys.Process("cmd", commandLineNewProcessIndex);
}

/**
    Description : Vérifier si le service est en cours d'exécution
    Paramètres :
            - vServerURL : le vserveur sur lequel on veut vérifier l'état de son service
            - serviceName : le nom de service qu'on veut vérifier s'il est en cours d'exécution            
*/
function IsServiceRunning(vServerURL, serviceName)
{
    var hostname = GetVserverHostName(vServerURL);
    Log.Message("Check if " + hostname + " '" + serviceName + "' service is running...");
    var isRunning = null;
    var outputSSH = ExecuteSSHCommand(null, vServerURL, "service " + serviceName + " status", null, "^\(not\\b\)?\(running\)$", false);
    switch (outputSSH){
        case "running": 
            isRunning = true;
            Log.Message(hostname + " '" + serviceName + "' service is running.");
            break;
        
        case "not running": 
            isRunning = false;
            Log.Message(hostname + " '" + serviceName + "' service is not running.");
            break;
        
        default: 
            isRunning = null;
            Log.Error("Unable to determine if " + hostname + " '" + serviceName + "' service is running or not.");
            break;
    }
    
    return isRunning;
}

/**
    Description : Démarrer le service
    Paramètres :
            - vServerURL : le vserveur sur lequel on veut démarrer le service
            - serviceName : le nom de service à démarrer            
*/
function StartService(vServerURL, serviceName)
{
    Log.Message("Start " + GetVserverHostName(vServerURL) + " '" + serviceName + "' service...");
    ExecuteSSHCommand(null, vServerURL, "service " + serviceName + " start", null, "^Starting\\b.*$", false);
    return (IsServiceRunning(vServerURL, serviceName));
}

/**
    Description : arrêter le service
    Paramètres :
            - vServerURL : le vserveur sur lequel on veut arrêter le service
            - serviceName : le nom de service à arrêter            
*/
function StopService(vServerURL, serviceName)
{
    Log.Message("Stop " + GetVserverHostName(vServerURL) + " '" + serviceName + "' service...");
    ExecuteSSHCommand(null, vServerURL, "service " + serviceName + " stop", null, "^Stopping\\b.*$", false);
    var isRunning = IsServiceRunning(vServerURL, serviceName);
    var isStopped = (isRunning === null)? null: (!isRunning);
    return isStopped;
}


/**
    Description : Remplace chaque caractère d'une chaîne de caractères par : "[Alt" + Code ASCII du caractère + "]"
*/
function MapStringCharsToCharsCodesEquivalent(stringVar)
{
	var mappedString = "";
    for (var i = 0; i < stringVar.length; i++)
        mappedString += "[Alt" + stringVar.charCodeAt(i) + "]";
    return mappedString;
}



/**
    Description : Remplace chaque caractère d'une chaîne de caractères par : "%" + Code ASCII Hexadecimal du caractère
*/
function GetPercentEncodedString(stringVar)
{
	var percentEncodedString = "";
    for (var i = 0; i < stringVar.length; i++)
        percentEncodedString += "%" + aqString.Format("%02x", stringVar.charCodeAt(i));
    return percentEncodedString;
}


/**
    Description : Ajoute le catactères Escape Batch approprié avant certains caractères spécifiques d'une chaîne de caractères.
*/
function GetBatchEscapedCharsString(varString)
{
    varString = aqString.Replace(varString, "%", "%%");
    var escapedChars = ["^", "&", "<", ">", "|", "\\"];
    var varStringArray = varString.split("");
    for (var i in varStringArray)
        if (GetIndexOfItemInArray(escapedChars, varStringArray[i]) != -1)
            varStringArray[i] = "^" + varStringArray[i];
    
    return varStringArray.join("");
}


/**
    Description : Exécute une commande SSH pour cfLoader
    Paramètres :
            - CRFolder : le numéro du CR qui va servir de dossier pour exécuter la commande
            - vserverCommand : le vserveur sur lequel exécuter la commande
            - sshCommand : la commande SSH à exécuter
            - username : le nom de user utilisé comme dossier
    Auteur : Antoine Gélinas
*/
function ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand, username)
{
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash" + "\r\n" + 
                "mkdir -p " + CRFolder + "\r\n" + 
                "cd /home/" + username + "/loader/" + CRFolder + "\r\n" +
                sshCommand;
    
    SSHCmdFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.ParentFolder.Path + "ProjectSuitesCommonScripts\\ssh_script_" + CRFolder + ".txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);

    //Create PLINK batch file
    hostname = GetVserverHostName(vserverCommand);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_" + CRFolder + ".txt > ssh_script_output_" + CRFolder + ".txt";
    plinkBatchFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.ParentFolder.Path + "ProjectSuitesCommonScripts\\plink_" + CRFolder + ".bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
  
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}


/**
    Description : Exécute une commande SSH
    Paramètres :
            - CRFolderOrSSHCommandId : le numéro du CR qui va servir de dossier pour exécuter la commande (ou Chaîne de caractères pour identifier la ou les commande(s) SSH)
            - vServerURL : le vserveur sur lequel exécuter la commande
            - sshCommand : la commande SSH à exécuter
            - username : le nom de user utilisé comme dossier sur le vserver
    Auteur : Christophe Paring
*/
function ExecuteSSHCommand(CRFolderOrSSHCommandId, vServerURL, sshCommand, username, outputSuccessRegEx, activateCfLoaderLog)
{
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var executionDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
    var filesRootName = (CRFolderOrSSHCommandId != undefined)? CRFolderOrSSHCommandId: "ExecuteSSHCommand" + executionDateTimeString;
    
    var executionSSHCommands = "#!/bin/bash" + "\r\n";
    if (activateCfLoaderLog == undefined || activateCfLoaderLog)
        executionSSHCommands += "if [ -f '/home/tools/LOG_cfLoader.sh' ]; then sh /home/tools/LOG_cfLoader.sh; fi" + "\r\n" + "\r\n";
    
    if (CRFolderOrSSHCommandId != undefined && username != undefined){
        var filesRootName = CRFolderOrSSHCommandId + executionDateTimeString;
        var vserverFolder = "/home/" + username + "/loader/" + CRFolderOrSSHCommandId + "/";
        executionSSHCommands += "mkdir -p " + vserverFolder + "\r\n";
        executionSSHCommands += "cd " + vserverFolder + "\r\n\r\n";
    }
    
    executionSSHCommands += sshCommand + "\r\n";
    
    Log.Message("ExecuteSSHCommand() on " + hostname + " : " + sshCommand, executionSSHCommands);
    
    var SSHCmdFileName = filesRootName + ".sh";
    var SSHCmdFilePath =  folderPath_ProjectSuiteCommonScripts + SSHCmdFileName;
    var localOutputFileName = filesRootName + "_Output.txt";
    var localOutputFilePath =  folderPath_ProjectSuiteCommonScripts + localOutputFileName;
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + filesRootName + "_Plink.bat";
    
    //Cleanup existing Files
    if (aqFileSystem.Exists(SSHCmdFilePath))
        aqFileSystem.DeleteFile(SSHCmdFilePath);
    
    if (aqFileSystem.Exists(plinkBatchFilePath))
        aqFileSystem.DeleteFile(plinkBatchFilePath);
    
    if (aqFileSystem.Exists(localOutputFilePath))
        aqFileSystem.DeleteFile(localOutputFilePath);
    
    //Create SSH file
    if (!aqFile.WriteToTextFile(SSHCmdFilePath, executionSSHCommands, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + SSHCmdFilePath, executionSSHCommands);
    
    //Create and Execute Plink batch file
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > " + localOutputFileName;
    if (!aqFile.WriteToTextFile(plinkBatchFilePath, batchCmdLine, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + plinkBatchFilePath, batchCmdLine);
    
    ExecuteBatchFile(plinkBatchFilePath);
    
    //Récupérer le Output
    if (!aqFileSystem.Exists(localOutputFilePath)){
        Log.Error("Local Output file not found : " + localOutputFilePath, localOutputFilePath);
        return null;
    }
    
    var localOutputFileContent = Trim(aqFile.ReadWholeTextFile(localOutputFilePath, aqFile.ctUTF8));
    Log.Message("ExecuteSSHCommand() Output for : " + sshCommand, localOutputFileContent);
    
    if (outputSuccessRegEx != undefined){
        if (aqString.StrMatches(outputSuccessRegEx, localOutputFileContent)){
            Log.CallStackSettings.EnableStackOnCheckpoint = true;
            Log.Checkpoint("Success. Regular Expression matched in the SSH command execution output.", "Regular Expression is : \r\n\r\n" + outputSuccessRegEx);
            Log.CallStackSettings.EnableStackOnCheckpoint = false;
        }
        else {
            Log.Error("Regular Expression not matched in the SSH command execution output.", "Regular Expression is : \r\n\r\n" + outputSuccessRegEx);
        }
    }
    
    return localOutputFileContent;
}



/**
    Description : Exécute les commandes SSH d'un fichier
    Paramètres :
            - CRFolderOrSSHCommandId : le numéro du CR qui va servir de dossier pour exécuter la commande (ou Chaîne de caractères pour identifier la ou les commande(s) SSH)
            - vServerURL : le vserveur sur lequel exécuter la commande
            - sshCommandsFile : Chemin d'accès du fichier contenant les commandes SSH à exécuter
            - username : le nom de user utilisé comme dossier sur le vserver
    Auteur : Christophe Paring
*/
function ExecuteSSHCommandsFile(CRFolderOrSSHCommandId, vServerURL, sshCommandsFile, username, outputSuccessRegEx, activateCfLoaderLog)
{
    Log.Message("Execute SSH commands from file : " + sshCommandsFile + ", on vServer : " + vServerURL);
    
    if (!aqFileSystem.Exists(sshCommandsFile)){
        Log.Error("File not found : " + sshCommandsFile, sshCommandsFile);
        return null;
    }
    
    var sshCommandsFromFile = aqFile.ReadWholeTextFile(sshCommandsFile, aqFile.ctUTF8);
    return ExecuteSSHCommand(CRFolderOrSSHCommandId, vServerURL, sshCommandsFromFile, username, outputSuccessRegEx, activateCfLoaderLog);
}



/**
    Description : Saisit une date dans un champ Date/Heure.
    Paramètres :
            - DateTimePickerObject : référence du composant Date/Heure
            - DateString : la chaîne de caractères représentant la date
            (exemple : "2009/12/31" en Français ou bien "12/31/2009" en Anglais)
    Résultat : Date saisie dans le champ
    Auteur : Christophe Paring
*/
function SetDateInDateTimePicker(DateTimePickerObject, DateString)
{
    //La condition if suivante a été commentée par suite de la possible 
    //exposition du composant DateField à l'intérieur du DateTimePicker
    //A maintenir possiblement
    //if (DateString == DateTimePickerObject.StringValue)
    //    return;
    
    if (DateTimePickerObject.IsReadOnly){
        Log.Error("The Date Time Picker is disabled!");
        return;
    } 
    
    DateTimePickerObject.Click();
    Sys.Keys("[End][BS][BS][BS][BS][BS][BS][BS][BS]");
    Sys.Keys(DateString + "[Tab]");
}



/**
    Description : Sélectionner un élément dans la liste d'un ComboBox.
    Paramètres :
            - ComboBoxObject : référence du composant ComboBox
            - ItemString : la chaîne de caractères de l'élément à sélectionner
    Résultat : Élément du ComboBox sélectionné
    Auteur : Christophe Paring
*/
function SelectComboBoxItem(ComboBoxObject, ItemString)
{
    Log.Message("Select the combobox item : '" + ItemString + "'");
    
    if (!ComboBoxObject.Exists){
        Log.Error("The combobox component does not exist!");
        return;
    }
    
    if (!ComboBoxObject.IsVisible){
        Log.Error("The combobox component is not visible!");
        return;
    }
    
    if (!ComboBoxObject.IsEnabled){
        if (ComboBoxObject.Text == ItemString)
            Log.Message("The combobox component is disabled and the selected value is '" + ItemString + "'");
        else
            Log.Error("The combobox component is disabled!");
        
        return;
    }
    
    ComboBoxObject.set_Text(ItemString);
    Delay(50);
    ComboBoxObject.Keys("[Tab]");
    Delay(50);
    
    if (ComboBoxObject.SelectedIndex == -1 || ComboBoxObject.SelectedValue == null)
        Log.Error("Unable to select the ComboBox Item '" + ItemString + "'.");
    else if (ComboBoxObject.Text != ItemString)
        Log.Error("The combobox component selected value is '" + ComboBoxObject.Text + "', expecting '" + ItemString + "'.");
}



/**
    Description : Recherche une valeur dans un tableau
    Paramètres :
        - arr : tableau (Array) dans lequel la recherche est effectuée
        - item : valeur recherchée (types variés)
        - verifyItemType : spécifie si le type de la valeur doit être vérifié (facultatif, valeur par défaut : false)
        - fromIndex : index à partir duquel la recherche est effectuée (facultatif, valeur par défaut : 0) 
    Résultat : Index de la valeur recherchée, -1 si la valeur n'a pas été trouvée
    Auteur : Christophe Paring
*/
function GetIndexOfItemInArray(arr, item, verifyItemType, fromIndex)
{
    if (arr == undefined || (GetVarType(arr) != varArray && GetVarType(arr) != varDispatch)){
        Log.Error("The first parameter should be an Array!");
        return -1;
    }
    
    if (arr.length == 0)
        return -1;
    
    if (verifyItemType == undefined)
        verifyItemType = false;
        
    if (fromIndex == undefined)
        fromIndex = 0;
    
    if (fromIndex >= arr.length){
        Log.Error("The fromIndex is greater than the array maximum index!");
        return -1;
    }
    
    for (arrIndex = fromIndex; arrIndex < arr.length; arrIndex++)
        if (verifyItemType){
            if (arr[arrIndex] === item)
                return arrIndex;
        }
        else {
            if (arr[arrIndex] == item)
                return arrIndex;
        }
    
    return -1;
}



/**
    Description : Recherche des valeurs dans un fichier CSV
    Paramètres :
        - CSVFilePath : chemin d'accès du fichier CSV
        - arrayOfColumnsNames : nom(s) des colonnes dans lesquelles la recherche sera effectuée (string ou tableau de strings)
        - arrayOfSearchValues : valeur(s) recherchées (types variés ou tableau)
        - delimiterChar : caractère de délimitation des données dans le fichier CSV (facultatif, valeur par défaut : "TAB")
                        valeurs possibles : "TAB" (pour tabulation), "\t" (pour tabulation), "CSV" (pour ","), ou tout autre caractère de délimitation utilisé. 
    Résultat : Boolean (true si les valeurs recherchées ont été trouvées, false sinon)
    Auteur : Christophe Paring
*/
function SearchValuesInCSVFile(CSVFilePath, arrayOfColumnsNames, arrayOfSearchValues, delimiterChar)
{
    if (arrayOfColumnsNames != undefined && GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
    
    if (arrayOfSearchValues != undefined && GetVarType(arrayOfSearchValues) != varArray && GetVarType(arrayOfSearchValues) != varDispatch)
        arrayOfSearchValues = new Array(arrayOfSearchValues);
    
    if (arrayOfColumnsNames.length != arrayOfSearchValues.length){
        Log.Error("The parameters arrayOfColumnsNames and arrayOfSearchValues don't contain the same number of elements.");
        return false;
    }
    
    var ANSIFileName = "ANSIFile.csv";
    var CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    var ANSIFilePath = CSVFilePath.replace(CSVFileName, ANSIFileName);
    
    var CSVFileContent = aqFile.ReadWholeTextFile(CSVFilePath, aqFile.ctANSI);//avant ctUnicode
    CreateFileAndWriteText(ANSIFilePath, CSVFileContent);
    
    if (delimiterChar == undefined || delimiterChar.toUpperCase() == "TAB" || delimiterChar == "\t")
        var CSVFormat = "Format=TabDelimited";
    else if (delimiterChar.toUpperCase() == "CSV" || delimiterChar == ",")
        var CSVFormat = "Format=CSVDelimited";
    else
        var CSVFormat = "Format=Delimited(" + delimiterChar + ")";
    
    var schemaFilePath = CSVFilePath.replace(CSVFileName, "schema.ini");
    var schemaFilelines = "[" + ANSIFileName + "]";
    schemaFilelines += "\r\n" + CSVFormat;
    schemaFilelines += "\r\n" + "CharacterSet=ANSI";
    schemaFilelines += "\r\n" + "ColNameHeader=True";
    CreateFileAndWriteText(schemaFilePath, schemaFilelines);
    
    var Driver = DDT.CSVDriver(ANSIFilePath);
    
    var arrayOfAllColumnsNames = new Array();
    for (var columnIndex = 0; columnIndex < Driver.ColumnCount; columnIndex++)
        arrayOfAllColumnsNames.push(Driver.ColumnName(columnIndex));
    
    var areAllNeededColumnNamesFound = true;
    for (var columnsNamesIndex = 0; columnsNamesIndex < arrayOfColumnsNames.length; columnsNamesIndex++)
        if (GetIndexOfItemInArray(arrayOfAllColumnsNames, arrayOfColumnsNames[columnsNamesIndex]) == -1){
            Log.Error("Column name '" + arrayOfColumnsNames[columnsNamesIndex] + "' was not found.");
            areAllNeededColumnNamesFound = false;
        }
    
    var areSearchValuesFound = false;
    if (areAllNeededColumnNamesFound){
        var rowNo = 0;
        while (! Driver.EOF()) {
            rowNo ++;
            var arrayOfCurrentValues = new Array();
            for (var i = 0; i < arrayOfColumnsNames.length; i++)
                arrayOfCurrentValues.push(Driver.Value(arrayOfColumnsNames[i]));
            
            if (arrayOfCurrentValues.toString() == arrayOfSearchValues.toString()){
                Log.Message("The search values were found at row No : " + rowNo);
                areSearchValuesFound = true;
                break;
            }
        
            Driver.Next();
        }
    
        if (!areSearchValuesFound)
            Log.Message("The search values were not found in the CSV file.");
    }
    
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(ANSIFilePath);
    aqFileSystem.DeleteFile(schemaFilePath);
    
    return areSearchValuesFound;
}



function GetRegionalSettings()
{
    Log.Message("Get User Regional settings.");
    
    var numTry = 0;
    do {
        Delay(5000);
        Get_MenuBar_Tools().Click();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
    Get_WinConfigurations().Parent.Maximize();
    
    Get_WinConfigurations_TvwTreeview_LlbOptions().DblClick();

    //Wait Get_WinConfigurations_LvwListView_LlbMyOptions
    var waitTime = 0;
    var timeOut = 10000;
    do {
        var isFound = (Get_WinConfigurations_LvwListView_LlbMyOptions().Exists && Get_WinConfigurations_LvwListView_LlbMyOptions().VisibleOnScreen && Get_WinConfigurations_LvwListView_LlbMyOptions().IsEnabled);
        if (isFound){
            Delay(1000);
            break;
        }
        Delay(100);
        waitTime += 100;
    } while (waitTime < timeOut)
    
    if (isFound)
        Get_WinConfigurations_LvwListView_LlbMyOptions().DblClick();
    
    if (!Get_WinConfigurations_TvwTreeview_LlbRegionalSettings().Exists)
        Get_WinConfigurations_TvwTreeview_LlbOptions().DblClick();
    
    Get_WinConfigurations_TvwTreeview_LlbRegionalSettings().Click();
    Get_WinConfigurations_TvwTreeview_LlbRegionalSettings().Click();
    
    //Wait Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings
    //Faux positifs parfois dans ce do-while. Erreur: The object does not exist. See Details for additional information.
    //TODO: Revoir la détection de l'option Paramètres régionaux pour s'assurer que le menu ait fini de dérouler.
    var waitTime = 0;
    var timeOut = 10000;
    do {
        var isFound = (Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings().Exists && Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings().VisibleOnScreen && Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings().IsEnabled);
        if (isFound){
            Delay(1000);
            break;
        }
        Delay(100);
        waitTime += 100;
    } while (waitTime < timeOut)
    
    Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings().DblClick();
    
    Get_WinRegionalSettings_TabNumbers().Click();
    Get_WinRegionalSettings_TabNumbers().WaitProperty("IsSelected", true, 60000);
    decimalSymbol = Get_WinRegionalSettings_TabNumbers_CmbDecimalSymbol().Text.OleValue;
    digitGroupingSymbol = Get_WinRegionalSettings_TabNumbers_CmbDigitGroupingSymbol().Text.OleValue;
    negativeNumberFormat = Get_WinRegionalSettings_TabNumbers_CmbNegativeNumberFormat().Text.OleValue;
    isNegativeNumberFormatFinancial = (negativeNumberFormat[0] == "(");
    Get_WinRegionalSettings_TabDate().Click();
    Get_WinRegionalSettings_TabDate().WaitProperty("IsSelected", true, 60000);
    shortDateFormat = Get_WinRegionalSettings_TabDate_GrpShortDate_CmbFormat().Text.OleValue;
    
    Get_WinRegionalSettings_BtnCancel().Click();
    Get_WinConfigurations().Close();
    
    Log.Message("decimalSymbol : " + decimalSymbol);
    Log.Message("digitGroupingSymbol : " + digitGroupingSymbol);
    Log.Message("negativeNumberFormat : " + negativeNumberFormat);
    Log.Message("isNegativeNumberFormatFinancial : " + isNegativeNumberFormatFinancial);
    Log.Message("shortDateFormat : " + shortDateFormat);
}



function ConvertToNumberStandardFormat(numberStr)
{
    var decimalSymbolPos = numberStr.indexOf(decimalSymbol);
    
    if (decimalSymbolPos != -1){
        var integerPart = numberStr.substr(0, decimalSymbolPos);
        var decimalPart = numberStr.substr(decimalSymbolPos + 1);
    }
    else {
        var decimalPart = "";
        var integerPart = numberStr;
    }
    
    if (digitGroupingSymbol == "")
        digitGroupingSymbol = " ";
    
    var newIntegerPart = integerPart.split(digitGroupingSymbol).join(",");
    
    if (decimalSymbolPos != -1)
        var newNumberStr = newIntegerPart + "." + decimalPart;
    else
        var newNumberStr = newIntegerPart;
    
    if (isNegativeNumberFormatFinancial && (newNumberStr[0] == "("))
        newNumberStr = newNumberStr.replace("(", "-").replace(")", "");
    
    return newNumberStr
}



/**
    Au cas où cette fonction ne donnait pas satisfaction, vous pouvez
    voir à utiliser la function CopyFileFromVserverThroughWinSCP()
*/
function CopyFileFromVserver(vServerURL, vserverFilePath, localDestinationFilePath)
{
    Log.Message("Copy remote file from vServer " + vServerURL, "from : " + vserverFilePath + " to : " + localDestinationFilePath);
    
    //Supprimer un éventuel fichier local de même nom
    if (aqFile.Exists(localDestinationFilePath) && !aqFileSystem.DeleteFile(localDestinationFilePath)){
        Log.Error("Unable to delete an existing local file : " + localDestinationFilePath);
        return false;
    }
    
    //Envoyer en fichier de sortie le contenu du fichier à copier (avec récupération du flus d'erreur)
    var errorFilePath = "/tmp/Error_CopyFile.txt";
    var CRFolder = "CopiedFile";
    var sshCommandForNeededFile = "cat -A " + vserverFilePath + " 2> " + errorFilePath;
    ExecuteSSHCommandCFLoader(CRFolder, vServerURL, sshCommandForNeededFile, "userCopyFile");
    var localOutputFilePath =  folderPath_ProjectSuiteCommonScripts + "ssh_script_output_" + CRFolder + ".txt";
    
    //Récupérer le contenu du flux d'erreur
    var CRFolder = "StreamErrorFile";
    var sshCommand = "cat -A " + errorFilePath;
    ExecuteSSHCommandCFLoader(CRFolder, vServerURL, sshCommand, "userCopyFile");
    var errorLocalFilePath =  folderPath_ProjectSuiteCommonScripts + "ssh_script_output_" + CRFolder + ".txt";
    
    //S'assurer que la commande cat -A FichierDistant a été exécutée sans erreur.
    var errorContent = Trim(aqFile.ReadWholeTextFile(errorLocalFilePath, aqFile.ctANSI));
    if (Trim(errorContent) != ""){
        Log.Message("There was error upon the execution of this SSH command : " + sshCommandForNeededFile, errorContent);
        Log.Message("File copy from vServer " + vServerURL + " was not successful", "from : " + vserverFilePath + " to : " + localDestinationFilePath);
        return false;
    }
    
    //Transférer le contenu du fichier Output vers le fichier de destination
    var localOutputFileContent = aqFile.ReadWholeTextFile(localOutputFilePath, aqFile.ctANSI);
    localOutputFileContent = aqString.Replace(localOutputFileContent, "$\n", "\n");
    var isCopySucceeded = aqFile.WriteToTextFile(localDestinationFilePath, localOutputFileContent, aqFile.ctANSI, true);
    
    if (isCopySucceeded)
        Log.Message("File copy from vServer " + vServerURL + " was successful", "from : " + vserverFilePath + " to : " + localDestinationFilePath);
    else
        Log.Message("File copy from vServer " + vServerURL + " was not successful", "from : " + vserverFilePath + " to : " + localDestinationFilePath);
    
    return isCopySucceeded;
}



function CopyFileFromVserverThroughWinSCP(vServerURL, vserverFilePath, localDestinationFilePath)
{
    Log.Message("Copy remote file from vServer " + vServerURL, "from: " + vserverFilePath + " to: " + localDestinationFilePath);
    
    //Check WinSCP connexion to the VServer
    TryConnexionAndTrustHostKeyThroughWinSCP(vServerURL);
    
    //Verify if provided vserverFilePath path matches many items
    var sshCommandGetFilePathMatchedItemsCount = "ls -l " + vserverFilePath + " 2> /dev/null | wc -l";
    var filePathMatchedItemsCount = ExecuteSSHCommand(null, vServerURL, sshCommandGetFilePathMatchedItemsCount, null, null, false);
    if (aqConvert.StrToInt(filePathMatchedItemsCount) > 1){
        Log.Error("CopyFileFromVserverThroughWinSCP: Found " + filePathMatchedItemsCount + " items matching file path '" + vserverFilePath + "'.");
        Log.Error("CopyFileFromVserverThroughWinSCP: To avoid ambiguity, the provided file path should match only 1 item.");
    }
    
    //Delete any existing local file with the same name
    if ("\\" != aqString.GetChar(aqString.Trim(localDestinationFilePath), aqString.GetLength(aqString.Trim(localDestinationFilePath)) - 1) && aqFile.Exists(localDestinationFilePath) && !aqFile.Delete(localDestinationFilePath)){
        Log.Error("Unable to delete an existing local file: " + localDestinationFilePath);
        return false;
    }
    
    //Create localDestinationFilePath folder if it does not exist
    if (!aqFileSystem.Exists(aqFileSystem.GetFileFolder(localDestinationFilePath))){
        aqFileSystem.CreateFolder(aqFileSystem.GetFileFolder(localDestinationFilePath));
    }
    
    //Download file
    Log.Message("Download file '" + vserverFilePath + "' to '" + localDestinationFilePath + "'...");
    ExecuteWinSCPCommand(vServerURL, '"get ""' + vserverFilePath + '""' + ' ""' + localDestinationFilePath + '"""');
    return aqFile.Exists(localDestinationFilePath);
}



/**
    Cette fonction ne valide pas que le fichier existe sur le VServer
*/
function CopyFileToVserverThroughWinSCP(vServerURL, remoteDestinationFolder, localSourceFilePath)
{
    if (remoteDestinationFolder[remoteDestinationFolder.length - 1] != "/")
        remoteDestinationFolder = remoteDestinationFolder + "/";
    
    Log.Message("Copy file to vServer " + vServerURL + ", from: " + localSourceFilePath + " to: " + remoteDestinationFolder, "from : " + localSourceFilePath + " to : " + remoteDestinationFolder);
    TryConnexionAndTrustHostKeyThroughWinSCP(vServerURL);
    var arrayOfRemoteSubFolders = remoteDestinationFolder.split("/");
    var remoteSubFolder = "/"
    for (var i in arrayOfRemoteSubFolders){
        if (Trim(arrayOfRemoteSubFolders[i]) != ""){
            remoteSubFolder = remoteSubFolder + arrayOfRemoteSubFolders[i] + "/";
            try {
                ExecuteWinSCPCommand(vServerURL, '"mkdir "' + remoteSubFolder + '""', null, false);
            }
            catch (e_remoteDestinationFolder){
                Log.Error("Exception while attempting to create directory: " + remoteSubFolder + ". " + e_remoteDestinationFolder.message, VarToStr(e_remoteDestinationFolder.stack));
                e_remoteDestinationFolder = null;
            }
        }
    }
    
    ExecuteWinSCPCommand(vServerURL, '"put ""' + localSourceFilePath + '""' + ' ""' + remoteDestinationFolder + '"""');
}


/**
    Description : Executer une commande via une session WinSCP
    Paramètres :
        vServerURL : URL du VServer
        winSCPCommand : Commande WinSCP à exécuter
        WinSCPLogFilePath : facultatif, Chemin d'accès du fichier log de la session WinSCP
    Auteur : Christophe Paring
*/
function ExecuteWinSCPCommand(vServerURL, winSCPCommand, WinSCPLogFilePath, logErrorIfNotSuccessfull)
{
    if (logErrorIfNotSuccessfull == undefined)
        logErrorIfNotSuccessfull = true;
        
    var WinSCPComFile = GetWinSCPComFilePath();
    
    if (!aqFileSystem.Exists(WinSCPComFile))
        return Log.Error("The file '" + WinSCPComFile + "' was not found.");
        
    if (WinSCPLogFilePath == undefined)
        WinSCPLogFilePath = Project.Path + "WinSCPCommand_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S") + "_detailed.log";
    
    //Executer la commande
    var hostName = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var commandLine = '"' + WinSCPComFile + '"' + " /command" + ' "open sftp://root:' + GetPercentEncodedString(rootPassword) + '@' + hostName + '/" ' + winSCPCommand + ' "exit" '  + ' /log="' + WinSCPLogFilePath + '"';   
    var isCommandSuccessfull = (0 == WshShell.Run(commandLine, 1, true));
    if (!isCommandSuccessfull && logErrorIfNotSuccessfull !== false){
        Log.Error("The following command line execution was not successful: " + commandLine, commandLine);
        Log.Error("Please, make sure that the VServer is running and function 'TryConnexionAndTrustHostKeyThroughWinSCP()' has been executed earlier, through the PreExecution script for instance.");
    }
    
    //Attendre que le fichier texte de sortie soit correctement écrit
    var nbOfChecks = 0;
    do {
        Delay(1000);
    } while (!aqFileSystem.Exists(WinSCPLogFilePath) && ++nbOfChecks < 20)
        
    //Afficher le log
    if (aqFileSystem.Exists(WinSCPLogFilePath))
        Log.Message(commandLine, aqFile.ReadWholeTextFile(WinSCPLogFilePath, aqFile.ctUTF8));
        
    return isCommandSuccessfull;
}



//Tester la connexion SSH
function TestSSHConnexions(vServerURL, isResultToBeLogged, timeOut, maxTries)
{
    var isPLINKTestSSHSuccessful = TryConnexionAndTrustHostKeyThroughPLINK(vServerURL, isResultToBeLogged, maxTries);
    var isWinSCPTestSSHSuccessful = TryConnexionAndTrustHostKeyThroughWinSCP(vServerURL, isResultToBeLogged, timeOut, maxTries);
    return (isPLINKTestSSHSuccessful && isWinSCPTestSSHSuccessful);
}



/**
    Description : Initier une connexion sur le vserver via PLINK et accepter éventuellement le hostkey
    Paramètres : vServerURL (URL du vserver)
                 isResultToBeLogged (true ou false, facultatif ; valeur par défaut : true)
                 maxTries (nombre maximum de tentatives ; valeur par défaut : 2)
    Résultat :  true (si la tentative de connexion a réussi)
                false (si la tentative de connexion n'a pas réussi)
    Auteur : Christophe Paring
*/
function TryConnexionAndTrustHostKeyThroughPLINK(vServerURL, isResultToBeLogged, maxTries)
{
    if (isResultToBeLogged == undefined)
        isResultToBeLogged = true;
    
    if (maxTries == undefined)
        maxTries = 2;
    
    //Essayer jusqu'à maxTries fois si échec
    var countTries = 0;
    var isTryConnexionAndTrustHostKeySuccessful = false;
    do {
        countTries ++;
        Log.Message("TryConnexionAndTrustHostKeyThroughPLINK, attempt N°" + countTries + "/" + maxTries + "...");
        if (countTries > 1)
            Delay(5000);
        isTryConnexionAndTrustHostKeySuccessful = TryConnexionAndTrustHostKeyThroughPLINK_Once(vServerURL);
    } while (!isTryConnexionAndTrustHostKeySuccessful && countTries < maxTries)
    
    if (isResultToBeLogged){
        if (isTryConnexionAndTrustHostKeySuccessful === true)
            Log.Checkpoint("SSH connexion to host '" + GetVserverHostName(vServerURL) + "' through PLINK was successful");
        else
            Log.Error("SSH connexion to host '" + GetVserverHostName(vServerURL) + "' through PLINK was not was successful");
    }
    
    return isTryConnexionAndTrustHostKeySuccessful;    


    function TryConnexionAndTrustHostKeyThroughPLINK_Once(vServerURL)
    {
        try {
            Log.Message("Through PLINK, try SSH connexion to VServer '" + vServerURL + "' and trust HostKey...");
            var isTryConnexionAndTrustHostKeySuccessfulThroughPLINK, dateTime, tmpFileName, tmpFileContent, vserverFolder, vserverFilePath, sshCommand, sshCommandExecutionID, localOutputFileContent;
            isTryConnexionAndTrustHostKeySuccessfulThroughPLINK = false;
            dateTime = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
            tmpFileName = executionComputerName + "_TestPlinkSSH" + dateTime + ".txt";
            tmpFileContent = "PLINK SSH Connexion Test : " + tmpFileName;
            vserverFolder = "/tmp/";
            vserverFilePath = vserverFolder + tmpFileName;
        
            //Exécuter commande SSH
            sshCommand = "mkdir -p " + vserverFolder + "\n";
            sshCommand += 'echo "' + tmpFileContent + '" > ' + vserverFilePath + "\n";
            sshCommand += 'cat ' + vserverFilePath + "\n";
            sshCommandExecutionID = "TestPlinkSSH_" + aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) + dateTime;
            localOutputFileContent = ExecuteSSHCommand(sshCommandExecutionID, vServerURL, sshCommand, null, tmpFileContent);
        }
        catch (e_TryConnexionAndTrustHostKeyThroughPLINK) {
            Log.Error("Exception : " + e_TryConnexionAndTrustHostKeyThroughPLINK.message, VarToStr(e_TryConnexionAndTrustHostKeyThroughPLINK.stack));
            e_TryConnexionAndTrustHostKeyThroughPLINK = null;
        }
        finally {
            isTryConnexionAndTrustHostKeySuccessfulThroughPLINK = (aqString.Find(localOutputFileContent, tmpFileContent) != -1);
            if (isTryConnexionAndTrustHostKeySuccessfulThroughPLINK === true){
                //Log.Message("Connexion to '" + vServerURL + "' host through PLINK was successful");
                aqFileSystem.DeleteFile(folderPath_ProjectSuiteCommonScripts + sshCommandExecutionID + "*");
            }
            else {
                Log.Message("Expecting in PLINK SSH Connexion Test Output '" + tmpFileContent + "', got '" + localOutputFileContent + "'");
                //Log.Message("Connexion to '" + vServerURL + "' host Through PLINK was not was successful");
            }
            return isTryConnexionAndTrustHostKeySuccessfulThroughPLINK;
        }
    }
}



/**
    Description : Initier une connexion sur le vserver via WinSCP et accepter éventuellement le hostkey
    Paramètres : vServerURL (URL du vserver)
                 isResultToBeLogged (true ou false, facultatif ; valeur par défaut : true)
                 timeOut (délai de réponse, facultatif, valeur par défaut : 30000 millisecondes)
                 maxTries (nombre maximum de tentatives ; valeur par défaut : 2)
    Résultat :  true (si la tentative de connexion a réussi)
                false (si la tentative de connexion n'a pas réussi)
    Auteur : Christophe Paring
*/
function TryConnexionAndTrustHostKeyThroughWinSCP(vServerURL, isResultToBeLogged, timeOut, maxTries)
{
    if (isResultToBeLogged == undefined)
        isResultToBeLogged = true;
    
    if (timeOut == undefined)
        timeOut = 30000;
    
    if (maxTries == undefined)
        maxTries = 2;
    
    Log.Message("Through WinSCP, try SSH connexion to VServer '" + vServerURL + "' and trust HostKey...");
    var languageWindowsUser = GetWindowsDisplayLanguage();
    var WinSCPComFile = GetWinSCPComFilePath();
    if (!aqFileSystem.Exists(WinSCPComFile)){
        Log.Error("The file '" + WinSCPComFile + "' was not found.");
        return false;
    }
    
    var vServerRootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    CheckIfAllStringCharsAreAscii7(vServerRootPassword);
    var vserverHostName = GetVserverHostName(vServerURL);
    var WinSCPLogFilePath = Project.Path + vserverHostName +  "_WinSCP_Connexion_Try.log";
    aqFileSystem.DeleteFile(WinSCPLogFilePath);
    
    if (languageWindowsUser == "french"){
        var charForAcceptHostKey = "O";
        var charForUpdateHostKey = "M";
        var expectedStringForSuccessfullConnexion = "*Session active : [*] root@" + vserverHostName + "*";
        var expectedStringForHostKeyToBeTrusted = "*Si vous faites confiance à cet hôte, appuyez sur Oui. Pour vous connecter sans ajouter de clé hôte au cache, appuyez sur Non.*";
        var expectedStringForHostKeyUpdateToBeTrusted = "*Si vous attendiez cette modification, faites confiance à la nouvelle clé et souhaitez continuer à vous connecter au serveur*";
    }
    else {
        var charForAcceptHostKey = "Y";
        var charForUpdateHostKey = "U";
        var expectedStringForSuccessfullConnexion = "*Active session: [*] root@" + vserverHostName + "*";
        var expectedStringForHostKeyToBeTrusted = "*If you trust this host, press Yes. To connect without adding host key to the cache, press No. To abandon the connection press Cancel.*";
        var expectedStringForHostKeyUpdateToBeTrusted = "*If you were expecting this change, trust the new key and want to continue connecting to the server, either press Update to update cache*";
    }
    
    //Essayer jusqu'à maxTries fois si échec
    var countTries = 0;
    var isTryConnexionAndTrustHostKeySuccessful = false;
    do {
        countTries ++;
        Log.Message("TryConnexionAndTrustHostKeyThroughWinSCP, attempt N°" + countTries + "/" + maxTries + "...");
        if (countTries > 1)
            Delay(5000);
        isTryConnexionAndTrustHostKeySuccessful = TryConnexionAndTrustHostKeyThroughWinSCP_Once(vServerURL, timeOut);
    } while (!isTryConnexionAndTrustHostKeySuccessful && countTries < maxTries)
    
    if (isResultToBeLogged){
        if (isTryConnexionAndTrustHostKeySuccessful == true)
            Log.Checkpoint("SSH connexion to host '" + vserverHostName + "' through WinSCP was successful");
        else
            Log.Error("SSH connexion to host '" + vserverHostName + "' through WinSCP was not was successful");
    }
    
    return isTryConnexionAndTrustHostKeySuccessful;
    
    
    function CheckIfAllStringCharsAreAscii7(varPassword)
    {
        for (var i = 0; i < varPassword.length; i++){
            if (varPassword.charCodeAt(i) > 127){
                Log.Warning(varPassword + " : Tous les caractères du mot de passe ne sont pas ASCII ; vous pourriez rencontrer des problèmes de connexion SSH via WinSCP.");
                return false;
            }
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
        var connexionCommandLine = '"' + WinSCPComFile + '"' + " /rawconfig Interface\\LocaleSafe=0 Interface\\Locale=0409 /command" + ' "open sftp://root:' + vServerRootPasswordPercentEncoded + '@' + vserverHostName + '/" ' + ' "exit" '  + ' /log="' + WinSCPLogFilePath + '"';
        Log.Message(aqString.Replace(connexionCommandLine, vServerRootPasswordPercentEncoded, vServerRootPassword), connexionCommandLine);
        Sys.Clipboard = connexionCommandLine;
        Delay(2000);
        commandLineConsole.Keys(" ^v[Enter]");
        
        var timeElapsed = 0;
        var stepTimeout = 250;
        while (timeElapsed < timeOut){
            //Vérifier si la connexion a réussi
            if (commandLineConsole.WaitProperty("wText", expectedStringForSuccessfullConnexion, 2*stepTimeout))
                break;
            timeElapsed += 2*stepTimeout;
            
            //Accepter le hostkey si requis
            if (commandLineConsole.WaitProperty("wText", expectedStringForHostKeyToBeTrusted, stepTimeout)){
                Log.Message("Accept Host Key for '" + vserverHostName + "' by pressing '" + charForAcceptHostKey + "'");
                commandLineConsole.Keys(charForAcceptHostKey);
                break;
            }
            timeElapsed += stepTimeout;
            
            //Accepter le hostkey si requis
            if (commandLineConsole.WaitProperty("wText", expectedStringForHostKeyUpdateToBeTrusted, stepTimeout)){
                Log.Message("Update Host Key for '" + vserverHostName + "' by pressing '" + charForUpdateHostKey + "'");
                commandLineConsole.Keys(charForUpdateHostKey);
                break;
            }
            timeElapsed += stepTimeout;
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



/**
    Description : Récupérer, via la base de registre, le chemin d'accès pour le fichier WinSCP.com
    Résultat : Chemin d'accès du fichier WinSCP.com
               retourne "C:\Program Files (x86)\WinSCP\WinSCP.com" par défaut (si la recherche dans la base de registre n'a pas été concluante)
*/
function GetWinSCPComFilePath()
{
    var WinSCPInstallDefaultPath = "C:\\Program Files (x86)\\WinSCP\\"; //Chemin d'accès par défaut
    var uninstallRegistryKey = Storages.Registry("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall", HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
    for (var i = uninstallRegistryKey.SectionCount - 1; i >= 0; i--){
        var uninstallAppKey = uninstallRegistryKey.GetSubSectionByIndex(i).Name;
        if (aqString.Find(uninstallAppKey, "\\winscp") != -1){
            var WinSCPRegistryKey = Storages.Registry(uninstallAppKey, HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
            return WinSCPRegistryKey.GetOption("InstallLocation", WinSCPInstallDefaultPath) + "WinSCP.com";
        }
    }
    
    Log.Warning("The WinSCP 'InstallLocation' was not found in the registry");
    return WinSCPInstallDefaultPath + "WinSCP.com";
}



function CopyFileToVserver(vServerURL, userName, vserverFilePath, localFilePath, encoding)
{
    if (encoding == undefined)
        encoding = aqFile.ctANSI;
    
    var hostname = GetVserverHostName(vServerURL);
    Log.Message("Copy file", "from : " + localFilePath + " to : " + vserverFilePath + " on : " + hostname);
    
    //Exécuter la commande SSH
    var fileContent = aqFile.ReadWholeTextFile(localFilePath, encoding);
    fileContent = aqString.Replace(fileContent, '"', '\\"');
    fileContent = aqString.Replace(fileContent, '\r\n', '\n');
    var errorFilePath = "/tmp/Error_CopyFile.txt";
    
    var vserverFakeFolder = vserverFilePath + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S"); //Permet de créer les dossiers parents du fichier, s'il n'existent pas
    var sshCommand = "mkdir -p " + vserverFakeFolder;
    sshCommand += "\nrmdir " + vserverFakeFolder;
    sshCommand += "\necho -e \"" + fileContent + "\" > \"" + vserverFilePath + "\" 2> " + errorFilePath;
    ExecuteSSHCommandCFLoader("CopyFile", vServerURL, sshCommand, userName);
    
    //S'assurer que la commande a été exécutée sans erreur.
    var errorLocalFilePath = folderPath_ProjectSuiteCommonScripts + "Error_CopyFile.txt";
    CopyFileFromVserver(vServerURL, errorFilePath, errorLocalFilePath);
    var errorContent = Trim(aqFile.ReadWholeTextFile(errorLocalFilePath, aqFile.ctANSI));
    if (Trim(errorContent) == "")
        return true;
    
    Log.Error("There was error upon the execution of this SSH command : " + sshCommand, errorContent);
    return false;
}




function DeleteFileOnVserver(vServerURL, vserverFilePath, userName)
{
    Log.Message("Delete file " + vserverFilePath + " on vServer : " + vServerURL);
 
    if (userName == undefined)
        userName = "DeleteFileUser";
       
    //Exécuter la commande SSH
    var errorFilePath = "/tmp/Error_CopyFile.txt";
    var sshCommand = "rm -f " + vserverFilePath + " 2> " + errorFilePath;
    ExecuteSSHCommandCFLoader("DeleteFile", vServerURL, sshCommand, userName);
    
    //S'assurer que la commande a été exécutée sans erreur.
    var errorLocalFilePath = folderPath_ProjectSuiteCommonScripts + "Error_CopyFile.txt";
    CopyFileFromVserver(vServerURL, errorFilePath, errorLocalFilePath);
    var errorContent = Trim(aqFile.ReadWholeTextFile(errorLocalFilePath, aqFile.ctANSI));
    var isFileDeleted = (Trim(errorContent) == "");
    
    if (isFileDeleted)
        Log.Message("File " + vserverFilePath + " deleted on vServer : " + vServerURL);
    else
        Log.Message("There was error while deleting file " + vserverFilePath + " on vServer : " + vServerURL, errorContent);
    
    return isFileDeleted;
}






//************************* fonctions pour lire le grid *******************************
//retourne la liste des colonnes incluant les colonnes vides
// baseColumn: une colonne à utiliser comme base pour trouver les autres
function Get_ColumnListAll(baseColumn)
{
  var colonnes = baseColumn.parent.FindAllChildren("ClrClassName", "LabelPresenter").toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft});
  for(n = 0; n < colonnes.length; n++)
    colonnes[n] = colonnes[n].WPFControlText;
  return colonnes;
}

//retourne la liste des colonnes sans les colonnes vides
// baseColumn: une colonne à utiliser comme base pour trouver les autres
function Get_ColumnList(baseColumn)
{
  var colonnes = Get_ColumnListAll(baseColumn);
  while(true)
    if(colonnes[0] == "")
      colonnes.shift();
    else
      break;
  return colonnes;
}

//retourne les lignes de grid qui sont visibles en ce moment
function Get_Grid_VisibleLines(grid)
{
  var array = grid.FindAllChildren(["ClrClassName", "visible"], ["DataRecordPresenter", "true"], 10).toArray().sort(function(a, b){return a.ScreenTop - b.ScreenTop});
  while (array.length > 0 && Get_Grid_LineContent(array[0]).length == 0) array.shift();
  return array;
}

//retourne la liste des composants cases dans une ligne
function Get_Grid_LineContent(DataRecordPresenter){return DataRecordPresenter.FindAllChildren("ClrClassName", "CellValuePresenter", 10).toArray().sort(function(a, b){return a.ScreenLeft - b.ScreenLeft})}

//retourne l'index de Column dans la liste de colonnes (excluant les colonnes vides à gauche)
function Get_ColumnIndex(Column)
{
  var listCol = Get_ColumnListAll(Column);
  var ColumnsEmptyLeft = 0;
  var ColumnIndex = -1;
  for(col = 0; col < listCol.length && ColumnIndex < 0; col++)
  {
    if(listCol[col] == "")
      ColumnsEmptyLeft++;
    if(listCol[col] == Column.WPFControlText)
      ColumnIndex = col;
  }
  return ColumnIndex - ColumnsEmptyLeft;
}

//retourne la liste de valeurs de la colonne
//Column: la colonne dont on veut les valeurs
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
function Get_ColumnFromGrid(Column, grid, IDColumn, canUseHomeKey){return Get_ColumnFromGridArray(Column, Get_Grid_ContentArray(grid, IDColumn, canUseHomeKey));}

//retourne la liste de valeurs de la colonne (avec la grille déjà dans un array)
//Column: la colonne dont on veut les valeurs
//gridArray: la grille contenu dans un array obtenu avec Get_Grid_ContentArray
function Get_ColumnFromGridArray(Column, gridArray)
{
  var index = Get_ColumnIndex(Column);
  var colArray = [];
  for(n = 0; n < gridArray.length; n++)
    colArray.push(gridArray[n][index]);
  return colArray;
}

//retourne un grille dans un tableau Array (excluant les colonnes vides à gauche) avec les colonnes au début du tableau
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
function Get_Grid_ContentArrayWithHeader(grid, IDColumn, canUseHomeKey)
{
  var gridData = Get_Grid_ContentArray(grid, IDColumn, canUseHomeKey);
  gridData.unshift(Get_ColumnList(IDColumn));
  return gridData;
}

//retourne un grille dans un tableau Array (excluant les colonnes vides à gauche)
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
//canUseHomeKey: si on peut utiliser la touche Home sans causer un changement de grille
function Get_Grid_ContentArray(grid, IDColumn, canUseHomeKey)
{
  //Find columns placements
  var listCol = Get_ColumnListAll(IDColumn);
  var ColumnsEmptyLeft = 0;
  var ColumnID = -1;
  for(col = 0; col < listCol.length && ColumnID < 0; col++)
  {
    if(listCol[col] == "")
      ColumnsEmptyLeft++;
    if(listCol[col] == IDColumn.WPFControlText)
      ColumnID = col;
  }
  
  if(canUseHomeKey == undefined || canUseHomeKey == true)
    grid.Keys("[Home][Home][Home]");
  
  var arrayPositions = new Array();
  var arrayPositionsTextIDs = new Array();
  var ajoutsVides = 0; //nombres de scroll sans ajouts
  while(ajoutsVides < 3)
  {
    grid.Refresh();
    var listePositionCourante = Get_Grid_VisibleLines(grid);
    for(n = 0; n < listePositionCourante.length; n++)
    {
      var positionChildren = Get_Grid_LineContent(listePositionCourante[n]);
        
      var isVisible = positionChildren[ColumnID].VisibleOnScreen;
      if(isVisible)
      {
        var arrayContentOfPosition = new Array();
        for(m = ColumnsEmptyLeft; m < positionChildren.length; m++)
        {
          if(positionChildren[m].FindChild("ClrClassName", "XamNumericEditor", 10).Exists)
            arrayContentOfPosition.push("" + positionChildren[m].FindChild("ClrClassName", "XamNumericEditor", 10).DisplayText);
          else if(positionChildren[m].FindChild("ClrClassName", "XamDateTimeEditor", 10).Exists)
            arrayContentOfPosition.push("" + positionChildren[m].FindChild("ClrClassName", "XamDateTimeEditor", 10).DisplayText);
          else if(positionChildren[m].FindChild("ClrClassName", "Rectangle", 10).Exists)
            arrayContentOfPosition.push(positionChildren[m].FindAllChildren("ClrClassName", "Rectangle", 10).toArray());
          else
            arrayContentOfPosition.push("" + positionChildren[m].WPFControlText);
        }
        var arrayContentOfPositionText = "";
        for(m = 0; m < arrayContentOfPosition.length; m++)
            arrayContentOfPositionText += "" + arrayContentOfPosition[m] + ",";
        
        var notAlreadyFound = true;
        for(findIndex = 0; findIndex < arrayPositionsTextIDs.length; findIndex++)
        {
          if(aqString.Compare(arrayPositionsTextIDs[findIndex], arrayContentOfPositionText, true) == 0)
          {
            notAlreadyFound = false;
            break;
          }
        }
        if(notAlreadyFound)
        {
          arrayPositions.push(arrayContentOfPosition);
          arrayPositionsTextIDs.push(arrayContentOfPositionText);
          ajoutsVides = 0;
        }
      }
    }
    ajoutsVides++;
    grid.Keys("[PageDown]");
  }
  return arrayPositions;
}

//retourne un grille (lignes visibles) dans un tableau Array (excluant les colonnes vides à gauche) avec les colonnes au début du tableau
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
function Get_Grid_ContentArrayWithHeader_VisibleOnly(grid, IDColumn)
{
  var gridData = Get_Grid_ContentArray_VisibleOnly(grid, IDColumn);
  gridData.unshift(Get_ColumnList(IDColumn));
  return gridData;
}

//retourne un grille (lignes visibles) dans un tableau Array (excluant les colonnes vides à gauche)
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
function Get_Grid_ContentArray_VisibleOnly(grid, IDColumn)
{
  //Find columns placements
  var listCol = Get_ColumnListAll(IDColumn);
  var ColumnsEmptyLeft = 0;
  var ColumnID = -1;
  for(col = 0; col < listCol.length && ColumnID < 0; col++)
  {
    if(listCol[col] == "")
      ColumnsEmptyLeft++;
    if(listCol[col] == IDColumn.WPFControlText)
      ColumnID = col;
  }
  
  var arrayPositions = new Array();
  grid.Refresh();
  var listePositionCourante = Get_Grid_VisibleLines(grid);
  for(n = 0; n < listePositionCourante.length; n++)
  {
    var positionChildren = Get_Grid_LineContent(listePositionCourante[n]);
        
    var isVisible = positionChildren[ColumnID].VisibleOnScreen;
    if(isVisible)
    {
      var arrayContentOfPosition = new Array();
      for(m = ColumnsEmptyLeft; m < positionChildren.length; m++)
      {
        if(positionChildren[m].FindChild("ClrClassName", "XamNumericEditor", 10).Exists)
          arrayContentOfPosition.push("" + positionChildren[m].FindChild("ClrClassName", "XamNumericEditor", 10).DisplayText);
        else if(positionChildren[m].FindChild("ClrClassName", "XamDateTimeEditor", 10).Exists)
          arrayContentOfPosition.push("" + positionChildren[m].FindChild("ClrClassName", "XamDateTimeEditor", 10).DisplayText);
        else if(positionChildren[m].FindChild("ClrClassName", "Rectangle", 10).Exists)
          arrayContentOfPosition.push(positionChildren[m].FindAllChildren("ClrClassName", "Rectangle", 10).toArray());
        else
          arrayContentOfPosition.push("" + positionChildren[m].WPFControlText);
      }
      arrayPositions.push(arrayContentOfPosition);
    }
  }
  return arrayPositions;
}

/**
    Description : Permet de localiser une ligne dans la grille avec plusieurs valeurs
    Paramètres :
        - Grid : le composant de la grille, obtenu par une fonction Get
        - Values : tableau des valeurs recherchés dans la grille        
    Résultat : - (-1) : la ligne recherché n'existe pas dans la grille
               - row : tous les composants de la ligne trouvée ; - index : l'indice de la ligne trouvée
    Auteur : Emna IHM
*/
function FindRowByMultipleValues(Grid, Values){
    var GridArray = Get_Grid_VisibleLines (Grid);
    var i, n=0;
    // Iterate through grid rows
    do{
      var match=true;
      for(i=0; i<Values.length; i++)  //Locate a row by multiple values
        match = match && GridArray[n].FindChild("Value",Values[i],10).Exists 
      if (match) return {row: GridArray[n], index: n+1}; // Row is found
      n++;              
    } while(n < GridArray.length && !match );
    return -1; // Row is not found
}

/**
    Description : Permet de localiser une valeur recherchée dans la grille en récupérant l'index de sa ligne
    Paramètres :
        - arraytabGrid : la grille contenu dans un array obtenu avec Get_Grid_ContentArray
        - searchValue : la valeur recherchée dans la grille (devrait être unique dans la grille sinon la valeur retournée sera de la prémière ligne trouvée)     
    Résultat : - (-1) : la valeur recherchée n'existe pas dans la grille
               - n : l'indice de la ligne trouvée
    Auteur : Emna IHM
*/
function Get_RowIndex(arraytabGrid, searchValue){    
    
     var n=0;
     do{         
        var res= aqString.Find(arraytabGrid[n], searchValue);          
        n++;
     }while(n < arraytabGrid.length && res == -1);
             
     if (res == -1){
         Log.Error("The search value «"+searchValue+"» is not found!");
         return -1
     }          
     //Log.Message("res = "+res)        
     //Log.Message("n = "+n)
     return n;

}

/**
    Description : Permet de rechercher un élement dans un tableau
    Auteur : Emna IHM
*/
function array_search(what, where){
  
  var indexOfArray=-1 
	for(elt in where){
    indexOfArray++;
		if (where[elt]==what){return indexOfArray} //retourne que l'indice de la première occurence dans le tableau : indexOfArray
	}
	indexOfArray=-1; //l'elt n'existe pas
	return indexOfArray
  
}

//fonction pour convertir des valeurs pris de Croesus d'après la langue en variable nombres
//defaultValue peut être null
function convertTextToNumber(textValue, defaultValue)
{
  if(aqString.StrMatches("^\\(\\d?\\d?\\d( |\\,\\d\\d\\d)*(\\,|\\.\\d\\d+)?\\)$", textValue))
    textValue = "-" + aqString.Replace(aqString.Replace(textValue, "(", "", true), ")", "", true);
  var regex;
  if(language == "french")
    regex = "^-?\\d?\\d?\\d( \\d\\d\\d)*(\\,\\d\\d+)?$";
  else
    regex = "^-?\\d?\\d?\\d(\\,\\d\\d\\d)*(\\.\\d\\d+)?$";
  
  if(aqString.StrMatches(regex, textValue))
    if(language == "french")
      return aqConvert.StrToFloat(aqString.Replace(aqString.Replace(textValue, " ", ""), ",", "."));
    else
      return aqConvert.StrToFloat(aqString.Replace(textValue, ",", ""));
  if(defaultValue != null)
    return defaultValue;
  return textValue;
}



/**
    Description : Cette fonction modifie la valeur de l'auto-timeout du projet (afin, typiquement, de réduire au besoin le temps d'attente)
    *** Attention : Ne pas oublier de s'assurer de faire ensuite un appel à la fonction RestoreAutoTimeOut()
    *** afin de remettre l'auto-timeout à sa valeur initiale renseignée dans les propriétés du projet,
    *** sans quoi cela va impacter la suite de l'exécution du script en cours.
    Paramètre : autoTimeoutNewValue (nouveau temps d'attente en millisecondes, valeur par défaut = 5000)
    Auteur : Christophe Paring
*/
function SetAutoTimeOut(autoTimeoutNewValue)
{
    if (autoTimeoutNewValue == undefined) autoTimeoutNewValue = 5000;
    if (autoTimeoutNewValue != Options.Run.Timeout){
        Options.Run.Timeout = autoTimeoutNewValue;
        Log.Message("Project playback 'Auto-wait timeout' value is updated to " + autoTimeoutNewValue + " milliseconds.");
    }
}



/**
    Description : Cette fonction remet l'auto-timeout à sa valeur initiale renseignée dans les propriétés du projet.
    Auteur : Christophe Paring
*/
function RestoreAutoTimeOut()
{
    if (typeof PROJECT_AUTO_WAIT_TIMEOUT != "undefined" && PROJECT_AUTO_WAIT_TIMEOUT != undefined && PROJECT_AUTO_WAIT_TIMEOUT != Options.Run.Timeout){
        Options.Run.Timeout = PROJECT_AUTO_WAIT_TIMEOUT;
        Log.Message("Project playback 'Auto-wait timeout' value is restored back to " + PROJECT_AUTO_WAIT_TIMEOUT + " milliseconds.");
    }
}



//********* Fonction pour ajouter toutes les colonnes possibles dans une grille *************************************************************
function Add_AllColumns(Column, columnObjectGetExpressionString)
  {
    var PREF_PROFILE_MAX_COLUMN = 10;
    
    var numTry = 0;
    do {
        Delay(3000);
        Column.ClickR();
    } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))

    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    
    //Ajouter tous les champs du menu contextuel Ajouter une colonne
    var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    for(i=1; i<count; i++)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 100).Click(); 
      Column.ClickR();
    } 
    
    // Ajouter tous les champs du sous menu contextuel Ajouter une colonne/Profils
    if (client == "BNC")
    {
      var numTry = 0;
      do {
        Delay(3000);
        Column.ClickR();
      } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))

      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
      var count1 = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
      for (i=1; i<=count1; i++)
      {
        if (i <= PREF_PROFILE_MAX_COLUMN )
        {
           Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
           Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
           Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10).Click();   
           if (!Column.Exists && columnObjectGetExpressionString != undefined){ //Par Christophe
                Column = eval(columnObjectGetExpressionString);
           }
           Column.ClickR();
         }   
      }
    }
  }
  
//*************************** Fonction pour ajouter toutes les colonnes sans sous menu profiles *********************************************************
 function Add_AllColumnsWithoutProfiles(Column)
  { 
    Column.ClickR();
    Column.ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    
    //Ajouter tous les champs du menu contextuel Ajouter une colonne
    var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    for(i=1; i<count; i++)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 100).Click(); 
      Column.ClickR();
    } 
  }

// ************************* Fonction pour supprimer une colonne dans une grille *************************************************************************
function DeleteColumn(Column)
  {
      //Supprimer une colonne
      Column.ClickR();
      Column.ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisColumn().Click(); 
  }

// ************************* Fonction pour déplacer une colonne dans une grille "fixer à droite" ******************************************************
function MoveColumn(Column)
  {
      //Supprimer une colonne
      Column.ClickR();
      Column.ClickR();
      Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
      Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();
  }
  
// ************************* Fonction pour ajouter une colonne dans une grille *************************************************************************
function AddColumn(ColumnHeader, Column)
  {
        ColumnHeader.ClickR();
        ColumnHeader.ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Delay(1000);
        Column.Click();  
  }  

//********************** Fonction pour ajouter une colonne par son label **********************************************************************************
function Add_ColumnByLabel(columnClickR,ColumnLabel){
      columnClickR.ClickR();
      columnClickR.ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  
      var SubMenu = Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1);
      var count = SubMenu.DataContext.Items.Item(0).Items.Count;
      for (i=0; i<count; i++)
      {
          var item = SubMenu.DataContext.Items.Item(0).Items.Item(i);
          if (item.Label == ColumnLabel)
          {
              Log.Message("Ajout de la colonne " +item.Label);
              SubMenu.Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i+1], 100).Click();
              break;
          }
      } 
  }  
// ************************** Fonction pour cliquer le bouton Export to Excel pour module Relations, Clients et Comptes ********************************
function ClickOnButtonExportExcel()
  {
      //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 2],10).Click();
      /**************** Mise à jour de la fonction suite à l'ajout d'un nouveau bouton avec la version HF *****************/
      Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 3],10).Click();
      Sys.WaitProcess("EXCEL", "5000", 1);
      Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, "15000");
  }
//******************** Fonction pour cliquer sur Export To Excel du menu contextuel *********************************************************
function ClickOnExportToExcel(Board)
 {
    Board.Click();
    Board.ClickR();
    Get_Win_ContextualMenu_ExportToMSExcel().Click();
	Sys.WaitProcess("EXCEL", "5000", 1);
	Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, 15000);
	Delay(1000);
                             
 }

//*********************************** Fonction pour mettre la configuration par défaut des colonnes dans une grille ************************************
function SetDefaultConfiguration(Column)
  {
      Column.ClickR();
      Column.ClickR();
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
  }

// ************************ Fonction pour comparer deux (02) fichiers excel le fichier exporté et celui considéré comme référence ********************* 
/**
    Description : Permet de comparer deux fichiers Excel
    Pour utiliser cette fonction on doit installer deux (02) plugins ExcelCompare.tcx et ExcelSheetCompare.tcx
    
    Paramètres :
        - ExpectedFolder : le dossier qui contient de fichier de référence
        - ExpectedFile : le nom du fichier de référence
        - ResultFolder : le dossier qui va contenir le fichier résultat s'il y a une différence        
    Résultat : - retourne de le nombre d'items différents entre les deux fichiers.
               - Crée un fichier résultat contient les différences avec le numéro de cellule
               - S'il n'y a pas de différence entre les deux fichiers le fichier résultat n'est pas généré.
    Auteur : Abdel Matmat
*/ 

function ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder)
  {
    var sTempFolder = Sys.OSInfo.TempDirectory;
    var ExportedFolder = sTempFolder+"\CroesusTemp\\";
    Log.Message(ExportedFolder);
    var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
    var ExportedFilePath = FindLastModifiedFileInFolder(ExportedFolder,FileNameContains); 
    Log.Message(ExportedFilePath);
	var ExportedFile = aqFileSystem.GetFileName(ExportedFilePath);
    var RefFile = ExpectedFolder+ExpectedFile;
    var ExpFile = ExportedFolder+ExportedFile;
    var ResultFile = ResultFolder+"ResultCompare_"+ExpectedFile;
    
    // Enlever le ReadOnly du fichier résultat s'il existe
    SetNotReadOnlyAttributeToFile(ResultFolder,"ResultCompare_"+ExpectedFile);
    
    //Supprimé le fichier Resultat s'il existe déjà
    DeleteFileIfExists(ResultFolder,"ResultCompare_"+ExpectedFile);
    
    //Vérifier que les 2 fichiers à comparer existent dans leurs dossiers respectives
    var ExpectedFileExiste = CheckIfFileExists(ExpectedFolder, ExpectedFile);
    var ExportedFileExiste = CheckIfFileExists(ExportedFolder, ExportedFile); 
    if(ExpectedFileExiste!=null) /* si le fichier attendu existe*/               
        if (ExportedFileExiste!=null)/* si le fichier exporté existe*/ 
          {
            //Appeler la fonction de comparaison excel 
            Log.Checkpoint(objectExcel.ExcelCompare(RefFile, ExpFile, ResultFile));
            
            //Vérifier s'il ya des écarts
            var ResultFileExiste = CheckIfFileExists(ResultFolder, "ResultCompare_"+ExpectedFile);  
            if (ResultFileExiste!=null)
               {
                 Log.Error("il ya une ou plusieurs differences entre les deux fichiers" );
               } 
            else 
               {
                 Log.Checkpoint("Les deux fichiers sont identiques");
               }  
          }
        else/*Cas où le ficheir téléchargé n'a pas été trouvé*/
                  Log.Error("Le fichier exporté (" + ExportedFile + ") est introuvable ");                        
    else/*Cas où le ficheir Attendu n'a pas été trouvé*/
              Log.Error("Le fichier de référence (" + ExpectedFile + ") est introuvable ");
              
    
  }
 // ********** Fonction pour enlever la lecture seul d'un fichier ********************************************************************
/* Description : Permet d'enlever le read only d'un fichier
    Paramètres :
        - Folder : le dossier qui contient le fichier en question
        - FileName : le nom du fichier       
    Résultat : Changer l'attribut read only (1) pour l'attribut archive (32).
             
    Auteur : Abdel Matmat
*/
function SetNotReadOnlyAttributeToFile (Folder,FileName) 
      {
         /*Verifier l'existance du fichier*/
          var FileExiste = CheckIfFileExists(Folder,FileName)
          if(FileExiste != null) 
             {
                 var state = aqFile.GetFileAttributes(Folder+FileName);
                 if (state == 1)//si read only
                   {
                      Log.Message("Le fichier "+FileName+" est en lecture seule");
                      Log.Message("Enlever la lecture seule du fichier"+FileName);
                      aqFile.SetFileAttributes(Folder+FileName,32);
                   }  
             }
      }
  
//******************* Fonction qui supprime des fichiers dans un dossier s'ils existent **************************************************************  
function DeleteFileIfExists(Folder,FileName)
        {
          /*Verifier l'existance du fichier*/
          var FileExiste = CheckIfFileExists(Folder,FileName)
          if(FileExiste != null)
            aqFileSystem.DeleteFile(Folder+FileName);
        }
//****************** Fonction qui vérifie si un fichier existe dans un dossier ************************************************************************
function CheckIfFileExists(Folder,FileName)      
{
    return FoundFiles = aqFileSystem.FindFiles(Folder, FileName);
}

// ******************** Fonction pour fermer le processus excel s'il est ouvert ***********************************************************************        
function CloseExcel()
{
    TerminateProcess("EXCEL");
}
    
    
//************* Fonctions pour le menu Users *************************************************************************************************************
//**** fonctions pour cocher et décocher l'option "Remember my selection dans le menu Users applicable pour tous les modules ******************************
/*
Description : Selon le cas 
              - Cocher l'option si ce n'est pas le cas.
              - Décocher l'option si ce n'est pas le cas.
Version     : 90.08.Dy-1
Analyste    : Abdel Matmat
*/
function Get_MenuBar_Users_RememberMySelection_Check()
 {
    if (Get_MenuBar_Users_RememberMySelection_CheckboxImage().VisibleOnScreen)
    {
            Log.Message("L'option est déjà cochée");
    }else{
            Get_MenuBar_Users_RememberMySelection().Click();
    }
 }
 
function Get_MenuBar_Users_RememberMySelection_UnCheck()
 {
    if (Get_MenuBar_Users_RememberMySelection_CheckboxImage().VisibleOnScreen)
    {
           Get_MenuBar_Users_RememberMySelection().Click();   
    }else{
           Log.Message("L'option est déjà décochée");
    }
 } 
 
//************************ Fonction pour supprimer un critere de recherche par nom ***********************************
function DeleteCriterion(CriterionName)
{
    Get_Toolbar_BtnManageSearchCriteria().Click();
    WaitObject(Get_CroesusApp(),"Uid","ManagerWindow_efa9");
    Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Keys("C");
    Get_WinQuickSearch_TxtSearch().SetText(CriterionName);
    Get_WinQuickSearch_BtnOK().CliCk();
    Get_WinSearchCriteriaManager().FindChild(["ClrClassName","Value"],["XamTextEditor",CriterionName],10).Click();
    Get_WinSearchCriteriaManager_BtnDelete().Click();
    Get_DlgConfirmation_BtnDelete().Click();
    Get_WinSearchCriteriaManager_BtnClose().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ManagerWindow_efa9");
}

//****************** fonction pour supprimer une entrée dans l'accumulateur *****************************************
function DeleteOrderInAcumulator(account){
        Log.Message("Supprimer l'ordre du compte "+account+" de l'accumulateur")
        Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",account],10).Click();
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
 }
 
//**************** fonction pour rechercher dans la table portfolio par symbole *************************************************
function SearchAccountBySymbolInPortfolioGrid(symbol){
        ClickOnToolbarSearchButton();
        Get_WinQuickSearch_TxtSearch().SetText(symbol);
        Get_WinPortfolioQuickSearch_RdoSymbol().set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        Delay(3000);
}


function ClickOnToolbarSearchButton()
{
    var nbOfChecks = 0;
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 10000);
    while (nbOfChecks < 4 && (!Get_barToolbar().Exists || !Get_Toolbar_BtnSearch().Exists || !Get_Toolbar_BtnSearch().Enabled)){
        Delay(10000);
        nbOfChecks++;
    }
    Get_Toolbar_BtnSearch().Click();
}



function ClickOnToolbarAddButton()
{
    var nbOfChecks = 0;
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 10000);
    while (nbOfChecks < 4 && (!Get_barToolbar().Exists || !Get_Toolbar_BtnAdd().Exists || !Get_Toolbar_BtnAdd().Enabled)){
        Delay(10000);
        nbOfChecks++;
    }
    Get_Toolbar_BtnAdd().Click();
}



function MaillageFromOneModuleToTargetModuleAllOption(functionGetBtnModuleSource, functionGetBtnModuleDestination, optionMaillage, OptionSelect, functionGetGrillModulSource, functionGetBarTargetModule)
{
    functionGetBtnModuleSource.WaitProperty("IsEnabled", true, 30000);
    functionGetBtnModuleSource.Click();
    functionGetBtnModuleSource.WaitProperty("IsChecked.OleValue", true, 100000);
    Get_CroesusApp().WaitProperty("CPUUsage", 10, 5000);
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 90000);
    var BarTargetMaillage = functionGetBtnModuleDestination.Pad.Text.OleValue;
    
    /*********************Début de l'option de sélection****************************************************************************************************************/
    if (OptionSelect == "SelectOnItem"){
        if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnModels().Pad.Text.OleValue){//Modèles
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transactions
            WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
            Get_TransactionsBar().Click();     
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
            //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
            var FirstLigne=  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text.OleValue
            Get_Transactions_ListView().FindChild("Text",FirstLigne,10).Click();          
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ClientNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();       
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relations
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ShortName.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){//portefeuille
            var FirstLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue){//Titres
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(2).DataItem.SecuFirm.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click();
        }
    }
    else if (OptionSelect == "SelectManyItem"){
        if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnModels().Pad.Text.OleValue ){//Modèles
            Get_Models_Details().set_IsExpanded(false);
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue ){//transactions
            //First Line
            var FirstLigne =  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text.OleValue
            var objFirstLigne = Get_Transactions_ListView().FindChild("Text",FirstLigne,10);
            //WaitProperty("VisibleOnScreen", true, 30000);
            
            //Select Last Line
            var pageDownCount = 0;
            while ((++pageDownCount) < 4 && !Get_Transactions_ListView().FindChildEx(["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["DragableListViewItem", "20", true], 10, true, 5000).Exists){
                Sys.Desktop.Keys("[PageDown]");
            }
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "20"], 10).Click();
            Sys.Desktop.KeyDown(0x10);
            
            //Select up to First Line
            var pageDownCount = 0;
            while ((++pageDownCount) < 5 && !objFirstLigne.Exists && !objFirstLigne.VisibleOnScreen){
                Sys.Desktop.Keys("[PageUp]");
            }
            objFirstLigne.Click();
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue ){//compte
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_RelationshipsClientsAccountsDetails().set_IsExpanded(false);
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnClients().Pad.Text.OleValue ){//client
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_RelationshipsClientsAccountsDetails().set_IsExpanded(false);
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ClientNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.ClientNumber.OleValue;
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue ){//relations
            var k = 19;
            if (client == "CIBC")
                k = 5;
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_RelationshipsClientsAccountsDetails().set_IsExpanded(false);
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ShortName.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(k).DataItem.ShortName.OleValue;
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue ){//portefeuille
            //recherche pour initialiser la grille
            ClickOnToolbarSearchButton();
            Get_WinPortfolioQuickSearch_RdoAccountNo().set_IsChecked(true);
            Get_WinQuickSearch_BtnOK().Click();
            Get_PortfolioGrid_GrpSummary().set_IsExpanded(false);
            var FirstLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.SecurityDescription.OleValue
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(19).DataItem.SecurityDescription.OleValue
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
        else if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue ){//Titres
            // Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(2).DataItem.SecuFirm.OleValue;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
            Sys.Desktop.KeyDown(0x10);
            var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(22).DataItem.SecuFirm.OleValue;
            functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
            Sys.Desktop.KeyUp(0x10);
        }
    }
    /*********************Fin de l'option de sélection****************************************************************************************************************/
    
    /************************************************Début de l'option de maillage*************************************************************************************/
    if (optionMaillage == "dragDrop"){//DRAG DROP
        if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transactions
            WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); //Wait Clients List View 
            Drag(Get_Transactions_ListView().FindChild("Text",FirstLigne,10), functionGetBtnModuleDestination);
        }
        else {
            Drag(functionGetGrillModulSource.FindChild("Value",FirstLigne,10), functionGetBtnModuleDestination);
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive)
                Get_DlgWarning().Keys("[Enter]");
            RestoreAutoTimeOut();
        }
    }
    else if (optionMaillage == "clickRightFunction"){//CLICK RIGHT
        if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue ){//transactions
            Get_Transactions_ListView().FindChild("Text",FirstLigne,10).ClickR();
            Get_Transactions_ListView().FindChild("Text",FirstLigne,10).ClickR();
        }          
        else {
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR();
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR();
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR();
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR();
        }
        
        /************************************************Comptes ou client ou relations*************************************************************/
        if ((Get_ModulesBar_BtnAccounts().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ) || (Get_ModulesBar_BtnClients().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ) || (Get_ModulesBar_BtnRelationships().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )){
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();

            if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Clients().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Accounts().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relation
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Relationships().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transaction
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Transactions().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){//portefeuille
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Portfolio().Click();
                Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 60000);
                WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue){//modèle
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Models().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue){//titre
                Get_ClientsAccountsGrid_ContextualMenu_Functions_Security().Click();
            }
        }
        
        /************************************************Modèles*************************************************************/
        if (Get_ModulesBar_BtnModels().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ){
            Get_ModelsGrid_ContextualMenu_Functions().Click();

            if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
                Get_ModelsGrid_ContextualMenu_Functions_Clients().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
                Get_ModelsGrid_ContextualMenu_Functions_Accounts().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relation
                Get_ModelsGrid_ContextualMenu_Functions_Relationships().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transaction
                Get_ModelsGrid_ContextualMenu_Functions_Transactions().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){//portefeuille
                Get_ModelsGrid_ContextualMenu_Functions_Positions().Click();
            }
        }
        
        /************************************************portefeuille*************************************************************/
        if(Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ){
            Get_PortfolioGrid_ContextualMenu_Functions().Click();
            
            if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
                Get_PortfolioGrid_ContextualMenu_Functions_Clients().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
                Get_PortfolioGrid_ContextualMenu_Functions_Accounts().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relation
                Get_PortfolioGrid_ContextualMenu_Functions_Relationships().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transaction
                Get_PortfolioGrid_ContextualMenu_Functions_Transactions().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue){//modèles
                Get_PortfolioGrid_ContextualMenu_Functions_Models().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue){//titre
                Get_PortfolioGrid_ContextualMenu_Functions_Securities().Click();
            }
        }
        
        /**************************************************Titres*****************************************************************/
        if (Get_ModulesBar_BtnSecurities().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ){
            Get_SecurityGrid_ContextualMenu_Functions().Click();
            
            if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
                Get_SecurityGrid_ContextualMenu_Functions_Clients().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
                Get_SecurityGrid_ContextualMenu_Functions_Accounts().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relation
                Get_SecurityGrid_ContextualMenu_Functions_Relationships().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){//transaction
                Get_SecurityGrid_ContextualMenu_Functions_Transactions().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue){//modèles
                Get_SecurityGrid_ContextualMenu_Functions_Models().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){//portefeuille
                Get_SecurityGrid_ContextualMenu_Functions_Portfolio().Click();
            }
        }
        
        /********************************************Transactions****************************************************************/
        if (Get_ModulesBar_BtnTransactions().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue){//transactions
            var numberOftries = 0;
            while (numberOftries < 5 && !Get_SubMenus().Exists){
                Get_MainWindow().Keys("[Apps]")
                // Get_Transactions_ContextualMenu_Functions().Click();
                numberOftries++;
            }
            
            Get_Transactions_ContextualMenu_Functions().Click();
            
            if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){//client
                Get_Transactions_ContextualMenu_Functions_Clients().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){//compte
                Get_Transactions_ContextualMenu_Functions_Accounts().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue){//modèle
                Get_Transactions_ContextualMenu_Functions_Models().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){//relation
                Get_Transactions_ContextualMenu_Functions_Relationships().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){//portefeuille
                Get_Transactions_ContextualMenu_Functions_Portfolio().Click();
            }
            else if (BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue){//titre
                Get_Transactions_ContextualMenu_Functions_Securities().Click();
            }
        }
    }
    else if (optionMaillage == "menuModule"){//MENU MODULE
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules().DblClick();
        WaitObject(Get_SubMenus(), ["Uid","VisibleOnScreen"], ["CustomizableMenu_8159", true]);  
        
        if (BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue){
            Get_MenuBar_Modules_Accounts().DblClick();
            Get_MenuBar_Modules_Accounts().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_e9d6", true]); 
            Get_MenuBar_Modules_Accounts_DragSelection().Click();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue){
            Get_MenuBar_Modules_Relationships().DblClick();
            Get_MenuBar_Modules_Relationships().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_2435", true]); 
            Get_MenuBar_Modules_Relationships_DragSelection().DblClick();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue){
            Get_MenuBar_Modules_Models().DblClick();
            Get_MenuBar_Modules_Models().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_aba8", true]); 
            Get_MenuBar_Modules_Models_DragSelection().DblClick();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue){
            Get_MenuBar_Modules_Portfolio().DblClick();
            Get_MenuBar_Modules_Portfolio().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_edd3", true],maxWaitTime); 
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){
            Get_MenuBar_Modules_Transactions().DblClick();
            Get_MenuBar_Modules_Transactions().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_92ff", true]); 
            Get_MenuBar_Modules_Transactions_DragSelection().DblClick();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue){
            Get_MenuBar_Modules_Securities().DblClick();
            Get_MenuBar_Modules_Securities().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_088b", true]); 
            Get_MenuBar_Modules_Securities_DragSelection().Click();
        }
        else if (BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue){
            Get_MenuBar_Modules_Clients().DblClick();
            Get_MenuBar_Modules_Clients().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_0d83", true]); 
            Get_MenuBar_Modules_Clients_DragSelection().Click();
        }
    }
    /************************************************Fin de l'option de maillage*************************************************************************************/
    
    functionGetBtnModuleDestination.WaitProperty("IsChecked", true, 300000);// SA: 300000 c'est l'équivalent a 5 minutes je l'ai fait plus pour le maillage vers portefeuile
    
    Log.Message("la variable BarTargetMaillage est : " + BarTargetMaillage);
    if (BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){
        functionGetBarTargetModule = Get_TransactionsPlugin().Find(["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["PadHeader", "1",true], 10)
    }
    
    if (functionGetBarTargetModule == undefined){
        functionGetBarTargetModule =  Get_PortfolioBar();
    }
    
    aqObject.CheckProperty(functionGetBarTargetModule, "Text", cmpEqual, BarTargetMaillage);
}

//--------------RÉÉQUILIBRAGE. L’ÉTAPE 2 : AJOUT DU CASH MANAGEMENT----------------------------------------------------

function ChangeCashMgmtBySleeveDesc(account,sleeveDesc, cashMgmt)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.UnderlyingAccountNumber)==VarToString(account) && VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleeveDesc)){
         position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
         found=true;
         // Modification le 18/02/2020 suite au CR1990 la position de Gestion d'encaisse est devenu 5 au lieu de 4
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    } 
    
}

//--------------FONCTION POUR ENLENER LES ZÉROS EN TROP (EX: 1,4600000) DANS LA FENÊTRE TAUX DE CHANGE-----------------
// Auteur : Amine Alaoui
function RemoveExtraZero(aString){
    
    aString = aqString.Replace(aString, ".", ","); //REMPLACER LE POINT PAR VIRGULE
    var i = aqString.GetLength(aString)-1;
    while (aqString.GetChar(aString, i)=="0"){
        aString = aqString.Remove(aString, i, 1)
        i--;
        };
    if(aqString.GetChar(aString, aqString.GetLength(aString)-1)==",")
        aString = aqString.Remove(aString, aqString.GetLength(aString)-1, 1);                   
    return aString;
}

//------------------- FONCTIONS LIÉS AUX MODÈLES -----------------------------------------------------------------
//Auteur Abdel
function RebalanceModel(modelName){
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
            Get_WinGenerateOrders_BtnGenerate().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            }          
 }
 
 function RemoveRelationshipClientAccountFromModel(modelName,itemNameOrNumber){
            Log.Message("Delete "+itemNameOrNumber+" from model "+modelName);
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelName);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Models_Details_DgvDetails().Find("Value",itemNameOrNumber,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
 }
 
 function AssignClientToModel(clientNo, modelName){
            Log.Message("Associate the client "+clientNo+" to the model "+modelName);
            Get_ModulesBar_BtnClients().Click();
            Search_Client(clientNo);
            var grid = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1);
            grid.Find("Uid","ClientNumber",10).Click();
            grid.Find("Uid","ClientNumber",10).ClickR();
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel().Click();
            Get_WinPickerWindow().Find("Value",modelName,10).DblClick();     
 }
 
 function CheckConflict(){
        Log.Message("Check conflict in Assign to model window");
        var cell = Get_WinAssignToModel().WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1)
        aqObject.CheckProperty(cell, "Value", cmpEqual,"Error");
 }
 function CheckNotConflict(){
        Log.Message("Check not conflict in Assign to model window");
        var cell = Get_WinAssignToModel().WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1)
        aqObject.CheckProperty(cell, "Value", cmpEqual,"Ok");
 }
 function Add_Sleeve(description,target){
        //Ajouter un segment
        Log.Message("----------------- Ajout de segment "+description+" ----------------");
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text( description);
        Get_WinEditSleeve_TxtTargerPercent().set_Text(target)
        Get_WinEditSleeve_BtOK().Click();
}
function EditSleeve(Description, ModelName){
        Log.Message("------------ Associer le modèle "+ModelName+" au segment "+Description+" -----------------");
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",Description,10).Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 10000);
        if (Get_WinManagerSleeves_GrpSleeves_BtnEdit().Enabled == false)
             Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
        Get_WinEditSleeve_TxtValueTextBox().set_Text(ModelName);
        Get_WinEditSleeve_TxtValueTextBox().Keys("[Tab]");
        Get_WinEditSleeve_BtOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
 }
function MoveUnderlyingSecurityToSleeve(sleeveDescription,securityDescription) {
        Log.Message("--------------- Déplacer le titre sous-jacent "+securityDescription+" sur le segment "+sleeveDescription+" ---------------");
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().FindChild("Value",securityDescription,10).Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
        WaitObject(Get_CroesusApp(),"Uid","MoveWindow_baf3");
        Get_WinMoveSecurities_CmbToSleeve().Click();
        Get_SubMenus().Find("WPFControlText",sleeveDescription,10).Click();
        Get_WinMoveSecurities_BtnOk().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MoveWindow_baf3");     
}
function RemoveAccountFromRelationship(relationshipName, accountNo){
        Log.Message("------- Remove the account "+accountNo+" from the relationship "+relationshipName+" ---------");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000); 
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName,10).Click();
        if (Get_RelationshipsClientsAccountsDetails().Find("Value",accountNo,100).Exists){
            Get_RelationshipsClientsAccountsDetails().Find("Value",accountNo,100).ClickR();
            Get_RelationshipsClientsAccountsDetails().Find("Value",accountNo,100).ClickR();
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
            Get_DlgConfirmation_BtnOk().Click();
        }else Log.Message("The account "+accountNo+" is not associated to the relationship "+relationshipName);
}



function MaillageFromOneModuleToTargetModuleMultiValue(functionGetBtnModuleSource, functionGetGrillModulSource) {
          functionGetBtnModuleSource.WaitProperty("IsEnabled", true);
          functionGetBtnModuleSource.Click();

          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnModels().Pad.Text.OleValue) //Modèles
          {
                    var FirstLigne = functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }

          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue) //transactions
          {
                    var FirstLigne = Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text.OleValue
                              Get_Transactions_ListView().FindChild("Text", FirstLigne, 10).Click();
                    //WaitProperty("VisibleOnScreen", true, 30000)

                    Sys.Desktop.KeyDown(0x10);

                    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "20"], 10).Click()

                    Sys.Desktop.KeyUp(0x10);
          }
          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue) //compte
          {
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    var FirstLigne = functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }

          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnClients().Pad.Text.OleValue) //client
          {
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    var FirstLigne = functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ClientNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.ClientNumber.OleValue;
                    functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }
          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue) //relations
          {
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    var FirstLigne = functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ShortName.OleValue;
                    functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.ShortName.OleValue;
                    functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }
          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue) //portefeuille
          {
                    //recherche pour initialiser la grille
                    ClickOnToolbarSearchButton();
                    Get_WinPortfolioQuickSearch_RdoAccountNo().set_IsChecked(true);
                    Get_WinQuickSearch_BtnOK().Click();

                    var FirstLigne = functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.SecurityDescription.OleValue
                              functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(19).DataItem.SecurityDescription.OleValue
                              functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }

          if (functionGetBtnModuleSource.Pad.Text.OleValue == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue) //Titres
          {
                    // Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    var FirstLigne = functionGetGrillModulSource.RecordListControl.Items.Item(2).DataItem.SecuFirm.OleValue;
                    functionGetGrillModulSource.FindChild("Value", FirstLigne, 10).Click();
                    Sys.Desktop.KeyDown(0x10);
                    var LastLigne = functionGetGrillModulSource.RecordListControl.Items.Item(22).DataItem.SecuFirm.OleValue;
                    functionGetGrillModulSource.FindChild("Value", LastLigne, 10).Click();
                    Sys.Desktop.KeyUp(0x10);
          }

}



/**
    Description: Stores in a text file located in the projectsuite folder, couples of data description and data resource location.
                That file will be read by Jenkins in other to publish direct links to download resources.
                For the usage, just call this function whenever, throughout the project, there is a need to have such a link.
                This function does not check for duplicates.
    Parameters:
        dataResourceLocation : remote dataResourceLocation
        dataDescription : a label for data identification (dataDescription must not contains the equals character =)
        checkResourcePathExistence : specifies if the file system path (dataResourceLocation) existence must be validated
                                    if true and dataResourceLocation does not exists, the Data Location will not be published (an error message will be logged)
    Author: Christophe Paring
*/
function PublishDataLocation(dataResourceLocation, dataDescription, checkResourcePathExistence)
{
    var isSuccessful = false;
    
    if (aqString.Find(dataDescription, "=") != -1){
        Log.Error("PublishDataLocation failed. Equals character (=) is forbidden in the parameter 'dataDescription', value provided: '" + dataDescription + "'");
        return false;
    }
    
    if (aqString.Find(dataResourceLocation, ":") != -1){
        Log.Error("PublishDataLocation failed. Character ':' is forbidden in the parameter 'dataResourceLocation', value provided: '" + dataResourceLocation + "'");
        return false;
    }
    
    if (GetVarType(checkResourcePathExistence) != varBoolean){
        Log.Error("PublishDataLocation aborted because the parameter checkResourcePathExistence value ('" + checkResourcePathExistence + "') is missing or is not a boolean (true/false).");
        return false;
    }
    
    if (Project.TestItems.Current != undefined){
        if (checkResourcePathExistence && !aqFileSystem.Exists(dataResourceLocation)){
            Log.Error("PublishDataLocation aborted because the resource path was not found : " + dataResourceLocation);
        }
        else {
            var filePath = '"' + filePath_PublishedDataLocations + '"';
            var newLine = dataDescription + " = " + dataResourceLocation;
            var powershellCmdLines = [];
            powershellCmdLines.push('if (-not(Test-Path ' + filePath + ')) {New-Item -Force -Path ' + filePath + ' -ItemType File}');
            powershellCmdLines.push('Set-Content -Force -Encoding UTF8 -Path ' + filePath + ' -Value "$(Get-Content -Force -Raw -Encoding UTF8 -Path ' + filePath + ' -ErrorAction SilentlyContinue)' + newLine + '"');
    
            isSuccessful = ExecuteCommandsOnPowerShell(powershellCmdLines);
    
            if (isSuccessful)
                Log.Message("PublishDataLocation is successful for '" + dataDescription + " = " + dataResourceLocation + "'. The updated list of published data resources is in the Details panel.", "All published DataLocations\r\n-----------------------------------------------------------------------------------\r\n" + Trim(aqFile.ReadWholeTextFile(filePath_PublishedDataLocations, aqFile.ctUTF8)));
            else
                Log.Error("Error while executing PublishDataLocation for '" + dataDescription + " = " + dataResourceLocation + "'. The actual list of published data resources is in the Details panel.", "All published DataLocations\r\n-----------------------------------------------------------------------------------\r\n" + Trim(aqFile.ReadWholeTextFile(filePath_PublishedDataLocations, aqFile.ctUTF8)));
        }
    }
    
    return isSuccessful;
}

/*****************************************************************************************************************/
/******* Fonction pour ajouter un ordre de vente avec les paramètres quantité, type de transaction et symbol *****/
function AddASellBySymbol(quantity,cmbTransaction,symbol)
{
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    Get_WinSwitchSource_CmbSecurity().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
            
    Get_WinSwitchSource_TxtQuantity().Keys(quantity);
    Get_WinSwitchSource_CmbQuantity().Click();
    Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction],10).Click();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
    Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    if (Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value",symbol,10).DblClick();
    }
    Get_WinSwitchSource_btnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
}
 

 
 /**
    Description: Convert text file encoding to UTF-8 without BOM
                 This function does not check the file new encoding upon update
    Parameter: textFilePath (text file path)
    Returns: true if no error detected, false otherwise (The file new encoding is not checked after update)
    Author: Christophe Paring
*/
function ConvertFileToUtf8WithoutBOM(textFilePath)
{
    Log.Message("ConvertFileToUtf8WithoutBOM: " + textFilePath);
    if (!aqFile.Exists(textFilePath)){
        Log.Error("File not found: " + textFilePath);
        return false;
    }
    else {
        var powershellScript = ['$textFilePath = "' + textFilePath + '";'];
        powershellScript.push('$previousFileAttributes = Attrib $textFilePath; Attrib -R $textFilePath; $updatedFileAttributes = Attrib $textFilePath;');
        powershellScript.push('$textFileContent = "$(Get-Content -Raw -Path $($textFilePath))";');
        powershellScript.push('[System.IO.File]::WriteAllLines($textFilePath, $textFileContent, $(New-Object System.Text.UTF8Encoding $False)) | Out-Null;');
        powershellScript.push('if ($updatedFileAttributes -ne $previousFileAttributes){Attrib +R $textFilePath;}');
        return ExecuteCommandsOnPowerShell(powershellScript);
    }
}



/**
    Description: Ajouter vérifications supplémentaires dans "PreExecution" (typiquement exécutée après la désactivation de la double authentification)
                 https://jira.croesus.com/browse/TCVE-4747
        1. Vérifie si le VServer est en état d'arrêt.
        2. Redémarre les services du VServer (ou démarre le VServer s'il n'est pas en état de marche).
        3. Teste la connexion SSH au VServer.
        4. Teste une ouverture de session avec l'utilisateur par défaut.
        5. Arrête l'exécution de toute la suite si au moins l'un de des deux tests précédents a échoué.
    Paramètres:
        1. vServerURL (URL du VServer)
        2. maxTriesForVServerCheck (Nombre maximal de tentatives pour chacun des tests : connexion SSH et de Login)
            - 0 => désactivation des tests de connexion SSH et de Login
            - valeur par défaut: valeur de la variable globale VSERVER_CHECK_MAXTRIES (ref. Global_variables).
    Version de scriptage: ref90-24-2021-04-3--V9-croesus-co7x-2_1_77
    Auteur: Christophe Paring
*/
function RestartServicesAndCheckVServer(vServerURL, maxTriesForVServerCheck)
{
    try {
        var isSSHConnexionSuccessful, isLoginSuccessful, isVServerRunning, logAttributes, isVServerCheckEnabled;
        var isProjectPerformance = (aqString.Find(projet, "Performance") == 0);
        var loginTestUserName = (isProjectPerformance)? userNamePerformance: userName;
        var loginTestPassword = (isProjectPerformance)? pswPerformance: psw;
        
        //Valider que maxTriesForVServerCheck est un entier positif.
        maxTriesForVServerCheck = (maxTriesForVServerCheck == undefined)? VarToFloat(VSERVER_CHECK_MAXTRIES): VarToFloat(maxTriesForVServerCheck);
        if (maxTriesForVServerCheck < 0 || (GetVarType(maxTriesForVServerCheck) != varInteger && VarToInt(maxTriesForVServerCheck) != maxTriesForVServerCheck)){
            throw new Error ("The maxTriesForVServerCheck value (" + maxTriesForVServerCheck + ") is invalid, please provide a positive integer.");
        }
        
        //Désactiver les tests de connexion SSH et de Login lorsque maxTriesForVServerCheck n'est pas supérieur 0.
        isVServerCheckEnabled = (maxTriesForVServerCheck > 0);
        
        logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        Log.Message("RestartServicesAndCheckVServer '" + vServerURL + "', maxTriesForVServerCheck = " + maxTriesForVServerCheck, "", pmNormal, logAttributes);
        
        //1. Vérifier si le VServer est en état d'arrêt.
        Log.Message("1. Get VServer status...", "", pmNormal, logAttributes);
        isVServerRunning = undefined;
        if (isProjectPerformance){
            Log.Message("Performance execution ('" + projet + "'): GetVServerStatus() will not be performed...", "", pmNormal, logAttributes);
        }
        else {
            try {
                var triesMax = 3;
                var triesCount = 0;
                //Parfois PowerShell ne fonctionne pas à une première tentative. En cas d'échec, essayer jusqu'à triesMax.
                while (isVServerRunning == undefined && (++triesCount) <= triesMax){
                    Log.Message("GetVServerStatus(), attempt N°" + triesCount + "/" + triesMax + "...");
                    isVServerRunning = GetVServerStatus(vServerURL);
                    Log.Message("Is VServer running? " + isVServerRunning);
                }
            }
            catch (excGetVServerStatus){
                Log.Error("Exception: " + excGetVServerStatus.message, VarToStr(excGetVServerStatus.stack));
                excGetVServerStatus =  null;
            }
        }
        
        //2. Redémarrer les services du VServer (ou démarrer le VServer s'il n'est pas en état de marche).
        try {
            if (isVServerRunning === false){
                Log.Message("2. The VServer is not running, start it...", "", pmNormal, logAttributes);
                StartVserver(vServerURL, false, 3);
            }
            else {
                //Lorsque l'état du VServer n'a pu être obtenu, nous convenons d'assumer qu'il est en marche (comme c'est généralement le cas sur Jenkins)
                Log.Message("2. RestartServices...", "", pmNormal, logAttributes);
                RestartServices(vServerURL);
            }
        }
        catch (excRestart){
            Log.Error("Exception: " + excRestart.message, VarToStr(excRestart.stack));
            excRestart =  null;
        }
        
        //Verifier le VServer
        if (isVServerCheckEnabled){
            //3. Tester la connexion SSH au VServer.
            Log.Message("3. TestSSHConnexions...", "", pmNormal, logAttributes);
            try {
                isSSHConnexionSuccessful = TestSSHConnexions(vServerURL, null, null, maxTriesForVServerCheck);
            }
            catch (excSSHConnexion){
                Log.Error("Exception: " + excSSHConnexion.message, VarToStr(excSSHConnexion.stack));
                excSSHConnexion =  null;
            }
            
            //4. Tester une ouverture de session avec l'utilisateur par défaut (ref. Global_variables pour les variables : userName, psw, language).
            Log.Message("4. Login test...", "", pmNormal, logAttributes);
            isLoginSuccessful = Login(vServerURL, loginTestUserName, loginTestPassword, language, null, null, maxTriesForVServerCheck);
        }
    }
    catch (exc){
        Log.Error("Exception: " + exc.message, VarToStr(exc.stack));
        exc =  null;
    }
    finally {
        //5. Arrête l'exécution de toute la suite si au moins l'un de des deux tests a échoué.
        if (isVServerCheckEnabled){
            Log.Message("5. VServer check result...", "", pmNormal, logAttributes);
            if (isLoginSuccessful === true && isSSHConnexionSuccessful === true){
                Log.Checkpoint("VServer check was successful: both SSHConnexion and Login checks succeeded.", "", pmNormal, logAttributes);
            }
            else {
                var resultsMsg = "SSH Connexion test";
                resultsMsg += (isSSHConnexionSuccessful === true)? " was successful.": ((isSSHConnexionSuccessful === false)? " failed.": " result is '" + isSSHConnexionSuccessful + "'.");
                resultsMsg += " Login test";
                resultsMsg += (isLoginSuccessful === true)? " was successful.": ((isLoginSuccessful === false)? " failed.": " result is '" + isLoginSuccessful + "'.");
                Log.Error(resultsMsg, resultsMsg, pmNormal, logAttributes);
            }
            
            Terminate_CroesusProcess();
            if (isLoginSuccessful === false || isSSHConnexionSuccessful === false){
                Log.Error("VServer check has failed. Stopping the whole execution...", "", pmNormal, logAttributes);
                Runner.Stop(false);
            }
        }
    }
}



//Récupère la liste de noms des projets activés dans le projectsuite courant
function GetProjectSuiteEnabledProjectsNamesList()
{
    var arrayOfEnabledProjects = new Array();
    var projectSuiteItems = ProjectSuite.TestItems;
    for (var i = 0; i < projectSuiteItems.ItemCount; i++){
        if (projectSuiteItems.TestItem(i).Enabled){
            arrayOfEnabledProjects.push(VarToStr(projectSuiteItems.TestItem(i).ProjectName));
        }
    }
    
    return arrayOfEnabledProjects;
}



//Retourne le ProjectName à utiliser dans le nom du dossier de Log
function GetExecutionLogProjectName(defaultLogProjectName)
{
    var prefixToRemove = "ProjectSuite";
    var projectSuiteFileName = aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName);
    var logProjectName = (aqString.Find(projectSuiteFileName, prefixToRemove, 0, false) != 0)? projectSuiteFileName: aqString.Remove(projectSuiteFileName, 0, aqString.GetLength(prefixToRemove));
    
    var arrProjectSuitesSplittedByProjects = ["ProjectSuiteMiniRegression", "ProjectSuitePerformance"];
    if (GetIndexOfItemInArray(arrProjectSuitesSplittedByProjects, projectSuiteFileName) == -1){
        if (defaultLogProjectName != undefined){
            logProjectName = defaultLogProjectName;
        }
    }
    else {
        if ((GetProjectSuiteEnabledProjectsNamesList()).length == 1){
            logProjectName += (defaultLogProjectName != undefined)? "-" + defaultLogProjectName: "-" + aqFileSystem.GetFileNameWithoutExtension(Project.FileName);
        }
    }
    
    return logProjectName;
}



function WaitObjectPropertyExistsToFalse(varObject, waitTimeMax)
{
    if (waitTimeMax == undefined){
        waitTimeMax  = 15000;
    }
    
    var interChecksDelay = 1000;
    var waitTimeElapsed = 0;
    while (waitTimeElapsed < waitTimeMax && varObject.Exists){
        Delay(interChecksDelay);
        waitTimeElapsed += interChecksDelay;
        varObject.Refresh();
    }
    
    return (!varObject.Exists);
}



//Ferme les instances de processus Acrobat
function TerminateAcrobatProcess()
{
    TerminateProcess(GetAcrobatProcessName());
}
