//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6320_Mod_AssociateAssignedDiscOrNonDiscToInternalModelAndAMBA_Pref_Model_Discretio


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6312 
    Description          :  Valider que les comptes, clients et relations associés à des codes de CP non discrétionnaire peuvent 
                            être associés à des modèle a gestion délégué (ambassadeur).
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-2
    Date                 :  04/04/2019
    
*/


function CR2141_6312_Mod_AssociateAccCliRelWithDelegatedManagementModel() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6312","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6312 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6320", language+client);
            var clientNo_6312 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6320", language+client);
            var modelName_6312 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var relationName_6312 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName_6312", language+client);
            var IACode_6312 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "IACode_6320", language+client);
           
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Log.Message("----------- Acceder au module Comptes -------------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            
            //Associer un compte discrétionnaire 800277-NA au modele ambassadeur 
            Log.Message("------------- Assigner le compte "+accountNo_6312+" au modèle "+modelName_6312 +" ----------");
            AssignAcountToModel(accountNo_6312,modelName_6312);
            //vérifier juste qu'il n ya pas un message bloquant
            Log.Message("------------- Vérifier qu'il n ya pas de message de conflit -------------------------");
            CheckNotConflict();
            if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
            Get_WinAssignToModel_BtnNo().Click();
            
           //Associer un client qui détient des comptes non discrétionnaires au modèle ambassadeur
           Log.Message("------------ Associer un client qui détient des comptes non discrétionnaires au modèle ambassadeur ------------");
           Get_ModulesBar_BtnClients().Click();
           Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
           AssignClientToModel(clientNo_6312, modelName_6312);
           //vérifier juste qu'il n ya pas un message bloquant
           Log.Message("------------- Vérifier qu'il n ya pas de message de conflit -------------------------");
           CheckNotConflict();
           if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
           Get_WinAssignToModel_BtnNo().Click();
           
           //Créer une relation ND-test5 avec code de CP = AC42
           CreateRelationship(relationName_6312,IACode_6312);
           //Ajouter le client 800066 à la relation créée
           JoinClientToRelationship(clientNo_6312, relationName_6312);
           //Assigner la relation au modèle ambassadeur
           Log.Message("------------- Associer la relation "+relationName_6312+" au modèle "+modelName_6312+" ----------------");
           AssignRelationToModel(relationName_6312,modelName_6312);
           //vérifier juste qu'il n ya pas un message bloquant
           Log.Message("------------- Vérifier qu'il n ya pas de message de conflit -------------------------");
           CheckNotConflict();
           if (Get_WinAssignToModel_BtnNo().Exists)
                Log.Checkpoint("Pas de message bloquant");
           Get_WinAssignToModel_BtnNo().Click();   
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Supprimer la relation créée
            //Ici je supprime la relation à partir du détails à cause de l'anomalie qui affiche le message que le portefeuille est en cours d'édition ou rééquilibrage
            Log.Message("--------- Supprimer la relation créée -------------------------");
            DeleteRelationshipFromDetails(relationName_6312);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}
