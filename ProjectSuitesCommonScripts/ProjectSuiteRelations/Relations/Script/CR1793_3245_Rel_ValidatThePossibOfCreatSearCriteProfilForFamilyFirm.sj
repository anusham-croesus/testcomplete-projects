//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**

    Description :
                 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3245             
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans onglet Outils--->Configurations ensuite choisir Profils:
                  Une nouvelle fenêtre intitulée ''Configuration de profils et du dictionnaire'' s'ouvre.
                  3.Fermer la fenêtre  ''Configuration de profils et du dictionnaire'' aller ensuite dans le module relations et sélectionner 
                  une relation Famille-Firme ensuite appuyer sur le bouton profil et décocher la case HENRY et appuyer sur Appliquer et OK:
                  La fenêtre de Profil se ferme.
                  4.Aller ensuite  et ajouter le critère de recherche suivant:Liste des relations 
                  ayant Profil---->>Default------>>HENRY égal(e) a Oui:La relation qui a le champ profil HENRY décoché 
                  vient d'être affichée à l'écran.
                   
    Auteur : Sana Ayaz
*/
function CR1793_3245_Rel_ValidatThePossibOfCreatSearCriteProfilForFamilyFirm()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
          // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var relationshipNameCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_245", language+client);
          var IACodeCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_245", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client);
          var criterRechercheTypeRelatioFamilFirmCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "criterRechercheTypeRelatioFamilFirmCroes_245", language+client);
          var TypRelatCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TypRelatCroes_245", language+client);
          var ProfilHENRYCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "ProfilHENRYCroes_245", language+client);
          var TitleWinProfilConfiguratCroes_245=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TitleWinProfilConfiguratCroes_245", language+client);

          
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
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_245);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_245);
          Get_WinDetailedInfo_BtnOK().Click();
          // clic sur le module relation ensuite chercher la relation de type firme famille
            Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByName(relationshipNameCroes_245)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_245, 10).Click();
          
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        //Modifier le profil
        Log.Message("Update profile.");
       if (language == "french")
         WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinProfilConfiguratCroes_245, true, true]);
         else
         WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinProfilConfiguratCroes_245, true, true]);
        
        var height = Get_WinVisibleProfilesConfiguration().get_ActualHeight();
        var width = Get_WinVisibleProfilesConfiguration().get_ActualWidth();
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
        
        
      //Set_IsCheckedForAllXamCheckEditors(Get_WinVisibleProfilesConfiguration(), false);
      
      
        Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkHENRY().Click();
        //Delay(2000)
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        //Delay(2000)
        Get_WinInfo_TabProfile_ItemControl_ChkHENRY().Click();
        //Cliquer sur OK
        Log.Message("Save the updates by clicking on OK button.");
        Get_WinDetailedInfo_BtnOK().Click();
       // Delay(1000);

          

          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
          Get_WinAddSearchCriterion_TxtName().Keys(criterRechercheTypeRelatioFamilFirmCroes_245);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemDefaut().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemDefaut_ItemHENRY().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          
          
       //Vérifier le profil
              Log.Message("Verify the profile. Check that the HENRY label is present in detail and visible ");
             // Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_245, 10).DblClick();
              Get_RelationshipsDetails_TabProfile().Click();
        
              if (Get_RelationshipsDetails_TabProfile_DefaultExpander_LblHENRY().Exists && Get_RelationshipsDetails_TabProfile_DefaultExpander_LblHENRY().IsVisible ){
                  Log.Checkpoint("The HENRY profile was present.");
                  aqObject.CheckProperty(Get_RelationshipsDetails_TabProfile_DefaultExpander_LblHENRY(), "Text", cmpEqual,ProfilHENRYCroes_245);
              }
              else {
                  Log.Error("The HENRY profile was notpresent.");
              }
              
              Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_245, 10).Click();
              Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_245, 10).DblClick();
              Log.Message("Verify the profile. Check that the HENRY label is present and visible on the info window, profile tab");
              Get_WinDetailedInfo_TabProfile().Click();
        if (Get_WinInfo_TabProfile_ItemControl_LblHENRY().Exists && Get_WinInfo_TabProfile_ItemControl_LblHENRY().IsVisible ){
            Log.Checkpoint("The HENRY profile was present.");
            aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl_LblHENRY(), "Text", cmpEqual,ProfilHENRYCroes_245);
            aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl_ChkHENRY(), "IsChecked", cmpEqual, -1);
            aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl_ChkHENRY(), "wState", cmpEqual, 1);
            
            
            
        }
        else {
            Log.Error("The HENRY profile was not present.");
        }
          
        
       Get_WinDetailedInfo_BtnCancel().Click();

           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        //supprimer le critére de recherche
        Delete_FilterCriterion(criterRechercheTypeRelatioFamilFirmCroes_245, vServerRelations);
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipNameCroes_245)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_245, 10).DblClick();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        //Modifier le profil
        Log.Message("Update profile.");
         if (language == "french")
         WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Configuration des profils visibles", true, true]);
         else
         WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Visible Profiles Configuration", true, true]);
        
       
       //Scroller pour voir le profil HENRY
       var height = Get_WinVisibleProfilesConfiguration().get_ActualHeight();
        var width = Get_WinVisibleProfilesConfiguration().get_ActualWidth();
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
       //Set_IsCheckedForAllXamCheckEditors(Get_WinVisibleProfilesConfiguration(), false);
        Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkHENRY().Click();
       // Delay(2000)
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        //Delay(2000)
        Get_WinInfo_TabProfile_ItemControl_ChkHENRY().Click();
         Get_WinDetailedInfo_BtnOK().Click();
        DeleteRelationship(relationshipNameCroes_245);
        //Enlever la colonne type 
        Terminate_CroesusProcess();
        
    }
}
