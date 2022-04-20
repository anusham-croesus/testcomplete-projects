//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Valider le remplacement d'une colonne
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1558
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1558_Acc_Confirm_the_replacement_of_a_column()
{
    try {
        
        Login(vServerAccounts, userName, psw, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Vérifier que la colonne 'Valeur totale' est affichée
        
        if (!(Get_AccountsGrid_ChTotalValue().Exists)){
            Log.Error("Column 'Total Value' not displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Creation' n'est pas affichée
        
        if (Get_AccountsGrid_ChCreationDate().Exists){
            Log.Error("Column 'Creation Date' displayed. This is not expected.");
            return;
        }
        
        
        //Prendre la position de la colonne 'Valeur totale'
    
        var TotalValueIndex = Get_AccountsGrid_ChTotalValue().WPFControlOrdinalNo;
        Log.Message("The 'Total Value' column index is : " + TotalValueIndex);
        
        
        //Remplacer la colonne 'Valeur totale' par 'Création'
        
        Log.Message("Replace the column 'Total Value' with 'Creation Date'.");
        Get_AccountsGrid_ChTotalValue().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CreationDate().Click();
        
        
        //Vérifier que la colonne 'Valeur totale' n'est pas affichée
        
        if (Get_AccountsGrid_ChTotalValue().Exists){
            Log.Error("Column 'Total Value' displayed. This is not expected.");
        }
        else {
            Log.Checkpoint("Column 'Total Value' not displayed. This is expected.");
        }
        
        
        //Vérifier que la colonne 'Création' est affichée
    
        if (Get_AccountsGrid_ChCreationDate().Exists){
            Log.Checkpoint("Column 'Creation Date' displayed.");
        }
        else {
            Log.Error("Column 'Creation Date' not displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Création' est à la même place que la colonne 'Valeur totale'
    
        var CreationDateIndex = Get_AccountsGrid_ChCreationDate().WPFControlOrdinalNo;
        Log.Message("The 'Creation Date' column index is : " + CreationDateIndex);
        
        if (CreationDateIndex == TotalValueIndex){
            Log.Checkpoint("Column 'Creation Date' is at the same position as the column 'Total Value'.");
        }
        else {
            Log.Error("Column 'Creation Date' is not at the same position as the column 'Total Value'. This is not expected.");
        }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        //Rétablir la configuration par défaut des colonnes
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
        //Fermer Croesus
        Close_Croesus_SysMenu();
    }
}