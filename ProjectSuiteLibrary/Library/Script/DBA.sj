//USEUNIT Global_variables
//USEUNIT Common_functions


function GetDBAConnectionString(vServerURL)
{
    var source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
    if (client == "CIBC") 
           source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb02";
    if (projet == "PerformanceNFR" || projet == "Performance"){
//        return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
          return source;
    }
    else if (projet == "General"){
        var BDNum = aqString.SubString(vServerURL, 19, 2);
        return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + BDNum;
    }
    else {
        Log.Error("Valeur '" + projet + "' non supportée pour la variable globale : projet.");
        return "";
    }
}



function DisableDoubleAuthentication(vServerURL, isRestartServicesToBeExecuted)
{
    Log.Message("DisableDoubleAuthentication on VServer " + vServerURL + "...");
    var userEmail = "'testsauto+' + rtrim(B_USER.STATION_ID) + '@croesus.com'"
    var updateQueryString = "update B_USER set MOTPASSE = 'GZz7m3vOe', RECOVERY_EMAIL_CONFIRMED = 'Y', RECOVERY_EMAIL = " + userEmail + ", EMAIL = " + userEmail + ", HASH = null, SALT = null, HASH_VERSION = 0, LAST_PSWD_CHNGE = null, VALIDATION_KEY = null, VALIDATION_CODE_EXPIRATION = null, PSWD_TENTATIVE_COUNT = 0, PSWD_REINIT = 0, BLOCKING_TYPE = '', VALIDATION_CODE_COUNT = 0, VALIDATION_CODE = null";
    
    Execute_SQLQuery(updateQueryString, vServerURL);
    
    Activate_Inactivate_PrefBranch("0", "PREF_AUTHENTICATION", "-1", vServerURL)
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_AUTHENTICATION", "-1", vServerURL);
    if (isRestartServicesToBeExecuted == undefined || isRestartServicesToBeExecuted === true)
        RestartServices(vServerURL);
    Log.Message("DisableDoubleAuthentication finished.");
}


/**
    Activer/Désactiver une pref à un niveau donné pour un User
    Les niveaux enfants sont restaurés à leur valeur par défaut, si nécessaire
*/
function UpdatePrefAtLevelForUser(user, prefName, prefValue, prefLevel, vServerURL)
{
    if (aqString.ToUpper(prefLevel) != "USER" && aqString.ToUpper(prefLevel) != "BRANCH" && aqString.ToUpper(prefLevel) != "FIRM")
        return Log.Error("Value '" + prefLevel + "' not supported for the prefLevel parameter.");
    
    if (aqString.ToUpper(prefLevel) == "USER")
        Activate_Inactivate_Pref(user, prefName, prefValue, vServerURL);
    else {
        Activate_Inactivate_Pref(user, prefName, null, vServerURL);
        var no_succ = Execute_SQLQuery_GetField("select NO_SUCC from B_USER where STATION_ID = '" + user + "'", vServerURL, "NO_SUCC");
        if (aqString.ToUpper(prefLevel) == "BRANCH")
            Activate_Inactivate_PrefBranch(no_succ, prefName, prefValue, vServerURL);
        else if (aqString.ToUpper(prefLevel) == "FIRM"){
            Activate_Inactivate_PrefBranch(no_succ, prefName, null, vServerURL);
            var firm_id = Execute_SQLQuery_GetField("select FIRM_ID from B_SUCC where NO_SUCC = '" + no_succ + "'", vServerURL, "FIRM_ID");
            var firm_code = Execute_SQLQuery_GetField("select FIRM_CODE from B_FIRM where FIRM_ID = " + firm_id, vServerURL, "FIRM_CODE");
            Activate_Inactivate_PrefFirm(firm_code, prefName, prefValue, vServerURL);
        }            
    }
}



/**
    Activer/Désactiver une pref User Level (utilise par défaut la procédure stockée)
    Pour remettre la pref à sa valeur par défaut, utiliser value = null
*/
function Activate_Inactivate_Pref_OldVersion(stationID, key, value, vServer)
{
    if (value == undefined) return Activate_Inactivate_Pref(stationID, key, value, vServer);
    
    var Proc=ADO.CreateADOStoredProc();
    Proc.ConnectionString = GetDBAConnectionString(vServer);
    //name of procedure
    Proc.ProcedureName="dbo.spUserConfig"
    //Proc.Parameters.
    Proc.Parameters.CreateParameter("@stationId",ftFixedChar,adParamInput,8,stationID);
    Proc.Parameters.CreateParameter("@key",ftFixedChar,adParamInput,60,key);
    Proc.Parameters.CreateParameter("@value",ftFixedChar,adParamInput,300,value);
    //execution
    Proc.ExecProc();
}




/**
    Activer/Désactiver une pref User Level (sans utiliser la procédure stockée)
    Pour remettre la pref à sa valeur par défaut, utiliser value = null
*/
function Activate_Inactivate_Pref(stationID, key, value, vServer)
{
    var selectQueryString = "select CONFIG_TXT from B_USER where STATION_ID = '" + stationID + "'";
    var config_txt = Execute_SQLQuery_GetField(selectQueryString, vServer, "CONFIG_TXT");
    
    var new_config_txt = GetNewConfigTxt(config_txt, key, value);
    if (new_config_txt == config_txt) return true;
    
    var updateQueryString = "update B_USER set CONFIG_TXT = '" + new_config_txt + "' where STATION_ID = '" + stationID + "'";
    return Execute_SQLQuery(updateQueryString, vServer);
}



/**
    Activer/Désactiver un pref Branch Level (utilise par défaut la procédure stockée)
    Pour remettre la pref à sa valeur par défaut, utiliser value = null
*/
function Activate_Inactivate_PrefBranch_OldVersion(noSucc, key, value, vServer)
{
    if (value == undefined) return Activate_Inactivate_PrefBranch(noSucc, key, value, vServer);
    
    var Proc=ADO.CreateADOStoredProc();
    Proc.ConnectionString = GetDBAConnectionString(vServer);
    //name of procedure
    Proc.ProcedureName="dbo.spBranchConfig"
    //Proc.Parameters.
    Proc.Parameters.CreateParameter("@noSucc",ftFixedChar,adParamInput,10,noSucc);
    Proc.Parameters.CreateParameter("@key",ftFixedChar,adParamInput,60,key);
    Proc.Parameters.CreateParameter("@value",ftFixedChar,adParamInput,300,value);
    //execution
    Proc.ExecProc();
}



/**
    Activer/Désactiver une pref Branch Level (sans utiliser la procédure stockée)
    Pour remettre la pref à sa valeur par défaut, utiliser value = null
*/
function Activate_Inactivate_PrefBranch(noSucc, key, value, vServer)
{
    var selectQueryString = "select CONFIG_TXT from B_SUCC where NO_SUCC = '" + noSucc + "'";
    var config_txt = Execute_SQLQuery_GetField(selectQueryString, vServer, "CONFIG_TXT");
    
    var new_config_txt = GetNewConfigTxt(config_txt, key, value);
    if (new_config_txt == config_txt) return true;
    
    var updateQueryString = "update B_SUCC set CONFIG_TXT = '" + new_config_txt + "' where NO_SUCC = '" + noSucc + "'";
    return Execute_SQLQuery(updateQueryString, vServer);
}



/**
    Activer/Désactiver une pref Firm Level
    Pour remettre la pref à sa valeur par défaut, utiliser value = null
*/
function Activate_Inactivate_PrefFirm(firm_code, key, value, vServer)
{
    var selectQueryString = "select CONFIG_TXT from B_FIRM where FIRM_CODE = '" + firm_code + "'";
    var config_txt = Execute_SQLQuery_GetField(selectQueryString, vServer, "CONFIG_TXT");
    
    var new_config_txt = GetNewConfigTxt(config_txt, key, value);
    if (new_config_txt == config_txt) return true;
    
    var updateQueryString = "update B_FIRM set CONFIG_TXT = '" + new_config_txt + "' where FIRM_CODE = '" + firm_code + "'";
    return Execute_SQLQuery(updateQueryString, vServer);
}



function Execute_SQLQuery(queryString, vServer)//par exemple suppression
{
	Log.Message("Execute SQL Query: " + queryString, queryString);
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    Qry.SQL = queryString;
    // Documentation http://docwiki.embarcadero.com/Libraries/XE2/en/Data.Win.ADODB.TADOQuery.ExecSQL
    nbRows = Qry.ExecSQL();
    return nbRows;
}



function Execute_SQLQuery_GetField(queryString, vServer, fieldName)
{
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    Qry.SQL = queryString;
    Qry.Open();
    Qry.First();
    var value = Qry.FieldByName(fieldName).Value;
    Qry.Close();
    
    return value;
}



function Execute_SQLQuery_GetFieldAllValues(queryString, vServer, fieldName)
{
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
	  
    Qry.SQL = queryString;
    Qry.Open();
    Qry.First();
    
    var arrayOfValues = new Array();
    while (!Qry.EOF){
        arrayOfValues.push(Qry.FieldByName(fieldName).Value);
        Qry.Next();
    }
    Qry.Close();
    
    return arrayOfValues;
}



/**
    Retourne la valeur de la pref pour un utilisateur
    Retourne null en cas de valeur par défaut
*/
function GetUserPrefValue(vServerURL, prefName, station_id)
{
    var queryString = "select CONFIG_TXT from B_USER where STATION_ID = '" + station_id + "'";
    var config_txt = Execute_SQLQuery_GetField(queryString, vServerURL, "CONFIG_TXT");
    return GetPrefValueFromConfigTxt(config_txt, prefName);
}



/**
    Retourne la valeur de la pref pour une succursale
    Retourne null en cas de valeur par défaut
*/
function GetSuccPrefValue(vServerURL, prefName, noSucc)
{
    if (noSucc == undefined) noSucc = "0";
    
    var queryString = "select CONFIG_TXT from B_SUCC where NO_SUCC = '" + noSucc + "'";
    var config_txt = Execute_SQLQuery_GetField(queryString, vServerURL, "CONFIG_TXT");
    return GetPrefValueFromConfigTxt(config_txt, prefName);
}



/**
    Retourne la valeur de la pref pour une firme
    Retourne null en cas de valeur par défaut
*/
function GetFirmPrefValue(vServerURL, prefName, firm_code)
{
    var queryString = "select CONFIG_TXT from B_FIRM where FIRM_CODE = '" + firm_code + "'";
    var config_txt = Execute_SQLQuery_GetField(queryString, vServerURL, "CONFIG_TXT");
    return GetPrefValueFromConfigTxt(config_txt, prefName);
}



/**
    Retourne la valeur de la pref, en parsant le contenu du champ config_txt fourni
    Retourne null si la pref spécifiée n'est pas présente dans config_txt
*/
function GetPrefValueFromConfigTxt(config_txt, prefName)
{
    var arrayOfConfigTxtLine = Trim(config_txt).split("\n");
    for (var i = arrayOfConfigTxtLine.length - 1; i >= 0; i--){
        var currentLine = Trim(arrayOfConfigTxtLine[i]);
        if (aqString.Find(currentLine, aqString.ToUpper(prefName) + "=") == 0)
            return aqString.Replace(currentLine, prefName + "=", "", false);
    }
    
    return null;
}


/**
    Génère un nouveau champ config_txt selon la pref à mettre à jour
    Pas de changement si la nouvelle valeur est la même que celle existante
*/
function GetNewConfigTxt(config_txt, prefName, prefValue)
{
    var isPrefFound = false;
    var expectedPrefLine = (prefValue == undefined)? null: prefName + "=" + prefValue;
    var arrayOfConfigTxtLine = Trim(config_txt).split("\n");
    for (var i = arrayOfConfigTxtLine.length - 1; i >= 0; i--){
        if (aqString.Find(Trim(arrayOfConfigTxtLine[i]), aqString.ToUpper(prefName) + "=") == 0){
            isPrefFound = true;
            if (expectedPrefLine === null)
                arrayOfConfigTxtLine.splice(i, 1);
            else
                arrayOfConfigTxtLine[i] = expectedPrefLine;
        }
    }
    
    if (!isPrefFound)
        arrayOfConfigTxtLine.push(expectedPrefLine);
    
    var new_config_txt = arrayOfConfigTxtLine.join("\n");
    Log.CallStackSettings.EnableStackOnMessage = true;
    Log.Message("Config_txt field content for : " + prefName + "=" + prefValue, new_config_txt);
    Log.CallStackSettings.EnableStackOnMessage = false;
    
    return new_config_txt;
}



/**
    Génère un nouveau champ config_txt selon la pref à mettre à jour
    Pas de changement si la nouvelle valeur est la même que celle existante
*/
function GetNewConfigTxt_old(config_txt, prefName, prefValue)
{
    var isPrefFound = false;
    var expectedPrefLine = (prefValue == undefined)? null: prefName + "=" + prefValue;
    var arrayOfConfigTxtLine = Trim(config_txt).split("\n");
    for (var i in arrayOfConfigTxtLine){
        var currentLine = Trim(arrayOfConfigTxtLine[i]);
        if (currentLine == expectedPrefLine)
            return config_txt;
        
        if (aqString.Find(currentLine, aqString.ToUpper(prefName) + "=") == 0){
            if (expectedPrefLine === null)
                arrayOfConfigTxtLine.splice(i, 1);
            else
                arrayOfConfigTxtLine[i] = expectedPrefLine;
            
            isPrefFound = true;
            break;
        }
    }
    
    if (!isPrefFound) arrayOfConfigTxtLine.push(expectedPrefLine);
    
    var new_config_txt = arrayOfConfigTxtLine.join("\n");
    Log.Message("Config_txt field new content :", new_config_txt);
    
    return new_config_txt;
}



//Ne fonctionne pas lorsque la pref n'existe pas dans Config_txt
function GetSuccPrefValue_old(vServer, prefName, noSucc)
{
    if (noSucc == undefined)
        noSucc = "0";
    
    genericQueryString = 'select substring(convert(varchar(16296), config_txt), charindex(@key + "=", convert(varchar(16296), config_txt)) + char_length(@key) + 1, charindex(char(10), substring(convert(varchar(16296), config_txt), charindex(@key + "=", convert(varchar(16296), config_txt)) + char_length(@key) + 1, 300)) - 1) as prefValue from b_succ where no_succ = @noSucc';
    queryString = aqString.Replace(aqString.Replace(genericQueryString, "@key", '"' + prefName + '"'), "@noSucc", '"' + noSucc + '"');
    
    return Execute_SQLQuery_GetField(queryString, vServer, "prefValue");
}



function Delete_FilterCriterion(description, vServer)
{
    //SELECT     
    var querySelect="SELECT * FROM  B_MSG  where DESCRIPTION='"+description+"'";
    Log.Message(querySelect)
      
    var Qry =ADO.CreateADOQuery()
    Qry.ConnectionString = GetDBAConnectionString(vServer);
      
    Qry.SQL =querySelect; 
    Qry.Open();      
    Qry.First();     
    var id = Qry.FieldByName("MSG_ID").Value;
          
    //DELETE
    var queryDeleteFromB_MSG="DELETE FROM  B_MSG  where DESCRIPTION='"+description+"'";
    Qry.SQL=queryDeleteFromB_MSG;
    Qry.ExecSQL();
           
    //DELETE
    var queryDeleteFromB_Criteria="DELETE FROM b_CRITERIA  where MSG_ID="+id+""
    Qry.SQL=queryDeleteFromB_Criteria;
    Qry.ExecSQL();
    Qry.Close();
}


/**
    Description : Rendre visible le rapport pour le module Titres
    Paramètres :
        - report_name : nom du rapport tel qu'il apparaît dans le champ REPORT_NAME de la table B_REPORT
        - vServer : URL du vserveur
    Résultat : Rapport visible pour le module Titres
*/
function MakeReportVisibleForSecurities(report_name, vServer)
{   
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    
    //UPDATE to set SECUR_VISIBLE To Yes
    var updateQuery = "update b_report set secur_visible = 'Y' where report_name = '" + report_name + "'";
    Log.Message(updateQuery);
    Qry.SQL = updateQuery;
    Qry.ExecSQL();
    
    Qry.Close();
}



/**
    Description : Rendre visible le rapport pour le module Clients
    Paramètres :
        - report_name : nom du rapport tel qu'il apparaît dans le champ REPORT_NAME de la table B_REPORT
        - vServer : URL du vserveur
    Résultat : Rapport visible pour le module Clients
*/
function MakeReportVisibleForClients(report_name, vServer)
{
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    
    //UPDATE to set CLIENT_VISIBLE To Yes
    var updateQuery = "update b_report set client_visible = 'Y' where report_name = '" + report_name + "'";
    Log.Message(updateQuery);
    Qry.SQL = updateQuery;
    Qry.ExecSQL();
    
    Qry.Close();
}



/**
    Description : Rendre visible le rapport pour le module Comptes
    Paramètres :
        - report_name : nom du rapport tel qu'il apparaît dans le champ REPORT_NAME de la table B_REPORT
        - vServer : URL du vserveur
    Résultat : Rapport visible pour le module Comptes
*/
function MakeReportVisibleForAccounts(report_name, vServer)
{    
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    
    //UPDATE to set ACCOUNT_VISIBLE To Yes
    var updateQuery = "update b_report set account_visible = 'Y' where report_name = '" + report_name + "'";
    Log.Message(updateQuery);
    Qry.SQL = updateQuery;
    Qry.ExecSQL();
    
    Qry.Close();
}



/**
    Description : Rendre visible le rapport pour le module Relations
    Paramètres :
        - report_name : nom du rapport tel qu'il apparaît dans le champ REPORT_NAME de la table B_REPORT
        - vServer : URL du vserveur
    Résultat : Rapport visible pour le module Relations
*/
function MakeReportVisibleForRelationships(report_name, vServer)
{    
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString = GetDBAConnectionString(vServer);
    
    //UPDATE to set LINK_VISIBLE To Yes
    var updateQuery = "update b_report set link_visible = 'Y' where report_name = '" + report_name + "'";
    Log.Message(updateQuery);
    Qry.SQL = updateQuery;
    Qry.ExecSQL();
    
    Qry.Close();
}



/**
    Description : Exécuter un fichier de requêtes SQL via la ligne de commande ISQL
                  L'encodage du fichier SQL doit être ANSI
    Paramètres :
        - SQLFilePath : chemin d'accès du fichier de requêtes SQL (L'encodage du fichier SQL doit être ANSI)
        - vServer : URL du vserveur
    Retourne : Output de l'exécution (peut retourner null: par exemple en cas d'échec de validation sommaire du fichier...)
    Auteur : Christophe Paring
*/
function ExecuteSQLFile(SQLFilePath, vServer)
{
    Log.Message("Execute SQL file: " + SQLFilePath + " on vServer: " + vServer);
    return ExecuteSQLFile_ThroughISQL(SQLFilePath, vServer);
}



/**
    Description : Exécuter un fichier de requêtes SQL via la ligne de commande ISQL
                  L'encodage du fichier SQL doit être ANSI
    Paramètres :
        - SQLFilePath : chemin d'accès du fichier de requêtes SQL (L'encodage du fichier SQL doit être ANSI)
        - vServerURL : URL du vserveur
    Retourne : Output de l'exécution (peut retourner null: échec de validation sommaire du fichier...)
    Auteur : Christophe Paring
*/
function ExecuteSQLFile_ThroughISQL(SQLFilePath, vServerURL)
{
    //Validation sommaire du fichier
    if (!aqFileSystem.Exists(SQLFilePath)){
        Log.Error("ExecuteSQLFile_ThroughISQL, SQL file not found: " + SQLFilePath, SQLFilePath);
        return null;
    }
    
    Log.File(SQLFilePath, "ExecuteSQLFile_ThroughISQL, SQL file: " + SQLFilePath + ", on VServer: " + vServerURL);
    var SQLFileContent = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    if (!aqString.StrMatches("^.*\\n+\\b*[Gg][oO]$", Trim(SQLFileContent))){
        Log.Error("Veuillez SVP ajouter une ligne de terminaison 'GO' à la fin du script (ou des requêtes) SQL et/ou supprimer les caractères 'inutiles' (texte en commentaire par exemple) venant après l'instruction 'GO' de la fin, fichier: '" + SQLFilePath + "'.", "Ajouter la ligne 'GO' dans le fichier, même si sans elle le fichier fonctionne correctement via une procédure d'exécution manuelle.");
        return null;
    }
    
    var lastGoIndex = aqString.FindLast(SQLFileContent, "GO", false);
    var arraySQLFileContent = (aqString.SubString(SQLFileContent, 0, lastGoIndex)).split("\n");
    var allowedControlCharsAsciiCodes = [9, 10, 13];
    var notAllowedControlCharsMessages = [];
    for (var lineNumber = 1; lineNumber <= arraySQLFileContent.length; lineNumber++){
        var lineContent = arraySQLFileContent[lineNumber - 1];
        for (var charPosition= 1; charPosition <= lineContent.length; charPosition++){
            var charAsciiCode = lineContent.charCodeAt(charPosition - 1);
            if (charAsciiCode == 127 || (charAsciiCode <= 31 && GetIndexOfItemInArray(allowedControlCharsAsciiCodes, charAsciiCode) == -1)){
                notAllowedControlCharsMessages.push("Caractère de contrôle problématique dans le contenu du fichier, à la ligne " + lineNumber + " et position " + charPosition + ": code ASCII = " + charAsciiCode + ".");
            }
        }
    }
    
    if (notAllowedControlCharsMessages.length > 0){
        Log.Error("Le fichier SQL contient un ou plusieurs caractère(s) de contrôle qui pourrai(en)t en impacter la bonne exécution. Voir la position et le code ASCII décimal de chacun des caractères potentiellement problématiques dans la partie Details et remédier éventuellement au problème.", "Fichier " + SQLFilePath + "\r\n--------------------------------------------------------------------------------------------------------------------------\r\n" + notAllowedControlCharsMessages.join("\r\n"));
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        Log.Message("Si vous êtes persuadé(e) que l'un ou plusieurs des caractères mentionnés au message d'erreur précédent n'est pas problématique pour l'exécution du fichier SQL, SVP merci d'en aviser.", "", pmNormal, logAttributes);
    }
    
    //Fichier Output
    var strISQLOutput = null;
    var ISQLOutputFileName = aqString.Replace(aqFileSystem.GetFileNameWithoutExtension(SQLFilePath), " ", "_") + '_ISQL_output.txt';
    if (aqFileSystem.Exists(ISQLOutputFileName))
        aqFileSystem.DeleteFile(ISQLOutputFileName);
    
    //Il a été constaté que la ligne de commande ISQL échoue lorsque le chemin d'accès comporte plus de 132 caractères
    if (SQLFilePath.length > 132){
        var tempSQLFilePath = Sys.OSInfo.TempDirectory + aqFileSystem.GetFileNameWithoutExtension(SQLFilePath) + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%y%m%d_%H%M%S.") + aqFileSystem.GetFileExtension(SQLFilePath);
        Log.Message("Chemin d'accès trop long: " + SQLFilePath.length + " > 132 caractères. Une copie va en être faite dans le dossier temporaire, pour l'exécution.", "Copie de : \r\n" + SQLFilePath + "\r\n\r\nVers le dossier temporaire : \r\n" + tempSQLFilePath);
        if (tempSQLFilePath.length > 132)
            Log.Warning("Chemin d'accès du fichier temporaire aussi beaucoup trop long: " + tempSQLFilePath.length + " > 132 caractères. Il y a peut être lieu de réduire le nom du fichier.", tempSQLFilePath);
        else {
            aqFile.Delete(tempSQLFilePath);
            if (aqFileSystem.CopyFile(SQLFilePath, tempSQLFilePath, false)){
                Log.Message("Succès de la copie du fichier: " + SQLFilePath, "Succès de la copie de : \r\n" + SQLFilePath + "\r\n\r\nVers : \r\n" + tempSQLFilePath);
                SQLFilePath = tempSQLFilePath;
            }
            else
                Log.Error("Échec de la copie du fichier: " + SQLFilePath, "Échec de la copie de : \r\n" + SQLFilePath + "\r\n\r\nVers : \r\n" + tempSQLFilePath);
        }
    }
    
    //Vérifier que ISQL s'exécute
	try {
		WshShell.Exec("isql -v");
	}
	catch(eISQL){
		Log.Error("Échec de la commande ISQL. Veuillez vérifier que ISQL est bien installé sur la machine. Au besoin, contacter une personne ressource des Tests Auto. (Message d'erreur : " + Trim(eISQL.message) + ")", VarToStr(eISQL.stack));
		Log.Error("Exception: " + eISQL.message, VarToStr(eISQL.stack));
		eISQL = null;
	}
    
    //Exécuter ISQL
    if (projet == "PerformanceNFR" || projet == "Performance"){
        var cmdLineSQL = 'isql -h-1 -S nfrbd -D nfr_syb01 -U qa -P oeillet3 -i "' + SQLFilePath + '" -o ' + ISQLOutputFileName;
        if (client == "CIBC")
            cmdLineSQL = 'isql -h-1 -S nfrbd -D nfr_syb02 -U qa -P oeillet3 -i "' + SQLFilePath + '" -o ' + ISQLOutputFileName;
    }
    else if (projet == "General"){
        var BDNum = aqString.SubString(vServerURL, 19, 2);
        var cmdLineSQL = 'isql -h-1 -S qatestauto1bd -D qa_auto' + BDNum + ' -U qa -P oeillet3 -i "' + SQLFilePath + '" -o ' + ISQLOutputFileName;
    }
    else {
        Log.Error("Valeur '" + projet + "' non supportée pour la variable globale : projet.");
        var cmdLineSQL = "";
    }
    
    Log.Message("Execute command line: " + cmdLineSQL, cmdLineSQL);
    var oExec = WshShell.Exec(cmdLineSQL);
    oExec.StdIn.Close();
    var strOutput = oExec.StdOut.ReadAll();
    var strError = oExec.StdErr.ReadAll();
    
    if (Trim(strError) != "")
        Log.Error("There was an error running this command: " + cmdLineSQL, strError);
    
    var nbOfChecks = 0;
    while (!aqFileSystem.Exists(ISQLOutputFileName) && (++nbOfChecks) <= 3){
        Delay(5000);
    }
    
    if (!aqFileSystem.Exists(ISQLOutputFileName))
        Log.Message("Output file not found by timeout: " + ISQLOutputFileName, ISQLOutputFileName);
    
    strISQLOutput = aqFile.ReadWholeTextFile(ISQLOutputFileName, aqFile.ctANSI);
    if (Trim(VarToStr(strISQLOutput)) != ""){
        var arrISQLOutputLines = strISQLOutput.split("\n");
        for (var i = 0; i < arrISQLOutputLines.length; i++){
            if (aqString.StrMatches("^Msg\\b\\z\,\\b\Level\\b\\z\,\\b\State\\b\\z\:$", Trim(arrISQLOutputLines[i]))){ //Example : "Msg 2812, Level 16, State 5:";
                Log.Warning("Présence éventuelle de message(s) d'erreur(s) d'exécution SQL (voir Output dans la partie Details), fichier exécuté: " + SQLFilePath, strISQLOutput);
                break;
            }
        }
    }
    
    Log.File(ISQLOutputFileName, "Output of SQL execution command: " + cmdLineSQL, strISQLOutput);
    return strISQLOutput;
}



function Delete_Note(commnote, vServer)
{
    //SELECT     
    var querySelect="SELECT * FROM  B_NOTE  where COMMNOTE like '%"+commnote+"%'";
    Log.Message(querySelect)
      
    var Qry =ADO.CreateADOQuery()
    Qry.ConnectionString = GetDBAConnectionString(vServer);
      
    Qry.SQL =querySelect; 
    Qry.Open();      
    Qry.First();     
    var id = Qry.FieldByName("NOTE_ID").Value;
          
    //DELETE
    var queryDeleteFromB_NOTE="DELETE FROM  B_NOTE  where COMMNOTE like'%"+commnote+"%'";
    Qry.SQL=queryDeleteFromB_NOTE;
    Qry.ExecSQL();
    Qry.Close();
}

function Delete_PredefinedSentences(sentence_short, vServer)
{
    //SELECT     select * from b_predef_sentence
    
    var querySelect="SELECT * FROM  B_PREDEF_SENTENCE  where SENTENCE_SHORT ='"+sentence_short+"'";
    Log.Message(querySelect)
      
    var Qry =ADO.CreateADOQuery()
    Qry.ConnectionString = GetDBAConnectionString(vServer);
      
    Qry.SQL =querySelect; 
    Qry.Open();      
    Qry.First();     
    var id = Qry.FieldByName("SENTENCEID").Value;
          
    //DELETE
    var queryDeleteFromB_PREDEF_SENTENCE="DELETE FROM  B_PREDEF_SENTENCE  where SENTENCE_SHORT ='"+sentence_short+"'";
    Qry.SQL=queryDeleteFromB_PREDEF_SENTENCE;
    Qry.ExecSQL();
    
   /*var queryDeleteFromB_PREDEF_SENTENCE_GRD="DELETE FROM  B_PREDEF_SENTENCE_GRP  where CREATIONDATE like'"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%b %d %Y")+"'";
    Qry.SQL=queryDeleteFromB_PREDEF_SENTENCE_GRD;
    Qry.ExecSQL();*/
    Qry.Close();
}

function Delete_PredefinedSentencesGRD( vServer)
{
    //SELECT     select * from b_predef_sentence
    
    var querySelect="SELECT * FROM  B_PREDEF_SENTENCE_GRP  where CREATIONDATE like'%"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%b  %#d %Y")+"%'";
    Log.Message(querySelect)
      
    var Qry =ADO.CreateADOQuery()
    Qry.ConnectionString = GetDBAConnectionString(vServer);
      
    Qry.SQL =querySelect; 
    Qry.Open();      
    Qry.First();     
    var id = Qry.FieldByName("SENTENCEID").Value;
          
    //DELETE
   /* var queryDeleteFromB_PREDEF_SENTENCE="DELETE FROM  B_PREDEF_SENTENCE  where SENTENCE_SHORT like'"+sentence_short+"'";
    Qry.SQL=queryDeleteFromB_PREDEF_SENTENCE;
    Qry.ExecSQL();*/
    
    var queryDeleteFromB_PREDEF_SENTENCE_GRD="DELETE FROM  B_PREDEF_SENTENCE_GRP  where CREATIONDATE like'%"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%b  %#d %Y")+"%'";
    Qry.SQL=queryDeleteFromB_PREDEF_SENTENCE_GRD;
    Qry.ExecSQL();
    Qry.Close();
}


function UpdateDateCreation_Note(commnote,datCreation ,vServer)
{
    //SELECT     
    var querySelect="SELECT * FROM  B_NOTE  where COMMNOTE like '%"+commnote+"%'";
    Log.Message(querySelect)
      
    var Qry =ADO.CreateADOQuery()
    Qry.ConnectionString = GetDBAConnectionString(vServer);
      
    Qry.SQL =querySelect; 
    Qry.Open();      
    Qry.First();     
    var id = Qry.FieldByName("NOTE_ID").Value;
          
    //UPDATE
 
    var queryDeleteFromB_NOTE="UPDATE B_NOTE SET DATE_CREAT ='"+datCreation+"'WHERE COMMNOTE like'%"+commnote+"%'";
    Qry.SQL=queryDeleteFromB_NOTE;
    Qry.ExecSQL();
    Qry.Close();
}

