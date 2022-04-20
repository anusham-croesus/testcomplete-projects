//USEUNIT Common_functions
//USEUNIT WebConfigurator_Get_functions
//USEUNIT Global_variables

function WebConfig_HomePage_SearchUser(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "WebConfig_HomePage_SearchUser";
        var user = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "userid", language+client);
        var waitTime = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "shortTime", language+client);

                
        try {
            // Se connecte
            Login_WebConfigurator(vServerPerformance, userNamePerformanceWebConfig, pswPerformanceWebConfig, language, browserName);
    
            var PageActif = Sys.Browser(browserName).Page(vServerPerformance + "*");
    
            PageActif.QuerySelector(classMenusUser).Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            PageActif.QuerySelector(userMenusSearchByCSS).ClickItem(byUser);
            Sys.Browser().Page(vServerPerformance + "*").Wait();
    
            PageActif.QuerySelector(userMenusSearchBoxCSS).Keys(user + "[Enter]");
    
            StopWatchObj.Start();
            WaitObject(PageActif.Find("idStr","configTree",100), ["ObjectIdentifier","VisibleOnScreen"], ["user_anchor", true], waitTime);
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
            PageActif.QuerySelector(logoutList).Click();
            WaitObject(PageActif, "idStr", "menulogout");
            PageActif.QuerySelector(logoutBtn).Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            Terminate_IEProcess();
        }
    
}