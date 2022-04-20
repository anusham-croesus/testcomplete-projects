//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR2010_Croes_6632_Rel_DragDropAssigHistoRel
/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6637
    Description :
                 Valider maillage assigné historique dans l'arborescence Clients vers module
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels:Carole Turcotte
    Version de scriptage:ref92.10.HF-25
*/
function CR2010_Croes_6637_Client_DragDropAssigHistoClients()
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
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6637","Lien testlink - Croes-6637");
       
//Étape1        
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRelations, userNameKeynej, passwordKeynej, language);
       
     
               // Dans l'arborescence du module Client, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations. 
               Log.Message("****Dans l'arborescence du module Client, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations.  *******************");         
               Select_Client800203(detenteur800203);
               if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded()==0){
                   Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
               }
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnRelationships());
                             
               //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01)
               
               
//Étape2               
               
               //Dans l'arborescence du module Client, sélectionner le détenteur 800203 du compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations.
               Log.Message("****Dans l'arborescence du module Client, sélectionner le détenteur 800203 du compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations.  *******************");         
               Select_Client800203(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().FindChild("Text", detenteur800203, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().FindChild("Text", detenteur800203, 10), Get_ModulesBar_BtnRelationships());
                             
               //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01)
               
//Étape3               
               // Dans l'arborescence du module Client, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations. 
               Log.Message("****Dans l'arborescence du module Client, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Relations.  *******************");         
               Select_Client800203(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnRelationships());
                             
               //Les points de verifications                
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01)
               
               
//Étape4               
               
               //Dans l'arborescence du module Clients, sélectionner le détenteur 800204  dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Relations.
               Select_Client800203(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10), Get_ModulesBar_BtnRelationships());
                             
               //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01)
                
               
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

// f// fonction qui selectionne un client 
function Select_Client800203(client){
    
               Get_ModulesBar_BtnClients().Click();
               Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);   
               Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
               Search_Client(client)
               Get_RelationshipsClientsAccountsGrid().FindChild("Text", client, 10).Click();
}

//cette fonction permets d'acceder a la grillle relation sous details
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelation(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10)
    
}
//cette fonction permets d'acceder a la premiere relation de la grille relation sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
    
}

//cette fonction permets d'acceder à la grille compte sous relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid(){
return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
}
//cette fonction permets d'acceder à la grille Histo_compte sous relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid(){
return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(2).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
}


function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(indice){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", indice], 10)
}



