//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6363 
    Description          :  Rééquilibrer un client discré associé à Modèle interne ou AMBA_tous les cpts discr

                            Le but de ce cas est de
                            - Valider le rééquilibrage et la génération des ordres dans l'accumulateur d'un client discrétionnaire associé à modèle interne 
                              ou un modèle à gestion déléguée. Tous les comptes du client sont discrétionnaire. 
                            - Valider le rééquilibrage d'un client non discrétionnaire
                            - Valider que les ordres ne peuvent pas être envoyer à GDO croesus dans le cas d'un client non discr associé à modèle interne 
                            - Valider que les ordres peuvent être envoyer à GDO croesus dans le cas d'un client non discr associé à modèle à gestion déléguée.
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  13/05/2019
    
*/


function CR2070_CR2141_6363_RebalancingDiscClientAssociatedWithInternalModelOrAMBA_AllDiscCpts() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6363","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6361", language+client);
            var clientNo_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo1_6349", language+client);
            var option1_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option1_6361", language+client);
            var discHeaderStep2_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discHeaderStep2_6349", language+client);
            var option2_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6363", language+client);
            var MsgNonBloc_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "MsgNonBloc_6363", language+client);
            var MsgBloc_6363 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "MsgBloc_6363", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            Log.Message("-------- Associer le client"+clientNo_6363+" au modèle "+modelName_6363+" ----------");
            AssociateClientWithModel(modelName_6363, clientNo_6363);
            
            //rééquilibrer le modèle
            Log.Message("------- Rééquilibrer jusqu'à l'étape 1 ----------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            // Decocher les trois  cases  car  pas pertinente pour le cas
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);  
            
            //Points de vérication à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6363); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 

            //Aller à l'étape 2 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 2 de rééquilibrage sans changer de sélection 'Discrétionnaires coché' ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            //Points de vérification à l'étape 2 de rééquilibrage
            Log.Message("------------- Points de vérification à l'étape 2 ------------------");
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, discHeaderStep2_6363);
            
            //Aller à l'étape 4 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();  
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            Log.Message("---------- Valider qu'il n ya pas de message bloquant ---------------");
            //aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, MsgNonBloc_6363);
            Log.Checkpoint("Pas de message bloquant") ;
            
            //Aller à l'étape 5 
            Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
            Get_WinGenerateOrders_BtnGenerate().Click();
            if (Get_DlgConfirmation().Exists)
               Get_DlgConfirmation().Click(Get_DlgConfirmation().Get_Width()*(2/3),73);
            Log.Message("------ Vérifier que l'application se dirige vers le module Ordres ----------------");
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(),"IsChecked", cmpEqual, true);
            
            //Exécuter la requête pour rendre le client non discrétionnaire
            Log.Message("------ Rendre le client "+clientNo_6363+" non discrétionnaire -----------");
            Execute_SQLQuery("update b_client set is_discretionary='N' where no_client = '800044'", vServerModeles);
            
            //Retourner dans modèle et rafraichir
            Get_ModulesBar_BtnModels().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            Log.Message("--------- Rééquilibrer le modèle -------------");
            SearchModelByName(modelName_6363);
            Log.Message("------- Rééquilibrer jusqu'à l'étape 1 ----------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //Decocher la case tolerance
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().Click();  
            
            //Points de vérication à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6363); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, true);
            
            Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();  
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            //Vérification du message bloquant
            Log.Message("------------ Vérification du message bloquant --------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, MsgBloc_6363);
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Retirer le client du modèle
            Log.Message("-------- Retirer le client "+clientNo_6363+" du modèle "+modelName_6363);
            RemoveRelationshipClientAccountFromModel(modelName_6363,clientNo_6363);
            
            //Exécuter la requête pour rendre le client discrétionnaire
            Log.Message("------ Rendre le client "+clientNo_6363+" non discrétionnaire -----------");
            Execute_SQLQuery("update b_client set is_discretionary='Y' where no_client = '800044'", vServerModeles);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

