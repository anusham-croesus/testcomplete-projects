//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1490_CR1764_6289_Rel_ValidateAddProfilesForREAGAR_PrefIs5

/**
    CR                  : 1490 devenu 1764
    Cas de test         : CROES-6291
    Description         : Valider l'ajout de profils pour KEYNEJ pref = 15
   
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-Fm-11
    Date                : 26-04-2019
    
*/
function CR1490_CR1764_6291_Rel_ValidateAddProfilesForKEYNEJ_PrefIs15(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6291","Lien du Cas de test sur Testlink");
                
                var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
                var relationshipName_6291 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "relationshipName_6291", language+client);
                var IACode_6291 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "IACode_6291", language+client);
                var pref = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefKeynej", language+client));
                
                //Se connecter à l'application
                Login(vServerRelations, userNameKeynej, passwordKeynej, language);
                
                //Aller au module relation et ajouter une relation
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                CreateRelationship(relationshipName_6291,IACode_6291);
                
                //Selectionner la relation créée et accéder à la fenêtre info
                Log.Message("------ Selectionner la relation créée et accéder à la fenêtre info ------------------");
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6291,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Cocher les 16 premiers profils
                for (i=1;i<=pref+1;i++){
                     CheckProfile(i);
                }
                
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Log.Checkpoint("Le système permet de cocher tous les "+(pref+1)+" profils 'plus de "+pref+" profils définis par la pref'");
                Get_WinDetailedInfo_BtnOK().Click();
                
                //Mettre la configuration par défaut des colonnes
                Log.Message("----------- Mettre la configuration par défaut des colonnes ----------------");
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                
                //Ajouter une colonne profile, ici on essaye d'ajouter tous les profils soit 5 et on valide qu'on ne peut ajouter qu'une seule
                Log.Message("---- Ici on essaye d'ajouter tous les profils soit "+(pref+1)+" et on valide qu'on ne peut ajouter que "+pref+" colonnes-------");
                AddAndCheck_ProfileColumns(Get_RelationshipsGrid_ChTotalValue(),pref);
                
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Décocher tous les profils de 
                Log.Message("-------- Décocher tous les profils cochés  -------------------");
                Log.Message("------ Selectionner la relation créée et accéder à la fenêtre info ------------------");
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6291,10).Click();
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6291,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Décocher les 16 premiers profils
                for (i=1;i<=pref+1;i++){
                     UnCheckProfile(i);
                }
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Get_WinDetailedInfo_BtnOK().Click();
                 
                //Supprimer la relation créé
                Log.Message("---- Supprimer la relation créée --------");
                DeleteRelationship(relationshipName_6291);
                
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}

function test(){
  var pref = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefKeynej", language+client);
  //Cocher les 16 premiers profils
  var profilACocher = StrToInt(pref)+1;
                for (i=1;i<=profilACocher;i++){
                     CheckProfile(i);
                }
}