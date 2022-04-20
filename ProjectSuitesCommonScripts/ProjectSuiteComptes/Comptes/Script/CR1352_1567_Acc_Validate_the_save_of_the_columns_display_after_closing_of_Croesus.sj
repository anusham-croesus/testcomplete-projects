//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Valider la sauvegarde de l'affichage des colonnes après fermeture de Croesus
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1567
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1567_Acc_Validate_the_save_of_the_columns_display_after_closing_of_Croesus()
{
    try {
        
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Vérifier que la colonne 'Statut' n'est pas affichée
        
        if (Get_AccountsGrid_ChStatus().Exists){
            Log.Error("'Status' column displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Langue' n'est pas affichée
    
        if (Get_AccountsGrid_ChLanguage().Exists){
            Log.Error("'Language' column displayed. This is not expected.");
            return;
        }
        
        
        //Ajouter la colonne 'Statut'
        
        Log.Message("Add the 'Status' column.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();
        
        
        //Vérifier que la colonne 'Statut' est affichée
        
        if (!(Get_AccountsGrid_ChStatus().Exists)){
            Log.Error("'Status' column not displayed. This is not expected.");
            return;
        }
        
        Log.Checkpoint("'Status' column displayed.");
        
        
        //Ajouter la colonne 'Langue'
        
        Log.Message("Add the 'Language' column.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
        
        
        //Vérifier que la colonne 'Langue' est affichée
        
        if (!(Get_AccountsGrid_ChLanguage().Exists)){
            Log.Error("'Language' column not displayed. This is not expected.");
            return;
        }
        
        Log.Checkpoint("'Language' column displayed.");
        
        
        //Redémarrer Croesus
        
        Log.Message("Restart Croesus ...");
        Close_Croesus_X();
        Terminate_CroesusProcess();
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Vérifier que la colonne 'Statut' est toujours présente
    
        if (Get_AccountsGrid_ChStatus().Exists){
            Log.Checkpoint("'Status' column still displayed.");
        }
        else {
            Log.Error("'Status' column not displayed. This is not expected.");
        }
        
        
        //Vérifier que la colonne 'Langue' est toujours présente
    
        if (Get_AccountsGrid_ChLanguage().Exists){
            Log.Checkpoint("'Language' column still displayed.");
        }
        else {
            Log.Error("'Language' column not displayed. This is not expected.");
        }
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        
        //Rétablir la configuration par défaut des colonnes
    
        Log.Message("Restore default configuration for the columns...");
        Terminate_CroesusProcess();
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
        //Fermer Croesus
        Close_Croesus_X();
        
    }
}