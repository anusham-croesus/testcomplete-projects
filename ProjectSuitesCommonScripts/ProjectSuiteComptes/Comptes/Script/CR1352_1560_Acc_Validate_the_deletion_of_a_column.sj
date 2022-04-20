//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Valider la suppression d'une colonne
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1560
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1560_Acc_Validate_the_deletion_of_a_column()
{
    Login(vServerAccounts, userName, psw, language);
   
    Get_ModulesBar_BtnAccounts().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Marge' est affichée
    
    if (!(Get_AccountsGrid_ChMargin().Exists)){
        Log.Error("Column 'Margin' is not displayed. This is not expected");
        return;
    }
    
    
    //Enlever la colonne 'Marge'
    
    Log.Message("Remove the 'Margin' column.");
    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
    
    
    //Vérifier que la colonne 'Marge' n'est pas affichée
    
    if (Get_AccountsGrid_ChMargin().Exists){
        Log.Error("Column 'Margin' displayed. This is not expected");
    }
    else {
        Log.Checkpoint("Column 'Margin' not displayed. This is expected");
    }
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    Close_Croesus_SysMenu();
}