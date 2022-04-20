//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0
//USEUNIT GDO_2464_Split_Of_BlockTrade


/**
    Module               :  Orders
    Jira                 :  TCVE-1281
    Description          :  Retrait des comptes non-discrétionnaires à la Soumission d'un bloc (GDO-1993) 
    Préconditions        : 
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.16.2020.5-42
    date                 :  27-05-2020 
  
    
*/

function GDO_TCVE_1281_Withdrawal_Non_Discretionary_Accounts_SubmittingBlock_GDO1993()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1281","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1168","Lien du cas de test dans Jira");
    
           //Declaration des Variables
           var userNameLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
           var passwordLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw");
          
           var account800056RE      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800056RE", language+client);
           var account800049NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800049NA", language+client);
           var account800049OB      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800049OB", language+client);
           var account800049RE      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800049RE", language+client);
           var transactionTCVE1281  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "transactionTCVE1281", language+client);
           var quantityTCVE1281     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE1281", language+client);
           var symbolMSFT           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolMSFT", language+client);
           var cmbTransaction       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
           var queryTCVE1281        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "queryTCVE1281", language+client); 
           var message_TCVE1281     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "message_TCVE1281", language+client);
           var typeDisplay          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "typeDisplay", language+client);
           
/************************************Étape 1************************************************************************/     
           //Se connecter à croesus avec LINCOA
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec LINCOA");
          Log.Message("Se connecter à croesus avec LINCOA")
          Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
          Get_MainWindow().Maximize();
       
/************************************Étape 2************************************************************************/     
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: sélectionner les comptes: "+account800056RE+", "+account800049NA+", "+account800049OB+" ,"+account800049RE );

           //Accéder au module compte
           Log.Message("Acceder au module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           
           //Sélectionner les comptes 80056-RE, 800049-NA, 800049-OB et 800049-RE 
           Log.Message("Sélectionner les comptes: "+account800056RE+", "+account800049NA+", "+account800049OB+" ,"+account800049RE);
           var arrayOfAccountsNo= new Array(account800056RE,account800049NA,account800049OB,account800049RE)
           SelectAccounts(arrayOfAccountsNo)
           
/************************************Étape 3, 4 , 5 et 6************************************************************************/     
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3,4,5,6: Ajouter Ordres multiples, en bloc et d'échange");
           
           // Cliquer le boutonOrdres multiples, en bloc et d'échange
           Log.Message("Cliquer le boutonOrdres multiples, en bloc et d'échange");
           Get_Toolbar_BtnSwitchBlock().Click();
           WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
                       
           // Ajouter une transaction Vente Quantité=200, Sélectionner Unité par compte, Titre:Symbole=MSFT
           Log.Message("Ajouter une transaction Vente");
           //Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
           
           SetAutoTimeOut();
            if(Get_DlgConfirmation().Exists){
              Get_DlgConfirmation_BtnYes().Click();
            };          
           RestoreAutoTimeOut();
           Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionTCVE1281],10).Click();
            
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10);
           
           //Appel à la fonction d'ajout qui existe dans le script CR2160_6026
           Log.Message("Appel à la fonction d'ajout qui existe dans le script CR2160_6026, peut être faut la déplacer dans Orders_common_functions")
           AddASellBySymbol(quantityTCVE1281,cmbTransaction,symbolMSFT);
                        
           //Cliquer sur le bouton Générer
           Log.Message("Cliquer sur le bouton Générer");
           Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
           Get_WinSwitchBlock_BtnGenerate().Click();            
           //WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
              
/************************************Étape 7************************************************************************/    
           Log.PopLogFolder();
           logEtape7 = Log.AppendFolder("Étape 7: Changer le statut des comptes 800049-NA et 800049-RE les faisant passer de Dicrétionnaire à Non-discrétionnaire");
           Log.Message("Changer le statut des comptes 800049-NA et 800049-RE à Non-discrétionnaire");
           Execute_SQLQuery(queryTCVE1281, vServerOrders);
            
/************************************Étape 8 ************************************************************************/     
           Log.PopLogFolder();
           logEtape8 = Log.AppendFolder("Étape 8 : Vérifier le message après le clic sur vérifier");
           Log.Message("Sélectionner l'ordre et cliquer sur le bouton vérifier");
           
            SetAutoTimeOut();
            if(Get_DlgConfirmation().Exists){
                Get_DlgConfirmation_BtnYes().Click();
              };          
            RestoreAutoTimeOut(); 
           
           Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",symbolMSFT],10).Click();
           Get_OrderAccumulator_BtnVerify().Click();
           WaitObject(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
           
/****************************************Étape 9 et 10 ************************************************************************/     
           Log.PopLogFolder();
           logEtape9 = Log.AppendFolder("Étape 9,10 :Valider le message qui est affiché en bas de fenêtre puis cocher l'ordre et soumettre");
           Log.Message("Valider le message qui est affiché en bas de fenêtre");
           aqObject.CheckProperty(Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["ListBoxItem","2"],10).DataContext.Message,"OleValue", cmpEqual, message_TCVE1281);
           Log.Message("Cocher l'ordre et soumettre");
           if (Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["XamCheckEditor","1"],10).IsChecked == false)
              Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["XamCheckEditor","1"],10).Click();
           Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled",true,1500);
           Get_WinAccumulator_BtnSubmit().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
           
           
/****************************************Étape 11 ************************************************************************/     
           Log.PopLogFolder();
           logEtape11 = Log.AppendFolder("Étape 11 :Dans le blotter, Valider que les compte 800049-NA et 800049-RE ne sont pas présent dans l'onglet Comptes sous-jascents");
           Log.Message("Dans le blotter,double cliquer sur l'ordre généré");           
           Get_OrderGrid().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).DblClick();
           WaitObject(Get_CroesusApp(), "Uid", "OrderDetails_d698");           

           Log.Message("Valider que les comptes 800049-NA et 800049-RE ne sont pas présent dans l'onglet Comptes sous-jascents");
           Get_WinOrderDetail_TabUnderlyingAccounts().Click();
           var grid = Get_WinOrderDetail().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10);
           var count = grid.Items.Count;
           for (i=0; i<count; i++){
              if (grid.Items.Item(i).DataItem.AccountNumber == account800049NA || grid.Items.Item(i).DataItem.AccountNumber == account800049RE )
                  Log.Error("Les comptes "+account800049NA+" et "+account800049RE+" ne doivent pas être affichés");
              else
                  Log.Checkpoint("Les comptes "+account800049NA+" et "+account800049RE+" ne sont pas affichés");
           }
           Get_WinOrderDetail_BtnCancel().Click(); 
            
/****************************************Étape 12 ************************************************************************/     
           Log.PopLogFolder();
           logEtape12 = Log.AppendFolder("Étape 12 :Retourner dans l'accumulateur, valider les ordres de vente pour les comptes 800049-NA et 800049-RE");
           Log.Message("Valider les ordres de vente pour les comptes 800049-NA et 800049-RE");
           var grid = Get_OrderAccumulator().accumulatorGrid.RecordListControl;
           var count = grid.Items.Count;
           var findNA = false;
           var findRE = false;
           for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == account800049NA ){
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem,"TypeForDisplay", cmpEqual, typeDisplay);
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem,"OrderSymbol", cmpEqual, symbolMSFT);
                    findNA = true;
                }
                if (grid.Items.Item(i).DataItem.AccountNumber == account800049RE ){
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem,"TypeForDisplay", cmpEqual, typeDisplay);
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem,"OrderSymbol", cmpEqual, symbolMSFT);
                    findRE = true;
                }
           }
           if (findNA && findRE)
              Log.Checkpoint("Les deux comptes "+account800049NA+" et "+account800049RE+" existent dans l'accumulateur");
           else 
              Log.Error("Au moins un des deux comptes "+account800049NA+" ou "+account800049RE+" n'existent pas dans l'accumulateur");
           
/****************************************Étape 13 ************************************************************************/     
           Log.PopLogFolder();
           logEtape13 = Log.AppendFolder("Étape 13 :Générer le PhaseOne");
           Log.Message("Générer le PhaseOne");
           //se connecter au Vserver en SSH(root, qa) et exécuter la commande:
           Log.Message("se connecter au Vserver en SSH(root, qa) et exécuter la commande:");
           ExecuteSSHCommandCFLoader("CR2080", vServerOrders, "cfLoader -PhaseOneGenerator -Firm=FIRM_1", "alhassaned");
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
//      suppression des ordres de l'accumulateur
        Log.Message("------------- C L E A N U P -----------------------------");
        Log.Message("Se connecter à croesus avec LINCOA")
        Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
        Get_ModulesBar_BtnOrders().Click();
        //Acceder au Module Ordres
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                
        //Supprimer l'ordre généré
        DeleteAllOrdersInAccumulator();
        Log.Message("Changer le statut des comptes 800049-NA et 800049-RE à Discrétionnaire");
        var queryTCVE1281CUP    = "update b_compte set is_discretionary = 'Y' where no_compte in ('800049-NA', '800049-RE')"; 
        Execute_SQLQuery(queryTCVE1281CUP, vServerOrders);
        
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }
 
 function AddASellBySymbol(quantity,cmbTransaction,symbol){
            Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
            //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
            Get_WinSwitchSource_CmbSecurity().Click();
            Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
            
            Get_WinSwitchSource_TxtQuantity().Keys(quantity);
            Get_WinSwitchSource_CmbQuantity().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction],10).Click();
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
            Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            SetAutoTimeOut();
            if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",symbol,10).DblClick();
            }
            RestoreAutoTimeOut();
            Get_WinSwitchSource_btnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
 }
 
