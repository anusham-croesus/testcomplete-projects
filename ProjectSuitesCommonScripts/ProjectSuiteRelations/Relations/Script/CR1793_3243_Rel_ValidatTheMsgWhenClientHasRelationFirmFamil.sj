//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3243             
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Clients et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée.
                  3.Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:Une fenêtre pour compléter les informations de la relation apparait.
                  4.Choisir un interlocuteur pour la relation et appuyer sur ok:La relation est créé.
                  5.Aller dans le module Clients et sélectionner la racine de  client avec laquelle on vient de créer une relation Famille-Firme dans le pas 4:La racine est 
                  sélectionnée.
                  6.Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:
                      Le message suivant va apparaitre:

                        EN: The root client ABCF-1  is already assigned to a Family-Firm relationship XYZ.
                        FR : Le client racine  ABCF-1  est déjà assigné à une relation Famille-Firme XYZ

                    

                   
    Auteur : Sana Ayaz
*/
function CR1793_3243_Rel_ValidatTheMsgWhenClientHasRelationFirmFamil()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
          // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var relationshipNameCroes_243=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_243", language+client);
          var IACodeCroes_243=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_243", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client);
          var MsgDejaAssignARelationFirmFamilCroes_243=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "MsgDejaAssignARelationFirmFamilCroes_243", language+client);
          

          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
          Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
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
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          Get_WinAssignToARelationship_BtnYes().Click();
        
         
         // 4.Choisir un interlocuteur pour la relation et appuyer sur ok:La relation est créé.
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_243);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_243);
          Get_WinDetailedInfo_BtnOK().Click();
          
          //Recuperer le numero de la relation crée 
          var relNo = Get_RelationshipNo(relationshipNameCroes_243);
          
          /* 5.Aller dans le module Clients et sélectionner la racine de  client avec laquelle on vient de créer une relation Famille-Firme dans le pas 4:La racine est 
                  sélectionnée.
          */
          
           Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800256)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800256, 10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).ClickR();
          
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         // Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          
          
          
          
          /*6.Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:
                      Le message suivant va apparaitre:

                        EN: The root client ABCF-1  is already assigned to a Family-Firm relationship XYZ.
                        FR : Le client racine  ABCF-1  est déjà assigné à une relation Famille-Firme XYZ

          */
          var CellReasonOfConflict = Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1);
          aqObject.CheckProperty(CellReasonOfConflict, "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(CellReasonOfConflict, "Exists", cmpEqual, true);
          aqObject.CheckProperty(CellReasonOfConflict, "DisplayText", cmpEqual, MsgDejaAssignARelationFirmFamilCroes_243+" "+relNo+".");
          //
          Get_WinAssignToARelationship_BtnOk().Click();
          
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationshipNameCroes_243);
        Terminate_CroesusProcess();
        
    }
}