//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6632
    Description :
                 Valider maillage assigné histo dans l'arborescence Relations vers module Relation
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels:Carole Turcotte
    Version de scriptage:ref92.10.HF-25
*/
function CR2010_Croes_6632_Rel_DragDropAssigHistoRel()
{
    try {
      
             //Variables
                 
               
               var accountNumber800204FS =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
               var accountNumber800203RE =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);    
               var NewRel01 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "NewRel01", language+client);
               var NewRel02 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "NewRel02", language+client);
               var GroupedRelationName =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "GroupedRelationName", language+client);              
               var detenteur800203 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client);
               var detenteur800204 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);       
               var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
     
               
       
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6632","Lien testlink - Croes-6632");
//Étape 1      
       
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRelations, userNameKeynej, passwordKeynej, language);
       
       
               //Aller dans le module Relation 
               Log.Message("******************** Aller dans le module Relation  *******************");
               Get_ModulesBar_BtnRelationships().Click();
               Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
       
               // Dans l'arborescence de la relation REL01, mailler le compte 800203-RE de la section 'Comptes' vers le module Relations
               Log.Message("******************** Dans l'arborescence de la relation REL01, mailler le compte 800203-RE de la section 'Comptes' vers le module Relations  *******************");         
               Select_NewRel01(NewRel01);
               if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded()==0){
                   Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
               }
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnRelationships());
             
                //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
//Étape 2        
              // Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Relations.
               Log.Message("******************** Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Relations.  *******************");
               Select_NewRel01(NewRel01);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnRelationships());
  
               //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
               
//Étape 3               
               
                //Dans l'arborescence de la relation REL01, exploser le compte 800204-FS de la section 'Hist. Comptes' et mailler le détenteur  800204 vers le module Relations.
                Log.Message("******************** Dans l'arborescence de la relation REL01, exploser le compte 800204-FS de la section 'Hist. Comptes' et mailler le détenteur  800204 vers le module Relations. *******************");
                Select_NewRel01(NewRel01);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnRelationships());
   
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
                                 
//Étape 4               
                //Dans l'arborescence de la relation REL01, sélectionner le Détenteur 800203 du compte 800203-RE de la section 'Comptes' sous 'Rel. Groupées' et 'Relations' et mailler vers le module Relations.
                Log.Message("******************** Dans l'arborescence de la relation REL01, sélectionner le Détenteur 800203 du compte 800203-RE de la section 'Comptes' sous 'Rel. Groupées' et 'Relations' et mailler vers le module Relations. *******************");
                Select_NewRel01(NewRel01);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGridDataRecordPresenter1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800203, 30).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800203, 30), Get_ModulesBar_BtnRelationships());
   
                 //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
                
                
//Étape 5                
               //Dans l'arborescence de la relation REL01, sélectionner le compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.
                Log.Message("Dans l'arborescence de la relation REL01, sélectionner le compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.")
                
                Select_NewRel01(NewRel01);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails().zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").MouseWheel(-1)                
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Refresh();          
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Value", accountNumber800204FS,10).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Value", accountNumber800204FS,10), Get_ModulesBar_BtnRelationships());
                
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
               
                
//Étape 6               
                //Dans l'arborescence de la relation REL01, sélectionner le compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.  
                Log.Message("Dans l'arborescence de la relation REL01, sélectionner le Détenteur 800204 du compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.");
                Select_NewRel01(NewRel01);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails().zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").MouseWheel(-1) 
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Refresh();
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGridDataRecordPresenter1().set_IsExpanded(true);     
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Text", detenteur800204, 100).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Text", detenteur800204, 100), Get_ModulesBar_BtnRelationships());
   
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);             
               
               
               
              
                
             
       //Fermer Croesus
       Close_Croesus_X(); 
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}

// fonction qui selectionne la relation NewRel01 dans le module relation
function Select_NewRel01(NewRel01){
    
               Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
               SearchRelationshipByName(NewRel01)
               Get_RelationshipsClientsAccountsGrid().FindChild("Text", NewRel01, 10).Click();
}

//Cette fonction permets d'acceder à la grille Relation groupées sous details de la relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouper(){
    return  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 3], 10)    
}

//Cette fonction permets d'acceder à la grille Histo. compte sous details de la relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte(){
    return  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10)    
}
 


//Cette fonction permets d'acceder à la premiere  Relation groupée de la grille relations groupées sous details de la relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1(){ 
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouper().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
}

//Cette fonction permets d'acceder à la premiere  Relation de la grille relations qui se trouve dans la grille relations groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
}

//Cette fonction permets d'acceder à la grille compte dans la grille relations qui se trouve dans la grille relations groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGrid(){
   return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)

}


//Cette fonction permets d'acceder au premier compte de  la grille compte dans la grille relations qui se trouve dans la grille relations groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGridDataRecordPresenter1(){    
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)

}

//Cette fonction permets d'acceder à la grille histo. compte dans la grille relations qui se trouve dans la grille relations groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid(){
    return    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperExpandableFieldRecordPresenterSchroll().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10);
}

//Cette fonction permets d'acceder au premier compte de  la grille histo. compte dans la grille relations qui se trouve dans la grille relations groupées sous details  
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGridDataRecordPresenter1(){
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}



//Cette fonction permets d'acceder à la grille Relation groupées sous details de la relation aprés le schroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperschroll(){
    return  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)    
}

//Cette fonction permets d'acceder à la premiere  Relation groupée de la grille relations groupées sous details de la relation aprés le schroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1Scrholl(){
    return    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperschroll().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10); 
    
}

//Cette fonction permets d'acceder a la grille relations  sous la grille relations groupées sous details de la relation aprés le schroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperExpandableFieldRecordPresenterSchroll(){
    return    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1Scrholl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10); 
    
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01(){
 return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)  

}
