//USEUNIT CR1806_Helper




/**
    Description : Valider les champs disponibles dans la table B_DATA_HUB
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4558
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4558_Valider_les_champs_disponibles_dans_la_table_B_DATA_HUB()
{
    /////////////////////
    return Log.Message("Ce script sera supprimé car désormais intégré à : CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB()", "Voir : CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB()");
    
    Log.Message("CR1806_4558_Valider_les_champs_disponibles_dans_la_table_B_DATA_HUB()");
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4558", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        var DataHub_DataTypeName_NumericIdentity = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_NumericIdentity", language + client);
        var DataHub_DataTypeName_DateTime = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_DateTime", language + client);
        var DataHub_DataTypeName_VarChar = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_VarChar", language + client);
        var DataHub_DataTypeName_Text = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_Text", language + client);
        var DataHub_DataTypeName_Numeric = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_Numeric", language + client);
    
        //Récupérer la structure de la table B_DATA_HUB
        var arrayOfColumnNamesAndTypeNames = GetDataHubTableColumnNamesAndTypeNames();
        
        //Vérifier les types de donnée
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_TASK_ID, DataHub_DataTypeName_NumericIdentity);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_DATE_GENERATION, DataHub_DataTypeName_DateTime);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_STATION_ID, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_LASTNAME_USER, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_FIRSTNAME_USER, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_EMAIL, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_ACCES, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_SUCC_ID, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_SUCC_NAME, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_IA_CODES, DataHub_DataTypeName_Text);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_FUNCTION_NAME, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_FUNCTION_ID, DataHub_DataTypeName_VarChar);
        CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, DataHub_ColumnName_NB_RECORDS, DataHub_DataTypeName_Numeric);
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        NameMapping.TimeOutWarning = true;
    }
}



function CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, columnName, expectedTypeName)
{
    for (var i in arrayOfColumnNamesAndTypeNames){
        if (arrayOfColumnNamesAndTypeNames[i][0] == columnName){
            CheckEquals(arrayOfColumnNamesAndTypeNames[i][1], expectedTypeName, "B_DATA_HUB column '" + columnName + "' type name");
            return;
        }
    }
    
    Log.Error("Column '" + columnName + "' not found in the B_DATA_HUB table structure")
}



////À améliorer éventuellement
function GetDataHubTableColumnNamesAndTypeNames()
{
    var query = "sp_columns 'B_DATA_HUB'";
	  
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServerDataHub);
	  
    Qry.SQL=query;
    Qry.Open();
    Qry.First();
    
    var arrayOfValues = new Array();
    while (!Qry.EOF){
        var column_name = Qry.FieldByName('column_name').Value;
        var type_name = Qry.FieldByName('type_name').Value;
        arrayOfValues.push([column_name, type_name]);
        Qry.Next();
    }
    Qry.Close();
            
    return arrayOfValues;
}
