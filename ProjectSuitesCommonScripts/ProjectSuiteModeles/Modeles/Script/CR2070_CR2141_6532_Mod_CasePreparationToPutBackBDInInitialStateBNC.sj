//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2070_CR2141_6463_Mod_DiscAndNotDiscAccountsTiggers



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6532 
    Description          :  Cas de préparation pour remettre la BD dans l'état initial de BNC.
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  22/05/2019
    
*/


function CR2070_CR2141_6532_Mod_CasePreparationToPutBackBDInInitialStateBNC() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6532","Lien du Cas de test sur Testlink");
                            
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo1_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6348", language+client);
            var accountNo2_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6348", language+client);
            var accountNo3_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo3_6348", language+client);
            var accountNo4_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo4_6348", language+client);
            var accountNo5_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo5_6348", language+client);
            var accountNo6_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo6_6348", language+client);
            var accountNo7_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo7_6348", language+client);
            var accountNo8_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo8_6348", language+client);
            var accountNo9_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo9_6348", language+client);
            var modelNameAMBA1_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var modelNameAMBA2_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var relationName1_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var relationName2_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName2_6348", language+client);
            var frenchLong_6532 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "frenchLong_6348", language+client)
           
            //Se loguer avec Keynej
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Enlever le contenu du profil KYC-Type honoraires pour les différents comptes
            setProfileToBlanc(accountNo1_6532);
            setProfileToBlanc(accountNo2_6532);
            setProfileToBlanc(accountNo3_6532);
            setProfileToBlanc(accountNo4_6532);
            setProfileToBlanc(accountNo5_6532);
            setProfileToBlanc(accountNo6_6532);
            setProfileToBlanc(accountNo7_6532);
            setProfileToBlanc(accountNo8_6532);
            
            //Supprimer les modèles ambassadeurs créés dans le script de préparation d'environement
            Log.Message("----------- Supprimer les modèles ambassadeurs créés dans Croes-6348 ----------------");
            DeleteModelByName(modelNameAMBA1_6532);
            DeleteModelByName(modelNameAMBA2_6532);
            
            //Enlever les comptes des relations D--TEST8 et D--TEST7
            RemoveAccountFromRelationship(relationName1_6532, accountNo4_6532);
            RemoveAccountFromRelationship(relationName1_6532, accountNo5_6532);
            RemoveAccountFromRelationship(relationName1_6532, accountNo6_6532);
            RemoveAccountFromRelationship(relationName2_6532, accountNo7_6532);
            RemoveAccountFromRelationship(relationName2_6532, accountNo9_6532);
            
            //Supprimer les 2 relations
            DeleteRelationship(relationName1_6532);
            DeleteRelationship(relationName2_6532);
                                   
            //Se connecter à croesus avec GP1859
            Login(vServerModeles, userNameGP1859, passwordGP1859, language);
            Get_MainWindow().Maximize();
            
            //Aller au Menu Outils/Configuration/Profils et Dictionnaire/Profils
            Log.Message("-------- Accéder au Menu Outils/Configuration/Profils et Dictionnaire/Profils ---------");
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();
            WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
            Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
            if (language == "french") WaitObject(Get_CroesusApp(),"WPFControlText", "Profils");
            else WaitObject(Get_CroesusApp(),"WPFControlText", "Profiles")
            Get_WinConfigurations_LvwListView_LlbProfiles().DblClick();
            WaitObject(Get_CroesusApp(),"Uid","ConfigurationWindow_a034");
            
            //Supprimer le profil KYC-Type hon
            Log.Message("------- Supprimer le profil 'KYC-Type hon' ------------------");
            Get_WinProfilesAndDictionaryConfiguration().Find("Value",frenchLong_6532,10).Click();
            Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDelete().Click();
            Get_DlgConfirmation_BtnDelete().Click();
            Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click()
            Get_WinConfigurations().Close();
            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            
            //Fermer l'application
            Terminate_CroesusProcess();
            
           //Mettre les Prefs DISCRETIONARY_MODE=1 et Pref_Model_Discretionary_Mode=1 
            Activate_Inactivate_PrefFirm("FIRM_1", "DISCRETIONARY_MODE", 1, vServerModeles);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_DISCRETIONARY_MODE", 1, vServerModeles);
                        
            //Mettre la pref Pref_allow_sleeve_nondisc = Yes
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_SLEEVE_NONDISC", "NO", vServerModeles);
            
            //Exécuter le Plugin du CR2070
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            //Redemarrer les service
            RestartServices(vServerModeles);                  
        }
}




