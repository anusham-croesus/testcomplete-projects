//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3244             
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Ouvrir le module relation ensuite aller ajouter un critère de recherche suivant:
                  Liste des relations ayant type égale(e) a Famille-Firme, appuyer sur Sauvegarder et régénérer.
                  Une liste des relations qui ont le Type Famille-Firme est affiché à l'écran.
                  
                   
    Auteur : Sana Ayaz
*/
function CR1793_3244_Rel_ValidatThePossibOfCreatSearCriteForFamilyFirm()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
          // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var relationshipNameCroes_244=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_244", language+client);
          var IACodeCroes_244=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_244", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client);
          var criterRechercheTypeRelatioFamilFirmCroes_244=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "criterRechercheTypeRelatioFamilFirmCroes_244", language+client);
          var TypRelatCroes_244=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TypRelatCroes_244", language+client);
         

          
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
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_244);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_244);
          Get_WinDetailedInfo_BtnOK().Click();
          
           Log.Message("Add the '" + criterRechercheTypeRelatioFamilFirmCroes_244 + "' search criterion.");
          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
          Get_WinAddSearchCriterion_TxtName().Keys(criterRechercheTypeRelatioFamilFirmCroes_244);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemFamilyFirm().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          //Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamilyFirm().Click();
          
        
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
       
        // les points de vérification
        
        if(Get_RelationshipsGrid_ChType().Exists){
          if (Get_RelationshipsGrid_ChType().VisibleOnScreen)  
            Log.Message("l'entête de colonne type fais parti des colonnes ")          
          }
        else{
             Log.Message("l'entête de colonne type ne fais pas parti des colonnes donc il faut l'ajouter");
             Get_RelationshipsGrid_ChName().ClickR();
  
             Get_RelationshipsGrid_ChName().ClickR();
             Get_RelationshipsGrid_ChName().ClickR();
             Get_RelationshipsGrid_ChName().ClickR();
             Get_RelationshipsGrid_ChName().ClickR();
             Get_RelationshipsGrid_ChName().ClickR();
             Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
             Get_GridHeader_ContextualMenu_AddColumn_Type().Click()           
         }
        var croesusRowCount= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
       for (var i = 1; i < croesusRowCount; i++){
             
              var displayedRelationshipType =Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 10], 10).WPFObject("XamTextEditor", "", 1).DisplayText;
            
              Log.Message(displayedRelationshipType)
              if(displayedRelationshipType == TypRelatCroes_244)
              {
                Log.Checkpoint("La liste des relations ayant le type Famille firme sont affichées a l'écran")
              }
              else {Log.Error("La liste des relations ayant le type Famille firme ne sont pas affichées a l'écran")}
        


         
           }
          
         
          
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        //supprimer le critére de recherche
        Delete_FilterCriterion(criterRechercheTypeRelatioFamilFirmCroes_244, vServerRelations);
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationshipNameCroes_244);
        //Enlever la colonne type 
        Terminate_CroesusProcess();
        
    }
}
