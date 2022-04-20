//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
       Lorsqu’on veut créer une relation à partir d'un client qui fait déjà partie d'une relation le message affiché n'est pas correct.

        Voici les étapes :
        1) Aller dans le module client faire un clic droit et choisir Relation ensuite choisir Créer une nouvelle relation. Choisir un nom et appuyer ok.
        2) Revenir dans le module client et sélectionner le même client et répéter les étapes d’en haut.
        On a le message de la capture joint en lieu de nous dire que ce client fait déjà partie d’une autre relation.


    Auteur : Sana Ayaz
    Anomalie:CROES-7601
    Version de scriptage:ref90-05-14--V9-AT_1-co6x
*/
function CROES_7601_CreatRelatFromCustomerWhoIsAlreadyPartOfRelatDisplayMsgNotCorrect()
{
    try {
        
        
        userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
        passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
       
        var NumBerClient800000=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumBerClient800000", language+client);
        var NameRelatCROES_7601=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameRelatCROES_7601", language+client);
        var IACodeCROES_7601=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "IACodeCROES_7601", language+client);
        var RaisonConflitLine1=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "RaisonConflitLine1", language+client);
        var RaisonConflitLine2=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "RaisonConflitLine2", language+client);
        var RaisonConflitLine3=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "RaisonConflitLine3", language+client);
        var RaisonConflitLine4=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "RaisonConflitLine4", language+client);
        
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NumBerClient800000);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClient800000, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClient800000, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();  
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        //Créer la relation
        
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(NameRelatCROES_7601);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().Keys(IACodeCROES_7601);
          Get_WinDetailedInfo_BtnOK().Click()
          
          Get_ModulesBar_BtnClients().Click();
          Search_Client(NumBerClient800000);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClient800000, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClient800000, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();  
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
           
          TabRaisonConflit = new Array();
          TabRaisonConflit.push(RaisonConflitLine1);
          TabRaisonConflit.push(RaisonConflitLine2);
          TabRaisonConflit.push(RaisonConflitLine3);
          TabRaisonConflit.push(RaisonConflitLine4);
          // Les points de vérifications des messages affichés:
           var count= Get_WinAssignToARelationship_DgvAccountsList().WPFObject("RecordListControl", "", 1).Items.Count;
           
      
            for (i=0; i<= count-1; i++){ 
                   var RaisonConflitDisplay = Get_WinAssignToARelationship_DgvAccountsList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ConflictReason.OleValue
                   var RaisonConflitExpected =TabRaisonConflit[i]
                  if (RaisonConflitDisplay==RaisonConflitExpected){
                      Log.Checkpoint("Le message de raison de conflit affiché est pareil que celui attendu "+RaisonConflitDisplay +i);
                  }
                  else{
                      Log.Error("Le message de raison de conflit affiché est  pareil que celui attendu "+RaisonConflitDisplay+i); }
                  }
                  Get_WinAssignToARelationship_BtnNo().Click();
                  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(NameRelatCROES_7601);
        Terminate_CroesusProcess();
        
        
        
    }
}
