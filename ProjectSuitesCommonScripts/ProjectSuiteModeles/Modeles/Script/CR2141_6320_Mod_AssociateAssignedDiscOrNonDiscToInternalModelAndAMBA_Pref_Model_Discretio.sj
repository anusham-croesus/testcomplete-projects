//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6320 
    Description          :  Le but de ce cas est de :
                            - valider l'assignation d'un compte disc et non discr à un modèle àgestion déléguée.
                            - Valider qu'il n'est pas possible d'assigner un compte non disc à modèle interne.
                            - Valider que comportement actuel de FBN lorsque Pref_Model_Discretionary_Mode=1 n'est pas affecté par les changements apportés par la Pref_Model_Discretionary_Mode=2.
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-2
    Date                 :  03/04/2019
    Mise a jour script   :  06/05/2019 (CR2070)
    
*/


function CR2141_6320_Mod_AssociateAssignedDiscOrNonDiscToInternalModelAndAMBA_Pref_Model_Discretio() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6320","Lien du Cas de test sur Testlink");
                
            //Exécuter les requêtes suivantes pour rendre deux comptes un client  non discrétionnaires
            Log.Message("Exécuter les requêtes suivantes pour rendre deux comptes un client  non discrétionnaires");
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '800277-NA'", vServerModeles);
            Execute_SQLQuery("update b_client set is_discretionary='N' where no_client = '800066'", vServerModeles);
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte like '800066-GT'", vServerModeles);
            
            //Redemarrer les service
            RestartServices(vServerModeles);
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo1_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6320", language+client);
            var accountNo2_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6320", language+client);
            var clientNo_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6320", language+client);
            var modelName_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6320", language+client);
            var msgConflictAccount_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgConflictAccount_6320", language+client);
            var msgConflictClient_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgConflictClient_6320", language+client);
            var msgConflictRelationship_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgConflictRelationship_6320", language+client);
            var relationName_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName_6320", language+client);
            var IACode_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "IACode_6320", language+client);
            var accountNo3_6320 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo3_6320", language+client);
            var discretionaryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discretionaryLabel", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            
            //rechercher le compte 800284-FS et vérifier qu'on peut l'associer à un modele
            Log.Message("---------- Valider qu'on peut associer le compte "+accountNo1_6320+" à un modele --------------");
            AssignAcountToModel(accountNo1_6320,modelName_6320);
            //Ici on veut vérifier juste qu'il n ya pas un message bloquant
            CheckNotConflict();
            if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
            Get_WinAssignToModel_BtnNo().Click();
            
            //Associer un compte non discrétionnaire 800277-NA au modele
            AssignAcountToModel(accountNo2_6320,modelName_6320);
            //Vérifier le message bloquant
            CheckConflict();
            aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid","ConflictReason",10), "Value", cmpEqual,msgConflictAccount_6320);
            Get_WinAssignToModel_BtnClose().Click();
            
           //Associer un client qui détient des comptes non discrétionnaires au modèle
           Get_ModulesBar_BtnClients().Click();
           Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
           AssignClientToModel(clientNo_6320, modelName_6320);
           //Vérifier le message bloquant
           CheckConflict();
           aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid","ConflictReason",10), "Value", cmpEqual,msgConflictClient_6320);
           Get_WinAssignToModel_BtnClose().Click();
           
           //Créer une relation ND-test4 avec code de CP = AC42
           CreateRelationship(relationName_6320,IACode_6320);
           //Ajouter le client 800066 à la relation créée
           JoinClientToRelationship(clientNo_6320, relationName_6320);
           //Assigner la relation au modèle
           AssignRelationToModel(relationName_6320,modelName_6320);
           //Vérifier le message bloquant
           CheckConflict();
           aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid","ConflictReason",10), "Value", cmpEqual,msgConflictRelationship_6320);
           Get_WinAssignToModel_BtnClose().Click();
           
           //Cette etape est ajoutée pour couvrir le CR2070
           Log.Message("----------- Cette étape est ajoutée pour couvrir le CR2070 -------------------");
           //Ajout de la colonne discretionnaire dans le module compte
           Get_ModulesBar_BtnAccounts().Click();
           Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
           Log.Message("`--------- Ajout de la colonne discretionnaire -----------");
           Add_ColumnByLabel(Get_AccountsGrid_ChTotalValue(),discretionaryLabel);
           Log.Message("--------- Rechercher le compte "+accountNo3_6320+" -----------");
           Search_Account(accountNo3_6320);           
           //Vérifier qu il ya pas de crochet pour le compte 800066-GT
           Log.Message("-------- Vérifier qu il n ya pas de crochet pour le compte "+accountNo3_6320+" ---------");
           var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
           var count = grid.Items.Count;
           for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6320){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false);
                  break; 
               }      
           }
           
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo3_6320, 10).Click();
           
            //Mailler vers Clients
           Log.Message("`--------- Mailler le compte "+accountNo3_6320+" vers module Clients -----------");
           Get_MenuBar_Modules().Click();
           Get_MenuBar_Modules_Clients().Click();
           Get_MenuBar_Modules_Clients_DragSelection().Click();
           
           //Ajout de la colonne discretionnaire dans le module client
           Get_ModulesBar_BtnClients().Click();
           Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
           Log.Message("`--------- Ajout de la colonne discretionnaire -----------");
           Add_ColumnByLabel(Get_ClientsGrid_ChTotalValue(),discretionaryLabel);
           //Vérifier qu il ya pas de crochet pour le client 800066
           Log.Message("-------- Vérifier qu il n ya pas de crochet pour le client "+clientNo_6320+" ---------");
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNo_6320); 
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "IsDiscretionary", cmpEqual, false);
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Exécuter les requêtes suivantes pour rendre deux comptes un client discrétionnaires (état initial)
            Log.Message("Exécuter les requêtes suivantes pour rendre deux comptes un client discrétionnaires (état initial)");
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte = '800277-NA'", vServerModeles);
            Execute_SQLQuery("update b_client set is_discretionary='Y' where no_client = '800066'", vServerModeles);
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte like '800066-GT'", vServerModeles);
              
            //Supprimer la relation créée
            //Ici je supprime la relation à partir du détails à cause de l'anomalie qui affiche le message que le portefeuille est en cours d'édition ou rééquilibrage
            Log.Message("---------------- Supprimer la relation créée pour retourner à l'état initial ----------------");
            DeleteRelationshipFromDetails(relationName_6320);          
            
            //Fermer Croesus
            Log.Message("Fermer Croesus")
            Close_Croesus_X();
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();
            //Redemarrer les service
            RestartServices(vServerModeles);  
            Runner.Stop(true)                 
        }
}

 function AssignAcountToModel(accountNo,modelName){
            Search_Account(accountNo)
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo,10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
            Get_WinPickerWindow().Find("Value",modelName,10).DblClick();
 }
 
 function AssignClientToModel(clientNo, modelName){
            Search_Client(clientNo);
            var grid = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1);
            grid.Find("Uid","ClientNumber",10).Click();
            grid.Find("Uid","ClientNumber",10).ClickR();
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel().Click();
            Get_WinPickerWindow().Find("Value",modelName,10).DblClick();     
 }
 
 function AssignRelationToModel(relationName,modelName){
          Get_RelationshipsClientsAccountsGrid().Find("Value",relationName,10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
          Get_WinPickerWindow().Find("Value",modelName,10).DblClick();   
 }

 function CheckConflict(){
        var cell = Get_WinAssignToModel().WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1)
        aqObject.CheckProperty(cell, "Value", cmpEqual,"Error");
 }
 
 function CheckNotConflict(){
        var cell = Get_WinAssignToModel().WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1)
        aqObject.CheckProperty(cell, "Value", cmpEqual,"Ok");
 }
 
 function DeleteRelationshipFromDetails(RelationshipName){
        Log.Message("Delete the relationship \"" + RelationshipName + "\".");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        SearchRelationshipByName(RelationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10).Click();
        Get_RelationshipsClientsAccountsDetails().Find("Uid","ShortName",10).Click();
        Get_RelationshipsClientsAccountsDetails().Find("Uid","ShortName",10).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);    
 }
 
 function Get_AccountsGrid_ChDiscretionary()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discrétionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary"], 10)}
}

function Get_ClientsGrid_ChDiscretionary()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discrétionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary"], 10)}
}
 
 function test(){
            var clientNo_6320 = "800066"//ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6320", language+client);
             var accountNo3_6320 = "800066-GT"
   //Cette etape est ajoutée pour couvrir le CR2070
           //Ajout de la colonne discretionnaire dans le module compte
           Get_ModulesBar_BtnAccounts().Click();
           Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
           Log.Message("`--------- Ajout de la colonne discretionnaire -----------");
           Add_ColumnByLabel(Get_AccountsGrid_ChTotalValue(),Get_AccountsGrid_ChDiscretionary());
           Log.Message("--------- Rechercher le compte "+accountNo3_6320+" -----------");
           Search_Account(accountNo3_6320);           
           //Vérifier qu il ya pas de crochet pour le compte 800066-GT
           Log.Message("-------- Vérifier qu il n ya pas de crochet pour le compte "+accountNo3_6320+" ---------");
           var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
           var count = grid.Items.Count;
           for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6320){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false);
                  break; 
               }      
           }
           
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo3_6320, 10).Click();
           //Mailler vers Clients
           Log.Message("`--------- Mailler le compte "+accountNo3_6320+" vers module Clients -----------");
           Get_MenuBar_Modules().Click();
           Get_MenuBar_Modules_Clients().Click();
           Get_MenuBar_Modules_Clients_DragSelection().Click();
           
           //Ajout de la colonne discretionnaire dans le module client
           Get_ModulesBar_BtnClients().Click();
           Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
           Log.Message("`--------- Ajout de la colonne discretionnaire -----------");
           Add_ColumnByLabel(Get_ClientsGrid_ChTotalValue(),Get_ClientsGrid_ChDiscretionary());
           //Vérifier qu il ya pas de crochet pour le client 800066
           Log.Message("-------- Vérifier qu il n ya pas de crochet pour le client "+clientNo_6320+" ---------");
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNo_6320); 
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "IsDiscretionary", cmpEqual, false);

 }