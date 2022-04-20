//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
   https://jira.croesus.com/browse/TCVE-2961
    
   
    Description : Ce Script regroupe les fonctions utilisées dans le script TCVE_2961_Validate_Saving_The_Selection_In_The_User_Menu 
           
   
    Analyste auto : Alhassane Diallo
    
    Version : 90.24.2021.04-3
    
    Date: 03/03/2021
*/



//Login
function Login_TCVE2961(vServer, userName, psw, language, browserName, debugMode)
{
	try {
        EnableLoginTimeOutTimer(720000); //Enable Login timeout timer: 12-minutes (720000 ms)
        var LogErrCountBeforeLoginFirstTry = Log.ErrCount;
        if (typeof LOGIN_ERROR_COUNT_TO_DISCARD == 'undefined' || LOGIN_ERROR_COUNT_TO_DISCARD == undefined)
            LOGIN_ERROR_COUNT_TO_DISCARD = 0;
        
		Login_Once(vServer, userName, psw, language, browserName, debugMode);
	}
	catch(loginException) {
		//Log.Warning("Exception during Login first try. Wait a while and try once again.", loginException.message, pmHigher, null, Sys.Desktop.Picture());
        Log.Warning("Exception during Login first try. " + loginException.message + ". Trying once again...", VarToStr(loginException.stack), pmHigher, null, Sys.Desktop.Picture());
		//Delay(5000); //Mis en commentaire, best practice: Il vaut mieux faire une validation que de de rester idle. Ces validations sont dans Login_Once et les functions qu'il utilise.
        Delay(5000); //Avant d'avoir éventuellement fait une validation précise, il vaut mieux pour le moment conserver ce temps d'attente statique de 5 secondes car il contribue à une meilleure stabilité.
		loginException = null;
        LOGIN_ERROR_COUNT_TO_DISCARD += Log.ErrCount - LogErrCountBeforeLoginFirstTry;
        
        try {
		    Login_Once(vServer, userName, psw, language, browserName, debugMode);
        }
        catch(loginException2) {
            Log.Error("Exception during Login second try. " + loginException2.message, VarToStr(loginException2.stack), pmHigher, null, Sys.Desktop.Picture());
            loginException2 = null;
        }
	}
    finally {
        DisableLoginTimeOutTimer(); //Disable Login timeout timer
    }
}



//Login once
function Login_Once(vServer, userName, psw, language, browserName, debugMode)
{
    Log.Message("Croesus Login with : " + userName, "vServer URL =  " + vServer);
    
    //Launch the specified browser and open the specified URL in it.
    Login_InitializeAndLaunchBrowser(vServer, browserName, debugMode);
    
    //Fill Webpage and Launch Croesus.
    switch (versionReference){
        case "MAINLINE-90-18-45":
            Login_FillAndLaunchCroesus_Version_MAINLINE_90_18_45(vServer, userName, psw, language, browserName);
            break;
            
        default:
            throw new Error("Variable versionReference value not supported : '" + VarToStr(versionReference) + "'.");
    }
    
    //Run Click Once.
    Login_RunClickOnce();
    
    //End Login
    Login_End();
}


function Login_InitializeAndLaunchBrowser(vServer, browserName, debugMode)
{
    var maxNbOfTries = 3;
    var debudModeString = (debugMode)? debugMode: "";
    
    //Internet Explorer is the browser to be used by default
    if (browserName == undefined)
        browserName = "iexplore";
    
    //Close Processes
    TerminateProcess("dfsvc");
    Terminate_CroesusProcess();
    
    //Launch the specified browser and opens the specified URL in it
    Log.Message("Launch browser '" + browserName + "' and navigate to the '" + vServer + debudModeString + "' page...");
    var nbOfTries = 0;
    do {
        nbOfTries++;
        CloseBrowser(browserName);
        if (nbOfTries > 1){
            Log.Warning("Navigating to the " + vServer + " page may have previously failed. Try " + nbOfTries + "/" + maxNbOfTries + "...", "", pmNormal, null, Sys.Desktop.Picture());
            Delay(30000);
        }
        
        Browsers.Refresh();
        Browsers.Item(browserName).Run();
        if (!Sys.WaitBrowser(browserName, 60000).Exists || !Sys.WaitBrowser(browserName).WaitBrowserWindow(0, 60000).Exists)
            Browsers.Item(browserName).Run();
        
        if (Sys.WaitBrowser(browserName, 60000).Exists && Sys.WaitBrowser(browserName).WaitBrowserWindow(0, 60000).Exists)
            Browsers.Item(browserName).Navigate(vServer + debudModeString);
        else
            Browsers.Item(browserName).Run(vServer + debudModeString);
        
    } while ((nbOfTries < maxNbOfTries) && !(Sys.Browser().WaitPage(vServer + "*", 60000).Exists));
}


//Login >= MAINLINE-90-18-45
function Login_FillAndLaunchCroesus_Version_MAINLINE_90_18_45(vServer, userName, psw, language, browserName)
{
    var maxNbOfTries = 3;
    
    if (projet == "PerformanceEVOL"){
        WaitObject(Sys.Browser(browserName).Page(vServer), ["ObjectType", "VisibleOnScreen"],["Login",true]);
        
        var securityPanel = Sys.Browser(browserName).Page(vServer).Login;
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
    
    //Check if VServer webpage exists
    if (!(Sys.Browser().WaitPage(vServer + "*", 60000).Exists))
        throw new Error("Navigating to the " + vServer + " page failed by timeout.");

    //Wait until the browser loads the page and is ready to accept user input.
    Log.Message("Navigating to the " + vServer + " page is successful.");
    Sys.Browser().Page(vServer + "*").Wait();
    var pageObject = Sys.Browser().Page("*");
    Sys.Browser().BrowserWindow(0).Restore();
    Sys.Browser().BrowserWindow(0).Maximize();
    
    //Change Language if needed
    var languageChangeTriesLeft = maxNbOfTries;
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
            if (!headerPanel.Exists)
                loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 3000);
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
            if (signOutButton.Exists && !signOutButton.WaitProperty("Exists", false, 10000) && !signOutButton.WaitProperty("VisibleOnScreen", false, 5000)){
                signOutButton.Refresh();
                if (signOutButton.Exists && signOutButton.VisibleOnScreen)
                    signOutButton.Click();
            }
            
            //Wait for Login panel
            loginPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "login_view", "login-view", true], 10, true, 15000);
        }
        
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
    var rememberLogin           = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Label", "0", true], 10, true, 5000);
    var checkboxRememberLogin   = loginForm.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Checkbox", "RememberLogin", true], 10, true, 5000);
    var value = checkboxRememberLogin.checked

    if(value){
       
       aqObject.CheckProperty(txtUsername,"Text", cmpEqual, userName)
       
       txtPassword.Click();
       txtPassword.Keys("^a[BS]");
       txtPassword.Keys(psw);
       rememberLogin.Click();       
    }else{
        
      txtUsername.Click();
      txtUsername.Keys("^a[BS]");
      txtUsername.Keys(userName);
      txtPassword.Click();
      txtPassword.Keys("^a[BS]");
      txtPassword.Keys(psw);
      rememberLogin.Click(); 
    }
    




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
    
    
    //From DBA
    function GetDBAConnectionString(vServerURL)
    {
        var source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
        if (client == "CIBC") 
               source = "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb02";
        if (projet == "PerformanceNFR" || projet == "Performance"){
            //return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
            return source;
        }
        else if (projet == "General"){
            var BDNum = aqString.SubString(vServerURL, 19, 2);
            return "Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=qa_auto" + BDNum;
        }
        else {
            Log.Error("Valeur '" + projet + "' non supportée pour la variable globale : projet.");
            return "";
        }
    }
    
    //From DBA
    function Execute_SQLQuery(queryString, vServer) 
    {
        var query= queryString;
        var Qry =ADO.CreateADOQuery();
        Qry.ConnectionString =GetDBAConnectionString(vServer);
        Qry.SQL=query;
        Qry.ExecSQL();
    }
}









//fonction qui valide  la sauvegarde de la selection dans le menu Utilisateur dans les differents environnements
function Validate_Saving_The_Selection_In_The_User_Menu(critereName, filterName, idUser, TitleWin, TotalValueTab, TotalValue, RelationName, note2961, clientFictifName, typePicker, positionDIS, targetValueDIS, filterAccountFictif){
    

      Get_ModulesBar_BtnDashboard().Click();    
      Get_MainWindow().Maximize();
      
      
      //Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic et appliquer
      Log.Message("Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic ou Deslaujeet appliquer") 
      
      

      Get_MenuBar_Users().Click();
      Get_MenuBar_Users_Selection().Click();
      Get_WinUserMultiSelection_TabUsers().Click(); 
   
      Get_WinUserMultiSelection_ClickButtonFilter();
      Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_LastName().Click();
      Get_WinCreateFilter_TxtValue().Keys(critereName);
      Get_WinCreateFilter_BtnSaveAndApply().Click();
   
      Get_WinSaveFilter_TxtName().Keys(filterName);
      Get_WinSaveFilter_BtnOK().Click();
      Get_WinUserMultiSelection().Find("Value",idUser,10).Click();
      Get_WinUserMultiSelection_BtnApply().Click();
   
/******************************************************************************Étape2******************************************************************/
      // Ajouter un nouveau tableau en se basant sur un critère de recherche :Total value
      Log.PopLogFolder();
      logEtape1 = Log.AppendFolder("Étape 2: Ajouter un nouveau tableau en se basant sur un critère de recherche :Langue Anglaise");

      WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWin]);

      Get_Toolbar_BtnAdd().Click();
      Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion().Click();
      Get_DlgAddBoard_BtnOK().Click();

      Get_WinAddSearchCriterion_TxtName().Keys(TotalValueTab);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
      Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click()
      Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(TotalValue) 
      
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
       
/***************************************************************Étape3*************************************************************/  
      //Mailler deux clients du nouveau tableau vers le module clients
      Log.PopLogFolder();
      logEtape3= Log.AppendFolder("Étape 3: Mailler deux clients du nouveau tableau vers le module clients "); 
       
      Get_Dashboard_GenericCriteriaBasedBoard().WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
//      Get_Dashboard_GenericCriteriaBasedBoard().WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Click(-1, -1, skCtrl);
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Clients().Click();
      Get_MenuBar_Modules_Clients_DragSelection().Click();   
          
    
/**************************************************************************Étape4**************************************************************************/
      Log.PopLogFolder();
      logEtape4= Log.AppendFolder("Étape 4: Mailler le clients vers le module comptes et faire une sommation ( noter le nombre de comptes ) "); 
      
      Get_MainWindow().Keys("^a");
      Get_MenuBar_Modules().Click();
      if(!Get_SubMenus().Exists){
          Get_MenuBar_Modules().Click();
      }
      Get_MenuBar_Modules_Accounts().Click();
      Get_MenuBar_Modules_Accounts_DragSelection().Click();
      Get_Toolbar_BtnSum().Click();
      if(Get_WinRelationshipsClientsAccountsSum().Exists){
          Log.Checkpoint("la sommation fonctionne");
      }
      
      Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();  
    
/*********************************************************************Étape5*************************************************************************/          
      //Faire un ctrl+ A pour selectionner tous les comptes et faire un  click droit et ajouter une nouvelle relation
      Log.PopLogFolder();
      logEtape5 = Log.AppendFolder("Étape 5: Faire un ctrl+ A pour selectionner tous les comptes et faire un  click droit et ajouter une nouvelle relation  "); 
      
      Get_MainWindow().Keys("^a");
      Get_RelationshipsClientsAccountsGrid().ClickR();
      Get_RelationshipsClientsAccountsGrid().ClickR();
      Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
      Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
      Get_WinAssignToARelationship_BtnYes().Click();
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationName);
      Get_WinDetailedInfo_BtnOK().Click();   
                      
/**************************************************************************Étape6*************************************************************************/
      //Mailler deux clients du nouveau tableau vers le module clients      
      Log.PopLogFolder();
      logEtap6 = Log.AppendFolder("Étape 6: Retourner au module tableau de bord , sélectionner les memes clients et mailler les vers le module relations ");   
      Get_ModulesBar_BtnDashboard().Click();
      
      Get_Dashboard_GenericCriteriaBasedBoard().WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Relationships().Click();
      Get_MenuBar_Modules_Relationships_DragSelection().Click();
      
      
/**************************************************************************Étape7*************************************************************************/
       
      //Mailler la relation vers le module portefeuille, Sélectionner 5 premieres postions par un click doit ajouter une note au 5 postions
      Log.PopLogFolder();
      logEtape7= Log.AppendFolder("Étape 7 : Mailler la relation vers le module portefeuille, Sélectionner 5 premieres postions par un click doit ajouter une note au 5 postions "); 
       
      Get_RelationshipsClientsAccountsGrid().FindChild("Text", RelationName, 100).Click();
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Text", RelationName, 100), Get_ModulesBar_BtnPortfolio());

      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click(-1, -1, skCtrl);
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Click(-1, -1, skCtrl);
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).Click(-1, -1, skCtrl);
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 4).Click(-1, -1, skCtrl);
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 5).Click(-1, -1, skCtrl);
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 5).ClickR()
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();
      Get_WinCRUANote_GrpNote_TxtNote().SetText(note2961);
      Get_WinCRUANote_BtnSave().Click();
      if(Get_WinCRUANote().Exists){
         Get_WinCRUANote_BtnSave().Click();
      }

      var count = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count;
      for(var i = 0; i <5; i++){
         aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem ,"HasNote",cmpEqual,true)      
      }
                  
/*****************************************************************Étape8************************************************************************/
      //Grouper le portefeuille par classe d'actif
      Log.PopLogFolder();
      logEtap8 = Log.AppendFolder("Étape 8: Grouper le portefeuille par classe d'actif "); 
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();

      
/*****************************************************************Étape9************************************************************************/
      //Cliquer sur simulations, Modifier la quantité d'une position existante : quantité 10000, Ajouter une nouvelle position : exemple Dis : pourcentage 2% puis sauvegarder 
      Log.PopLogFolder();
      logEtap9 = Log.AppendFolder("Étape 9: Cliquer sur simulations, Modifier la quantité d'une position existante : quantité 10000, Ajouter une nouvelle position : exemple Dis : pourcentage 2% puis sauvegarder "); 
      Get_PortfolioBar_BtnWhatIf().Click();
      Get_PortfolioBar_BtnSave().Click();
      Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().Keys(clientFictifName);
      Get_WinWhatIfSave_BtnOK().Click();
      Get_DlgInformation_BtnOK().Click();

      
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
      Get_PortfolioBar_BtnInfo().Click();
      Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Keys(1000);
      Get_WinPositionInfo_BtnOK().Click();
      
       Get_Toolbar_BtnAdd().Click();
       Get_WinAddPosition_GrpAdd_CmbTypePicker().Click();
       Get_SubMenus().Find("Text",typePicker,10).Click();
       Log.Message(typePicker)
       Get_WinAddPosition_GrpAdd_TxtQuickSearchKey().Keys(positionDIS);
       Get_WinAddPosition_GrpAdd_DlSecurityListPicker().Click(); 
       if(Get_SubMenus().Exists){
            Get_SubMenus().Find("Value",positionDIS,10).DblClick();
       }           
       Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent().Keys(targetValueDIS); 
       Get_WinAddPosition_BtnOK().Click();
       
       
/*****************************************************************Étape10************************************************************************/
      //Aller dans le module compte, cliquer sur Réafficher tout Appliquer le filtre prédéfinis: comptes fictfs 
      Log.PopLogFolder();
      logEtap10 = Log.AppendFolder("Étape 10: Aller dans le module compte, cliquer sur Réafficher tout Appliquer le filtre prédéfinis: comptes fictfs"); 
      Get_ModulesBar_BtnAccounts().Click();        
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);   
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterAccountFictif).Click();
      
       var count =  Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
      for(var i = 0; i <count; i++){
          
        if(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem.Name==clientFictifName){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem ,"Class",cmpEqual,"Fictitious")      
          }
      }
      
}

//fonction quivalide la selection apres reconnexion
function Validate_Saving_The_Selection_In_The_User_Menu_AfterReconnexion(critereNameNFR){
    
/*****************************************************************Étape11************************************************************************/
     //Fermer croesus , On se reconnecte avec le meme user,Valider qu'apres reconnection , on doit garder la meme selection 
      Log.PopLogFolder();
      logEtap11 = Log.AppendFolder("Étape 11: Fermer croesus , On se reconnecte avec le meme user,Valider qu'apres reconnection , on doit garder la meme selection"); 
        

      Get_ModulesBar_BtnDashboard().Click();    
      Get_MainWindow().Maximize();
      
      Get_MenuBar_Users().Click();
      Get_MenuBar_Users_Selection().Click();
      Get_WinUserMultiSelection_TabUsers().Click(); 
      
      var count =  Get_WinUserMultiSelection_TabUsers_DgvUsers().WPFObject("RecordListControl", "", 1).Items.Count;
      for(var i = 0; i <count; i++){
          aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_DgvUsers().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem ,"LastName",cmpEqual,critereNameNFR)      
      }
       aqObject.CheckProperty(Get_WinUserMultiSelection().Find("Value",critereNameNFR,10),"VisibleOnScreen", cmpEqual, true)
      
      
}


//Fonction pour supprimer le client
function DeleteClient_TCVE2961()
{
    

    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
    Get_ModulesBar_BtnClients().Click();
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", "#CLIENT_FICTIF_2", 10).Click();
    Get_Toolbar_BtnDelete().Click();
    Get_DlgConfirmation_BtnYes().Click();   
}


//Fonction pour supprimer le filtre
function deleteFilter(filterName){
     
    Get_WinUserMultiSelection_ClickButtonFilter();
    Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters().Click();
//    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("Value",filterName,10).Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
    Get_DlgConfirmation_BtnYes().Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    Get_WinUserMultiSelection_BtnCancel().Click();
    
    Get_MenuBar_Users().Click();
    Get_MenuBar_Users_Global().Click();
    

}


//Fonction pour ajouter le filtre
function AddCriteria(critereName, filterName){
    
      //Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic et appliquer
      Log.Message("Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic ou Deslaujeet appliquer") 
      Get_MenuBar_Users().Click();
      Get_MenuBar_Users_Selection().Click();
      Get_WinUserMultiSelection_TabUsers().Click(); 
   
      Get_WinUserMultiSelection_ClickButtonFilter();
      Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_LastName().Click();
      Get_WinCreateFilter_TxtValue().Keys(critereName);
      Get_WinCreateFilter_BtnSaveAndApply().Click();
   
      Get_WinSaveFilter_TxtName().Keys(filterName);
      Get_WinSaveFilter_BtnOK().Click();
      Get_WinUserMultiSelection().Find("Value","GPF",10).Click();
      Get_WinUserMultiSelection_BtnApply().Click();

}

//Fonction pour supprimer le filtre compte fictif et compte fictif
function deleteFilterAndFictifAccount(){
    

    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsGrid().FindChild("Text", "#CLIENT_FICTIF_2", 100).Click();
    Get_Toolbar_BtnDelete().Click();
    Get_DlgConfirmation_BtnYes().Click();
    Get_RelationshipsClientsAccountsGrid_ToggleButton(2).Click()

    
}


//Fonction pour supprimer la relation creé
function DeleteRelationship_TCVE2961(RelationshipName)
{
    Log.Message("Delete the relationship \"" + RelationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(RelationshipName);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    if (searchResult.Exists){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        Delay(100);
        
        /*if (Get_DlgConfirmAction_BtnOK().Exists)
            Get_DlgConfirmAction_BtnOK().Click();
        else if (Get_DlgConfirmAction_BtnDelete().Exists)
            Get_DlgConfirmAction_BtnDelete().Click();*/
            
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().WaitProperty("VisibleOnScreen",true,5000);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
    }
    else
        Log.Message("The relationship " + RelationshipName + " does not exist.");
}

//Fonction pour localiser le filtre
function Get_RelationshipsClientsAccountsGrid_ToggleButton(i){
    return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ItemsControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", i], 10)}

function Get_MenuBar_Users_Global()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Global"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Global"], 10)}
}

//fonction qui permets de localiser le tableau creer 
function Get_Dashboard_GenericCriteriaBasedBoard(){return Get_DashboardPlugin().FindChild(["ClrClassName", "PageTitle"], ["GenericCriteriaBasedBoard", "TOTAL_VALUE"], 10)}

//fonction qui permets de supprimer le tableau cree
function deleteCriteria(){

Get_ModulesBar_BtnDashboard().Click();
Get_ModulesBar_BtnDashboard().Click();
delay(1000) 
Get_Dashboard_GenericCriteriaBasedBoard().CloseBoard();
 
Get_Toolbar_BtnAdd().Click();
Aliases.CroesusApp.dlgAddBoard.WPFObject("treeView").WPFObject("TreeViewItem", "TOTAL_VALUE", 1).Click();
Get_DlgAddBoard_BtnDelete().Click();
Get_DlgAddBoard_BtnCancel().Click();

}
