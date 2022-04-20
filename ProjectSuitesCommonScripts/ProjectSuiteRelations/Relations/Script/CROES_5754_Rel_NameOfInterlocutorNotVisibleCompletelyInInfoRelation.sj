//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Le nom de l'interlocuteur n'est visible pas complètement dans la fenêtre info relation
    L'objectif ici est de valider que la largeur du champs où apparait l'interlocuteur est suffisant pour l'afficher en complet

    Auteur :                Abdel Matmat
    Anomalie:               CROES-5754
    Version de scriptage:	90-08-Dy-2
    
*/


function CROES_5754_Rel_NameOfInterlocutorNotVisibleCompletelyInInfoRelation() {
         
          try {
                              
                Log.Link("https://jira.croesus.com/browse/CROES-5754", "Cas de tests JIRA CROES-5754");
          
                var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
                var RelationshipNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES5754_Rel_RelationshipNo", language+client);
                var WidthTxtRepresentative = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES5754_Rel_WidthTxtRepresentative", language+client);
                var WidthCheckBox = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES5754_Rel_WidthCheckBox", language+client);
                var WidthBtnRepresentative = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES5754_Rel_WidthBtnRepresentative", language+client);
                  
                Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                
                // Rechercher une relation et accéder à la fenêtre info
                SearchRelationshipByNo(RelationshipNo);
                Get_RelationshipsClientsAccountsGrid().Find("Value",RelationshipNo,10).DblClick();
                WaitObject(Get_WinDetailedInfo(),["ClrClassName","WPFControlText"],["UniButton","OK"]);
                
                //Points de vérification
                //Valider la largeur du champ interlocuteur
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(),"Visible", cmpEqual, true);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(),"Enabled", cmpEqual, true);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(),"Width" ,cmpEqual, WidthTxtRepresentative);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship(),"Visible", cmpEqual, true);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship(),"Width", cmpEqual, WidthBtnRepresentative);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(),"Visible", cmpEqual, true);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(),"Width", cmpEqual, WidthCheckBox);
         
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}
