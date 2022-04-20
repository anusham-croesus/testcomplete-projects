//USEUNIT CR1485_003_Common_functions
//USEUNIT CR1485_020_Common_functions
//USEUNIT CR1485_061_Common_functions
//USEUNIT CR1485_097_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_097_Cli_ParamDef_Produits()
{
    Log.Message("CR771");
    Log.Message("JIRA CROES-7265");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\\2.3 Clients\\", "CR1485_097_Cli_ParamDef_Produits()");
    
    try {
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
        var arrayOfCoupledReportNames = [];
        arrayOfCoupledReportNames.push(GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 1, language));
        arrayOfCoupledReportNames.push(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language));
        arrayOfCoupledReportNames.push(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language));
        var clientsNumbers = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 252);
        
        var accountNumberAndProductAndSecondaryProductForAccount800049NA = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 253, language);
        var accountNumberAndProductAndSecondaryProductForAccount800049OB = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 254, language);
        var accountNumberAndNumberOfProductTypeForAccount800049RE = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 255, language);
                
        //Preparation
        CR1485_PreparationBD_CR771(userNameKEYNEJ);
        
        //Login and goto the module and select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Validation du Type de produit (produit et produit secondaire) pour le compte 800049-NA
        var arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049NA = accountNumberAndProductAndSecondaryProductForAccount800049NA.split("|");
        var accountNumber800049NA = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049NA[0];
        var expectedProduct800049NA = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049NA[1];
        var expectedSecondaryProduct800049NA = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049NA[2];
        ValidateProductTypeForAccount(accountNumber800049NA, expectedProduct800049NA, expectedSecondaryProduct800049NA);
        
        //Validation du Type de produit (produit et produit secondaire) pour le compte 800049-OB
        var arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049OB = accountNumberAndProductAndSecondaryProductForAccount800049OB.split("|");
        var accountNumber800049OB = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049OB[0];
        var expectedProduct800049OB = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049OB[1];
        var expectedSecondaryProduct800049OB = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049OB[2];
        ValidateProductTypeForAccount(accountNumber800049OB, expectedProduct800049OB, expectedSecondaryProduct800049OB);
        
        //Validation du nombre de Type de produit pour le compte 800049-RE
        var arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049RE = accountNumberAndNumberOfProductTypeForAccount800049RE.split("|");
        var accountNumber800049RE = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049RE[0];
        var expectedNbOfProductType800049RE = arrayOfAccountNumberAndProductAndSecondaryProductForAccount800049RE[1];
        ValidateProductTypeCountForAccount(accountNumber800049RE, expectedNbOfProductType800049RE);
        
        //Aller au module Clients pour produire les rapports
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 260);
        
        //Open Reports window
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select Coupled reports and then Main report
        SelectReports(arrayOfCoupledReportNames);
        SelectAReport(reportName);
        
        //Reports options values
        var destination = null;
        var sortBy = null;
        var currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 258, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 259, language);
        var checkAddBranchAddress = null;
        var checkGroupInTheSameReport = null;
        var checkConsolidatePositions = null;
        var checkGroupUnderlyingClients = null;
        var checkIncludeMessage = null;
        var message = null;
        
        //Set Reports options
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");   
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 265);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 263, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 264, language);
        
        //Open Reports window
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select Coupled reports and then Main repor
        SelectReports(arrayOfCoupledReportNames);
        SelectAReport(reportName);
        
        //Set Reports options
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        CR1485_RestoreBD_CR771(userNameKEYNEJ);
        Terminate_CroesusProcess();
    }
    
}



function CR1485_PreparationBD_CR771(testUser)
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\\2.3 Clients\\", "CR1485_PreparationBD_CR771()");
    
    var folderPathCR771 = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR771\\";
    oldValue_B_CONFIG_NOTE = Execute_SQLQuery_GetField("select NOTE from B_CONFIG where CLE = 'FD_DT_ACCTYPE'", vServerReportsCR1485, 'NOTE');
    arrayOfInserted_B_DICT_ENTRY_ID = [];
    
    //Activate Prefs:
    CR1485_003_Common_functions.ActivatePrefs();
    CR1485_020_Common_functions.ActivatePrefs();
    CR1485_061_Common_functions.ActivatePrefs();
    CR1485_097_Common_functions.ActivatePrefs();
    var firmCode = GetUserFirmCode(testUser, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(firmCode, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    UpdatePrefAtLevelForUser(testUser, "PREF_DISPLAY_ASC_CODE", "FIRMADM", "FIRM", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
    
    //1. Rouler le script (Config CR-771.sql)
    //1.1. Modifier l'ancien paramètre dans B_CONFIG
    var update_B_CONFIG_SQLFilePath = folderPathCR771 + "Config CR-771 B_CONFIG.sql";
    var update_B_CONFIG_SQLFileContent = Trim(aqFile.ReadWholeTextFile(update_B_CONFIG_SQLFilePath, aqFile.ctUTF8));
    Execute_SQLQuery(update_B_CONFIG_SQLFileContent, vServerReportsCR1485);
    
    //1.2. Créer le entrées du dictionnaire si n'existe pas dans la BD
    var update_B_DICT_SQLFilePath = folderPathCR771 + "Config CR-771 B_DICT.sql";
    var SQLFileContent = Trim(aqFile.ReadWholeTextFile(update_B_DICT_SQLFilePath, aqFile.ctUTF8));
    Log.Message("Execute SQL file content : " + update_B_DICT_SQLFilePath, SQLFileContent);
    var lineSeparator = (aqString.Find(SQLFileContent, "\r\n") == -1)? "\n": "\r\n";
    var arrayOfSQLLines = SQLFileContent.split(lineSeparator);
    var rowsCountBeforeSQL = GetNbOfRecordsIn_B_DICT();
    for (var i in arrayOfSQLLines){
        try {
            var querySQL = Trim(arrayOfSQLLines[i]);
            if (GetIndexOfItemInArray(['go', ''], aqString.ToLower(querySQL)) == -1)
                Execute_SQLQuery(querySQL, vServerReportsCR1485);
        }
        catch (sqlException){
            if (aqString.Find(VarToStr(sqlException.message), 'Attempt to insert duplicate key row in object') == -1)
                Log.Error("SQL Exception at line " + IntToStr(i + 1) + " : " + sqlException.message, querySQL);
            sqlException = null;
        }
    }
    var arrayOfNew_B_DICT_ENTRY_ID = Execute_SQLQuery_GetFieldAllValues("select top " + GetNbOfNewRecordsIn_B_DICT(rowsCountBeforeSQL, arrayOfSQLLines.length) + " ENTRY_ID from B_DICT ORDER BY ENTRY_ID DESC", vServerReportsCR1485, 'ENTRY_ID');
    arrayOfInserted_B_DICT_ENTRY_ID = arrayOfInserted_B_DICT_ENTRY_ID.concat(arrayOfNew_B_DICT_ENTRY_ID);
    
    //2. loader le fichier (pro_CR771_BDQA.xml)
    var vserverRemoteFolder = "/home/albertoq/CR771/";
    var loaderXmlBakFileName = "pro_CR771_BDQA.xml";
    var loaderXmlFileName = "pro_CR771_BDQA_" + executionComputerName + ".xml";
    if (!aqFileSystem.CopyFile(folderPathCR771 + loaderXmlBakFileName, folderPathCR771 + loaderXmlFileName))
        Log.Error("Problème de copie du fichier '" + loaderXmlBakFileName + "' vers '" + loaderXmlFileName + "'", "Dossier : " + folderPathCR771);
    var loaderSSHCommand = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
    loaderSSHCommand += "cd '" + vserverRemoteFolder + "' \r\n";
    loaderSSHCommand += "loader " + loaderXmlFileName + " -FORCE -LOG2STDOUT" + " | tee " + loaderXmlFileName + ".log\r\n";
    TryConnexionAndTrustHostKeyThroughWinSCP(vServerReportsCR1485);
    CopyFileToVserverThroughWinSCP(vServerReportsCR1485, vserverRemoteFolder, folderPathCR771 + loaderXmlFileName);
    ExecuteSSHCommandCFLoader("CR771", vServerReportsCR1485, loaderSSHCommand, testUser);
    
    //3. Stop/start du vserver.
    RestartVserver(vServerReportsCR1485);
    
    
    function GetNbOfRecordsIn_B_DICT()
    {
        return VarToInt(Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_DICT", vServerReportsCR1485, "nbOfRows"));
    }
    
    function GetNbOfNewRecordsIn_B_DICT(formerNbOfRowsIn_B_DICT, nbOfExpectedNewRecords, timeOutForTableUpdate)
    {
        if (nbOfExpectedNewRecords == undefined) nbOfExpectedNewRecords = 1;
        if (timeOutForTableUpdate == undefined) timeOutForTableUpdate = 6000;
    
        var timeEllapsedDB = 0;
        do {
            var nbOfActualNewRecords = GetNbOfRecordsIn_B_DICT() - formerNbOfRowsIn_B_DICT;
        
            if (nbOfActualNewRecords >= nbOfExpectedNewRecords){
                Delay(5000); //Attendre encore un petit temps pour voir s'il n'y aura pas d'enregistrements supplémentaires
                nbOfActualNewRecords = GetNbOfRecordsIn_B_DICT() - formerNbOfRowsIn_B_DICT;
                break;
            }
        
            Delay(3000);
            timeEllapsedDB += 3000;
        } while (timeEllapsedDB < timeOutForTableUpdate)
    
        return nbOfActualNewRecords;
    }
}



function ValidateProductTypeCountForAccount(accountNumber, expectedNbOfProductType)
{
    Log.Message("Validate Number of Product Type for Account '" + accountNumber + "' : expected number Of Product Type = '" + expectedNbOfProductType + "'.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 1000000);
    SelectAccounts(accountNumber);
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProductTypes().Click();
    Get_WinAccountInfo_TabProductTypes().WaitProperty("IsSelected", true, 30000);
    var winAccountInfoTitle = Get_WinAccountInfo().Title;
    var arrayOfProductTypesRows =  Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindAllChildren(["ClrClassName", "IsVisible"], ["DragableListViewItem", true], 10).toArray();
    var isValidationSuccessfull = CheckEquals(arrayOfProductTypesRows.length, expectedNbOfProductType, "The number of Product Type for Account '" + accountNumber + "'");
    Get_WinAccountInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", winAccountInfoTitle], 30000);
    return isValidationSuccessfull;
}



function ValidateProductTypeForAccount(accountNumber, expectedProduct, expectedSecondaryProduct)
{
    Log.Message("Validate Product Type for Account '" + accountNumber + "' : expected Product = '" + expectedProduct + "', expected Secondary Product = '" + expectedSecondaryProduct + "'.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 1000000);
    SelectAccounts(accountNumber);
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProductTypes().Click();
    Get_WinAccountInfo_TabProductTypes().WaitProperty("IsSelected", true, 30000);
    
    var productColumnHeader = Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChProduct();
    var productColumnHeaderLeftX = productColumnHeader.Left;
    var productColumnHeaderRightX = productColumnHeaderLeftX + productColumnHeader.Width;
    var secondaryProductColumnHeader = Get_WinAccountInfo_TabProductTypes_DgvProductTypes_ChSecondaryProduct();    
    var secondaryProductColumnHeaderLeftX = secondaryProductColumnHeader.Left;
    var secondaryProductColumnHeaderRightX = secondaryProductColumnHeaderLeftX + secondaryProductColumnHeader.Width;
    
    var winAccountInfoTitle = Get_WinAccountInfo().Title;
    var arrayOfProductTypesRows =  Get_WinAccountInfo_TabProductTypes_DgvProductTypes().FindAllChildren(["ClrClassName", "IsVisible"], ["DragableListViewItem", true], 10).toArray();
    for (var rowIndex in arrayOfProductTypesRows){
        var arrayOfProductTypeRowCells = arrayOfProductTypesRows[rowIndex].FindAllChildren(["ClrClassName", "IsVisible"], ["BrowserCellTemplateSimple", true], 10).toArray();;
        var productCell = Utils.CreateStubObject();
        var secondaryProductCell = Utils.CreateStubObject();
        for (var cellIndex = 0; cellIndex < arrayOfProductTypeRowCells.length; cellIndex++){
            var productTypeRowCell = arrayOfProductTypeRowCells[cellIndex];
            var productTypeRowCellMiddleX = productTypeRowCell.Left + (productTypeRowCell.Width/2);
            if (productTypeRowCellMiddleX > productColumnHeaderLeftX && productTypeRowCellMiddleX < productColumnHeaderRightX)
                productCell = productTypeRowCell;
            else if (productTypeRowCellMiddleX > secondaryProductColumnHeaderLeftX && productTypeRowCellMiddleX < secondaryProductColumnHeaderRightX)
                secondaryProductCell = productTypeRowCell;
        }
        
        var product = (productCell.Exists)? VarToStr(productCell.Text): "";
        var secondaryProduct = (secondaryProductCell.Exists)? VarToStr(secondaryProductCell.Text): "";
        if (product == expectedProduct && secondaryProduct == expectedSecondaryProduct){
            Log.Checkpoint("Compte '" + accountNumber + "' : produit '" + expectedProduct + "' et produit secondaire '" + expectedSecondaryProduct + "' trouvés dans la liste des Types de produits.");
            Get_WinAccountInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", winAccountInfoTitle], 30000);
            return true;
        }
    }
    
    Log.Error("Compte '" + accountNumber + "' : produit '" + expectedProduct + "' et produit secondaire '" + expectedSecondaryProduct + "' non trouvés dans la liste des Types de produits.");
    Get_WinAccountInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", winAccountInfoTitle], 30000);
    return false;
}



function CR1485_RestoreBD_CR771(testUser)
{ 
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\\2.3 Clients\\", "CR1485_RestoreBD_CR771()");
    
    if (typeof arrayOfInserted_B_DICT_ENTRY_ID != "undefined" && arrayOfInserted_B_DICT_ENTRY_ID != undefined && arrayOfInserted_B_DICT_ENTRY_ID.length > 0)
        Execute_SQLQuery("delete from B_DICT where ENTRY_ID in (" + arrayOfInserted_B_DICT_ENTRY_ID + ")", vServerReportsCR1485);
    
    if (typeof oldValue_B_CONFIG_NOTE != "undefined" && oldValue_B_CONFIG_NOTE != undefined)
        Execute_SQLQuery('update b_config set NOTE = "' + oldValue_B_CONFIG_NOTE + '" where CLE = "FD_DT_ACCTYPE"', vServerReportsCR1485);
    
    var firmCode = GetUserFirmCode(testUser, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(firmCode, "PREF_ADD_THEORETICAL_VALUE", null, vServerReportsCR1485);
    UpdatePrefAtLevelForUser(testUser, "PREF_DISPLAY_ASC_CODE", null, "FIRM", vServerReportsCR1485);
    
    RestartVserver(vServerReportsCR1485);
}



/**
    Fonction générique pour récupérer le FIRM_CODE d'un utilisateur
*/
function GetUserFirmCode(user, vServerURL)
{
    var no_succ = Execute_SQLQuery_GetField("select NO_SUCC from B_USER where STATION_ID = '" + user + "'", vServerURL, "NO_SUCC");
    var firm_id = Execute_SQLQuery_GetField("select FIRM_ID from B_SUCC where NO_SUCC = '" + no_succ + "'", vServerURL, "FIRM_ID");
    var firm_code = Execute_SQLQuery_GetField("select FIRM_CODE from B_FIRM where FIRM_ID = " + firm_id, vServerURL, "FIRM_CODE");
    return firm_code;
}