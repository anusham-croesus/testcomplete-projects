//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6348 
    Description          :  Cas de préparation créer modèle et pref et profil
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  08/05/2019
    
*/


function CR2070_CR2141_6348_Mod_PreparationCaseCreateModelsPrefAndProfile() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6348","Lien du Cas de test sur Testlink");
    
            //Mettre les Prefs DISCRETIONARY_MODE=2 et Pref_Model_Discretionary_Mode=2 
            Activate_Inactivate_PrefFirm("FIRM_1", "DISCRETIONARY_MODE", 2, vServerModeles);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_DISCRETIONARY_MODE", 2, vServerModeles);
                        
            //Mettre la pref Pref_allow_sleeve_nondisc = Yes
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_SLEEVE_NONDISC", "YES", vServerModeles);
            
            //Exécuter le Plugin du CR2070
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            //Redemarrer les service
            RestartServices(vServerModeles);
            
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var mnemonic_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "mnemonic_6348", language+client);
            var frenchShort_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "frenchShort_6348", language+client);
            var frenchLong_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "frenchLong_6348", language+client);
            var englishShort_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "englishShort_6348", language+client);
            var englishLong_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "englishLong_6348", language+client);
            var lenght_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "lenght_6348", language+client);
            var accountNo1_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6348", language+client);
            var accountNo2_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6348", language+client);
            var accountNo3_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo3_6348", language+client);
            var accountNo4_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo4_6348", language+client);
            var accountNo5_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo5_6348", language+client);
            var accountNo6_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo6_6348", language+client);
            var accountNo7_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo7_6348", language+client);
            var accountNo8_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo8_6348", language+client);
            var profileValue1_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "profileValue1_6348", language+client);
            var profileValue2_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "profileValue2_6348", language+client);
            var profileValue3_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "profileValue3_6348", language+client);
            
            var modelName1Croes_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var modelName2Croes_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var TypModelCroes_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "TypModelCroes_6341", language+client);
            
            var symbol1_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "symbol1_Model1", language+client);
            var description1_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "description1_Model1", language+client);
            var cible1_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "cible1_Model1", language+client);
            var symbol2_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "symbol2_Model1", language+client);
            var description2_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "description2_Model1", language+client);
            var cible2_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "cible2_Model1", language+client);
            var symbol3_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "symbol3_Model1", language+client);
            var description3_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "description3_Model1", language+client);
            var cible3_Model1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "cible3_Model1", language+client);
            var symbol1_Model2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "symbol1_Model2", language+client);
            var description1_Model2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "description1_Model2", language+client);
            var cible1_Model2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "cible1_Model2", language+client);
            
            var relationName1_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var IACode_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "IACode_6348", language+client);
            var relationName2_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName2_6348", language+client);
            var accountNo9_6348 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo9_6348", language+client);
                        
            //Se connecter à croesus
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
            
            //Ajouter le profil KYC-Type hon
            Log.Message("------- Ajouter le profil 'KYC-Type hon' ------------------");
            Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnAdd().Click();
            Get_WinAddOrEditProfile_GrpProfile_TxtMnemonic().Keys(mnemonic_6348);
            Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort().Keys(frenchShort_6348);
            Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong().Keys(frenchLong_6348);
            Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort().Keys(englishShort_6348);
            Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong().Keys(englishLong_6348);
            
            Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType().DropDown();
            Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemText().Click();
            Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtLenght().Keys(lenght_6348);
            
            Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkExportToMSWord().set_IsChecked(true);
            Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkSearchCriteria().set_IsChecked(true);
            
            Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkClients().set_IsChecked(false);
            Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkAccounts().set_IsChecked(true);
            Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkRelationships().set_IsChecked(false);
            Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkSecurities().set_IsChecked(false);
            
            Get_WinAddOrEditProfile_BtnOK().Click();
            Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click()
            Get_WinConfigurations().Close();
            
            //Ajouter le profil aux comptes
            AddProfileToAccount(accountNo1_6348, frenchShort_6348, profileValue1_6348);
            AddProfileToAccount(accountNo2_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo3_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo4_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo5_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo6_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo7_6348, frenchShort_6348, profileValue2_6348); 
            AddProfileToAccount(accountNo8_6348, frenchShort_6348, profileValue3_6348); 
            
            //Exécuter la requête suivante 
            Execute_SQLQuery("update B_MODEL_TYPE set ALLOW_EDIT_POSITIONS = 'Y',ALLOW_RESTRICTIONS = 'Y', ALLOW_CREATE = 'Y',ALLOW_delete = 'Y',ALLOW_EDIT_INFO = 'Y',ALLOW_SYNC_RULES = 'Y', CAN_BE_SUBMODEL='Y', ALLOW_ASSIGN='Y', ALLOW_SYNC='Y' where MODEL_TYPE_CODE = 'AMBA'", vServerModeles);
            
            //Se loguer avec Keynej
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                                    
            //Créer deux modèles Ambassadeurs s'ils ne le sont pas
            Log.Message("-------------- Créer deux modèles ambassadeurs -----------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            Log.Message("------------- Créer deux modeles ambassadeurs --------------------");
            CreateModelIfNotExist(modelName1Croes_6348, TypModelCroes_6348);
            CreateModelIfNotExist(modelName2Croes_6348, TypModelCroes_6348);
            
            //Mailler Le 1er modele dans portefeuille
            Log.Message("------------ Mailler le modèle "+modelName1Croes_6348+" vers portefeuille -------------------");
            SearchModelByName(modelName1Croes_6348);
            Get_ModelsGrid().Find("Value",modelName1Croes_6348,10).Click();
       
            //Mailler vers le module portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            
            //Ajouter position SAP (saputo inc) cible 10% 
            Log.Message("---------------- Ajouter des positions au modèle ----------------------------");
            AddPositionToModel(symbol1_Model1,description1_Model1,cible1_Model1);
            AddPositionToModel(symbol2_Model1,description2_Model1,cible2_Model1);
            AddPositionToModel(symbol3_Model1,description3_Model1,cible3_Model1);
            
            //Sauvgarder
            Log.Message("---------------- Sauvegarder les changements ---------------------------------");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
             //Mailler Le 2eme modele dans portefeuille
            Log.Message("------------ Mailler le modèle "+modelName2Croes_6348+" vers portefeuille -------------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modelName2Croes_6348);
            Get_ModelsGrid().Find("Value",modelName2Croes_6348,10).Click();
       
            //Mailler vers le module portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            
            //Ajouter position MSFT cible 100%
            Log.Message("---------------- Ajout d'une position au modèle ----------------------------");        
            AddPositionToModel(symbol1_Model2,description1_Model2,cible1_Model2);
            
            //Sauvgarder
            Log.Message("---------------- Sauvegarder les changements ---------------------------------");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
             //Cocher la cas Actif pour les 2 modeles si ce n'est pas le cas
            Log.Message("-------------- Cocher la case à cocher 'Acif' des deux modèle si ce n'est pas le cas --------------");
            CheckModelActif(modelName1Croes_6348);
            CheckModelActif(modelName2Croes_6348); 
            
            //Aller dans le module Relations et ajouter les relations
            CreateRelationship(relationName1_6348, IACode_6348);
            JoinAccountToRelationship(accountNo4_6348, relationName1_6348);
            JoinAccountToRelationship(accountNo5_6348, relationName1_6348);
            JoinAccountToRelationship(accountNo6_6348, relationName1_6348);
            CreateRelationship(relationName2_6348, IACode_6348);
            JoinAccountToRelationship(accountNo7_6348, relationName2_6348);
            JoinAccountToRelationship(accountNo9_6348, relationName2_6348);       
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

function AddProfileToAccount(accountNo, frenchShort, profileValue) {
            var GroupBoxDefaut = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "GroupBoxDefaut", language+client);
            var ProfileValue = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", language+"Long_6348", language+client);     
             
            Log.Message("------------ Ajouter le profil "+frenchShort+" au compte "+accountNo+" --------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Search_Account(accountNo);
            Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo, 10).DblClick();
            //Acceder à l'onglet Profil
            Log.Message("----------- Acceder à l'onglet Profil -----------------");
            Get_WinDetailedInfo_TabProfile().Click();
            Get_WinInfo_TabProfile_BtnSetup().Click();
            //Cliquer sur le scrollDown pour aboutir la fin de la fenêtre
            Get_WinVisibleProfilesConfiguration().Click(Get_WinVisibleProfilesConfiguration().Width-25,Get_WinVisibleProfilesConfiguration().Height-95);
            var index= Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).Find("Value",ProfileValue,10).DataContext.DataItemIndex
            if (Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).IsChecked == false)
                Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).Click();//set_IsChecked(true);
            //Sauvegarder
            Get_WinVisibleProfilesConfiguration_BtnSave().Click();
            Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
            //Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("_currentControl").WPFObject("_itemsControl").WPFObject("Expander", "Défaut", 1).WPFObject("ItemsControl", "", 2).WPFObject("ContentControl", "", 1).WPFObject("TextBox", "", 1).Keys(profileValue);
            Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).WPFObject("ItemsControl", "", 2).WPFObject("ContentControl", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys(profileValue);
            Get_WinDetailedInfo_BtnApply().Click();
            Get_WinDetailedInfo_BtnOK().Click();
}

