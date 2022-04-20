//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1433
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1433_PSWD_TENTATIVE_COUNT(){
              
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1433","Testlink");
        
        try {
                var userName = "UNI00";
                var psw = "croesus";
                var application = "app";
                var queryString = "select * from b_user where station_id = 'UNI00'"
              
                Activate_Inactivate_Pref("UNI00","PSWD_TENTATIVE_COUNT",0,vServerCR1755);
              
                Login_CR1755Croesus(vServerCR1755,userName,"111111",application,language,browserName);
                Login_CR1755Croesus(vServerCR1755,userName,"111111",application,language,browserName);
              
                if(Execute_SQLQuery_GetField(queryString, vServerCR1755, "PSWD_TENTATIVE_COUNT") == 2){
                    Log.Checkpoint("Après 2 fois Login Erreur, PSWD_TENTATIVE_COUNT égale 2");
                }
              
                Login_CR1755Croesus(vServerCR1755,userName,psw,application,language,browserName);
                Login_CroesusAdvisor(browserName);
              
                if(Execute_SQLQuery_GetField(queryString, vServerCR1755, "PSWD_TENTATIVE_COUNT") == 0){
                    Log.Checkpoint("Après Login succès, PSWD_TENTATIVE_COUNT égale 0");
                }

        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                Terminate_CroesusProcess();
                Terminate_IEProcess();
        }
}
