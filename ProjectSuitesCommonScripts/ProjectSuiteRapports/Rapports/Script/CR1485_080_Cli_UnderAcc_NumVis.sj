//USEUNIT CR1485_080_Common_functions
//USEUNIT CR1485_125_Common_functions
//USEUNIT DBA


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\80. Transactions (mensuelles)\1.1 Clients
                  https://jira.croesus.com/browse/CROES-1707
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-6--V9-croesus-co7x-1_8_2_653
*/

function CR1485_080_Cli_UnderAcc_NumVis()
{
    Log.Message("CR1092 / CR1252");
    Log.Link("https://jira.croesus.com/browse/CROES-1707", "JIRA CROES-1707");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\80. Transactions (mensuelles)\\1.1 Clients", "CR1485_080_Cli_UnderAcc_NumVis()");
    
    try {
        //1. Rouler le script : ScriptFlottantFDP_CR1092.sql
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        Log.Message("JIRA CROES-1707 : Rouler le script ScriptFlottantFDP_CR1092.sql", "", pmNormal, logAttributes);
        var startDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
        var ScriptFlottantFDP_CR1092_SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR1092_CR1252\\ScriptFlottantFDP_CR1092.sql";
        var ScriptFlottantFDP_CR1092_SQLFileContent = Trim(aqFile.ReadWholeTextFile(ScriptFlottantFDP_CR1092_SQLFilePath, aqFile.ctANSI));
        
        var ScriptFlottantFDP_CR1092_CR1252_SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR1092_CR1252\\ScriptFlottantFDP_CR1092_CR1252.sql";
        if (aqFileSystem.Exists(ScriptFlottantFDP_CR1092_CR1252_SQLFilePath))
            if (!aqFileSystem.DeleteFile(ScriptFlottantFDP_CR1092_CR1252_SQLFilePath))
                Log.Error("Erreur lors de la suppression du fichier : " + ScriptFlottantFDP_CR1092_CR1252_SQLFilePath);
        
        Log.Message("Execute SQL file content : " + ScriptFlottantFDP_CR1092_SQLFilePath, ScriptFlottantFDP_CR1092_SQLFileContent);
        var lineSeparator = (aqString.Find(ScriptFlottantFDP_CR1092_SQLFileContent, "\r\n") == -1)? "\n": "\r\n";
        
        //Pour suppression de la procédure sp_create_msg_id au cas où elle existait (voir suppression à la fin du script SQL)
        var priorProcedureExistenceMessage = "LA PROCEDURE sp_create_msg_id EXISTAIT, SUPPRESSION : " + startDateTimeString;
        ScriptFlottantFDP_CR1092_SQLFileContent =  "if object_id('sp_create_msg_id') is not null drop proc sp_create_msg_id" + lineSeparator + "GO" + lineSeparator + lineSeparator + ScriptFlottantFDP_CR1092_SQLFileContent;
        ScriptFlottantFDP_CR1092_SQLFileContent = "if object_id('sp_create_msg_id') is not null print '" + priorProcedureExistenceMessage + "'" + lineSeparator + ScriptFlottantFDP_CR1092_SQLFileContent;
        
        //Pour vérification de la connexion à la BD
        var DBConnexionSuccessToken = "LA CONNEXION A LA BASE DE DONNEE A REUSSI : " + startDateTimeString;
        ScriptFlottantFDP_CR1092_SQLFileContent = "print '" + DBConnexionSuccessToken + "'" + lineSeparator + "GO" + lineSeparator + lineSeparator + ScriptFlottantFDP_CR1092_SQLFileContent;
        
        //Pour vérification d'éventuels messages d'erreurs
        var SQLExecutionErrorToken = "IL Y A EU ERREUR EXECUTION SQL : " + startDateTimeString;
        var arrayOfSQLLines = ScriptFlottantFDP_CR1092_SQLFileContent.split(lineSeparator);
        for (var i in arrayOfSQLLines)
            if (aqString.ToLower(Trim(arrayOfSQLLines[i])) == 'go')
                arrayOfSQLLines[i] = arrayOfSQLLines[i] + lineSeparator + lineSeparator + "if @@error > 0 print '" + SQLExecutionErrorToken + "'" + lineSeparator + "GO" + lineSeparator;
        
        if (!aqFile.WriteToTextFile(ScriptFlottantFDP_CR1092_CR1252_SQLFilePath, arrayOfSQLLines.join(lineSeparator), aqFile.ctANSI, true))
            Log.Error("Erreur lors de la création du fichier : " + ScriptFlottantFDP_CR1092_CR1252_SQLFilePath, arrayOfSQLLines.join(lineSeparator));
        
        //Exécuter le fichier SQL
        var strISQLOutput = ExecuteSQLFile_ThroughISQL(ScriptFlottantFDP_CR1092_CR1252_SQLFilePath, vServerReportsCR1485);
        
        //Vérifier s'il y a eu erreur de connexion à la BD
        if (strISQLOutput === null || aqString.Find(strISQLOutput, DBConnexionSuccessToken) == -1)
            Log.Error("JIRA CROES-1707 : Erreur d'exécution, fichier du ScriptFlottantFDP_CR1092.sql : " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
        
        if (strISQLOutput !== null){
            //Vérifier s'il y a eu quelque erreur d'exécution SQL
            if (aqString.Find(strISQLOutput, priorProcedureExistenceMessage) != -1)
                Log.Warning("JIRA CROES-1707 : Existence antérieure de la procédure 'sp_create_msg_id', procédé à sa suppression préalable, fichier du ScriptFlottantFDP_CR1092.sql : " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
            
            
            //Vérifier s'il y a eu quelque erreur d'exécution SQL
            if (aqString.Find(strISQLOutput, SQLExecutionErrorToken) != -1)
                Log.Warning("JIRA CROES-1707 : Présence d'erreur d'exécution, fichier du ScriptFlottantFDP_CR1092.sql : " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
            
            var arrISQLOutputLines = strISQLOutput.split("\n");
            for (var i in arrISQLOutputLines){
                if (aqString.StrMatches("^Msg\\b\\z\,\\b\Level\\b\\z\,\\b\State\\b\\z\:$", Trim(arrISQLOutputLines[i]))){ //Example : "Msg 2812, Level 16, State 5:";
                    Log.Warning("JIRA CROES-1707 : Présence de Message(s) d'erreur d'exécution SQL, fichier du ScriptFlottantFDP_CR1092.sql : " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
                    break;
                }
            }
            
            //Vérifier la création effective du message dans B_MSG et B_MSG_GRP
            var createdMsgID = null;
            for (var i = 0; i < arrISQLOutputLines.length; i++){
                if (Trim(arrISQLOutputLines[i]) == "Return parameters:"){
                    for (var j = i; j < arrISQLOutputLines.length - 1; j++){
                        if (Trim(arrISQLOutputLines[j]) == "-------------"){
                            createdMsgID = arrISQLOutputLines[j + 1];
                            break;
                        }
                    }
                    break;
                }
            }
            
            if (createdMsgID == null)
                Log.Error("JIRA CROES-1707 : ID du message créé non trouvé dans le résultat d'exécution SQL du fichier " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
            else {
                Log.Checkpoint("JIRA CROES-1707 : ID du message créé '" + createdMsgID + "' trouvé dans le résultat d'exécution SQL du fichier " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
            
                //Vérification de la présence du message créé dans la table B_MSG
                var countMsgID_B_MSG = Execute_SQLQuery_GetField("select count(*) as countMsgID_B_MSG from B_MSG where MSG_ID = " + createdMsgID, vServerReportsCR1485, "countMsgID_B_MSG");
                if (countMsgID_B_MSG > 0)
                    Log.Checkpoint("JIRA CROES-1707 : Message ID '" + createdMsgID + "' effectivement trouvé dans la table B_MSG.");
                else
                    Log.Error("JIRA CROES-1707 : Message ID '" + createdMsgID + "' non trouvé dans la table B_MSG.");
                
                //Vérification de la présence du message créé dans la table B_MSG_GRP
                var countMsgID_B_MSG_GRP = Execute_SQLQuery_GetField("select count(*) as countMsgID_B_MSG_GRP from B_MSG_GRP where MSG_ID = " + createdMsgID, vServerReportsCR1485, "countMsgID_B_MSG_GRP");
                if (countMsgID_B_MSG_GRP > 0)
                    Log.Checkpoint("JIRA CROES-1707 : Message ID '" + createdMsgID + "' effectivement trouvé dans la table B_MSG_GRP.");
                else
                    Log.Error("JIRA CROES-1707 : Message ID '" + createdMsgID + "' non trouvé dans la table B_MSG_GRP.");
            }
            
            
            //Vérifier la présence du message de succès dans le résultat d'exécution SQL
            var expectedCR1092SuccessString = "(return status = 0)";
            var expectedSuccessStringCount = 1;
            var successStringCount = strISQLOutput.split(expectedCR1092SuccessString).length - 1;
            switch (successStringCount){
                case 0 :
                    Log.Error("JIRA CROES-1707 : Message de succès '" + expectedCR1092SuccessString + "' non trouvé dans le résultat d'exécution SQL du fichier " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
                    break;
                
                case expectedSuccessStringCount :
                    Log.Checkpoint("JIRA CROES-1707 : Message de succès '" + expectedCR1092SuccessString + "' trouvé " + successStringCount + " fois dans le résultat d'exécution SQL du fichier " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
                    break;
                
                default :
                    Log.Warning("JIRA CROES-1707 : Message de succès '" + expectedCR1092SuccessString + "' trouvé " + successStringCount + " fois au lieu de " + expectedSuccessStringCount + " fois attendu dans le résultat d'exécution SQL du fichier " + ScriptFlottantFDP_CR1092_SQLFilePath, strISQLOutput);
                    break;
            }
        }
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        var firm_code_UserNameKEYNEJ = GetUserFirmCode(userNameKEYNEJ, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_REPORT_FDP_TRANSCOVERPAGE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_REPORT_FDP_TRANSACTION", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_RECAP_TRADE_REPORT", "YES", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
        
        
        
        //************************* Vérifier si le rapport 'Rapport de transactions (mensuel)' est disponible dans les rapports sauvegardés de la firme *********************
        
        try {
            var firmSavedReportName = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 2, language);
            
            //Login and goto Clients module
            Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
            
            //Open Reports window and Select report
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            if (SelectFirmSavedReport(firmSavedReportName) == false)
                Log.Error("JIRA CROES-1707 : Le rapport '" + firmSavedReportName + "' n'était pas disponible dans les rapports sauvegardés de la firme.", "", pmNormal, logAttributes);
            else {
                Log.Checkpoint("JIRA CROES-1707 : Le rapport '" + firmSavedReportName + "' était disponible dans les rapports sauvegardés de la firme.", "", pmNormal, logAttributes);
                VerifyIfReportsAreDisplayedInCurrentReports();
            }
        
            var reportsWindowTitle = Get_WinReports().Title.OleValue;
            if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
                Get_Reports_GrpReports_BtnRemoveAllReports().Click();
            Get_WinReports_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 30000);
            Close_Croesus_MenuBar();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
        }
        catch(e_savedReport) {
            Log.Error("Exception: " + e_savedReport.message, VarToStr(e_savedReport.stack));
            e_savedReport = null;
        }
        finally {
            Terminate_CroesusProcess();
        }
        
        
        //************************* Generate report *********************
        var reportName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 1, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 36);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Valider que le rapport 'RELEVÉ DE TRANSACTIONS' n'est pas disponible *********************
        var reportNotToBeDisplayed = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 37, language);

        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        if (SelectAReportWithoutErrorMessage(reportNotToBeDisplayed) == true)
            Log.Error("JIRA CROES-1707 : Le rapport '" + reportNotToBeDisplayed + "' était disponible.", "", pmNormal, logAttributes);
        else
            Log.Checkpoint("JIRA CROES-1707 : Le rapport '" + reportNotToBeDisplayed + "' n'était pas disponible.", "", pmNormal, logAttributes);
        
        var reportsWindowTitle = Get_WinReports().Title.OleValue;
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 30000);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 38);
        
        //Vérifier si le rapport 'Transactions (mensuelles)' est disponible dans les rapports sauvegardés de la firme
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        if (SelectReports(reportName) == false)
            Log.Error("JIRA CROES-1707 : Le rapport '" + reportName + "' n'était pas disponible.", "", pmNormal, logAttributes);
        else
            Log.Checkpoint("JIRA CROES-1707 : Le rapport '" + reportName + "' était disponible.", "", pmNormal, logAttributes);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 41, language);
        var sortBy = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 42, language);
        var currency = null; //GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 43, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 44, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 45, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 46, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 47, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 48, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 49, language);
        var message = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var numbering = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 53, language);
        
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Vérifier si le rapport 'Transactions (mensuelles)' est disponible dans les rapports sauvegardés de la firme
        if (SelectReports(reportName) == false)
            Log.Error("JIRA CROES-1707 : Le rapport '" + reportName + "' n'était pas disponible.", "", pmNormal, logAttributes);
        else
            Log.Checkpoint("JIRA CROES-1707 : Le rapport '" + reportName + "' était disponible.", "", pmNormal, logAttributes);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = null; //GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 59, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 60, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        if (firm_code_UserNameKEYNEJ != undefined){
            Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_REPORT_FDP_TRANSCOVERPAGE", null, vServerReportsCR1485);
            Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_REPORT_FDP_TRANSACTION", null, vServerReportsCR1485);
            Activate_Inactivate_PrefFirm(firm_code_UserNameKEYNEJ, "PREF_RECAP_TRADE_REPORT", null, vServerReportsCR1485);
            RestartServices(vServerReportsCR1485);
        }
        Terminate_CroesusProcess();
    }
    
    
    function GetUserFirmCode(user, vServerURL)
    {
        var no_succ = Execute_SQLQuery_GetField("select NO_SUCC from B_USER where STATION_ID = '" + user + "'", vServerURL, "NO_SUCC");
        var firm_id = Execute_SQLQuery_GetField("select FIRM_ID from B_SUCC where NO_SUCC = '" + no_succ + "'", vServerURL, "FIRM_ID");
        var firm_code = Execute_SQLQuery_GetField("select FIRM_CODE from B_FIRM where FIRM_ID = " + firm_id, vServerURL, "FIRM_CODE");
        return firm_code;
    }
}


/**
    Description : Sélectionne un rapport
    Paramètres :
        - reportName : le nom du rapport à sélectionner
    Résultat : Rapport sélectionné
    Auteur : Christophe Paring
*/
function SelectAReportWithoutErrorMessage(reportName)
{
    var reportNameWithoutAccents = RemoveAccentsInString(reportName);
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
            
            var currentReportNameWithoutAccents = RemoveAccentsInString(currentReportName);
            var currentReportNameFirstChar = aqString.ToLower(aqString.GetChar(currentReportName, 0));
            
            if ((currentReportNameFirstChar != reportNameFirstChar)/* || (aqString.Compare(reportNameWithoutAccents, currentReportNameWithoutAccents, true) == -1)*/)
                break;
            
            if (currentReportName == reportName){
                Get_Reports_GrpReports_BtnAddAReport().Click();
                Log.Message("Report '" + currentReportName + "' selected.");
                return true;
            }
        
            Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
        }
    }
    
    Log.Message("Report '" + reportName + "' not found!");
    return false;
}
