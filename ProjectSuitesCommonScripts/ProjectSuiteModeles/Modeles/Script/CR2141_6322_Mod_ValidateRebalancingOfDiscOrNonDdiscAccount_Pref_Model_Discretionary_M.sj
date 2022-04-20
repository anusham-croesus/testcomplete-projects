//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6322
    Description          :  Le but de ce cas est.
                            - Valider le comportement existant lorsque la Pref_Model_Discretionary_Mode=1
                            - Valider l'assignation et le rééquilibrage d'un compte discrétionnaire 
                            - Valider qu'il n'est pas possible de rééquilibrer un compte non discr associé à modèle à gestion interne et que le contraire est possible pour un modèle à gestion déléguée
                            - Valider que seulement les ordres sur les comptes disc peuvent être envoyer à GDO croesus
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-3
    Date                 :  05/04/2019
    
*/


function CR2141_6322_Mod_ValidateRebalancingOfDiscOrNonDdiscAccount_Pref_Model_Discretionary_M() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6322","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6322 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6322", language+client);
            var modelName_6322 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6322", language+client);
            var msgRebalance_6322 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgRebalance_6322", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller dans le module Compte et sélectionner le compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            
            //rechercher le compte 800008-NA et associer au modele
            AssignAcountToModel(accountNo_6322,modelName_6322);
            CheckNotConflict();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Rééquilibrer le modèle 
            RebalanceModel(modelName_6322);
            
            //Vérifier que l'application se dirige vers le module ordres
            Log.Message("Vérifier qu'il n ya pas de message bloquant et l'application se dirige vers le module ordres ")
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(), "IsChecked", cmpEqual,true);
            
            //Exécuter la requête suivante pour rendre le compte  non discrétionnaire
            Log.Message("----------- Rendre le compte non discrétionnaire ----------------");
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '"+accountNo_6322+"'", vServerModeles);
            //Redemarrer les service
            RestartServices(vServerModeles);             
            //Fermer l'application
            Terminate_CroesusProcess();            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module modèle et rééquilibrer le modèle
            Get_ModulesBar_BtnModels().Click();
            Get_ModelsGrid().Find("Value",modelName_6322,10).Click();
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
            Log.Message("Vérifier le message bloquant affiché");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10),"WPFControlText", cmpEqual, msgRebalance_6322) ;
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click(width/3,73);
            }
            
            //Enlever le compte 800008-NA du modèle CH CANADIAN EQUI
            Log.Message("Retirer le compte "+accountNo_6322+" du modèle "+modelName_6322);
            RemoveAccountFromModel(accountNo_6322,modelName_6322); 
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

 /*function RemoveAccountFromModel(modelName,accountNo){
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelName);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Models_Details_DgvDetails().Find("Value",accountNo,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
 }*/
 

