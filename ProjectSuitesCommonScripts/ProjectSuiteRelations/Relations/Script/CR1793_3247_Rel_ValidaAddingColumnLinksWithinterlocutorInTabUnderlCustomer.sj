//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/*
    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3247             
                  1.Aller dans le module relation et selectioner une relation Famille-Firme ensuite cliquer sur l'onglet ''Info'':
                  La fenêtre Info relation s'ouvre.
                  2.Sélectionner dans cette fenêtre l'onglet Clients sous-jacents ensuite faire un clic droit et sélectionner’ ‘Ajouter une colonne''===>>>''Lien 
                  avec l'interlocuteur'':
                  La colonne ''Lien avec l'interlocuteur est affiché à l'écran à droite de la colonne ''Solde''.
                  
                   
    Auteur : Sana Ayaz
*/

function CR1793_3247_Rel_ValidaAddingColumnLinksWithinterlocutorInTabUnderlCustomer()
{
   try { 
   
   
   userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
   passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
   
   
    // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var relationshipNameCroes_247=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_247", language+client);
          var IACodeCroes_247=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_247", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client);
          
          
   //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
    Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
    Get_ModulesBar_BtnRelationships().Click();
    // Ajout de la relation Famille-Firme
    
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
        
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_247);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_247);
    Get_WinDetailedInfo_BtnOK().Click();
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipNameCroes_247)
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_247, 10).DblClick();
    Get_WinDetailedInfo().Click();
    Get_WinDetailedInfo_TabUnderlyingClientsForRelationship().Click();
    
    //La colonne ''Lien avec l'interlocuteur est affiché à l'écran à droite de la colonne ''Solde''
	Log.Message("On voit pas les entêtes des colonnes ,Un émail est envoyé a Mamoudou ")
    aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative(), "VisibleOnScreen", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative(), "FlowDirection", cmpEqual, "LeftToRight");
     var WPFControlOrdinalNoLinkWithTheRepresentative=Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative().WPFControlOrdinalNo;
     var WPFControlOrdinalNoBalance=Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChBalance().WPFControlOrdinalNo;
    
     if(WPFControlOrdinalNoLinkWithTheRepresentative == WPFControlOrdinalNoBalance+1)
        {
          Log.Checkpoint("La colonne Lien avec l'interlocuteur est a droite de la colonne solde ")
        }
        else {
        Log.Error("La colonne Lien avec l'interlocuteur n'est pas a droite de la colonne solde ");
      
        }
      

           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        DeleteRelationship(relationshipNameCroes_247);
        Terminate_CroesusProcess();
        
    }
}
