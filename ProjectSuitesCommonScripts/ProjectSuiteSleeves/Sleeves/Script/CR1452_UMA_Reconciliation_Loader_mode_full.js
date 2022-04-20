//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1452_282_CashManagement

/**
    Tâche                :  TCVE-3559; TCVE-3467
    Lien                 : https://jira.croesus.com/browse/TCVE-3467 
    Préconditions        :    
    Auteur               : Youlia
    Version de scriptage :ref90-19-2020-09-45--V9-croesus-co7x-2_1_758 BD de TD dump -->BDQA_90.19.2020.09-45_2020-10-29_Sleeve_Ref2_AutoCM_Gab_Multi
*/

function CR1452_UMA_Reconciliation_Loader_mode_full(){
  
      var logEtape1, logEtape2, logEtape3,logRetourEtatInitial;
      try {
              
			  //Lien de la story dans Jira
              Log.Link("https://jira.croesus.com/browse/TCVE-3559", "Lien vers la story");
              Log.Link("https://jira.croesus.com/browse/TCVE-3467", "Lien vers le cas de test");
                     
              var userNameKEYNEJ                  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
              var userPswKEYNEJ                   = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
              var modelAmericanEqui               = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client);
              var criterionAccMAJ                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "criterionAccMAJ", language+client);
              var criterionAllSleeves             = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "criterionAllSleeves", language+client);
              var cmbSourcesString                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cmbSourcesString", language+client);
              var account151037NA                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account151037NA", language+client);
              var cashMgmt151037NA                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmt151037NA", language+client);;
              var account141037NA                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account141037NA", language+client);
              var cashMgmt141037NA                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmt141037NA", language+client);
              
              var account121037RE                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account121037RE", language+client);
              var slDescGrowthSecurities121037RE  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescGrowthSecurities121037RE", language+client);
              var slDescFixedIncomeSecurities121037RE = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescFixedIncomeSecurities121037RE", language+client);
              var slDescOthers121037RE            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescOthers121037RE", language+client);
              var slDescLiquidites121037RE        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescLiquidites121037RE", language+client);
              var cashMgmtGrowthSecurities121037R = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtGrowthSecurities121037R", language+client);
              var cashMgmtFixedIncomeSecurities121037RE = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtFixedIncomeSecurities121037RE", language+client);
              var cashMgmtOthers121037RE          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtOthers121037RE", language+client);
              var cashMgmtLiquidites121037RE      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtLiquidites121037RE", language+client);
              
              var account800252RE                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account800252RE", language+client);
              var slDescAction800252RE            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescAction800252RE", language+client);
              var cashMgmtAction800252RE          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtAction800252RE", language+client);
              var slDescObligation800252RE        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescObligation800252RE", language+client);
              var cashMgmtObligation800252RE      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtObligation800252RE", language+client);
              var slDescS1800252RE                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescS1800252RE", language+client);
              var cashMgmtS1800252RE              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtS1800252RE", language+client);
              var slDescS2800252RE                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescS2800252RE", language+client);
              var cashMgmtS2800252RE              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtS2800252RE", language+client);
              
              var account161037RE                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account161037RE", language+client);
              var slDescLiquidites161037RE        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescLiquidites161037RE", language+client);
              var cashMgmtLiquidites161037RE      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtLiquidites161037RE", language+client);
              var slDescAutres161037RE            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescAutres161037RE", language+client);
              var cashMgmtAutres161037RE          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmtAutres161037RE", language+client);
              
              var account800063OB                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account800063OB", language+client);
              var cashMgmt800063OB                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "cashMgmt800063OB", language+client);
              var slDescS1800063OB                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "slDescS1800063OB", language+client);
              
              var account800021Na                 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "account800021Na", language+client);
              var sleeveDes800021NA               = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "sleeveDes800021NA", language+client);
              var S1Target                        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "S1Target", language+client); 
              
              
              //********************************************************** L'étape 2**********************************************************
              Log.PopLogFolder();
              logEtape2 = Log.AppendFolder("L'étape 2 de cas de test TCVE-3467: Appliquer et rééquilibrer le critère 'Rééquilibrer le compte'");
              Log.Message("Se connecter dans Croesus avec Keynej");
              Login(vServerSleeves, userNameKEYNEJ, userPswKEYNEJ, language);
              
              Log.message("Aller au module Comptes")
              Get_ModulesBar_BtnAccounts().Click();
              Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
              
              Log.Message("sélectionner le critère 'Rééquilibrer le compte' et charger");
              Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
              Get_Toolbar_BtnManageSearchCriteria().Click(); 
              Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
              Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterionAccMAJ,100).Click();
              Get_WinSearchCriteriaManager_BtnLoad().Click();
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(), "VisibleOnScreen", cmpEqual, true);
              
              Log.Message("Rééquilibrer les comptes en sélectionnant la liste crochet");
              Get_Toolbar_BtnRebalance().Click();     
              SelectComboBoxItem(Get_WinRebalancingMethod_GrpParameters_CmbSources(), cmbSourcesString)                       
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true);
              Get_WinRebalancingMethod_BtnOK().Click();
              
              Get_WinRebalance().Parent.Maximize();
              Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 2
                                    
              Log.Message(" Dans l'étape 2, cliquer sur Gestion d'encaisse: ajouter du cash management pour les comptes 141037-NA = 10000 et 151037-NA = -40000");
              Log.Message("ajouter du cash management pour les comptes 141037-NA = 10000 et 151037-NA = -40000");
              Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
              Get_WinCashManagement().Parent.Maximize();
              ChangeCashMgmt(account141037NA,cashMgmt141037NA);
              ChangeCashMgmt(account151037NA,cashMgmt151037NA); 
                           
              Get_WinCashManagement_BtnOk().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CashAmountOverrideWindow", 30000);              
               
              Log.Message("Ensuite avancer jusqu'à la dernière étape et générer les ordres");
              GoToStep4();
              
              //CheckGenerated_Flag()
                
              //********************************************************** L'étape 3 **********************************************************   
              Log.PopLogFolder();
              logEtape3 = Log.AppendFolder("L'étape 3 de cas de test TCVE-3467: Appliquer et rééquilibrer le critère 'Rééquilibrer tous les segments'");
              Log.Message("Retourner au module Comptes '");
              Get_ModulesBar_BtnAccounts().Click();
              Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                         
              Log.Message("charger le critère 'Rééquilibrer tous les segments");
              Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
              Get_Toolbar_BtnManageSearchCriteria().Click(); 
              Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
              Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterionAllSleeves,100).Click();
              Get_WinSearchCriteriaManager_BtnLoad().Click();
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(), "VisibleOnScreen", cmpEqual, true);
              
              Log.Message("Cliquer sur le bouton 'Rééquilibrer' et sélectionner Liste actuelle avec crochets. Rééquilibrer tous les segments:");
              Get_Toolbar_BtnRebalance().Click();     
              SelectComboBoxItem(Get_WinRebalancingMethod_GrpParameters_CmbSources(), cmbSourcesString)                       
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true);
              Get_WinRebalancingMethod_BtnOK().Click();
              
              Get_WinRebalance().Parent.Maximize();
              Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 2

              Log.Message("ajouter du cash management pour les comptes 121037-RE, 800252-RE et 161037-RE selon les données.");
              Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
              Get_WinCashManagement().Parent.Maximize();
             
              Log.message("Compte 121037-RE:Liquidités = -5000; Titres à revenus fixes = 1000;Titres de croissance = 1000;Autres = 2000;");
              ChangeCashMgmtBySleeveDesc(account121037RE,slDescGrowthSecurities121037RE, cashMgmtGrowthSecurities121037R);
              ChangeCashMgmtBySleeveDesc(account121037RE,slDescFixedIncomeSecurities121037RE, cashMgmtFixedIncomeSecurities121037RE);
              ChangeCashMgmtBySleeveDesc(account121037RE,slDescOthers121037RE, cashMgmtOthers121037RE);
              ChangeCashMgmtBySleeveDesc(account121037RE,slDescLiquidites121037RE, cashMgmtLiquidites121037RE);
              
              Log.message("Compte 800252-RE:Action = 10000;Obligation = 5000;S1 = -500; S2 = 1000");
              ChangeCashMgmtBySleeveDesc(account800252RE,slDescAction800252RE, cashMgmtAction800252RE);
              ChangeCashMgmtBySleeveDesc(account800252RE,slDescObligation800252RE, cashMgmtObligation800252RE);
              ChangeCashMgmtBySleeveDesc(account800252RE,slDescS1800252RE, cashMgmtS1800252RE);
              ChangeCashMgmtBySleeveDesc(account800252RE,slDescS2800252RE, cashMgmtS2800252RE);
                      
              Log.message("Compte 161037-RE: Liquidités = 10000; Autres = 10000");
              ChangeCashMgmtBySleeveDesc(account161037RE,slDescLiquidites161037RE, cashMgmtLiquidites161037RE);
              ChangeCashMgmtBySleeveDesc(account161037RE,slDescAutres161037RE, cashMgmtAutres161037RE);
                           
              Get_WinCashManagement_BtnOk().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CashAmountOverrideWindow", 30000); 
              
              Log.Message("Ensuite avancer jusqu'à la dernière étape et générer les ordres");
              GoToStep4();
             
              //CheckGenerated_Flag()
                
              //********************************************************** L'étape 4 ********************************************************** 
              Log.PopLogFolder(); 
              logEtape4 = Log.AppendFolder("L'étape 4 de cas de test TCVE-3467: Rééquilibrer le segment du compte '800063-OB'");
              Log.Message("Aller au module Modèles");
              Get_ModulesBar_BtnModels().Click();
              Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
              
              Log.Message("Sélectionner le modèle 'CH American Equities'");
              SearchModelByName(modelAmericanEqui);
              Get_ModelsGrid().Find("Value",modelAmericanEqui,10).Click();
                          
              Log.Message("sélectionner le segment du compte '800063-OB' ensuite cliquer sur Rééquilibrer");
              Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account800063OB,10).Click();
              Get_Toolbar_BtnRebalance().Click(); 
               
              Log.Message("Ajouter du Cash management = 10000");
              Get_WinRebalance().Parent.Maximize();
              Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 2
              Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
              Get_WinCashManagement().Parent.Maximize();
              ChangeCashMgmtBySleeveDescModele(account800063OB,slDescS1800063OB,cashMgmt800063OB);
              
              Get_WinCashManagement_BtnOk().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CashAmountOverrideWindow", 30000);
                            
              Log.Message(" Avancer jusqu'à la dernière étape et générer les ordres");
              GoToStep4forModel();
              Terminate_CroesusProcess(); //Fermer Croesus
              //CheckGenerated_Flag()
                                            
              //********************************************************** L'étape 5 ********************************************************** 
              Log.PopLogFolder();
              logEtape5 = Log.AppendFolder("L'étape 5 de cas de test TCVE-3467: Mettre à jour la date_crea dans B_Or_Ou et B_Rebalance et comparer les colonnes colonnes Quantity, Expected_Qty  25 jan");              
              var queryString25  = "update b_or_ou set DATE_CREA = 'JAN 25 2010 12:00AM'"                           
              Log.Message("mettre à jour la date_crea dans B_Or_Ou et B_Rebalance : " +queryString25);
              Execute_SQLQuery(queryString25, vServerSleeves);

              var queryStringReb25  ="update b_rebalance set DATE_REBALANCE = 'JAN 25 2010 12:00AM'";               
              Log.Message("mettre à jour la date_crea dans B_Or_Ou et B_Rebalance : " +queryStringReb25);
              Execute_SQLQuery(queryStringReb25, vServerSleeves);

              //********************************************************** L'étape 6 **********************************************************              
              Log.PopLogFolder();
              logEtape6 = Log.AppendFolder("L'étape 6 de cas de test TCVE-3467: Comparer les colonnes Quantity, Expected_Qty 'ReeqSleeve' 25 jan");
              Log.Message("Validation des colonnes dans les tables:B_OR_OU : Quantity, Expected_Qty");
              
              Log.Message("Validation des colonnes dans les tables:B_OR_OU : Quantity, Expected_Qty");
              ValidateColumnBD("QUANTITE",vServerSleeves,"QUANTITE_25janv");
              ValidateColumnBD("EXPECTED_QTY",vServerSleeves,"EXPECTED_QTY_25janv");

              //********************************************************** L'étape 7 **********************************************************               
              Log.PopLogFolder();
              logEtape7 = Log.AppendFolder("L'étape 7 de cas de test TCVE-3467: Avancer le loader  au 26 ");
              MovingForwardLoader("26");
              
              //********************************************************** L'étape 8  **********************************************************
              Log.PopLogFolder();
              logEtape8 = Log.AppendFolder("L'étape 8 de cas de test TCVE-3467:  Modifier la cible du segment Sleeve à 50% pour le compte '800021-Na'.Comparer les colonnes Quantity, Expected_Qty  26 jan");                          
              Log.Message("Se connecter dans Croesus avec Keynej");
              Login(vServerSleeves, userNameKEYNEJ, userPswKEYNEJ, language);
              
              Log.message("Aller au module Comptes")
              Get_ModulesBar_BtnAccounts().Click();
              Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
              
              Log.Message("Sélectionner le compte '800021-Na', modifier la cible du segment Sleeve à 50% et sauvegarder");
              SearchAccount(account800021Na);
              Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800021Na,1000), Get_ModulesBar_BtnPortfolio());
              Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
              
              Get_PortfolioBar_BtnSleeves().Click();
              Get_WinManagerSleeves().Parent.Maximize(); 
              //Modifier le segment 
              SelectSleeveWinSleevesManager(sleeveDes800021NA);
              Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
              AddEditSleeveWinSleevesManager("","",S1Target,"","","")                  
              Get_WinManagerSleeves_BtnSave().Click(); 
              WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "SLEEVESMANAGER", 30000); 
              
              Log.Message("Rééquilibrer le compte en date du 26 janv. et générer les ordres");
              Get_Toolbar_BtnRebalance().Click(); 
              Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true);
              Get_WinRebalancingMethod_BtnOK().Click();              
              Get_WinRebalance().Parent.Maximize();
              Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 2
              GoToStep4();
              Terminate_CroesusProcess(); //Fermer Croesus

              //SQL Execution 
              var todayDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d")
              Log.Message("update b_or_ouset DATE_CREA = 'JAN 26 2010 12:00AM' where DATE_CREA = '"+todayDate+"'");
              Log.Message("update b_rebalance set DATE_REBALANCE = 'JAN 26 2010 12:00AM' where DATE_REBALANCE = '"+todayDate+"'");
              
              var queryString26  = "update b_or_ou set DATE_CREA = 'JAN 26 2010 12:00AM' where DATE_CREA = '"+todayDate+" 00:00:00'"                                       
              Log.Message("mettre à jour la date_crea dans B_Or_Ou et B_Rebalance : " +queryString26);
              Execute_SQLQuery(queryString26, vServerSleeves);
              
              var queryStringReb26  ="update b_rebalance set DATE_REBALANCE = 'JAN 26 2010 12:00AM' where DATE_REBALANCE = '"+todayDate+" 00:00:00'";  
              Log.Message("mettre à jour la date_crea dans B_Or_Ou et B_Rebalance : " +queryStringReb26);
              Execute_SQLQuery(queryStringReb26, vServerSleeves);
                                       
              Log.Message("Validation des colonnes dans les tables:B_OR_OU : Quantity, Expected_Qty");
              ValidateColumnBD("QUANTITE",vServerSleeves,"QUANTITE_26janv");
              ValidateColumnBD("EXPECTED_QTY",vServerSleeves,"EXPECTED_QTY_26janv");
              
              //********************************************************** L'étape 10 **********************************************************
              Log.PopLogFolder();
              logEtape10 = Log.AppendFolder("L'étape 10 de cas de test TCVE-3467: Avancer le loader au 27 et comparer les colonnes Quantity, Expected_Qty 'ReeqSleeve' 27 jan");
              MovingForwardLoader("27");
              ValidateColumnBD("QUANTITE",vServerSleeves,"QUANTITE_27janv");
              ValidateColumnBD("EXPECTED_QTY",vServerSleeves,"EXPECTED_QTY_27janv");


              //********************************************************** L'étape 11 **********************************************************              
              Log.PopLogFolder();
              logEtape11 = Log.AppendFolder("L'étape 11 de cas de test TCVE-3467: Avancer le loader au 28 et comparer les colonnes Quantity, Expected_Qty 'ReeqSleeve' 28 jan");
              MovingForwardLoader("28");
              ValidateColumnBD("QUANTITE",vServerSleeves,"QUANTITE_28janv");
              ValidateColumnBD("EXPECTED_QTY",vServerSleeves,"EXPECTED_QTY_28janv");
              
             
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));

      }
      finally {
            Log.PopLogFolder();            
            Runner.Stop(true);   
        }
}

//Avancer le loader
function MovingForwardLoader(date){
  Log.Message("avancer le loader au "+date+" janv selon la procédure"); 
  if (TryConnexionAndTrustHostKeyThroughWinSCP(vServerSleeves)){ //TryConnexionAndTrustHostKeyThroughPLINK(vServerSleeves);
     DeleteDir();
     Delay(30000);
     CopyFilesToVserver(date);
     Delay(30000);
     SSHExecute("CR1452UMAReconciliation")
  }else{
      Log.Error("L'exécution a été arrêtée parce que la connexion au vserver  n'a pas été établie.");
      Runner.Stop(false);//Specifies whether the method stops execution of the current test only or the whole test run.
  };
                           
}


function ChangeCashMgmtBySleeveDescModele(account,sleeveDesc, cashMgmt)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumberForDisplay)==VarToString(account) && VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SleeveName)==VarToString(sleeveDesc)){
         position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
         found=true;
         // Modification le 18/02/2020 suite au CR1990 la position de Gestion d'encaisse est devenu 5 au lieu de 4
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    } 
    
}

//Mettre les fichiers  suivants: Firm1bkv_26jan, pro_26jan, Transactions_26janv_Ref2_AutoCM_Gab et Firm2 : les fichiers suivants: bkv_26jan, pro_26jan, tra_VIDE_26jan dans  home/christine/TestsCR1452/TestsenmodefullMulti/
function CopyFilesToVserver(date){
    var remoteDestinationFolder="/home/christine/TestsCR1452/TestsenmodefullMulti/";       
    var localFolderPath=folderPath_Data+"TD\\CR1452\\LOADER\\"+date+"janv\\"
          
    var listOfFiles  = "sec_"+date+"jan.xml|Firm1|Firm2";
    Log.Message(listOfFiles);
    var arrayOfFiles  = listOfFiles.split("|");
      
    Log.Message("Copy the files");
    TryConnexionAndTrustHostKeyThroughWinSCP(vServerSleeves);
          
    for (i in arrayOfFiles)
        CopyFileToVserverThroughWinSCP(vServerSleeves, remoteDestinationFolder, localFolderPath + arrayOfFiles[i]);
}


//s'assurer de supprimer tous les autres fichiers de logs ou sec existants
function DeleteDir(){
    ExecuteWinSCPCommand(vServerSleeves, '"rmdir /home/christine/TestsCR1452/TestsenmodefullMulti"', null, false);
}

//Validation de la colonne 'Generated_Flag' qui devrait être = Y pour tous les ordres générés dans la table B_OR_OU
function ValidateColumnGenerated_Flag(){
  var differentValues=false; 
  var bdValues = new Array();    
  var bdValues = Execute_SQLQuery_GetFieldAllValues("select Generated_Flag from b_or_ou", vServerOrders, "Generated_Flag");
  for (i = 0; i < bdValues.length; i++) {
    if (aqObject.CompareProperty(VarToString(bdValues[i]),cmpEqual,"Y",true,lmError)){
        Log.Checkpoint("BD value "+bdValues[i]+" equal to Y ");
      }else{
        differentValues=true 
        Log.Message("BD value "+bdValues[i]+" doesn't equal to Y" );
      };
    }
    return differentValues;
}

//Validation de la colonne 'Generated_Flag'
function CheckGenerated_Flag(){
  Log.Message("Dans la table B_OR_OU la colonne 'Generated_Flag' devrait être = Y pour tous les ordres générés select * from b_or_ou");
  if(!ValidateColumnGenerated_Flag())
    Log.Checkpoint("Tous les ordres générés = Y");
  else
    Log.Error("pas tous les ordres générés = Y");               
}

//Validation de collones 'quantité' et 'Expected Qty' qui devraient être égales pour les même comptes sleeves et mêmes titres (colonne Security)
function ValidateColumnBD(fieldName,vserver,fieldDate){
  
    var differentValues=0; 
    Log.Message("select " + fieldName + " from b_or_ou order by NO_COMPTE,SECURITY");
    Log.Message("Get all the values of " + fieldName + " colomn from bd")
    
    var bdValues = new Array();    
    var bdValues = Execute_SQLQuery_GetFieldAllValues("select " + fieldName + " from b_or_ou order by NO_COMPTE,SECURITY", vServerOrders, fieldName);
    var excelValues = new Array();
    var excelValues =ReadDataFromExcelByColumnID(filePath_Sleeves, "ReconciliationUMA",fieldDate);
    
    Log.Message("There are " + bdValues.length+ " lines in bd");
    Log.Message("There are " + bdValues.length+ " lines in Excel");
    for (i = 0; i < bdValues.length; i++) {
    if (aqObject.CompareProperty(VarToString(bdValues[i]),cmpEqual,VarToString(excelValues[i]),true,lmError)){
        Log.Checkpoint("BD value "+bdValues[i]+" equal to reference value "+excelValues[i]);
      }else{
        differentValues ++ 
        Log.Message("BD value "+bdValues[i]+" doesn't equal to reference value "+excelValues[i]+ ". Tn the line number "+ i +" of Excel file." );
      };
    }
    return differentValues;
}


function ReadDataFromExcelByColumnID(filePath, sheetName,columnID)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
	  var arrayOfValues = new Array();
    
    //Parcourir les lignes pour récupérer le contenu de la cellule cible
    var isRowFound = false;
    while (! Driver.EOF()) {
		arrayOfValues.push(VarToStr(Driver.Value(columnID)));        
        Driver.Next();
    }
        
    // Fermer the driver
    DDT.CloseDriver(Driver.Name);
    
    return arrayOfValues;
}

function GoToStep4(){  //Rééquilibrage
      Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 3
      WaitUntilObjectDisappears(Get_CroesusApp(), ["WindowMetricTag","ProgressWindowMetricTag"], ["PROGRESSWINDOW","PROGRESSWINDOW_RESYNCRONIZEPARAMETER"], 100000);
      WaitObject(Get_CroesusApp(), "Uid", "TabControl_1a23",40000); 
      Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 4
      Delay(5000);
      //WaitObject(Get_CroesusApp(), "Uid", "TabControl_1a23",40000);
      Get_WinRebalance_BtnGenerate().WaitProperty("IsEnabled", true, 15000);
      Get_WinRebalance_BtnGenerate().Click();
      WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad",40000);
      Get_WinGenerateOrders_BtnGenerate().Click();
      Get_DlgConfirmation_BtnCancel().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad", 100000);
}

function GoToStep4forModel(){  //Rééquilibrage à partir du module modèle 
      Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 3
      WaitUntilObjectDisappears(Get_CroesusApp(), ["WindowMetricTag","ProgressWindowMetricTag"], ["PROGRESSWINDOW","PROGRESSWINDOW_RESYNCRONIZEPARAMETER"], 100000);
      WaitObject(Get_CroesusApp(), "Uid", "TabControl_1a23",40000); 
      Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 4
      Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 5
      //WaitObject(Get_CroesusApp(), "Uid", "TabControl_1a23",40000);
      Get_WinRebalance_BtnGenerate().WaitProperty("IsEnabled", true, 15000);
      Get_WinRebalance_BtnGenerate().Click();
      WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad",40000);
      Get_WinGenerateOrders_BtnGenerate().Click();
      Get_DlgConfirmation_BtnReinitialize().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad", 100000);
}

function SSHExecute(txtFile){
       //Create PLINK batch file
        var hostname = GetVserverHostName(vServerOrders);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m "+txtFile+".txt > "+txtFile+"_output.txt";
        var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "\\ProjectSuiteSleeves\\Sleeves\\SSH\\"+txtFile+"_plink.bat";
        CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
        //Execute PLINK batch file (The PLINK application must be present in the same folder)
        ExecuteBatchFile(plinkBatchFilePath);
}