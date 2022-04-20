//USEUNIT ExcelUtils

//Le mot de passe par défaut pour la connexion SSH au Vserver
//SVP s'assurer qu'il n'y a pas de caractères non ASCII dans le mot de passe, ni les caractères Espace et Double-quotes
//Pour utiliser un mot de passe spécifique pour le vserver d'un projet, le renseigner dans ExecutionVServers.xlsx à la colonne ROOT_PSWD
var VSERVER_SSH_ROOT_DEFAULT_PSWD = "TestsAuto2019!!";

var WINDOWS_DISPLAY_LANGUAGE = null; //La langue d'affichage de Windows (pourra être 'french' ou 'english')
var TIMER_TIMEOUT_LOGIN = null; //Timer pour la durée maximale du Login
var PROJECT_AUTO_WAIT_TIMEOUT = Options.Run.Timeout; //Le temps d'attente initial Auto-wait timeout du projet
NameMapping.TimeOutWarning = false;

//Le Client
var client = ProjectSuite.Variables.executionClient;
//var client = "BNC" //BNC, CIBC, TD, RJ, US, RGMP, VMD, VMBL,GPD

//Temps max pour une pause dynamique
var maxWaitTime = 60000;

//COMMON
var folderPath_ProjectSuiteCommonScripts = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.ParentFolder.Path + "ProjectSuitesCommonScripts\\";
var folderPath_Data = aqFileSystem.GetFolderInfo(folderPath_ProjectSuiteCommonScripts).ParentFolder.Path + "Data\\";
var filePath_ExecutionVServers = folderPath_Data + "ExecutionVServers.xlsx";
var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username"); 
var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
var filePath_Common = folderPath_Data + "data_common_scripts.xlsx";
var filePath_RemoteExecutionDisconnecting = folderPath_ProjectSuiteCommonScripts + "RemoteExecutionDisconnecting.bat";
var devOpsDeploymentFilePath = folderPath_ProjectSuiteCommonScripts + "DevOps\\ReleaseFoundations\\current\\ReleaseFoundations.psm1";
var logRootFolderPath = "\\\\srvfs1\\pub\\aq\\Tests Automatisés\\Execution\\" + client + "\\" ;
var filePath_PublishedDataLocations = ProjectSuite.Path + "PublishedDataLocations.properties";

var authUser = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "AUTHUSER", "username"); 
var authPsw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "AUTHUSER", "psw");

//La langue d’exécution
var language = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 2);
if (language != "french" && language != "english"){
    language = (client == "RJ" || client == "TD" || client == "US" || client == "CIBC" || client == "RGMP"|| client == "SH")? "english": "french";
}
if (aqString.Find(Project.FileName,"Billing.mds") != -1) language = "english"; //EM : Ajouté pour Billing car il faut que Billing soit testé en anglais
//var language = "english"; //english or french
//var language = "french"; //english or french

//Browser
var browserName = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 3);
if (browserName != "iexplore" && browserName != "firefox" && browserName != "chrome" && browserName != "edge"){
    browserName = "iexplore";
}

// Choisir une version BE ou CO ou ER (la page login est différent)
var VERSION_LOGIN_COL_NUM = 4;
var VERSION_LOGIN_ROW_NUM = 1;
var versionReference = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", VERSION_LOGIN_COL_NUM, VERSION_LOGIN_ROW_NUM);
var projet = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 4);
var VSERVER_CHECK_MAXTRIES = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 5);//Nombre maximum d'essais pour les tests de connexion SSH et Login (typiquement dans la PreExecution); 0 => l'arrêt prématuré de toute l'exécution est désactivée
////
//LES VARIABLES GLOBALES POUR MiniRegression
var vServerMiniRegression = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 20);

//LES VARIABLES GLOBALES POUR LE MODULE TITRE
var vServerTitre = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 5);
var dataPoolTitre = folderPath_Data + "DataPoolUsers.xlsx";
var filePath_Titre = folderPath_Data + "data_Titre.xlsx";

//LES VARIABLES GLOBALES POUR LE MODULE PORTEFEUILLE
var vServerPortefeuille = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 9);
var filePath_Portefeuille = folderPath_Data + "data_Portefeuille.xlsx";

//LES VARIABLES GLOBALES POUR LE  MODULE MODELES
var vServerModeles = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 16);
var filePath_Modeles = folderPath_Data + "data_Modeles.xlsx";

//LES VARIABLES GLOBALES POUR LE  MODULE ORDERS
var vServerOrders = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 7);
//var clientOrders = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 2, 7); //Utilisé nul part    
var userNameOrders=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
var pswOrders=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
var filePath_Orders = folderPath_Data + "data_Orders.xlsx";

//LES VARIABLES GLOBALES POUR LES EQUIPES TCVE
var vServerTCVE1 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 22);
var vServerTCVE2 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 23);
var vServerTCVE3 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 24);

//LES VARIABLES GLOBALES POUR LE PROJET CROESUSJIRA
var vServerCroesusJira = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 25);
var filePath_CroesusJira = folderPath_Data + "data_CroesusJira.xlsx";

//LES VARIABLES GLOBALES POUR LE  MODULE DASHBOARD
var vServerDashboard = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 6);
var filePath_Dashboard = folderPath_Data + "data_Dashboard.xlsx";

//LES VARIABLES GLOBALES POUR LE  MODULE TRANSACTIONS
var vServerTransactions = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 8);
var filePath_Transactions = folderPath_Data + "data_Transactions.xlsx";

//LES VARIABLES GLOBALES POUR AGENDA
var vServerAgenda = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 4);
var filePath_Agenda = folderPath_Data + "data_Agenda.xlsx";

//LES VARIABLES GLOBALES POUR CLIENTS
var vServerClients = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 1);
var filePath_Clients = folderPath_Data + "data_Clients.xlsx";

//LES VARIABLES GLOBALES POUR COMPTES
var vServerAccounts = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 2);
var filePath_Accounts = folderPath_Data + "data_Accounts.xlsx";

//LES VARIABLES GLOBALES POUR RELATIONS
var vServerRelations = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 3);
var filePath_Relations = folderPath_Data + "data_Relations.xlsx";

//LES VARIABLES GLOBALES POUR SLEEVES
var vServerSleeves = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 10);
var filePath_Sleeves = folderPath_Data + "data_Sleeves.xlsx";

//LES VARIABLES GLOBALES POUR RCMGenerique
var vServerRCMGenerique = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 26);
var filePath_RCMGenerique = folderPath_Data + "data_RCMGenerique.xlsx";

//LES VARIABLES GLOBALES POUR SmokeTestStaging
var vServerSmokeTest = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 27);
var filePath_SmokeTestStaging = folderPath_Data + "data_SmokeTestStaging.xlsx";

//LES VARIABLES GLOBALES POUR BILLING
var vServerBilling = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 11);
var filePath_Billing = folderPath_Data + "data_Billing.xlsx";
var userNameBilling=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
var pswBilling=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 

//LES VARIABLES GLOBALES POUR RAPPORTS DU CR1485
var PROJECTSUITE_NAME = aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName);
var PROJECTSUITE_NAME = (aqString.Find(PROJECTSUITE_NAME, "ProjectSuite", 0, false) != 0)? PROJECTSUITE_NAME: aqString.Remove(PROJECTSUITE_NAME, 0, 12);
var CR1485_REPORTS_TIMEOUT = (projet == "Performance" || projet == "PerformanceNFR" || projet == "PerformanceEVOL")? 1000000: 300000;
var executionComputerName = "ComputerNameUndefined";
try {executionComputerName = VarToStr(Sys.HostName);} catch (sys_e){executionComputerName = "ComputerNameUndefined"; sys_e = null;}
var filePath_ReportsCR1485 = folderPath_Data + "data_ReportsCR1485.xlsx";
var userNameReportsCR1485 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
var pswReportsCR1485 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
var vServerReportsCR1485 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 12);
var REPORTS_FILES_FOLDER_PATH = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "\\Temp_Reports\\";
var REPORTS_FILES_BACKUP_FOLDER_PATH = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "\\Temp_BackupFromComputer_" + executionComputerName + "\\";
var CR1485_REPORTS_LANGUAGE = (client == "US")? "english" : VarToStr(GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 12));
var CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE = (typeof CR1485_REPORTS_LANGUAGE != 'undefined' && (CR1485_REPORTS_LANGUAGE == "english" || CR1485_REPORTS_LANGUAGE == "french"));

//LES VARIABLES GLOBALES POUR GP1859
var vServerGP1859 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 21);
var filePath_GP1859 = folderPath_Data + "data_GP1859.xlsx";
var GP1859_FOLDER_SUFFIX_THEME_ID = "";
if (aqFileSystem.GetFileNameWithoutExtension(Project.FileName) == "GP1859"){
    var vServerReportsCR1485 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 21);
    var REPORTS_FILES_FOLDER_PATH = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "_" + GP1859_FOLDER_SUFFIX_THEME_ID + "\\Temp_Reports\\";
    var REPORTS_FILES_BACKUP_FOLDER_PATH = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "_" + GP1859_FOLDER_SUFFIX_THEME_ID + "\\Temp_BackupFromComputer_" + executionComputerName + "\\";
    var CR1485_REPORTS_LANGUAGE = (client == "US")? "english" : VarToStr(GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 21));
    var CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE = (typeof CR1485_REPORTS_LANGUAGE != 'undefined' && (CR1485_REPORTS_LANGUAGE == "english" || CR1485_REPORTS_LANGUAGE == "french"));
}

//LES VARIABLES GLOBALES POUR PERFORMANCE
var vServerPerformance = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 13);
var filePath_Performance = folderPath_Data + "data_Performance.xlsx";
var numberOfUsers= GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 6, 4);//le nombre d'utilisateurs  pour lancer le simulateur (50 or 75)
var filePath_Performance_simulateur = folderPath_Data+"CIBC\\SimulatorNbrUsers\\" + "data_Performance_Simulateur.xlsx";

if (projet == "PerformanceNFR"){//
    if(client == "CIBC"){
        var userNamePerformance = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "USER_RCM", "username");
        var pswPerformance      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "USER_RCM", "psw");
        var userNameSARONTAL    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "SARONTAL", "username");
        var passwordSARONTAL    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "SARONTAL", "psw");
    }
    else{
          var userNamePerformance    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "username");
          var pswPerformance         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "psw");
          var userPerformanceBELAIRA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BELAIRA", "username");
          var pswPerformanceBELAIRA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BELAIRA", "psw");
    }
}else{
    var userNamePerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "username");
    var pswPerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "psw");
    var userPerformanceBELAIRA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BELAIRA", "username");
    var pswPerformanceBELAIRA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BELAIRA", "psw");
}

var userNamePerformanceWebConfig = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "NFRUNI00", "username");
var pswPerformanceWebConfig = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "NFRUNI00", "psw");
var numCell_PerformanceBD = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", userNamePerformance,"DataValue");
var sheetName_Performance = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", "sheetName_Performance","DataValue");
var sheetName_DataBD      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", "sheetName_DataBD","DataValue");
var sheetName_DataBD_RCM  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", "sheetName_DataBD_RCM","DataValue");
var DataType              = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", "PositionOrData","DataValue");
var sheetName_DataWebConfigurator  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "ExecutionVServers", "sheetName_DataWebConfigurator","DataValue");

var polymer = "?shady=true";

//LES VARIABLES GLOBALES POUR AIDE CONTEXTUELLE
var filePath_Help = folderPath_Data + "data_Help.xlsx";
var vServerHelp = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 14);
var userNameHelp=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
var pswHelp = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");

//LES VARIABLES GLOBALES POUR RQS
var vServerRQS = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 15);
var filePath_RQS = folderPath_Data + "data_RQS.xlsx";
var userNameRQS=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
var pswRQS=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");

//LES VARIABLES GLOBALES POUR GENERAL
var vServerGeneral = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 17);
var filePath_General = folderPath_Data + "data_General.xlsx";
var userNameGeneral=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
var pswGeneral=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");

//LES VARIABLES GLOBALES POUR DATAHUB
var vServerDataHub, filePath_DataHub = folderPath_Data + "data_DataHub.xlsx";
switch (aqFileSystem.GetFileNameWithoutExtension(Project.FileName)){
    case "Clients"      : vServerDataHub = vServerClients;      break;
    case "Comptes"      : vServerDataHub = vServerAccounts;     break;
    case "Dashboard"    : vServerDataHub = vServerDashboard;    break;
    case "General"      : vServerDataHub = vServerGeneral;      break;
    case "Modeles"      : vServerDataHub = vServerModeles;      break;
    case "Ordres"       : vServerDataHub = vServerOrders;       break;
    case "Portefeuille" : vServerDataHub = vServerPortefeuille; break;
    case "Relations"    : vServerDataHub = vServerRelations;    break;
    case "Titres"       : vServerDataHub = vServerTitre;        break;
    case "Transactions" : vServerDataHub = vServerTransactions; break;
    default             : vServerDataHub = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 18);
}


//LES VARIABLES CR1755
var vServerCR1755 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 19);
var filePath_CR1755 = folderPath_Data + "data_CR1755.xlsx";

//LES VARIABLES GLOBALES POUR LE PROJET CROESUSBUILD
var vServerCroesusBuild = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 28);

// Varibale Globale pour la fonction get Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship
var userNameWinInfoCmbTypeForRelationship=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");