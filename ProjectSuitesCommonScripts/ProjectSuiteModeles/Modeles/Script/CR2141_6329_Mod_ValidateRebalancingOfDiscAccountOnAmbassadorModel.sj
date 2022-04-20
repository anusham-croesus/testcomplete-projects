//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6329
    Description          :  Le but de ce cas est.
                            - Valider qu'on peut rééquilibrer un compte non discrétionnaire avec un modèle ambassadeur.
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-3
    Date                 :  05/04/2019
    
*/


function CR2141_6329_Mod_ValidateRebalancingOfDiscAccountOnAmbassadorModel() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6329","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6329 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6322", language+client);
            var modelNameAMBA_6329 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            
            Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
                     
            //Exécuter la requête suivante pour rendre le compte non discrétionnaire à l'état initial en cas où le script précédent echoue
            Log.Message("Rendre le compte '800008-NA' non discrétionnaire");
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '"+accountNo_6329+"'", vServerModeles);
            //Redemarrer les service
            RestartServices(vServerModeles);
                                   
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller dans le module Compte et sélectionner le compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            
            //rechercher le compte 800008-NA et associer au modele AMBA2
            Log.Message("----------- Associer le compte "+accountNo_6329+" au modèle "+modelNameAMBA_6329+" ---------------");
            AssignAcountToModel(accountNo_6329,modelNameAMBA_6329);
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Rééquilibrer le modèle 
            Log.Message("-------------- Rééquilibrer le modèle ------------------------");
            RebalanceModel(modelNameAMBA_6329);
            
            //Vérifier que l'application se dirige vers le module ordres
            Log.Message("Vérifier qu'il n ya pas de message bloquant et l'application se dirige vers le module ordres ")
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(), "IsChecked", cmpEqual,true);
            
            //Enlever le compte 800008-NA du modèle AMBA2
            Log.Message("Retirer le compte "+accountNo_6329+" du modèle "+modelNameAMBA_6329);
            RemoveAccountFromModel(accountNo_6329,modelNameAMBA_6329); 
            aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
            
            //Fermer Croesus
            Log.Message("Fermer Croesus")
            Close_Croesus_X();
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Exécuter la requête suivante pour rendre le compte discrétionnaire à l'état initial
            Log.Message("Rendre le compte '800008-NA' discrétionnaire");
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte = '"+accountNo_6329+"'", vServerModeles);  
            
            //Redemarrer les service
            RestartServices(vServerModeles);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess(); 
                              
        }
}


