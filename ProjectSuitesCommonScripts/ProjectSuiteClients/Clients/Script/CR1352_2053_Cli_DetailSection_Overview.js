//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Modification permise dans info clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2075
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_2053_Cli_DetailSection_Overview()
 {    
// script spécifique a BNC
   
      var rootClient="800075";
      var rootClient1="800228"
      var secondaryClient="800076";    
      var roots= GetData(filePath_Clients,"CR1352",202,language);   
      var address=GetData(filePath_Clients,"CR1352",204,language);
      var relationships=GetData(filePath_Clients,"CR1352",205,language);
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
      //sélectionner le client
      Search_Client(rootClient);
      
      //Valider le nombre d’items affichés dans chaque bloc  
      for (var i=1; i<=3;i++){
         if(aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "",i).WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,GetData(filePath_Clients,"CR1352",242+i,language))){
            Log.Message("Dans le bloc "+i+" il y a "+GetData(filePath_Clients,"CR1352",242+i,language)+ "items")
         }
         else{
            Log.Error("Le nombres des items est erroné dans le bloc "+i)
         }
      }
            
      //Valider les numéros de compte affichés dans le bloc "racines"  
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10), "IsEnabled", cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",246,language),10), "IsEnabled", cmpEqual,true)
      //Valider les numéros de compte affichés dans le bloc "Mêmes adresses" 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",rootClient,10), "IsEnabled", cmpEqual,true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",247,language),10), "IsEnabled", cmpEqual,true)
      //Valider la relation affichée dans le bloc "relations" 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",248,language),10), "IsEnabled", cmpEqual,true)
            
      
      //sélectionner le client
      Search_Client(rootClient1);
      
      //Valider qu’un seul bloc s’affiche et il contient un seul compte    
      aqObject.CheckProperty(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.bottomGroupBox.zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).Items,"Count", cmpEqual,GetData(filePath_Clients,"CR1352",249,language))
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "",1).WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,GetData(filePath_Clients,"CR1352",249,language) );
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient1,10), "IsEnabled", cmpEqual,true)
         
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();

 }
 