//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Changer la position d'une colonne dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-631
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0631_Rel_Change_the_position_of_a_column_in_the_Relationships_module()
{
    
    Login(vServerRelations, userName, psw, language);   
    Get_ModulesBar_BtnRelationships().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Devise' est affichée
    SetAutoTimeOut();
    if (!(Get_RelationshipsGrid_ChCurrency().Exists)){
        Log.Error("'Currency' column not displayed. This is not expected.");
        Close_Croesus_SysMenu();
        return;
    }
    
    
    //Vérifier que la colonne 'Marge' est affichée
    
    if (!(Get_RelationshipsGrid_ChMargin().Exists)){
        Log.Error("'Margin' column not displayed. This is not expected.");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Faire un glisser-déplacer de la colonne 'Devise' pour le mettre à droite de la colonne 'Marge'
    
    Log.Message("Move Currency column next to Margin column.");
    
    var CurrencyWidth = Get_RelationshipsGrid_ChCurrency().get_ActualWidth();
    var CurrencyHeight = Get_RelationshipsGrid_ChCurrency().get_ActualHeight();
    var MarginWidth = Get_RelationshipsGrid_ChMargin().get_ActualWidth();
    
    Get_RelationshipsGrid_ChCurrency().Drag(CurrencyWidth/2, CurrencyHeight/2, MarginWidth + CurrencyWidth/2, 0);
    
    
    //Vérifier que la colonne 'Devise' est à droite de la colonne 'Marge'
    
    var MarginPosX = Get_RelationshipsGrid_ChMargin().Left;
    var MarginWidth = Get_RelationshipsGrid_ChMargin().Width;
    var expectedCurrencyNewPosX = MarginPosX + MarginWidth - 1;
    var actualCurrencyNewPosX = Get_RelationshipsGrid_ChCurrency().Left;
    Log.Message("The 'Currency' column header new horizontal position is : " + actualCurrencyNewPosX);
    
    if (actualCurrencyNewPosX == expectedCurrencyNewPosX){
        Log.Checkpoint("'Currency' column was the next column right to the 'Margin' column.");
    }
    else {
        Log.Error("'Currency' column was not the next column right to the 'Margin' column. The horizontal position of 'Currency' was expected to be : " + expectedCurrencyNewPosX);
    }
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    
    Close_Croesus_SysMenu();
}