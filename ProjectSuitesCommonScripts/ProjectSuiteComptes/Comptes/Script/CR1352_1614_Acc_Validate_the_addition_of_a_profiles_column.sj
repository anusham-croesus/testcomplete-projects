//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CR1352_1575_Acc_Validate_the_addition_of_a_profiles_field


/**
    Description : Valider l'ajout d'une colonne de type 'profils'
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1614
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1614_Acc_Validate_the_addition_of_a_profiles_column()
{
    try {
        Login(vServerAccounts, userName, psw, language);
    
        //Activer les profils par défaut
        CheckAllDefaultProfilesForAccounts();
    
        //Rétablir la configuration par défaut des colonnes
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
        //Vérifier que la colonne 'Loisirs' n'est pas affichée
        if (Get_AccountsGrid_ChHobbies().Exists){
            Log.Error("'Hobbies' column displayed. This is not expected.");
            Close_Croesus_SysMenu();
            return;
        }
    
        //Ajouter la colonne 'Profils -> Loisirs'
        Log.Message("Add the 'Profiles -> Hobbies' column.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles_Hobbies().Click();
    
        //Vérifier que la colonne 'Loisirs' est affichée
        if (Get_AccountsGrid_ChHobbies().Exists){
            Log.Checkpoint("'Hobbies' column displayed.");
        }
        else {
            Log.Error("'Hobbies' column not displayed. This is not expected.");
        }
    
        //Rétablir la configuration par défaut des colonnes
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
        //Fermer Croesus
        Close_Croesus_SysMenu();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}