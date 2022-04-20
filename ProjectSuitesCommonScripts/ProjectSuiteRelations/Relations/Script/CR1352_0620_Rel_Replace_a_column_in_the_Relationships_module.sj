//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Remplacer une colonne dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-620
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0620_Rel_Replace_a_column_in_the_Relationships_module()
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
            Log.Error("'Margin' column not displayed. This is not expected.");
            return;
        }
        
        
        //Vérifier que la colonne 'Langue' n'est pas affichée
        
        if (Get_RelationshipsGrid_ChLanguage().Exists){
            Log.Error("'Language' column displayed. This is not expected.");
            return;
        }
        
        RestoreAutoTimeOut();
        //Prendre la position de la colonne 'Marge'
    
        var MarginColumnIndex = Get_RelationshipsGrid_ChMargin().WPFControlOrdinalNo;
        Log.Message("The 'Margin' column index is : " + MarginColumnIndex);
        
        
        //Remplacer la colonne 'Marge' par 'Langue'
        
        Log.Message("Replace the 'Margin' column with 'Language'.");
        Get_RelationshipsGrid_ChMargin().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().Click();
        Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
        
        
        //Vérifier que la colonne 'Marge' n'est pas affichée
        SetAutoTimeOut();
        if (Get_RelationshipsGrid_ChMargin().Exists){
            Log.Error("'Margin' column displayed. This is not expected.");
        }
        else {
            Log.Checkpoint("'Margin' column not displayed. This is expected.");
        }
       
        
        //Vérifier que la colonne 'Langue' est affichée
    
        if (Get_RelationshipsGrid_ChLanguage().Exists){
            Log.Checkpoint("'Language' column displayed.");
        }
        else {
            Log.Error("'Language' column not displayed. This is not expected.");
            return;
        }
         RestoreAutoTimeOut();
        
        //Vérifier que la colonne 'Langue' est à la même place que la colonne 'Marge'
    
        var LanguageColumnIndex = Get_RelationshipsGrid_ChLanguage().WPFControlOrdinalNo;
        Log.Message("The 'Language' column index is : " + LanguageColumnIndex);
        
        if (LanguageColumnIndex == MarginColumnIndex){
            Log.Checkpoint("'Language' column is at the same position as the 'Margin' column.");
        }
        else {
            Log.Error("'Language' column is not at the same position as the 'Margin' column. This is not expected.");
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