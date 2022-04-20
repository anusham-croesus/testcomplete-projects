


//Ternimate Excel process
function TerminateExcelProcess()
{
    TerminateProcessInExcel("EXCEL");
}

//Close Excel process
function CloseExcelProcess()
{
    TerminateProcessInExcel("EXCEL");
}


//Excel datapool pour récupérer un nom de vserveur qui est sur la ligne [rowNum]
function GetVServerExcel(filePath, sheetName, colNum, rowNum)
{
    var i = 0;
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
  
    // Iterates through records
    while (! Driver.EOF()) {
        i ++;
        if (i == rowNum){
            var serveurName = Driver.Value(colNum); 
            break; 
        }
        Driver.Next();
    }    
    // Closes the driver
    DDT.CloseDriver(Driver.Name);
    return serveurName;  
}
 
 
 
/**
    Description : Excel datapool pour récupérer une donnée qui est sur la ligne [rowNum]
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowNum : numéro de la ligne
        - language : optionnel, "french" ou "english" ; si manquant, la première colonne est considérée
    Résultat : Contenu de la cellule
    Désuet : à supprimer
*/
function GetData(filePath, sheetName, rowNum, language)
{
    var i = 1;
    var colNum = (language == undefined || language == "french")? 0: 1;
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var value;
    
    if (rowNum == 1)
        value = Driver.ColumnName(colNum);
    else
        // Iterates through records
        while (! Driver.EOF()) {
            i++;
            if (i == rowNum){
                value = Driver.Value(colNum);
                break; 
            }
            
            Driver.Next();
        }
    
    // Closes the driver
    DDT.CloseDriver(Driver.Name);
    return VarToStr(value);
}




/**
    Description : Excel datapool pour récupérer une donnée qui est sur la ligne [rowNum]
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowNum : numéro de la ligne
        - language : optionnel, "french" ou "english" ; si manquant, la première colonne est considérée
    Résultat : Contenu de la cellule
*/
function GetData_old(filePath, sheetName, rowNum, language)
{
    CloseExcelProcess();
    var colNum = (language == undefined || language == "french")? 1: 2;
    var excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 30000);
    excel.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();
    var value = VarToStr(excel.Cells.Item(rowNum, colNum));
    excel.Quit();
    CloseExcelProcess();
    return value;
}



/**
    Description : Excel datapool pour récupérer une donnée qui est sur la ligne [rowNum] et à la colonne [colNum]
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowNum : numéro de la ligne
        - colNum : numéro de la colonne
    Résultat : Contenu de la cellule
*/
function ReadDataFromExcel(filePath, sheetName, rowNum, colNum)
{
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 30000);
    Excel.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();
    var value = VarToStr(Excel.Cells.Item(rowNum, colNum));
    Excel.Quit();
    CloseExcelProcess();
    return value
}



/**
    Description: Excel datapool pour écrire une donnée qui est sur la ligne [rowNum] et à la colonne [colNum]
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowNum : numéro de la ligne
        - colNum : numéro de la colonne
    
*/    
function WriteExcelSheet(filePath, sheetName, row, column, data)
{
   
   var app = Sys.OleObject("Excel.Application");
   Sys.WaitProcess("excel", 30000);
   var book = app.Workbooks.Open(filePath);
   
   if (true === ((typeof Symbol === 'function') && (typeof Symbol.toStringTag === 'symbol'))){
       var sheet = book.Sheets.Item(sheetName);
       sheet.Cells.Item(row, column).Value2 = data;
   }
   else {
       var sheet = book.Sheets(sheetName);
       sheet.Cells(row, column) = data;
   }
   
   app.DisplayAlerts = false;
   Log.Message("data write in row " + row);
   book.Save();
   app.Quit();
   CloseExcelProcess();
}




/**
    Description: Excel datapool pour rechercher d'une donnée qui est sur la ligne [rowNum]
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - SoughtForValue : valeur de la recherche
*/   
/*function FindExcelRow(filePath, sheetName, SoughtForValue)
{
    CloseExcelProcess();
            
    var app, rowNum;
    app = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 30000);
    app.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();

    var RowCount = app.ActiveSheet.UsedRange.Rows.Count;
    var ColumnCount = app.ActiveSheet.UsedRange.Columns.Count;
    var isFound = false;
    for (var i = 1; i <= RowCount; i++)
    {
    for (var j = 1; j <= ColumnCount; j++){
        var value = VarToStr(app.Cells.Item(i, j));
        if (value == SoughtForValue)
        {
            rowNum = i;
            isFound = true;
            break;
        }
    }
    if (isFound)
        break;
    }
      
    app.Quit();
    CloseExcelProcess();
       
    if (isFound)
        return rowNum;
    else 
        Log.Error("la valeur de recherche n'existe pas")

}*/

function FindExcelRow(filePath, sheetName, SoughtForValue, displayErrorIfNotFound)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var i=1;
    var rowNum;
    var isFound = false;
    
        // Iterates through records
        while (! Driver.EOF()) {
            i++;
            if (Driver.Value(2)==SoughtForValue){
                rowNum = i;
                isFound = true;
                break; 
            }
            
            Driver.Next();
        }
    
    // Closes the driver
    DDT.CloseDriver(Driver.Name);
    
    if (isFound)
        return rowNum;
    
    if (displayErrorIfNotFound == undefined || displayErrorIfNotFound == true)
        Log.Error("la valeur de recherche n'existe pas");
    
    return null;
}





/**
    Description : Excel datapool pour récupérer une donnée qui est sur la ligne identifiée par rowID (dans la première colonne) 
                  et à la colonne identifiée par columnID (dans la première ligne)
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowID : ID de la ligne
        - columnID : ID de la colonne
    Résultat : Contenu de la cellule
*/
function ReadDataFromExcelByRowIDColumnID_old(filePath, sheetName, rowID, columnID)
{
    //TerminateExcelProcess();
    
    var excel = Sys.OleObject("Excel.Application");  
    Sys.WaitProcess("EXCEL", 30000);
    excel.Workbooks.Open(filePath).Sheets.Item(sheetName).Activate();
    var rowCount = excel.ActiveSheet.UsedRange.Rows.Count;
    var columnCount = excel.ActiveSheet.UsedRange.Columns.Count;
    
    //Trouver La ligne
    var isRowFound = false;
    for (var rowNum = 1; rowNum <= rowCount; rowNum ++){
        if (VarToString(excel.Cells.Item(rowNum, 1)) == rowID){
            isRowFound = true;
            break;
        }
    }
    
    if(!isRowFound)
        Log.Error("Le ID Ligne (" + rowID + ") est introuvable dans la feuille: " + sheetName + " du fichier: " + filePath);  
    
    //Trouver La colonne
    var isColumnFound = false;                 
    for (var columnNum = 1; columnNum <= columnCount; columnNum ++){
        if (VarToString(excel.Cells.Item(1, columnNum)) == columnID){
            isColumnFound = true;
            break;
        }                          
    }
    
    if (!isColumnFound)
        Log.Error("Le ID colonne  (" + columnID + ") est introuvable dans la feuille: " + sheetName + " du fichier: " + filePath);
    
    //Récupérer le contenu de la cellule
    if (isRowFound && isColumnFound)
        var cellValue = VarToString(excel.Cells.Item(rowNum, columnNum));             
    
    excel.Quit();
    TerminateExcelProcess();
    
    return cellValue
}



/**
    Description : Excel datapool pour récupérer une donnée qui est sur la ligne identifiée par rowID (dans la première colonne) 
                  et à la colonne identifiée par columnID (dans la première ligne)
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowID : ID de la ligne
        - columnID : ID de la colonne
    Résultat : Contenu de la cellule
*/
function ReadDataFromExcelByRowIDColumnID(filePath, sheetName, rowID, columnID)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var cellValue;
    
    //Parcourir les lignes pour récupérer le contenu de la cellule cible
    var isRowFound = false;
    while (! Driver.EOF()) {
        if (Driver.Value(0) == rowID){
            cellValue = VarToStr(Driver.Value(columnID));
            isRowFound = true;
            break; 
        }
        
        Driver.Next();
    }
    
    if(!isRowFound)
        Log.Error("ReadDataFromExcelByRowIDColumnID : rowID not found.", "ReadDataFromExcelByRowIDColumnID : Le ID Ligne (" + rowID + ") est introuvable dans la feuille : " + sheetName + " du fichier : " + filePath);
    
    // Fermer the driver
    DDT.CloseDriver(Driver.Name);
    
    return cellValue;
}

/**
    Description : Récupérer la ligne de data par rapport rowID
    Paramètres :
        - filePath : chemin d'accès du fichier Excel
        - sheetName : nom de la feuille Excel
        - rowID : ID de la ligne
    Résultat : Contenu de la cellule
*/
function ReadDataRowArray(filePath, sheetName, rowID)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var columnCount = Driver.ColumnCount;
    var array = [];

    while (! Driver.EOF()) {
        if (Driver.Value(0) == rowID){
            for (var i = 1; i < columnCount; i++){
                array.push(VarToStr(Driver.Value(i)));
            }
        }
        Driver.Next();
    }
    
    // Fermer the driver
    DDT.CloseDriver(Driver.Name);
    
    if (array != null)
        return array;
    else 
        Log.Error(rowID + " n'existe pas");
}



//~same as in Common_functions
function TerminateProcessInExcel(processName)
{
    try {
        Log.Message("Terminate process '" + processName + "'...");
        var timerTerminateProcess = HISUtils.StopWatch;
        var timeTerminateProcess = 0;
        var loopsCount = 0;
        var waitProcessName = ("edge" == aqString.ToLower(Trim(processName)))? "ms" + Trim(processName): processName;
        //var timeoutWaitProcessToClose = (GetIndexOfItemInArray(["iexplore", "chrome"], aqString.ToLower(Trim(waitProcessName))) != -1)? 30000: 15000;
        var timeoutWaitProcessToClose = 15000;
        var timeOutTerminateProcess = (typeof maxWaitTime == 'undefined' || maxWaitTime < 90000)? 90000: maxWaitTime;
        
        do {
            timerTerminateProcess.Start();
            loopsCount++;
            //Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Les instructions dans ce loop donnent déjà le temps au process de se fermer.
            Delay(5000); //Avant d'avoir éventuellement fait une validation précise, il vaut mieux pour le moment conserver ce temps d'attente statique de 5 secondes car il a permis une sensible réduction de messages d'erreurs indésirables.
            Sys.Refresh();
            var processInstance = Sys.WaitProcess(waitProcessName, 300);
            if (processInstance.Exists){
                //If the found process instance instance still exists (because directly elligible for termination or because of previous close command failure), try to Terminate() it
                processInstance.Refresh();
                if (processInstance.Exists){
                    Log.Message("Terminating process '" + waitProcessName + "', execute: Terminate()...");
                    processInstance.Terminate();
                    WaitObjectPropertyExistsToFalse(processInstance, 5000); //Wait some time for the process to actually disappear
                }
            }
            
            timeTerminateProcess = timerTerminateProcess.Stop();
            Delay(100);
        } while (timeTerminateProcess < timeOutTerminateProcess && Sys.WaitProcess(waitProcessName, 300).Exists)
    }
    catch (excTerminateProcess) {
        Log.Warning("Exception from TerminateProcessInExcel('" + processName + "'). " + excTerminateProcess.message, VarToStr(excTerminateProcess.stack), pmNormal, null, Sys.Desktop.Picture());
        excTerminateProcess = null;
    }
    finally {
        timerTerminateProcess.Reset();
        Delay(100);
        if (Sys.WaitProcess(waitProcessName).Exists){
            Log.Warning("Process '" + waitProcessName + "' not terminated by " + timeTerminateProcess + "ms.", "", pmNormal, null, Sys.Desktop.Picture());
        }
        
        if (timeTerminateProcess >= timeOutTerminateProcess){
            Log.Message("TimeOut (" + timeOutTerminateProcess + "ms) reached while terminating process '" + processName + "'.");
            if (loopsCount > 1)
                Log.Message("TerminateProcess: Le loopsCount est de " + loopsCount + " répétitions.");
                
            //Temp, To Be Deleted
            ///*
            var executionComputerName = "ComputerNameUndefined";
            try {executionComputerName = VarToStr(Sys.HostName);} catch (sys_e){executionComputerName = "ComputerNameUndefined"; sys_e = null;}
            SendMail("youlia.raisper@croesus.com;xian.wei@croesus.com", "mail.croesus.com", "TerminateProcess TimeOut", "testauto@croesus.com", aqFileSystem.GetFileNameWithoutExtension(Project.FileName) + " TerminateProcess TimeOut", "Computer = " + executionComputerName + "\r\nProject = " + aqFileSystem.GetFileNameWithoutExtension(Project.FileName) + "\r\n" + timeTerminateProcess + "ms => TimeOut (" + timeOutTerminateProcess + "ms) reached while terminating process '" + processName + "'.\r\nloopsCount = " + loopsCount);
            //*/
        }
        
        Delay(100);
        Sys.Refresh();
    }
    
    
    
    function WaitObjectPropertyExistsToFalse(varObject, waitTimeMax)
    {
        if (waitTimeMax == undefined){
            waitTimeMax  = 15000;
        }
        
        var interChecksDelay = 1000;
        var waitTimeElapsed = 0;
        while (waitTimeElapsed < waitTimeMax && varObject.Exists){
            Delay(interChecksDelay);
            waitTimeElapsed += interChecksDelay;
            varObject.Refresh();
        }
        
        return (!varObject.Exists);
    }
}
