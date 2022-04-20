//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_004_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\4. Projection de liquidités (annuelle)\2.1 Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Amine A.
    version: 90.15-45
*/

function CR1485_004_Cli_Albert_Einstein_BD66_Q_12_31_2009E_800067_ANTOINETTA_STEAD_800067()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\4. Projection de liquidités (annuelle)\\2.1 Clients\\", "CR1485_004_Cli_Albert_Einstein_BD66_Q_12_31_2009E_800067_ANTOINETTA_STEAD_800067()");
    
    try {
        var reportName       = GetData(filePath_ReportsCR1485, "004_ANNIC", 1, language);
        var clientNumber     = GetData(filePath_ReportsCR1485, "004_ANNIC", 131);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePDFFirmPrefs(); 
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 133);
        
        //Ce cas est relatif à Destination = 'Ficher PDF' et checkUsePDFFileNamingConvention = true ; choisir le bon nom de fichier attendu car la fonction SetReportsOptionsNew ne ferait pas l'affaire
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE){
            if (CR1485_REPORTS_LANGUAGE == "french")
                reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 161);
        }
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination         = GetData(filePath_ReportsCR1485, "004_ANNIC", 136, language);
        var checkArchiveRepport = GetData(filePath_ReportsCR1485, "004_ANNIC", 137, language);
        var checkPrintDuplex    = GetData(filePath_ReportsCR1485, "004_ANNIC", 138, language);
        var sortBy              = GetData(filePath_ReportsCR1485, "004_ANNIC", 139, language);
        var currency            = GetData(filePath_ReportsCR1485, "004_ANNIC", 140, language);
        var reportLanguage      = GetData(filePath_ReportsCR1485, "004_ANNIC", 141, language);
        var source              = GetData(filePath_ReportsCR1485, "004_ANNIC", 142, language);
        var accountCriteria     = GetData(filePath_ReportsCR1485, "004_ANNIC", 143, language);
        var checkRemoveName     = GetData(filePath_ReportsCR1485, "004_ANNIC", 144, language);
        var title               = GetData(filePath_ReportsCR1485, "004_ANNIC", 145, language);
        
        var checkAddBranchAddress           = GetData(filePath_ReportsCR1485, "004_ANNIC", 146, language);
        var checkGroupInTheSameReport       = GetData(filePath_ReportsCR1485, "004_ANNIC", 147, language);
        var checkConsolidatePositions       = GetData(filePath_ReportsCR1485, "004_ANNIC", 148, language);
        var checkGroupUnderlyingClients     = GetData(filePath_ReportsCR1485, "004_ANNIC", 149, language);
        var checkUsePDFFileNamingConvention = GetData(filePath_ReportsCR1485, "004_ANNIC", 150, language);
        var checkIncludeMessage             = GetData(filePath_ReportsCR1485, "004_ANNIC", 151, language);
        var message                         = GetData(filePath_ReportsCR1485, "004_ANNIC", 152, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
        
        //Parameters values
        var startDate                   = GetData(filePath_ReportsCR1485, "004_ANNIC", 155, language);
        var checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "004_ANNIC", 156, language);
        var parametersSortBy            = GetData(filePath_ReportsCR1485, "004_ANNIC", 157, language);
        var numbering                   = GetData(filePath_ReportsCR1485, "004_ANNIC", 158, language);
        
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
                
        //Validate and save report
        var isDestinationPDFFile = true;
        var findExactFileName = (aqString.ToUpper(checkUsePDFFileNamingConvention) == "VRAI" || aqString.ToUpper(checkUsePDFFileNamingConvention) == "TRUE");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, isDestinationPDFFile, findExactFileName);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 161);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency       = GetData(filePath_ReportsCR1485, "004_ANNIC", 164, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "004_ANNIC", 165, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, isDestinationPDFFile, findExactFileName);
   }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        DesactivatePDFFirmPrefs();
        Terminate_CroesusProcess();
    }
    
}