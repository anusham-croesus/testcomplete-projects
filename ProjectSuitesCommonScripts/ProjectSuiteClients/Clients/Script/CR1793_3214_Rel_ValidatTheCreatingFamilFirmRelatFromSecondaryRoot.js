//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3214            
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Clients et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée.
                  3.Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:
                  Une fenêtre pour compléter les informations de la relation apparait.
                  4.Saisir les données nécessaires pour la relation et appuyer sur ok:La relation est créé.
                  
                   
    Auteur : Sana Ayaz
*/
function CR1793_3214_Rel_ValidatTheCreatingFamilFirmRelatFromSecondaryRoot()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
          // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var NameRelatBNC_3214=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameRelatBNC_3214", language+client);
          var IACodeCroes_3214=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "IACodeCroes_3214", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "rootsBNC_1145", language+client);
        //  var TypRelatCroes_3245=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "TypRelatCroes_3245", language+client);
         

          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
          Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
          /*Aller dans le module Clients et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée*/
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800256)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800256, 10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).ClickR();
          /*3.Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:
          Une fenêtre pour compléter les informations de la relation apparait.
          */
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          Log.Message("BNC-2042")
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //Selon BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          Get_WinAssignToARelationship_BtnYes().Click();
        
         
         // 4.Choisir un interlocuteur pour la relation et appuyer sur ok:La relation est créé.
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(NameRelatBNC_3214);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_3214);
          Get_WinDetailedInfo_BtnOK().Click();
          
           // Les points de vérifications, vérifier que la relation est crée.
         Get_ModulesBar_BtnRelationships().Click();
         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
          Log.Message("Verify that the relationship \"" + NameRelatBNC_3214 + "\" was successfully added.");
          SearchRelationshipByName(NameRelatBNC_3214);
          var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelatBNC_3214, 10);
          if (SearchResult.Exists == true){
              Log.Checkpoint("The relationship \"" + NameRelatBNC_3214 + "\" was successfully added.");
          }
          else {
              Log.Error("The relationship \"" + NameRelatBNC_3214 + "\" was not successfully added.");
          }
          
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(NameRelatBNC_3214);
        Terminate_CroesusProcess();
        
    }
}
