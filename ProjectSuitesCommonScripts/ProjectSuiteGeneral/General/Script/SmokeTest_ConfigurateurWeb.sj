//USEUNIT Global_variables
//USEUNIT Common_functions



function SmokeTest_ConfigurateurWeb()
{
    
    try {
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        browserName = "iexplore";
        
        //Login
        WebConfiguratorLogin(vServerGeneral, userName, psw, browserName);
        
        //Les fonctions Get utilisent le texte pour identifier les composants
        //Donc si le composant a été trouvé, cela veut dire que le texte est celui attendu
        
        Log.Message("Check if the 'Users' link is displayed in the side bar.");
        if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkUsers(vServerGeneral), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkUsers(vServerGeneral), "VisibleOnScreen", cmpEqual, true);
            if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkUsers(vServerGeneral), "Enabled", cmpEqual, true)){
                Log.Message("Click on the 'Users' link of the side bar and check if the expected webpage is loaded.");
                Get_WebConfigurator_PnlSidebar_LnkUsers(vServerGeneral).Click();
                Get_WebConfigurator_WebPageUsers(vServerGeneral).Wait();
                aqObject.CheckProperty(Get_WebConfigurator_WebPageUsers(vServerGeneral), "Exists", cmpEqual, true);
            }
        }
    
        Log.Message("Check if the 'Securities' link is displayed in the side bar.");
        if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkSecurities(vServerGeneral), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkSecurities(vServerGeneral), "VisibleOnScreen", cmpEqual, true);
            if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkSecurities(vServerGeneral), "Enabled", cmpEqual, true)){
                Log.Message("Click on the 'Securities' link of the side bar and check if the expected webpage is loaded.");
                Get_WebConfigurator_PnlSidebar_LnkSecurities(vServerGeneral).Click();
                Get_WebConfigurator_WebPageSecurities(vServerGeneral).Wait();
                aqObject.CheckProperty(Get_WebConfigurator_WebPageSecurities(vServerGeneral), "Exists", cmpEqual, true);
            }
        }

        Log.Message("Check if the 'User Requests' link is displayed in the side bar.");
        if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkDefinitions(vServerGeneral), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkDefinitions(vServerGeneral), "VisibleOnScreen", cmpEqual, true);
            if (aqObject.CheckProperty(Get_WebConfigurator_PnlSidebar_LnkDefinitions(vServerGeneral), "Enabled", cmpEqual, true)){
                Log.Message("Click on the 'User Requests' link of the side bar and check if the expected webpage is loaded.");
                Get_WebConfigurator_PnlSidebar_LnkDefinitions(vServerGeneral).Click();
                Get_WebConfigurator_WebPageDefinitions(vServerGeneral).Wait();
                aqObject.CheckProperty(Get_WebConfigurator_WebPageDefinitions(vServerGeneral), "Exists", cmpEqual, true);
            }
        }
    
        Log.Message("Check if the 'Welcome' message is displayed in the header bar.");
        if (aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LblWelcome(vServerGeneral), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LblWelcome(vServerGeneral), "VisibleOnScreen", cmpEqual, true);
    
        Log.Message("Check if the username '" + userName + "' link is displayed in the header bar.");
        if (aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LnkUsername(vServerGeneral, userName), "Exists", cmpEqual, true)){
            if (aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LnkUsername(vServerGeneral, userName), "VisibleOnScreen", cmpEqual, true)){
                Log.Message("Click on the username '" + userName + "' link in the header bar and check if the 'Disconnect' link is displayed.");
                Get_WebConfigurator_BarHeader_LnkUsername(vServerGeneral, userName).Click();
                if (aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LnkDisconnect(vServerGeneral), "Exists", cmpEqual, true)){
                    if (aqObject.CheckProperty(Get_WebConfigurator_BarHeader_LnkDisconnect(vServerGeneral), "VisibleOnScreen", cmpEqual, true)){
                        Log.Message("Click on the 'Disconnect' link in the header bar and check if the Login webpage is loaded.");
                        Get_WebConfigurator_BarHeader_LnkDisconnect(vServerGeneral).Click();
                        Get_WebConfigurator_WebPageLogin(vServerGeneral).Wait();
                        aqObject.CheckProperty(Get_WebConfigurator_WebPageLogin(vServerGeneral), "Exists", cmpEqual, true);
                    }
                }
            }
        
        }
        
        //Close browser
        CloseBrowser(browserName);
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Close browser
        CloseBrowser(browserName);
    }

}



function Get_WebConfigurator(vServer)
{
    if (typeof browserName == "undefined" || browserName == undefined) browserName = "*";
    return Sys.Browser(browserName).Page(vServer + "WebConfigurator/*");
}

function Get_WebConfigurator_WebPageLogin(vServer){return Sys.Browser().Page(vServer + "*Login*WebConfigurator*login*")}

function Get_WebConfigurator_WebPageUsers(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/users*")}

function Get_WebConfigurator_WebPageSecurities(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/securities*")}

function Get_WebConfigurator_WebPageUserRequests(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/userRequest*")}

function Get_WebConfigurator_WebPageDefinitions(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/definitions*")}


function Get_WebConfigurator_BarHeader_LnkDisconnect(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100), ["ObjectType", "contentText"], ["Link", "Déconnexion"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100), ["ObjectType", "contentText"], ["Link", "Disconnect"], 100)}
}


function Get_WebConfigurator_WebPageLogin_LnkLanguage(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_WebPageLogin(vServer), ["ObjectType", "contentText"], ["Link", "Français"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_WebPageLogin(vServer), ["ObjectType", "contentText"], ["Link", "English"], 100)}
}

function Get_WebConfigurator_WebPageLogin_TxtUsername(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["Textbox", "username"], 100)}

function Get_WebConfigurator_WebPageLogin_TxtPassword(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["PasswordBox", "password"], 100)}

function Get_WebConfigurator_WebPageLogin_BtnConnection(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["SubmitButton", "btnConnect"], 100)}



function Get_WebConfigurator_PnlSidebar(vServer){return Get_WebConfigurator(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "sidebar"], 100)}

function Get_WebConfigurator_PnlSidebar_LnkUsers(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Utilisateurs"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Users"], 100)}
}


function Get_WebConfigurator_PnlSidebar_LnkSecurities(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Titres"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Securities"], 100)}
}


function Get_WebConfigurator_PnlSidebar_LnkUserRequests(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Demandes d'accès"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "User requests"], 100)}
}

function Get_WebConfigurator_PnlSidebar_LnkDefinitions(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Définitions"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_PnlSidebar(vServer), ["ObjectType", "contentText"], ["Link", "Definitions"], 100)}
}

function Get_WebConfigurator_BarHeader(vServer){return Get_WebConfigurator(vServer).FindChild("idStr", "header", 100)}

function Get_WebConfigurator_BarHeader_LblWelcome(vServer)
{
    if (language == "french"){return FindChildCaseSensitive(Get_WebConfigurator_BarHeader(vServer), ["ObjectType", "contentText"], ["Panel", "Bienvenue"], 100)}
    else {return FindChildCaseSensitive(Get_WebConfigurator_BarHeader(vServer), ["ObjectType", "contentText"], ["Panel", "Welcome"], 100)}
}

function Get_WebConfigurator_BarHeader_LnkUsername(vServer, connectedUser){
    var userPanel = FindChildCaseSensitive(Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100), ["ObjectType", "contentText"], ["Panel", connectedUser.toUpperCase()], 100);
    return FindChildCaseSensitive(userPanel, ["ObjectType", "contentText"], ["TextNode", connectedUser.toUpperCase()], 100);
}


//*************** Pref/Config Edition *************

function Get_WebConfigurator_LnkFirm(vServer, firmCode){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", firmCode + "_anchor", true], 100, true, 30000)}

function Get_WebConfigurator_BtnPreferencesAndConfigurations(vServer){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Button", "firmGetPrefsBtn", "firmGetPrefsBtn", true], 100, true, 30000)}

function Get_WebConfigurator_TxtPrefConfigSearchBox(vServer){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Textbox", "prefSearchBox", "prefSearchBox", true], 100, true, 30000)}

function Get_WebConfigurator_LnkPrefConfig(vServer, prefConfigName){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "contentText", "Visible"], ["Link", prefConfigName, true], 100, true, 30000)}



//*************** Pref Edition *************

function Get_WebConfigurator_PnlEditPrefsFirm(vServer){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "editPrefsFirm", "editPrefsFirm", true], 100, true, 30000)}

function Get_WebConfigurator_PnlEditPrefsFirm_ChkUseTheGlobalFirmValue(vServer)
{
    var panelContentText = (language == "french")? "Choisir la valeur de la firme globale": "Use the global firm Value";
    return Get_WebConfigurator_PnlEditPrefsFirm(vServer).FindChildEx(["ObjectType", "contentText", "Visible"], ["Panel", panelContentText, true], 100, true, 10000).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Checkbox", "inherited1", "inherited1", true], 10, true, 3000);
}

function Get_WebConfigurator_PnlEditPrefsFirm_CmbValue(vServer){return Get_WebConfigurator_PnlEditPrefsFirm(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Select", "value", "value", true], 100, true, 5000)}

function Get_WebConfigurator_PnlEditPrefsFirm_BtnApply(vServer){return Get_WebConfigurator_PnlEditPrefsFirm(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Button", "prefApplyBtn", "prefApplyBtn", true], 100, true, 30000)}

function Get_WebConfigurator_PnlEditPrefsSuccessMessage(vServer)
{
    var successPopupMessage = (language == "french")? "La préférence a été enregistrée.": "The preference has been saved.";
    return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "contentText", "Visible"], ["Panel", successPopupMessage, true], 100, true, 30000);
}



//*************** Config Edition *************

function Get_WebConfigurator_PnlEditConfig(vServer){return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "editConf", "editConf", true], 100, true, 30000)}

function Get_WebConfigurator_PnlEditConfig_ChkUseTheGlobalFirmValue(vServer)
{
    var panelContentText = (language == "french")? "Choisir la valeur de la firme globale": "Use the global firm Value";
    return Get_WebConfigurator_PnlEditConfig(vServer).FindChildEx(["ObjectType", "contentText", "Visible"], ["Panel", panelContentText, true], 100, true, 10000).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Checkbox", "inherited1", "inherited1", true], 10, true, 3000);
}

function Get_WebConfigurator_PnlEditConfig_TxtValue(vServer){return Get_WebConfigurator_PnlEditConfig(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Textbox", "value", "value", true], 100, true, 30000)}

function Get_WebConfigurator_PnlEditConfig_BtnApply(vServer){return Get_WebConfigurator_PnlEditConfig(vServer).FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Button", "configSubmitBtn", "configSubmitBtn", true], 100, true, 30000)}

function Get_WebConfigurator_PnlEditConfigSuccessMessage(vServer)
{
    var successPopupMessage = (language == "french")? "La configuration a été modifiée avec succès.": "The configuration has been changed.";
    return Get_WebConfigurator(vServer).FindChildEx(["ObjectType", "contentText", "Visible"], ["Panel", successPopupMessage, true], 100, true, 30000);
}




/*
function Get_WebConfigurator(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/*")}

function Get_WebConfigurator_WebPageLogin(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/login*")}

function Get_WebConfigurator_WebPageUsers(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/users*")}

function Get_WebConfigurator_WebPageSecurities(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/securities*")}

function Get_WebConfigurator_WebPageUserRequests(vServer){return Sys.Browser().Page(vServer + "WebConfigurator/userRequest*")}


function Get_WebConfigurator_BarHeader_LnkDisconnect(vServer)
{
    if (language == "french"){return Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100).FindChild(["ObjectType", "contentText"], ["Link", "Déconnexion"], 100)}
    else {return Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100).FindChild(["ObjectType", "contentText"], ["Link", "Disconnect"], 100)}
}


function Get_WebConfigurator_WebPageLogin_LnkLanguage(vServer)
{
    if (language == "french"){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Français"], 100)}
    else {return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "contentText"], ["Link", "English"], 100)}
}

function Get_WebConfigurator_WebPageLogin_TxtUsername(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["Textbox", "username"], 100)}

function Get_WebConfigurator_WebPageLogin_TxtPassword(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["PasswordBox", "password"], 100)}

function Get_WebConfigurator_WebPageLogin_BtnConnection(vServer){return Get_WebConfigurator_WebPageLogin(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["SubmitButton", "btnConnect"], 100)}



function Get_WebConfigurator_PnlSidebar(vServer){return Get_WebConfigurator(vServer).FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "sidebar"], 100)}

function Get_WebConfigurator_PnlSidebar_LnkUsers(vServer)
{
    if (language == "french"){return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Utilisateurs"], 100)}
    else {return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Users"], 100)}
}

function Get_WebConfigurator_PnlSidebar_LnkSecurities(vServer)
{
    if (language == "french"){return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Titres"], 100)}
    else {return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Securities"], 100)}
}

function Get_WebConfigurator_PnlSidebar_LnkUserRequests(vServer)
{
    if (language == "french"){return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "Demandes d'accès"], 100)}
    else {return Get_WebConfigurator_PnlSidebar(vServer).FindChild(["ObjectType", "contentText"], ["Link", "User requests"], 100)}
}

function Get_WebConfigurator_BarHeader(vServer){return Get_WebConfigurator(vServer).FindChild("idStr", "header", 100)}

function Get_WebConfigurator_BarHeader_LblWelcome(vServer)
{
    if (language == "french"){return Get_WebConfigurator_BarHeader(vServer).FindChild(["ObjectType", "contentText"], ["Panel", "Bienvenue"], 100)}
    else {return Get_WebConfigurator_BarHeader(vServer).FindChild(["ObjectType", "contentText"], ["Panel", "Welcome"], 100)}
}

function Get_WebConfigurator_BarHeader_LnkUsername(vServer, connectedUser){return Get_WebConfigurator_BarHeader(vServer).FindChild("idStr", "div_menu", 100).FindChild(["ObjectType", "contentText"], ["Panel", connectedUser], 100).FindChild(["ObjectType", "contentText"], ["TextNode", connectedUser], 100)}

*/


//Login du Configurateur Web
function WebConfiguratorLogin(vServer, userName, psw, browserName)
{
    Log.Message("Web Configurator Login with : " + userName);
    
    //Internet Explorer is the browser to be used by default
    if (browserName == undefined)
        browserName = "iexplore";
    
    //Close browser and Croesus App
    CloseBrowser(browserName);
    
    //Launch the specified browser and opens the specified URL in it.
    Browsers.Item(browserName).Run();
    Browsers.Item(browserName).Navigate(vServer + "WebConfigurator/");
    
    //Wait until the browser loads the page and is ready to accept user input.
    Get_WebConfigurator_WebPageLogin(vServer).Wait();
    var pageObject = Sys.Browser().Page("*");
    Sys.Browser().BrowserWindow(0).Maximize();
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
    loginForm.Keys("[Tab]^a[Del]" + userName + "[Tab]");
    if (psw != null) loginForm.Keys(psw);;
    loginForm.Keys("[Enter]");
    
    //Wait for the Users webpage to be loaded
    Get_WebConfigurator_WebPageUsers(vServer).Wait();
}



function PrefConfigLookUp(vServer, prefConfigName)
{
    Get_WebConfigurator_TxtPrefConfigSearchBox(vServer).Click();
    Get_WebConfigurator_TxtPrefConfigSearchBox(vServer).Keys("^a[Del]" + prefConfigName + "[Enter]");
}


function FindChildCaseSensitive(parentObject, PropNames, PropValues, Depth, Refresh)
{
    var foundObject = parentObject.FindChild(PropNames, PropValues, Depth, Refresh);
    
	if (foundObject != null && foundObject.Exists){
    
        if (GetVarType(PropNames) != varArray && GetVarType(PropNames) != varDispatch){
            PropNames = new Array(PropNames);
            PropValues = new Array(PropValues);
        }
        
        for (var i = 0; i < PropNames.length; i++){
            if (GetPropertyValue(foundObject, PropNames[i]) != PropValues[i])
		        return Utils.CreateStubObject();
        }
    }
	
	return foundObject;
}
