//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6341 
    Description          :  Le but de ce cas est de :
                            - Mis à jour des  préférences.
                            - Créer des modèles à gestion déléguée(Ambassadeur)  qui seront utiliser pour les tests auto.
    Préconditions        :  IMPORTANT dans l'envrionnement BNC la config et les préférences sont peut-être déjà sur la bd de référence 
                            1- Configuration de niveau Firme:  DISCRETIONARY_MODE=1
                            2- Préférence de niveau firme : Pref_Model_Discretionary_Mode=1
                            3- Préférence de niveau firme : Pref_allow_sleeve_nondisc = Yes
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-2
    Date                 :  03/04/2019
    
*/


function CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6341","Lien du Cas de test sur Testlink");
    
            //Mettre les Prefs DISCRETIONARY_MODE=1 et Pref_Model_Discretionary_Mode=1 (vient avec le Dump je vais les laisser en commentaire)
            
            Activate_Inactivate_PrefFirm("FIRM_1", "DISCRETIONARY_MODE", 1, vServerModeles);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_DISCRETIONARY_MODE", 1, vServerModeles);
            
            //Mettre la pref Pref_allow_sleeve_nondisc = Yes
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_SLEEVE_NONDISC", "YES", vServerModeles);
            
            //Exécuter la requête qui permet d'ajouter et rééquilibrer un modèle ambassadeur au segment 
            Execute_SQLQuery("update B_MODEL_TYPE set ALLOW_EDIT_POSITIONS = 'Y',ALLOW_RESTRICTIONS = 'Y', ALLOW_CREATE = 'Y',ALLOW_delete = 'Y',ALLOW_EDIT_INFO = 'Y',ALLOW_SYNC_RULES = 'Y', CAN_BE_SUBMODEL='Y', ALLOW_ASSIGN='Y', ALLOW_SYNC='Y' where MODEL_TYPE_CODE = 'AMBA'", vServerModeles);
            
            //Exécuter le Plugin du CR2070
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            //Redemarrer les service
            RestartServices(vServerModeles);
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName1Croes_6341 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var modelName2Croes_6341 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var TypModelCroes_6341 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "TypModelCroes_6341", language+client);
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
            
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Créer deux modèles Ambassadeurs s'ils ne le sont pas
            Log.Message("-------------- Créer deux modèles ambassadeurs -----------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
            CreateModelIfNotExist(modelName1Croes_6341, TypModelCroes_6341);
            CreateModelIfNotExist(modelName2Croes_6341, TypModelCroes_6341);
            
            //Mailler Le 1er modele dans portefeuille
            Log.Message("------------ Mailler le modèle "+modelName1Croes_6341+" vers portefeuille -------------------");
            SearchModelByName(modelName1Croes_6341);
            Get_ModelsGrid().Find("Value",modelName1Croes_6341,10).Click();
       
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
            Log.Message("------------ Mailler le modèle "+modelName2Croes_6341+" vers portefeuille -------------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modelName2Croes_6341);
            Get_ModelsGrid().Find("Value",modelName2Croes_6341,10).Click();
       
            //Mailler vers le module portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            
            //Ajouter position SAP (saputo inc) cible 10%
            Log.Message("---------------- Ajouter d'une position au modèle ----------------------------");        
            AddPositionToModel(symbol1_Model2,description1_Model2,cible1_Model2);
            
            //Sauvgarder
            Log.Message("---------------- Sauvegarder les changements ---------------------------------");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            //Cocher la cas Actif pour les 2 modeles si ce n'est pas le cas
            Log.Message("-------------- Cocher la case à cocher 'Acif' des deux modèle si ce n'est pas le cas --------------");
            CheckModelActif(modelName1Croes_6341);
            CheckModelActif(modelName2Croes_6341);   
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

 function CreateModelIfNotExist(modelName,type){
    SearchModelByName(modelName)
    if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
        Log.Message("Le modèle est déjà existe");
    }else{
        Create_Model(modelName,type);
    }
 }
 
 function AddPositionToModel(symbol,description,cibleValue){
      Get_Toolbar_BtnAdd().Click();
      if (Get_DlgConfirmation().Exists){   
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73);
      }
      Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".")
      Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().set_Text(symbol);   
      Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
      if (Get_SubMenus().Exists)
          Get_SubMenus().Find("Text",description,10).DblClick();
            
      Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(cibleValue);
      Get_WinAddPositionSubmodel_TxtValuePercent().Click();
      Get_WinAddPositionSubmodel_BtnOK().WaitProperty("IsEnabled", true, 30000);  
      Get_WinAddPositionSubmodel_BtnOK().Click(); 
 }
 
 function CheckModelActif(modelName){
      Get_ModulesBar_BtnModels().Click();
      Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
      SearchModelByName(modelName);
      Get_ModelsGrid().Find("Value",modelName,10).DblClick();
      WaitObject(Get_CroesusApp(),"Uid","InfoModelWindow_b101");
      Get_WinModelInfo_GrpModel_ChkActive().set_IsChecked(true);
      Get_WinModelInfo_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoModelWindow_b101");
 }
 
 
 
