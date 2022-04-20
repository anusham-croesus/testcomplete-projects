//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Relations_Get_functions


/**
    Description : Ajouter une colonne dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-618
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0618_Rel_Add_a_column_in_the_Relationships_module()
{
    Login(vServerRelations, userName, psw, language);
   
    Get_ModulesBar_BtnRelationships().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Communication' n'est pas affichée
    SetAutoTimeOut();

    if (Get_RelationshipsGrid_ChCommunication().Exists){
        Log.Error("'Communication' column displayed. This is not expected.");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Ajouter la colonne 'Communication'
    
    Log.Message("Add the 'Communication' column.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Communication().Click();
    
    
    //Vérifier que la colonne 'Communication' est affichée
     SetAutoTimeOut();
    if (Get_RelationshipsGrid_ChCommunication().Exists){
        Log.Checkpoint("'Communication' column displayed.");
    }
    else {
        Log.Error("'Communication' column not displayed. This is not expected.");
    }
     RestoreAutoTimeOut();
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    Close_Croesus_SysMenu();
}