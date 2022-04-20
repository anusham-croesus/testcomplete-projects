//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1480
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1480_Cli_ContextSensitiveHelp()
 {        
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //fermer  iexplore
    while(Sys.waitProcess("iexplore").Exists){
        Sys.Process("iexplore").Terminate();
    }
   
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click();        
        
    Get_WinSearchCriteriaManager_DgvCriteria().ClickR();
    Get_WinFilterManager_DgvFilters_ContextualMenu_Help().Click();
    Get_WinFilterManager_DgvFilters_ContextualMenu_Help_ContextSensitiveHelp().Click();
    
    //Une page web s'ouvrira sur le survol des critère de recherche 
    var length=aqString.GetLength(vServerClients)
    var subString= aqString.SubString(vServerClients, 7, length-7)
    Log.Message("YR:La réponse de Karima 12/02/2018 :CROES-8440")  
    Log.Message("EM: Le titre de la page n'est plus le même, il faut changer le datapool. Changement effectué pour l'url mais pas pour le titre")   
    //aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#").Frame(0).Frame("topic").TextNode(0), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",358,language));
    aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#"+GetData(filePath_Clients,"CR1352",299,language)+"\\"+GetData(filePath_Clients,"CR1352",300,language)+".htm").Frame(0).Frame("topic").TextNode(0), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",358,language)); //EM: url modifié le 1er url est erroné 
    Get_WinSearchCriteriaManager_BtnClose().Click();
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
        
 }