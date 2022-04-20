//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1490_CR1764_6289_Rel_ValidateAddProfilesForREAGAR_PrefIs5

/**
    CR                  : 1490 devenu 1764
    Cas de test         : CROES-6290
    Description         : Valider l'ajout de profils pour ADAMSJ pref = 1
   
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-Fm-11
    Date                : 26-04-2019
    
*/
function CR1490_CR1764_6290_Rel_ValidateAddProfilesForADAMSJ_PrefIs1(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6290","Lien du Cas de test sur Testlink");
                
                var userNameAdamsj = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "username");
                var passwordAdamsj = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "psw");
                
                var relationshipName_6290 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "relationshipName_6290", language+client);
                var pref = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefAdamsj", language+client));
                
                //Se connecter à l'application
                Login(vServerRelations, userNameAdamsj, passwordAdamsj, language);
                
                //Aller au module relation et ajouter une relation
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                CreateRelationship(relationshipName_6290);
                
                //Selectionner la relation créée et accéder à la fenêtre info
                Log.Message("------ Selectionner la relation créée et accéder à la fenêtre info ------------------");
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6290,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Cocher les 5 premiers profils
                CheckProfile(1);
                CheckProfile(2);
                CheckProfile(3);
                CheckProfile(4);
                CheckProfile(5);
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Log.Checkpoint("Le système permet de cocher tous les 5 profils 'plus de 1 profil défini par la pref'");
                Get_WinDetailedInfo_BtnOK().Click();
                
                //Mettre la configuration par défaut des colonnes
                Log.Message("----------- Mettre la configuration par défaut des colonnes ----------------");
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                
                //Ajouter une colonne profile, ici on essaye d'ajouter tous les profils soit 5 et on valide qu'on ne peut ajouter qu'une seule
                Log.Message("---- Ici on essaye d'ajouter tous les profils soit 5 et on valide qu'on ne peut ajouter qu'une seule-------");
                AddAndCheck_ProfileColumns(Get_RelationshipsGrid_ChTotalValue(),pref);
                
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Décocher tous les profils de 
                Log.Message("-------- Décocher tous les profils cochés  -------------------");
                Log.Message("------ Selectionner la relation créée et accéder à la fenêtre info ------------------");
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6290,10).Click();
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6290,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Décocher les 5 premiers profils
                UnCheckProfile(1);
                UnCheckProfile(2);
                UnCheckProfile(3);
                UnCheckProfile(4);
                UnCheckProfile(5);
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Get_WinDetailedInfo_BtnOK().Click();
                 
                //Supprimer la relation créé
                Log.Message("---- Supprimer la relation créée --------");
                DeleteRelationship(relationshipName_6290);
                
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}


