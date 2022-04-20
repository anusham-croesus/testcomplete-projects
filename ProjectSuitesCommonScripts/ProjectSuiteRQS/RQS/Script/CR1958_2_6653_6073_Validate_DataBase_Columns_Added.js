//USEUNIT CR1958_2_Helper


/**
    Description : Validate if the Plugin and the new column added in Offside Account Report Client Relationship number,Client Relationship Name,Management level)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6653_6073_Validate_DataBase_Columns_Added()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653", "Croes-6653 #7 - Client Profile : CR1958_2_6653_6073_Validate_DataBase_Columns_Added()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        //Récupérations à partir de fichier excel
        var Database_ColumnName_ManagementLevel             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_DataBase_ColumnName_ManagementLevel", language + client);
        var Database_ColumnName_ClientRelationshipName      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_DataBase_ColumnName_ClientRelationshipName", language + client);
        var Database_ColumnName_ClientRelationshipNumber    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_DataBase_ColumnName_ClientRelationshipNumber", language + client);
        var Database_ColumnName_ClientRelationshipID        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_DataBase_ColumnName_ClientRelationshipID", language + client);
        
        //ÉTAPE #1 : select MANAGEMENT_LEVEL,LINK_ID,NO_LINK,LINK_NAME from B_RQS_OFFSIDE_CLIENT_HIST
        var arrayOfDatabaseNewColumns = [Database_ColumnName_ManagementLevel, Database_ColumnName_ClientRelationshipName, Database_ColumnName_ClientRelationshipNumber,Database_ColumnName_ClientRelationshipID];
        Log.Message("STEP #1 : Validate added columns in DataBase : " + arrayOfDatabaseNewColumns, arrayOfDatabaseNewColumns.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var arrayOfSuccessfullyFoundNewColumns = [];
        for (var i = arrayOfDatabaseNewColumns.length - 1; i >= 0; i--){
            try {
                var arrayOfFieldValues = null;
                var databaseNewColumnName = arrayOfDatabaseNewColumns[i];
                arrayOfFieldValues = Execute_SQLQuery_GetFieldAllValues("select " + databaseNewColumnName + " from B_RQS_OFFSIDE_ENTITY_HIST", vServerRQS, databaseNewColumnName);//A.A: Avant B_RQS_OFFSIDE_CLIENT_HIST
                if (GetVarType(arrayOfFieldValues) == varArray || GetVarType(arrayOfFieldValues) == varDispatch)
                    arrayOfSuccessfullyFoundNewColumns.push(VarToStr(arrayOfDatabaseNewColumns.splice(i, 1)));
            }
            catch (exceptionSQL) {
                if (aqString.Find(exceptionSQL.message, "Invalid column name '" + databaseNewColumnName + "'") == -1)
                    Log.Error("SQL exception : " + exceptionSQL.message, VarToStr(exceptionSQL.stack));
                exceptionSQL = null;
            }
        }
        
        if (arrayOfSuccessfullyFoundNewColumns.length != 0)
            Log.Checkpoint("The following columns were successfully found : " + arrayOfSuccessfullyFoundNewColumns, arrayOfSuccessfullyFoundNewColumns);
        
        if (arrayOfDatabaseNewColumns.length != 0)
            Log.Error("The following columns were not successfully found : " + arrayOfDatabaseNewColumns, arrayOfDatabaseNewColumns);
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
}