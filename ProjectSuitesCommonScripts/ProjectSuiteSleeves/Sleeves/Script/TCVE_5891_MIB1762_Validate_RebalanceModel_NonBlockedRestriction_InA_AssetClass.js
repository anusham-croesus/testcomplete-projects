//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction

 /*  Valider que le rééquilibrage d'un segment à partir du module Modèles pour un compte 
 ayant une restriction sur une classe d'actifs est complété sans message d'erreur
Analyste d'automatisation: Alassaned diallo*/


function TCVE_5891_MIB1762_Validate_RebalanceModel_NonBlockedRestriction_InA_AssetClass()
{
    try{      
        
         //Variables                      
         var userNameKEYNEJ      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var passwordKEYNEJ      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          
         var model_CH_MOYEN_TERME   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CH_MOYEN_TERME", language+client);
         var account800251GT        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ACCOUNT_800251GT", language+client);
         var titreM85805            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TITRE_M85805", language+client);
         var target                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TARGET_SLEEVES", language+client);
         var message1_MIB1762       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MESSAGE_1_MIB1762", language+client);
         var message2_MIB1762       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MESSAGE_2_MIB1762", language+client);
         var groupeClass            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "GROUPE_CLASSE", language+client);
         var categorie              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CATEGORIE", language+client);
 
         var percentageOfTotalValueMin_1   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MINIMUM_1_MIB1762", language+client);
         var percentageOfTotalValueMax_1   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MAXIMUM_1_MIB1762", language+client);
         var percentageOfTotalValueMin_2   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MINIMUM_2_MIB1762", language+client);
         var percentageOfTotalValueMax_2   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MAXIMUM_2_MIB1762", language+client);
        
         
                             
//Étape1
          //Se connecter à croesus avec Keynej
         Log.PopLogFolder();
         logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user KEYNEJ");
         Login(vServerSleeves, userNameKEYNEJ, passwordKEYNEJ, language);
 
         
                            
//Étape2         
         //Créer le modèle de firme CH Moyen terme si requis avec les titres suivants : Q49599 Cible(%) = 30 VM(%), M85805 Cible(%) = 30, Solde Cible(%) calculée = 40 VM(%)
         Log.PopLogFolder();
         logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle de firme CH Moyen terme si requis avec les titres suivants : Q49599 Cible(%) = 30 VM(%), M85805 Cible(%) = 30, Solde Cible(%) calculée = 40 VM(%) ");

         
                             
//Étape3         
         Log.PopLogFolder();
         logEtape3 = Log.AppendFolder("Étape 3: Acceder au module compte et  sélectionner le compte 800251-GT, puis lui ajuter une  restriction non bloquante");
            
         Log.Message("Accéder au module Compte ");         
         Get_ModulesBar_BtnAccounts().Click();
         Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
         SearchAccount(account800251GT) 
         Get_RelationshipsClientsAccountsGrid().FindChild("Text", account800251GT, 10).Click();
         
         
//         logEtape4 = Log.AppendFolder("sélectionner le compte 800251-GT, lui ajouter la restriction Non bloquante suivante :  Titre = M85805, Pourcentage de la valeur totale: Minimum = 25, Maximum = 35 "); 
         Get_RelationshipsAccountsBar_BtnRestrictions().Click();
         AddRestriction(titreM85805,percentageOfTotalValueMin_1,percentageOfTotalValueMax_1)
         
                             
//Étape4

         Log.PopLogFolder();
         logEtape4 = Log.AppendFolder("Étape 4:Sélectionner le compte 800251-GT, lui ajouter lune deuxieme restriction Non bloquante suivante :  Catégorie de firme -> Moyen terme, Pourcentage de la valeur totale: Minimum = 55, Maximum = 65 "); 
         Get_RelationshipsAccountsBar_BtnRestrictions().Click();
         AddRestrictionGprClasse(groupeClass, categorie, percentageOfTotalValueMin_2, percentageOfTotalValueMax_2)


//Étape5

         Log.PopLogFolder();
         logEtape5 = Log.AppendFolder("Étape 5: Mailler le compte 800251-GT vers le module Portefeuille puis lui Ajouter le segment Moyen terme, Classe d'Actifs = Moyen terme, Cible = 100 % Modele:CH MOYEN TERME "); 
         Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800251GT,10), Get_ModulesBar_BtnPortfolio());
         Get_PortfolioBar_BtnSleeves().Click();
         Add_Sleeve(categorie,categorie,target,model_CH_MOYEN_TERME)
       
//Étape6

         Log.PopLogFolder();
         logEtape6 = Log.AppendFolder("Étape 6 : Sélectionner le modèle CH MOYEN TERME, Portefeuilles associés, sélectionner le segment Moyen terme du compte 800251-GT puis  Cliquer sur Rééquilibrer "); 
   
         Get_ModulesBar_BtnModels().Click();
         Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
         SearchModelByName(model_CH_MOYEN_TERME);
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         Get_Toolbar_BtnRebalance().Click()
         Get_WinRebalance().Parent.Maximize();
         
//Étape7

         Log.PopLogFolder();
         logEtape7 = Log.AppendFolder("Étape 7 :À l'étape 1 , décocher les cases des paramètres disponibles, puis étape 4 Dans l'onglet Ordres proposés, vérifier les messages affichés. "); 
   
                        
         // Decocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
         Log.Message("Décocher les cases valider les limites Appliquer les frais et Répartir la liquidité.");
         Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
         Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
         Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);  
         
         // Poursuivre le rééquilibrage jusqu'à l'étape 4, dans l'onglet Ordres proposés, vérifier les messages affichés..
         Log.Message(" Poursuivre le rééquilibrage jusqu'à l'étape 4, dans l'onglet Ordres proposés, vérifier les messages affichés.."); 
         Get_WinRebalance_BtnNext().Click(); 
         Get_WinRebalance_BtnNext().Click(); 
         Get_WinRebalance_BtnNext().Click();
         if(Get_WinWarningDeleteGeneratedOrders().Exists){
            Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
         }  
         WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
          
         //Selectionner le compte 800251-GT
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account800251GT,10).Click();
        
    
         var grid = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_DgvRestriction().WPFObject("RecordListControl", "", 1)  
         aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"Description",cmpEqual,message1_MIB1762)
         aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"Description",cmpEqual,message2_MIB1762)
         
         //Fermer la fenetre de rééquilibrage
         Log.Message("Fermer la fenetre de rééquilibrage")
         Get_WinRebalance_BtnClose().Click();       
         Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
         
            
        
                           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
    }
    finally {   
      Log.PopLogFolder();
      logEtape8 = Log.AppendFolder("Étape 8 : Restore data ");        
      DeleteRestriction();
      Get_ModulesBar_BtnPortfolio().Click();
      Delete_AllSleeves_WinSleevesManager();
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}


function Add_Sleeve(assetClass,description,target,ModelName){
        //Ajouter un segment
        Log.Message("----------------- Ajout de segment "+description+" ----------------");
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text( description);
        Get_WinEditSleeve_CmbAssetClass().Keys(assetClass)
        Get_WinEditSleeve_TxtTargerPercent().set_Text(target)
        Get_WinEditSleeve_TxtValueTextBox().set_Text(ModelName);
        Get_WinEditSleeve_TxtValueTextBox().Keys("[Tab]");
        Get_WinEditSleeve_BtOK().Click();
        Get_WinManagerSleeves_BtnSave().Click();
}

//++++++++++++++++++++++++++++++++++ RESTRICTION ++++++++++++++++++++++++++++++++++++++
function AddRestriction(security,percentageOfTotalValueMin,percentageOfTotalValueMax){
    //ajouter une restriction                    
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    var count = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]"); 
    Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum().Keys(percentageOfTotalValueMin);
    Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum().Keys(percentageOfTotalValueMax);
    Get_WinCRURestriction_BtnOK().Click();
    Get_WinRestrictionsManager_BtnClose().Click();
    
}


function AddRestrictionGprClasse(grpClasse, categorie,percentageOfTotalValueMin_2, percentageOfTotalValueMax_2){
    
         Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
         Get_WinCRURestriction_GrpGroupClass_RdoGroupClass().Click();
         Get_WinCRURestriction_GrpGroupClass_BtnClass_LblClass().Click();
         Get_SubMenus().FindChild("Text", grpClasse,100).Click();
         Get_SubMenus().FindChild("Text", categorie ,1000).Click();
         Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMinimum().Keys(percentageOfTotalValueMin_2);
         Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMaximum().Keys(percentageOfTotalValueMax_2);
         Get_WinCRURestriction_BtnOK().Click(); 
         Get_WinRestrictionsManager_BtnClose().Click();
}


function DeleteRestriction(){
        
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      Get_RelationshipsAccountsBar_BtnRestrictions().Click();
      Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Keys("^a"); 
      Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
      Get_DlgConfirmation_BtnYes().click();
      Get_WinRestrictionsManager_BtnClose().Click();


}
