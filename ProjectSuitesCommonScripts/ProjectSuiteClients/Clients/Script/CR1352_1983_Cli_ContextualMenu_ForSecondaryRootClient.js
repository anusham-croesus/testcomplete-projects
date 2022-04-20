//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions

/* Description : Menu contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1983
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
function CR1352_1983_Cli_ContextualMenu_ForSecondaryRootClient()
{
    try {
        var rootClient="800241"
        var secondaryClient="800241-FS"     
        var roots= GetData(filePath_Clients,"CR1352",202,language)  
        var accounts= GetData(filePath_Clients,"CR1352",206,language) 
    
        Login(vServerClients,userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
    
        Get_MainWindow().Maximize(); 
    
        //fermer  iexplore
        while (Sys.waitProcess("iexplore").Exists){
            Sys.Process("iexplore").Terminate();
        }
    
        //chercher un client 
        Search_Client(rootClient);
        if (client == "BNC" ){
        var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("ClrClassName","DataRecordPresenter",10).get_ActualWidth();
        var height= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("ClrClassName","DataRecordPresenter",10).get_ActualHeight();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("ClrClassName","DataRecordPresenter",10).set_IsExpanded(true); // Click((width+5)-width, (height+5)-height);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("ClrClassName","DataRecordPresenter",10).WaitProperty("IsExpanded", true, 1000)
        }
        Invoke_contextualMenu(secondaryClient)
    
        //Vérifier que le menu contextuel apparait contenant les fonctions suivantes : Info, Detail, Supprimer, dissocier , Performance, Restrictions, Associer , Aide , Imprimer 
        Check_ContextualMenu_Properties();
    
        //Cliquer sur Info 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtAccountNumber(), "Text", cmpEqual, secondaryClient);
        Get_WinAccountInfo_BtnCancel().Click();
    
        //Cliquer sur perfomance
        Invoke_contextualMenu(secondaryClient) 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance().Click();
        aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpContains, secondaryClient);
        Get_WinPerformance().Parent.Position(400, 25, Get_WinPerformance().Parent.Width, Get_WinPerformance().Parent.Height);//Christophe: Stabilisation
        Get_WinPerformance_BtnClose().Click();
    
        //Cliquer sur Aide/AideContextuel
        Invoke_contextualMenu(secondaryClient)
        /*Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help().Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help_ContextSensitiveHelp().Click();*/ //EM : 90-07-23-CO : Modifié selon le Jira CROES-9172
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",accounts,10).Find("OriginalValue",secondaryClient,10).Keys("[F1]");
    
        var length=aqString.GetLength(vServerClients)
        var subString= aqString.SubString(vServerClients, 7, length-7)
   
        if (language == "french"){
            aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/"+GetData(filePath_Clients,"CR1352",126,language)+"/Default.htm#cshid=C_CLIENT_WINDOW_PAD").Panel("body").Panel("contentBody").Panel("contentBodyInner").Frame("topic").Panel(0).Panel(0).Table(0).Cell(0, 1).TextNode(0), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",230,language)); //EM : 90-07-CO-18   
            //aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#Clients_module\\Clients_module_overview.htm").Frame(0).Frame("topic").TextNode(1), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",230,language));
        }
        else{
            //aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#Clients_Module\\Clients_Module_Overview.htm").Frame(0).Frame("topic").TextNode(1), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",230,language));
            aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/"+GetData(filePath_Clients,"CR1352",126,language)+"/Default.htm#cshid=C_CLIENT_WINDOW_PAD").Panel("body").Panel("contentBody").Panel("contentBodyInner").Frame("topic").Panel(0).Panel(0).Table(0).Cell(0, 1).TextNode(0), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",230,language)); //EM : 90-07-23-CO
        }
        Log.Message("CROES-4464");
        
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}

 
 function Check_ContextualMenu_Properties()
 {
    //Vérifier que le menu contextuel apparait contenant les fonctions suivantes : Info, Detail, Supprimer, dissocier , Performance, Restrictions, Associer , Aide , Imprimer 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Detail(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(),"IsEnabled",cmpEqual,false);
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(),"IsEnabled",cmpEqual,false);
    }
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign(),"IsEnabled",cmpEqual,true);
    Log.Message("CROES-9172")
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help(),"IsEnabled",cmpEqual,true); //EM : 90-07-23-CO : Modifié selon le Jira CROES-9172
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Print(),"IsEnabled",cmpEqual,true);
 }
 
function Invoke_contextualMenu(secondaryClient)
{
    var roots= GetData(filePath_Clients,"CR1352",202,language);  
    var accounts= GetData(filePath_Clients,"CR1352",206,language); 
    
    if (client == "BNC" ){
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",accounts,10).Find("OriginalValue",secondaryClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",accounts,10).Find("OriginalValue",secondaryClient,10).ClickR();  
    }
    else{
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",accounts,10).Find("OriginalValue",secondaryClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",accounts,10).Find("OriginalValue",secondaryClient,10).ClickR();  
    }
}
