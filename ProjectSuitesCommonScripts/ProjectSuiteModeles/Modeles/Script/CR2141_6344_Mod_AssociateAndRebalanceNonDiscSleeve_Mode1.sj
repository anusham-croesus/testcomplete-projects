//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6325_Mod_AssociateAndRebalanceDiscretionarySleeve_Mode1


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6344
    Description          :  Le but de ce cas est de:
                            - Valider le message bloquant le rééquilibrage d'un compte UMA non discrétionnaire.
                            - Valider qu'un segment non discrétionnaire ne peut être associer qu'à un modèle à gestion déléguée.
    Préconditions        :  update b_compte set is_discretionary='N' where no_compte = "800046-FS" 
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-6
    Date                 :  09/04/2019
    
*/


function CR2141_6344_Mod_AssociateAndRebalanceNonDiscSleeve_Mode1() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6344","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6344 = "800046-FS"//ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6344", language+client);
            var modelNameAMBA1_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var modelNameAMBA2_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var sleevedescription1_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "sleevedescription1_6344", language+client);
            var typeAsset1_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "typeAsset1_6344", language+client);
            var target1_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "target1_6344", language+client);
            var sleevedescription2_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "sleevedescription2_6344", language+client);
            var typeAsset2_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "typeAsset2_6344", language+client);
            var target2_6344 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "target2_6344", language+client);

            //Exécuter la requête suivante pour rendre le compte 800046-FS  non discrétionnaire
            Log.Message("Rendre le compte "+accountNo_6344+" non discrétionnaire");
            Execute_SQLQuery("update b_compte set is_discretionary='N' where no_compte = '"+accountNo_6344+"'", vServerModeles);
            //Redemarrer les service
            RestartServices(vServerModeles);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller dans le module Compte et sélectionner le compte 800292-JW 
            Log.Message("------------- Aller au module Comptes ----------------------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            Search_Account(accountNo_6344);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6344,10).Click();
            
            //Mailler vers portefeuille
            Log.Message("-------------------- Mailler vers portefeuille -----------------------------");
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer le bouton Segement
            Log.Message("------------------- Cliquer le bouton segment -----------------------------");
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Ajouter un segment
            Log.Message("------------ Ajouter les segment "+sleevedescription1_6344+" et "+sleevedescription2_6344+" ----------------");
            Add_Sleeve(sleevedescription1_6344,typeAsset1_6344,target1_6344);
            Add_Sleeve(sleevedescription2_6344,typeAsset2_6344,target2_6344);
            
            //Cliquer sur modifier et associer le modèle interne CH CANADIAN EQUI au SEG1 et AMBA2 au SEG2
            EditSleeve(sleevedescription1_6344, modelNameAMBA1_6344);
            EditSleeve(sleevedescription2_6344, modelNameAMBA2_6344);
           
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Dans la section sommaire selectionner la répartition d'actifs Segments et cliquer sur le bouton "Par segment"
            Log.Message("Sélection de la répartition d'actifs 'Segement' dans sommaire du portefeuille et cliquer le bouton 'Par segment'");
            Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Focus();
            Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Click();
            Get_PortfolioGrid_GrpSummary_CmbAssetAllocation_Sleeves().Click();
            Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().WaitProperty("IsEnabled", true, 30000);  
            Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
            
            //Ne rien sélectionner  et Rééquilibrer avec l'option 'Rééquilibrer le compte'
            Log.Message("Rééquilibrer avec l'option 'Rééquilibrer le compte'sans rien sélectionner");
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().IsChecked == false)
                Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            } 
            
            //Valider qu'il ya des ordres proposés pour le comptes 800046-FS
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6344);
            //Valider que la grille des ordres proposés n'est pas vide
            if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
            else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click(width/3,73);
            }
            
            //Selectionner le segment SEG1 et rééquilibrer avec l'option 'Rééquilibrer tous les segments'
            Log.Message("Rééquilibrer le segment "+sleevedescription1_6344+" avec l'option 'Rééquilibrer tous les segments'");
            Get_Portfolio_PerSleeveGrid().Find("Value",sleevedescription1_6344,10).Click();
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            } 
            
            //Valider qu'il ya des ordres proposés pour le comptes 800046-FS
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6344);
            //Valider que la grille des ordres proposés n'est pas vide
            if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
            else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click(width/3,73);
            }
            
            //Selectionner le segment SEG1 et rééquilibrer avec l'option 'Rééquilibrer le ou les segments sélectionnés'
            Log.Message("Rééquilibrer le segment "+sleevedescription1_6344+" avec l'option 'Rééquilibrer le ou les segments sélectionnés'");
            Get_Portfolio_PerSleeveGrid().Find("Value",sleevedescription1_6344,10).Click();
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().Click();
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            } 
            
            //Valider qu'il ya des ordres proposés pour le comptes 800046-FS
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6344);
            //Valider que la grille des ordres proposés n'est pas vide
            if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
            else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click(width/3,73);
            }
              
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {  
            //Exécuter la requête suivante pour rendre le compte 800046-FS   discrétionnaire "Etat initial"
            Log.Message("Rendre le compte "+accountNo_6344+" discrétionnaire");
            Execute_SQLQuery("update b_compte set is_discretionary='Y' where no_compte = '"+accountNo_6344+"'", vServerModeles);      
      
            //Supprimer les segments créés
            Log.Message("------------ Supprimer les segments créés pour retourner à l'état initial --------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Search_Account(accountNo_6344);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6344,10).Click();
            
            //Mailler vers portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer le bouton Segement
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            DeleteSleeveWinSleevesManager(sleevedescription1_6344);
            DeleteSleeveWinSleevesManager(sleevedescription2_6344);
            
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
             //Supprimer les modèles ambassadeurs créés dans le script de préparation d'environement
            Log.Message("----------- Supprimer les modèles ambassadeur créés dans Croes-6341 ----------------");
            DeleteModelByName(modelNameAMBA1_6344);
            DeleteModelByName(modelNameAMBA2_6344);  
                        
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();
            
            // Mettre la pref Pref_allow_sleeve_nondisc = NO 
            Log.Message("------------- Mettre la pref Pref_allow_sleeve_nondisc = NO 'État initial' -----------------");
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_SLEEVE_NONDISC", "NO", vServerModeles);  
            
            //Redemarrer les service
            RestartServices(vServerModeles);                 
        }
}
function Add_Sleeve(description,typeAsset,target){
        //Ajouter un segment
        Log.Message("Ajout de segment "+description);
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text( description);
        Get_WinEditSleeve_CmbAssetClass().Click();
        Get_SubMenus().Find("WPFControlText",typeAsset,10).Click();
        Get_WinEditSleeve_TxtTargerPercent().set_Text(target)
        Get_WinEditSleeve_BtOK().Click();
}

