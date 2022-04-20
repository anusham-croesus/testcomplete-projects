//USEUNIT Global_variables

/*
//Activer/Désactiver un pref
function Activate_Inactivate_Pref(stationID, key, value, vServer)
{
    var subString= aqString.SubString(vServer,9, 2)
    var Proc=ADO.CreateADOStoredProc();
    Proc.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_syb"+subString+""
    //name of procedure
    Proc.ProcedureName="dbo.spUserConfig"
    //Proc.Parameters.
    Proc.Parameters.CreateParameter("@stationId",ftFixedChar,adParamInput,8,stationID);
    Proc.Parameters.CreateParameter("@key",ftFixedChar,adParamInput,60,key);
    Proc.Parameters.CreateParameter("@value",ftFixedChar,adParamInput,300,value);
    //execution
    Proc.ExecProc();
}
*/

//Activer/Désactiver un pref Branch Level 
function Activate_Inactivate_PrefBranch(noSucc,key,value,vServer)
{
    if (client == "qaref"){
            var subString= aqConvert.StrToInt(aqString.SubString(vServer,9,2))-30+30;    //changement de 9 a 19 
            var Proc=ADO.CreateADOStoredProc();
            Proc.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_syb"+subString+""  ;  //changement de qa_syb a qa_auto
            //name of procedure
            Proc.ProcedureName="dbo.spBranchConfig"
            //Proc.Parameters.
            Proc.Parameters.CreateParameter("@noSucc",ftFixedChar,adParamInput,10,noSucc);
            Proc.Parameters.CreateParameter("@key",ftFixedChar,adParamInput,60,key);
            Proc.Parameters.CreateParameter("@value",ftFixedChar,adParamInput,300,value);
            //execution
            Proc.ExecProc();
    } else {
            var subString= aqString.SubString(vServer, 19, 2);    //changement de 9 a 19 
            var Proc=ADO.CreateADOStoredProc();
            Proc.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto"+subString+""  ;  //changement de qa_syb a qa_auto
            //name of procedure
            Proc.ProcedureName="dbo.spBranchConfig"
            //Proc.Parameters.
            Proc.Parameters.CreateParameter("@noSucc",ftFixedChar,adParamInput,10,noSucc);
            Proc.Parameters.CreateParameter("@key",ftFixedChar,adParamInput,60,key);
            Proc.Parameters.CreateParameter("@value",ftFixedChar,adParamInput,300,value);
            //execution
            Proc.ExecProc();
    }

}

  //Activer/Désactiver un pref Firm Level-----------------------------------
 function Activate_Inactivate_PrefFirm_New(firmID, key, value, vServer)
{
  var query = "declare @firmID numeric(10) declare @key varchar(60) declare @value varchar(300) " + 
              "select @firmID = " + firmID + " select @key = '" + key + "' select @value = '" + value + "' " + 
  "update b_firm set config_txt = \r\n\r\n" +
	
	"case when patindex('%'+@key+'=%', config_txt) > 0 then\r\n" +
	"str_replace(convert(varchar(16296), config_txt),\r\n" +
	"substring(convert(varchar(16296), config_txt), 	patindex('%'+@key+'=%', config_txt), \r\n" +
	"coalesce(nullif(patindex('%'+char(10)+'%', substring(convert(varchar(16296), config_txt), patindex('%'+@key+'=%', config_txt), 500)), 0), char_length(substring(convert(varchar(16296), config_txt), patindex('%'+@key+'=%', config_txt), 500)) + 1 ) - 1),\r\n" +
	"@key+'='+@value)\r\n\r\n" +
  
	"else\r\n" +
	"convert(varchar(16296), config_txt) + case when right(convert(varchar(16296), config_txt), 1) = char(10) then '' else char(10) end + @key+'='+@value+char(10)\r\n" +
	"end\r\n" +
	"from b_firm \r\n" +
	"where firm_id = @firmID\r\n";
  Execute_SQLQuery(query, vServer);
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
        if (client == "qaref"){
            var subString= aqConvert.StrToInt(aqString.SubString(vServer,9,2))-30+30;    //changement de 9 a 19 
            var query= queryString;
	  
            var Qry =ADO.CreateADOQuery()
            Qry.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_syb"+subString+"" ;  //changement de qa_syb a qa_auto
	  
            Qry.SQL=query;
            Qry.ExecSQL();
        } else {
            var subString= aqString.SubString(vServer, 19, 2);    //changement de 9 a 19 
            var query= queryString;
	  
            var Qry =ADO.CreateADOQuery()
            Qry.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto"+subString+"" ;  //changement de qa_syb a qa_auto
	  
            Qry.SQL=query;
            Qry.ExecSQL();
        }
}

function Execute_SQLQuery_GetField(queryString, vServer, fieldName)
{
    if (client == "qaref"){
        var subString = aqConvert.StrToInt(aqString.SubString(vServer,9,2))-30+30;
        var query = queryString;
	  
        var Qry = ADO.CreateADOQuery();
        Qry.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_syb" + subString + "";
	  
        Qry.SQL=query;
        Qry.Open();
        Qry.First();
        var value = Qry.FieldByName(fieldName).Value;
        Qry.Close();
    
        return value;
    } else {
        var subString = aqString.SubString(vServer, 19, 2);
        var query = queryString;
	  
        var Qry = ADO.CreateADOQuery();
        Qry.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + subString + "";
	  
        Qry.SQL=query;
        Qry.Open();
        Qry.First();
        var value = Qry.FieldByName(fieldName).Value;
        Qry.Close();
    
        return value;        
    }
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

/**
    Description : Exécuter un fichier de requêtes SQL
    Paramètres :
        - SQLFilePath : chemin d'accès du fichier de requêtes SQL
        - vServer : URL du vserveur
    Résultat : Requêtes SQL exécutées
*/
function ExecuteSQLFile(SQLFilePath, vServer)
{
    Log.Message("Execute SQL file : " + SQLFilePath + " on vServer : " + vServer);
    
    try {
        
        if (client == "qaref"){
            var vServerNum = aqConvert.StrToInt(aqString.SubString(vServer,9,2))-30+30;    //changement de 9 a 19 
        
            var Qry = ADO.CreateADOQuery();
            Qry.ConnectionString = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_syb" + vServerNum ; //changement de qa_syb a qa_auto
        } else {
            var vServerNum = aqString.SubString(vServer,19,2);    //changement de 9 a 19 
        
            var Qry = ADO.CreateADOQuery();
            Qry.ConnectionString = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + vServerNum ; //changement de qa_syb a qa_auto
        }
        // Opens the specified file for reading
        var SQLFile = aqFile.OpenTextFile(SQLFilePath, aqFile.faRead, aqFile.ctANSI);

        // Reads text lines from the file, posts them to the test log and execute them
        while(! SQLFile.IsEndOfFile()){
            lineSQL = SQLFile.ReadLine();
            Log.Message(lineSQL);
            if (Trim(VarToStr(lineSQL)) != ""){
                Qry.SQL = lineSQL;
                Qry.ExecSQL();
            }
        }

        // Closes the file and the SQL connexion
        SQLFile.Close();
        Qry.Close();
    }
    catch (e){
        Log.Error("Exception ! " + e.message);
    }
}
