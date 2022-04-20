//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA

var browserName = "iexplore";//chrome    edge    iexplore    firefox  

var gmailUrl = "https://www.google.com/gmail/";
var tabGmail = "https://*google*"
var gmail = "testsauto@croesus.com"
var pswGmail = "testsauto.2016";

//************************************ Login page ************************************
var languageCSS = "#nav-header > ul > li > a";
var userNameCSS = "#username";
var pswCSS = "#password";
var btnConnectCSS = "#btnConnect";

//************************************ Home page *************************************

//search
var userMenusSearchBoxCSS = "#searchBox";
var userMenusSearchByCSS = "#searchBy";

//category search
if (language == "french"){
    var byFirm = "par Firme";
    var byName = "par Nom";
    var byRegion = "par Région";
    var byBranch = "par Succursale";
    var byUser = "par Utilisateur";
    var byIACode = "par Code de CP";
} else if (language == "english"){
    var byFirm = "by Firm";
    var byName = "by Name";
    var byRegion = "by Region";
    var byBranch = "by Branch";
    var byUser = "by User";
    var byIACode = "by IA Code";
  
}

var classMenusName = "#usersMainTab li:nth-child(1)";
var classMenusUser = "#usersMainTab li:nth-child(2)";
var classMenusIACode = "#usersMainTab li:nth-child(3)";

var firm1CSS = "#firm-1_anchor";
var region1CSS = "#region-1_anchor";
var defaultBranch = "#branch-DEFAULT_anchor";
var HOBranch = "#branch-H-O_anchor";
var BDBranch = "#branch-BD_anchor"


//*************************************** User page ************************************

var addIACodeCSS = "#addCPCodes";

var addNewUserBtnXpath = ".//*[@id='body']/ul/li[1]/a";
var firstNameCSS = "#FirstName";
var lastNameCSS = "#LastName";
var emailCSS = "#Email";
var accessLevelCSS = "#accessLevel";
var userIDCSS = "#StationId";
var radioLanguage = "#language1" 
var resetPSWBtnCSS = "#resetUserPasswordBtn";
var applquerBtnCSS = "#newUserSubmitBtn";
var applyBtnCSS = "#userSubmitBtn";
var popupWarningOKBtnXpath = ".//*[@id='body']/div[6]/div[3]/div/button[1]";
var popupWinOKBtnXpath = ".//*[@id='cboxLoadedContent']/div/div/a";
var confirPSWBtn = ".ui-dialog-buttonset button:nth-child(1)";
var croAdvCheckBoxCSS = "#softwareAccess_3";
var configCheckBoxCSS = "#softwareAccess_4";

//************************************** IACodeUser page ********************************
var IACodeUSerPageSearchBoxCSS = "#CPSearchBox";
var cancelIACodeBtn = "[class='btn cancelCpCodes cancelColorbox red']";



//************************************* LogOut *****************************************
var logoutList = ".profileline.dropdownline";
var logoutBtn = "#menulogout";


//************************************* Gmail *******************************************

var emailConfirmCSS = ".Cp table tbody > tr:nth-child(1)";
var emailNewUser = "tbody tr:nth-child(2) > td p:nth-child(5)";
var emailPSWReset = "tbody tr:nth-child(2) > td p:nth-child(3)";
var codeActiveCSS = "tbody:nth-child(1) > tr:nth-child(2) > td > p:nth-child(3) > b";
var deleteBtnCSS = ".iH > div:nth-child(1) > div:nth-child(2) > div:nth-child(3) > div:nth-child(1)";
var deleteAllBtnCSS = "div.D:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(3) > div:nth-child(1)";

//************************************* Préférence et configurations *******************************************

var preferenceConfigBtnCSS = "#firmGetPrefsBtn";
var searchTextCSS = "#prefSearchBox";

var configurationBtnidStr = "#configs_anchor";
var otherBtnidStr = "#other_anchor";
var offsideAccountidStr = "FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS_anchor"
var checkBoxDefautValueidStr = "inherited1";
var prefconfigSubmitBtnidStr = "configSubmitBtn";
var closeWinPrefBtnCSS = "#cboxLoadedContent > div > a"

function CreateNewUser_WebConfiguator(vServer, userName, psw, firstName, lastName, email, level, station_id, language,browserName){
            
            Login_WebConfigurator(vServer, userName, psw, language,browserName);
            var PageActif = Sys.Browser().Page(vServer + "*");
          
            WaitObject(PageActif, "idStr", "firm-1_anchor");
            // Double clique id firm1
            PageActif.QuerySelector(firm1CSS).DblClick();
            WaitObject(PageActif, "idStr", "region-1_anchor");
            
            // Double clique id region1
            PageActif.QuerySelector(region1CSS).DblClick();
            WaitObject(PageActif, "idStr", "branch-H-O_anchor");
          
            // Clique souri droit
            PageActif.QuerySelector(HOBranch).Click();
            PageActif.QuerySelector(HOBranch).ClickR();
            WaitObject(PageActif, ["ObjectType", "Name", "namePropStr"], ["Link","Link(0)","users#"]);  
            Delay(2000);
            PageActif.FindChildByXPath(addNewUserBtnXpath).focus();   
            PageActif.FindChildByXPath(addNewUserBtnXpath).Click();
            WaitObject(PageActif, "idStr", "FirstName");
          
            // Fill out Prenom
            PageActif.QuerySelector(firstNameCSS).Keys(firstName);
            PageActif.QuerySelector(lastNameCSS).Keys(lastName);
            PageActif.QuerySelector(emailCSS).Keys(email);
            PageActif.QuerySelector(accessLevelCSS).ClickItem(level);
            PageActif.QuerySelector(userIDCSS).Keys(station_id);
            
            if (language == "english"){
                PageActif.QuerySelector(radioLanguage).Click()
            }
            
            PageActif.QuerySelector(croAdvCheckBoxCSS).Click();
            PageActif.QuerySelector(configCheckBoxCSS).Click();
            
            PageActif.QuerySelector(applquerBtnCSS).Click();
            
            WaitObject(PageActif, "idStr", "cboxLoadedContent");
            PageActif.FindChildByXPath(popupWinOKBtnXpath).Click();
          
            // Logout
            PageActif.QuerySelector(logoutList).Click();
            WaitObject(PageActif, "idStr", "menulogout");
            PageActif.QuerySelector(logoutBtn).Click();
            Sys.Browser().Page(vServer + "*").Wait();
            WaitObject(PageActif, "idStr", "wrapper");
}


function test(){
  
      var PageActif = Sys.Browser().Page(vServerCR1755 + "*");
      
      
}

function ResetPSW_User(vServer, userName, psw, station_id, email, language,browserName){
            
            var useNumber = Execute_SQLQuery_GetField("select * from B_USER where STATION_ID = " + "'"+station_id+"'" ,vServer,"USER_NUM");
            Log.Message(useNumber);
            
            Login_WebConfigurator(vServer, userName, psw, language, browserName);
          
            var PageActif = Sys.Browser().Page(vServer + "*");
            WaitObject(PageActif, "idStr", "firm-1_anchor");
            // Double clique id firm1
            PageActif.QuerySelector(firm1CSS).DblClick();
            WaitObject(PageActif, "idStr", "region-1_anchor");
            
            // Double clique id region1
            PageActif.QuerySelector(region1CSS).DblClick();
            WaitObject(PageActif, "idStr", "branch-BD_anchor");
          
            // Double clique branch BD
            PageActif.QuerySelector(BDBranch).DblClick();
            WaitObject(PageActif, "idStr", "user-"+ useNumber +"_anchor");
            
            PageActif.QuerySelector("#user-"+ useNumber +"_anchor").Click();
            WaitObject(PageActif, "idStr", "Email");
            
            PageActif.QuerySelector(emailCSS).SetText(email);
            PageActif.QuerySelector(applyBtnCSS).Click();
            WaitObject(PageActif, ["idStr","Text","Visible"], ["Email",email,"True"]);
            Delay(3000);
            
            PageActif.QuerySelector(resetPSWBtnCSS).Click();
            if (language == "french"){
                WaitObject(PageActif, ["ObjectLabel","ObjectType","Visible"], ["Continuer","Button","True"]);
            } else {
                WaitObject(PageActif, ["ObjectLabel","ObjectType","Visible"], ["Continue","Button","True"]);
            }

            PageActif.QuerySelector(confirPSWBtn).Click();
            WaitObject(PageActif, "idStr", "cboxLoadedContent");
            PageActif.FindChildByXPath(popupWinOKBtnXpath).Click();
            
          
            // Logout
            PageActif.QuerySelector(logoutList).Click();
            WaitObject(PageActif, "idStr", "menulogout");
            PageActif.QuerySelector(logoutBtn).Click();
            Sys.Browser().Page(vServer + "*").Wait();
            WaitObject(PageActif, "idStr", "wrapper");
}

function GetCodeConfirmationFromGmail(vServer,browserName){

            //Attendre la page gmail boite de reception
            var pageGmail = Sys.Browser().Page(tabGmail);
            WaitObject(pageGmail,["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"]);
        
            pageGmail.Find(["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"],100).Click();
            Delay(2000);
            pageGmail.QuerySelector(emailConfirmCSS).Click();
            Delay(4000);
            //Get le code 
            var codeActive = pageGmail.QuerySelector(codeActiveCSS).contentText;
            Log.Message(codeActive);
            Delay(2000);
            //Supprimer email
            pageGmail.QuerySelector(deleteBtnCSS).Click();
            Delay(2000);
            CloseTab(tabGmail,browserName);
        
            // Switch a la pageCroesus
            SelectTab(vServer + "*",browserName);
            
            return codeActive;
}

function GetCodeTemporaryFromGmail(language,browserName){

            //Attendre la page gmail boite de reception
            var pageGmail = Sys.Browser().Page(tabGmail);
            WaitObject(pageGmail,["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"]);
        
            pageGmail.Find(["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"],100).Click();
            Delay(2000);
            pageGmail.QuerySelector(emailConfirmCSS).Click();
            Delay(4000);
            
            //Get le code 
            var code = pageGmail.QuerySelector(emailNewUser).contentText;
            if(language == "french"){
                var codeActive = aqString.Remove(code, 0, 32);
            } else {
                var codeActive = aqString.Remove(code, 0, 25);
            }       
            //var codeActive = aqString.Trim(aqString.SubString(code, aqString.Find(code, ":")+1, aqString.GetLength(code)-aqString.Find(code, ":")));
            Log.Message(codeActive);
            Delay(2000);
            
            //Supprimer email
            pageGmail.QuerySelector(deleteBtnCSS).Click();
            Delay(2000);
            CloseTab(tabGmail,browserName);
            CloseBrowser(browserName);
            
            return codeActive;
}

function GetCodeResetFromGmail(language,browserName){

            //Attendre la page gmail boite de reception
            var pageGmail = Sys.Browser().Page(tabGmail);
            WaitObject(pageGmail,["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"]);
        
            pageGmail.Find(["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"],100).Click();
            Delay(2000);
            pageGmail.QuerySelector(emailConfirmCSS).Click();
            Delay(4000);
            
            //Get le code 
            var code = pageGmail.QuerySelector(emailPSWReset).contentText;
            if(language == "french"){
                var codeActive = aqString.Remove(code, 0, 38);
            } else {
                var codeActive = aqString.Remove(code, 0, 33);
            }       
            //var codeActive = aqString.Trim(aqString.SubString(code, aqString.Find(code, ":")+1, aqString.GetLength(code)-aqString.Find(code, ":")));
            Log.Message(codeActive);
            Delay(2000);
            
            //Supprimer email
            pageGmail.QuerySelector(deleteBtnCSS).Click();
            Delay(2000);
            CloseTab(tabGmail,browserName);
            CloseBrowser(browserName);
            
            return codeActive;
}


/*
function Login_WebConfigurator(vServer, userName, psw, language, browserName){
  
            Log.Message("Croesus WebConfigurator Login with : " + userName);
      

            
            //Close browser and Croesus App
            CloseBrowser(browserName);
    
            //Launch the specified browser and opens the specified URL in it.
            Browsers.Item(browserName).Run(vServer + "WebConfigurator/login");
            
            if (projet == "Performance"){
              SetAutoTimeOut();
                      if (Sys.Browser(browserName).Page("*").Login.Exists == true){
                              Sys.Browser(browserName).Page("*").Login.Button("OK").Click();
                      }
              RestoreAutoTimeOut();
            }
    
            //Wait until the browser loads the page and is ready to accept user input.
            Sys.Browser().Page(vServer + "*").Wait();
            var PageActif = Sys.Browser().Page(vServer + "*");
            //Sys.Browser().BrowserWindow(0).Maximize();
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
    
            //Fill Login form
            loginForm.Click(10, 10);
            loginForm.Keys("[Tab]^a[Del]" + userName + "[Tab]");
            if (psw != null) loginForm.Keys(psw);
            loginForm.Keys("[Enter]");
            
            Sys.Browser().Page(vServer + "*").Wait();
}
*/

//Nouvelle version pour 90.18 et plus
function Login_WebConfigurator(vServer, userName, psw, language, browserName){
  
            Log.Message("Croesus WebConfigurator Login with : " + userName);
      

            
            //Close browser and Croesus App
            CloseBrowser(browserName);
    
            //Launch the specified browser and opens the specified URL in it.
            Browsers.Item(browserName).Run(vServer + "WebConfigurator/login");
  /*        
            if (projet == "Performance"){
              SetAutoTimeOut();
                      if (Sys.Browser(browserName).Page("*").Login.Exists == true){
                              Sys.Browser(browserName).Page("*").Login.Button("OK").Click();
                      }
              RestoreAutoTimeOut();
            }
    */
            //Wait until the browser loads the page and is ready to accept user input.
            Sys.Browser().Page(vServer + "*").Wait();
            var PageActif = Sys.Browser().Page(vServerPerformance + "*");
            var LoginViewPanel = PageActif.Panel(0).Panel("login_view");
        
            var UserNameTextBox = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(0).Panel(0).Panel(0).Panel(0).Textbox("Username");
            var PasswordTextBox = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(0).Panel(0).Panel(1).Panel(0).PasswordBox("Password");
            var ConnexionButton = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(2).Panel(0).Button("button")
            var LanguageButton  = LoginViewPanel.Panel(2).Panel(0).Form(0).Button(0);
 
            Log.Message("ObjectLabel : "+LanguageButton.ObjectLabel)
            //Change Language if needed
            var LanguageLabel = (language == "french")? "language Français": "language English";
            if(LanguageButton.ObjectLabel == LanguageLabel){
                LanguageButton.HoverMouse(15,25);
                LanguageButton.Click();    
            } 
            
            //Fill Login form
            UserNameTextBox.Keys(userNamePerformanceWebConfig);
            PasswordTextBox.Keys(pswPerformanceWebConfig);
        
            ConnexionButton.Click();
            
            Sys.Browser().Page(vServer + "*").Wait();
}


function Login_CR1755Croesus(vServer,userName,psw,application,language,browserName)
{
    
            //Close browser and Croesus App
            CloseBrowser(browserName);
            Terminate_CroesusProcess();
    Log.Message("L'anomalie : PF-2463")
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
    
            //Fill Login form
            loginForm.Click(10, 10);
            Delay(1000);
            loginForm.Keys("[Tab]^a[Del]" + userName + "[Tab]");
            Delay(1000);
            loginForm.Keys(psw);
            Delay(1000);
            loginForm.Keys("[Enter]");
            Sys.Browser().Page(vServer + "*").Wait();
            
}


function ModifierPSW(vServer,psw){

            var PageActif = Sys.Browser().Page(vServer + "*");
            
            WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
            var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
            
            //Fill Login form
            loginForm.Click(10, 10);
            Delay(1000);
            loginForm.Keys("[Tab]^a[Del]" + psw + "[Tab]");
            Delay(1000);
            loginForm.Keys(psw);
            Delay(1000);
            loginForm.Keys("[Enter]");
            
            Sys.Browser().Page(vServer + "*").Wait();
               
}


function TwoFactorAuthentication(vServer,application,email,language,browserName){
  
            //Attendre la page confirmation
            Sys.Browser(browserName).Page(vServer + "*").Wait();
        
            var PageActif = Sys.Browser(browserName).Page(vServer + "*");
            var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
            var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);

            check_PageConfirmation(language);
            //loginForm.HoverMouse(90, 320);
            loginForm.Click(100, 320);
        
            //Attendre la page Modification
            Sys.Browser(browserName).Page(vServer + "*").Wait();
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
            Sys.Browser(browserName).Page(vServer + "*").Wait();
            WaitObject(PageActif,["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true]);
            check_PageVerification(language);
        
            Login_Gmail(gmailUrl,browserName);
            var codeActive = GetCodeConfirmationFromGmail(vServer,browserName);
                        
            //Remplir le code
            loginForm.Click(10, 10);
            Delay(2000);
            loginForm.Keys("[Tab]^a[Del]" + codeActive); 
            Delay(2000);
            loginForm.Keys("[Enter]");
            Sys.Browser(browserName).Page(vServer + "*").Wait();
            Delay(2000);
            

}

function TwoFactorAuthentication_Pass(vServer,application,browserName){
            
            var PageActif = Sys.Browser(browserName).Page(vServer + "*");
            
            if (application == "app"){
                Login_CroesusAdvisor(browserName);
            }else if(application == "web"){
                PageActif.QuerySelector(logoutList).Click();
                WaitObject(PageActif, "idStr", "menulogout");
                PageActif.QuerySelector(logoutBtn).Click();
                Sys.Browser().Page(vServer + "*").Wait(); 
            }else if (application == "profil"){
                var width = PageActif.Width;
                var Height = PageActif.Height;
                PageActif.Click(width*0.98385, Height*0.0276);
                Delay(2000);
                PageActif.Click(width*0.98385, Height*0.09554);
                Sys.Browser().Page(vServer + "*").Wait(); 
            }
}


function Login_CroesusAdvisor(browserName){

            var pageObject = Sys.Browser(browserName).Page("*");
            
            //Click on "Launch Croesus Advisor" button
            if (browserName != "chrome" && browserName != "firefox"){
    			  WaitObject(pageObject, "idStr", "launcher2");
    			  Delay(3000);
            pageObject.FindChild("idStr", "launcher2",100).Click();
            }
            
            /*//Click on Open button in the Notification bar
            var nbOfTries = 0;
            do {
                var barNotification = Sys.Browser().BrowserWindow(0).FindChildEx(["WndClass", "WndCaption", "Visible"], ["Frame Notification Bar", "", true], 10, true, 3000);
                if (!barNotification.Exists) break;
                var btnOpenContainer = barNotification.FindChildEx(["ObjectIdentifier", "Visible"], ["Notification", true], 10, true, 1000);
                
                //The Open button text is either "Open" or "Ouvrir"
                var strOpen = "Open";
                var btnOpen = btnOpenContainer.FindChildEx(["ObjectIdentifier", "Visible"], [strOpen, true], 10, true, 1000);
                if (!btnOpen.Exists){
                    strOpen = "Ouvrir";
                    btnOpen = btnOpenContainer.FindChildEx(["ObjectIdentifier", "Visible"], [strOpen, true], 10, true, 1000);
                }
                
                btnOpen.Click();
                Delay(100);
                btnOpenContainer.Refresh();
            } while (btnOpenContainer.FindChild(["ObjectIdentifier", "Visible"], [strOpen, true], 10).Exists && ++nbOfTries < 5)*/
	
            // if you run a vserveur for the first time
            if (client != "TD"){
                var dfsvcProcess = Sys.WaitProcess("dfsvc", 3000);
                if (dfsvcProcess.Exists){
                    if (dfsvcProcess.WaitWinFormsObject("TrustManagerPromptUI", 3000).Exists){
                        Sys.Process("dfsvc").WinFormsObject("TrustManagerPromptUI").WinFormsObject("tableLayoutPanelOuter").WinFormsObject("tableLayoutPanelButtons").WinFormsObject("btnInstall").Click();
                        Delay(5000);
                    }
            
                    if (dfsvcProcess.WaitWindow("#32770", "Open File - Security Warning", 1, 3000).Exists)
                        dfsvcProcess.Window("#32770", "Open File - Security Warning", 1).Window("Button", "&Run", 1).Click();
                }
            }
    
            //Wait for Croesus App
        	  Sys.WaitProcess("CroesusClient", 30000);
        	  WaitObject(Get_CroesusApp(), "Uid", "Window_5bbd");
            if (Get_MainWindow().Exists) Get_MainWindow().WaitProperty("VisibleOnScreen", true, 20000);
    
            //What's new dialog box
            if (Get_WinWhatsNew().Exists){
                Get_WinWhatsNew_ChkDoNotShowThisDialogBoxAgain().set_IsChecked(true);
                Get_WinWhatsNew_BtnClose().Keys("[Enter]");
            }

}


function Login_Gmail(URL,browserName)
{
            
            //WshShell.Run("powershell RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255");
            //Delay(8000);
            
            //Launch gmail         
            OpenNewTab(URL,browserName);
            
            var pageGmail = Sys.Browser(browserName).Page(tabGmail);
            
            /*SetAutoTimeOut();
            var signInPage = WaitObject(pageGmail,["namePropStr","contentText"], ["mail","Sign In"]);
            if (signInPage == true)
                {
                pageGmail.Find(["namePropStr","contentText"], ["mail","Sign In"], 10).Click();
                Sys.Browser(browserName).Page(tabGmail).Wait();
                }
            RestoreAutoTimeOut();*/
            
            /*// Fill email adresse
            pageGmail.Find("idStr","identifierId",100).Keys("^a[Del]" + gmail + "[Enter]");
            Sys.Browser(browserName).Page(tabGmail).Wait();
            
            //Fill password
            pageGmail.Find(["ObjectIdentifier","ObjectType"],["password","PasswordBox"],100).Keys("^a[Del]" + pswGmail + "[Enter]");
            Sys.Browser(browserName).Page(tabGmail).Wait();*/


}

function DeleteAllGmail(URL,browserName)
{
            
            CloseBrowser(browserName);
            
            WshShell.Run("powershell RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255");
            Delay(8000);
            
            //Launch gmail         
            Browsers.Item(browserName).Run(URL);
            Sys.Browser().Page(tabGmail).Wait();
            Sys.Browser().BrowserWindow(0).Maximize();
            
            var pageGmail = Sys.Browser(browserName).Page(tabGmail);
            
            SetAutoTimeOut();
            var signInPage = WaitObject(pageGmail,["namePropStr","contentText"], ["mail","Sign In"],5000);
            if (signInPage == true)
                {
                pageGmail.Find(["namePropStr","contentText"], ["mail","Sign In"], 10).Click();
                Sys.Browser(browserName).Page(tabGmail).Wait();
                }
            RestoreAutoTimeOut();
            
            // Fill email adresse
            pageGmail.Find("idStr","identifierId",100).Keys("^a[Del]" + gmail + "[Enter]");
            Sys.Browser(browserName).Page(tabGmail).Wait();
            
            //Fill password
            pageGmail.Find(["ObjectIdentifier","ObjectType"],["password","PasswordBox"],100).Keys("^a[Del]" + pswGmail + "[Enter]");
            Sys.Browser(browserName).Page(tabGmail).Wait();
            
            WaitObject(pageGmail,["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"]);
            pageGmail.Find(["namePropStr","contentText","ObjectType"],["3.CR1755","3.CR1755","Link"],100).Click();
            Delay(2000);
            
            SetAutoTimeOut();
            var message = WaitObject(pageGmail,["ObjectType","contentText","Name"],["Cell","Aucune conversation avec ce libellé n'a été trouvée.","Cell(0, 0)"]);
            if (message == false){
                pageGmail.Panel(5).Panel(2).Panel(0).Panel(1).Panel(0).Panel(1).Panel(0).Panel(0).Panel(0).Panel(0).Panel(0).Panel(1).Panel(0).Panel(0).Panel(0).Panel(0).Panel(0).Panel("o").Panel(0).TextNode(0).Click();
                Delay(2000);
                pageGmail.QuerySelector(deleteAllBtnCSS).Click();
            }
            RestoreAutoTimeOut();
            
            Sys.Browser(browserName).Page(tabGmail).Wait();
            Delay(2000);
            
            Terminate_IEProcess();

}
function OpenNewTab(URL,browserName)
{
            
            Sys.Browser(browserName).BrowserWindow(0).Keys("^t");
            Delay(3000);
            Sys.Browser(browserName).ToUrl(URL);
            Sys.Browser(browserName).Page("*").Wait();

}

// Activates the browser tab where the specified URL is opened
function SelectTab(URL,browserName)
{
              
              var tabBand = Sys.Browser(browserName).BrowserWindow(0).CommandBar.TabBand;

              var page = Sys.Browser(browserName).WaitPage(URL, 0);
              if (! page.Exists)
                  {
                    Log.Error("Browser tab \"" + URL + "\" was not found.");
                  }
              else
                  {
                    tabBand.TabButton(page.contentDocument.title).Click();
                  }
}


function TabExists(URL,browserName)
{
  return Sys.Browser(browserName).WaitPage(URL, 0).Exists;
}

function CloseTab(URL,browserName)
{
  Sys.Browser(browserName).Page(URL).Close();
}

function check_PageConfirmation(language)
{
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageConfirmation1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageConfirmation2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageConfirmation3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnModifier", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnConfirmer", language), true);
}

function check_PageModification(language)
{
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageModification1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageModification2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageModification3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageModification4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnSuivant", language), true);
}

function check_PageVerification(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnValider", language), true);
}

function check_PageVerification_CodeError(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification6", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnValider", language), true);
}

function check_PageVerification_CodeMaximum(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "pageVerification7", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "btnValider", language), true);
}

function check_PageLogin_Error(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin1", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin6", language), true);
}

function check_PageLogin_PSWError(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin7", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin6", language), true);
}

function check_PageLogin_PSWErrorMaximum(language)
{ 
        var PageActif = Sys.Browser().Page("*");
        var loginPanel = PageActif.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
        var loginForm = loginPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "wrapper", "wrapper", true], 10, true, 5000);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin8", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin2", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin3", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin4", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin5", language), true);
        CheckProperty(loginForm, "innerHTML", cmpContains, ReadDataFromExcelByRowIDColumnID(filePath_CR1755, "LoginPage", "PageLogin6", language), true);
}

