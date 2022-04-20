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

function CR1755_Web1658_ModePer_FlowProfilPass(){
          
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1658","Testlink Web-1658");
        
        try {
              var arr = ReadDataRowArray(filePath_CR1755, "CR1755", "FORTINN");
          
              Login_CR1755Croesus(vServerCR1755,arr[0],arr[1],arr[2],language,browserName);
          
              Delay(2000);
              var PageActif = Sys.Browser(browserName).Page(vServerCR1755 + "*");
              var width = PageActif.Width;
              var Height = PageActif.Height;
              PageActif.Click(width*0.98385, Height*0.0276);
              Delay(2000);
              PageActif.Click(width*0.98677, Height*0.09554);
              Sys.Browser().Page(vServerCR1755 + "*").Wait(); 
          

        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {

                Terminate_IEProcess();
        }
  
}