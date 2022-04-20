//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CR1352_1983_Cli_ContextualMenu_ForSecondaryRootClient

/* Description : Menu contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1983
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_1983_Cli_ContextualMenu_ForRootClientAndRel()
 {    
  if(client == "TD" || client == "CIBC" )  {
   var rootClient="300001"; 
  } 
  else {
    var rootClient="800241"; }
    if (client == "BNC" ){      
      var relationshipsValue="#3 TEST";
    }
    if(client == "TD" ){
      var relationshipsValue="00000";
    }
    if(client == "CIBC"){
      var relationshipsValue="00003"; 
    } 
    if(client == "RJ"){
      var relationshipsValue="#3 TEST";
    }
    if(client == "US" ){
     var relationshipsValue="0000R";
    } 
    if(client == "VMD" ){
     var relationshipsValue="00002";
    } 
    
    var roots= GetData(filePath_Clients,"CR1352",202,language);  
    var accounts= GetData(filePath_Clients,"CR1352",206,language); 
    var relationships= GetData(filePath_Clients,"CR1352",205,language);
     
    Login(vServerClients,userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
   
    //chercher un client 
    Search_Client(rootClient);    
    WaitObject(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel(), "Uid", "HierarchyPanel_8528", 10);
    
    if (client == "BNC" ){    
      //Dans la section détail. Sélectionner la racine 800240 et faire un click droit 
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).ClickR();
    }
    else{//RJ
       //Dans la section détail. Sélectionner la racine 800240 et faire un click droit 
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).ClickR();
     // Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).ClickR();
      
    }
    //Vérifier que le menu contextuel apparait contenant les fonctions suivantes : Info, Detail, Supprimer, dissocier , Performance, Restrictions, Associer , Aide , Imprimer 
    Check_ContextualMenu_Properties();   
    
    //Cliquer sur Info 
    
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info().Click();
    if(client == "TD" || client == "CIBC" ){
    aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, "VALIDATIONS CALC: 300001");
    } 
    else {
    aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, "ALARY ANNY: 800241");}
    Get_WinDetailedInfo_BtnCancel().Click();
       
    //Sélectionner la relation et faire un click droit 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).Click(); 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).ClickR();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).ClickR();  
    
    //Vérifier que le menu contextuel apparait contenant les fonctions suivantes : Info, Detail, Supprimer, dissocier , Performance, Restrictions, Associer , Aide , Imprimer 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Detail(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(),"IsEnabled",cmpEqual,true);
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(),"IsEnabled",cmpEqual,false);
    }
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign(),"IsEnabled",cmpEqual,true);
    Log.Message("CROES-9172")
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help(),"IsEnabled",cmpEqual,true); //EM : 90-07-23-CO : Modifié selon le Jira CROES-9172
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Print(),"IsEnabled",cmpEqual,true);;  
     
    //Cliquer sur Détail 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Detail().Click();
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton().DataContext,"TabTextHeader", cmpContains,relationshipsValue);
     
    Close_Croesus_AltQ()
 }