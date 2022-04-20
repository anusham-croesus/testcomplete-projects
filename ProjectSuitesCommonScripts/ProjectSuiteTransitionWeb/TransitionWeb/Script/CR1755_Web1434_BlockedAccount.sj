//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1434
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1434_BlockedAccount(){

            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1434","Testlink");
            
            try {

                        var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "MCDOJO");
              
                        Execute_SQLQuery("update B_USER set RECOVERY_EMAIL_CONFIRMED = 'Y' where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set RECOVERY_EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com' where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com' where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set VALIDATION_CODE_COUNT = 0 where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set HASH = null where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set SALT = null where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set HASH_VERSION = 0 where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set LAST_PSWD_CHNGE = null where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set VALIDATION_KEY = null where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set VALIDATION_CODE_EXPIRATION = null where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set PSWD_TENTATIVE_COUNT = 0 where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set PSWD_REINIT = 0 where station_id = " + "'" + arr[0] + "'", vServerCR1755);
                        Execute_SQLQuery("update B_USER set BLOCKING_TYPE='' where station_id = " + "'" + arr[0] + "'", vServerCR1755);

                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWError(arr[3]);
              
                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWError(arr[3]);
              
                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWErrorMaximum(arr[3]);
              
                        var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "MCDOJO1");
                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWErrorMaximum(arr[3]);
              
                        var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "MCDOJO2");
                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWErrorMaximum(arr[3]);
              
                        var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "MCDOJO3");
                        Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],arr[3],browserName);
                        check_PageLogin_PSWErrorMaximum(arr[3]);
              
                }
                catch(e) {
                        Log.Error("Exception: " + e.message, VarToStr(e.stack));
                }
                finally {
                        Terminate_CroesusProcess();
                        Terminate_IEProcess();
                }

}