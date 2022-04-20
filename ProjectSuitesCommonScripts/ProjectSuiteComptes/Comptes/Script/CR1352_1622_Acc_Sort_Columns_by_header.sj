//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Trier les colonnes par header
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1622
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1622_Acc_Sort_Columns_by_header()
{
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Cliquer sur l'en-tête de la colonne "Valeur totale" et vérifier que la colonne est triée
    
    Log.Message("Verify sorting of the 'Total Value' column.");
    Get_AccountsGrid_ChTotalValue().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 106, language), "TotalValue")
    
    
    //Cliquer sur l'en-tête de la colonne "Solde" et vérifier que la colonne est triée
    
    Log.Message("Verify sorting of the 'Balance' column.");
    Get_AccountsGrid_ChBalance().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 107, language), "Balance")
        
    //Cliquer sur l'en-tête de la colonne "Devise" et vérifier que la colonne est triée
    
    Log.Message("Verify sorting of the 'Currency' column.");
    Get_AccountsGrid_ChCurrency().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 108, language), "Currency")
    
    //Cliquer sur l'en-tête de la colonne "Type" et vérifier que la colonne est triée
    
    Log.Message("Verify sorting of the 'Type' column.");
    Get_AccountsGrid_ChType().Click();    
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 109, language), "Type")
    
    //Fermer Croesus
    
    Close_Croesus_SysMenu();
}