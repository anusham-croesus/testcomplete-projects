//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6352 
    Description          :  Le but de ce cas est de
                            - Valider le message d'erreur bloquant qui s'affiche lorsqu'on associe un client discrétionnaire avec des comptes discrétionnaires et non discrétionnaires à un modèle interne
                            - Valider qu l'association d'un client discr avec des comptes non discr à un modèle AMBA est possible
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  10/05/2019
    
*/


function CR2070_CR2141_6352_Mod_AssociateClientWithCptDiscrAndNotDiscToModel_AccountsDiscAndNotDisc() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6352","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6352 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6320", language+client);
            var clientNo_6352 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6352", language+client);
            var msgwarning_6352 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgwarning_6352", language+client);
            var msgConflict_6352 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgConflict_6352", language+client);
            var modelNameAmba1_6352 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Log.Message("-------- Associer le client"+clientNo_6352+" au modèle "+modelName_6352+" ----------");
            SearchModelByName(modelName_6352);
            Get_ModelsGrid().Find("Value",modelName_6352,10);
            Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
            Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
            Get_WinPickerWindow_DgvElements().Keys("F"); 
            WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
            Get_WinQuickSearch_TxtSearch().Clear();
            Get_WinQuickSearch_TxtSearch().Keys(clientNo_6352);
            Get_WinQuickSearch_RdoClientNo().Set_IsChecked(true);
            Get_WinQuickSearch_BtnOK().Click()  
            Get_WinPickerWindow_DgvElements().Find("Value",clientNo_6352,10).Click();
            Get_WinPickerWindow_BtnOK().Click();
            
            //Vérifier le message bloquant
            aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid", "Label_3f1d",10), "WPFControlText", cmpEqual,msgwarning_6352);
            CheckConflict();
            aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid","ConflictReason",10), "Value", cmpEqual,msgConflict_6352);
            Get_WinAssignToModel_BtnClose().Click();
            
            Log.Message("-------- Associer le client"+clientNo_6352+" au modèle "+modelName_6352+" ----------");
            AssignClientToModel(clientNo_6352, modelName_6352);
            
            //Vérifier le message bloquant
            aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid", "Label_3f1d",10), "WPFControlText", cmpEqual,msgwarning_6352);
            CheckConflict();
            aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid","ConflictReason",10), "Value", cmpEqual,msgConflict_6352);
            Get_WinAssignToModel_BtnClose().Click();
            
            //Refaire l'étape 2 avec le modèle Ambassadeur
            Log.Message("-------- Associer le client"+clientNo_6352+" au modèle "+modelNameAmba1_6352+" ----------");
            AssignClientToModel(clientNo_6352, modelNameAmba1_6352);
            
            //Vérifier qu'il n ya pas de message bloquant
            CheckNotConflict();
            if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
            Get_WinAssignToModel_BtnNo().Click();       
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


