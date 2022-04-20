//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR2010_Croes_6632_Rel_DragDropAssigHistoRel
/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6634
    Description :
                 Valider maillage assigné historique dans l'arborescence Relations vers autres modules
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels:Carole Turcotte
    Version de scriptage:ref92.10.HF-25
*/
function CR2010_Croes_6634_Rel_DragDropAssigHistoOthersPad()
{
    try {
      
             //Variables
               var accountNumber800204FS =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
               var accountNumber800203RE =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);                 
               var accountNumber800204JW =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204JW", language+client);
               var accountNumber800204NA =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204NA", language+client);
               var accountNumber800204OB =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204OB", language+client);
               var ModelCHBONDS =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "ModelCHBONDS", language+client);              
               var client800203 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client); 
               var client800204 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);               
               var NewRel01 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "NewRel01", language+client);                          
               var detenteur800203 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client);
               var detenteur800204 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);
               var clientNameZA =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "clientNameZA", language+client);
               var positionNBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "positionNBC100", language+client)
               var positionK77743 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "positionK77743", language+client)            

                      
               var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6634","Lien testlink - Croes-6634");
       
//Étape1        
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRelations, userNameKeynej, passwordKeynej, language);
       
       
               
             
               //Dans l'arborescence de la relation REL01, mailler le compte 800203-RE de la section 'Comptes' vers le module Clients.
               Log.Message("******************** Dans l'arborescence de la relation REL01, mailler le compte 800203-RE de la section 'Comptes' vers le module Clients. *******************");               
               Select_NewRel01_02(NewRel01)
               if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded()==0){
                   Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
               }
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnClients());
                
               //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, client800203);
       
               
               
       
              
//Étape2               
               //Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Clients.
               Log.Message("******************** Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Clients. *******************");               
               Select_NewRel01_02(NewRel01)
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnClients());
  
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, client800204);
               
               
               
//Étape3              
               //Dans l'arborescence de la relation REL01, section 'Hist. Comptes' exploser par le + le compte 800204-FS Mailler le Détenteur800204 vers le module Clients.
                Log.Message("******************** Dans l'arborescence de la relation REL01, section 'Hist. Comptes' exploser par le + le compte 800204-FS Mailler le Détenteur800204 vers le module Clients. *******************");               
                Select_NewRel01_02(NewRel01)
                //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Click(40,100);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnClients());
   
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, client800204);
               
                
//Étape4                
              //Dans l'arborescence de la relation REL01 , sélectionner le compte 800203-RE et 800204-FS en même temps et mailler vers le module Clients.          
              Log.Message("******************** Dans l'arborescence de la relation REL01 , sélectionner le compte 800203-RE et 800204-FS en même temps et mailler vers le module Clients. *******************");                 
              Select_NewRel01_02(NewRel01)
              Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
              Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl); 
              
              Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 30), Get_ModulesBar_BtnClients()); //JimenaB 
              //Les points de verifications 
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, client800203);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "ClientNumber", cmpEqual, client800204);
              
              
//Étape5
                //Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Comptes.
                Log.Message("******************** Dans l'arborescence de la relation REL01, mailler le compte 800204-FS de la section 'Hist. Comptes' vers le module Comptes. *******************");
                Select_NewRel01_02(NewRel01)
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnAccounts());
                
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);

//Étape6                              
               //Dans l'arborescence de la relation REL01, exploser le compte 800204-FS de la section 'Hist. Comptes' et mailler le détenteur  800204 vers le module Compte.
                Log.Message("******************** Dans l'arborescence de la relation REL01, exploser le compte 800204-FS de la section 'Hist. Comptes' et mailler le détenteur  800204 vers le module Compte *******************");               
                Select_NewRel01_02(NewRel01)
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Click(40,100);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnAccounts());
   
                //Les points de verifications 
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "AccountNumber", cmpEqual, accountNumber800204JW);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(2).DataItem, "AccountNumber", cmpEqual, accountNumber800204NA);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(3).DataItem, "AccountNumber", cmpEqual, accountNumber800204OB);
                
//Étape7                
                
                
             //Dans l'arborescence de la Relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers modèles
               Log.Message("******************** Dans l'arborescence de la Relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers modèles *******************");               
               Select_NewRel01_02(NewRel01)                  
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100),Get_ModulesBar_BtnModels() )  
   
               //Les points de verifications 
              aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items.Item(0).DataItem, "Name", cmpEqual, ModelCHBONDS);
                

//Étape8 
              //Dans l'arborescence de la relation REL01, sélectionner le compte  800204-FS et mailler vers Portefeuillle
               Log.Message("******************** Dans l'arborescence de la relation REL01, sélectionner le compte  800204-FS et mailler vers Portefeuillle *******************");               
               Select_NewRel01_02(NewRel01)
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click();
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10), Get_ModulesBar_BtnPortfolio());
                              
               //les points de verification  
               var nbrposition = Get_Portfolio_PositionsGrid().Items.Count  
               aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items,"Count", cmpGreater, 0) 
               if(nbrposition>0)
                    Log.Message("la grille du module portefeuilles n'est pas vide")
               else
                    Log.Message("la grille du module portefeuilles est  vide")  
               aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
               aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem, "ClientShortName", cmpEqual, clientNameZA);
               aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(1).DataItem, "Symbol", cmpEqual, positionNBC100);
               aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(2).DataItem, "Symbol", cmpEqual, positionK77743);
 
//Étape9   
             //Dans l'arborescence de la relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers Transactions
               Log.Message("******************** Dans l'arborescence de la relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers Transactions *******************");               
               Select_NewRel01_02(NewRel01)                  
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
               Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);
               Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100),Get_ModulesBar_BtnTransactions() )
 
 
               
             //Les points de verifications                  
               //var nbrTransaction = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count
               var nbrTransaction = Get_TransactionGridListView().Items.Count;
               if(nbrTransaction>0)
                  Log.Message("la grille du module transaction n'est pas vide")
               else
                  Log.Message("la grille du module transaction est  vide") 
                  
 //Étape10               
               
                  
                //Dans l'arborescence de la relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers Titres
                Log.Message("******************** Dans l'arborescence de la relation REL01, sélectionner les comptes 800203-RE et 800204-FS et mailler vers Titres *******************");                               
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                Select_NewRel01_02(NewRel01)                   
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);
                Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100),Get_ModulesBar_BtnSecurities() )
 
                              
                
                //Les points de verifications                 
                var nbrtitres = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count
              
               Log.Message(nbrtitres) 
               aqObject.CheckProperty(Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items,"Count", cmpGreater, 0)
               //aqObject.CheckProperty(nbrTransaction,", cmpGreater, 0)
                if(nbrtitres>0)
                   Log.Message("la grille du module titres n'est pas vide")
                else
                   Log.Message("la grille du module titres est  vide")                  
                  
                 
       
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}



function Select_NewRel01_02(NewRel01){
    
 
             //Aller dans le module Relation 
               Get_ModulesBar_BtnRelationships().Click();
               Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
               
             //Rafraichir la grille Relation et selectionner la relation NewRel01
               Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
               SearchRelationshipByName(NewRel01)
               Get_RelationshipsClientsAccountsGrid().FindChild("Text", NewRel01, 10).Click();               
               
}

function Get_RelationshipsClientsAccountsDetailsRelGrouperHistoCompte(){
    return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.bottomGroupBox.zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid");
}

