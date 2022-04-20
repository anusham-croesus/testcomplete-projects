//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
    Log.Message("Is project language JavaScript? " + isJavaScript());
    
    var pipelineStartIndicatorFile = aqFileSystem.IncludeTrailingBackSlash(ProjectSuite.Path) + "PIPELINE\\PIPELINE_STARTED.txt";
    if (aqFileSystem.Exists(pipelineStartIndicatorFile)){
        ParseProjectSuite();
        aqFileSystem.DeleteFile(pipelineStartIndicatorFile);
        return;
    }
    
    DisableDoubleAuthentication(vServerSleeves, false);
    RestartServicesAndCheckVServer(vServerSleeves); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerSleeves, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
    
    //Supprimer le dossier Backup des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_BACKUP_FOLDER_PATH)){
        if (!aqFileSystem.DeleteFolder(REPORTS_FILES_BACKUP_FOLDER_PATH, true))
            Log.Error("Error while deleting the folder: " + REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    
    //Supprimer le dossier Local des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_FOLDER_PATH)){ 
        if (!aqFileSystem.DeleteFolder(REPORTS_FILES_FOLDER_PATH, true))
            Log.Error("Error while deleting the folder: " + REPORTS_FILES_FOLDER_PATH);
    }
}




function ParseProjectSuite()
{
    try {
        var pipelineFolderPath = aqFileSystem.IncludeTrailingBackSlash(ProjectSuite.Path) + "PIPELINE\\";
        if (!aqFileSystem.CreateFolder(pipelineFolderPath))
            Log.Message("Error with aqFileSystem.CreateFolder() : " + pipelineFolderPath, pipelineFolderPath);
        
        var projectsListFilePath = pipelineFolderPath + "ProjectsList.csv";
        var arrayOfEnabledProjects = GetListOfEnabledProjects();
    
        var arrayOfEnabledProjectsNames = [];
        for (var projectName in arrayOfEnabledProjects)
            arrayOfEnabledProjectsNames.push(projectName);
        var fileContent = "Projects," + arrayOfEnabledProjectsNames.join("|");
        if (!aqFile.WriteToTextFile(projectsListFilePath, fileContent, aqFile.ctUTF8, true))
            Log.Error("Error with aqFile.WriteToTextFile() : " + projectsListFilePath, fileContent);
        
        for (var projectName in arrayOfEnabledProjects){
            var arrayOfProjectEnabledUnits = GetListOfProjectEnabledUnits(arrayOfEnabledProjects[projectName]);
            SaveProjectEnabledUnits(arrayOfProjectEnabledUnits, projectName);
        }
    }
    catch (e_ParseProjectSuite){
        Log.Error("Exception in ParseProjectSuite : " + e_ParseProjectSuite.message, VarToStr(e_ParseProjectSuite.stack));
        e_ParseProjectSuite = null;
    }
}



function SaveProjectEnabledUnits(arrayOfProjectEnabledUnits, projectName)
{
    var pipelineFolderPath = aqFileSystem.IncludeTrailingBackSlash(ProjectSuite.Path) + "PIPELINE\\";
    if (!aqFileSystem.CreateFolder(pipelineFolderPath))
        Log.Error("Error with aqFileSystem.CreateFolder() : " + pipelineFolderPath, pipelineFolderPath);
        
    var projectUnitsFilePath = pipelineFolderPath + projectName + ".csv";
    
    var preExecutionIdentifiers = ["PreExecution", "Preparation"];
    var postExecutionIdentifiers = ["ExecutionLog", "Restore"];
    var arrayOfPreExecutionUnits = [];
    var arrayOfTestUnits = [];
    var arrayOfPostExecutionUnits = [];
    for (var i = 0; i < arrayOfProjectEnabledUnits.length; i++){
        var unitName = arrayOfProjectEnabledUnits[i];
        var isPreExecution = false;
        var isPostExecution = false;
        for (var j = 0; j < preExecutionIdentifiers.length; j++){
            if (aqString.Find(unitName, preExecutionIdentifiers[j], 0, false) != -1){
                arrayOfPreExecutionUnits.push(unitName);
                isPreExecution = true;
                break;
            }
        }
        
        if (!isPreExecution){
            for (var j = 0; j < postExecutionIdentifiers.length; j++){
                if (aqString.Find(unitName, postExecutionIdentifiers[j], 0, false) != -1){
                    arrayOfPostExecutionUnits.push(unitName);
                    isPostExecution = true;
                    break;
                }
            }
        }
        
        if (!isPreExecution && !isPostExecution)
            arrayOfTestUnits.push(unitName);
    }
    
    var preExecutionString = "PreExecutionUnits," + arrayOfPreExecutionUnits.join("|");
    var postExecutionString = "PostExecutionUnits," + arrayOfPostExecutionUnits.join("|");
    var TestUnitsString = "TestUnits," + arrayOfTestUnits.join("|");
    var fileContent = preExecutionString + "\r\n" + TestUnitsString + "\r\n" + postExecutionString;
    if (!aqFile.WriteToTextFile(projectUnitsFilePath, fileContent, aqFile.ctUTF8, true))
        Log.Error("Error with aqFile.WriteToTextFile() : " + projectUnitsFilePath, fileContent);
}


function GetListOfEnabledProjects()
{
    var arrayOfEnabledProjects = new Array();
    var projectSuiteItems = ProjectSuite.TestItems;
    for (var i = 0; i < projectSuiteItems.ItemCount; i++)
        if (projectSuiteItems.TestItem(i).Enabled)
            arrayOfEnabledProjects[VarToStr(projectSuiteItems.TestItem(i).ProjectName)] = VarToStr(projectSuiteItems.TestItem(i).ProjectLocation);
    
    return arrayOfEnabledProjects;
}



function GetListOfProjectEnabledUnits(projectFilePath)
{
    var xmlRelevantKeys = {name: "name", group: "group", enabled: "enabled", testMoniker: "testMoniker"};
    
    if (!aqFileSystem.Exists(projectFilePath)){
        Log.Error("Le fichier n'a pas été trouvé : " + projectFilePath);
        return null;
    }
    
    var projectName = aqFileSystem.GetFileNameWithoutExtension(projectFilePath);
    
    //var Doc = Sys.OleObject("Msxml2.DOMDocument.4.0");
    var xmlDoc = Sys.OleObject("Msxml2.DOMDocument.6.0");
    xmlDoc.async = false;
    xmlDoc.load(projectFilePath);
    
    if (xmlDoc.parseError.errorCode == 0){
        var arrayOfProjectItems = ProcessProjectNode(xmlDoc.documentElement, xmlRelevantKeys);
        var arrayOfEnabledTests = [];
        for (var i = 0; i < arrayOfProjectItems.testMoniker.length; i++)
            if (aqString.ToUpper(arrayOfProjectItems.group[i]) == "FALSE" && aqString.ToUpper(arrayOfProjectItems.enabled[i]) == "TRUE")
                arrayOfEnabledTests.push(arrayOfProjectItems.testMoniker[i].split("}")[1]);
        
        return arrayOfEnabledTests;
    }
    else {
        var errorInfo = "Reason:\t" + xmlDoc.parseError.reason + "\n" +
        "Line:\t" + aqConvert.VarToStr(xmlDoc.parseError.line) + "\n" + 
        "Pos:\t" + aqConvert.VarToStr(xmlDoc.parseError.linePos) + "\n" + 
        "Source:\t" + xmlDoc.parseError.srcText;
        Log.Error("Il a été impossible de parser le fichier : " + projectFilePath, errorInfo);
        return null;
    }
    
    
    //Inner function : Pour le traitement récursif des noeuds du fichier XML
    function ProcessProjectNode(XMLNode, xmlRelevantKeys, xmlMapObject)
    {
        if (xmlMapObject == undefined)
            xmlMapObject = {name: [], group: [], enabled: [], testMoniker: []}
    
        //Exclure les lignes de commentaires
        if (XMLNode.nodeName.charAt(0) != "\#"){
            var nodeAttributes = XMLNode.attributes;
        
            //Si toutes les clés pertinentes ont été trouvées, alors enregistrer la valeur du nom (name) et celle du chemin d'accès (path)
            var xmlMapObjectName = null, xmlMapObjectGroup = null, xmlMapObjectEnabled = null, xmlMapObjectTestMoniker = null;
            for (var i = 0; i < nodeAttributes.length; i++){
                var nodeAttributeItem = nodeAttributes.item(i);
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.name)
                    xmlMapObjectName = nodeAttributeItem.nodeValue;
            
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.group)
                    xmlMapObjectGroup = nodeAttributeItem.nodeValue;
                    
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.enabled)
                    xmlMapObjectEnabled = nodeAttributeItem.nodeValue;
                    
                if (nodeAttributeItem.nodeName == xmlRelevantKeys.testMoniker)
                    xmlMapObjectTestMoniker = nodeAttributeItem.nodeValue;
            }
            
            if (xmlMapObjectName !== null && xmlMapObjectGroup !== null && xmlMapObjectEnabled !== null && xmlMapObjectTestMoniker !== null){
                xmlMapObject.name[xmlMapObject.name.length] = xmlMapObjectName;
                xmlMapObject.group[xmlMapObject.group.length] = xmlMapObjectGroup;
                xmlMapObject.enabled[xmlMapObject.enabled.length] = xmlMapObjectEnabled;
                xmlMapObject.testMoniker[xmlMapObject.testMoniker.length] = xmlMapObjectTestMoniker;
            }
        }
    
        // Obtenir les noeuds enfants et faire le même traitement de façon récursive
        var XMLChildNodes = XMLNode.childNodes;
        for(var i = 0; i < XMLChildNodes.length; i++)
            xmlMapObject = ProcessProjectNode(XMLChildNodes.item(i), xmlRelevantKeys, xmlMapObject); 
    
        return xmlMapObject;
    }
}
