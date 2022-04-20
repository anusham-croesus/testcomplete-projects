//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


function TestChris1()
{
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
    
    //Delay(3000);
    Log.Warning("Test Warning 1 ...");
    Log.Error("Test Error 1 ...");
    Log.Message("Test Message ...");
    Log.Error("Test Error 2...");
    Delay(30000);
    Log.Warning("Test Warning 2 ...");
    Delay(30000);
    Log.Warning("Test Warning 3 ...");
    
    Log.Message("Delay 3 hours...");
    Delay(10800000);
    Log.Message("TestChris2...");
    Delay(30000);
    Log.Message("TestChris3...");
    Delay(30000);
    Log.Message("TestChris4...");
    Delay(30000);
    Log.Message("TestChris5...");
    Delay(30000);
    Log.Message("TestChris6...");
}