//USEUNIT Global_variables
//USEUNIT Common_functions


/*
    Description : Test du login / Logout
    Analyste d'automatisation : Emna IHM
    Version : 90-28-44, 90-26-2021-08-79 (SUP-6497)
*/

function LoginLogoutTest()
{       
  try {
    
      var browserName = "chrome"; //"iexplore";
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
            
    Log.AppendFolder("******* Login test *******", "", pmNormal, logAttributes);
            
    //Login
    Login(vServerCroesusBuild, userName, psw, language, browserName);
            
    Log.Message("Check if the Croesus process is running.");
    if (aqObject.CheckProperty(Get_CroesusApp(), "Exists", cmpEqual, true)){
      Log.Message("Check if the Croesus main window is opened.");
      aqObject.CheckProperty(Get_MainWindow(), "Exists", cmpEqual, true);
    }     
    
    Log.PopLogFolder();
    
    Log.AppendFolder("******* Logout test *******", "", pmNormal, logAttributes);
           
    //Close Croesus
    Delay(5000);
    Close_Croesus_MenuBar();
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
      Get_DlgConfirmation().Click(Get_DlgConfirmation().Width/3, Get_DlgConfirmation().Height-45);
    RestoreAutoTimeOut();
    
    Log.Message("Check if the Croesus main window is closed.");
    aqObject.CheckProperty(Get_MainWindow(), "Exists", cmpEqual, false);
    Log.Message("Check if the Croesus process is stopped.");
    aqObject.CheckProperty(Get_CroesusApp(), "Exists", cmpEqual, false);
    
    //Checkpoints
    LogoutCheck_LoadInputForm();
    
    Log.PopLogFolder();
        
  }
  catch(e) {
    Log.Error("Exception : " + e.message, VarToStr(e.stack));
    e = null;
  }
  finally {
    TerminateProcess(browserName);
    Terminate_CroesusProcess();
    Log.PopLogFolder();
  }
    
}

function LogoutCheck_LoadInputForm()
{
    if (versionReference == "FM-13"){
        return LogoutCheck_LoadInputForm_Version_FM13();
    }
    
    var maxNbOfTries = 3;
    
    //Change Language if needed
    var pageObject = Sys.Browser().Page("*");  
    var DisconnectChecksLeft = maxNbOfTries;      
    
    do {    
      pageObject.Wait();
      Delay(1000);
      
      //Wait for either Header panel or Login panel
      var headerAndLoginPanelChecksLeft = (2 * maxNbOfTries);
      var headerPanel = Utils.CreateStubObject();
      var loginPanel = Utils.CreateStubObject();  
    
      do {
        pageObject.Refresh();
        headerPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "header", "header", true], 20, true, 3000);
        if (!headerPanel.Exists){
          loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 3000);
        }            
      } while (!headerPanel.Exists && !loginPanel.Exists && --headerAndLoginPanelChecksLeft > 0)
        
      if (headerPanel.Exists){//Disconnect
        var disconnectPanel = headerPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "0", true], 10, true, 1000);
        disconnectPanel.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Button", "0", true], 10).Click();
        var disconnectSubmenu = disconnectPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "myDropdown", true], 10, true, 5000);
        var signOutButton = disconnectSubmenu.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", "0", true], 10, true, 3000);
        signOutButton.HoverMouse();
        signOutButton.Click();
        //If the Click on Sign Out button did not succeed (button is still displayed), try once again
        signOutButton.Refresh();
        if (signOutButton.Exists && !WaitObjectPropertyExistsToFalse(signOutButton, 10000) && !signOutButton.WaitProperty("VisibleOnScreen", false, 5000)){
          signOutButton.Refresh();
          if (signOutButton.Exists && signOutButton.VisibleOnScreen){
            signOutButton.Click();
          }
        }            
        //Wait for Login panel
        loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 15000);
      }        
      
    } while (!loginPanel.Exists && --DisconnectChecksLeft > 0);
    
    if (!loginPanel.Exists)
        Log.Error("Logout Failed!! Login panel (for Username and Password input) not displayed.");
    else
        Log.Checkpoint("Logout Success!!")            
        
}

function LogoutCheck_LoadInputForm_Version_FM13()
{
    var maxNbOfTries = 3;
    
    //Change Language if needed
    var pageObject = Sys.Browser().Page("*");
    var DisconnectChecksLeft = maxNbOfTries;
    do {
      pageObject.Wait();
      Delay(1000);
      var loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_container", "login-container", true], 10, true, 30000);
       
    } while (!loginPanel.Exists && --DisconnectChecksLeft > 0);
    
    if (!loginPanel.Exists)
        Log.Error("Logout Failed!! Login panel (for Username and Password input) not displayed.");
    else
        Log.Checkpoint("Logout Success!!")
    
}