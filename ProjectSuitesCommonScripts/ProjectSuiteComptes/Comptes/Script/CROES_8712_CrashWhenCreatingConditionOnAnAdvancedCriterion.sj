//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT DBA



/**
    Description : Crash lorsqu'on sélectionne le champ "personne-ressource" dans les critères avancés.

        EX:
        Dans le module Comptes, ajouter un nouveau critère avancé dans le gestionnaire de critères de recherche, 
        et aller dans Conditions > Champ > Clients > Informatif > Champs de base > cliquer sur Personne-ressource (Client) > l'application crash.
        
        Numéro de l'anomalie:CROES-8712.
        Version de scriptage:ref90-04-BNC-59B-9
        Auteur : Sana Ayaz
*/
function CROES_8712_CrashWhenCreatingConditionOnAnAdvancedCriterion()
{
    try {
        
        
        //Se connecter et aller au module Comptes
         userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
        //
        Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField().Click();
        Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients().Click();
        Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative().Click();
//        if (client == "CIBC")
//            Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative_BasicFields_ContactPersonClient().Click()
//        else{ 
        Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative_BasicFields().Click();
        Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative_BasicFields_ContactPersonClient().Click()
//        }
        //Les points de vérification :Vérifier si le message d'erreur apparaît
        maxWaitTime = 10000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("Bug CROES-8712");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
       
    }
}


