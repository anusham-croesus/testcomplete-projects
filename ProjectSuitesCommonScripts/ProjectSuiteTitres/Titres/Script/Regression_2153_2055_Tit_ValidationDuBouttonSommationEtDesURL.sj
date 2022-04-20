//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 

/**
    
    Description :   - Vérifier le fonctionnement du boutton Sommation
                    - Vérifier le fonctionnement des liens URL pour un titre
                    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2153
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2055 
    Analyste d'automatisation : Amine Alaoui
    Complété par :Abdel Matmat 
    
*/

function Regression_2153_2055_Tit_ValidationDuBouttonSommationEtDesURL(){
 
    try {   
        //lien pour TestLink
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2153");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2055");
        
        var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");            
        
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "SecurityBCE", language+client);
           
        Log.Message("**********************Login********************");
        Login(vServerTitre, userNameKeynej, passwordKeynej, language);
		TerminateProcess(browserName); //Stabilisation par Christophe
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize(); 
                          
        Log.Message("*******  Validation du boutton Sommation  Croes-2153*****");
        
        //var x = Math.round(Math.random()*(7));
        var x = 1 + Math.round(Math.random()*(4));// 2021/09/02: MAJ faite par Christophe
        Get_SecurityGrid().Click(Get_SecurityGrid().Width - 100, 100);
        Sys.Desktop.KeyDown(0x10); //Press SHIFT
        Get_SecurityGrid().Click(Get_SecurityGrid().Width - 100, 100*x);
        Sys.Desktop.KeyUp(0x10); //Release SHIFT
        var selection = 0;
        var count = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).ChildCount;
        for (var i = 0; i < count; i++){          
            if (Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).IsSelected) selection++;
        }
        //Log.Message(selection+"-----------"+count);
        Get_Toolbar_BtnSum().Click();
        //Log.Message(Get_WinSecuritySum().Find("Value","Total",10).DataContext.DataItem.Count);
        aqObject.CheckProperty(Get_WinSecuritySum().Find("Value","Total",10).DataContext.DataItem,"Count",cmpEqual,selection);
        Get_WinSecuritySum_BtnClose().Click();
        
        Log.Message("*******  Validation des URL  Croes-2055*****");
        Get_ModulesBar_BtnSecurities().Click();        
        Search_SecurityByDescription(security);
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        
        if (client != "CIBC"){
              Get_Toolbar_BtnInternetAddresses().Focus();
              Get_Toolbar_BtnInternetAddresses().Click();
              Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes().Click();
              
              Get_CroesusApp().WaitBrowserWindow(0,5000);
              var pageActif = Sys.Browser(browserName).Page("*");
              pageActif.Wait();
              aqObject.CheckProperty(pageActif.Find("idStr","uh-logo",100),"namePropStr",cmpEqual,"ca.finance.yahoo.com");       
              Sys.Browser(browserName).Close();
              Get_ModulesBar_BtnSecurities().Click();
              Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
                        
              Get_Toolbar_BtnInternetAddresses().Click();
              Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs().Click();
              Sys.Browser(browserName).Close();
              Get_ModulesBar_BtnSecurities().Click();
              Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
              
              Get_Toolbar_BtnInternetAddresses().Click();
              Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis().Click();
              Sys.Browser(browserName).Close();
              Get_ModulesBar_BtnSecurities().Click();
              Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
        
              Get_Toolbar_BtnInternetAddresses().Click();          
              Get_Toolbar_BtnInternetAddresses_ContextMenu_News().Click();
              Sys.Browser(browserName).Close();
              Get_ModulesBar_BtnSecurities().Click();
              Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
       
              Get_Toolbar_BtnInternetAddresses().Click();
              Get_Toolbar_BtnInternetAddresses_ContextMenu_Company().Click();
              Sys.Browser(browserName).Close();
              Get_ModulesBar_BtnSecurities().Click();
              Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);               
        }
        //Ces derniers actions sont mis en commentaire à cause du crash que ça cause
//        Get_Toolbar_BtnInternetAddresses().Click();    
//        Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage().Click();
//        
//        Sys.Browser(browserName).Close();
                
        Get_Toolbar_BtnInternetAddresses().Click();
        if(!Get_SubMenus().Exists!=true){Get_Toolbar_BtnInternetAddresses().Click();}
        Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().WaitProperty("VisibleOnScreen", true, 15000);
        Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Click();
        Get_WinComposeAddress_TxtAddress().WaitProperty("VisibleOnScreen", true, 5000);
        Get_WinComposeAddress_TxtAddress().set_Text("www.google.ca");
        Get_WinComposeAddress_BtnLaunch().Click();
        Get_CroesusApp().WaitBrowserWindow(0,5000);
        var pageActif = Sys.Browser(browserName).Page("*");
        pageActif.Wait(2000);
        /*
        //MAJ faite par Christophe ce 2021/02/25 par suite de l'évolution des propriétés de l'image hplogo de Google
        //aqObject.CheckProperty(pageActif.Find("idStr","hplogo",100),"Exists",cmpEqual,true);
        //aqObject.CheckProperty(pageActif.Find("idStr","hplogo",100),"VisibleOnScreen",cmpEqual,true);
        */
        var googleHomePageLogo = (pageActif.FindEx("idStr", "hplogo", 100, true, 15000).Exists)? pageActif.Find("idStr", "hplogo", 100): pageActif.FindEx(["className", "alt", "ObjectType", "ObjectIdentifier"], ["lnXdpd", "Google", "Image", "googlelogo*"], 100, true, 15000);
        aqObject.CheckProperty(googleHomePageLogo, "Exists", cmpEqual, true);
        aqObject.CheckProperty(googleHomePageLogo, "VisibleOnScreen", cmpEqual, true);
        
        //aqObject.CheckProperty(NameMapping.Sys.Browser(browserName).Page("https://www.google.ca/?gws_rd=ssl").Panel("viewport").Panel("main").Panel("lga").Image("hplogo"),"Exists",cmpEqual,true);
        //aqObject.CheckProperty(NameMapping.Sys.Browser(browserName).Page("https://www.google.ca/?gws_rd=ssl").Panel("viewport").Panel("main").Panel("lga").Image("hplogo"),"VisibleOnScreen",cmpEqual,true);
        //Terminate_IEProcess()   
        Sys.Browser(browserName).Close();
        
    }
    catch (e) {            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
    }         
    finally {           
       // Close Croesus 
       Terminate_CroesusProcess();        
    }                    
}



