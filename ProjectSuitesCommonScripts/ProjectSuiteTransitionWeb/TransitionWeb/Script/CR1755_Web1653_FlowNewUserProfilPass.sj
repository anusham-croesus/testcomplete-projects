//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1653
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1653_FlowNewUserProfilPass(){
          
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1653","Testlink Web-1653");
            var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "PROFL");
            CR1755_NewUserCroesus_Passe(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],VarToInt(arr[6]),arr[7],arr[8],browserName);
  
}