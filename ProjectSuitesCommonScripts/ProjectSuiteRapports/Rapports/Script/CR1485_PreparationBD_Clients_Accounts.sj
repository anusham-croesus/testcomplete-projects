//USEUNIT CR1485_Common_functions



/**  
    Préparation BD Clients et Comptes
*/
function CR1485_PreparationBD_Clients_Accounts()
{
    try {
        Log.Message("CR1485_PreparationBD_Clients_Accounts()");
        
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        
        //Configurer le rapport 103 (Répartition d'actifs de l'entreprise)
        Log.Link("https://confluence.croesus.com/pages/viewpage.action?pageId=5908384", "Configurer le rapport 103 (Répartition d'actifs de l'entreprise)", "", pmNormal, logAttributes);
        ConfigureCorporateAssetAllocationReport();
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Ajouter l'objectif de placement pour certains clients (pour les rapports 3, 12, 20, 43, 51, 61, 77 et 98)
        Log.Message("Ajouter l'objectif de placement pour certains clients (pour les rapports 3, 12, 20, 43, 51, 61, 77 et 98)", "", pmNormal, logAttributes);
        CR1485_AddInvestmentObjectiveToClients();
    
        //Ajouter l'objectif de placement pour certains comptes (pour les rapports 3, 27, 42, 97 et 102)
        Log.Message("Ajouter l'objectif de placement pour certains comptes (pour les rapports 3, 27, 42, 97 et 102)", "", pmNormal, logAttributes);
        CR1485_AddInvestmentObjectiveToAccounts();
        
        //Renseigner dans le profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (pour le rapport 118)
        Log.Message("Renseigner dans le profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (pour le rapport 118)", "", pmNormal, logAttributes);
        CR1485_AddProfileToAccounts();
       
        //Fermer Croesus
        CloseCroesus();

    }
    catch(exception_CR1485_PreparationBD_Clients_Accounts){
        Log.Error("Exception in CR1485_PreparationBD_Clients_Accounts(): " + exception_CR1485_PreparationBD_Clients_Accounts.message, VarToStr(exception_CR1485_PreparationBD_Clients_Accounts.stack));
        exception_CR1485_PreparationBD_Clients_Accounts = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



/**
    Configure le rapport 103 (Répartition d'actifs de l'entreprise)
    https://confluence.croesus.com/pages/viewpage.action?pageId=5908384
*/
function ConfigureCorporateAssetAllocationReport()
{   
    //1) Activer (ou ajouter) la clé de FD_ASSET_MIX dans B_CONFIG:
    Log.Message("1) Activer (ou ajouter) la clé de FD_ASSET_MIX dans B_CONFIG.");
    
    Log.Message("Ajouter la clé de FD_ASSET_MIX dans B_CONFIG.");
    var insertConfigKey_FD_ASSET_MIX_SQL = ""
    + "\r\n" + "if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on') "
    + "\r\n" + "go "
    + "\r\n" + "insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) "
    + "\r\n" + "values ('FD_ASSET_MIX',0,'FEED',1,'Rapports/Chargeur. Si le Chargeur est en mode','Reports/Loader. If the Loader runs in automat', null, null, null, '', 1, 1) "
    + "\r\n" + "if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off') "
    + "\r\n" + "go "
    + "\r\n";
    var insertConfigFilePath = aqFileSystem.IncludeTrailingBackSlash(Project.Path) + "insertConfigKey_FD_ASSET_MIX.sql";
    if (aqFileSystem.Exists(insertConfigFilePath))
        aqFileSystem.DeleteFile(insertConfigFilePath);
    aqFile.WriteToTextFile (insertConfigFilePath, insertConfigKey_FD_ASSET_MIX_SQL, aqFile.ctANSI, true);
    ExecuteSQLFile_ThroughISQL(insertConfigFilePath, vServerReportsCR1485);
    
    var updateConfigSQLQuery = "update B_CONFIG set NOTE = 'YES' where CLE = 'FD_ASSET_MIX'";
    Log.Message("Activer la clé de FD_ASSET_MIX dans B_CONFIG : " + updateConfigSQLQuery);
    Execute_SQLQuery(updateConfigSQLQuery, vServerReportsCR1485);
    
    var updateValue_FD_ASSET_MIX = Execute_SQLQuery_GetField("select NOTE from B_CONFIG  where CLE = 'FD_ASSET_MIX' and FIRM_ID = 1", vServerReportsCR1485, "NOTE");
    CheckEquals(updateValue_FD_ASSET_MIX, "YES", "B_CONFIG key FD_ASSET_MIX value for FIRM 1");
    RestartServices(vServerReportsCR1485);

    //2) Rouler la commande pour populer la table B_ASS_REP et générer les données pour le rapport:
    var sshCommand = "cfLoader -CorpAssetMixCalculator '2009.12.31' -Firm=FIRM_1";
    Log.Message("2) Rouler la commande : " + sshCommand + ", pour populer la table B_ASS_REP et générer les données pour le rapport.");
    var outputSuccessRegEx = '^.*INFO  \- Processing Calculate the data for table b_assrep at a specified date. ended: Success Elapsed time: \\d\\d:\\d\\d:\\d\\d\\.\\d\\d.*';
    ExecuteSSHCommand("cfLoader_ConfigureCorporateAssetAllocationReport_ForReports_103", vServerReportsCR1485, sshCommand, null, outputSuccessRegEx);
}



/**
    Ajouter l'objectif de placement pour certains clients (pour les rapports 3, 12, 20, 43, 51, 61, 77 et 98)
*/
function CR1485_AddInvestmentObjectiveToClients()
{
    //Récupérer du fichier Excel le nombre de clients concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Clients").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    var NbOfClients = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de clients pour l'ajout d'objectif de placement : " + NbOfClients);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (i = 0; i < NbOfClients; i++){
        var offset = 3 + (4*i);
        var clientNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Clients", offset + 1, language);
        var investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Clients", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to client '" + clientNumber + "'");
        
        Delay(5000);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
        
        var windowTitle = VarToStr(Get_WinDetailedInfo().Title);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", windowTitle], 30000);
    }
    
    ExecuteSSHScriptForInvestmentObjectives();
}



function ExecuteSSHScriptForInvestmentObjectives()
{
    var sshCommand = "cfLoader -AsmInvObjCalculator -Firm=FIRM_1";
    Log.Message("Rouler la commande : " + sshCommand + ", pour les objectifs de placement.");
    var outputSuccessRegEx = '^.*INFO  \- Processing Calculation the assetmix for all accounts to generate b_asm_inv_obj data for Investment Objective Report. ended: Success Elapsed time: \\d\\d:\\d\\d:\\d\\d\\.\\d\\d.*';
    ExecuteSSHCommand("cfLoader_AsmInvObjCalculator_ForInvestmentObjectives_Report_051", vServerReportsCR1485, sshCommand, null, outputSuccessRegEx);
}



/**
    Ajouter l'objectif de placement pour certains comptes (pour les rapports 3, 27, 42, 97 et 102)
*/
function CR1485_AddInvestmentObjectiveToAccounts()
{
    //Récupérer du fichier Excel le nombre de comptes concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Accounts").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    var NbOfAccounts = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de comptes pour l'ajout d'objectif de placement : " + NbOfAccounts);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (i = 0; i < NbOfAccounts; i++){
        var offset = 3 + (4*i);
        var accountNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Accounts", offset + 1, language);
        var investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Accounts", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to account '" + accountNumber + "'");

        Delay(5000);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabInvestmentObjective().Click();
        Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
        
        var windowTitle = VarToStr(Get_WinAccountInfo().Title);
        Get_WinAccountInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", windowTitle], 30000);
    } 
}



/**
    Renseigner dans le profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (pour le rapport 118)
*/
function CR1485_AddProfileToAccounts()
{
    //Récupérer du fichier Excel le nombre de comptes concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.DisplayAlerts = false;
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Accounts").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
    //Renseigner dans le profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (pour le rapport 118)
    //DisplayOnlyDefaultProfilesForAccounts(); //ligne Commentée depuis la version Co ref90-07-22--V9-Be_1-co6x car l'affichage du groupe Default se fait désormais dans la fonction SetBrokerAndMiddlemanAccountsNumbersForAccount
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Rapport118").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
    for (var i = 2; i <= RowCount; i++){
        var accountNumber = VarToStr(Excel.Cells.Item(i, 1));
        var brokerAccountNumber = VarToStr(Excel.Cells.Item(i, 2));
        var middlemanAccountNumber = VarToStr(Excel.Cells.Item(i, 3));
        Delay(5000);
        SetBrokerAndMiddlemanAccountsNumbersForAccount(accountNumber, brokerAccountNumber, middlemanAccountNumber);
    }
    
    Excel.Quit();
    TerminateExcelProcess();
}



function SelectInvestmentObjectiveForClientAndAccount(investmentObjective)
{
    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
        
    if (investmentObjective == "De la firme - Global - Equilibre" || investmentObjective == "Firm - Global - Balanced")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Balanced().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Croissance Plus" || investmentObjective == "Firm - Global - Croissance Plus")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_CroissancePlus().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Revenu et croissance" || investmentObjective == "Firm - Global - Income and Growth")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_IncomeAndGrowth().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Croissance maximale" || investmentObjective == "Firm - Global - Maximum Growth")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumGrowth().Parent.set_IsSelected(true);
    else if (investmentObjective == "De base - Global - Equilibre" || investmentObjective == "Basic - Global - Balanced")
        Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Balanced().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Revenu maximum" || investmentObjective == "Firm - Global - Maximum Income")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumIncome().Parent.set_IsSelected(true);
    else if (investmentObjective == "De base - Global - Revenu maximum" || investmentObjective == "Basic - Global - Maximum Income")
        Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_MaximumIncome().Parent.set_IsSelected(true);
    else
        Log.Error("'" + investmentObjective + "' investment objective not covered!");
        
    if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
        Get_WinSelectAnObjective_BtnOK().Click();
    else {
        Log.Message("Bug JIRA CROES-10474, RJ-CO : Les objectifs de placement (firme) ne sont plus visibles après de migrer à la version CO-15");
        Log.Error("Investment objective selection cancelled.");
        Get_WinSelectAnObjective_BtnCancel().Click();
    }
    
    //S'il y a une éventuelle boîte de dialogue de confirmation
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists){
        Log.Warning("There was an unexpected Confirmation Dialog Box. Click on Yes.", VarToStr(Get_DlgConfirmation_LblMessage().Message), pmNormal, null, Sys.Desktop.Picture());
        Get_DlgConfirmation_BtnYes().Click();
    }
    RestoreAutoTimeOut();
}
