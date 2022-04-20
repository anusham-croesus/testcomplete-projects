//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description :Fonction Aide dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1445
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1445_Cli_ContentsIndexHelp_inManageFilter()
 {
    
    //fermer iexplore
    while(Sys.waitProcess("iexplore").Exists){
        Sys.Process("iexplore").Terminate();
    }    
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click()
    
    Get_MainWindow().Maximize();
    
    //fermer  iexplore
    while(Sys.waitProcess("iexplore").Exists){
        Sys.Process("iexplore").Terminate();
    }

    //afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter. 
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();  
     
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().ClickR();
    Get_WinFilterManager_DgvFilters_ContextualMenu_Help().Click();
    Get_WinFilterManager_DgvFilters_ContextualMenu_Help_ContentsAndIndex().Click();
    
    var filter=GetData(filePath_Clients,"CR1352",123,language);
    var length=aqString.GetLength(vServerClients)
    var subString= aqString.SubString(vServerClients, 7, length-7)
     
    //aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#"+GetData(filePath_Clients,"CR1352",127,language)+".htm").Frame(0).Frame("topic").TextNode(0), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",127,language));
    aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#Welcome.htm").Frame(0).Frame("topic").TextNode(1), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",127,language));
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 