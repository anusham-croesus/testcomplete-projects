//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT ExcelUtils

/* Analyste d'assurance qualité: Ali
Analyste d'automatisation: Xian Wei */

function Performance_Dashboard(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Dashboard";
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  

        try {
 //Terminate processes
        Terminate_CroesusProcess();
        Terminate_IEProcess();

        
    
            //Internet Explorer is the browser to be used by default
            if (browserName == undefined) browserName = "iexplore";
    
            //Close browser and Croesus App
            CloseBrowser(browserName);
            Terminate_CroesusProcess();
    
            //Launch the specified browser and opens the specified URL in it.
            Browsers.Item(browserName).Run(vServerPerformance);

            if (projet == "PerformanceEVOL"){
            WaitObject(Sys.Browser(browserName).Page(vServerPerformance), ["ObjectType", "VisibleOnScreen"],["Login",true]);
            
            var securityPanel = Sys.Browser(browserName).Page(vServerPerformance).Login;
            var ChUserName = securityPanel.TextBox("UserName");
            var ChPassword = securityPanel.TextBox("Password");
            
            ChUserName.Click();
            ChUserName.Keys("^a[BS]");
            ChUserName.Keys(authUser);
           
            ChPassword.Click();
            ChPassword.Keys("^a[BS]")
            ChPassword.Keys(authPsw);
            
            securityPanel.Button("OK").Click();
            }
            

        
          //Wait until the browser loads the page and is ready to accept user input.
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            var pageObject = Sys.Browser().Page("*");
            Sys.Browser().BrowserWindow(0).Maximize();
            
           if(versionReference == "FM-13"){
             
            var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
    
            

            
           //Change Language if needed
            var languageString = 'language="' + aqString.SubString(language, 0, 2) + '-';
            if (aqString.Find(VarToStr(loginForm.innerHTML), languageString) == -1){
                loginForm.Click(10, 10);
                loginForm.Keys("[Tab][Tab][Tab][Tab][Tab]");
                loginForm.Keys("[Enter]");
                loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            }
    
            //Fill Login form
            loginForm.Click(10, 10);
            loginForm.Keys("[Tab]^a[Del]" + userNamePerformance + "[Tab]");
			Delay(1000);
            if (psw != null) loginForm.Keys(pswPerformance);
			Delay(1000);
            loginForm.Keys("[Enter]");
			pageObject.Wait();
    
            //If Firefox browser, click on the Fx Click Once button
            if (browserName == "firefox"){
                Log.Message("For FireFox browser, click on the 'Fx Click Once' button");
                Sys.Browser(browserName).WaitWindow("MozillaDialogClass", "Opening CroesusClient.application", -1, 5000);
                var clickOnceInstallButton = Sys.Browser(browserName).FindChild("Name", 'button("FxClickOnce_RunButton")', 100);
        
                if (clickOnceInstallButton.Exists)
                    clickOnceInstallButton.Click();
                else
                    Log.Message("Firefox browser : The 'Fx Click Once' button was not found.");
            }
            
            //Click on "Launch Croesus Advisor" button
            if (browserName != "chrome" && browserName != "firefox"){
    			WaitObject(pageObject, "idStr", "launcher");
    			Delay(1000);
                pageObject.FindChild("idStr", "launcher",100).Click();
            }
            
    }	                        //Wait for Croesus App
    
    
/*******************************************************************************************************************************************************/
 if(versionReference == "MAINLINE-90-18-45"){
   var maxNbOfTries = 3;
   //Change Language if needed
    var languageChangeTriesLeft = maxNbOfTries;
    do {
        pageObject.Wait();
        Delay(1000);
        pageObject.Refresh();
        var headerPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "header", "header", true], 20, true, 15000);
        if (headerPanel.Exists){//Disconnect
            var disconnectPanel = headerPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "0", true], 10, true, 1000);
            disconnectPanel.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Button", "0", true], 10).Click();
            var disconnectSubmenu = disconnectPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "myDropdown", true], 10, true, 5000);
            var signOutButton = disconnectSubmenu.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", "0", true], 10, true, 3000);
            signOutButton.HoverMouse();
            signOutButton.Click();
            //If the Click on Sign Out button did not succeed (button is still displayed), try once again
            if (!signOutButton.WaitProperty("VisibleOnScreen", false, 15000)){
                signOutButton.Refresh();
                if (signOutButton.Exists && signOutButton.VisibleOnScreen)
                    signOutButton.Click();
            }
        }
        
        var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 15000);
        if (!loginPanel.Exists)
            throw new Error("Login panel (for Username and Password input) not displayed.");
        
        var alternateLanguageLabel = (language == "french")? "language English": "language Français";
        var isAlternateLanguageButtonDisplayed = (loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", alternateLanguageLabel, true], 20, true, 5000).Exists);
        if(!isAlternateLanguageButtonDisplayed){//Change Language
            var languageLabel = (language == "french")? "language Français": "language English";
            loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", languageLabel, true], 20, true, 5000).Click();
            pageObject.Wait();
            isAlternateLanguageButtonDisplayed = (loginPanel.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", alternateLanguageLabel, true], 20, true, 5000).Exists);
        }
    } while (!isAlternateLanguageButtonDisplayed && --languageChangeTriesLeft > 0);
    
    //Input UserName and Password, and Sign In
    loginPanel.Refresh();
    var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "1", "", true], 10, true, 5000);
    var txtUsername = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Textbox", "Username", true], 10, true, 5000);
    var txtPassword = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["PasswordBox", "Password", true], 10, true, 5000);
    var signInLabel = (language == "french")? "Se connecter": "Sign in";
    var signButton = loginForm.FindChildEx(["ObjectType", "ObjectLabel", "Visible"], ["Button", signInLabel, true], 10, true, 5000);
    txtUsername.Click();
    txtUsername.Keys("^a[BS]");
    txtUsername.Keys(userNamePerformance);
    txtPassword.Click();
    txtPassword.Keys("^a[BS]");
    txtPassword.Keys(pswPerformance);
    signButton.Click();
    pageObject.Wait();
    
    //If Firefox browser, click on the Fx Click Once button
    if (browserName == "firefox"){
        Log.Message("For FireFox browser, click on the 'Fx Click Once' button");
        Sys.Browser(browserName).WaitWindow("MozillaDialogClass", "Opening CroesusClient.application", -1, 5000);
        var clickOnceInstallButton = Sys.Browser(browserName).FindChild("Name", 'button("FxClickOnce_RunButton")', 100);
        if (clickOnceInstallButton.Exists)
            clickOnceInstallButton.Click();
        else
            Log.Message("Firefox browser : The 'Fx Click Once' button was not found.");
    }
            
    //If no "Launch Croesus Advisor" button, check if PREF_MAX_USER error message is displayed
    if (!WaitObject(pageObject, "idStr", "launcher")){
        if (language == "french")
            var PREF_MAX_USER_errorMsg = "Un utilisateur s’est connecté avec le nom d'utilisateur " + userName + ". Le nombre maximum de sessions a été atteint. Vous avez été déconnecté.";
        else
            var PREF_MAX_USER_errorMsg = "A user signed in with the username " + userName + ". The maximum number of sessions is exceeded. You have been signed out.";
        
        loginForm.Click(10, 10);
        Delay(2000);
        loginForm.Keys("[Tab][Tab][Tab][Tab]");
        Delay(2000);
        var tempSavedClipboard = Sys.Clipboard;
        Sys.Clipboard = "";
        loginForm.Keys("^a^c");
        loginForm.Click(10, 10);
        var nbClipboardChecksLeft = 400;
        do {
            Delay(50);
            var is_PREF_MAX_USER_errorMsg_found = (GetVarType(Sys.Clipboard) == varOleStr && aqString.Find(Sys.Clipboard, PREF_MAX_USER_errorMsg) != -1);
        } while (!is_PREF_MAX_USER_errorMsg_found && --nbClipboardChecksLeft > 0);
        Sys.Clipboard = tempSavedClipboard;
        
        if (is_PREF_MAX_USER_errorMsg_found){
            Log.Error(PREF_MAX_USER_errorMsg);
            Log.Error("JIRA : CROES-11379 / CROES-10330 / CROES-6618 / CROES-5664");
            
            //Execute SQL to cleanup user connections
            var connectionsCleanupSQL = "";
            connectionsCleanupSQL += "declare @now datetime set @now = getdate() \r\n";
            connectionsCleanupSQL += "declare @today datetime set @today = convert(varchar, @now, 101) \r\n";
            connectionsCleanupSQL += "update b_login set status='0', disconnect_date = @today where STATION_ID = '" + userName + "' and STATUS = '1' and SOFTWARE_ID = 3 and CONNECT_DATE > @today \r\n";
            Log.Message("Execute SQL to cleanup " + userName + " connections.", connectionsCleanupSQL);
            Execute_SQLQuery(connectionsCleanupSQL, vServer);
        }
    }
    
    //Click on "Launch Croesus Advisor" button
    Sys.Refresh();
    if (Sys.WaitProcess("dfsvc", 1000).Exists){
        Sys.WaitProcess("dfsvc").Refresh();
        Delay(1000);
    }
    pageObject.Refresh();
    pageObject.FindChild("idStr", "launcher", 100).Click();
    
    
 }

 
  // if you run a vserveur for the first time
    if (client != "TD"){
        var dfsvcProcess = Sys.WaitProcess("dfsvc", 3000);
        SetAutoTimeOut();
        if (dfsvcProcess.Exists){
            if (dfsvcProcess.WaitWinFormsObject("TrustManagerPromptUI", 3000).Exists){
                Sys.Process("dfsvc").WinFormsObject("TrustManagerPromptUI").WinFormsObject("tableLayoutPanelOuter").WinFormsObject("tableLayoutPanelButtons").WinFormsObject("btnInstall").Click();
//                Delay(5000);
            }
            
            
        }
    }
    RestoreAutoTimeOut();   
                //Wait for Croesus App
            	Sys.WaitProcess("CroesusClient", 30000);
                
                StopWatchObj.Start();
                //Wait for Croesus App
            	WaitObject(Get_CroesusApp(), ["Uid"], ["ScrollViewer_0078"], waitTimeShort);
                Get_Dashboard_NegativeCashBalanceSummaryBoard().WaitProperty("IsDataGridLayoutInitialized", true, waitTimeShort);
                StopWatchObj.Stop();
                
                if (Get_MainWindow().Exists) Get_MainWindow().WaitProperty("VisibleOnScreen", true, 20000);

                // Écrit le résultat dans le fichier excel
                Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());    
                var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
                WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            	WaitObject(Get_CroesusApp(), "Uid", "Window_5bbd");
                if (Get_MainWindow().Exists) Get_MainWindow().WaitProperty("VisibleOnScreen", true, 20000);
     
                
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
        // Déconnecter
        //Get_MainWindow().SetFocus();
        //Close_Croesus_MenuBar();
        Terminate_CroesusProcess();
        Terminate_IEProcess();
        }

}