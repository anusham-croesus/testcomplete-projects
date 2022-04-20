//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1


/**
    Module               :  Modeles
    CR                   :  2141
    TestLink             :  Croes-6325
    Description          :  Le but de ce cas est de:
                            - Valider l'association et le rééquilibrage d'un segment discr et d'un segment non discr en mode1
                            - Valider Le point précédent lorsque la PREF_ALLOW_SLEEVE_NONDISC=NO ou YES.
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-6
    Date                 :  08/04/2019
    
*/


function CR2141_6325_Mod_AssociateAndRebalanceDiscretionarySleeve_Mode1() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6325","Lien du Cas de test sur Testlink");
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6325 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6322", language+client);
            var accountNo_6325 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6325", language+client);
            var sleevedescription_6325 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "sleevedescription_6325", language+client);
            var target_6325 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "target_6325", language+client);
            var underlyingSecurity_6325 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "underlyingSecurity_6325", language+client);

            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller dans le module Compte et sélectionner le compte 800292-JW 
            Log.Message("------------- Aller au module Comptes ----------------------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize();
            Search_Account(accountNo_6325);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6325,10).Click();
            
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
            Log.Message("------------ Ajouter le segment "+sleevedescription_6325+" ----------------");
            Add_Sleeve(sleevedescription_6325,target_6325);
            
            //Cliquer sur modifier et associer le modèle interne CH CANADIAN EQUI au SEG1 et AMBA2 au SEG2
            EditSleeve(sleevedescription_6325, modelName_6325);
           
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Cliquer une 2ème fois sur le bouton Segment pour modifier les segment créés
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Déplacer le titre sous-jacent XBB à Seg1 pour avoir une balance
            Log.Message("------------ Déplacer un titre sous-jacent au segment pour avoir un solde -----------------");
            MoveUnderlyingSecurityToSleeve(sleevedescription_6325,underlyingSecurity_6325);
                        
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
            
            //Sélectionner le segment SEG1 et rééquilibrer avec l'option "Rééquilibrer le ou les segments sélectionnés"
            Log.Message("Rééquilibrer le segment SEG1 par  avec l'option 'Rééquilibrer le ou les segments sélectionnés'");
            Get_Portfolio_PerSleeveGrid().Find("Value",sleevedescription_6325,10).Click();
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/3)),73);
            } 
            
            //Valider qu'il ya des ordres proposés pour le comptes 800292-JW
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6325);
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
            
            //Refaire le rééquilibrage avec l'option "Rééquilibrer le compte"
            Log.Message("Rééquilibrer le segment SEG1 par  avec l'option 'Rééquilibrer le compte'");
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
            
            //Valider qu'il ya des ordres proposés pour le comptes 800292-JW
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6325);
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
            
            //Accéder au module compte et faire un rafraichir
            Log.Message("------------------------- Aller au module Comptes ---------------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            //Sélectionner le compte et rééquilibrer avec l'option "Rééquilibrer le compte"
            Log.Message("Rééquilibrer le compte "+accountNo_6325+" avec l'option 'Rééquilibrer le compte'");
            Search_Account(accountNo_6325);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6325,10).Click();
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
            
            //Valider qu'il ya des ordres proposés pour le comptes 800292-JW
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6325);
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
            
            //Rééquilibrer le compte avec l'option "Rééquilibrer tous les segments"
            Log.Message("Rééquilibrer le compte "+accountNo_6325+" avec l'option 'Rééquilibrer tous les segments'");
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
            
            //Valider qu'il ya des ordres proposés pour le comptes 800292-JW
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6325);
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
            //Supprimer les segments créés
            Log.Message("------------ Supprimer le segment créé pour retourner à l'état initial --------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Search_Account(accountNo_6325);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6325,10).Click();
            
            //Mailler vers portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer le bouton Segement
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            DeleteSleeveWinSleevesManager(sleevedescription_6325);
            
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

function Add_Sleeve(description,target){
        //Ajouter un segment
        Log.Message("----------------- Ajout de segment "+description+" ----------------");
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text( description);
        Get_WinEditSleeve_TxtTargerPercent().set_Text(target)
        Get_WinEditSleeve_BtOK().Click();
}
function EditSleeve(Description, ModelName){
        Log.Message("------------ Associer le modèle "+ModelName+" au segment "+Description+" -----------------");
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",Description,10).Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 10000);
        if (Get_WinManagerSleeves_GrpSleeves_BtnEdit().Enabled == false)
             Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
        Get_WinEditSleeve_TxtValueTextBox().set_Text(ModelName);
        Get_WinEditSleeve_TxtValueTextBox().Keys("[Tab]");
        Get_WinEditSleeve_BtOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
 }
function MoveUnderlyingSecurityToSleeve(sleeveDescription,securityDescription) {
        Log.Message("--------------- Déplacer le titre sous-jacent "+securityDescription+" sur le segment "+sleeveDescription+" ---------------");
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().FindChild("Value",securityDescription,10).Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
        WaitObject(Get_CroesusApp(),"Uid","MoveWindow_baf3");
        Get_WinMoveSecurities_BtnOk().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MoveWindow_baf3");     
}