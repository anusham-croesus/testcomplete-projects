//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1473
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1473_ResetPSW_WebConfigurator(){

              Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1473","Testlink Web-1473");
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "DARWIC");
              CR1755_ResetPSWWebConfig_TwoFactor(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],browserName);
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "DESOUST");
              CR1755_ResetPSWWebConfig_TwoFactor(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],browserName);
            
}