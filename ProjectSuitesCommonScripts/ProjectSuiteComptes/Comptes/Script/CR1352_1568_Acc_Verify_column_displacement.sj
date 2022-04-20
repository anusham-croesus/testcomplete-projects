//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Vérifier le déplacement des colonnes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1568
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1568_Acc_Verify_column_displacement()
{
    
    Login(vServerAccounts, userName, psw, language);   
    Get_ModulesBar_BtnAccounts().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Devise' est affichée
    
    if (!(Get_AccountsGrid_ChCurrency().Exists)){
        Log.Error("'Currency' column not displayed. This is not expected.");
        return;
    }
    
    
    //Vérifier que la colonne 'Marge' est affichée
    
    if (!(Get_AccountsGrid_ChMargin().Exists)){
        Log.Error("'Margin' column not displayed. This is not expected.");
        return;
    }
    
    
    //Faire un glisser-déplacer de la colonne 'Devise' pour le mettre à droite de la colonne 'Marge'

    Log.Message("Move Currency column next to Margin column.");

    var CurrencyWidth = Get_AccountsGrid_ChCurrency().get_ActualWidth();
    var CurrencyHeight = Get_AccountsGrid_ChCurrency().get_ActualHeight();
    var MarginWidth = Get_AccountsGrid_ChMargin().get_ActualWidth();
    
    Get_AccountsGrid_ChCurrency().Drag(CurrencyWidth/2, CurrencyHeight/2, MarginWidth + CurrencyWidth/2, 0);


    //Vérifier que la colonne 'Devise' est à droite de la colonne 'Marge'

    var MarginPosX = Get_AccountsGrid_ChMargin().Left;
    var MarginWidth = Get_AccountsGrid_ChMargin().Width;
    var expectedCurrencyNewPosX = MarginPosX + MarginWidth - 1;
    var actualCurrencyNewPosX = Get_AccountsGrid_ChCurrency().Left;
    Log.Message("The 'Currency' column header new horizontal position is : " + actualCurrencyNewPosX);
    
    if (actualCurrencyNewPosX == expectedCurrencyNewPosX){
        Log.Checkpoint("'Currency' column was the next column right to the 'Margin' column.");
    }
    else {
        Log.Error("'Currency' column was not the next column right to the 'Margin' column. The horizontal position of 'Currency' was expected to be : " + expectedCurrencyNewPosX);
    }
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Fermer Croesus
    
    Close_Croesus_SysMenu();
}