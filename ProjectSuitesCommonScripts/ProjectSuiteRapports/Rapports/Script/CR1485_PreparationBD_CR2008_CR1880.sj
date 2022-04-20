//USEUNIT CR1485_Common_functions



function CR1485_PreparationBD_CR2008_CR1880()
{
    CR1485_PreparationBD_CR2008_CR1880_Prefs();
    CR1485_PreparationBD_CR2008_Relationships();
}



/**
    Préparation pour les CR2008 / CR1880 relatifs aux cas suivants :
    
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\2. GAINS ET PERTES RÉALISÉS\3.1 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\2. GAINS ET PERTES RÉALISÉS\2.3 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\1.1 Relations
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\145. Rapport de frais
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\149. Page couverture (Déclaration de revenus)
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\150. Feuillets d'impôt attendus (comptes non enregistrés)
*/
function CR1485_PreparationBD_CR2008_CR1880_Prefs()
{
    Log.Message("CR1485_PreparationBD_CR2008_CR1880_Prefs()");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\2. GAINS ET PERTES RÉALISÉS\\3.1 Comptes\\PREFs.txt", "Pour ouvrir le Document de la Configuration à faire relative au CR2008/CR1880, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        //Retrieve data from Excel file
        var firmCode = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "CR2008_CR1880_FirmCode", language);
        var value_ACCOUNT_TYPE_NON_REGISTERED = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "ACCOUNT_TYPE_NON_REGISTERED", language);
        var value_SECURITY_TAX_SLIP_NON_REGISTERED = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "SECURITY_TAX_SLIP_NON_REGISTERED", language);
        
        Activate_Inactivate_PrefFirm(firmCode, "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
        var insertConfigFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\InsertConfig_TAX_REPORT_NON_REGISTERED_ACCOUNTS_For_" + firmCode + ".sql";
        ExecuteSQLFile_ThroughISQL(insertConfigFilePath, vServerReportsCR1485);
            
        var SQLQuery = "update B_CONFIG set NOTE = 'ACCOUNT_TYPE_NON_REGISTERED=" + value_ACCOUNT_TYPE_NON_REGISTERED + "\r\n";
        SQLQuery += "SECURITY_TAX_SLIP_NON_REGISTERED=" + value_SECURITY_TAX_SLIP_NON_REGISTERED + "'\r\nwhere CLE = 'TAX_REPORT_NON_REGISTERED_ACCOUNTS'"
        Log.Message(SQLQuery, SQLQuery);
        Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
    }
    catch (exception_CR1485_PreparationBD_CR2008_CR1880_Prefs){
        Log.Error("Exception in CR1485_PreparationBD_CR2008_CR1880_Prefs(): " + exception_CR1485_PreparationBD_CR2008_CR1880_Prefs.message, VarToStr(exception_CR1485_PreparationBD_CR2008_CR1880_Prefs.stack));
        exception_CR1485_PreparationBD_CR2008_CR1880_Prefs = null;
    }
    finally {
        Delay(30000);
        RestartServices(vServerReportsCR1485);
    }
}



/**  
    Configuration du CR2008 pour le rapport 150 suivant : CR1485_150_Rel_2005_NumVis
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\150. Feuillets d'impôt attendus (comptes non enregistrés)\1. Relations
*/
function CR1485_PreparationBD_CR2008_Relationships()
{
    try {
        Log.Message("CR1485_PreparationBD_CR2008_Relationships()");
        
        //Récupérer les données du fichier Excel
        var CR2008_Relationship_Name = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Name", language);
        var CR2008_Relationship_IACode = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_IACode", language);
        var CR2008_Relationship_Language = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Language", language);
        var CR2008_Relationship_Currency = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Currency", language);
        var CR2008_Relationship_IsBillable = (client == "CIBC" || client == "VMBL" || client == "VMD" || client == "TD")? null: ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_IsBillable", language);
        var CR2008_Relationship_AccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_AccountsNumbers", language);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Créer la relation
        CreateRelationship(CR2008_Relationship_Name, CR2008_Relationship_IACode, CR2008_Relationship_Currency, CR2008_Relationship_Language, GetBooleanValue(CR2008_Relationship_IsBillable));
        
        //Associer les comptes à la relation
        var arrayOfRelationshipAccountsNumbers = CR2008_Relationship_AccountsNumbers.split("|");
        for (var i in arrayOfRelationshipAccountsNumbers)
            JoinAccountToRelationship(arrayOfRelationshipAccountsNumbers[i], CR2008_Relationship_Name);
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(exception_CR1485_PreparationBD_CR2008_Relationships){
        Log.Error("Exception in CR1485_PreparationBD_CR2008_Relationships(): " + exception_CR1485_PreparationBD_CR2008_Relationships.message, VarToStr(exception_CR1485_PreparationBD_CR2008_Relationships.stack));
        exception_CR1485_PreparationBD_CR2008_Relationships = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}
