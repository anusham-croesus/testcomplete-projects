//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Valider la configuration par défaut de l'affichage des colonnes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1561
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1561_Acc_Validate_the_default_configuration_of_column_display()
{
    Login(vServerAccounts, userName, psw, language);
   
    Get_ModulesBar_BtnAccounts().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier que la colonne 'Valeur totale' est affichée
    
    if (!(Get_AccountsGrid_ChTotalValue().Exists)){
        Log.Error("Column 'Total Value' is not displayed. This is not expected");
        return;
    }
    
    
    //Enlever la colonne 'Valeur totale'
    
    Log.Message("Remove the 'Total Value' column.");
    Get_AccountsGrid_ChTotalValue().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
    
    
    //Vérifier que la colonne 'Valeur totale' n'est pas affichée
    
    if (Get_AccountsGrid_ChTotalValue().Exists){
        Log.Error("'Total Value' column displayed. This is not expected");
    }
    else {
        Log.Checkpoint("'Total Value' column not displayed. This is expected");
    }
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier l'existence et la position des en-têtes de colonne qui devraient être visibles
    
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChName(), 3, "Name");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChAccountNo(), 4, "Account No.");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChIACode(), 5, "IA Code");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChType(), 6, "Type");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChPlan(), 7, "Plan");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTelephone1(), 8, "Telephone 1");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTelephone2(), 9, "Telephone 2");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChBalance(), 10, "Balance");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChCurrency(), 11, "Currency");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChMargin(), 12, "Margin");
    CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTotalValue(), 13, "Total Value");    
    
    
    //Vérifier la non existence des en-têtes de colonne qui ne devraient pas être visibles
    
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChJointAccount(), "Joint Account")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChCreationDate(), "Creation Date")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChIAProgChangeDate(), "IA/Prog. Change Date")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChClosingDate(), "Closing Date")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChLastTransaction(), "Last Transaction")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChLastTrade(), "Last Trade")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChSeparatelyManaged(), "Separately Managed")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChManager(), "Manager")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChLanguage(), "Language")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChMandate(), "Mandate")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChClientNo(), "Client No.")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChFullName(), "Full Name")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChSleeves(), "Sleeves")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChStatus(), "Status")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChCheckDigit(), "Check Digit")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChProduct(), "Product")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChSecondaryProduct(), "Secondary Product")
    CheckNonExistenceOfColumn(Get_AccountsGrid_ChHobbies(), "Hobbies")
    
    
    //Fermer Croesus
    Close_Croesus_SysMenu();
}




function CheckExistenceAndPositionOfColumn(columnHeaderObject, expectedColumnHeaderIndex, columnHeaderName)
{
    //Vérifier que la colonne est affichée    

    if (!(columnHeaderObject.Exists)){
        Log.Error("'" + columnHeaderName + "' column not displayed. This is not expected.");
        return false;
    }
    
    Log.Checkpoint("'" + columnHeaderName + "' column displayed. This is expected.");

    
    //Vérifier que la colonne est à la bonne position

    var actualColumnHeaderIndex = columnHeaderObject.WPFControlOrdinalNo;
    Log.Message("The '" + columnHeaderName + "' column actual index is : " + actualColumnHeaderIndex);
    
    if (expectedColumnHeaderIndex == actualColumnHeaderIndex){
        Log.Checkpoint("'" + columnHeaderName + "' column is at the expected position.");
        return true;
    }
    else {
        Log.Error("'" + columnHeaderName + "' column is not at the expected position. Expecting index : " + expectedColumnHeaderIndex + ", got : " + actualColumnHeaderIndex);
        return false;
    }
}




function CheckNonExistenceOfColumn(columnHeaderObject, columnHeaderName)
{
    //Vérifier que la colonne n'est pas affichée    

    if (columnHeaderObject.Exists){
        Log.Error("'" + columnHeaderName + "' column displayed. This is not expected.");
        return false;
    }
    else {
        Log.Checkpoint("'" + columnHeaderName + "' column not displayed. This is expected.");
        return true;
    }
}