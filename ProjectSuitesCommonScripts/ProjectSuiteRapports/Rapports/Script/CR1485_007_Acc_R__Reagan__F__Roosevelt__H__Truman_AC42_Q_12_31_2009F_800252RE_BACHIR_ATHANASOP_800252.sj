//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_007_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\7. Sommaire du document\3.1 Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Amine A.
    version: 90.15-45
*/

function CR1485_007_Acc_R__Reagan__F__Roosevelt__H__Truman_AC42_Q_12_31_2009F_800252RE_BACHIR_ATHANASOP_800252()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\7. Sommaire du document\\3.1 Comptes\\", "CR1485_007_Acc_R__Reagan__F__Roosevelt__H__Truman_AC42_Q_12_31_2009F_800252RE_BACHIR_ATHANASOP_800252()");
    
    try {
        var reportName          = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 94, language);
        var arrayOfReportsNames = reportName.split("|");
        var accountNumber       = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 95);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePDFFirmPrefs(); 
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);        
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 97);
        
        //Ce cas est relatif à Destination = 'Ficher PDF' et checkUsePDFFileNamingConvention = true ; choisir le bon nom de fichier attendu car la fonction SetReportsOptionsNew ne ferait pas l'affaire
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE){
            if (CR1485_REPORTS_LANGUAGE == "french")
                reportFileName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 123);
        }
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Document Summary report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        var destination         = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 100, language);
        var checkArchiveRepport = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 101, language);
        var checkPrintDuplex    = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 102, language);
        var sortBy              = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 103, language);
        var currency            = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 104, language);
        var reportLanguage      = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 105, language);
        var source              = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 106, language);
        var accountCriteria     = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 107, language);
        var checkRemoveName     = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 108, language);
        var title               = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 109, language);
        
        var checkAddBranchAddress           = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 110, language);
        var checkGroupInTheSameReport       = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 111, language);
        var checkConsolidatePositions       = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 112, language);
        var checkGroupUnderlyingClients     = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 113, language);
        var checkUsePDFFileNamingConvention = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 114, language);
        var checkIncludeMessage             = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 115, language);
        var message                         = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 116, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
       
        //Parameters values
        var asOfDate  = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 119, language);
        var numbering = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 120, language);
        
        //Set the report parameters
        SetReportParameters(asOfDate, numbering);
        
        //Validate and save report
        var isDestinationPDFFile = true;
        var findExactFileName = (aqString.ToUpper(checkUsePDFFileNamingConvention) == "VRAI" || aqString.ToUpper(checkUsePDFFileNamingConvention) == "TRUE");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, isDestinationPDFFile, findExactFileName);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 123);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Document Summary report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        var currency       = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 126, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 127, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, numbering);
        
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