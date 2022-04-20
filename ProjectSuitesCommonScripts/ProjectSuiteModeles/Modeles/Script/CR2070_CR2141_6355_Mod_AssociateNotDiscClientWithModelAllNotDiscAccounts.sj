//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6355 
    Description          :  Le but de ce cas est de valider l'assignation à modèle d'un client non discrétionnaire dont tous les comptes sont non discrétionnaires.
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  10/05/2019
    
*/


function CR2070_CR2141_6355_Mod_AssociateNotDiscClientWithModelAllNotDiscAccounts() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6355","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6355 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6320", language+client);
            var clientNo_6355 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6355", language+client);
            var modelNameAmba1_6355 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Log.Message("-------- Associer le client"+clientNo_6355+" au modèle "+modelName_6355+" ----------");
            SearchModelByName(modelName_6355);
            Get_ModelsGrid().Find("Value",modelName_6355,10);
            Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
            Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
            Get_WinPickerWindow_DgvElements().Keys("F"); 
            WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
            Get_WinQuickSearch_TxtSearch().Clear();
            Get_WinQuickSearch_TxtSearch().Keys(clientNo_6355);
            Get_WinQuickSearch_RdoClientNo().Set_IsChecked(true);
            Get_WinQuickSearch_BtnOK().Click()  
            Get_WinPickerWindow_DgvElements().Find("Value",clientNo_6355,10).Click();
            Get_WinPickerWindow_BtnOK().Click();
            
            //Vérifier qu'il n ya pas de message bloquant
            CheckNotConflict();
            if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
            Get_WinAssignToModel_BtnNo().Click(); 
            
            //Refaire l'étape 2 avec le modèle Ambassadeur
            Log.Message("-------- Associer le client"+clientNo_6355+" au modèle "+modelNameAmba1_6355+" ----------");
            AssignClientToModel(clientNo_6355, modelNameAmba1_6355);
            
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


