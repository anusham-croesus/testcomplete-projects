//USEUNIT Global_variables
//USEUNIT Common_functions


/*
    Description : Test du login avec différents navigateurs
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
*/

function SmokeTest_Login()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_Login()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    var testedBrowsersNames = new Array();
    testedBrowsersNames.push("iexplore");
    testedBrowsersNames.push("chrome");
    testedBrowsersNames.push("firefox");
    
    for (var i = 0; i < testedBrowsersNames.length; i++){
        try {
            var browserName = testedBrowsersNames[i];
            Log.AppendFolder("******* Login test for '" + browserName + "' browser. *******", "", pmNormal, logAttributes);
            
            //Login
            Login(vServerGeneral, userNameGeneral, pswGeneral, language, browserName);
            
            Log.Message("Check if the Croesus process is running.");
            if (aqObject.CheckProperty(Get_CroesusApp(), "Exists", cmpEqual, true)){
                Log.Message("Check if the Croesus main window is opened.");
                aqObject.CheckProperty(Get_MainWindow(), "Exists", cmpEqual, true);
            }
            
            //Close Croesus
            Delay(5000);
            Close_Croesus_MenuBar();
            SetAutoTimeOut();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation().Click(Get_DlgConfirmation().Width/3, Get_DlgConfirmation().Height-45);
            RestoreAutoTimeOut();
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
}
