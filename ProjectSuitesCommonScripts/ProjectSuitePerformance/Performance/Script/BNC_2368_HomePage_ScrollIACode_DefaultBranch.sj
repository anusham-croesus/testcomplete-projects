//USEUNIT Common_functions
//USEUNIT WebConfigurator_Get_functions
//USEUNIT Global_variables

function BNC_2368_HomePage_ScrollIACode_DefaultBranch(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "BNC_2368_HomePage_ScrollIACode_DefaultBranch";
        var codeBNC2368 = "0A02";//ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "codeBNC2368", language+client);
        var waitTime = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "shortTime", language+client);

                
        try {
            // Se connecte
            Login_WebConfigurator(vServerPerformance, userNamePerformanceWebConfig, pswPerformanceWebConfig, language, browserName);
    
            var PageActif = Sys.Browser(browserName).Page(vServerPerformance + "*");
    
            PageActif.QuerySelector(classMenusIACode).Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            PageActif.QuerySelector(userMenusSearchByCSS).ClickItem(byIACode);
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            
            // Double clique id firm1
            PageActif.QuerySelector(firm1CSS).DblClick();
            WaitObject(PageActif, "idStr", "region-1_anchor");
            
            // Double clique id region1
            PageActif.QuerySelector(region1CSS).DblClick();
            WaitObject(PageActif, "idStr", "branch-DEFAULT_anchor");
            
            // Double clique id branch-DEFAULT
            PageActif.QuerySelector(defaultBranch).DblClick();
    
            StopWatchObj.Start();
            WaitObject(PageActif, ["idStr","VisibleOnScreen"], [codeBNC2368 + "_anchor", true], waitTime);
            StopWatchObj.Stop();
    
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        }
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            var PageActif = Sys.Browser(browserName).Page(vServerPerformance + "*");
            WaitObject(PageActif, "className", "profileaccount");
            PageActif.QuerySelector(logoutList).Click();
            WaitObject(PageActif, "idStr", "menulogout");
            PageActif.QuerySelector(logoutBtn).Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            Terminate_IEProcess();
        }
    
}

function test()
{
//   Browsers.Item(GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 3)).Run(vServer + "WebConfigurator");
// Log.Message( GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 3));
 
//        NameMapping.Sys.Browser("iexplore").Page("http://nfrtestqa1.croesus.local/AuthServices/login?ReturnUrl=%2FAuthServices%2Fconnect%2Fauthorize%2Fcallback%3Fresponse_type%3Dcode%26client_id%3D85BC0A083BA16B3710CD46AC03511CF5%26redirect_uri%3Dhttp%253A%252F%252Fnfrtestqa1.croesus.local%252FWebConfigurator%252FloginCallback%26scope%3Dopenid%2520profile%2520croesusapi%2520croesusclaims").Panel(0).Panel("login_view").Panel(2).Panel(0).Form(0).Button(0)
        var PageActif = Sys.Browser().Page(vServerPerformance + "*");
        var LoginViewPanel = PageActif.Panel(0).Panel("login_view");
        
        var UserNameTextBox = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(0).Panel(0).Panel(0).Panel(0).Textbox("Username");
        var PasswordTextBox = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(0).Panel(0).Panel(1).Panel(0).PasswordBox("Password");
        var ConnexionButton = LoginViewPanel.Panel(1).Panel(0).Form(0).Panel(2).Panel(0).Button("button")
        var LanguageButton  = LoginViewPanel.Panel(2).Panel(0).Form(0).Button(0);
        Sys.HighlightObject(LanguageButton);
 
        Log.Message("ObjectLabel : "+LanguageButton.ObjectLabel)
        //Change Language if needed
        var LanguageLabel = (language == "french")? "language Français": "language English";
        Log.Message(language+" - LanguageLabel : "+LanguageLabel)
        if(LanguageButton.ObjectLabel == LanguageLabel){
            LanguageButton.HoverMouse(15,25);
            LanguageButton.Click();    
        } 
        
        UserNameTextBox.Keys(userNamePerformanceWebConfig);
        PasswordTextBox.Keys(pswPerformanceWebConfig);
        
        ConnexionButton.Click(); 

 
}