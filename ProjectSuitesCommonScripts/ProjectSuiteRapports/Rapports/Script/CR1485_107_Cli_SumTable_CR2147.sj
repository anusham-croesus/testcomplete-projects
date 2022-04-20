//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_107_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\2.2 Clients\"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
    Date: 13/02/2020
    Version de scriptage: 90.15.2020.3-7
*/

function CR1485_107_Cli_SumTable_CR2147()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\\2.2 Clients\\", "CR1485_107_Cli_SumTable_CR2147()");
    
    try {
                
        //Préconditions
        Log.Message("Activation des PREfs");
        var query = "insert into b_config values('TAX_REPORT_NON_REGISTERED_ACCOUNTS',0,'Reports/Rapports',1,'Cette configuration définit les types des tit','This configuration defines the types of unreg',\r\n" +
                    "'NULL','NULL','NULL','ACCOUNT_TYPE_NON_REGISTERED= A,C,E\r\n" +
                    "SECURITY_TAX_SLIP_NON_REGISTERED=2611392,315,3158000,3158001,3158002,3158007,3158008,3158015,330,3807000,3807500,3807850,3807680',1,1)\r\n";
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_FOREIGN_PROPERTY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
        Execute_SQLQuery("delete from b_config where cle='TAX_REPORT_NON_REGISTERED_ACCOUNTS'", vServerReportsCR1485);
        Log.Message("Execute_SQLQuery : " + query, query);
        Execute_SQLQuery(query, vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");  
    
        reportName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 200, language);
        arrayOfReportsNames = reportName.split("|");
        clientsNumbers = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 201);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        Log.Message("Sélection des clients");
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 203);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the second report and move it up
        Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).Click();
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 206, language);
        sortBy = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 207, language);
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 208, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 209, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 210, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 211, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 212, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 213, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 214, language);
        message = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 215, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 218, language);
        startDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 219, language);
        foreignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 221, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 220, language);
        checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 222, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 223, language);
        summaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 224, language);
        paginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 225, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, paginationValue, summaryTableValue);
        
        //Select the first report
        Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 2).Click();
        
        //Parameters values
        startDateMonth1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 228, language);
        startDateYear1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 229, language);
        foreignPropertyValue1 = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 231, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 230, language);
        checkIncludeSummaryTable1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 232, language);
        checkIncludeNonregisteredAccountsOnly1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 233, language);
        summaryTableValue1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 234, language);
        paginationValue1 = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 235, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth1, startDateYear1, foreignPropertyValue1, checkIncludeSummaryTable1, checkIncludeNonregisteredAccountsOnly1, paginationValue1, summaryTableValue1);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 237);
        
       //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the first report 
        Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).Click();
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 240, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 241, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, paginationValue, summaryTableValue);
        
        //Select the second report 
        Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 2).Click();
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParameters(startDateMonth1, startDateYear1, foreignPropertyValue1, checkIncludeSummaryTable1, checkIncludeNonregisteredAccountsOnly1, paginationValue1, summaryTableValue1);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Execute_SQLQuery("delete from b_config where cle='TAX_REPORT_NON_REGISTERED_ACCOUNTS'", vServerReportsCR1485);
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}
/*
function SelectClients(arrayOfClientsNumbersToBeSelected)
{
    if (GetVarType(arrayOfClientsNumbersToBeSelected) != varArray && GetVarType(arrayOfClientsNumbersToBeSelected) != varDispatch)
        arrayOfClientsNumbersToBeSelected = new Array(arrayOfClientsNumbersToBeSelected);
    
    //Aller au module Clients et enlever toute sélection
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Error("The Clients data grid is empty.");
        return false;
    }
    
    //Sélectionner les Clients désirés
    for (var i in arrayOfClientsNumbersToBeSelected){
        Search_Client(arrayOfClientsNumbersToBeSelected[i]);
        var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChildEx("Text", arrayOfClientsNumbersToBeSelected[i], 10, true, 30000);
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
*/


function Get_WinParameters_GrpSummaryTableValue()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Valeur pour le tableau sommaire"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Summary Table Value"], 10)}
}