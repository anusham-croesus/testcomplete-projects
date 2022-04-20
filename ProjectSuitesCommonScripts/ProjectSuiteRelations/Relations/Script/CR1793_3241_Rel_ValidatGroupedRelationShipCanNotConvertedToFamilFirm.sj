//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3241               
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module relation choisir une relation groupée et appuyer sur l'onglet info:Une nouvelle fenêtre intitule ''Info Relation'' vient
                   de s'ouvrir.
                  3.Aller ensuite et essayer de modifier le champ type qui affiche ''Relation groupée'':Le champ est grisé et non-modifiable.
                  4.Appuyer Annuler :La fenêtre Info relation vient de se fermer.

                    

                   
    Auteur : Sana Ayaz
*/
function CR1793_3241_Rel_ValidatGroupedRelationShipCanNotConvertedToFamilFirm()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
          //Les variables
          
          var relationshipNameCroes_241=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_241", language+client);
          var IACodeCroes_241=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_241", language+client);
          var InfoRelationshipTypeCroes_241=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "InfoRelationshipTypeCroes_241", language+client);
         
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
         Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
          
        /* 2.Aller dans le module relation choisir une relation groupée et appuyer sur l'onglet info:Une nouvelle fenêtre intitule ''Info Relation'' vient
                   de s'ouvrir.*/
         
         CreateGroupedRelationship(relationshipNameCroes_241)
         
         /*3.Aller ensuite et essayer de modifier le champ type qui affiche ''Relation groupée'':Le champ est grisé et non-modifiable.*/
           SearchRelationshipByName(relationshipNameCroes_241);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_241, 10);
           Get_RelationshipsBar_BtnInfo().Click();
           
           //  Le champ type ''Relation groupée'est grisé
             aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "Exists", cmpEqual, true);
              aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "IsEnabled", cmpEqual, false);
              aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "VisibleOnScreen", cmpEqual, true);
              aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "Text", cmpEqual, InfoRelationshipTypeCroes_241);

         //4.Appuyer Annuler :La fenêtre Info relation vient de se fermer.
         
         Get_WinDetailedInfo_BtnCancel().Click();
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationshipNameCroes_241);
        Terminate_CroesusProcess();
        
    }
}
