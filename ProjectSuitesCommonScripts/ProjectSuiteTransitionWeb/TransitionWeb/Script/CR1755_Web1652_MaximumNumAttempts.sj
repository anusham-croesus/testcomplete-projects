//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1652
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1661_MessageErrorMaximumValide(){

              Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1652","Testlink Web-1652");
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "TRUDPE"); 
              CR1755_LoginFail_MaximumAttempts(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);            

              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "MONETC");              
              CR1755_LoginFail_MaximumAttempts(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "LOTHC");              
              CR1755_LoginFail_MaximumAttempts(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);

}

