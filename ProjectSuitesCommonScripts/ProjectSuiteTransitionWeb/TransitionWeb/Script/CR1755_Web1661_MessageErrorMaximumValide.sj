//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1661
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1661_MessageErrorMaximumValide(){

              Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1661","Testlink Web-1661");
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "CLINTB");              
              CR1755_TwoFactorCroesus_Fail(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],browserName);

              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "BUSHGW");              
              CR1755_TwoFactorCroesus_Fail(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],browserName);
              
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "PARIZJ");              
              CR1755_TwoFactorCroesus_Fail(vServerCR1755,arr[0],arr[1],arr[2],arr[3],arr[4],browserName);

}





