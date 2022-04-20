//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Insérer un champ dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-621
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

/***************************   BUG CROES-4942    ***************************/

function CR1352_0621_Rel_Insert_a_field_in_the_Relationships_module()
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
        
        
        //Vérifier que le champ 'Communication' est en dessous de de l'en-tête de colonne 'Marge'
        
        Log.Message("Verify that the 'Communication' field is just under the 'Margin' header");
        
        var MarginPosX = Get_RelationshipsGrid_ChMargin().Left;
        var actualCommunicationPosX = Get_RelationshipsGrid_ChCommunication().Left;
        var expectedCommunicationPosX = MarginPosX;
        Log.Message("The horizontal position of 'Communication' was : " + actualCommunicationPosX);
    
        var MarginPosY = Get_RelationshipsGrid_ChMargin().Top;
        var MarginHeight = Get_RelationshipsGrid_ChMargin().Height;
        var actualCommunicationPosY = Get_RelationshipsGrid_ChCommunication().Top;
        var expectedCommunicationPosY = MarginPosY + MarginHeight - 1;
        Log.Message("The vertical position of 'Communication' was : " + actualCommunicationPosY);
        
        if ((actualCommunicationPosX == expectedCommunicationPosX) && (actualCommunicationPosY == expectedCommunicationPosY)){
            Log.Checkpoint("'Communication' field was just under the 'Margin' field.");
        }
        else {
            Log.Error("Ref. BUG CROES-4942. 'Communication' field was not just under the 'Margin' field. The horizontal position of 'Communication' was expected to be : " + expectedCommunicationPosX + ". The vertical position of 'Communication' was expected to be : " + expectedCommunicationPosY);
        }
        
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