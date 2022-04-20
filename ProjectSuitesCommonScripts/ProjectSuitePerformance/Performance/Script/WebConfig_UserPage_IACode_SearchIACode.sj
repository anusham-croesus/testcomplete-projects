//USEUNIT Common_functions
//USEUNIT WebConfigurator_Get_functions
//USEUNIT Global_variables

function WebConfig_UserPage_IACode_SearchIACode(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "WebConfig_UserPage_IACode_SearchIACode";
        var code = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "iacode", language+client);
        var user = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "userid", language+client);
        var waitTime = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "shortTime", language+client);
        
        //var useNumber = Execute_SQLQuery_GetField("select * from B_USER where STATION_ID = " + "'"+user+"'" ,vServerPerformance,"USER_NUM");
        var useNumber = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataWebConfigurator, "bada1865ID", language+client);
                
        try {
            // Se connecte
            Login_WebConfigurator(vServerPerformance, userNamePerformanceWebConfig, pswPerformanceWebConfig, language, browserName);
    
            var PageActif = Sys.Browser(browserName).Page(vServerPerformance + "*");
    
            PageActif.QuerySelector(classMenusUser).Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            PageActif.QuerySelector(userMenusSearchByCSS).ClickItem(byUser);
            Sys.Browser().Page(vServerPerformance + "*").Wait();
    
            PageActif.QuerySelector(userMenusSearchBoxCSS).Keys(user + "[Enter]");
            WaitObject(PageActif.Find("idStr","configTree",100), "ObjectIdentifier", "user_anchor", waitTime);
            
            PageActif.Find("idStr","configTree",100).Find("idStr", "user-" + useNumber + "_anchor").Click();
            Sys.Browser().Page(vServerPerformance + "*").Wait();
            
            //clique le stylo Codes de CP sur la page d'informaition Utilisateur
            PageActif.QuerySelector(addIACodeCSS).Click();
            WaitObject(PageActif, "idStr", "cboxLoadedContent");
            Delay(5000);
            
            //recherche codes de CP
            PageActif.QuerySelector(IACodeUSerPageSearchBoxCSS).Keys(code + "[Enter]");
            
            StopWatchObj.Start();
            WaitObject(PageActif.Find("idStr","cPTree",100), ["idStr","VisibleOnScreen"], [code + "_anchor", true], waitTime);
            StopWatchObj.Stop();
    
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            PageActif.QuerySelector(cancelIACodeBtn).Click();
            
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

function Execute_SQLQuery_GetField(queryString, vServer, fieldName)
{

    var query = queryString;
	  
    var Qry = ADO.CreateADOQuery();
    Qry.ConnectionString ="Provider=MSDASQL.1;Password=oeillet3;Persist Security Info=False;User ID=qa;Data Source=nfr_syb01";
	  
    Qry.SQL=query;
    Qry.Open();
    Qry.First();
    var value = Qry.FieldByName(fieldName).Value;
    Qry.Close();
    
    return value;
}