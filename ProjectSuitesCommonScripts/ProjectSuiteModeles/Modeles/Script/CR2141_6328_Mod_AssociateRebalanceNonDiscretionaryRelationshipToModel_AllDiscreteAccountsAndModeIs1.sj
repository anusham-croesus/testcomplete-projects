//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6320_Mod_AssociateAssignedDiscOrNonDiscToInternalModelAndAMBA_Pref_Model_Discretio


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6328
    Description          :  Le but de ce cas est de valider qu'il est possible d'associer une relation non discretionnaire avec  tous les comptes disc à un modele 
                            interne et un modèle à gestion delegué (en mode 1 le statut du parent est ignoré seul le statut des enfants est pris en compte ).
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-3
    Date                 :  04/04/2019
    
*/


function CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6328","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var relationName_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName_6328", language+client);
            var IACode_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "IACode_6320", language+client);
            var accountNo1_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6328", language+client);
            var accountNo2_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6328", language+client);
            var modelName_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6328", language+client);
            var modelNameAMBA_6328 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
           
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Créer une relation ND-test1 avec code de CP = AC42
            CreateRelationship(relationName_6328,IACode_6328);
            
            //Exécuter la requête suivante pour rendre la relation  non discrétionnaire
            Log.Message("Rendre la relation non discrétionnaire");
            Execute_SQLQuery("update b_link set is_discretionary='N' where fullname = '"+relationName_6328+"'", vServerModeles);
            
            //Ajouter les comptes 800288-FS et 800290-GT à la relation créée
            JoinAccountToRelationship(accountNo1_6328, relationName_6328);
            JoinAccountToRelationship(accountNo2_6328, relationName_6328);
            
            //Assigner la relation au modèle CH-BONDS
            Log.Message("---------- Associer la relation "+relationName_6328+" au modèle "+modelName_6328+" ----------");
            AssignRelationToModel(relationName_6328,modelName_6328);
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Rééquilibrer le modèle 
            Log.Message("-------------- Rééquilibrer le modèle ---------------------");
            RebalanceModel(modelName_6328);
            
            //Vérifier que l'application se dirige vers le module ordres
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(), "IsChecked", cmpEqual,true);
            
            //Enlever la relation ND-test1 du modèle
            Log.Message("---------- Enlever la relation "+relationName_6328+" du modèle "+modelName_6328+" ----------");
            RemoveRelationshipFromModel(modelName_6328,relationName_6328);
             
            //Associer la relation ND-TEST1 au modèle AMBA2
            Log.Message("---------- Associer la relation "+relationName_6328+" au modèle "+modelNameAMBA_6328+" ----------");
            Get_ModulesBar_BtnRelationships().Click();
            AssignRelationToModel(relationName_6328,modelNameAMBA_6328); 
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Rééquilibrer le modèle AMBA2 
            Log.Message("-------------- Rééquilibrer le modèle ---------------------");
            RebalanceModel(modelNameAMBA_6328);
            
            //Vérifier que l'application se dirige vers le module ordres
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(), "IsChecked", cmpEqual,true);
            
            //Enlever la relation ND-test1 du modèle AMBA2
            Log.Message("---------- Enlever la relation "+relationName_6328+" du modèle "+modelNameAMBA_6328+" ----------");
            RemoveRelationshipFromModel(modelNameAMBA_6328,relationName_6328);      
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Supprimer la relation créée
            //Ici je supprime la relation à partir du détails à cause de l'anomalie qui affiche le message que le portefeuille est en cours d'édition ou rééquilibrage
            Log.Message("-------------- supprimer la relation créée pour retourner à l'état initial --------------------");
            DeleteRelationshipFromDetails(relationName_6328);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}
 
 function RebalanceModel(modelName){
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
            Get_WinGenerateOrders_BtnGenerate().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            } 
              
 }
 
 function RemoveRelationshipFromModel(modelName,relationName){
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelName);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Models_Details_DgvDetails().Find("Value",relationName,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
 }
 
 