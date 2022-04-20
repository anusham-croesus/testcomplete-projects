//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : (MOD-16, MOD-53, MOD-906, MOD-1186) CR1990 : Valider les spécifications de la colonne Solde (%)
                  dans le module Modèles et la fenêtre de rééquilibrage  
        
    https://jira.croesus.com/browse/MOD-1515
    Analyste d'assurance qualité : Christine Perreault
    Analyste d'automatisation : Abdel Matmat
    
    Version de scriptage:	90.15.2020.3-21
*/

function CR1990_MOD_1515_ValidateBalanceColumnInModelsAndRebalancingWindow()
{
    try {
            //Afficher le lien du cas de test
            Log.Link(" https://jira.croesus.com/browse/MOD-1515","Cas de test Xray : MOD-1515") 
                                      
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelNameCHBONDS        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "modelNameCHBONDS", language+client);
            var accountNumber800048NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "accountNumber800048NA", language+client);
            var clientNumber800049      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "clientNumber800049", language+client);
            var accountNumber800049NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "accountNumber800049NA", language+client);
            var accountNumber800049OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "accountNumber800049OB", language+client);
            var accountNumber800049RE   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "accountNumber800049RE", language+client);
            
            var balancePercentAccount800048NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentAccount800048NA", language+client);
            var balancePercentClient800049      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentClient800049", language+client);
            var balancePercentAccount800049NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentAccount800049NA", language+client);
            var balancePercentAccount800049OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentAccount800049OB", language+client);
            var balancePercentAccount800049RE   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentAccount800049RE", language+client);
            
            var balancePercentSummaryAccount800048NA  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentSummaryAccount800048NA", language+client);
            var balancePercentSummaryClient800049     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentSummaryClient800049", language+client);
            var balancePercentSummaryAccount800049NA  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentSummaryAccount800049NA", language+client);
            var balancePercentSummaryAccount800049OB  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentSummaryAccount800049OB", language+client);
            var balancePercentSummaryAccount800049RE  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1990", "balancePercentSummaryAccount800049RE", language+client);
            
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
                        
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
                     
            //Associer le compte au modèle 
            Log.Message("Associer le compte "+accountNumber800048NA+" au modèle "+modelNameCHBONDS); 
            AssociateAccountWithModel(modelNameCHBONDS,accountNumber800048NA);
            
            //Associer le client au modèle 
            Log.Message("Associer le client "+clientNumber800049+" au modèle "+modelNameCHBONDS); 
            AssociateClientWithModel(modelNameCHBONDS,clientNumber800049);
            
            //Aller dans l'onglet Portefeuilles associés
            Log.Message("Aller dans l'onglet Portefeuilles associés et vérifier les valeurs de la colonne Solde(%)");
            Get_Models_Details_TabAssignedPortfolios().Click();
            var grid = Get_Models_Details_DgvDetails();
            CheckPercentBalanceColumn(grid, accountNumber800048NA, clientNumber800049, balancePercentAccount800048NA, balancePercentClient800049);
               
            //Cliquer sur le (+) pour afficher les comptes du client et vérifier les valeurs de la colonne Solde(%)
            Log.Message("Cliquer sur le (+) pour afficher les comptes du client "+clientNumber800049+" et vérifier les valeurs de la colonne Solde(%)");
            Get_Models_Details_DgvDetails().WPFObject("DataRecordPresenter", "", 2).set_IsExpanded(true);
            var subGrid = Get_Models_Details_DgvDetails().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", "1", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", "1", true], 10);
            CheckPercentBalanceColumnInSubgrid(subGrid, accountNumber800049NA, accountNumber800049OB, accountNumber800049RE, balancePercentAccount800049NA, balancePercentAccount800049OB, balancePercentAccount800049RE);
            
            //Vérifier que la colonne Solde(%) est triable
            Log.Message("Vérifier que la colonne Solde(%) est triable");
            Get_Models_Details_TabAssignedPortfolios_ChPercentBalance().Click();
            ColumnBalancePercentAscendingSort(grid);
            
            
            
            //Activerle modèle si pasactif
            CheckModelActif(modelNameCHBONDS);
            //Rééquilibrer le modèle CH BONDS"
            Log.Message("Rééquilibrage du modèle "+modelNameCHBONDS);
            Get_ModelsGrid().Find("Value",modelNameCHBONDS,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //à l'étape 1 choisir Selon la valeur cible
            Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().set_IsChecked(true);
            //Décocher l'option Répartir la liquidité entre les comptes selon la tolérance du solde
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            //Décocher la case Valider les tolérances des titres.
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            //Décocher la case Appliquer les réserves de liquidités.
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            //Aller à l'étape 2
            Log.Message("Aller à l'étape 2 de rééquilibrage");
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_7456");
            
            //Vérifier la valeur de la colonne " Solde (%) / Balance (%) "dans la section Portefeuilles à rééquilibrer
            Log.Message("Vérifier la valeur de la colonne 'Solde (%) / Balance (%)'dans la section Portefeuilles à rééquilibrer");
            var gridStep2 = Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1);
            CheckPercentBalanceColumn(gridStep2, accountNumber800048NA, clientNumber800049, balancePercentAccount800048NA, balancePercentClient800049);
            
            //Vérifier que la colonne Solde(%) est triable
            Log.Message("Vérifier que la colonne Solde(%) dans la section Portefeuilles à rééquilibrer est triable");
            Get_Models_Details_TabAssignedPortfolios_ChPercentBalance().Click();
            ColumnBalancePercentAscendingSort(gridStep2);
            
            //Aller à la fenêtre Gestion de l'encaisse en cliquant sur le bouton dédié
            Log.Message("Aller à la fenêtre Gestion de l'encaisse en cliquant sur le bouton dédié");
            Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
            WaitObject(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");
            
            //Vérifier la valeur de la colonne " Solde (%) / Balance (%) "dans fenêtre Gestion de l'encaisse
            Log.Message("Vérifier la valeur de la colonne 'Solde (%) / Balance (%)'dans la fenêtre Gestion de l'encaisse");
            CheckPercentBalanceColumnInCashMngGrid(accountNumber800048NA, accountNumber800049NA, accountNumber800049OB, accountNumber800049RE, balancePercentAccount800048NA, balancePercentAccount800049NA, balancePercentAccount800049OB, balancePercentAccount800049RE);
            Get_WinCashManagement_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");
            
            //Aller à l'étape 4 de rééquilibrage
            Log.Message("------ Aller à l'étape 4 de rééquilibrage ---------------");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            //vérifier la colonne Solde (%) dans la section portefeuilles projetés
            Log.Message("------ vérifier la colonne Solde (%) dans la section portefeuilles projetés ---------------");
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");
            var gridProjectPort = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1);
            CheckPercentBalanceColumn(gridProjectPort, accountNumber800048NA, clientNumber800049, balancePercentAccount800048NA, balancePercentClient800049);
            
            Get_WinRebalance().FindChild("Uid", "DataGrid_d123", 10).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).set_IsExpanded(true);
            var subGridProjectPort = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1)
            CheckPercentBalanceColumnInSubgrid(subGridProjectPort, accountNumber800049NA, accountNumber800049OB, accountNumber800049RE, balancePercentAccount800049NA, balancePercentAccount800049OB, balancePercentAccount800049RE);
            
            //Vérifier que la colonne Solde(%) est triable
            Log.Message("Vérifier que la colonne Solde(%) dans la section Portefeuilles projetés");
            //Delay(5000)
            //Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChPercentBalance().Click()
            ColumnBalancePercentAscendingSort(gridProjectPort);
            
            //Aller dans l'onglet portefeuilles projetés et vérifier la valeur Solde (%) dans Sommaire
            Log.Message("------ Aller dans l'onglet portefeuilles projetés et vérifier la valeur Solde (%) dans Sommaire ---------------");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ScrollViewer_2e5e");
            
            //Scroll à gauche pour que les comptes soient visibles
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left][Left]");
            
            //Vérifier la valeur de 'Solde (%)' dans sommaire pour le client et tous les comptes
            CheckBalancePercentInProjectedPortfolioSummary(accountNumber800048NA, balancePercentSummaryAccount800048NA);
            CheckBalancePercentInProjectedPortfolioSummary(clientNumber800049, balancePercentSummaryClient800049);
            CheckBalancePercentInProjectedPortfolioSummary(accountNumber800049NA, balancePercentSummaryAccount800049NA);
            CheckBalancePercentInProjectedPortfolioSummary(accountNumber800049OB, balancePercentSummaryAccount800049OB);
            CheckBalancePercentInProjectedPortfolioSummary(accountNumber800049RE, balancePercentSummaryAccount800049RE);
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnContinue().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));  
    }   
    finally {
        //Clean-up
        Log.Message("--------------- C L E A N - U P -------------");
        RemoveAccountFromModel(accountNumber800048NA, modelNameCHBONDS);
		    RemoveClientFromModel(clientNumber800049, modelNameCHBONDS);   
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
    }
}


function CheckPercentBalanceColumn(grid, account, client, balancePercentAccount, balancePercentClient){
   count = grid.Items.Count
   for (i=0; i<count; i++){
     if (grid.Items.Item(i).DataItem.AccountNumber == account){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount, "Solde(%) du compte "+account)
     }
     if (grid.Items.Item(i).DataItem.ClientNumber == client){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentClient, "Solde(%) du client "+client)
     }   
   }
}

function CheckPercentBalanceColumnInSubgrid(grid, account1, account2, account3, balancePercentAccount1, balancePercentAccount2, balancePercentAccount3){
  count = grid.Items.Count;
  for (i=0; i<count; i++){
     if (grid.Items.Item(i).DataItem.AccountNumber == account1){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount1, "Solde(%) du compte "+account1)
     }
     if (grid.Items.Item(i).DataItem.AccountNumber == account2){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount2, "Solde(%) du compte "+account2)
     }
     if (grid.Items.Item(i).DataItem.AccountNumber == account3){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount3, "Solde(%) du compte "+account3)
     }
   }
}

function ColumnBalancePercentAscendingSort(grid){
    count = grid.Items.Count
   for (i=0; i<count-1; i++){
     balancePercent1 = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
     balancePercent2 = aqString.Format("%.2f",grid.Items.Item(i+1).DataItem.BalancePercent.OleValue)
     if (balancePercent1 < balancePercent2)
        Log.Checkpoint("La colonne 'Solde (%)' est triée");
     else 
        Log.Error("La colonne 'Solde (%)' n'est pas triée");
   }
}

function CheckPercentBalanceColumnInCashMngGrid(account1, account2, account3, account4, balancePercentAccount1, balancePercentAccount2, balancePercentAccount3, balancePercentAccount4){
  grid = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1);
  count = grid.Items.Count;
  for (i=0; i<count; i++){
     if (grid.Items.Item(i).DataItem.AccountNumber == account1){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount1, "Solde(%) du compte "+account1)
     }
     if (grid.Items.Item(i).DataItem.AccountNumber == account2){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount2, "Solde(%) du compte "+account2)
     }
     if (grid.Items.Item(i).DataItem.AccountNumber == account3){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount3, "Solde(%) du compte "+account3)
     }
     if (grid.Items.Item(i).DataItem.AccountNumber == account4){
        balancePercent = aqString.Format("%.2f",grid.Items.Item(i).DataItem.BalancePercent.OleValue)
        CheckEquals(balancePercent,balancePercentAccount4, "Solde(%) du compte "+account4)
     }
   }
}


function CheckBalancePercentInProjectedPortfolioSummary(accountNumber, balancePercentSummary){
    Log.Message("Vérifier la valeur de 'Solde (%)' du compte/client: "+accountNumber+" dans sommaire de l'onglet Portefeuille projeté");
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value", accountNumber, 10).Click();
    Get_WinRebalance().FindChild("Uid", "AssetMixView_ec57", 10).WaitProperty("IsLoaded", true, 5000); 
    CheckEquals(Get_WinRebalance_TabProposedOrders().FindChild("Uid","CFTextBlock_d425" , 10).Text,balancePercentSummary, "Sommaire Solde(%) du compte "+accountNumber)            
}


 
function CheckModelActif(modelName){
      Get_ModulesBar_BtnModels().Click();
      Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
      SearchModelByName(modelName);
      Get_ModelsGrid().Find("Value",modelName,10).DblClick();
      WaitObject(Get_CroesusApp(),"Uid","InfoModelWindow_b101");
      Get_WinModelInfo_GrpModel_ChkActive().set_IsChecked(true);
      Get_WinModelInfo_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoModelWindow_b101");
 }
