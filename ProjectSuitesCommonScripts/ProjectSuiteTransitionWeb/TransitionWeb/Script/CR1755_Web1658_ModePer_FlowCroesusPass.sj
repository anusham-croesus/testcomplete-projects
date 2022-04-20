//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1658
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1658_ModePer_FlowCroesusPass(){
          
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1658","Testlink Web-1658");
        
        try {
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "LEVESR");
          
              Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],language,browserName);
          
              Login_CroesusAdvisor(browserName);
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                Terminate_CroesusProcess();
                Terminate_IEProcess();
        }
  
}