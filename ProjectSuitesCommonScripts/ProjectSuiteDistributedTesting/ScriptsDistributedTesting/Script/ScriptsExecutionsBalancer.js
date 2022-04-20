//USEUNIT ExecutionsBalancer

var arrayOfBeforeJobsNames = new Array();
var arrayOfAfterJobsNames = new Array();



function ScriptsExecutionsBalancer()
{
    //Create Networksuite Variables
    AddNetworksuiteVariables();
    
    //Create Hosts
    var hostsFilePath = CSVFolderPath + "\\Hosts.csv";
    CreateHostsFromCSVFile(hostsFilePath);
    
    //Initialize the array of active Tasks Hosts
    InitArrayOfActiveTasksHosts();
    
    //Create Tasks
    var tasksFilePath = CSVFolderPath + "\\Tasks.csv";
    var arrayOfJobsTasks = CreateScriptsTasksFromCSVFile(tasksFilePath);
    
    //Run before test on all hosts
    NetworkSuite.WaitForState(ns_Idle);
    Delay(5000);
    for (var p = 0; p < arrayOfBeforeJobsNames.length; p++)
        NetworkSuite.Jobs.ItemByName(arrayOfBeforeJobsNames[p]).Run(true);
    
    //Run Tasks
    NetworkSuite.WaitForState(ns_Idle);
    Delay(5000);
    RunTasks(arrayOfJobsTasks);
    
    //Run After test on all hosts
    NetworkSuite.WaitForState(ns_Idle);
    Delay(5000);
    for (var p = 0; p < arrayOfAfterJobsNames.length; p++)
        NetworkSuite.Jobs.ItemByName(arrayOfAfterJobsNames[p]).Run(true);
    
    //Delete Networksuite Variables
    RemoveNetworksuiteVariables();
    
    //Sauvegarder le log
    var logFolderPath = logRootFolderPath + "DistributedTesting_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S") + "\\";
    Log.SaveResultsAs(logFolderPath, 0, 0);
}



function AddNetworksuiteVariables()
{
    var networksuiteVariablesNames = ["testsToBeRun", "notSpecifiedTests", "projectFolderName"];
    for (var i = 0; i < networksuiteVariablesNames.length; i++){
        if (! NetworkSuite.Variables.VariableExists(networksuiteVariablesNames[i]))
            NetworkSuite.Variables.AddVariable(networksuiteVariablesNames[i], "String");
    } 
}



function RemoveNetworksuiteVariables()
{
    var networksuiteVariablesNames = ["testsToBeRun", "notSpecifiedTests", "projectFolderName"];
    for (var i = 0; i < networksuiteVariablesNames.length; i++){
        if (NetworkSuite.Variables.VariableExists(networksuiteVariablesNames[i]))
            NetworkSuite.Variables.RemoveVariable(networksuiteVariablesNames[i]);
    } 
}



function CreateScriptsTasksFromCSVFile(CSVFilePath, delimiterChar)
{
    //Create schema.ini file
    var CSVFormat, CSVFileName, schemaFilePath;
    
    if (delimiterChar == undefined || delimiterChar.toUpperCase() == "CSV" || delimiterChar == ",")
        CSVFormat = "Format=CSVDelimited";
    else if (delimiterChar.toUpperCase() == "TAB" || delimiterChar == "\t")
        CSVFormat = "Format=TabDelimited";
    else
        CSVFormat = "Format=Delimited(" + delimiterChar + ")";
    
    CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    
    schemaFilePath = CSVFilePath.replace(CSVFileName, "schema.ini");
    schemaFilelines = "[" + CSVFileName + "]";
    schemaFilelines += "\r\n" + CSVFormat;
    schemaFilelines += "\r\n" + "CharacterSet=ANSI";
    schemaFilelines += "\r\n" + "ColNameHeader=True";
    
    if (!aqFile.WriteToTextFile(schemaFilePath, schemaFilelines, aqFile.ctANSI, true)){
        Log.Error("Failed to create file and write text to it : " + schemaFilePath, schemaFilelines);
        Runner.Stop();
    }
    
    //Read the CSV file and create tasks
    var Driver = DDT.CSVDriver(CSVFilePath);
    var isAllTasksCreationSucceeded = true;
    var jobName, taskName, hostName, projectPath, remoteApplication, testPath, toBeRun, profile, objTask, arrayOfJobsTasks = new Array();
    var hostToBeUsedIndex = 0;
    
    while (! Driver.EOF()) {
        //Empty NetworkSuite variables
        NetworkSuite.Variables.testsToBeRun = "";
        NetworkSuite.Variables.notSpecifiedTests = "";
        NetworkSuite.Variables.projectFolderName = "";
    
        toBeRun = Driver.Value("ToBeRun");
        
        if (toBeRun == null || toBeRun.toUpperCase() == "YES" || toBeRun.toUpperCase() == "TRUE"){
            var initTestPath = Driver.Value("InitScript");
            var taskNamePrefix = Driver.Value("TaskName");
            if (initTestPath == null){
                Log.Error("No init script found for task : " + taskNamePrefix);
                return;
            } 
            
            jobName = Driver.Value("JobName");
            hostName = arrayOfActiveTasksHosts[hostToBeUsedIndex][1];
            projectPath = Driver.Value("ProjectPath");
            remoteApplication = Driver.Value("RemoteApplication");
            taskName = taskNamePrefix + "_Init";
            
            objTask = AddNewTask(jobName, taskName, hostName, projectPath, remoteApplication, initTestPath);
            
            if (objTask == null ){
                Log.Error("Task '" + taskName + "' creation failed!");
                Runner.Stop();
            }
            else
                objTask.Run(true);
            
            
            //Before Tests
            var beforeTestPath = Driver.Value("BeforeTests");
            if (beforeTestPath != null){
                var beforeJobName = taskNamePrefix + "_BeforeTests";
                arrayOfBeforeJobsNames.push(beforeJobName);
                for (var j = 0; j < arrayOfActiveTasksHosts.length; j++){
                    hostName = arrayOfActiveTasksHosts[j][1];
                    taskName = taskNamePrefix + "_BeforeTest_On_Host_" + hostName;
                    objTask = AddNewTask(beforeJobName, taskName, hostName, projectPath, remoteApplication, beforeTestPath);
                    if (objTask == null ){
                        isAllTasksCreationSucceeded = false;
                        Log.Error("Task '" + taskName + "' creation failed!");
                    }
                }
            }
            
            
            //After Tests
            var afterTestPath = Driver.Value("AfterTests");
            if (afterTestPath != null){
                var afterJobName = taskNamePrefix + "_AfterTests";
                arrayOfAfterJobsNames.push(afterJobName);
                for (var j = 0; j < arrayOfActiveTasksHosts.length; j++){
                    hostName = arrayOfActiveTasksHosts[j][1];
                    taskName = taskNamePrefix + "_AfterTest_On_Host_" + hostName;
                    objTask = AddNewTask(afterJobName, taskName, hostName, projectPath, remoteApplication, afterTestPath);
                    if (objTask == null ){
                        isAllTasksCreationSucceeded = false;
                        Log.Error("Task '" + taskName + "' creation failed!");
                    }
                }
            }
            
            
            //Get all tests tasks
            arrayOfTestsPaths = GetListOfTestsPaths();////
            for (var i = 0; i < arrayOfTestsPaths.length; i++){
                hostName = arrayOfActiveTasksHosts[hostToBeUsedIndex][1];    
                testPath = arrayOfTestsPaths[i];
                
                aqString.ListSeparator = "\\";
                var scriptName = aqString.GetListItem(testPath, aqString.GetListLength(testPath)-1);
                
                var currentTaskName = taskNamePrefix + "_" + IntToStr(i+1) + "_" + scriptName;
                objTask = AddNewTask(jobName, currentTaskName, hostName, projectPath, remoteApplication, testPath);
                
                if (objTask != null ){
                    profile = Driver.Value("Profile");
                    arrayOfJobsTasks.push([jobName, objTask, profile]);
                    SetLastTaskForProfile(profile, currentTaskName);
                }
                else {
                    isAllTasksCreationSucceeded = false;
                    Log.Error("Task '" + currentTaskName + "' creation failed!");
                }
                
                if (hostToBeUsedIndex >= arrayOfActiveTasksHosts.length - 1)
                    hostToBeUsedIndex = 0;
                else
                    hostToBeUsedIndex ++;
            }
        }
        
        Driver.Next();
    }
    
    //Close the CSV driver and delete the schema.ini file
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(schemaFilePath);
    
    if (!isAllTasksCreationSucceeded)
        Runner.Stop();
    
    return arrayOfJobsTasks;
}



function GetListOfTestsPaths()
{
    var arrayOfTestsPaths = new Array();
    var slaveProjectFolderName = NetworkSuite.Variables.projectFolderName;
    var strListOfTests = NetworkSuite.Variables.testsToBeRun;
    var arrayListOfTests = strListOfTests.split(",");
    for (var i = 0; i < arrayListOfTests.length; i++){
        var testPath = arrayListOfTests[i];
        testPath = slaveProjectFolderName + "\\" + testPath.replace(" - ", "\\");
        arrayOfTestsPaths.push(testPath);
        //Log.Message(testPath);
    }
    return arrayOfTestsPaths;
}