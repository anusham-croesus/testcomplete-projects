//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Valider la suppression d'un champ
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1566
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1566_Acc_Validate_the_deletion_of_a_field()
{
    try {
        
        Login(vServerAccounts, userName, psw, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Vérifier que la colonne 'Marge' est affichée
        
        if (!(Get_AccountsGrid_ChMargin().Exists)){
            Log.Error("The 'Margin' column not displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Status' n'est pas affichée
        
        if (Get_AccountsGrid_ChStatus().Exists){
            Log.Error("The 'Status' column displayed. This is not expected");
            return;
        }
        
        
        //Insérer le champ 'Statut' à l'emplacement de la colonne 'Marge'
        
        Log.Message("Insert the 'Status' field at the 'Margin' field position.");
        Get_AccountsGrid_ChMargin().ClickR();
        Get_GridHeader_ContextualMenu_InsertField().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();
        
        
        //Vérifier que le champ 'Statut' est affichée
    
        if (!(Get_AccountsGrid_ChStatus().Exists)){
            Log.Error("'Status' field not displayed. This is not expected.");
            return;
        }
       
        Log.Checkpoint("'Status' field is displayed.");
        
        
        //Vérifier que le champ 'Marge' est affichée
    
        if (!(Get_AccountsGrid_ChMargin().Exists)){
            Log.Error("'Margin' field not displayed. This is not expected.");
            return;
        }
       
        Log.Checkpoint("'Margin' field is displayed.");
        
        
        //Supprimer le champ 'Statut'
    
        Log.Message("Delete the 'Status' field.");
        Get_AccountsGrid_ChStatus().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisField().Click();
        
        
        //Vérifier que le champ 'Statut' n'est pas affichée
    
        if (Get_AccountsGrid_ChStatus().Exists){
            Log.Error("'Status' field displayed. This is not expected.");
        }
        else {
            Log.Checkpoint("'Status' field not displayed. This is expected.");
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