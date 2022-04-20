//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Trier les colonnes (clique-droit)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1623
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1623_Acc_Sort_columns_by_right_click()
{
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Faire un clic droit et choisir Trier par 'Nom', vérifier que la colonne 'Nom' est effectivement triée
    
    Log.Message("Right-click in the grid, sort by Name and verify sorting of the 'Name' column.");
    
    Get_RelationshipsClientsAccountsGrid().ClickR();
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_SubMenus().Exists){
        Get_RelationshipsClientsAccountsGrid().ClickR();
        numberOftries++;
    } 
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_Name().Click();
    
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 112, language), "Name")
    
    
    //Faire un clic droit et choisir Trier par 'No compte', vérifier que la colonne 'No compte' est effectivement triée
    
    Log.Message("Right-click in the grid, sort by 'Account No.' and verify sorting of the 'Account No.' column.");

    Get_RelationshipsClientsAccountsGrid().ClickR();
    
     var numberOftries=0;  
    while ( numberOftries < 5 && !Get_SubMenus().Exists){
        Get_RelationshipsClientsAccountsGrid().ClickR();
        numberOftries++;
    } 
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();
    Get_AccountsGrid_ContextualMenu_SortBy_AccountNo().Click();
    
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 113, language), "AccountNumber")
    
    
    //Fermer Croesus
    
    Close_Croesus_SysMenu();
}