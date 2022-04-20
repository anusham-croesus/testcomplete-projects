//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : valider l'affichage de l'information avec le bouton + dans le détail
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2071
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
 function CR1352_2071_Cli_DetailSection_btnPlus()
 {    

   
      var rootClient="800075";
      var rootClient1="300010" 
      var roots= GetData(filePath_Clients,"CR1352",202,language);   
      var address=GetData(filePath_Clients,"CR1352",204,language);
      var relationships=GetData(filePath_Clients,"CR1352",205,language);
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
       //sélectionner le client
      Search_Client(rootClient);
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
 
 // script spécifique a BNC     
  if (client == "BNC"){
      //Cliquer sur + dans le bloc Racines 
      var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualWidth();
      var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualHeight();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).WaitProperty("IsExpanded", true, 30000);
    
      //Valider que le bloc contient 3 comptes    
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,GetData(filePath_Clients,"CR1352",254,language))
      for(var i=1;i<=3;i++){
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",254+i,language),10), "IsEnabled", cmpEqual,true)
      }
      //Cliquer sur +
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
      
      //Cliquer sur + dans le bloc Same Address
      var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualWidth();
      var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualHeight();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).WaitProperty("IsExpanded", false, 30000);
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
      //Valider que le bloc contient 2 comptes 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,GetData(filePath_Clients,"CR1352",254,language))
   
      for(var i=1;i<=3;i++){
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",257+i,language),10), "IsEnabled", cmpEqual,true)
      }
      //Cliquer sur +
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));

     
      //Validation pour le bloc de Relations a été faite avec un autre client 
      //Cliquer sur + dans le bloc Relations
      //sélectionner le client
      Search_Client(rootClient1);
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
      
      var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).get_ActualWidth();
      var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).get_ActualHeight();
      
      
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click((width+5)-width, (height/2));
      //Valider que le bloc contient 2 comptes 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,GetData(filePath_Clients,"CR1352",263,language))
      for(var i=1;i<=2;i++){
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",GetData(filePath_Clients,"CR1352",260+i,language),10), "IsEnabled", cmpEqual,true)
      }
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click((width+5)-width, (height/2));
               
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
      }
    if (client == "CIBC"){
      
    }
 }
//function test(){
//    
//   if (client == "CIBC"){     
//      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,GetData(filePath_Clients,"CR1352",254,language));        
//      for(var i=1;i<=3;i++){
//        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",GetData(filePath_Clients,"CR1352",254+i,language),20), "IsEnabled", cmpEqual,true);//.Find("Description",roots,10)
//      }
//}
//}