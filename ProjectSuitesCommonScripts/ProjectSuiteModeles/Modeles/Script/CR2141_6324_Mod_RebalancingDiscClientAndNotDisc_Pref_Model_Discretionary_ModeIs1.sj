//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6324
    Description          :  - En mode 1: On permet l'assignation et le rééquilibrage des assignés non discrétionnaires qui contient tous les comptes discrétionnaire, 
                            donc on regardre pas le statut des assignés mais le statut des comptes qu'ils contiennent 
                            - En mode2: On ne permet pas l'assignation et le rééquilibrage des assignés non discr qui contien des comptes disc (nouveau comportement) 

                            Le but de ce cas est de:
                            - valider le rééquilibrage d'un client discr.
                            - Valider que le rééquilibrage d'un client non disc n'est pas possible lorsque la Pref_Model_Discretionary_Mode=1 lorsqu'il est associé à un modèle interne.
                            - Valider le rééquilibrage d'un client non disc associé à modèle à gestion déléguée.
                            - Seulement les ordres sur les comptes discr peuvent être générés à GDO croesus dans le cas d'un modèle interne. 
                            - Dans le cas d'un modèle à gestion déléguée, les ordres générés suite au rééquilibrage des assignés discr et non discr peuvent être envoyer à GDO croesus.
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-6
    Date                 :  05/04/2019
    
*/


function CR2141_6324_Mod_RebalancingDiscClientAndNotDisc_Pref_Model_Discretionary_ModeIs1() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6324","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6320", language+client);
            var accountNo1_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6324", language+client);
            var accountNo2_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6324", language+client);
            var clientNo1_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo1_6324", language+client);
            var clientNo2_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo2_6324", language+client);
            var modelNameAMBA_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var msgRebalance_6324 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgRebalance_6324", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller dans le module Compte et sélectionner le compte 
            Log.Message("---------- Aller au modèle compte --------------------");
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            
            //Associer les clients 800013 et 800213 au modele CH LONG TERM
            Log.Message("---------- Associer le client "+clientNo1_6324+" au modèle "+modelName_6324);
            AssignClientToModel(clientNo1_6324,modelName_6324);
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
            AssignClientToModel(clientNo2_6324,modelName_6324);
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Exécuter les requêtes suivantes pour rendre les 2 comptes  non discrétionnaires
            Log.Message("Rendre les deux comptes "+accountNo1_6324+"et "+accountNo2_6324+" non discrétionnaires");
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '"+accountNo1_6324+"'", vServerModeles);
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '"+accountNo2_6324+"'", vServerModeles);            
            //Redemarrer les service
            RestartServices(vServerModeles);             
            //Fermer l'application
            Terminate_CroesusProcess();            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);            
            
            //Aller au module modèle et rééquilibrer le modèle
            Log.Message("--------- Aller au module modèle et rééquilibrer le modèle "+modelName_6324+" -------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            SearchModelByName(modelName_6324);
            Get_ModelsGrid().Find("Value",modelName_6324,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); //Etape4
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            
            //Vérifier le message bloquant qui indique que le rééquilibrage a échoué
            Log.Message("Vérifier le message bloquant affiché à l'étape 4");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10),"WPFControlText", cmpEqual, msgRebalance_6324) ;
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click(width/3,73);
            }
            
            //Enlever les clients 800013 et 800213 du modèle CH LONG TERM
            Log.Message("Retirer les clients "+clientNo1_6324+" et "+clientNo2_6324+" du modèle "+modelName_6324);
            RemoveClientFromModel(clientNo1_6324,modelName_6324);  
            RemoveClientFromModel(clientNo2_6324,modelName_6324);
            
            //Associer les clients 800013 et 800213 au modele AMBA2
            Log.Message("------ Associer les clients "+clientNo1_6324+" et "+clientNo2_6324+" au modèle "+modelNameAMBA_6324+" ------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            AssociateClientWithModel(modelNameAMBA_6324,clientNo1_6324);
            AssociateClientWithModel(modelNameAMBA_6324,clientNo2_6324);
            
            //Rééquilibrer le modèle 
            Log.Message("----------- rééquilibrer le modèle -----------------------------");
            RebalanceModel(modelNameAMBA_6324);
            
            //Vérifier que l'application se dirige vers le module ordres
            Log.Message("Vérifier qu'il n ya pas de message bloquant et l'application se dirige vers le module ordres ")
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(), "IsChecked", cmpEqual,true);
            
            //Enlever les clients 800013 et 800213 du modèle AMBA2
            Log.Message("Retirer les clients "+clientNo1_6324+" et "+clientNo2_6324+" du modèle "+modelNameAMBA_6324);
            RemoveClientFromModel(clientNo1_6324,modelNameAMBA_6324);  
            RemoveClientFromModel(clientNo2_6324,modelNameAMBA_6324);
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {  
            //Exécuter les requêtes suivantes pour rendre les 2 comptes discrétionnaires (État initial)
            Log.Message("Rendre les deux comptes "+accountNo1_6324+"et "+accountNo2_6324+" discrétionnaires");
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte = '"+accountNo1_6324+"'", vServerModeles);
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte = '"+accountNo2_6324+"'", vServerModeles);  
      
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

