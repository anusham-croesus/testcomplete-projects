//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR2010_Croes_6632_Rel_DragDropAssigHistoRel

/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6638
    Description :
                 Valider maillage assigné historique dans l'arborescence Clients vers module
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels:Carole Turcotte
    Version de scriptage:ref92.10.HF-25
*/
function CR2010_Croes_6638_Client_DragDropAssigHistoOthersPad()
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
               var ModelCHBONDS =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "ModelCHBONDS", language+client);   
     
               
       
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6638","Lien testlink - Croes-6638");
       
//Étape1       
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRelations, userNameKeynej, passwordKeynej, language);
               
      
              // Dans l'arborescence, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Modèles. 
               Log.Message("****Dans l'arborescence, sélectionner le compte 800203-RE dans la section 'Comptes' sous 'Relations' et mailler vers le module Modèles. *******************");         
               Select_Client(detenteur800203);
               if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded()==0){
                   Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
               }
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnModels());
               
   
               //Les points de verifications 
               aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items.Item(0).DataItem, "Name", cmpEqual, ModelCHBONDS);  
                             
//Étape2               
               //Dans l'arborescence du client du compte 800203-RE, sélectionner le détenteur 800203 dans la section 'Comptes' sous 'Relations' et mailler vers le module Modèles.
               Log.Message("****Dans l'arborescence du client du compte 800203-RE, sélectionner le détenteur 800203 dans la section 'Comptes' sous 'Relations' et mailler vers le module Modèles*******************");         
               Select_Client(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().FindChild("Text", detenteur800203, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid().FindChild("Text", detenteur800203, 10), Get_ModulesBar_BtnModels());
               
               
               
             
             //Les points de verifications                
                var nbrModels = Get_ModelsGrid().RecordListControl.Items.Count                
               aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items ,"Count", cmpEqual, 0)
               if(nbrModels==0)
                  Log.Message("la grille du module Modéle es tvide")
               else
                  Log.Message("la grille du module Modéle n'est pas vide")
                  
              
//Étape3               
               // Dans l'arborescence du client 800203, sélectionner le compte 800204-FS  dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Modèles.
               Log.Message("****Dans l'arborescence du client 800203, sélectionner le compte 800204-FS  dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Modèles.  *******************");         
               Select_Client(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnModels());
                             
                            
               //Les points de verifications 
               aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items.Item(0).DataItem, "Name", cmpEqual, ModelCHBONDS);  
               
               
               
//Étape4               
               //Dans l'arborescence du module Clients, sélectionner le détenteur 800204  dans la section 'Hist. Comptes' sous 'Relations' et mailler vers  le module Modèles..
               Select_Client(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().set_IsExpanded(true);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10), Get_ModulesBar_BtnModels());
                             
              //Les points de verifications                
               var nbrModels = Get_ModelsGrid().RecordListControl.Items.Count                
               aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items ,"Count", cmpEqual, 0)
               if(nbrModels==0)
                  Log.Message("la grille du module Modéle est vide")
               else
                  Log.Message("la grille du module Modéle n'est pas vide") 
                  
//Étape5 
              //Dans l'arborescence du client 800203, sélectionner le détenteur 800204 du compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Transactions.
               Log.Message("****Dans l'arborescence du client 800203, sélectionner le détenteur 800204 du compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Transactions.  *******************");
               Select_Client(detenteur800203);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnTransactions());
               
                
              //Les points de verifications                  
               //var nbrTransaction = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count               
               var nbrTransaction = Get_TransactionGridListView().Items.Count;
               if(nbrTransaction>0){
                  Log.Message("la grille du module transaction n'est pas vide")
               }
               else{
                  Log.Message("la grille du module transaction est  vide")     
                }  

//Étape6
             //Dans l'arborescence du client 800203 , sélectionner le compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Titres.   
               Log.Message("****Dans l'arborescence du client 800203, sélectionner le détenteur 800204 du compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations'et  mailler vers le module Titres*******************");
               Get_ModulesBar_BtnClients().Click();
               Select_Client(detenteur800203);               
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnSecurities());
               
               
                
              //Les points de verifications                                 
                var nbrtitres = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count
              
               Log.Message(nbrtitres) 
               aqObject.CheckProperty(Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items,"Count", cmpGreater, 0)
                if(nbrtitres>0){
                   Log.Message("la grille du module titres n'est pas vide")
                }
                else{
                   Log.Message("la grille du module titres est  vide")            
                 }   
 //Étape7                  
            //Dans l'arborescence du client 800203  sélectionner la REL01  dans la section 'Relations' sous 'Relations Groupés ' et mailler vers le module Comptes.
              Log.Message("****Dans l'arborescence du client 800204 ,  sélectionner le compte 800204-FS dans la section 'Hist. Comptes' sous 'Hist. Relations' et mailler vers le module Comptes.*******************");
             Select_Client(detenteur800203);
             Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1().set_IsExpanded(true);
             Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1Expandle().FindChild(["ClrClassName","DisplayText"],["XamTextEditor","REL01"], 10), Get_ModulesBar_BtnAccounts());
               
             //Les points de verifications
             aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800203RE)
             aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS)
//Étape8            
                
    
            //Dans l'arborescence du client 800204 ,  sélectionner le compte 800204-FS dans la section 'Hist. Comptes' sous 'Relation groupées' et mailler vers le module Comptes.
             Log.Message("****Dans l'arborescence du client 800204 ,  sélectionner le compte 800204-FS dans la section 'Hist. Comptes' sous 'Hist. Relations' et mailler vers le module Comptes.*******************");
             Select_Client(detenteur800204);
             Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelationDatarecord().set_IsExpanded(true);
             Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnAccounts());
               
             //Les points de verifications
             aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS)
               
               
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

// fonction qui selectionne le client 800203 dans le module client
function Select_Client(client){
    
               Get_ModulesBar_BtnClients().Click();
               Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);   
               Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
               Delay(3000)
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
//cette fonction permets d'acceder a la grillle relation groupées sous details
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupe(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 3], 10)
    
}

//cette fonction permets d'acceder a la premiere relation de la grille relationgroupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupe().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
    
}
//cette fonction permets d'acceder a la grille relation  relationgroupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1Expandle(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)
    
}

//cette fonction permets d'acceder a la premiere relation de la grille relation  sous relationgroupées 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1ExpandleRel01(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1Expandle().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
    
}
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelation(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 4], 10)
    
}
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelationDatarecord(){
    return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)
    
}

