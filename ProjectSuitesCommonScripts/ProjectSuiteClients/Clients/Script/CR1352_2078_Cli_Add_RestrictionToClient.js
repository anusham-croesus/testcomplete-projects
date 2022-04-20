//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Ajouter une restriction a un client 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2078
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2078_Cli_Add_RestrictionToClient()
 {    
//Script spécifique pour BNC
  
      var clientNo="800075"
      var roots= GetData(filePath_Clients,"CR1352",202,language)
      var owners= GetData(filePath_Clients,"CR1352",203,language)
    
      Login(vServerClients, userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
    
      //sélectionner le client 
      Search_Client(clientNo);
    
      //Le bouton Restrictions n'est pas disponible sur le ClientToolBar 
      Get_MainWindow().Keys("[Apps]")
      Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
   
     //La fonction Restrictions n'existe pas dans le menu contextuel
      aqObject.CheckProperty(Get_RelationshipsAccountsGrid_ContextualMenu_Functions_Restrictions(),"IsVisible",cmpEqual,false);
    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Value","800075",10).ClickR();
    
      //La fonction Restrictions est grisée dans le menu contextuel
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,false);
  
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",clientNo,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",clientNo,10).ClickR();
      //La fonction Restrictions n'est pas grisée dans le menu contextuel
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,true);
    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",clientNo,10).Click();
      //Mailler  vers le module comptes    
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Accounts().Click();
      Get_MenuBar_Modules_Accounts_DragSelection().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
  
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",owners,10).Find("OriginalValue",clientNo,10).ClickR()
      //La fonction Restrictions est grisée dans le menu contextuel
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,false)
         
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();

 }
 

