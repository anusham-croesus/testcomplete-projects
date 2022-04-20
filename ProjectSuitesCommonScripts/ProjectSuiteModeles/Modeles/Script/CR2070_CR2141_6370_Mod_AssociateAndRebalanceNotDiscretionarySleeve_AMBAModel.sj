//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2070_CR2141_6348_Mod_PreparationCaseCreateModelsPrefAndProfile



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6370
    Description          :  Associer et rééquilibrer un segment non discrétionnaire_Modèle AMBA

                            Le but de ce cas est de
                            - Valider que la création de segments non discrétionnaires n'est pas possible si on l'associe pas à un modèle à gestion 
                              déléguée et que la somme des cibles des segments doit être 100%
                            - Valider le rééquilibrage de comptes UMA via le module Copmtes et Portefeuilles avec les 3 options 'Rééquilibrer le compte',
                              ' Rééquilibrer tous les segments' ou 'Rééquilibrer le ou les segments sélectionnés'.
                            - Valider que le rééquilibrage via le module Modèle d'un modèle à gestion déléguée met tous les comptes UMA à Discrétionnaires. 
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  16/05/2019
    
*/


function CR2070_CR2141_6370_Mod_AssociateAndRebalanceNotDiscretionarySleeve_AMBAModel() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6370","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6370", language+client);
            var sleevedescription1_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "sleevedescription1_6370", language+client);
            var target1_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "target1_6370", language+client);
            var modelNameAMBA1_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var sleevedescription2_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "sleevedescription2_6370", language+client);
            var target2_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "target2_6370", language+client);
            var modelNameAMBA2_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName2Croes_6341", language+client);
            var option1_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option1_6361", language+client);
            var option2_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6361", language+client);
            var underlyingSecurity1_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "underlyingSecurity1_6370", language+client);
            var underlyingSecurity2_6370 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "underlyingSecurity2_6370", language+client);
             
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Search_Account(accountNo_6370);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6370,10).Click();
            
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
            Log.Message("------------ Ajouter le segment "+sleevedescription1_6370+" ----------------");
            Add_Sleeve(sleevedescription1_6370,target1_6370);
            Log.Message("------------ Ajouter le segment "+sleevedescription2_6370+" ----------------");
            Add_Sleeve(sleevedescription2_6370,target2_6370);
            
            //Cliquer sur modifier et associer AMBA1 au SEG1 et AMBA2 au SEG2
            EditSleeve(sleevedescription1_6370, modelNameAMBA1_6370);
            EditSleeve(sleevedescription2_6370, modelNameAMBA2_6370);
            
                       
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Cliquer une 2ème fois sur le bouton Segment pour modifier les segment créés
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Déplacer des titres sous-jacent à Seg1 et Seg2 pour avoir une balance
            Log.Message("------------ Déplacer un titre sous-jacent au segment pour avoir un solde -----------------");
            MoveUnderlyingSecurityToSleeve(sleevedescription1_6370,underlyingSecurity1_6370);
            MoveUnderlyingSecurityToSleeve(sleevedescription2_6370,underlyingSecurity2_6370);
                       
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
            Log.Message("Rééquilibrer le segment ("+sleevedescription1_6370+") avec l'option 'Rééquilibrer le ou les segments sélectionnés'");
            Get_Portfolio_PerSleeveGrid().Find("Value",sleevedescription1_6370,10).Click();
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            
            //Points de vérification à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
            
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            
            //Valider qu'il ya des ordres proposés pour le compte 800246-NA et on voit aussi SEG1
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6370);
            //Cliquer + pour voir le segment
            Get_WinRebalance().Find("Uid", "TabControl_1a23",10).Click(12,75);
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","SleeveDescription",100),"Value", cmpEqual, sleevedescription1_6370);
            
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
            Log.Message("Rééquilibrer le segment ("+sleevedescription1_6370+") avec l'option 'Rééquilibrer le compte'");
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            
            //Points de vérification à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
            
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            
            //Valider qu'il ya des ordres proposés pour le comptes 800246-NA
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6370);
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
            
            //Sélectionner le compte et rééquilibrer avec l'option "Rééquilibrer tous les segments"
            Log.Message("Rééquilibrer le compte "+accountNo_6370+" avec l'option 'Rééquilibrer tous les segments'");
            Search_Account(accountNo_6370);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6370,10).Click();
            
            Get_Toolbar_BtnRebalance().Click();
            if (Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().IsChecked == false)
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            
            //Points de vérification à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6370); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
            
            Get_WinRebalance_BtnNext().Click(); //Etape2
            Get_WinRebalance_BtnNext().Click(); //Etape3
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            
            //Valider qu'il ya des ordres proposés pour le compte 800246-NA et on voit aussi SEG1
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","Id",10),"Value", cmpEqual, accountNo_6370);
            //Cliquer + pour voir le segment
            Get_WinRebalance().Find("Uid", "TabControl_1a23",10).Click(12,75);
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_navigatorExpander").WPFObject("_navigatorGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1)
            var count = grid.Items.Count;
            for (i=1;i<count;i++){
              if (grid.Items.Item(i).DataItem.Description == sleevedescription1_6370 )
                Log.Checkpoint("Le segment ("+sleevedescription1_6370+") existe dans liste à gauche");
              else if (grid.Items.Item(i).DataItem.Description == sleevedescription2_6370 )
                      Log.Checkpoint("Le segment ("+sleevedescription2_6370+") existe dans liste à gauche");
                  else
                      Log.Error ("Au moins un des deux segments ("+sleevedescription1_6370+") et ("+sleevedescription2_6370+") n'existe pas dans la liste à geuche");
            }
            
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
            Log.Message("------------ Supprimer les segments créés pour retourner à l'état initial --------------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Search_Account(accountNo_6370);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6370,10).Click();
            
            //Mailler vers portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer le bouton Segement
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            DeleteSleeveWinSleevesManager(sleevedescription1_6370);
            DeleteSleeveWinSleevesManager(sleevedescription2_6370);
            
            //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}
