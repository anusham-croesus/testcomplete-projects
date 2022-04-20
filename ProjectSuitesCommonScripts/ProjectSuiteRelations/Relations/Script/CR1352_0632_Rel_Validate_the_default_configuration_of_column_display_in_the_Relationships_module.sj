//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Valider la configuration par défaut de l'affichage des colonnes dans le module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-632
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0632_Rel_Validate_the_default_configuration_of_column_display_in_the_Relationships_module()
{
    
    Login(vServerRelations, userName, psw, language);
    
    Get_ModulesBar_BtnRelationships().Click();
    
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Ajouter une colonne - Communication
    
    Log.Message("Add 'Communication' column.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Communication().Click();
    
    
    //Vérifier que la colonne 'Communication' est affichée
    SetAutoTimeOut();
    if (!(Get_RelationshipsGrid_ChCommunication().Exists)){
        Log.Error("'Communication' column is not displayed. This is not expected");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Insérer un champ - Langue
    
    Log.Message("Add 'Communication' column.");
    Get_RelationshipsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
    
    
    //Vérifier que le champ 'Langue' est affiché
    SetAutoTimeOut();
    if (!(Get_RelationshipsGrid_ChLanguage().Exists)){
        Log.Error("'Language' field is not displayed. This is not expected");
        Close_Croesus_SysMenu();
        return;
    }
    RestoreAutoTimeOut();
    
    //Rétablir la configuration par défaut des colonnes
    
    Log.Message("Restore default configuration for the columns.");
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    
    //Vérifier l'existence et la position des en-têtes de colonne qui devraient être visibles
    var i = 3;
    if (client == "CIBC")
        i = 4;
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChName(), i, "Name");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChRelationshipNo(), i+1, "Relationship No.");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChIACode(), i+2, "IA Code");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChBalance(), i+3, "Balance");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChCurrency(), i+4, "Currency");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChMargin(), i+5, "Margin");
    CheckExistenceAndPositionOfColumn(Get_RelationshipsGrid_ChTotalValue(), i+6, "Total Value");

    
    //Vérifier la non existence des en-têtes de colonne qui ne devraient pas être visibles
    
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChAlternateName(), "Alternate Name")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChCommunication(), "Communication")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChCreation(), "Creation")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChEmail1(), "Email 1")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChEmail2(), "Email 2")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChEmail3(), "Email 3")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChFullName(), "Full Name")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChLanguage(), "Language")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChLastUpdate(), "Last Update")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChRepresentative(), "Representative")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChSalutationName(), "Salutation Name")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChSegmentation(), "Segmentation")
    CheckNonExistenceOfColumn(Get_RelationshipsGrid_ChType(), "Type")

    
    
    //Fermer Croesus
    Close_Croesus_SysMenu();
}



function CheckExistenceAndPositionOfColumn(columnHeaderObject, expectedColumnHeaderIndex, columnHeaderName)
{
    //Vérifier que la colonne est affichée    
   SetAutoTimeOut();

    if (!(columnHeaderObject.Exists)){
        Log.Error("'" + columnHeaderName + "' column not displayed. This is not expected.");
        return false;
    }
    RestoreAutoTimeOut();
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
    SetAutoTimeOut();

    if (columnHeaderObject.Exists){
        Log.Error("'" + columnHeaderName + "' column displayed. This is not expected.");
        return false;
    }
    else {
        Log.Checkpoint("'" + columnHeaderName + "' column not displayed. This is expected.");
        return true;
    }
    RestoreAutoTimeOut();
}