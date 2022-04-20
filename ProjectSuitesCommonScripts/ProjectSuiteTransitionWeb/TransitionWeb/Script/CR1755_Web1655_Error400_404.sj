//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT WebConfigurator_Get_functions
//USEUNIT CR1755_TwoFactorAuthentication

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1655
    Analyste d'assurance qualité : Manel Rouina
    Analyste d'automatisation : Xian Wei
*/

function CR1755_Web1655_Error400_404(){
          
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Web&item=testcase&id=Web-1655","Testlink Web-1655");
        
        
        try {
                CloseBrowser(browserName);
                
                Browsers.Item(browserName).Run(vServerCR1755 + "Profile/Login");
                Sys.Browser(browserName).BrowserWindow(0).Maximize();
                //Wait until the browser loads the page and is ready to accept user input.
                Sys.Browser().Page(vServerCR1755 + "*").Wait();
                var PageActif = Sys.Browser(browserName).Page("*");
                
                //Change Language if needed
                var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
                var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
                var languageString = 'language="' + aqString.SubString(language, 0, 2) + '-';
                if (aqString.Find(VarToStr(loginForm.innerHTML), languageString) == -1){
                    loginForm.Click(10, 10);
                    loginForm.Keys("[Tab][Tab][Tab][Tab][Tab]");
                    loginForm.Keys("[Enter]");
                    loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
                }
                
                var URL = PageActif.URL;
                Log.Message(URL);
                
                var errorUrl =  aqString.Remove(URL, 96, 2);
                Log.Message(errorUrl);
                
                PageActif.ToUrl(errorUrl);
                //Wait until the browser loads the page and is ready to accept user input.
                Sys.Browser().Page(vServerCR1755 + "*").Wait();
                
                if (language == "french"){
                    CheckProperty(PageActif, "LocationName", cmpEqual, "Erreur 400", true);
                } else {
                    CheckProperty(PageActif, "LocationName", cmpEqual, "Error 400", true);
                }
                
                
                PageActif.ToUrl(vServerCR1755 + "Profile/Logi");
                //Wait until the browser loads the page and is ready to accept user input.
                Sys.Browser().Page(vServerCR1755 + "*").Wait();
                
                CheckProperty(PageActif, "LocationName", cmpEqual, "Erreur 404", true);
                
        
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                Terminate_CroesusProcess();
                Terminate_IEProcess();
        }
  
}