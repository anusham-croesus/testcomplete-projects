//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/**
    Jira Xray                 : https://jira.croesus.com/browse/TCVE-7007
    Description               : CR2183 Importer des listes manuelles à partir d'une source externe  
    Version de scriptage      : ref9027-2021.10-29   ref9027-2021.10-35
    Date:                     : 18 octobre 2021

    Analyste d'automatisation : Abdel.m
    Analyste QA               : Karima.Mo
**/

function CR2183_TCVE_7007_ImportManualListsFromAnExternalSource()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-7007","Lien du cas de test dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-7749","Lien de la story dans Jira");
        
        var userNameCOPERN     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordCOPERN     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        var folderPathCR1483 = folderPath_Data + "BNC\\CR2183\\"
        var filPathAccountMore25UnsupportedChar = folderPathCR1483 + "compte_more_25_unsupported_char.csv"
        var filPathAccountLess25MaxLength = folderPathCR1483 + "compte_less_25_max_length.csv"
        var filPathAccountMore25EntryNotExist = folderPathCR1483 + "compte_more_25_Entry_Not_Exists.csv"
        var filPathAccountMore25Mix = folderPathCR1483 + "compte_more_than_25_mix.csv"
        var filPathClientMore25EntryNotExist = folderPathCR1483 + "client_more_25_Entry_Not_Exists.csv"
        var filPathClientMore25Mix = folderPathCR1483 + "client_more_25_mix.csv"
        var filPathLinkLess25EntryNotExist = folderPathCR1483 + "link_less_25_Entry_Not_Exists.csv"
        var filPathLinkLess25Mix = folderPathCR1483 + "link_less_25_mix.csv"
        var filePathEmpty = folderPathCR1483 + "fichier_vide.csv"
        var filePathNotExist = folderPathCR1483 + "NotExist.csv"
        
        var moduleAccounts = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "moduleAccounts", language+client);
        var moduleClients = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "moduleClients", language+client);
        var moduleRelationships = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "moduleRelationships", language+client);
        
        var msgAccountMore25UnsupportedChar = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgAccountMore25UnsupportedChar", language+client);
        var msgAccountLess25MaxLength = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgAccountLess25MaxLength", language+client);
        var msgAccountMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgAccountMore25EntryNotExist", language+client);
        var msgAccountMore25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgAccountMore25Mix", language+client);
        var msgClientMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgClientMore25EntryNotExist", language+client);
        var msgClientMore25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgClientMore25Mix", language+client);
        var msgLinkLess25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgLinkLess25EntryNotExist", language+client);
        var msgLinkLess25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgLinkLess25Mix", language+client);
        var msgEmpty = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgEmpty", language+client);
        var msgNameExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgNameExist", language+client);
        var msgfileNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "msgfileNotExist", language+client);
        
        var nameAccountMore25UnsupportedChar = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameAccountMore25UnsupportedChar", language+client);
        var nameAccountLess25MaxLength = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameAccountLess25MaxLength", language+client);
        var nameAccountMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameAccountMore25EntryNotExist", language+client);
        var nameAccountMore25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameAccountMore25Mix", language+client);
        var nameClientMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameClientMore25EntryNotExist", language+client);
        var nameClientMore25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameClientMore25Mix", language+client);
        var nameLinkLess25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameLinkLess25EntryNotExist", language+client);
        var nameLinkLess25Mix = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameLinkLess25Mix", language+client);
        var nameEmpty = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameEmpty", language+client);
        var nameNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "nameNotExist", language+client);
        
        var crochetAccountMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "crochetAccountMore25EntryNotExist", language+client);
        var crochetClientMore25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "crochetClientMore25EntryNotExist", language+client);
        var crochetLinkLess25EntryNotExist = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2183", "crochetLinkLess25EntryNotExist", language+client);

        //******************************************* Étape 1***************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: mettre la PREF_ENABLE_CRITERIA_MANUAL_IMPORT à YES (niveau firme).");
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CRITERIA_MANUAL_IMPORT", "YES", vServerAccounts);
        RestartServices(vServerAccounts);        
                                    
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Nombre de compte >25, caractères non-supportés");
        
       // Se connecter à croesus
        Log.Message("Se connecter à croesus");
        Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
        
        Log.Message("Aller dans le module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
        
        //ouvrir la fenêtre Gestionnaire de critères de recherche
        Log.Message("ouvrir la fenêtre Gestionnaire de critères de recherche");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        ImportFile(filPathAccountMore25UnsupportedChar, moduleAccounts, nameAccountMore25UnsupportedChar);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgAccountMore25UnsupportedChar);
        Get_DlgError_Btn_OK().Click();
 
        
        //******************************************* Étape 3***************************************************

        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Nombre de compte <25, entrée trop longue.");
        
        //Importer le fichier csv
        ImportFile(filPathAccountLess25MaxLength, moduleAccounts, nameAccountLess25MaxLength);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgAccountLess25MaxLength);
        Get_DlgError_Btn_OK().Click();
        
        
        //******************************************* Étape 4***************************************************

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Nombre de compte >25, entrée non-existante ou non-accessible.");
        
        //Importer le fichier csv
        ImportFile(filPathAccountMore25EntryNotExist, moduleAccounts, nameAccountMore25EntryNotExist);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckWarningMessage( msgAccountMore25EntryNotExist);
        Get_DlgWarning_Btn_OK().Click();
        
        //Valider que le nombre de crochets dans la grille est 16 
        Log.Message("Valider que le nombre de crochets dans la grille est 16 ");
        var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = grid.Items.Count;
        if (count == crochetAccountMore25EntryNotExist)
            Log.Checkpoint("le nombre de crochets dans la grille account est tel que attendu "+crochetAccountMore25EntryNotExist);
        else    
            Log.Error("le nombre de crochets dans la grille account est différent de ce qui est attendu "+crochetAccountMore25EntryNotExist);
            
        Log.Message("Valider le nombre affiché dans la bar en bas à droite");
        aqObject.CheckProperty(Get_StatusBarContentSelection(),"Text",cmpEqual, crochetAccountMore25EntryNotExist);
       
        //******************************************* Étape 5***************************************************

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Nombre de compte >25, messages mixtes.");
        
        //ouvrir la fenêtre Gestionnaire de critères de recherche
        Log.Message("ouvrir la fenêtre Gestionnaire de critères de recherche");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        //Importer le fichier csv
        ImportFile(filPathAccountMore25Mix, moduleAccounts, nameAccountMore25Mix);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgAccountMore25Mix);
        Get_DlgError_Btn_OK().Click();        
        
        //******************************************* Étape 6***************************************************

        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Nombre de client>25, entrée non-existante ou non-accessible.");
        
        //Importer le fichier csv
        ImportFile(filPathClientMore25EntryNotExist, moduleClients, nameClientMore25EntryNotExist);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'avertissement affiché
        CheckWarningMessage( msgClientMore25EntryNotExist);
        Get_DlgWarning_Btn_OK().Click();
        
        //Valider que le nombre de crochets dans la grille est 1 
        Log.Message("Valider que le nombre de crochets dans la grille est 1 ");
        var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = grid.Items.Count;
        if (count == crochetClientMore25EntryNotExist)
            Log.Checkpoint("le nombre de crochets dans la grille Clients est tel que attendu "+crochetClientMore25EntryNotExist);
        else    
            Log.Error("le nombre de crochets dans la grille Clients est différent de ce qui est attendu "+crochetClientMore25EntryNotExist);
            
        Log.Message("Valider le nombre affiché dans la bar en bas à droite");
        aqObject.CheckProperty(Get_StatusBarContentSelection(),"Text",cmpEqual, crochetClientMore25EntryNotExist);
        
        //******************************************* Étape 7***************************************************

        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Nombre de client>25, messages mixtes.");
        
        //ouvrir la fenêtre Gestionnaire de critères de recherche
        Log.Message("ouvrir la fenêtre Gestionnaire de critères de recherche");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        //Importer le fichier csv
        ImportFile(filPathClientMore25Mix, moduleClients, nameClientMore25Mix);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgClientMore25Mix);
        Get_DlgError_Btn_OK().Click(); 
        
       
        //******************************************* Étape 8***************************************************

        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Nombre de relation<25, entrée non-existante ou non-accessible.");
        
        //Importer le fichier csv
        ImportFile(filPathLinkLess25EntryNotExist, moduleRelationships, nameLinkLess25EntryNotExist);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'avertissement affiché
        CheckWarningMessage( msgLinkLess25EntryNotExist);
        Get_DlgWarning_Btn_OK().Click();
        
        //Valider que le nombre de crochets dans la grille est 1 
        Log.Message("Valider que le nombre de crochets dans la grille est 1 ");
        var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = grid.Items.Count;
        if (count == crochetLinkLess25EntryNotExist)
            Log.Checkpoint("le nombre de crochets dans la grille Relations est tel que attendu "+crochetLinkLess25EntryNotExist);
        else    
            Log.Error("le nombre de crochets dans la grille Relations est différent de ce qui est attendu "+crochetLinkLess25EntryNotExist);
            
        Log.Message("Valider le nombre affiché dans la bar en bas à droite");
        aqObject.CheckProperty(Get_StatusBarContentSelection(),"Text",cmpEqual, crochetLinkLess25EntryNotExist);
        
        //******************************************* Étape 9***************************************************

        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Importer une liste avec un nom existant.");
        
        //ouvrir la fenêtre Gestionnaire de critères de recherche
        Log.Message("ouvrir la fenêtre Gestionnaire de critères de recherche");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        //Importer le fichier csv
        ImportFile(filPathLinkLess25EntryNotExist, moduleRelationships, nameLinkLess25EntryNotExist);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgNameExist);
        Get_DlgError_Btn_OK().Click(); 
        
        //******************************************* Étape 10***************************************************

        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 10: Nombre relation<25, messages mixtes.");
        
        //Importer le fichier csv
        ImportFile(filPathLinkLess25Mix, moduleRelationships, nameLinkLess25Mix);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgLinkLess25Mix);
        Get_DlgError_Btn_OK().Click(); 
         
        //******************************************* Étape 11***************************************************

        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Étape 11: Importer un fichier vide.");
        
        //Importer le fichier csv
        ImportFile(filePathEmpty, moduleRelationships, nameEmpty);
        Get_WinImportManualList_BtnImport().Click();
        
        //Valider le message d'erreur affiché
        CheckErrorMessage( msgEmpty);
        Get_DlgError_Btn_OK().Click(); 
        
        //******************************************* Étape 12***************************************************

        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: Le fichier à importer n'existe pas ou supprimé.");  
        
        Log.Message("Cette partie à ne pas automatiser pour le faire il faut investir plus de temps pour la création et la suppression du fichier csv en cours d'exécution");

    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
        //Fermer le processus Croesus
        Get_WinImportManualList_BtnCancel().Click();
        Get_WinSearchCriteriaManager_BtnClose().Click();
        
        Terminate_CroesusProcess();
        
        //Supprimer les filtres créés
        Delete_FilterCriterion(nameAccountMore25EntryNotExist, vServerAccounts);
        Delete_FilterCriterion(nameClientMore25EntryNotExist, vServerAccounts);
        Delete_FilterCriterion(nameLinkLess25EntryNotExist, vServerAccounts);
       
        Log.Message("Remettre la pref à No");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CRITERIA_MANUAL_IMPORT", "NO", vServerAccounts);
        RestartServices(vServerAccounts); 
       
    }
}


function ImportFile(filePath, Module, Name){
    Log.Message("Remplir les champs dans la fenêtre 'Importer une liste manuelle'");
    Get_WinImportManualList_TxtName().Keys(Name);
    Get_WinImportManualList_CmbModule().Click();
    Get_SubMenus().Find("WPFControlText", Module, 10).Click();
    Get_WinImportManualList_BtnBrowse().Click();
    Get_DlgOpen_CmbFileName1().SetText(filePath);
    Get_DlgOpen_BtnOpen().Click()
}
 function CheckErrorMessage(Message){
    Log.Message("Valider le message d'erreur affiché");
    aqObject.CheckProperty(Get_DlgError_LblMessage1(),"Text",cmpContains, Message);
 }
function CheckWarningMessage(Message){
    Log.Message("Valider le message d'avertissement affiché");
    aqObject.CheckProperty(Get_DlgWarning_LblMessage1(),"Text",cmpContains, Message);
 }
