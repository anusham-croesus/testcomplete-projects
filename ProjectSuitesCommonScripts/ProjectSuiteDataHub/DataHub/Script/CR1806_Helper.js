//USEUNIT Common_functions
//USEUNIT ExcelUtils
//USEUNIT DBA




var defaultTimeOutForDataHubTableUpdate = 60000; //1 minute

var exportMethod_Toolbar_Print = "TOOLBAR_PRINT";
var exportMethod_CTRL_C = "CTRL+C";
var exportMethod_X_Button_ExportToMSExcel = "EXPORTTOMSEXCEL_X";
var exportMethod_MenuBar_Copy = "MENUBAR_COPY";
var exportMethod_MenuBar_CopyWithHeader = "MENUBAR_COPYWITHHEADER";
var exportMethod_MenuBar_ExportToFile = "MENUBAR_EXPORTTOFILE";
var exportMethod_MenuBar_ExportToMSExcel = "MENUBAR_EXPORTTOMSEXCEL";
var exportMethod_MenuBar_Print = "MENUBAR_PRINT";
var exportMethod_ClickR_Copy = "CLICKR_COPY";
var exportMethod_ClickR_CopyWithHeader = "CLICKR_COPYWITHHEADER";
var exportMethod_ClickR_ExportToFile = "CLICKR_EXPORTTOFILE";
var exportMethod_ClickR_ExportToMSExcel = "CLICKR_EXPORTTOMSEXCEL";
var exportMethod_ClickR_Print = "CLICKR_PRINT";
var exportMethod_Toolbar_Reports = "TOOLBAR_REPORTS";
var exportMethod_MenuBar_Reports = "MENUBAR_REPORTS";

var projectName_DataHub = "DATAHUB";
var moduleName_Dashboard = "DASHBOARD";
var moduleName_Models = "MODELES";
var moduleName_Relationships = "RELATIONS";
var moduleName_Clients = "CLIENTS";
var moduleName_Accounts = "COMPTES";
var moduleName_Portfolio = "PORTEFEUILLE";
var moduleName_Transactions = "TRANSACTIONS";
var moduleName_Securities = "TITRES";
var moduleName_Orders = "ORDRES";
var moduleName_Orders_Accumulator = "ORDRES_ACCUMULATEUR";



var printingDlgBoxTitle = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "printingDlgBoxTitle", language + client); ////ToBeDeleted

var successfullExportMessage = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "successfullExportMessage", language + client);

var noDataToExportMessage = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "noDataToExportMessage", language + client);

var informationDlgBoxTitle = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "informationDlgBoxTitle", language + client);

var printDlgBoxTitle = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "printDlgBoxTitle", language + client);

var printingStatusMessageLogsDlgBoxTitle = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "PrintingStatusMessageLogsDlgBoxTitle", language + client);

var DataHubExtractor_DefaultNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_DefaultNamePrefix", language + client);

var DataHubExtractor_FileNameSeparator = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_FileNameSeparator", language + client);

var DataHubExtractor_DefaultNameDate = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_DefaultNameDate", language + client);

var DataHubExtractor_FileNameExtension = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_FileNameExtension", language + client);

var DataHubExtractor_FileNameDateSeparator = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_FileNameDateSeparator", language + client);

var DataHubExtractor_SuccessfulString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_SuccessfulString", language + client);

var DataHubExtractor_ProcessingEndedStringPattern = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_ProcessingEndedStringPattern", language + client);

var vserverDefaultFolder = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_VserverDefaultFolder", language + client);

var localFolder = Project.Path;

var IACodeColumnName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "ColumnName_IACode", language + client);


//Les noms de colonne dans la table B_DATA_HUB
var DataHub_ColumnName_TASK_ID = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_TASK_ID", language + client);
var DataHub_ColumnName_DATE_GENERATION = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_DATE_GENERATION", language + client);
var DataHub_ColumnName_STATION_ID = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_STATION_ID", language + client);
var DataHub_ColumnName_LASTNAME_USER = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_LASTNAME_USER", language + client);
var DataHub_ColumnName_FIRSTNAME_USER = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_FIRSTNAME_USER", language + client);
var DataHub_ColumnName_EMAIL = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_EMAIL", language + client);
var DataHub_ColumnName_ACCES = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_ACCES", language + client);
var DataHub_ColumnName_SUCC_ID = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_SUCC_ID", language + client);
var DataHub_ColumnName_SUCC_NAME = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_SUCC_NAME", language + client);
var DataHub_ColumnName_IA_CODES = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_IA_CODES", language + client);
var DataHub_ColumnName_FUNCTION_NAME = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_FUNCTION_NAME", language + client);
var DataHub_ColumnName_FUNCTION_ID = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_FUNCTION_ID", language + client);
var DataHub_ColumnName_NB_RECORDS = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_ColumnName_NB_RECORDS", language + client);



function GetDataHubFirstValue(fieldName)
{
    return Execute_SQLQuery_GetField("select top 1 " + fieldName + " from B_DATA_HUB order by TASK_ID asc", vServerDataHub, fieldName);
}


function GetDataHubLastValues(fieldName, nbOfLastRecords)
{
    var queryNbOfRecordsPart = (nbOfLastRecords == undefined)? "": " top " + nbOfLastRecords;
    return Execute_SQLQuery_GetFieldAllValues("select" + queryNbOfRecordsPart + " " + fieldName + " from B_DATA_HUB order by TASK_ID desc", vServerDataHub, fieldName);
}


function GetDataHubLastValue(fieldName)
{
    return GetDataHubLastValues(fieldName, 1);
}



function GetDataHubNbOfRecords()
{
    return VarToInt(Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_DATA_HUB", vServerDataHub, "nbOfRows"));
}



function DeleteAllInDataHub()
{
    Execute_SQLQuery("delete from B_DATA_HUB", vServerDataHub);
}


/**
    Supprime les doublons dans un array
*/
function GetArrayUniqueValues(arr)
{
    var uniqueValuesArray = [];
    for (var k in arr)
        if (GetIndexOfItemInArray(uniqueValuesArray, arr[k]) == -1)
            uniqueValuesArray.push(arr[k]);
    
    return uniqueValuesArray;
}




function ExecuteManyExportsFromModule(connectedUser, moduleName, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod)
{
    try {
        Log.AppendFolder(moduleName);
        
        if (shouldExportSuccess == undefined) shouldExportSuccess = true;
        if (isCfLoaderCommandToBeChecked == undefined) isCfLoaderCommandToBeChecked = true;
        if (arrayOfExportMethod == undefined) arrayOfExportMethod = GetAllExportMethodsForModule(moduleName);
    
        if (GetVarType(arrayOfExportMethod) != varArray && GetVarType(arrayOfExportMethod) != varDispatch)
            arrayOfExportMethod = new Array(arrayOfExportMethod);
    
        GotoModule(moduleName);
    
        //Valeurs attendues dans le nouvel enregistrement de la table B_DATA_HUB (les champs qui ont le plus d'impact)
        if (shouldExportSuccess){
            if (moduleName == moduleName_Orders_Accumulator)
                var arrayOfIACodes = GetAllDisplayedIACodesThroughExportToFile(Get_OrderAccumulatorGrid());
            else if (moduleName == moduleName_Securities){
                var arrayOfSecurities = GetAllDisplayedSecuritiesThroughExportToFile();
                var expectedNbOfRecords = arrayOfSecurities.length;
                var expectedIACodes = GetExpectedIACodesString(null, moduleName_Securities);
            }
            else
                var arrayOfIACodes = GetAllDisplayedIACodesThroughExportToFile();
        
            if (moduleName != moduleName_Securities){
                var expectedNbOfRecords = arrayOfIACodes.length;
                var expectedIACodes = GetExpectedIACodesString(arrayOfIACodes);
            }
        
            var expectedStationID = connectedUser;
            var extractDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
        }
    
        //Vérifier le résultat de l'exportation de données
        for (var i in arrayOfExportMethod){
            try {
                var exportMethod = arrayOfExportMethod[i];
                Log.AppendFolder(moduleName + ", " + exportMethod);
                
                var isDataExportSuccessful = false;
                
                isDataExportSuccessful = ExportData(moduleName, exportMethod, 1, shouldExportSuccess);
                CheckEquals(isDataExportSuccessful, shouldExportSuccess, "The data export result from module '" + moduleName + "' by " + exportMethod);
        
                if (isDataExportSuccessful){
                    //Vérifier le nouvel enregistrement de la table B_DATA_HUB (les champs qui ont le plus d'impact)
                    if (shouldExportSuccess)
                        CheckDataHubExportedData(moduleName, exportMethod, expectedStationID, expectedIACodes, expectedNbOfRecords);
            
                    //Tester la commande cfLoader
                    if (isCfLoaderCommandToBeChecked)
                        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
                }
            }
            catch(e) {
                Log.Error("Exception : " + e.message, VarToStr(e.stack));
                e = null;
            }
            finally {
                Log.PopLogFolder();
            }
        }
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        Log.PopLogFolder();
    }
}



function ExecuteManyExportsForReports(connectedUser, moduleName, reportDisplayedName, reportName, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod, arrayOfSelectedIACodes)
{
    try {
        Log.AppendFolder(moduleName + ", report : " + reportDisplayedName);
        
        if (shouldExportSuccess == undefined) shouldExportSuccess = true;
        if (isCfLoaderCommandToBeChecked == undefined) isCfLoaderCommandToBeChecked = true;
        if (arrayOfExportMethod == undefined) arrayOfExportMethod = [exportMethod_Toolbar_Reports, exportMethod_MenuBar_Reports];
    
        if (GetVarType(arrayOfExportMethod) != varArray && GetVarType(arrayOfExportMethod) != varDispatch)
            arrayOfExportMethod = new Array(arrayOfExportMethod);
    
        //Vérifier le résultat de l'exportation de données
        for (var i in arrayOfExportMethod){
            try {
                var exportMethod = arrayOfExportMethod[i];
                Log.AppendFolder(moduleName + ", report : " + reportDisplayedName + ", exportMethod : " + exportMethod);
                
                var resultOfDataExport = ExportDataForReports(moduleName, exportMethod, reportDisplayedName, shouldExportSuccess);
                var isDataExportSuccessful = resultOfDataExport[0];
                var isGroupedInTheSameReport = resultOfDataExport[1];
                CheckEquals(isDataExportSuccessful, shouldExportSuccess, "The data export result from module '" + moduleName + "' by " + exportMethod + " for report '" + reportDisplayedName + "'");
        
                if (isDataExportSuccessful){
                    //Vérifier le nouvel enregistrement de la table B_DATA_HUB (les champs qui ont le plus d'impact)
                    if (shouldExportSuccess){
                        var expectedIACodesAndNbOfRecords = GetExpectedIACodesAndNbOfRecordsForReports(moduleName, reportName, isGroupedInTheSameReport, arrayOfSelectedIACodes);
                        var expectedIACodes = expectedIACodesAndNbOfRecords[0];
                        var expectedNbOfRecords = null;
                        //var expectedNbOfRecords = expectedIACodesAndNbOfRecords[1]; ////La logique dans GetExpectedIACodesAndNbOfRecordsForReports n'est pas encore complète
                        var expectedFunctionID = reportName;
                        var expectedStationID = connectedUser;
                        var extractDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
                        
                        CheckDataHubExportedDataForReports(moduleName, exportMethod, expectedStationID, expectedIACodes, expectedFunctionID, expectedNbOfRecords);
                    }
                    
                    //Tester la commande cfLoader
                    if (isCfLoaderCommandToBeChecked)
                        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
                }
            }
            catch(e) {
                Log.Error("Exception : " + e.message, VarToStr(e.stack));
                e = null;
            }
            finally {
                Log.PopLogFolder();
            }
        }
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        Log.PopLogFolder();
    }
}



function GetConnectedUser()
{
    var croesusTitle = Get_MainWindow().WndCaption;
    var startPos = aqString.Find(croesusTitle, "(") + 1;
    return aqString.SubString(croesusTitle, startPos, aqString.Find(croesusTitle, ")") - startPos);
}



function GetAllExportMethodsForModule(moduleName)
{
    moduleName = aqString.ToUpper(moduleName);
    switch (moduleName){
        case moduleName_Accounts : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print, exportMethod_X_Button_ExportToMSExcel];
        case moduleName_Clients : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print, exportMethod_X_Button_ExportToMSExcel];
        case moduleName_Models : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print];
        case moduleName_Orders : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print];
        case moduleName_Orders_Accumulator : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_Toolbar_Print];
        case moduleName_Portfolio : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print];
        case moduleName_Relationships : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print, exportMethod_X_Button_ExportToMSExcel];
        case moduleName_Securities : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print];
        case moduleName_Transactions : return [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print, exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel, exportMethod_MenuBar_Print, exportMethod_Toolbar_Print];
    }
    Log.Error("Module " + moduleName + " not covered");
    return [];
}



function ExportDataForReports(moduleName, exportMethod, reportDisplayedName, shouldExportSuccess)
{
    Sys.Refresh();
    if (!Get_CroesusApp().WaitProperty("CPUUsage", 0, 120000))
        Log.Warning("Croesus may be processing at the time of the Export action.", "", pmHigher, null, Sys.Desktop.Picture());
    Delay(5000);
    
    if (shouldExportSuccess == undefined) shouldExportSuccess = true;
        
    //Récupérer le nombre initial d'enregistrements dans la table B_DATA_HUB
    var formerNbOfRowsInDataHub = GetDataHubNbOfRecords();

    //Cas du bouton Rapports de la barre d'outils
    if (exportMethod == exportMethod_Toolbar_Reports){
        if (!Get_Toolbar_BtnReportsAndGraphs().IsEnabled){
            Log.Error("Component Get_Toolbar_BtnReportsAndGraphs() is not enabled.");
            return false;
        }
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
    }
    
    //Cas du menu Rapports
    else if (exportMethod == exportMethod_MenuBar_Reports){
        ExecuteActionAndExpectSubmenus(Get_MenuBar_Reports(), "Click");
        
        var menubarReportCommand = null;
        switch (moduleName){
            case moduleName_Accounts : menubarReportCommand = Get_MenuBar_Reports_Accounts(); break;
            case moduleName_Clients : menubarReportCommand = Get_MenuBar_Reports_Clients(); break;
            case moduleName_Models : menubarReportCommand = Get_MenuBar_Reports_Model(); break;
            case moduleName_Portfolio : menubarReportCommand = Get_MenuBar_Reports_Portfolio(); break;
            case moduleName_Relationships : menubarReportCommand = Get_MenuBar_Reports_Relationships(); break;
            case moduleName_Securities : menubarReportCommand = Get_MenuBar_Reports_Securities(); break;
            default : Log.Error("moduleName '" + moduleName + "' not covered."); return false;
        }
        
        if (!menubarReportCommand.IsEnabled){
            Log.Error("Component Get_MenuBar_Reports_...() is not enabled.");
            return false;
        }
        
        menubarReportCommand.Click();
    }
    
    //Sélectionner le rapport
    WaitReportsWindow();
    SelectReports(reportDisplayedName);
    Get_WinReports_BtnOK().WaitProperty("IsEnabled", true, 10000);
    
    //Récupérer le nombre attendu de nouveaux enregistrements : nbOfExpectedNewRecords
    var isGroupedInTheSameReport = Get_WinReports_GrpOptions_ChkGroupInTheSameReport().IsChecked.OleValue;
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    var nbOfExpectedNewRecords = (nbOfSelectedElements == 0 || isGroupedInTheSameReport)? 1: nbOfSelectedElements;
    
    //Valider le rapport
    ValidateReport(true, false, reportDisplayedName);
    
    //Attendre que l'enregistrement soit fait dans la table B_DATA_HUB et évaluer le résultat
    Delay(5000);
    if (!Get_CroesusApp().WaitProperty("CPUUsage", 0, 120000))
        Log.Warning("Following the Export action, Croesus may still be processing until 2 minutes.", "", pmHigher, null, Sys.Desktop.Picture());
    
    var nbOfActualNewRecords = GetNbOfNewRecordsInDataHub(formerNbOfRowsInDataHub, nbOfExpectedNewRecords);
    Log.Message("Looked for " + nbOfExpectedNewRecords + " new record(s) by timeout, found " + nbOfActualNewRecords + " new record(s).");
    var isExportSuccessfull = (shouldExportSuccess)? (nbOfActualNewRecords == nbOfExpectedNewRecords): (nbOfActualNewRecords != 0);
    
    //Retourne un Array : [résultat de l'exportation, état de la case à cocher ChkGroupInTheSameReport] (solution jugée plus simple trouvée pour éviter d'utiliser une variable globale pour l'état de la case à cocher ChkGroupInTheSameReport)
    return [isExportSuccessfull, isGroupedInTheSameReport];
}



function ValidateReport(killAcrobatProcessAtEnd, logErrorIfAcrobatDoesNotStart, reportFileName)
{
    try {
        var previous_CR1485_REPORTS_TIMEOUT = Global_variables.CR1485_REPORTS_TIMEOUT;
        var previous_PROJECT_AUTO_WAIT_TIMEOUT = Global_variables.PROJECT_AUTO_WAIT_TIMEOUT;
        Global_variables.CR1485_REPORTS_TIMEOUT = 3000000;
        Global_variables.PROJECT_AUTO_WAIT_TIMEOUT = 120000;
        Options.Run.Timeout = Global_variables.PROJECT_AUTO_WAIT_TIMEOUT;
        
        Common_functions.ValidateReport(killAcrobatProcessAtEnd, logErrorIfAcrobatDoesNotStart, reportFileName)
    }
    catch(e_ValidateReport) {
        Log.Error("Exception : " + e_ValidateReport.message, VarToStr(e_ValidateReport.stack));
        e_ValidateReport = null;
    }
    finally {
        Global_variables.CR1485_REPORTS_TIMEOUT = previous_CR1485_REPORTS_TIMEOUT;
        Global_variables.PROJECT_AUTO_WAIT_TIMEOUT = previous_PROJECT_AUTO_WAIT_TIMEOUT;
        Options.Run.Timeout = Global_variables.PROJECT_AUTO_WAIT_TIMEOUT;
    }
}



function ExportData(moduleName, exportMethod, nbOfExpectedNewRecords, shouldExportSuccess)
{
    Sys.Refresh();
    if (!Get_CroesusApp().WaitProperty("CPUUsage", 0, 120000))
        Log.Warning("Croesus may be processing at the time of the Export action.", "", pmHigher, null, Sys.Desktop.Picture());
    Delay(5000);
    
    if (nbOfExpectedNewRecords == undefined) nbOfExpectedNewRecords = 1;
    
    if (shouldExportSuccess == undefined) shouldExportSuccess = true;
    
    //Récupérer le nombre initial d'enregistrements dans la table B_DATA_HUB
    var formerNbOfRowsInDataHub = GetDataHubNbOfRecords();
    
    //Aller au module
    //GotoModule(moduleName);
    
    exportMethod = aqString.ToUpper(exportMethod);
    
    Log.Message("****** Export data through '" + exportMethod + "'. ******");
    
    //Cas spécifique de l'accumulateur des ordres : Aller dans l'accumulateur et ne rien sélectionner
    if (moduleName_Orders_Accumulator == aqString.ToUpper(moduleName)){
        Get_OrderAccumulatorGrid().Click();
        var dataGridRecordListControl = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        var nbOfItems = dataGridRecordListControl.Items.Count;
        
        if (nbOfItems < 1)
            dataGridRecordListControl.Click();
        else {
            var firstRowDescriptionCell = dataGridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SecurityDescription"], 10);
            firstRowDescriptionCell.Click();
            var maxNbOfTries = 10;
            var nbOfTries = 0;
            do {
                firstRowDescriptionCell.Click(-1, -1, skCtrl);
                Delay(200);
            } while(firstRowDescriptionCell.IsRecordSelected && (++nbOfTries < maxNbOfTries))
        }
    }
    
    
    //Exécuter la commande
    
    //Cas du CTRL + C
    if (exportMethod == exportMethod_CTRL_C)
        Get_MainWindow().Keys("^c");
    
    //Cas du bouton Imprimer de la barre d'outils
    else if (exportMethod == exportMethod_Toolbar_Print){
        if (!Get_Toolbar_BtnPrint().IsEnabled){
            Log.Error("Component Get_Toolbar_BtnPrint() is not enabled");
            return false;
        }
        Get_Toolbar_BtnPrint().Click();
    }
    
    
    //Click sur le bouton (X)  situé en haut à droite de la grille principal - [Exporter vers MS Excel]
    else if (exportMethod == exportMethod_X_Button_ExportToMSExcel){
        if (GetIndexOfItemInArray([moduleName_Relationships, moduleName_Clients, moduleName_Accounts], aqString.ToUpper(moduleName)) == -1)
            Log.Error("The Export to Excel by X button is only available for Relationships/Clients/Accounts modules");
        else
            Get_RelationshipsClientsAccountsGrid_BtnExportToMSExcel().Click();
    }
    
    //À partir du menu principal
    else if (aqString.Find(exportMethod, "MENUBAR") == 0){
        if (exportMethod != exportMethod_MenuBar_Print)
            ExecuteActionAndExpectSubmenus(Get_MenuBar_Edit(), "Click");
            
        if (exportMethod == exportMethod_MenuBar_Copy)
            Get_MenuBar_Edit_Copy().Click();
        else if (exportMethod == exportMethod_MenuBar_CopyWithHeader)
            Get_MenuBar_Edit_CopyWithHeader().Click();
        else if (exportMethod == exportMethod_MenuBar_ExportToFile)
            Get_MenuBar_Edit_ExportToFile().Click();
        else if (exportMethod == exportMethod_MenuBar_ExportToMSExcel)
            Get_MenuBar_Edit_ExportToMsExcel().Click();
        else if (exportMethod == exportMethod_MenuBar_Print){
            ExecuteActionAndExpectSubmenus(Get_MenuBar_File(), "Click");
            if (!Get_MenuBar_File_Print().IsEnabled){
                Log.Error("Component Get_MenuBar_File_Print() is not enabled");
                return false;
            }
            Get_MenuBar_File_Print().Click();
        }
        else
            Log.Error("Export method '" + exportMethod + "' not covered.");
    }
    
    //À partir du Clic droit
    else if (aqString.Find(exportMethod, "CLICKR") == 0){
        //Faire le clic droit
        Sys.Refresh();
        ExecuteActionAndExpectSubmenus(Get_MainWindow(), "[Apps]");
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        
        //Sélectionner la commande
        if (GetIndexOfItemInArray([moduleName_Relationships, moduleName_Clients, moduleName_Accounts], aqString.ToUpper(moduleName)) != -1){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToAFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Models == aqString.ToUpper(moduleName)){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_ModelsGrid_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_ModelsGrid_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_ModelsGrid_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_ModelsGrid_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_ModelsGrid_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_ModelsGrid_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_ModelsGrid_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Portfolio == aqString.ToUpper(moduleName)){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_PortfolioGrid_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_PortfolioGrid_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_PortfolioGrid_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_PortfolioGrid_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_PortfolioGrid_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_PortfolioGrid_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_PortfolioGrid_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Transactions == aqString.ToUpper(moduleName)){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_Transactions_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_Transactions_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_Transactions_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_Transactions_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_Transactions_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_Transactions_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_Transactions_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Securities == aqString.ToUpper(moduleName)){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_SecurityGrid_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_SecurityGrid_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_SecurityGrid_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_SecurityGrid_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_SecurityGrid_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_SecurityGrid_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_SecurityGrid_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Orders == aqString.ToUpper(moduleName)){
            
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_OrderGrid_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_OrderGrid_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_OrderGrid_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_OrderGrid_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_OrderGrid_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_OrderGrid_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_OrderGrid_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
        else if (moduleName_Orders_Accumulator == aqString.ToUpper(moduleName)){
            Delay(3000);
            if (exportMethod == exportMethod_ClickR_Copy)
                Get_Win_ContextualMenu_Copy().Click();
            else if (exportMethod == exportMethod_ClickR_CopyWithHeader)
                Get_Win_ContextualMenu_CopyWithHeader().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToFile)
                Get_Win_ContextualMenu_ExportToFile().Click();
            else if (exportMethod == exportMethod_ClickR_ExportToMSExcel)
                Get_Win_ContextualMenu_ExportToMSExcel().Click();
            else if (exportMethod == exportMethod_ClickR_Print){
                if (!Get_Win_ContextualMenu_Print().IsEnabled){
                    Log.Error("Component Get_Win_ContextualMenu_Print() is not enabled");
                    return false;
                }
                Get_Win_ContextualMenu_Print().Click();
            }
            else
                Log.Error("Export method '" + exportMethod + "' not covered.");
        }
    }
    
    
    //Action supplémentaire pour Export vers Fichier
    if (aqString.Find(exportMethod, "EXPORTTOFILE") != -1)
        Get_DlgSelectTheFileName_BtnCancel().Click();
    
    //Action supplémentaire pour Export vers Imprimante
    if (aqString.Find(exportMethod, "PRINT") != -1){
        if (moduleName == moduleName_Transactions && Get_DlgDefinePrintingType().Exists)
            Get_DlgDefinePrintingType_BtnOK().Click();
        
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 100000);
        
        if (WaitObject(Get_CroesusApp(), ["WndClass", "WndCaption"], ["#32770", printDlgBoxTitle], 30000))
            Get_DlgPrint_BtnCancel().Click();
        else {
            SetAutoTimeOut();
            if (Get_DlgInformation().Exists){
                Log.Warning("Information dialog box was displayed instead of the expected 'Print' dialog box. (May be this is due to a 'Tele-Travail' configuration issue)", "", pmHigher, pmNormal, Sys.Desktop.Picture());
                Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
            }
            else {
                var nbOfErrorChecksLeft = 3;
                while (Get_DlgError().Exists && --nbOfErrorChecksLeft > 0){
                    
                    /*
                    Log.Error("La boîte de dialogue Erreur s'est affichée.");
                    if (Get_DlgError_LblMessage().Exists && Get_DlgError_LblMessage().Visible)
                        Log.Error("Message d'erreur : '" + Get_DlgError_LblMessage().Message + "'");
                    else if (Get_DlgError_LblMessage1().Exists && Get_DlgError_LblMessage1().Visible)
                        Log.Error("Message d'erreur : '" + Get_DlgError_LblMessage1().Text + "'");
                    */
                    //Temp
					if (language == "french")
						var tempMsg = "L'impression a échouée. Veuillez communiquer avec votre administateur de réseau.";
					else
						var tempMsg = "Printing failed. Please contact your network administrator.";
					
                    if (Get_DlgError_LblMessage().Exists && Get_DlgError_LblMessage().Visible){
						if (tempMsg == Trim(VarToStr(Get_DlgError_LblMessage().Message))){
                            Log.Message("La boîte de dialogue Erreur s'est affichée.");
							Log.Message("Message d'erreur : '" + Get_DlgError_LblMessage().Message + "'");
                        }
						else {
                            Log.Error("La boîte de dialogue Erreur s'est affichée.");
							Log.Error("Message d'erreur : '" + Get_DlgError_LblMessage().Message + "'");
                        }
					}
                    else if (Get_DlgError_LblMessage1().Exists && Get_DlgError_LblMessage1().Visible){
						if (tempMsg == Trim(VarToStr(Get_DlgError_LblMessage1().Text))){
                            Log.Message("La boîte de dialogue Erreur s'est affichée.");
							Log.Message("Message d'erreur : '" + Get_DlgError_LblMessage1().Text + "'");
                        }
						else {
                            Log.Error("La boîte de dialogue Erreur s'est affichée.");
							Log.Error("Message d'erreur : '" + Get_DlgError_LblMessage1().Text + "'");
                        }
					}
                    //
                    
                    if (Get_DlgError_BtnOK().Exists){
                        Get_DlgError_BtnOK().Click();
                        Get_DlgError().WaitProperty("Exists", false, 10000)
                    }
                    else if (Get_DlgError_Btn_OK().Exists){
                        Get_DlgError_Btn_OK().Click();
                        Get_DlgError().WaitProperty("Exists", false, 10000)
                    }
                }
                
                if (!Get_DlgError().WaitProperty("Exists", false, 10000)){
                    Log.Error("ESC keystroke to attempt to close the Error dialog box.");
                    Get_DlgError().Keys("[Esc]");
                }
            }
            RestoreAutoTimeOut();
        }
        
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["BaseWindow", informationDlgBoxTitle], 30000); // CP : Adaptation pour CO
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45); // CP : Adaptation pour CO
    }
    
    //Attendre que l'éventuelle boîte de dialogue "Exporter vers ..." se ferme
    if ((aqString.Find(exportMethod, "EXPORTTOFILE") != -1 || aqString.Find(exportMethod, "EXPORTTOMSEXCEL") != -1))
        WaitForDataExportCompletion(1000000);
    
    //Action supplémentaire pour Export vers Excel
    if (aqString.Find(exportMethod, "EXPORTTOMSEXCEL") != -1){
        Sys.WaitProcess("excel", 10000);
        CloseExcelProcess();
    }
    
    //Attendre que l'enregistrement soit fait dans la table B_DATA_HUB
    Delay(5000);
    if (!Get_CroesusApp().WaitProperty("CPUUsage", 0, 120000))
        Log.Warning("Following the Export action, Croesus may still be processing until 2 minutes.", "", pmHigher, null, Sys.Desktop.Picture());
    
    var nbOfActualNewRecords = GetNbOfNewRecordsInDataHub(formerNbOfRowsInDataHub, nbOfExpectedNewRecords);
    Log.Message("Looked for " + nbOfExpectedNewRecords + " new record(s) by timeout, found " + nbOfActualNewRecords + " new record(s).");
    
    var isExportSuccessfull = (shouldExportSuccess)? (nbOfActualNewRecords == nbOfExpectedNewRecords): (nbOfActualNewRecords != 0);
    return isExportSuccessfull;
}



function GetNbOfNewRecordsInDataHub(formerNbOfRowsInDataHub, nbOfExpectedNewRecords, timeOutForDataHubTableUpdate)
{
    if (nbOfExpectedNewRecords == undefined) nbOfExpectedNewRecords = 1;
    if (timeOutForDataHubTableUpdate == undefined) timeOutForDataHubTableUpdate = defaultTimeOutForDataHubTableUpdate;
    
    var timeEllapsedDB = 0;
    do {
        var nbOfActualNewRecords = GetDataHubNbOfRecords() - formerNbOfRowsInDataHub;
        
        if (nbOfActualNewRecords >= nbOfExpectedNewRecords){
            Delay(5000); //Attendre encore un petit temps pour voir s'il n'y aura pas d'enregistrements supplémentaires
            nbOfActualNewRecords = GetDataHubNbOfRecords() - formerNbOfRowsInDataHub;
            break;
        }
        
        Delay(3000);
        timeEllapsedDB += 3000;
    } while (timeEllapsedDB < timeOutForDataHubTableUpdate)
    
    //Log.Message(nbOfActualNewRecords + " new records found in B_DATA_HUB table.");
    return nbOfActualNewRecords;
}



function GotoModule(moduleName)
{
    Delay(2000);
    moduleName = aqString.ToUpper(moduleName);
    Log.Message("Go to module '" + moduleName + "'.");
    var isGotoModuleSuccessful = false;
    var nbOfTriesLeft = 3;
    
    do {
        nbOfTriesLeft--;
        
        if (moduleName == moduleName_Dashboard){
            Get_ModulesBar_BtnDashboard().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnDashboard().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Models){
            Get_ModulesBar_BtnModels().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnModels().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Relationships){
            Get_ModulesBar_BtnRelationships().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnRelationships().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Clients){
            Get_ModulesBar_BtnClients().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnClients().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Accounts){
            Get_ModulesBar_BtnAccounts().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnAccounts().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Portfolio){
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnPortfolio().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else if (moduleName == moduleName_Transactions){
            Get_ModulesBar_BtnTransactions().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnTransactions().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
            Delay(3000);
        }
        else if (moduleName == moduleName_Securities){
            Get_ModulesBar_BtnSecurities().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnSecurities().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
            Delay(3000);
        }
        else if (moduleName == moduleName_Orders || moduleName == moduleName_Orders_Accumulator){
            Get_ModulesBar_BtnOrders().WaitProperty("IsEnabled", true, 10000);
            Get_ModulesBar_BtnOrders().Click();
            isGotoModuleSuccessful = Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
        }
        else {
            Log.Error("Module name '" + moduleName + "' not covered.");
            isGotoModuleSuccessful = null;
        }
        
    } while (nbOfTriesLeft > 0 && isGotoModuleSuccessful !== null && !isGotoModuleSuccessful)
    
    return isGotoModuleSuccessful;
}



function CheckDataHubExportedData(moduleName, exportMethod, expectedStationID, expectedIACodes, expectedNbOfRecords, expectedFunctionID)
{
    
    if (expectedFunctionID == undefined) expectedFunctionID = GetExpectedFunctionID(moduleName);
    
    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_STATION_ID), expectedStationID, DataHub_ColumnName_STATION_ID);
    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), expectedIACodes, DataHub_ColumnName_IA_CODES);
    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_ID), expectedFunctionID, DataHub_ColumnName_FUNCTION_ID);
    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_NB_RECORDS), expectedNbOfRecords, DataHub_ColumnName_NB_RECORDS);
}



function CheckDataHubExportedDataForReports(moduleName, exportMethod, expectedStationID, expectedIACodes, expectedFunctionID, expectedNbOfRecords)
{
    if (expectedFunctionID == undefined) expectedFunctionID = GetExpectedFunctionID(moduleName);
    var expectedFunctionName = GetExpectedFunctionName(exportMethod, moduleName);
    
    if (GetVarType(expectedIACodes) != varArray && GetVarType(expectedIACodes) != varDispatch)
        var nbOfRows = 1;
    else {
        var nbOfRows = expectedIACodes.length;
        
        if (GetVarType(expectedStationID) != varArray && GetVarType(expectedStationID) != varDispatch)
            expectedStationID = NewArrayFill(nbOfRows, expectedStationID);
        
        expectedFunctionName = NewArrayFill(nbOfRows, expectedFunctionName);
        
        if (GetVarType(expectedFunctionID) != varArray && GetVarType(expectedFunctionID) != varDispatch)
            expectedFunctionID = NewArrayFill(nbOfRows, expectedFunctionID);
        
        expectedIACodes = expectedIACodes.sort().toString();
        expectedStationID = expectedStationID.sort().toString();
        expectedFunctionName = expectedFunctionName.sort().toString();
        expectedFunctionID = expectedFunctionID.sort().toString();
        
        if (expectedNbOfRecords != undefined && GetVarType(expectedNbOfRecords) != varArray && GetVarType(expectedNbOfRecords) != varDispatch){
            expectedNbOfRecords = NewArrayFill(nbOfRows, 1);
            expectedNbOfRecords = expectedNbOfRecords.sort().toString();
        }
    }
    
    CheckEquals(GetDataHubLastValues(DataHub_ColumnName_STATION_ID, nbOfRows).sort().toString(), expectedStationID, DataHub_ColumnName_STATION_ID);
    CheckEquals(GetDataHubLastValues(DataHub_ColumnName_IA_CODES, nbOfRows).sort().toString(), expectedIACodes, DataHub_ColumnName_IA_CODES);
    CheckEquals(GetDataHubLastValues(DataHub_ColumnName_FUNCTION_NAME, nbOfRows).sort().toString(), expectedFunctionName, DataHub_ColumnName_FUNCTION_NAME);
    CheckEquals(GetDataHubLastValues(DataHub_ColumnName_FUNCTION_ID, nbOfRows).sort().toString(), expectedFunctionID, DataHub_ColumnName_FUNCTION_ID);
    
    if (expectedNbOfRecords != undefined)
        CheckEquals(GetDataHubLastValues(DataHub_ColumnName_NB_RECORDS, nbOfRows).sort().toString(), expectedNbOfRecords, DataHub_ColumnName_NB_RECORDS);
}



function GetExpectedFunctionID(moduleName)
{
    return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_ID_" + aqString.ToUpper(moduleName), language + client);
}



/**
    En utilisant cette fonction,
    il faudrait préalablement (avant l'appel de cette fonction), à l'issue de la sélection dans la grille, valider que les codes CP sélectionnés sont les bons
    
    La logique qui donne expectedNbOfRecords n'est pas complète (la valeur ne sera la bonne dans certains cas).
*/
function GetExpectedIACodesAndNbOfRecordsForReports(moduleName, reportName, isGroupedInTheSameReport, arrayOfSelectedIACodes)
{
    var expectedIACodes = null;
    var expectedNbOfRecords = null;
    var isReportType10 = false;
    
    //Le rapport est-il de type 10?
    var isReportType10 = (0 != VarToInt(Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_REPORT where REPORT_TYPE = 10 and REPORT_NAME = '" + reportName + "'", vServerDataHub, "nbOfRows")));
    var expectedIACodeForReportOfType10 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "IA_CODES_FOR_REPORT_TYPE_10", language + client);
    
    //Si aucune ligne n'est sélectionnée dans la grille alors le champ IA_CODES doit afficher le Code CP de la ligne active (aussi valable pour une seule ligne sélectionnée)
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements == 0){
        expectedNbOfRecords = 1;
        if (isReportType10)
            expectedIACodes = expectedIACodeForReportOfType10;
        else {
            var dataGridRecordListControl = null;
            if (GetIndexOfItemInArray([moduleName_Accounts, moduleName_Clients, moduleName_Relationships], moduleName) != -1)
                dataGridRecordListControl = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1);
            else if (moduleName == moduleName_Models)
                dataGridRecordListControl = Get_ModelsGrid().WPFObject("RecordListControl", "", 1);
            else if (moduleName == moduleName_Portfolio)
                dataGridRecordListControl = Get_Portfolio_PositionsGrid();
            else {
                Log.Error("Module " + moduleName + " not covered.");
                return "";
            }
            
            var dataGridActiveRow = dataGridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsActive"], ["DataRecordPresenter", false, true], 10);
            if (!dataGridActiveRow.Exists){
                Log.Message("The data grid is empty.");
                return "";
            }
            
            var IACodeUid = (moduleName == moduleName_Models)? "RepresentativeNumber" : "RepresentativeId";
            expectedIACodes = VarToStr(dataGridActiveRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", IACodeUid], 10).WPFControlText);
        }
    }
    
    //S'il y a des lignes sélectionnées, alors :
    //Si Grouper dans un même rapport n'est pas coché, il y autant d'enregistrements que de lignes sélectionnées (pour le moment, cette fonction retourne seulement le Code CP de la dernière ligne sélectionnée)
    //Si Grouper dans un même rapport est coché, tous les Codes CP sont affichés 
    else {
        if (!isReportType10 && arrayOfSelectedIACodes == undefined)
            return Log.Error("'arrayOfSelectedIACodes' parameter is required.");
        
        if (isGroupedInTheSameReport){
            expectedNbOfRecords = arrayOfSelectedIACodes.length;
            expectedIACodes = (isReportType10)? expectedIACodeForReportOfType10: GetExpectedIACodesString(arrayOfSelectedIACodes);
        }
        else {
            expectedNbOfRecords = NewArrayFill(arrayOfSelectedIACodes.length, 1);
            expectedIACodes = (isReportType10)? NewArrayFill(arrayOfSelectedIACodes.length, expectedIACodeForReportOfType10): arrayOfSelectedIACodes;
        }
    }
    
    return [expectedIACodes, expectedNbOfRecords]
}



function GetIACodesOfSelectedItems(moduleName)
{
    Log.Message("Get selected rows in the grid of module : " + moduleName);
    
    if (moduleName == moduleName_Securities)
        return [];
    
    Sys.Clipboard = "";
    ExportData(moduleName, exportMethod_MenuBar_CopyWithHeader);
    
    var nbOfChecks = 0; //Attendre que le presse-papier soit mis à jour
    while (++nbOfChecks < 20 && (GetVarType(Sys.Clipboard) != varOleStr || Trim(Sys.Clipboard) == "")){
        Delay(300);
    }
    
    if (aqString.Find(Trim(Sys.Clipboard).split("\n")[0], IACodeColumnName) == -1){
        Log.Warning("IA Code header '" + IACodeColumnName + "' not found in the exported data first line.", VarToStr(Sys.Clipboard), pmHigher, null, Sys.Desktop.Picture());
    }
    
    var selectedRowsFilePath = Project.Path + "selectedRowsFile.txt";;
    if (!aqFile.WriteToTextFile(selectedRowsFilePath, Sys.Clipboard, aqFile.ctANSI, true)){
        Log.Error("Failed to create file and write text to it : " + selectedRowsFilePath);
        return [];
    }
        
    var arrayOfIACodes = SetArrayItemsToString(GetDataFromCSVFile(selectedRowsFilePath, IACodeColumnName));
    return arrayOfIACodes;
}



function GetExpectedIACodesString(arrayOfAllIACodes, moduleName)
{
    if (aqString.ToUpper(moduleName) == moduleName_Securities || Trim(VarToStr(arrayOfAllIACodes)) == "" || Trim(arrayOfAllIACodes.toString()) == "")
        return " ";
    
    var arrayOfIACodesUniqueValues = GetArrayUniqueValues(arrayOfAllIACodes).sort();
    var arrayOfStartSpecialCharValues = new Array();
    var arrayOfStartStandardCharValues = new Array();
    
    for (var i in arrayOfIACodesUniqueValues){
        if (arrayOfIACodesUniqueValues[i][0] == "_")
            arrayOfStartSpecialCharValues.push(arrayOfIACodesUniqueValues[i]);
        else
            arrayOfStartStandardCharValues.push(arrayOfIACodesUniqueValues[i]);
    }
    
    return (arrayOfStartSpecialCharValues.concat(arrayOfStartStandardCharValues)).toString();
}



function GetExpectedFunctionName(exportMethod, moduleName)
{
    exportMethod = aqString.ToUpper(exportMethod);
    
    if (GetIndexOfItemInArray([exportMethod_CTRL_C, exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader], exportMethod) != -1)
        return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_NAME_CLIPBOARD", language + client);
    else if (GetIndexOfItemInArray([exportMethod_MenuBar_ExportToFile, exportMethod_ClickR_ExportToFile], exportMethod) != -1)
        if (moduleName != undefined && aqString.ToUpper(moduleName) == moduleName_Transactions)
            return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "TRANSACTIONS_FUNCTION_NAME_FILE", language + client);
        else
            return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_NAME_FILE", language + client);
    else if (GetIndexOfItemInArray([exportMethod_X_Button_ExportToMSExcel, exportMethod_MenuBar_ExportToMSExcel, exportMethod_ClickR_ExportToMSExcel], exportMethod) != -1)
        return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_NAME_EXCEL", language + client);
    else if (GetIndexOfItemInArray([exportMethod_MenuBar_Print, exportMethod_ClickR_Print, exportMethod_Toolbar_Print], exportMethod) != -1)
        return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_NAME_PRINTER", language + client);
    else if (GetIndexOfItemInArray([exportMethod_MenuBar_Reports, exportMethod_Toolbar_Reports], exportMethod) != -1)
        return ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "FUNCTION_NAME_REPORTS", language + client);
    
    Log.Error("Export method '" + exportMethod + "' not covered.");
    return null;
}



function SetArrayItemsToString(arr)
{
    var resultArray = new Array();
    for (var i = 0; i < arr.length; i ++)
        resultArray.push(arr[i].toString());
    
    return resultArray;
}



function ExportGridContentToFile(exportFilePath, byClickRight, clickRightFromObject, timeOut)
{
    Log.Message("Export grid content to file : " + exportFilePath);
    
    if (timeOut == undefined) timeOut = 1000000;
    
    //Supprimer le fichier s'il existe un fichier de même nom
    if (aqFile.Exists(exportFilePath) && !aqFileSystem.DeleteFile(exportFilePath)){
        Log.Error("Unable to delete file : " + exportFilePath);
        return false
    }
    
    //Cas du menu Fichier
    if (byClickRight == undefined || !byClickRight){
        Get_MenuBar_Edit().OpenMenu();
        Get_MenuBar_Edit_ExportToFile().Click();
    }
    
    //Cas du Click droit
    else {
        ExecuteActionAndExpectSubmenus(clickRightFromObject, "ClickR");
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        Get_Win_ContextualMenu_ExportToFile().Click();
    }
    
    //Saisir le chemin d'accès du fichier et valider
    Get_DlgSelectTheFileName().SetFocus();
    Get_DlgSelectTheFileName_CmbFileName_TxtFileName().SetText(exportFilePath);
    Get_DlgSelectTheFileName_BtnSave().Click();
    
    //Attendre que l'éventuel boîte de dialogue "Exporter vers ..." se ferme
    if (!WaitForDataExportCompletion(timeOut))
        return false;
    
    //Cas de Transaction vide : aucun fichier n'est créé
    if (Get_ModulesBar_BtnTransactions().IsChecked.OleValue && VarToInt(Get_Transactions_ListView().Items.Count) < 1)
        if (!aqFile.Exists(exportFilePath)) aqFile.WriteToTextFile(exportFilePath, "\n", aqFile.ctANSI, true);
    
    
    return aqFile.Exists(exportFilePath);
}



function WaitForDataExportCompletion(timeOut)
{
    if (timeOut == undefined) timeOut = 1000000;
    
    SetAutoTimeOut();
    
    if (Get_DlgWarning().Exists){
        if (Trim(Get_DlgWarning().CommentTag.OleValue) == Trim(noDataToExportMessage)){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
            RestoreAutoTimeOut();
            return true;
        }
        else {
            Log.Warning("The Warning dialog box was displayed upon data export.", "", pmHigher, null, Sys.Desktop.Picture());
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
    }
    
    if (WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["BaseWindow", informationDlgBoxTitle], 20000)){
        var isExportCompleted = false;
        var timeDataExport = 0;
        while (!isExportCompleted && timeDataExport < timeOut){
            //Cette partie de la fonction a fait l'objet d'adaptations relatives à des situations observées lors des divers tests
            //Lors de l'adaptation relative aux versions Co, il n'a pas été possible de reproduire ces situations
            //La logique actuelle devrait normalement fonctionner
            isExportCompleted = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["BaseWindow", informationDlgBoxTitle], 500);
            if (Get_DlgInformation().Exists && Trim(Get_DlgInformation().CommentTag.OleValue) == Trim(successfullExportMessage)){
                Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
                isExportCompleted = true;
            }
            timeDataExport += 500;
        }
        
        if (!isExportCompleted && Get_DlgInformation().Exists){
            Log.Error("Data export not completed until timeout : " + timeOut + " milliseconds");
            Get_DlgInformation().Close();
            RestoreAutoTimeOut();
            return false;
        }
    }
    /*else */if (Get_DlgProgressCroesus().Exists && Get_DlgProgressCroesus().IsVisible){
        if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Uid"], ["ProgressCroesusWindow", "ProgressCroesusWindow_b5e1"], timeOut)){
            Log.Error("Data export not completed until timeout : " + timeOut + " milliseconds");
            Get_DlgProgressCroesus().Close();
            RestoreAutoTimeOut();
            return false;
        }
    }
    
    RestoreAutoTimeOut();
    return true;
}



function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
            
        var nbOfTries = 0;
        do {
            Sys.Refresh();
            
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
        
        } while (++nbOfTries < maxNbOfTries && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!Get_SubMenus().Exists || !Get_SubMenus().VisibleOnScreen) Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
    }
}



function GetDataFromCSVFile(CSVFilePath, arrayOfColumnsNames, delimiterChar, encoding)
{
    if (GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
        
    var progressDisplayMsgStarting = "GetDataFromCSVFile (started at " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%H:%M") + ") : ";
    
    var CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    var ANSIFileName = CSVFileName;
    var ANSIFilePath = CSVFilePath;
    
    if (encoding == undefined)
        var fileObj = aqFile.OpenTextFile(CSVFilePath, aqFile.faRead, aqFile.ctANSI);
    else
        var fileObj = aqFile.OpenTextFile(CSVFilePath, aqFile.faRead, encoding);
    var linesCountInCSVFile = fileObj.LinesCount; //Fonctionne seulement avec les retours de ligne de Windows (\r\n)
    fileObj.Close();
    
    
    if (encoding != undefined && encoding != aqFile.ctANSI){
        ANSIFileName = "ANSIFile.csv";
        ANSIFilePath = CSVFilePath.replace(CSVFileName, ANSIFileName);
        var CSVFileContent = aqFile.ReadWholeTextFile(CSVFilePath, encoding);
        if (!aqFile.WriteToTextFile(ANSIFilePath, CSVFileContent, aqFile.ctANSI, true))
            Log.Error("Failed to create file and write text to it : " + ANSIFilePath);
    }
    
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
    if (!aqFile.WriteToTextFile(schemaFilePath, schemaFilelines, aqFile.ctANSI, true))
        Log.Error("Failed to create file and write text to it : " + schemaFilePath);
    
    var Driver = DDT.CSVDriver(ANSIFilePath);
    var arrayOfData = new Array();
    var j = 0;
    var progressTotalCount = linesCountInCSVFile;
    var progressPercent;
    var progressDisplayStep = 1;
    var progressDisplayPercent = 0;
    while (! Driver.EOF()){
        var arrayOfCurrentValues = new Array();
        for (var i = 0; i < arrayOfColumnsNames.length; i++)
            arrayOfCurrentValues.push(aqString.Unquote(VarToStr(Driver.Value(aqString.Unquote(arrayOfColumnsNames[i]).replace(".", "#")))));
            
        arrayOfData.push(arrayOfCurrentValues);
        Driver.Next();
        
        j++;
        progressPercent = Math.round(100*j/progressTotalCount);
        if (progressPercent >= progressDisplayPercent){
            progressDisplayPercent = progressPercent + progressDisplayStep;
            Indicator.PushText(progressDisplayMsgStarting + progressPercent + "% completed.");
        }
    }
    Indicator.Clear();
    
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(schemaFilePath);
    if (encoding != undefined && encoding != aqFile.ctANSI)
        aqFileSystem.DeleteFile(ANSIFilePath);
    
    return arrayOfData;
}



function GetAllDisplayedIACodesThroughExportToFile(clickRightFromObject)
{
    var exportFilePath = Project.Path + "AllDisplayedIACodes.txt";
    
    var isDataGridExported = (clickRightFromObject == undefined)? ExportGridContentToFile(exportFilePath): ExportGridContentToFile(exportFilePath, true, clickRightFromObject);
    if (!isDataGridExported){
        Log.Error("Failed to export Grid content to : " + exportFilePath);
        return new Array();
    }
    
    return SetArrayItemsToString(GetDataFromCSVFile(exportFilePath, IACodeColumnName));
}



function GetAllDisplayedSecuritiesThroughExportToFile()
{
    var securityColumnName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "ColumnName_Security", language + client);
    
    var exportFilePath = Project.Path + "AllDisplayedSecurities.txt";
    if (!ExportGridContentToFile(exportFilePath)){
        Log.Error("Failed to export Grid content to : " + exportFilePath);
        return new Array();
    }
    
    return SetArrayItemsToString(GetDataFromCSVFile(exportFilePath, securityColumnName));
}



function ExecuteCfLoaderDataHubExtractor(vServerURL, fileName, extractDate, vserverFolder)
{
    var localFolder = Project.Path;
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
   
    if (vserverFolder == undefined)
        vserverFolder = "/tmp/";
    
    //Exécuter la commande avec récupération du flux d'erreur dans un fichier
    var errorFilePath = "/tmp/Error_DataHubExtractor.txt";
    
    var sshCommand = "#!/bin/bash";
    sshCommand += "\ncd " + vserverFolder + " 2> " + errorFilePath;
    sshCommand += "\nsh /home/tools/LOG_cfLoader.sh" + " 2>> " + errorFilePath;
    sshCommand += "\ncfLoader -DataHubExtractor";
    
    if (fileName != undefined)
        sshCommand += " --FileName " + fileName;
    
    if (extractDate != undefined)
        sshCommand += " --ExtractDate " + extractDate;
    
    sshCommand += " -Firm=FIRM_1 2>> " + errorFilePath + " | tee Output_DataHubExtractor.txt"
    
    Log.Message("ExecuteCfLoaderDataHubExtractor(" + VarToStr(hostname) + ", " + VarToStr(fileName) + ", " + VarToStr(extractDate) + ", " + VarToStr(vserverFolder) + ")", sshCommand);
    
    var SSHCmdFileName = "DataHubExtractor.sh";
    var SSHCmdFilePath =  folderPath_ProjectSuiteCommonScripts + SSHCmdFileName;
    var localOutputFileName = "DataHubExtractor_Output.txt";
    var localOutputFilePath =  folderPath_ProjectSuiteCommonScripts + localOutputFileName;
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "DataHubExtractor.bat";
    
    //Cleanup existing Files
    if (aqFileSystem.Exists('"' + SSHCmdFilePath + '"')) aqFileSystem.DeleteFile('"' + SSHCmdFilePath + '"');
    if (aqFileSystem.Exists('"' + plinkBatchFilePath + '"')) aqFileSystem.DeleteFile('"' + plinkBatchFilePath + '"');
    if (aqFileSystem.Exists('"' + localOutputFilePath + '"')) aqFileSystem.DeleteFile('"' + localOutputFilePath + '"');
    
    //Create SSH file
    if (!aqFile.WriteToTextFile(SSHCmdFilePath, sshCommand, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + SSHCmdFilePath, sshCommand);
    
    //Create and Execute Plink batch file
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > " + localOutputFileName;
    if (!aqFile.WriteToTextFile(plinkBatchFilePath, batchCmdLine, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + plinkBatchFilePath, batchCmdLine);
    ExecuteBatchFile(plinkBatchFilePath);
    
    //S'assurer que les commandes ont été exécutées sans erreur.
    var errorLocalFilePath = localFolder + "Error_DataHubExtractor.txt";
    if (!CopyFileFromVserver(vServerURL, errorFilePath, errorLocalFilePath))
        Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand);
    else {
        var errorContent = Trim(aqFile.ReadWholeTextFile(errorLocalFilePath, aqFile.ctANSI));
        if (Trim(errorContent) != "")
            Log.Error("There was error upon the execution of this SSH command : " + sshCommand, errorContent);
    }
    
    //Vérifier si la commande cfLoader -DataHubExtractor a réussi
    var localOutputFileContent = Trim(aqFile.ReadWholeTextFile(localOutputFilePath, aqFile.ctANSI));
    Log.Message("Result of ExecuteCfLoaderDataHubExtractor(" + VarToStr(hostname) + ", " + VarToStr(fileName) + ", " + VarToStr(extractDate) + ", " + VarToStr(vserverFolder) + ")", localOutputFileContent);
    var isSuccessfulStringFound = (aqString.Find(localOutputFileContent, DataHubExtractor_SuccessfulString) != -1);
    if (!isSuccessfulStringFound)
        Log.Message("Successful string '" + DataHubExtractor_SuccessfulString + "' was not found in the SSH command output :", localOutputFileContent);
    
    var isProcessingEndedStringPatternFound = aqString.StrMatches(DataHubExtractor_ProcessingEndedStringPattern, localOutputFileContent);
    if (!isProcessingEndedStringPatternFound)
        Log.Message("Successful string pattern '" + DataHubExtractor_ProcessingEndedStringPattern + "' was not found in the SSH command output :", localOutputFileContent);
    
    return (isSuccessfulStringFound && isProcessingEndedStringPatternFound);
}



function ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerURL, fileName, extractDate, vserverFolder)
{
    if (vserverFolder == undefined)
        vserverFolder = "/tmp/";
    
    //Supprimer un fichier éventuel de même nom que le fichier attendu
    var expectedExtractionFileName = GetExpectedExtractionFileName(fileName, extractDate);
    var expectedExtractionFilePath = vserverFolder + expectedExtractionFileName;
    if (!DeleteFileOnVserver(vServerURL, expectedExtractionFilePath)){
        Log.Error("Prior to CfLoaderDataHubExtractor command execution, existing file " + expectedExtractionFilePath + " not successfully deleted on vServer : " + vServerURL);
        return false;
    }
    
    //Exécuter la commande
    if (!ExecuteCfLoaderDataHubExtractor(vServerURL, fileName, extractDate, vserverFolder)){
        Log.Error("ExecuteCfLoaderDataHubExtractor was not successfull");
        return false;
    }
    
    //Vérifier si le fichier attendu a été généré
    Log.Message("Check if expected file is generated : " + expectedExtractionFileName);
    var localFolder = Project.Path;
    if (!CopyFileFromVserver(vServerURL, expectedExtractionFilePath, localFolder + expectedExtractionFileName)){
        Log.Error("The file " + expectedExtractionFileName + " was not successfully generated.");
        return false;
    }
    
    Log.Checkpoint("The file " + expectedExtractionFileName + " was successfully generated.");
    return true;
}



function GetExpectedExtractionFileName(fileName, extractDate)
{
    var ExtractionFileNamePrefix = (fileName == undefined)? DataHubExtractor_DefaultNamePrefix: fileName;
    var extractDate = (extractDate == undefined)? DataHubExtractor_DefaultNameDate: extractDate;
    var ExtractionFileNameDate = DateTimeToFormatStr(aqConvert.StrToDate(extractDate), "%Y" + DataHubExtractor_FileNameDateSeparator + "%m" + DataHubExtractor_FileNameDateSeparator + "%d");
    return ExtractionFileNamePrefix + DataHubExtractor_FileNameSeparator + ExtractionFileNameDate + DataHubExtractor_FileNameExtension;
}



function ConnectToSSHSecureShell(vServerURL, connexionUsername, connexionPassword, portNumber, authenticationMethod)
{
    var isConnexionSuccessful = false;
    
    if (connexionUsername == undefined) connexionUsername = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "SSSHSecureShell_Default_Username", language + client);
    if (connexionPassword == undefined) connexionPassword = GET_VSERVER_SSH_ROOT_PSWD();
    if (portNumber == undefined) portNumber = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "SSSHSecureShell_Default_PortNumber", language + client);
    if (authenticationMethod == undefined) authenticationMethod = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "SSSHSecureShell_Default_AuthenticationMethod", language + client);
    
    var hostName = GetVserverHostName(vServerURL);
    var SshClientExecutableFilePath = aqEnvironment.GetEnvironmentVariable("ProgramFiles") + "\\SSH Communications Security\\SSH Secure Shell\\SshClient.exe";
    
    //Ouvrir une seule instance de SSHSecureShell
    TerminateProcess("SshClient");
    var shellObj = (isJavaScript())? getActiveXObject("WScript.Shell"): Sys.OleObject("WScript.Shell");
    shellObj.Exec(SshClientExecutableFilePath);
    
    if (!Get_WinSSHSecureShell().Exists){
        Log.Error("Unable to start SSH Secure Shell client.");
        return false;
    }
    
    //Afficher la barre d'état au cas où elle ne serait pas visible
    if (!Get_WinSSHSecureShell_Statusbar().Visible)
        Get_WinSSHSecureShell().Keys("~vb");
    
    //Se déconnecter au cas où il y aurait une connexion automatique
    if (Trim(Get_WinSSHSecureShell_Statusbar().wText(1)) != ""){
        Get_WinSSHSecureShell().Keys("~fd");
        if (Get_DlgConfirmDisconnect().Exists)
            Get_DlgConfirmDisconnect_BtnOK().Click();
    }
    
    //Ouvrir la boite de dialogue de nouvelle connexion et saisir les informations de connexion
    Get_WinSSHSecureShell().Keys("[Enter]");
    Get_DlgConnectToRemoteHost_TxtHostName().SetText(hostName);
    Get_DlgConnectToRemoteHost_TxtUserName().SetText(connexionUsername);
    Get_DlgConnectToRemoteHost_TxtPortNumber().SetText(portNumber);
    Get_DlgConnectToRemoteHost_CmbAuthenticationMethod().ClickItem(authenticationMethod);
    Get_DlgConnectToRemoteHost_BtnConnect().Click();
    
    //Éventuellement accepter la sauvegarde du host key
    while (Get_DlgHostIdentification().Exists && Get_DlgHostIdentification().Visible)
        Get_DlgHostIdentification_BtnYes().Click();
    
    //Saisir et valider le mot de passe
    Get_DlgEnterPassword_TxtPassword().SetText(connexionPassword);
    Get_DlgEnterPassword_BtnOK().Click();
    
    //Vérifier si la connexion est établie
    Get_WinSSHSecureShell().WaitProperty("Enabled", true, 30000);
    Get_WinSSHSecureShell().Maximize();
    Get_WinSSHSecureShell().HoverMouse();
    var nbTries = 0;
    while (Get_WinSSHSecureShell_Statusbar().wText(0) != "Connected to " + hostName && ++nbTries < 60)
        Delay(1000);
    
    isConnexionSuccessful = (Get_WinSSHSecureShell_Statusbar().wText(0) == "Connected to " + hostName);
    if (!isConnexionSuccessful)
        Log.Error("Connexion to host '" + hostName + "' was not successful");
    
    return isConnexionSuccessful;
}



function ConnectToWinSCP(vServerURL, connexionUsername, connexionPassword)
{
    if (connexionUsername == undefined)
        connexionUsername = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "SSSHSecureShell_Default_Username", language + client);
    if (connexionPassword == undefined)
        connexionPassword = GET_VSERVER_SSH_ROOT_PSWD();
    
    TerminateProcess("WinSCP");
    var hostName = GetVserverHostName(vServerURL);
    var cmdLineOpenWinSCP = '"' + GetWinSCPExeFilePath() + '" ' + connexionUsername + ":" + GetPercentEncodedString(connexionPassword) + "@" + hostName;
    var oExec = WshShell.Exec(cmdLineOpenWinSCP);
    oExec.StdIn.Close();
    
    var nbOfChecksLeft = 3;
    while (nbOfChecksLeft > 0 && Get_DlgWinSCPWarning().Exists){
        nbOfChecksLeft --;
        Delay(1000);
        if (Get_DlgWinSCPWarning_BtnUpdate().Exists)
            Get_DlgWinSCPWarning_BtnUpdate().Click();
        else
            Get_DlgWinSCPWarning().Keys("[Esc]");
        Delay(10000);
    }
        
    
    if (Get_WinWinSCP().Exists){
        Get_WinWinSCP().Maximize();
        return Get_WinWinSCP().WaitProperty("WndCaption", "*" + connexionUsername + "@" + hostName + " - WinSCP", 30000);
    }
    
    Log.Error("Unable to start WinSCP.");
    return false;
}



/**
    Description : Récupérer, via la base de registre, le chemin d'accès pour le fichier WinSCP.com
    Résultat : Chemin d'accès du fichier WinSCP.exe
               retourne "C:\Program Files (x86)\WinSCP\WinSCP.exe" par défaut (si la recherche dans la base de registre n'a pas été concluante)
*/
function GetWinSCPExeFilePath()
{
    var WinSCPInstallDefaultPath = "C:\\Program Files (x86)\\WinSCP\\"; //Chemin d'accès par défaut
    var uninstallRegistryKey = Storages.Registry("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall", HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
    for (var i = uninstallRegistryKey.SectionCount - 1; i >= 0; i--){
        var uninstallAppKey = uninstallRegistryKey.GetSubSectionByIndex(i).Name;
        if (aqString.Find(uninstallAppKey, "\\winscp") != -1){
            var WinSCPRegistryKey = Storages.Registry(uninstallAppKey, HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
            return WinSCPRegistryKey.GetOption("InstallLocation", WinSCPInstallDefaultPath) + "WinSCP.exe";
        }
    }
    
    Log.Warning("The WinSCP 'InstallLocation' was not found in the registry");
    return WinSCPInstallDefaultPath + "WinSCP.exe";
}



function DragAccountsToPortfolio(arrayOfAccountNumber)
{
    if (GetVarType(arrayOfAccountNumber) != varArray && GetVarType(arrayOfAccountNumber) != varDispatch)
        arrayOfAccountNumber = new Array(arrayOfAccountNumber);
    
    Delay(3000);
    
    //Aller au module Comptes et enlever toute sélection
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Sélectionner les comptes désirés
    for (var i in arrayOfAccountNumber){
        SearchAccount(arrayOfAccountNumber[i]);
        var accountNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayOfAccountNumber[i], 10);
        if (accountNumberCell.Exists)
            accountNumberCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The account number '" + arrayOfAccountNumber[i] + "' cell was not found.");
    }
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Warning("The Accounts data grid is empty, the drag action is not possible.");
        return false;
    }
    
    //Mailler ver le module Portefeuille
    Get_MenuBar_Modules().OpenMenu();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    var isDragSucessfull = Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (!isDragSucessfull) Log.Error("The Drag Accounts to Portfolio was not successfull.");
    return isDragSucessfull;
}



function AddIACodesToUser(stationID, arrayOfIACodes, vServerURL)
{
    if (GetVarType(arrayOfIACodes) != varArray && GetVarType(arrayOfIACodes) != varDispatch)
        arrayOfIACodes = new Array(arrayOfIACodes);
    
    Log.Message("Add the following IA Codes to user " + stationID + " : " + arrayOfIACodes);
    
    var userNum = Execute_SQLQuery_GetField("select USER_NUM from B_USER where STATION_ID = '" + stationID + "'", vServerURL, "USER_NUM");
    
    for (var i in arrayOfIACodes){
        var repID = Execute_SQLQuery_GetField("select REP_ID from B_REP where NO_REP = '" + arrayOfIACodes[i] + "'", vServerURL, "REP_ID");
        if (Trim(VarToStr(repID)) == "")
            Log.Error("REP_ID not found for NO_REP = '" + arrayOfIACodes[i] + "'");
        else
            Execute_SQLQuery("if not exists (select * from B_USEREP where USER_NUM = " + userNum + " and REP_ID = " + repID + ") insert into B_USEREP (USER_NUM, REP_ID) values (" + userNum + ", " + repID + ")", vServerURL);
    }
}



function DeleteIACodesForUser(stationID, arrayOfIACodes, vServerURL)
{
    if (GetVarType(arrayOfIACodes) != varArray && GetVarType(arrayOfIACodes) != varDispatch)
        arrayOfIACodes = new Array(arrayOfIACodes);
        
    Log.Message("Delete the following IA Codes for user " + stationID + " : " + arrayOfIACodes);
    
    var arrayOfRepID = new Array();
    for (var i in arrayOfIACodes){
        var repID = Execute_SQLQuery_GetField("select REP_ID from B_REP where NO_REP = '" + arrayOfIACodes[i] + "'", vServerURL, "REP_ID");
        if (Trim(VarToStr(repID)) == "")
            Log.Error("REP_ID not found for NO_REP = '" + arrayOfIACodes[i] + "'");
        else
            arrayOfRepID.push(Execute_SQLQuery_GetField("select REP_ID from B_REP where NO_REP = '" + arrayOfIACodes[i] + "'", vServerURL, "REP_ID"));
    }
    
    var userNum = Execute_SQLQuery_GetField("select USER_NUM from B_USER where STATION_ID = '" + stationID + "'", vServerURL, "USER_NUM");
    Execute_SQLQuery("delete from B_USEREP where USER_NUM = " + userNum + " and REP_ID in (" + arrayOfRepID.toString() + ")", vServerURL);
}



function UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, prefValue, prefLevel)
{
    try {
        if (GetVarType(arrayOfUsers) != varArray && GetVarType(arrayOfUsers) != varDispatch)
            arrayOfUsers = new Array(arrayOfUsers);

        Log.AppendFolder("Update pref PREF_EXPORT_STAT : value = " + prefValue + ", level = " + prefLevel, "for users : " + arrayOfUsers);
        for (var i in arrayOfUsers){
            var testUser = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", arrayOfUsers[i], "username");
            UpdatePrefAtLevelForUser(testUser, "PREF_EXPORT_STAT", prefValue, prefLevel, vServerDataHub);
        }
        RestartServices(vServerDataHub);
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        Log.PopLogFolder();
    }
}



function SelectIACodes(arrayOfIACode)
{
    Delay(3000);
    
    if (GetVarType(arrayOfIACode) != varArray && GetVarType(arrayOfIACode) != varDispatch)
        arrayOfIACode = new Array(arrayOfIACode);
    
    Log.Message("Select the following " + arrayOfIACode.length + " branches : " + arrayOfIACode);
        
    //D'abord, désélectionner "Enregister la sélection"
    
    ExecuteActionAndExpectSubmenus(Get_MenuBar_Users(), "Click");
    if (Get_MenuBar_Users_RememberMySelection().Exists && Get_MenuBar_Users_RememberMySelection_CheckboxImage().Exists && Get_MenuBar_Users_RememberMySelection_CheckboxImage().VisibleOnScreen)
        Get_MenuBar_Users_RememberMySelection().Click();
    
    ExecuteActionAndExpectSubmenus(Get_MenuBar_Users(), "Click");
    Get_MenuBar_Users_Selection().Click();
    Get_WinUserMultiSelection_TabIACodes().Click();
    
    for (var j = 0; j < arrayOfIACode.length; j++){
        var currentIACode = arrayOfIACode[j];
        Get_WinUserMultiSelection_TabIACodes_DgvBranches().Keys(currentIACode.substring(0, 1));
        Sys.Keys(currentIACode.substring(1));
        Sys.Keys("[Enter]");
        var currentIACodeCell = Get_WinUserMultiSelection_TabIACodes_DgvBranches().FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "RepresentativeId", currentIACode], 10);
        if (currentIACodeCell.Exists)
            currentIACodeCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The IA Code '" + currentIACode + "' cell was not found.");
    }
    
    if (Get_WinUserMultiSelection_TxtNumberOfSelectedIACodes().WPFControlText != IntToStr(arrayOfIACode.length))
        Log.Error("The number of selected IA Codes is not correct, expecting : " + arrayOfIACode.length);
    
    Get_WinUserMultiSelection_BtnApply().Click();
    
    Delay(3000);
}



//OK, but not used
function ClickRightInModuleGrid(moduleName, isClickRightOnSelectedRowMandatory)
{
    if (isClickRightOnSelectedRowMandatory == undefined) isClickRightOnSelectedRowMandatory = true;
    
    var dataGridRecordListControl = null;
    switch (aqString.ToUpper(moduleName)){
        case moduleName_Relationships : dataGridRecordListControl = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Clients : dataGridRecordListControl = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Accounts : dataGridRecordListControl = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Models : dataGridRecordListControl = Get_ModelsGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Orders : dataGridRecordListControl = Get_OrderGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Orders_Accumulator : dataGridRecordListControl = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10); break;
        case moduleName_Portfolio : dataGridRecordListControl = Get_Portfolio_PositionsGrid(); break;
        case moduleName_Securities : dataGridRecordListControl = Get_SecurityGrid().WPFObject("RecordListControl", "", 1); break;
        case moduleName_Transactions : dataGridRecordListControl = Get_Transactions_ListView(); break;
        default : Log.Error("Module '" + moduleName + "' not covered.");
    }
        
    if (moduleName == moduleName_Transactions)
        var selectedVisibleOnScreenRow = dataGridRecordListControl.FindChild(["ClrClassName", "IsSelected", "VisibleOnScreen"], ["DragableListViewItem", true, true], 10);
    else
        var selectedVisibleOnScreenRow = dataGridRecordListControl.FindChild(["ClrClassName", "IsSelected", "VisibleOnScreen"], ["DataRecordPresenter", true, true], 10);
            
    if (selectedVisibleOnScreenRow.Exists)
        ExecuteActionAndExpectSubmenus(selectedVisibleOnScreenRow, "CLICKR");
    else {
        if (isClickRightOnSelectedRowMandatory)
            Log.Error("There is no visible on screen selected row. The Click Right action will be executed through the keyboard '[Apps]' button.");
        
        ExecuteActionAndExpectSubmenus(Get_MainWindow(), "[Apps]");
    }
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
}



function ShuffleArray(varArray)
{
    var i = 0, j = 0, temp = null;

    for (i = varArray.length - 1; i > 0; i -= 1){
        j = Math.floor(Math.random() * (i + 1));
        temp = varArray[i];
        varArray[i] = varArray[j];
        varArray[j] = temp;
    }
    
    return varArray;
}



function GetRandomNbOfItemsInArray(varArray, maxNbOfItemsToBeSelected, minNbOfItemsToBeSelected)
{
    if (maxNbOfItemsToBeSelected == undefined)
        maxNbOfItemsToBeSelected = varArray.length;
        
    if (minNbOfItemsToBeSelected == undefined)
        minNbOfItemsToBeSelected = 2;
    
    var arrayOfRandomItems = varArray;
        
    if (varArray.length > 2){
        varArray = ShuffleArray(varArray);
        var nbOfRandomItems = 0;
        while (nbOfRandomItems < minNbOfItemsToBeSelected)
            nbOfRandomItems = Math.round(Math.random()*maxNbOfItemsToBeSelected);
        arrayOfRandomItems = varArray.slice(0, nbOfRandomItems);
    }
    
    return arrayOfRandomItems;
}



function NewArrayFill(nbOfItems, itemsValue)
{
    var newArrayFilled = new Array();
    for (var p = 0; p < nbOfItems; p++)
        newArrayFilled[p] = itemsValue;
    return newArrayFilled;
}



function CloseCroesus()
{
    Get_MainWindow().HoverMouse();
    Close_Croesus_MenuBar();
    var previousAutoTimeout = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
    RestoreAutoTimeOut(previousAutoTimeout);
}
