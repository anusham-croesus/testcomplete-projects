//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Jira Xray   : TCVE-3272 automatisation du Jira FEDS-1
    Description : Quand la Pref est à Yes les champs: Telephone1, Telephone2, Telephone3... ne s'affichent pas dans la fenêtre de recherche
    
    Analyste d'assurance qualité : Karima Me
    Analyste d'automatisation : A.A
    version : 90-21-2020.11-9
**/

function TCVE_3272_FEDS1_TelephoneNoLongerDisplayedWhenPrefIsActive(){
    
    var logEtape1, logEtape2;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-3272","Lien du Cas de test sur Jira Xray");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "psw");
        
        var TelephoneString = (language == "french")? "Téléphone": "Telephone";
        var waitTime        = 15000;
        
        // Étape 1
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Activation de Pref et login");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "Yes", vServerAccounts);
        RestartServices(vServerAccounts);
        
        //Login
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);

        // Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Aller au module Comptes et valider que 'Téléphone' ne s'affiche pas dans la fenêtre 'recherche'");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, waitTime);
        
        ClickOnToolbarSearchButton();

        var nbElement = Get_WinQuickSearch().WPFObject("FieldSelector").Items.count
        for(i=0; i<nbElement; i++)
           CheckProperty(Get_WinQuickSearch().WPFObject("FieldSelector").Items.Item(i).Label, "OleValue", cmpNotContains, TelephoneString);
        Delay(1000);
        Get_WinQuickSearch_BtnCancel().Click();
        
        // Étape 3
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 3: Aller au module Clients, valider que 'Téléphone' ne s'affiche pas dans la fenêtre 'recherche'");
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, waitTime);
        
        ClickOnToolbarSearchButton();

        var nbElement = Get_WinQuickSearch().WPFObject("FieldSelector").Items.count
        for(i=0; i<nbElement; i++)
           CheckProperty(Get_WinQuickSearch().WPFObject("FieldSelector").Items.Item(i).Label, "OleValue", cmpNotContains, TelephoneString);
        Delay(1000);
        Get_WinQuickSearch_BtnCancel().Click();
        
        // Étape 4
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 4: Aller au module Relations, valider que 'Téléphone' ne s'affiche pas dans la fenêtre 'recherche'");
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime);
        
        ClickOnToolbarSearchButton();

        var nbElement = Get_WinQuickSearch().WPFObject("FieldSelector").Items.count
        for(i=0; i<nbElement; i++)
           CheckProperty(Get_WinQuickSearch().WPFObject("FieldSelector").Items.Item(i).Label, "OleValue", cmpNotContains, TelephoneString);
        Delay(1000);
        Get_WinQuickSearch_BtnCancel().Click();
        
        //Fermer Croesus
        Close_Croesus_X();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
            
    }
    catch(e) {
  //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}
