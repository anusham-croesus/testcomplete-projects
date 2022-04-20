//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description :Valider le rééquilibrage d’un compte UMA (devise USD) avec transferts de liquidités 
    et modification du taux de change à l’étape 1	
    
    https://jira.croesus.com/browse/TCVE-2991
    https://jira.croesus.com/browse/MIB-494
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.20.2020.10-11
*/

function TCVE_2991_MID_19_Validate_RebalancingUMAAccount_With_LiquidityTransfers_And_ModificationTheExchangeRate_InStep1()
{
    try {
            
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8;
            
            
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-2991") 
            Log.Link("https://jira.croesus.com/browse/MIB-494")
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10; 
                  
            var userNameKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            var account800236OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800236OB", language+client);
            var mod_MID_19        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MID19_SUBMODEL", language+client);
            var seg_Adhoc         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SEG_ADHOC", language+client);
            var seg_Unallocated   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SEG_UNALLOCATED", language+client);
            var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
            var securityAAPL      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityAAPL", language+client);
            var securityBCE       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityBCE", language+client);
            var securityBAM_A     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityBAM_A", language+client);
            var securityKO        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityKO", language+client);
            var solde             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SOLDE_MID19", language+client);
             
            var targetAAPL        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetAAPL_MID19", language+client);
            var targetBCE         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetBCE_MID19", language+client);
            var targetBAM_A       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetBAM_A_MID19", language+client);
            var targetKO          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetKO_MID19", language+client);
            var target_Adhoc      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "target_Adhoc", language+client);
            var exchangeRate      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "EXCHANGE_RATE", language+client);
           
            var quantityAAPL      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_AAPL", language+client);
            var quantityBCE       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_BCE", language+client);
            var quantityBAM_A     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_BAM_A", language+client);
            var quantityKO        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_KO", language+client);
            
            var marketValueSOLDE  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MARKET_VALUE_SOLDE", language+client);
            var marketValueAAPL   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MARKET_VALUE_AAPL", language+client);
            var marketValueBCE    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MARKET_VALUE_BCE", language+client);
            var marketValueBAM_A  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MARKET_VALUE_BAM_A", language+client);
            var marketValueKO     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MARKET_VALUE_KO", language+client);
            
            var vmPERCENT_SOLDE   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_PERCENT_SOLDE", language+client);
            var vmPERCENT_AAPL    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_PERCENT_AAPL", language+client);
            var vmPERCENT_BCE     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_PERCENT_BCE", language+client);
            var vmPERCENT_BAM_A   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_PERCENT_BAM_A", language+client);
            var vmPERCENT_KO      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_PERCENT_KO", language+client);
           
            
            var quantityUNALLOCATED   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_NON_ATRIBUE", language+client);
            var quantityADHOC         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QUANTITY_ADHOC", language+client);
             
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle de firme M571-SUBMODEL. et ajouter au modele les positions suivantes: AAPL, BCE, BAM.A, KO");      
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_M1423 
            Log.Message("Créer le modèle mod_M571_subModel "); 
            Create_Model(mod_MID_19,modelType)
            
            
            //Ajouter des position dans le Modèle mod_M1423
            Log.Message("Ajouter la position NA au Modèle mod_M571_subModel"); 
            SearchModelByName(mod_MID_19);
            Drag( Get_ModelsGrid().Find("Value",mod_MID_19,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/2.9)),73);
            
            //Ajouter de la  position APPLE
            AddPositionToModel(securityAAPL,targetAAPL,typePicker,"");

            //Ajouter de la  position BCE
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityBCE,targetBCE,typePicker,"");
            
            //Ajouter de la  position BAM_A
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityBAM_A,targetBAM_A,typePicker,"");
            
            //Ajouter de la  position KO
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityKO,targetKO,typePicker,"");
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Mailler le compte 800236-OB vers le module Portefeuille et lui Ajouter le segment Adhoc avec Cible = 100 % et lui associer le modèle MIB-19-USD."); 
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            
            Search_Account(account800236OB);
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800236OB,10), Get_ModulesBar_BtnPortfolio());
            
            //Cliquer le bouton Segement
            Log.Message(" Cliquer le bouton segment ");
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd"); 
            Get_WinManagerSleeves().Parent.Maximize();
        
            //**Ajouter lesegment Adhoc
            Log.Message("Ajout du segment Croissance avec une cible de 60% et lui associer le modèle M2296-CROIS");
            Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
            AddEditSleeveWinSleevesManager(seg_Adhoc,"",target_Adhoc,"","",mod_MID_19)
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
            
            //Sauvegarder le segment créé
            Get_WinManagerSleeves_BtnSave().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
             

//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4:Rééquilibrer le compte puis À l'étape 1, modifier le taux de change = 1.15 et Poursuivre le rééquilibrage jusqu'à l'étape 4.");
             
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            Get_WinRebalance().Parent.Maximize();
            
            
            //Modifier le taux de change = 1.15
            Log.Message("Modifier le taux de change = 1.15");
            Get_WinRebalance_TabParameters_TxtExchangeRate().Click();
            Get_WinRebalance_TabParameters_TxtExchangeRate().Keys(exchangeRate);
            
            //Continuer le Rééquilibrage et aller l'étape 4
            Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42")
            
            
            
//Étape5   
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5:Vérifier les informations dans l'onglet Ordres proposés : Section Ordres proposés.");         
         
            WaitObject(Get_CroesusApp(), "Uid", "ToggleButton_c0e5");
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().WaitProperty("IsChecked", false, 30000);
            
                    var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
                    var count = grid.Items.Count;
              
                         for (i=0; i<count; i++){
                             
                             if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SecuritySymbol== securityAAPL)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityAAPL)
                                }     
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SecuritySymbol== securityBCE)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityBCE)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SecuritySymbol== securityBAM_A)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityBAM_A)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SecuritySymbol== securityKO)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityKO)
                                }                      
                           }
                           
                
               
//Étape6  
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6:Vérifier les informations dans l'onglet Mouvement des liquidités."); 
            
            Get_WinRebalance_TabProjectedPortfolios_TabCashMovements().Click(); 
           
                  var grid = Get_WinRebalance_TabProjectedPortfolios_TabCashMovements_DgvCashMovements().WPFObject("RecordListControl", "", 1);
                  var count = grid.Items.Count;
              
                         for (i=0; i<count; i++){
                             
                             if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SleeveName== seg_Unallocated)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityUNALLOCATED)
                                }     
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.SleeveName== seg_Adhoc)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityADHOC)
                                }                 
                           }       
//Étape7  
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7:Vérifier les informations dans l'onglet Portefeuile projeté0.");         
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            
              
                         
              var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1);
              var count = grid.Items.Count;
             
                         for (i=0; i<count; i++){
                             
                                if (grid.Items.Item(i).DataItem.Symbol== solde)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueSOLDE)
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmPERCENT_SOLDE)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.Symbol== securityAAPL)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueAAPL)
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmPERCENT_AAPL)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.Symbol== securityBCE)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueBCE)
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmPERCENT_BCE)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.Symbol== securityBAM_A)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueBAM_A)
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmPERCENT_BAM_A)
                                }  
                                if (grid.Items.Item(i).DataItem.AccountNumber == account800236OB && grid.Items.Item(i).DataItem.Symbol== securityKO)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueKO)
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmPERCENT_KO)
                                }                            
                           }
                           
                           //Fermer la fenetre de reequilibrage
                           Get_WinRebalance_BtnClose().Click(); 
                           var width = Get_DlgConfirmation().Get_Width();
                           Get_DlgConfirmation().Click((width*(1/2.9)),73)              
            
 }
    catch(e) {
	    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            //Restore data
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8:Restore data");             
	        Delete_AllSleeves_WinSleevesManager();
            DeleteModelByName(mod_MID_19)
            
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}


function Get_WinRebalance_TabParameters_TxtExchangeRate(){return Get_WinRebalance().FindChild("Uid", "TabControl_1a23", 10).FindChild("Uid", "DoubleTextBox_0b3f", 10)}
