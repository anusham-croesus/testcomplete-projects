//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3242               
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module relation choisir une relation Famille-Firme ensuite sélectionner un compte dans Sommaire de la relation:Le compte 
                  est sélectionné.
                  3.Faire un clic droit et valider si l'option ‘’Retirer de la  relation'' est grisé:L'option ‘’Retirer de la  relation'' est grisé.
                  4.Mailler la relation dans le module compte ensuite sélectionner un compte et essayer de enlever le compte en utilisant
                   l'icône ''-'' en haut de l'écran:L'icône ''-'' est grisé.

                    

                   
    Auteur : Sana Ayaz
*/
function CR1793_3242_Rel_ValidatThatRemovTherelationshipIsDisable()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
          // Les variables
         var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800256", language+client); 
          var relationshipNameCroes_242=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_242", language+client);
          var IACodeCroes_242=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_242", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client);
          var RelationDetailAccount=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "RelationDetailAccount", language+client);
          var Account800256GT=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800256GT", language+client);
          var Account800256NA=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800256NA", language+client);
          var nbOfExpectedRelationshipsCroes_242=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "nbOfExpectedRelationshipsCroes_242", language+client);
          
          TabAccount800256 = new Array(); 
          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
          Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800256)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800256, 10).Click();
          // 2.clic droit sur sa racine secondaire Client800239
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).ClickR();
          //3.Associer----> Relation ---> Créer une relation Famille-Firme
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          //4.Oui
          Get_WinAssignToARelationship_BtnYes().Click();
        
         
          // 5.Renseigner Noms et code de CP(BD88)
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_242);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_242);
          //6.OK
          Get_WinDetailedInfo_BtnOK().Click();
          /*2.Aller dans le module relation choisir une relation Famille-Firme ensuite sélectionner un compte dans Sommaire de la relation:Le compte 
                  est sélectionné.*/
                  
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByName(relationshipNameCroes_242)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_242, 10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",RelationDetailAccount,10).Find("OriginalValue",Account800256GT,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",RelationDetailAccount,10).Find("OriginalValue",Account800256GT,10).ClickR();
          var numberOftries=0;  
          while ( numberOftries < 5 && !Get_SubMenus().Exists){
             Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",RelationDetailAccount,10).Find("OriginalValue",Account800256GT,10).ClickR();
          
            numberOftries++;
          } 

          //Les points de vérifications: valider que l'option "Retirer de la relation est grisée"
          
          
          //Les points de vérifications: valider que l'option "Retirer de la relation est grisée"
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship(), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship(), "VisibleOnScreen", cmpEqual, true);
          /*4.Mailler la relation dans le module compte ensuite sélectionner un compte et essayer de enlever le compte en utilisant
                   l'icône ''-'' en haut de l'écran:L'icône ''-'' est grisé.*/
                   
                   
          //maillage vers le module compte 
          Get_MenuBar_Modules().click();
          Get_MenuBar_Modules_Accounts().OpenMenu();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          //Les points de vérification
          TabAccount800256.push(Account800256GT);
          TabAccount800256.push(Account800256NA);
          var nbOfDisplayedRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          
          CheckEquals(nbOfDisplayedRelationships, nbOfExpectedRelationshipsCroes_242, "Le nombre des comptes affichés est correct");
        
        for (var i = 0; i < nbOfDisplayedRelationships; i++){
            var currentAccountNumber = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber();
            var found = false;
            for (var j = 0; j < nbOfExpectedRelationshipsCroes_242; j++){
                if (VarToStr(currentAccountNumber) == TabAccount800256[j]){
                    found = true;
                    break;
                }
            }
            
            if (found){
                Log.Checkpoint("le numéro de compte affichée est \"" + currentAccountNumber + "\" was expected.");
            }
            else {
                Log.Error("le numéro de compte affichée est  \"" + currentAccountNumber + "\" was not expected.");
            }
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
        DeleteRelationship(relationshipNameCroes_242);
        Terminate_CroesusProcess();
        
    }
}
