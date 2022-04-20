//USEUNIT CR1806_Helper




/**
    Description : Valider l'exportation des données des rapports MULTIPLE
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4717
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE()
{
    Log.Message("CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE()");
    CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4717", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        NameMapping.TimeOutWarning = false;
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        
        //Se connecter avec l'utilisateur FORTIM
        var userNameFORTIM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTIM", "username");
        var passwordFORTIM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTIM", "psw");
        var IACodesString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4717_IACodes", language + client);
        var arrayOfIACodes = IACodesString.split("|");
        var expectedStationID = userNameFORTIM;
        
        var stringOfOfReportsNames_step1 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4717_ReportsNames_step1", language + client);
        var stringOfOfReportsNames_step2 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4717_ReportsNames_step2", language + client);
        var stringOfOfReportsNames_step3 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4717_ReportsNames_step3", language + client);
                
        var prefValue = "YES";
        var prefLevel = "USER";
        var shouldExportSuccess = true;
        var isCfLoaderCommandToBeChecked = false;
        var exportMethod = exportMethod_Toolbar_Reports;
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(userNameFORTIM, prefValue, prefLevel);
        
        //Se connecter avec l'utilisateur
        Login(vServerDataHub, userNameFORTIM, passwordFORTIM, language);
        Delay(3000);
        
        
        //STEP 1
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            Log.Message("********** STEP 1 : RAPPORTS QUI SONT DE TYPE 10 - MODULE CLIENTS *************", "", pmNormal, logAttributes);
            var nbOfTestedReports = 0;
            var arrayOfOfReportsNames_step1 = stringOfOfReportsNames_step1.split(";");
            for (var i = 0; i < arrayOfOfReportsNames_step1.length; i++){
                var reportName = arrayOfOfReportsNames_step1[i].split("|")[0];
                var reportDisplayedName = arrayOfOfReportsNames_step1[i].split("|")[1];
                if (!IsReportType10(reportName, reportDisplayedName)){
                    Log.Error("Report '" + reportDisplayedName + "' will not be tested because REPORT_NAME '" + reportName + "' is not of type 10 reports.", "", pmNormal, logAttributes);
                    continue;
                }
            
                //Aller au module
                var moduleName = moduleName_Clients;
                GotoModule(moduleName);
        
                //Sélectionner les lignes
                SelectAllRowsOfIACodes(arrayOfIACodes);
                
                //Récupérer la liste des Codes CP effectivement sélectionnés
                var arrayOfSelectedIACodes = GetIACodesOfSelectedItems(moduleName);
        
                //Faire le test pour le rapport
                ExecuteManyExportsForReports(expectedStationID, moduleName, reportDisplayedName, reportName, shouldExportSuccess, isCfLoaderCommandToBeChecked, exportMethod, arrayOfSelectedIACodes);
                nbOfTestedReports++;
                
                //Cliquer sur le bouton OK de l'éventuel boîte de dialogue "Statut d’impression / Messages"
                SetAutoTimeOut();
                if (Get_DlgPrintingStatusMessageLogs().Exists)
                    Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
                RestoreAutoTimeOut();
            }
            
            if (nbOfTestedReports == 0)
                Log.Error("No reports tested for this step.");
        }
        
        
        //STEP 2
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Securities){
            Log.Message("********** STEP 2 : RAPPORTS QUI SONT DE TYPE 10 - MODULE TITRES *************", "", pmNormal, logAttributes);
            var nbOfTestedReports = 0;
            var arrayOfOfReportsNames_step2 = stringOfOfReportsNames_step2.split(";");
            for (var j = 0; j < arrayOfOfReportsNames_step2.length; j++){
                var reportName = arrayOfOfReportsNames_step2[j].split("|")[0];
                var reportDisplayedName = arrayOfOfReportsNames_step2[j].split("|")[1];
                if (!IsReportType10(reportName, reportDisplayedName)){
                    Log.Error("Report '" + reportDisplayedName + "' will not be tested because REPORT_NAME '" + reportName + "' is not of type 10 reports.", "", pmNormal, logAttributes);
                    continue;
                }
                
                //Aller au module
                var moduleName = moduleName_Securities;
                GotoModule(moduleName);
                
                //Sélectionner un titre
                Log.Message("Select a security");
                var arrayOfVisibleRows = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindAllChildren(["ClrClassName", "IsHeaderRecord", "VisibleOnScreen"], ["DataRecordPresenter", false, true], 10).toArray();
                if (arrayOfVisibleRows.length == 0)
                    Log.Error("There is no diplayed item in the Security grid.");
                else
                    ShuffleArray(arrayOfVisibleRows)[0].Click();
                
                //Récupérer la liste des Codes CP effectivement sélectionnés
                var arrayOfSelectedIACodes = GetIACodesOfSelectedItems(moduleName);
                
                //Faire le test pour le rapport
                ExecuteManyExportsForReports(expectedStationID, moduleName, reportDisplayedName, reportName, shouldExportSuccess, isCfLoaderCommandToBeChecked, exportMethod, arrayOfSelectedIACodes);
                nbOfTestedReports++;
                
                //Cliquer sur le bouton OK de l'éventuel boîte de dialogue "Statut d’impression / Messages"
                SetAutoTimeOut();
                if (Get_DlgPrintingStatusMessageLogs().Exists)
                    Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
                RestoreAutoTimeOut();
            }

            if (nbOfTestedReports == 0)
                Log.Error("No reports tested for this step.");
        }
        
        //STEP 3
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            Log.Message("********** STEP 3 : RAPPORTS QUI NE SONT PAS DE TYPE 10 - MODULE CLIENTS *************", "", pmNormal, logAttributes);
            var nbOfTestedReports = 0;
            var arrayOfOfReportsNames_step3 = stringOfOfReportsNames_step3.split(";");
            for (var k = 0; k < arrayOfOfReportsNames_step3.length; k++){
                var reportName = arrayOfOfReportsNames_step3[k].split("|")[0];
                var reportDisplayedName = arrayOfOfReportsNames_step3[k].split("|")[1];
                if (IsReportType10(reportName, reportDisplayedName)){
                    Log.Error("Report '" + reportDisplayedName + "' will not be tested because REPORT_NAME '" + reportName + "' is of type 10 reports.", "", pmNormal, logAttributes);
                    continue;
                }
                
                //Aller au module
                var moduleName = moduleName_Clients;
                GotoModule(moduleName);
                
                //Sélectionner les lignes
                SelectAllRowsOfIACodes(arrayOfIACodes);
                
                //Récupérer la liste des Codes CP effectivement sélectionnés
                var arrayOfSelectedIACodes = GetIACodesOfSelectedItems(moduleName);
                
                //Faire le test pour le rapport
                ExecuteManyExportsForReports(expectedStationID, moduleName, reportDisplayedName, reportName, shouldExportSuccess, isCfLoaderCommandToBeChecked, exportMethod, arrayOfSelectedIACodes);
                nbOfTestedReports++;
                
                //Cliquer sur le bouton OK de l'éventuel boîte de dialogue "Statut d’impression / Messages"
                SetAutoTimeOut();
                if (Get_DlgPrintingStatusMessageLogs().Exists)
                    Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
                RestoreAutoTimeOut();
            }
            
            if (nbOfTestedReports == 0)
                Log.Error("No reports tested for this step.");
        }
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        if (userNameFORTIM != undefined) UpdateDataHubPrefAtSameLevelForUsers(userNameFORTIM, null, prefLevel); //Mettre la Pref à sa valeur par défaut
        Terminate_CroesusProcess();
        NameMapping.TimeOutWarning = true;
    }
}



/**
    Testée sur les modules Relations, Clients et Comptes
*/
function SelectAllRowsOfIACodes(arrayOfIACodes, recordListControlObject)
{
    Log.Message("Select rows of the following IA Codes : " + arrayOfIACodes);
    
    if (GetVarType(arrayOfIACodes) != varArray && GetVarType(arrayOfIACodes) != varDispatch)
        arrayOfIACodes = new Array(arrayOfIACodes);
    
    if (recordListControlObject == undefined)
        recordListControlObject = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1);
    
    recordListControlObject.Click();
    do {
        var formerIsActiveRowIndex = GetIsActiveRowIndex(recordListControlObject);
        Sys.Keys("[PageDown][PageDown]");
        var currentIsActiveRowIndex = GetIsActiveRowIndex(recordListControlObject);
        var isEndOfGridReached = (formerIsActiveRowIndex == currentIsActiveRowIndex);
    } while (!isEndOfGridReached)
    
    for (var i = 0; i < recordListControlObject.Items.Count; i++){
        var currentIACode = VarToStr(recordListControlObject.Items.Item(i).DataItem.get_RepresentativeNumber());
        recordListControlObject.Items.Item(i).set_IsSelected((GetIndexOfItemInArray(arrayOfIACodes, currentIACode) != -1));
    }
}



function GetIsActiveRowIndex(recordListControlObject)
{
    for (var i = 0; i < recordListControlObject.Items.Count; i++)
        if (recordListControlObject.Items.Item(i).IsActive)
            return i;
    return null;
}


function IsReportType10(REPORT_NAME, reportDisplayedName)
{
    var valueType10 = "10";
    var querySQL = "select REPORT_TYPE from B_REPORT where REPORT_NAME = '" + REPORT_NAME + "'";
    var queryResult = Execute_SQLQuery_GetField(querySQL, vServerDataHub, "REPORT_TYPE");
    Log.Message("REPORT_TYPE = " + queryResult + " for report '" + reportDisplayedName + "' (REPORT_NAME = " + REPORT_NAME + ").", querySQL);
    return (Trim(VarToStr(queryResult)) == valueType10);
}