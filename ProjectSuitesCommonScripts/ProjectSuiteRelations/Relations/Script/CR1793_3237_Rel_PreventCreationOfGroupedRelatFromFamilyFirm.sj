//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3237                
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module relation selectioner une relation Famille-Firme ensuite  faire un clic droit de la souris sur la relation et verifier 
                  que l'option ''Associer à une relation groupée'' est grisé:L'option 'L'option ''Associer à une relation groupée'' est grisé.

                   
    Auteur : Sana Ayaz
*/
function CR1793_3237_Rel_PreventCreationOfGroupedRelatFromFamilyFirm()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
          //Les variables
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800239", language+client);
          var relationshipNameCroes_237=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_237", language+client);
          var IACodeCroes_237=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_237", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var RelaOptionJointToGroupedRelat=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "RelaOptionJointToGroupedRelat", language+client); 
          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
         Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
          
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
          // Renseigner Noms et code de CP(BD88)
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_237);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(IACodeCroes_237);
          Get_WinDetailedInfo_BtnOK().Click();
         /*2.Aller dans le module relation selectioner une relation Famille-Firme ensuite  faire un clic droit de la souris sur la relation et verifier 
         que L'option ''Associer à une relation groupée'' est grisé.*/
         Get_ModulesBar_BtnRelationships().Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_237, 10).Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_237, 10).ClickR()
         //Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship()
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
         /*Les points de vérifications : verifier 
         que l'option ''Associer à une relation groupée'' est grisé.*/
         aqObject.CheckProperty(Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship(), "WPFControlText", cmpEqual, RelaOptionJointToGroupedRelat);
         aqObject.CheckProperty(Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship(), "Enabled", cmpEqual, false);
         aqObject.CheckProperty(Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship(), "IsVisible", cmpEqual, true);
         

         
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationshipNameCroes_237);
        Terminate_CroesusProcess();
        
    }
}
