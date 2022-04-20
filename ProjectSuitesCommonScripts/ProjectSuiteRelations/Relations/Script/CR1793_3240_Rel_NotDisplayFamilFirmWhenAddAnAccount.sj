//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3240               
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Compte et sélectionner un compte:Le Compte est sélectionnée.
                  3.Faire un clic droit ensuite choisir 'Relation' après appuyer 'Associer a une relation'
                    Valider qu’aucune relation de type ''Famille Firme'' n'est affiches..

                    

                   
    Auteur : Sana Ayaz
*/
function CR1793_3240_Rel_NotDisplayFamilFirmWhenAddAnAccount()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
          //Les variables
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800239", language+client);
          var relationshipNameCroes_240=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_240", language+client);
          var IACodeCroes_240=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_240", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var Account800066GT=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800066GT", language+client);
          var TypRelatCroes_240=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TypRelatCroes_240", language+client);
          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
         Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
          
         //Ajouter une relation de type  Famille-Firme
         
            //Ajouter une relation de type  Famille-Firme
         
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800239)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800239, 10).Click();
          //2)	Sélectionner la racine de ce client ensuite faire un clic droit =====>Associer=====>Relation=====>Créer une Relation Famille-Firme.
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).ClickR();
          //3.Associer----> Relation ---> Créer une relation Famille-Firme
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          // 3)	Faire un clic sur oui ensuite entrer le nom de la Relation et appuyer sur ok.
          Get_WinAssignToARelationship_BtnYes().Click();
          // Renseigner Noms et code de CP(AC42)
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_240);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(relationshipNameCroes_240);
          Get_WinDetailedInfo_BtnOK().Click();
         /*3.Faire un clic droit ensuite choisir 'Relation' après appuyer 'Associer a une relation'
           Valider qu’aucune relation de type ''Famille Firme'' n'est affiches.*/
           Get_ModulesBar_BtnAccounts().Click();
           Search_Account(Account800066GT)
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800066GT, 10).Click();
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800066GT, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
           Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
           
           // scroll pour pour pouvoir voir le champ Type
               for (var i=1; i<13; i++){       
                       Get_WinPickerWindow().Click(Get_WinPickerWindow().get_ActualWidth() - 30, 526);
                                }
          
          
          
           
           croesusRowCount = Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.get_Count();
          arrayOfRelationshipsNames = new Array();
          for (var i = 1; i < croesusRowCount; i++){
             Log.Message("CROES-6026 : Il manque l'entête de colonne Nom complet, Un émail est envoyé a Mamoudou ")
              var displayedRelationshipType =Get_WinPickerWindow_DgvElements().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).DisplayText;
              Log.Message(displayedRelationshipType)
              if(displayedRelationshipType == TypRelatCroes_240)
              {
                Log.Error("Une relation de type Famille firme existe")
              }
              else {Log.Checkpoint("Aucune relation de type Famille firme n'existe")}
        
          }

         
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        Log.Message("on ne peut pas supprimer une relation qui est associé a un client: une fenêtre d'avertissement est apparaît au lieu de la fenêtre de comfirmation suppression ==> on attend reponse Karima")
        DeleteRelationship(relationshipNameCroes_240);
        Terminate_CroesusProcess();
        
    }
}