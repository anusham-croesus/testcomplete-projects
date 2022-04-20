//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3239                
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Clients et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée.
                  3.Faire un clic droit et sélectionner relation ensuite choisir Associer a une relation:Une nouvelle fenêtre intitule ''Relation''
                   vient de s'ouvrir avec la colonne Type Famille-Firme qui est affiche.

                   
    Auteur : Sana Ayaz
*/
function CR1793_3239_Rel_ValidatTheAdditionOfColumnTypInWinRelat()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
          //Les variables
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800239", language+client);
          var relationshipNameCroes_239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_239", language+client);
          var IACodeCroes_239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_239", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var RelaOptionJointToGroupedRelat=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "RelaOptionJointToGroupedRelat", language+client); 
          var Client800242=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800242", language+client); 
          var TypRelatCroes_239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TypRelatCroes_239", language+client);
          var TitleWinRelationCroes_239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TitleWinRelationCroes_239", language+client);
          
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
          // Renseigner Noms et code de CP(AC42)
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_239);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(IACodeCroes_239);
          Get_WinDetailedInfo_BtnOK().Click();
          
          // choisir le module client 
          
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800242)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800242, 10).Click();
          //2)	Sélectionner la racine de ce client ensuite faire un clic droit =====>Associer=====>Relation=====>Créer une Relation Famille-Firme.
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800242,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800242,10).ClickR();
          //3.Associer----> Relation ---> Créer une relation Famille-Firme
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship().Click();
          
          //Les points de vérifications
          // scroll pour pour pouvoir voir le champ Type
               for (var i=1; i<13; i++){       
                       Get_WinPickerWindow().Click(Get_WinPickerWindow().get_ActualWidth() - 30, 526);
                                }
          aqObject.CheckProperty(Get_WinPickerWindow().Parent, "WndCaption", cmpEqual, TitleWinRelationCroes_239);
		  Log.Message("Il manque l'entête de colonne Nom complet,Un émail est envoyé a Mamoudou  CROES-6026")
          var CellTypeRelationShip = Get_WinPickerWindow_DgvElements().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
          aqObject.CheckProperty(CellTypeRelationShip, "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(CellTypeRelationShip, "Exists", cmpEqual, true);
          
          Get_WinPickerWindow_BtnCancel().Click();
         
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
        DeleteRelationship(relationshipNameCroes_239);
        Terminate_CroesusProcess();
        
    }
}
