//USEUNIT Global_variables

var arrayOfActiveTasksHosts = new Array();
var arrayOfHostsProfile = new Array();
var arrayOfLastTasksPerProfile = new Array();

var CSVFolderPath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteDistributedTesting\\CSV_" + VarToStr(client);



function ExecutionsBalancer()
{
    //Create Hosts
    var hostsFilePath = CSVFolderPath + "\\Hosts.csv";
    CreateHostsFromCSVFile(hostsFilePath);
    
    //Initialize the array of active Tasks Hosts
    InitArrayOfActiveTasksHosts();
    
    //Create Tasks
    var tasksFilePath = CSVFolderPath + "\\Tasks.csv";
    var arrayOfJobsTasks = CreateTasksFromCSVFile(tasksFilePath);
    
    //Run Tasks
    RunTasks(arrayOfJobsTasks);
}



function AddNewHost(hostName, hostAddress, hostDomain, hostUsername, hostPassword, hostBasePath, hostLoginMode)
{
    var objHosts = NetworkSuite.Hosts;
    
    //Verify if the host name is already used
    var isHostNameUsed = (objHosts.ItemByName(hostName) != null);
    if (isHostNameUsed){
        Log.Error("Host Name '" + hostName + "' already in use.");
        Runner.Stop();
        return false;
    }
    
    // Creates a new host
    var objNewHost = objHosts.AddNew();
    
    // Specifies the host's parameters
    objNewHost.Name = hostName;
    objNewHost.Address = hostAddress;
    objNewHost.Domain = hostDomain;
    objNewHost.UserName = hostUsername;
    objNewHost.Password = hostPassword;
    
    if (hostBasePath != undefined && Trim(hostBasePath) != "")
        objNewHost.BasePath = hostBasePath;
    
    if (hostLoginMode != undefined && Trim(hostLoginMode) != "")
        objNewHost.LogonMode = hostLoginMode;
    
    // Verifies whether the created host can be used by a network suite
    var isNewHostSuccessfullyCreated = objNewHost.Verify();
    if (isNewHostSuccessfullyCreated)
        Log.Message("Host '" + hostName + "' successfully created.");
    else {
        Log.Error("Host '" + hostName + "' properties aren't valid.");
    }
    
    return isNewHostSuccessfullyCreated;
}



function AddNewJob(jobName)
{
    var objJobs = NetworkSuite.Jobs;
    
    //Verify if the job name is already used
    var isJobNameUsed = (objJobs.ItemByName(jobName) != null);
    if (isJobNameUsed){
        Log.Error("Job Name '" + jobName + "' already in use.");
        return false;
    }
    
    // Creates a new job
    Log.Message("Create new job : " + jobName);
    var objNewJob = objJobs.AddNew();
    
    // Specifies the job's parameter
    objNewJob.Name = jobName;
    
    return true;
}



function AddNewTask(jobName, taskName, hostName, projectPath, remoteApplication, testPath)
{
    var objJobs = NetworkSuite.Jobs;
    
    //Verify if the job name exists
    var objJob = objJobs.ItemByName(jobName);
    if (objJob == null){
        Log.Message("Job Name '" + jobName + "' does not exist!");
        AddNewJob(jobName);
        objJobs = NetworkSuite.Jobs;
        objJob = objJobs.ItemByName(jobName);
        //return false;
    }
    
    //Get the Tasks object
    var objTasks = objJob.Tasks;
    
    //Verify if the task name is already in use
    var isTaskNameUsed = (objTasks.ItemByName(taskName) != null);
    if (isTaskNameUsed){
        Log.Error("Task Name '" + taskName + "' already in use.");
        Runner.Stop();
        return null;
    }
    
    //Get the Hosts object
    var objHosts = NetworkSuite.Hosts;
    
    //Verify if the host name exists
    var objHost = objHosts.ItemByName(hostName);
    if (objHost == null){
        Log.Error("Host Name '" + hostName + "' does not exist!");
        Runner.Stop();
        return null;
    }
    
    //Add New task
    var objNewTask = objTasks.AddNew();
    
    //Specify new task properties
    objNewTask.Name = taskName;
    objNewTask.Host = objHost;
    objNewTask.ProjectPath = projectPath;
    var remoteApplicationCode = (remoteApplication == "TestComplete" || remoteApplication == 0)? ra_TC: ra_TE;
    objNewTask.RemoteApplication = remoteApplicationCode;
    
    if (testPath != undefined)
        objNewTask.Test = testPath;
    
    /* ////
    // Verifies whether the new task is successfully created
    var isNewTaskSuccessfullyCreated = objNewTask.Verify();
    if (isNewTaskSuccessfullyCreated)
        Log.Message("Task '" + taskName + "' successfully created.");
    else
        Log.Error("Task '" + taskName + "' properties aren't valid.");
    */ ////
    //return isNewTaskSuccessfullyCreated;
    return objNewTask;
}



function CreateHostsFromCSVFile(CSVFilePath, delimiterChar)
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
        return;
    }
    
    //Read the CSV file and create hosts
    var Driver = DDT.CSVDriver(CSVFilePath);
    var isAllHostsCreationSucceeded = true;
    var name, address, domain, username, password, basePath, loginMode, toBeUsed, profile;
    while (! Driver.EOF()) {
        toBeUsed = Driver.Value("ToBeUsed");
        
        if (toBeUsed == null || toBeUsed.toUpperCase() == "YES" || toBeUsed.toUpperCase() == "TRUE"){
            name = Driver.Value("Name");
            address = Driver.Value("Address");
            domain = Driver.Value("Domain");
            username = Driver.Value("Username");
            password = Driver.Value("Password");
            basePath = Driver.Value("BasePath");
            loginMode = Driver.Value("LoginMode");
			
			if (AddNewHost(name, address, domain, username, password, basePath, loginMode)){
                profile = Driver.Value("Profile");
			    arrayOfHostsProfile.push([name, profile]);
			}
            else
                isAllHostsCreationSucceeded = false;
            
        }
        
        Driver.Next();
    }
    
    //Close the CSV driver and delete the schema.ini file
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(schemaFilePath);
    
    if (!isAllHostsCreationSucceeded)
        Runner.Stop();
}



function CreateTasksFromCSVFile(CSVFilePath, delimiterChar)
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
    var jobName, taskName, hostName, projectPath, remoteApplication, toBeRun, profile, objTask, arrayOfJobsTasks = new Array();
    var hostToBeUsedIndex = 0;
    
    while (! Driver.EOF()) {
        toBeRun = Driver.Value("ToBeRun");
        
        if (toBeRun == null || toBeRun.toUpperCase() == "YES" || toBeRun.toUpperCase() == "TRUE"){
            jobName = Driver.Value("JobName");
            taskName = Driver.Value("TaskName");
            //hostName = Driver.Value("HostName");
            hostName = arrayOfActiveTasksHosts[hostToBeUsedIndex][1];
            projectPath = Driver.Value("ProjectPath");
            remoteApplication = Driver.Value("RemoteApplication");
            
            objTask = AddNewTask(jobName, taskName, hostName, projectPath, remoteApplication);
            if (objTask != null ){
                profile = Driver.Value("Profile");
                arrayOfJobsTasks.push([jobName, objTask, profile]);
                SetLastTaskForProfile(profile, taskName);
            }
            else {
                isAllTasksCreationSucceeded = false;
                Log.Message("Task '" + taskName + "' creation failed!");
            }
            
            if (hostToBeUsedIndex >= arrayOfActiveTasksHosts.length - 1)
                hostToBeUsedIndex = 0;
            else
                hostToBeUsedIndex ++;
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


function SetLastTaskForProfile(profile, taskName)
{
    for (var i = 0; i < arrayOfLastTasksPerProfile.length; i++){
        if (arrayOfLastTasksPerProfile[i][0] == profile){
            arrayOfLastTasksPerProfile[i][1] = taskName;
            arrayOfLastTasksPerProfile[i][2] = false; //Is last Task for profile reached
            arrayOfLastTasksPerProfile[i][3] = 0; //Next Index of Task to be executed
            return;
        }
    }
    
    arrayOfLastTasksPerProfile.push([profile, taskName, false, 0]);
}


function GetNextIndexOfTaskForProfile(profile)
{
    for (var i = 0; i < arrayOfLastTasksPerProfile.length; i++){
        if (arrayOfLastTasksPerProfile[i][0] == profile)
            return arrayOfLastTasksPerProfile[i][3];
    }
    
    Log.Error("Profile '" + profile + "' not found!");
}



function GetLastTaskForProfile(profile)
{
    for (var i = 0; i < arrayOfLastTasksPerProfile.length; i++){
        if (arrayOfLastTasksPerProfile[i][0] == profile)
            return arrayOfLastTasksPerProfile[i][1];
    }
    
    Log.Error("Profile '" + profile + "' not found!");
}


function SetIsProfileExecutionCompleted(profile)
{
    for (var i = 0; i < arrayOfLastTasksPerProfile.length; i++){
        if (arrayOfLastTasksPerProfile[i][0] == profile){
            arrayOfLastTasksPerProfile[i][2] = true; //Is last Task for profile reached
            return;
        }
    }
    
    Log.Error("Profile '" + profile + "' not found!");
} 


function GetIsProfileExecutionCompleted(profile)
{
    for (var i = 0; i < arrayOfLastTasksPerProfile.length; i++){
        if (arrayOfLastTasksPerProfile[i][0] == profile)
            return arrayOfLastTasksPerProfile[i][2]; //Is last Task for profile reached
    }
    
    Log.Error("Profile '" + profile + "' not found!");
    return false;
} 


function SetProfileToHost(hostName, profile)
{
    for (var i = 0; i < arrayOfHostsProfile.length; i++){
        if (arrayOfHostsProfile[i][0] == hostName){
            arrayOfHostsProfile[i][1] = profile
            break;
        }
    }
    
    for (var i = 0; i < arrayOfActiveTasksHosts.length; i++){
        if (arrayOfActiveTasksHosts[i][1] == hostName){
            arrayOfActiveTasksHosts[i][2] = profile
            break;
        }
    }
}



function RunTasks(arrayOfJobsTasks)
{
    //Create executions Start Time records file
    var executionsStartTimeFilePath = CSVFolderPath + "\\ExecutionsStartTime_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S") + ".csv";
    aqFile.WriteToTextFile(executionsStartTimeFilePath, "TASK_NAME,HOST_NAME,START_TIME", aqFile.ctANSI, true);
    
    //Put together all tasks of each profile
    var arrayOfProfileJobsTasks = new Array();
    for (var j = 0; j < arrayOfLastTasksPerProfile.length; j++){
        var arrayOfCurrentProfileJobsTasks = new Array();
        for (var k = 0; k < arrayOfJobsTasks.length; k++){
            if (arrayOfJobsTasks[k][2] == arrayOfLastTasksPerProfile[j][0])
                arrayOfCurrentProfileJobsTasks.push(arrayOfJobsTasks[k]);
        } 
        
        arrayOfProfileJobsTasks.push(arrayOfCurrentProfileJobsTasks);
    } 
    
    var isSomeTaskRemaining = true;
    while (isSomeTaskRemaining){
        
        //Loop through the tasks of each profile, find an available host and run the task
        for (var j = 0; j < arrayOfProfileJobsTasks.length; j++){
            var currentArrayOfJobsTasks = arrayOfProfileJobsTasks[j];
            
            var varProfile = currentArrayOfJobsTasks[0][2];
            var startIndex = GetNextIndexOfTaskForProfile(varProfile);
        
            for (var i = startIndex; i < currentArrayOfJobsTasks.length; i++){
                var jobName = currentArrayOfJobsTasks[i][0];
                var objTask = currentArrayOfJobsTasks[i][1];
                var profile = currentArrayOfJobsTasks[i][2];
                var taskName = objTask.Name;
                
                var hostName = GetAvailableHost(jobName, profile);
                
                if (hostName == null)
                    break;
                
                //Run task
                objTask.Host = NetworkSuite.Hosts.ItemByName(hostName);
                objTask.Run(false);
                SetHostToTask(taskName, hostName, profile);
                
                //Add record for task in the executions Start Time file
                aqFile.WriteToTextFile(executionsStartTimeFilePath, "\r\n" + taskName + "," + hostName + "," + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S"), aqFile.ctANSI, false);
                
                //Set next Index of Task to be executed for the Profile
                for (var k = 0; k < arrayOfLastTasksPerProfile.length; k++){
                    if (arrayOfLastTasksPerProfile[k][0] == profile){
                        if (arrayOfLastTasksPerProfile[k][3] < currentArrayOfJobsTasks.length - 1)
                            arrayOfLastTasksPerProfile[k][3] = arrayOfLastTasksPerProfile[k][3] + 1; //Next Index of Task to be executed
                        else
                            arrayOfLastTasksPerProfile[k][3] = "End"; //Next Index of Task to be executed
                    }
                }
            
            }
        }
        
        //Verify if all tasks have been executed
        isSomeTaskRemaining = false;
        for (var j = 0; j < arrayOfProfileJobsTasks.length; j++){
            var varArrayOfJobsTasks = arrayOfProfileJobsTasks[j];
            var varProfile = varArrayOfJobsTasks[0][2];
                
            if (GetNextIndexOfTaskForProfile(varProfile) != "End"){
                isSomeTaskRemaining = true;
                break;
            }
        }
        
    }
} 



function GetNetworkSuiteHosts()
{
    var arrayOfHosts = new Array();
    
    // Obtains the number of hosts in the collection
    var nbHosts = NetworkSuite.Hosts.Count;
    
    // Iterates through the host collection
    for (var i = 0; i < nbHosts; i++)
        arrayOfHosts.push(NetworkSuite.Hosts.Items(i));
    
    return arrayOfHosts;
}



//Not used
function GetNetworkSuiteJobs()
{
    var arrayOfJobs = new Array();
    
    // Obtains the number of jobs in the collection
    var nbJobs = NetworkSuite.Jobs.Count;
    
    // Iterates through the jobs collection
    for (var i = 0; i < nbJobs; i++)
        arrayOfJobs.push(NetworkSuite.Jobs.Items(i));
    
    return arrayOfJobs;
}



function GetJobTasks(objJob)
{
    var arrayOfJobTasks = new Array();
    var objTasks = objJob.Tasks;
    
    // Obtains the number of tasks
    var nbTasks = objTasks.Count;
        
    // Iterates through the tasks
    for (var j = 0; j < nbTasks; j++)
        arrayOfJobTasks.push(objTasks.Items(j));
    
    return arrayOfJobTasks;
}



function InitArrayOfActiveTasksHosts()
{
    arrayOfActiveTasksHosts = new Array();
    var arrayOfHosts = GetNetworkSuiteHosts();
    for (var i = 0; i < arrayOfHosts.length; i++){
        var hostName = arrayOfHosts[i].Name;
        
        //Get Host Profile
        for (var i = 0; i < arrayOfHostsProfile.length; i++){
            if (arrayOfHostsProfile[i][0] == hostName){
                var hostProfile = arrayOfHostsProfile[i][1];
                break;
            }
        }
        
        arrayOfActiveTasksHosts.push(["-", hostName, hostProfile]);
    }
} 


function SetHostToTask(taskName, hostName, profile)
{
    for (var i = 0; i < arrayOfActiveTasksHosts.length; i++){
        if (arrayOfActiveTasksHosts[i][1] == hostName){
        
            if (taskName == GetLastTaskForProfile(profile))
                SetIsProfileExecutionCompleted(profile);
            
            arrayOfActiveTasksHosts[i][0] = taskName;
            return;
        } 
    }
    
    Log.Error("Host name '" + hostName + "' not found.");
}



function GetAvailableHost(jobName, profile)
{
    var availableHostName = null;
    
    for (var i = 0; i < arrayOfActiveTasksHosts.length; i++){
            
        var currentTaskName = arrayOfActiveTasksHosts[i][0];
        var currentHostName = arrayOfActiveTasksHosts[i][1];
        var currentHostProfile = arrayOfActiveTasksHosts[i][2];
        
        //Change profile for host if all current profile tasks have been executed
        if (GetIsProfileExecutionCompleted(currentHostProfile)){
            SetProfileToHost(currentHostName, profile);
            currentHostProfile = arrayOfActiveTasksHosts[i][2];
        }
        
        if (currentHostProfile != profile)
            continue;
            
        if (currentTaskName == "-"){
            availableHostName = currentHostName;
            break;
        }
        else {
            var objCurrentTask = NetworkSuite.Jobs.ItemByName(jobName).Tasks.ItemByName(currentTaskName);
            if (objCurrentTask.State == ns_Idle){
                Delay(5000);
                availableHostName = currentHostName;
                break;
            }
        }
    }
    
    if (availableHostName != null)
        Log.Message("Host '" + availableHostName + "' found for profile '" + profile + "'");
        
    return availableHostName;
}