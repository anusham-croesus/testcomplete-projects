//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions



/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-
    Analyste d'assurance qualité : 
    Analyste d'automatisation : 
*/

function test(){
  
         Login_CR1755Croesus(vServerCR1755,"DALTOJ","croesus","profil",language,browserName);  
         var PageActif = Sys.Browser(browserName).Page("*");
         var URL = PageActif.URL;
         Log.Message(URL); 
         
         PageActif.ToUrl(URL + polymer);
         
         PageActif.QuerySelector("#passwordButton").Click();
                                     
}


function CR1755_LoginWebConfigError(vServer,userName,psw,application,language,browserName){

      try {
            
            Login_CR1755Croesus(vServer,userName,psw,application,language,browserName);
                    
            check_PageLogin_Error(language);

      }
      catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
      Terminate_IEProcess();
      } 

}


function CR1755_ResetPSWWebConfig_TwoFactor(vServer,userName,psw,application,station_id,email,language,browserName)
{
        try {

              DeleteAllGmail(gmailUrl,browserName);
              
              ResetPSW_User(vServer, userName, psw, station_id, email, language,browserName);
              
              Login_Gmail(gmailUrl,browserName);
              
              var codeActive = GetCodeResetFromGmail(language,browserName);

              Login_CR1755Croesus(vServer,station_id,codeActive,application,language,browserName);
              
              ModifierPSW(vServerCR1755,ReadDataRowArray(filePath_CR1755, "CR1755", "NEWPSW"));
              
              TwoFactorAuthentication(vServer,application,email,language,browserName);
              
              TwoFactorAuthentication_Pass(vServer,application,browserName)
          
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                Terminate_CroesusProcess();
                Terminate_IEProcess();
        }
}


function CR1755_NewUserCroesus_Passe(vServerCR1755,userName,psw,application,firstName,lastName,email,level,station_id,language,browserName)
{
    try {
                
            DeleteAllGmail(gmailUrl,browserName);
            
            CreateNewUser_WebConfiguator(vServerCR1755,userName,psw,firstName,lastName,email,level,station_id,language,browserName);
            
            Login_Gmail(gmailUrl,browserName);
            
            var codeActive = GetCodeTemporaryFromGmail(language,browserName);
            
            Login_CR1755Croesus(vServerCR1755,station_id,codeActive,application,language,browserName);
            
            ModifierPSW(vServerCR1755,ReadDataRowArray(filePath_CR1755, "CR1755", "NEWPSW"));
            
            TwoFactorAuthentication(vServerCR1755,application,email,language,browserName);
            
            TwoFactorAuthentication_Pass(vServerCR1755,application,browserName)
    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            Terminate_CroesusProcess();
            Terminate_IEProcess();
    }
}


function CR1755_TwoFactorCroesus_Pass(vServer,userName,psw,application,email,language,browserName)
{
    try {
            DeleteAllGmail(gmailUrl,browserName);
            
            Login_CR1755Croesus(vServer, userName, psw, application, language,browserName);
            
            TwoFactorAuthentication(vServerCR1755,application,email,language,browserName);
            
            TwoFactorAuthentication_Pass(vServerCR1755,application,browserName)

    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		    //Fermer le processus Croesus  
        Terminate_CroesusProcess();
        Terminate_IEProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}   

    
function CR1755_TwoFactorCroesus_Fail(vServer,userName,psw,application,email,language,browserName)
{
    try {

            Login_CR1755Croesus(vServer,userName,psw,application,language,browserName);

            Sys.Browser().Page(vServer + "*").Wait();
        
            var PageActif = Sys.Browser(browserName).Page(vServer + "*");
            var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);

            check_PageConfirmation(language);
            //loginForm.HoverMouse(90, 320);
            loginForm.Click(100, 320);
        
            //Attendre la page Modification
            Sys.Browser().Page(vServer + "*").Wait();
            WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
            check_PageModification(language);
        
            //Remplir l'adresse courriel
            loginForm.Click(10, 10);
            Delay(1000);
            loginForm.Keys("[Tab]^a[Del]" + email + "[Tab]");
            Delay(1000);
            loginForm.Keys(email);
            loginForm.Keys("[Enter]");
            
            //Attendre la page vérification
            Sys.Browser().Page(vServer + "*").Wait();
            WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
            check_PageVerification(language);
            
            //Remplir le code
            for(var i=0; i<10; i++){
            
                loginForm.Click(10, 10);
                loginForm.Keys("[Tab]^a[Del]" + "1000000"); 
                loginForm.Keys("[Enter]");
                Sys.Browser().Page(vServer + "*").Wait();
                WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
                
                if (i==9){
                  check_PageVerification_CodeMaximum(language);
                }else{
                   check_PageVerification_CodeError(language);
                }
                loginForm.Click(10, 10);
                loginForm.Keys("[Tab][Tab][Enter]"); 
                Sys.Browser().Page(vServer + "*").Wait();
                WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
            }     
            
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		    //Fermer le processus Croesus  
        Terminate_CroesusProcess();
        Terminate_IEProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}    


function CR1755_LoginFail_MaximumAttempts(vServer,userName,psw,application,language,browserName)
{
    try {
    
            //Close browser and Croesus App
            CloseBrowser(browserName);
            Terminate_CroesusProcess();
    
            //Launch the specified browser and opens the specified URL in it.
            if (application == "app"){
                Browsers.Item(browserName).Run(vServer);
            } else if(application == "web"){
                Browsers.Item(browserName).Run(vServer + "WebConfigurator");
            } else if (application == "profil"){
                Browsers.Item(browserName).Run(vServer + "Profile/Login");
            }
            //Wait until the browser loads the page and is ready to accept user input.
            Sys.Browser().Page(vServer + "*").Wait();
            Sys.Browser().BrowserWindow(0).Maximize();
            var PageActif = Sys.Browser().Page(vServer + "*");
            
            var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
    
            //Change Language if needed
            var languageString = 'language="' + aqString.SubString(language, 0, 2) + '-';
            if (aqString.Find(VarToStr(loginForm.innerHTML), languageString) == -1){
                loginForm.Click(10, 10);
                loginForm.Keys("[Tab][Tab][Tab][Tab][Tab]");
                loginForm.Keys("[Enter]");
                loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            }
    
            for (var i=0; i<3;i++){
                //Fill Login form
                loginForm.Click(10, 10);
                Delay(2000);
                loginForm.Keys("[Tab]^a[Del]" + userName + "[Tab]");
                Delay(2500);
                loginForm.Keys(psw);
                Delay(2000);
                loginForm.Keys("[Enter]");
                Sys.Browser().Page(vServer + "*").Wait();
                
                if (i==2){
                  check_PageLogin_PSWErrorMaximum(language)
                }else{
                  check_PageLogin_PSWError(language);
                }
            }  
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		    //Fermer le processus Croesus  
        Terminate_CroesusProcess();
        Terminate_IEProcess();
    }  

}
      


