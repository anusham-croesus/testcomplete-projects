//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Enlever un champ dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-622
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/



function CR1352_0622_Rel_Remove_a_field_in_the_Relationships_module()
{
    try {
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore default configuration for the columns.");
        Get_RelationshipsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Vérifier que la colonne 'Marge' est affichée
        SetAutoTimeOut();
        if (!(Get_RelationshipsGrid_ChMargin().Exists)){
            Log.Error("The 'Margin' column not displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Communication' n'est pas affichée
        
        if (Get_RelationshipsGrid_ChCommunication().Exists){
            Log.Error("The 'Communication' column displayed. This is not expected.");
            return;
        }
        
        RestoreAutoTimeOut();
        //Insérer le champ 'Communication' à l'emplacement de la colonne 'Marge'
        
        Log.Message("Insert the 'Communication' field at the 'Margin' field position.");
        Get_RelationshipsGrid_ChMargin().ClickR();
        Get_GridHeader_ContextualMenu_InsertField().Click();
        Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Communication().Click();
        
        
        //Vérifier que la colonne 'Marge' est affichée
        SetAutoTimeOut();
        if (!(Get_RelationshipsGrid_ChMargin().Exists)){
            Log.Error("'Margin' column not displayed. This is not expected.");
            return;
        }
        
        Log.Checkpoint("'Margin' column displayed.");
            
        
        //Vérifier que le champ 'Communication' est affichée
        
        if (!(Get_RelationshipsGrid_ChCommunication().Exists)){
            Log.Error("'Communication' field not displayed. This is not expected.");
            return;
        }
        RestoreAutoTimeOut();
        Log.Checkpoint("'Communication' field displayed.");
        
        
        //Enlever le champ 'Communication'
        
        Log.Message("Remove the 'Communication' field.");
        Get_RelationshipsGrid_ChCommunication().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisField().Click();
        
        
        //Vérifier que le champ 'Communication' n'est pas affichée
        SetAutoTimeOut();
        if (Get_RelationshipsGrid_ChCommunication().Exists){
            Log.Error("The 'Communication' field displayed. This is not expected.");
        }
        else {
            Log.Checkpoint("The 'Communication' field not displayed. This is expected.");
        }
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        //Rétablir la configuration par défaut des colonnes
        Log.Message("Restore default configuration for the columns.");
        Get_RelationshipsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        //Fermer Croesus
        Close_Croesus_SysMenu();
    }
}