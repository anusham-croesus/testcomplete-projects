//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1628
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1628_FlowTwoFactorProfilPass(){
          
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1628","Testlink Web-1628");
          var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "DALTOJ");     
          CR1755_TwoFactorCroesus_Pass(vServerCR1755,arr[0],arr[1],arr[2],arr[3],language,browserName);
  
}