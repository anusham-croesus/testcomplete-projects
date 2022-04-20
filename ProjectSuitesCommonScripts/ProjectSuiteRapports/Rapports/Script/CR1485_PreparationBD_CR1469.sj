//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : 
        P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.2 Clients
        P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\1.1 Relations
        P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\2.2 Clients
        P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\3.3 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_PreparationBD_CR1469()
{   
    try {
                       
        //Activate Prefs
        ActivatePrefs();
        RestartServices(vServerReportsCR1485);
        
        //Create Relationship CR1469
        CR1485_PreparationBD_CR1469_Relationships();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Terminate_IEProcess();
    }
    
}

function ActivatePrefs()
{
    if (client == "CIBC"){
        Activate_Inactivate_PrefFirm(1, "PREF_REPORT_ACCOUNT_TYPE_HEADER", "1", vServerReportsCR1485);
    }else {
        Activate_Inactivate_PrefFirm(1, "PREF_REPORT_ACCOUNT_TYPE_HEADER", "0", vServerReportsCR1485);
    }
    
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_PROFILE_HEADER_1", "146", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_PROFILE_HEADER_2  ", "68,69" , vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_PROFILE_SUMMARY_BOX  ", "68,69" , vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_DISPLAY_REPORT_HEADER_MULTILINE", "AccountTypeHeader,ProfileHeader1,ProfileHeader2,IAName", vServerReportsCR1485);
}


function CR1485_PreparationBD_CR1469_Relationships()
{
    //try {
        Log.Message("CR1485_PreparationBD_CR1469_Relationships()");
        
        //Récupérer les données du fichier Excel
        var CR1469_Relationship_Name = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1469", "CR1469_Relationship_Name", language);
        var CR1469_Relationship_IACode = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1469", "CR1469_Relationship_IACode", language);
        var CR1469_Relationship_Language = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1469", "CR1469_Relationship_Language", language);
        var CR1469_Relationship_Currency = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1469", "CR1469_Relationship_Currency", language);
        var CR1469_Relationship_AccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1469", "CR1469_Relationship_AccountsNumbers", language);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Créer la relation
        CreateRelationship(CR1469_Relationship_Name, CR1469_Relationship_IACode, CR1469_Relationship_Currency, CR1469_Relationship_Language);
        
        //Associer les comptes à la relation
        var arrayOfRelationshipAccountsNumbers = CR1469_Relationship_AccountsNumbers.split("|");
        for (var i in arrayOfRelationshipAccountsNumbers)
            JoinAccountToRelationship(arrayOfRelationshipAccountsNumbers[i], CR1469_Relationship_Name);
        
        //Fermer Croesus
       // CloseCroesus();
    }
    /*catch(exception_CR1469_PreparationBD_CR1469_Relationships){
        Log.Error("Exception in CR1469_PreparationBD_CR1469_Relationships(): " + exception_CR1469_PreparationBD_CR1469_Relationships.message, VarToStr(exception_CR1469_PreparationBD_CR1469_Relationships.stack));
        exception_CR1469_PreparationBD_CR1469_Relationships = null;
    }
    finally {
       // Terminate_CroesusProcess();
    }
}*/
