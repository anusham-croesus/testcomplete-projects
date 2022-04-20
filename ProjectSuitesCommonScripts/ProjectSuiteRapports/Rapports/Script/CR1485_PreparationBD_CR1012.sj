//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_097_Cli_ParamDef_Produits



/**
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.2 Comptes\Étapes CR1012\
    
    Configuration du CR1012 pour les rapports suivants :
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\20. Évaluation du portefeuille (avancé)\3.1 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\61. Évaluation du portefeuille (intermédiaire)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\2.1 Clients
*/
function CR1485_PreparationBD_CR1012()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\3. Évaluation du portefeuille (simple)\\3.2 Comptes\\Étapes CR1012\\", "CR1485_PreparationBD_CR1012()");
    
    try {
        var externalClientName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalClient_Name", language);
        var externalAccountsCount = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalAccounts_Count", language));
        
        var folderPathCR1012 = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR1012\\";
        var vserverRemoteFolder = "/home/albertoq/CR1012/";
        var loaderSSHCommands = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommands += "cd '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommands += aqFile.ReadWholeTextFile(folderPathCR1012 + "LoaderCommandesInsertionTransactions.sh", aqFile.ctUTF8);
        
        //1. Créér un client externe, 2. Mailler le client externe vers comptes et créer 3 comptes externes
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        var arrayOfFormerClientNumbers = GetClientsNumbersFromClientName(externalClientName);    
        CreateExternalClient(externalClientName);
        var arrayOfClientNumbers = GetClientsNumbersFromClientName(externalClientName);
        var numberOfExternalClientsCreated = arrayOfClientNumbers.length - arrayOfFormerClientNumbers.length;
        if (numberOfExternalClientsCreated != 1)
            return Log.Error(numberOfExternalClientsCreated + " nouveaux client(s) créés au lieu de 1.");
        
        for (var i in arrayOfClientNumbers){
            if (GetIndexOfItemInArray(arrayOfFormerClientNumbers, arrayOfClientNumbers[i]) == -1){
                externalClientNumber = arrayOfClientNumbers[i];
                break;
            }
        }
        
        var arrayOfExternalAccountsNumbers = CreateExternalClientAccounts(externalClientNumber, externalAccountsCount);
        if (0 != aqFile.SetFileAttributes(filePath_ReportsCR1485, 128))
            Log.Error("Il y a eu erreur lors de la modification d'attributs du fichier : " + filePath_ReportsCR1485);
        WriteExcelSheetByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalClient_Number", "french", externalClientNumber);
        WriteExcelSheetByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalClient_Number", "english", externalClientNumber);
        WriteExcelSheetByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalAccounts_Numbers", "french", arrayOfExternalAccountsNumbers.join("|"));
        WriteExcelSheetByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1012", "CR1012_ExternalAccounts_Numbers", "english", arrayOfExternalAccountsNumbers.join("|"));
        
        //Récupérer le contenu du fichier ListeComptesExternesARemplacerDansXML.txt
        var externalAccountsInXmlGabaritFileFileContent = aqFile.ReadWholeTextFile(folderPathCR1012 + "ListeComptesExternesARemplacerDansXML.txt", aqFile.ctUTF8);
        var lineSeparator = (aqString.Find(externalAccountsInXmlGabaritFileFileContent, "\r\n") == -1)? "\n": "\r\n";
        var externalAccountsLines = externalAccountsInXmlGabaritFileFileContent.split(lineSeparator);
        for (var j in externalAccountsLines)
            externalAccountsLines[j] = Trim(externalAccountsLines[j]);
        
        //3, 4. Dossier XML / Dans chaque XML remplacer le No. de compte externe à la ligne 5, par chaque numéro de compte de l'étape 2 respectivement
        for (var i = 0; i < externalAccountsCount; i++){
            var xmlFileName = "Ex" + IntToStr(i + 1) + "_tra_comptesexternes_" + executionComputerName + ".xml";
            var xmlFilePath = folderPathCR1012 + xmlFileName;
            var xmlGabaritFileName = "Ex" + IntToStr(i + 1) + "_tra_comptesexternes.xml";
            var xmlGabaritFilePath = folderPathCR1012 + xmlGabaritFileName;
            if (!aqFileSystem.Exists(xmlGabaritFilePath)){
                Log.Error("Fichier XML gabarit non trouvé : " + xmlGabaritFilePath);
                continue;
            }
            
            //Récupérer info à remplacer dans le fichier gabarit XML
            var arrayOfExternalAccountInXmlGabaritFile = [];
            for (var k in externalAccountsLines){
                if (aqString.Find(externalAccountsLines[k], xmlGabaritFileName) == 0){
                    var stringAfterFileName = Trim(aqString.SubString(externalAccountsLines[k], xmlGabaritFileName.length, externalAccountsLines[k].length - xmlGabaritFileName.length));
                    if (stringAfterFileName != "")
                        arrayOfExternalAccountInXmlGabaritFile.push(stringAfterFileName);
                }
            }
            
            var xmlGabaritFileContent = aqFile.ReadWholeTextFile(xmlGabaritFilePath, aqFile.ctUTF8);
            var xmlFileContent = xmlGabaritFileContent;
            for (var p in arrayOfExternalAccountInXmlGabaritFile){
                var externalAccountInXmlGabaritFile = arrayOfExternalAccountInXmlGabaritFile[p];
                if (aqString.Find(xmlGabaritFileContent, externalAccountInXmlGabaritFile) == -1)
                    Log.Error("No. de compte externe '" + externalAccountInXmlGabaritFile + "' à remplacer non trouvé dans le fichier XML gabarit : " + xmlGabaritFilePath, xmlGabaritFileContent);
                xmlFileContent = aqString.Replace(xmlFileContent, externalAccountInXmlGabaritFile, arrayOfExternalAccountsNumbers[i]);
            }
            
            if (aqFileSystem.Exists(xmlFilePath))
                aqFileSystem.DeleteFile(xmlFilePath);
            
            if (!aqFile.WriteToTextFile(xmlFilePath, xmlFileContent, aqFile.ctUTF8, true))
                Log.Error("Échec de création du fichier : " + xmlFilePath, xmlFileContent);
            else {
                loaderSSHCommands = aqString.Replace(loaderSSHCommands, xmlGabaritFileName, xmlFileName);
                CopyFileToVserverThroughWinSCP(vServerReportsCR1485, vserverRemoteFolder, xmlFilePath);
            }
        }
        
        //5. Insérer les fichiers des transactions XML pour chaque compte
        ExecuteSSHCommandCFLoader("CR1012", vServerReportsCR1485, loaderSSHCommands, userNameReportsCR1485);
        
        //6. Faire un stop/start
        CloseCroesus();
        RestartVserver(vServerReportsCR1485);
    }
    catch(exception_CR1485_PreparationBD_CR1012){
        Log.Error("Exception : " + exception_CR1485_PreparationBD_CR1012.message, VarToStr(exception_CR1485_PreparationBD_CR1012.stack));
        exception_CR1485_PreparationBD_CR1012 = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function Activate_PREF_RPT_DISPLAY_ISSUER_NOTE_Catego(securitySecufirm)
{
    var securityCatego = Execute_SQLQuery_GetField("select CATEGO from B_TITRE where SECUFIRME = '" + securitySecufirm + "'", vServerReportsCR1485, "CATEGO");
    if (securityCatego == null)
        Log.Error("CATEGO non trouvé pour le titre '" + securitySecufirm + "'");
    else
        Log.Message("SECUFIRME = " + securitySecufirm + ", CATEGO = " + securityCatego);
    
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "PREF_RPT_DISPLAY_ISSUER_NOTE", securityCatego, "FIRM", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}


function SetToDefault_PREF_RPT_DISPLAY_ISSUER_NOTE_Catego()
{
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "PREF_RPT_DISPLAY_ISSUER_NOTE", null, "FIRM", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function CreateExternalClientAccounts(clientNumber, nbOfAccounts)
{
    Get_ModulesBar_BtnAccounts().Click();
	Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(3000);
    Get_ModulesBar_BtnClients().Click();
	Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(3000);
    Search_Client(clientNumber);    
    Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["ClientNumber", clientNumber], 10), Get_ModulesBar_BtnAccounts());
    SetAutoTimeOut(3000);
    if (Get_DlgWarning().Exists)
        Get_DlgWarning().Click(Get_DlgWarning().Width/2, Get_DlgWarning().Height-45);
    RestoreAutoTimeOut();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    
    var arrayOfExternalAccountsNumbers = [];
    var arrayOfFormerAccountsNumbers = GetAccountsNumbers();
    for (var i = 1; i <= nbOfAccounts; i++){
        ClickOnToolbarAddButton();
        var winAccountInfoTitle = Get_WinAccountInfo().Title;
        Get_WinAccountInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", winAccountInfoTitle], 30000);
        var arrayOfCurrentAccountsNumbers = GetAccountsNumbers();
        for (var k = 0; k < arrayOfCurrentAccountsNumbers.length; k++)
            if (GetIndexOfItemInArray(arrayOfFormerAccountsNumbers, arrayOfCurrentAccountsNumbers[k]) == -1)
                arrayOfExternalAccountsNumbers.push(arrayOfCurrentAccountsNumbers[k]);
        
        arrayOfFormerAccountsNumbers = arrayOfCurrentAccountsNumbers;
    }
    
    if (arrayOfExternalAccountsNumbers.length != nbOfAccounts)
        Log.Error(arrayOfExternalAccountsNumbers.length + " comptes externes effectivement créés au lieu de " + nbOfAccounts, arrayOfExternalAccountsNumbers);
    
    return arrayOfExternalAccountsNumbers;
    
    function GetAccountsNumbers()
    {
        var arrayOfAccountsNumbers = [];
        var recordListControl = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1);
        recordListControl.Refresh();
        for (var j = 0; j < recordListControl.Items.Count; j++)
            arrayOfAccountsNumbers.push(VarToStr(recordListControl.Items.Item(j).DataItem.AccountNumber));
        return arrayOfAccountsNumbers;
    }
}



function GetClientsNumbersFromClientName(clientName)
{
    var arrayOfClientNameClientsNumbers = new Array();
    Get_ModulesBar_BtnClients().Click();
	Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(3000);
    SearchClientByName(clientName);
    var allClientNameCells = Get_RelationshipsClientsAccountsGrid().FindAllChildren(["Uid", "Value"], ["Name", clientName], 10).toArray();
    for (var j in allClientNameCells)
        arrayOfClientNameClientsNumbers.push(allClientNameCells[j].DataContext.DataItem.ClientNumber.OleValue);
    return arrayOfClientNameClientsNumbers;
}



function FindExcelRowNumberByRowID(filePath, sheetName, SoughtForValue, displayErrorIfNotFound)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var i = 1;
    
    // Iterates through records
    while (! Driver.EOF()) {
        i++;
        if (Driver.Value(0) == SoughtForValue) {
            DDT.CloseDriver(Driver.Name);
            return i;
        }
        Driver.Next();
    }
    
    if (displayErrorIfNotFound == undefined || displayErrorIfNotFound == true)
        Log.Error("la ligne recherchée n'existe pas : " + SoughtForValue);
    
    DDT.CloseDriver(Driver.Name);
    return null;
}



function FindExcelColumnNumberByColumnID(filePath, sheetName, SoughtForValue, displayErrorIfNotFound)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    for (var columnIndex = 0; columnIndex < Driver.ColumnCount; columnIndex++){
        if (Driver.ColumnName(columnIndex) == SoughtForValue){
            DDT.CloseDriver(Driver.Name);
            return (columnIndex + 1);
        }
    }
    
    if (displayErrorIfNotFound == undefined || displayErrorIfNotFound == true)
        Log.Error("la colonne recherchée n'existe pas : " + SoughtForValue);
    
    DDT.CloseDriver(Driver.Name);
    return null;
}


function WriteExcelSheetByRowIDColumnID(filePath, sheetName, rowID, columnID, data)
{
    var rowIndex = FindExcelRowNumberByRowID(filePath, sheetName, rowID, true);
    var columnIndex = FindExcelColumnNumberByColumnID(filePath, sheetName, columnID, true);
    WriteExcelSheet(filePath, sheetName, rowIndex, columnIndex, data);
}
