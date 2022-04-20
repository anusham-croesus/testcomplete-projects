//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Relations_Get_functions


/**
    Description : Enlever une colonne dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-619
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0619_Rel_Remove_a_column_in_the_Relationships_module()
{
    Login(vServerRelations, userName, psw, language);
   
    Get_ModulesBar_BtnRelationships().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Marge' est affichée
    SetAutoTimeOut();
    if (!(Get_RelationshipsGrid_ChMargin().Exists)){
        Log.Error("'Margin' column not displayed. This is not expected.");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Enlever la colonne 'Marge'
    
    Log.Message("Remove the 'Margin' column.");
    Get_RelationshipsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
    
    
    //Vérifier que la colonne 'Marge' n'est pas affichée
     SetAutoTimeOut();
    if (Get_RelationshipsGrid_ChCommunication().Exists){
        Log.Error("'Margin' column displayed. This is not expected.");
    }
    else {
        Log.Checkpoint("'Margin' column not displayed.");
    }
    RestoreAutoTimeOut();
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    Close_Croesus_SysMenu();
}