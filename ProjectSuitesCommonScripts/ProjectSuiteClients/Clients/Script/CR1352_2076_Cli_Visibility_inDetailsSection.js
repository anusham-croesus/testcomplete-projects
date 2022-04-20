//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Vérifier que selon l'utilisateur qui est logué l'affichage dans la section Sommaire du module client est restrictif au code de représentant.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2076
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2076_Cli_Visibility_inDetailsSection()
 {  
// Script spécifique a BNC
   
      var rootClient="800060"
      var client1="800060"
      var client2="800061"
      var client3="800272"
      var client4="900272"
      var sameAddress= GetData(filePath_Clients,"CR1352",204,language)
    
      Login(vServerClients, "KEYNEJ", psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
        
      //sélectionner le client
      Search_Client(rootClient);
      
      WaitObject(Get_CroesusApp(), "Uid", "HierarchyPanel_8528");  
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client1,10),"IsVisible",cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client2,10),"IsVisible",cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client3,10),"IsVisible",cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client4,10),"IsVisible",cmpEqual,true)
         
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
    
      Login(vServerClients, "KENNEJ", psw, language);
      Get_ModulesBar_BtnClients().Click();
    
      //sélectionner le client
      Search_Client(rootClient);
    
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client1,10),"IsVisible",cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client2,10),"IsVisible",cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client3,10),"Exists",cmpEqual,false)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",sameAddress,10).Find("OriginalValue",client4,10),"Exists",cmpEqual,false)
           
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
 
 }