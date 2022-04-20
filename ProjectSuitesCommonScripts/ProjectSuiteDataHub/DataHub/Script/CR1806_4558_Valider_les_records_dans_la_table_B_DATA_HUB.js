//USEUNIT CR1806_Helper




/**
    Description : Valider les records dans la table B_DATA_HUB
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4558
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB()
{
    CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4558", "CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB()");
    
    Log.Message("JIRA CROES-10234 : Le champ NB_RECORDS et IA_CODES de la table B_data_hub est vide lorsqu'on exporte vers le presse-papiers sans sélectionner aucune donnée.");

    try {
        NameMapping.TimeOutWarning = false;
        
        //Les types de donnée de la table B_DATA_HUB
        var DataHub_DataTypeName_NumericIdentity = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_NumericIdentity", language + client);
        var DataHub_DataTypeName_DateTime = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_DateTime", language + client);
        var DataHub_DataTypeName_VarChar = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_VarChar", language + client);
        var DataHub_DataTypeName_Text = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_Text", language + client);
        var DataHub_DataTypeName_Numeric = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHub_DataTypeName_Numeric", language + client);
        
        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        var prefValue = "YES";
        var prefLevel = "BRANCH";
        var shouldExportSuccess = true;
        var isCfLoaderCommandToBeChecked = false;
        
        //Ajouter un courriel à l'utilisateur
        var emailGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "emailGP1859", language + client);
        Execute_SQLQuery("update B_USER set EMAIL = '" + emailGP1859 + "' where STATION_ID = '" + userNameGP1859 + "'", vServerDataHub);
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, prefValue, prefLevel);
        
        //1, 2 : Valider_les_champs_disponibles_dans_la_table_B_DATA_HUB (Récupérer la structure de la table B_DATA_HUB, puis Vérifier les types de donnée)
        Log.Message("1, 2 : Valider_les_champs_disponibles_dans_la_table_B_DATA_HUB (Récupérer la structure de la table B_DATA_HUB, puis Vérifier les types de donnée)");
        var arrayOfColumnNamesAndTypeNames = GetDataHubTableColumnNamesAndTypeNames();
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
        
        
        //3. Se connecter avec GP1859. Après de génère l'exportation des donnès, se connecter sur la BD et consulter la table B_DATA_HUB (select * from B_DATA_HUB)
        Log.Message("3. Se connecter avec GP1859. Après l'exportation des données, se connecter sur la BD et consulter la table B_DATA_HUB (select * from B_DATA_HUB)");
        
        //Login
        Login(vServerDataHub, userNameGP1859, passwordGP1859, language);
        
        //Executer our chaque module
        var arrayOfExportMethod = null; //Toutes les méthodes d'exportation disponibles pour chaque module
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Models){
            GotoModule(moduleName_Models);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Models, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            GotoModule(moduleName_Relationships);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Relationships, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            GotoModule(moduleName_Clients);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Clients, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Accounts){
            GotoModule(moduleName_Accounts);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Accounts, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Portfolio){
            if (DragAccountsToPortfolio([]))
                ExecuteManyExportsFromModule(userNameGP1859, moduleName_Portfolio, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Transactions){
            GotoModule(moduleName_Transactions);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Transactions, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Securities){
            GotoModule(moduleName_Securities);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Securities, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
            Log.Message("JIRA CROES-10233 : Lorsqu'on exporte vers excel via le blotter du module Ordres, la FUNCTION_ID = OrdreAccumulatorDataGrid au lieu de FUNCTION_ID = OrdreBlotterDataGrid qui est le comportement attendu.");
            Log.Message("JIRA CROES-10231 : Crash de l'application lorsqu'on fait une copie sur le datagrille vide du module Ordres.");
            GotoModule(moduleName_Orders);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Orders, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
            
            GotoModule(moduleName_Orders_Accumulator);
            ExecuteManyExportsFromModule(userNameGP1859, moduleName_Orders_Accumulator, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        if (userNameGP1859 != undefined && emailGP1859 != undefined) Execute_SQLQuery("update B_USER set EMAIL = '' where STATION_ID = '" + userNameGP1859 + "'", vServerDataHub); //Supprimer le courriel ajouté à l'utilisateur
        if (userNameGP1859 != undefined) UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, null, prefLevel); //Mettre la Pref à sa valeur par défaut
        
        Terminate_CroesusProcess();
        NameMapping.TimeOutWarning = true;
    }
}



function CheckTableDataTypeName(arrayOfColumnNamesAndTypeNames, columnName, expectedTypeName)
{
    for (var i in arrayOfColumnNamesAndTypeNames)
        if (arrayOfColumnNamesAndTypeNames[i][0] == columnName)
            return CheckEquals(arrayOfColumnNamesAndTypeNames[i][1], expectedTypeName, "B_DATA_HUB column '" + columnName + "' type name");    
    
    Log.Error("Column '" + columnName + "' not found in the B_DATA_HUB table structure");
    return null;
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
