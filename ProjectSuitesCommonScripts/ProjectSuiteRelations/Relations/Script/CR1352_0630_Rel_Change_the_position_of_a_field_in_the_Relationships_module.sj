//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Changer la position d'un champ dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-630
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0630_Rel_Change_the_position_of_a_field_in_the_Relationships_module()
{
    
    Login(vServerRelations, userName, psw, language);   
    Get_ModulesBar_BtnRelationships().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Insérer le champ 'Langue' en dessous du champ Devise
    
    Log.Message("Insert the 'Language' field under the 'Currency' field");
    Get_RelationshipsGrid_ChCurrency().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
    
    
    //Vérifier que le champ 'Langue' est affichée
    SetAutoTimeOut();
    if (!(Get_RelationshipsGrid_ChLanguage().Exists)){
        Log.Error("'Language' field not displayed. This is not expected.");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Faire un glisser-déplacer du champ 'Langue' pour le mettre en dessous du champ 'Valeur totale'
    
    Log.Message("Move 'Language' field and place it under the 'TotalValue' field.");
    
    var LanguageWidth = Get_RelationshipsGrid_ChLanguage().get_ActualWidth();
    var LanguageHeight = Get_RelationshipsGrid_ChLanguage().get_ActualHeight();
    var MarginWidth = Get_RelationshipsGrid_ChMargin().get_ActualWidth();
    var TotalValueWidth = Get_RelationshipsGrid_ChTotalValue().get_ActualWidth();
    
    Get_RelationshipsGrid_ChLanguage().Drag(LanguageWidth/2, LanguageHeight/2, TotalValueWidth/2 + MarginWidth + LanguageWidth/2, 0);
    
    
    //Vérifier que le champ 'Langue' est en dessous de de l'en-tête de colonne 'Valeur totale'
        
    Log.Message("Verify that the 'Language' field is just under the 'TotalValue' header");
        
    var TotalValuePosX = Get_RelationshipsGrid_ChTotalValue().Left;
    var actualLanguagePosX = Get_RelationshipsGrid_ChLanguage().Left;
    var expectedLanguagePosX = TotalValuePosX;
    Log.Message("The horizontal position of 'Language' was : " + actualLanguagePosX);
    
    var TotalValuePosY = Get_RelationshipsGrid_ChTotalValue().Top;
    var TotalValueHeight = Get_RelationshipsGrid_ChTotalValue().Height;
    var actualLanguagePosY = Get_RelationshipsGrid_ChLanguage().Top;
    var expectedLanguagePosY = TotalValuePosY + TotalValueHeight - 1;
    Log.Message("The vertical position of 'Language' was : " + actualLanguagePosY);
        
    if ((actualLanguagePosX == expectedLanguagePosX) && (actualLanguagePosY == expectedLanguagePosY)){
        Log.Checkpoint("'Language' field was just under the 'Total Value' field.");
    }
    else {
        Log.Error("Ref. BUG CROES-4942. 'Language' field was not just under the 'Total Value' field. The horizontal position of 'Language' was expected to be : " + expectedLanguagePosX + ". The vertical position of 'Language' was expected to be : " + expectedLanguagePosY);
    }   
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    
    Close_Croesus_SysMenu();
}