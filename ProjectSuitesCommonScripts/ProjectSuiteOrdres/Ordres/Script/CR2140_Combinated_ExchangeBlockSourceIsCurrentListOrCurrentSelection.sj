//USEUNIT CR2140_common_functions


/**
    Ce script regroupe les scripts: CR2140_6055, CR2140_6070
    
    Les Liens dans TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6055
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6070
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
    Regroupé par : A.A Version ref90-19-2020-09-6 
    
*/


function CR2140_Combinated_ExchangeBlockSourceIsCurrentListOrCurrentSelection() {
         
      try {
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6025");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var account1_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            var account3_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account3_6055", language+client);
            var account4_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account4_6055", language+client);
            var account5_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account5_6055", language+client);
            
            var transactionType_6055   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6055    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            var UndrlyingAccounts_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "UndrlyingAccounts_6055", language+client);
            
            var quantity_6055   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6026", language+client);
            var symbol_6055     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6055", language+client); 
            var type_6055       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);
            var msgWarning_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var CADAccount_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
            var sourceType_6055 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "sourceType_6055", language+client);
                        
            var account1_6070   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6070   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            var msgWarning_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var quantity_6070   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6038", language+client); 
            var symbol_6070     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6038", language+client); 
            var type_6070       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
            var CADAccount_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
            
            var transactionType_6070 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6070", language+client);
            var cmbTransaction_6070  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6070", language+client); 

            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);

//6055            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800022-HU
            SelectFiveAccounts(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            //SelectFiveAccounts(account5_6055,account4_6055,account3_6055,account2_6055,account1_6055);
            
            //Appuyer la touche espace et afficher la liste par défaut les 2 comptes
            Get_RelationshipsClientsAccountsGrid().Keys(" ");
                        
            //Valider que les comptes ont un check rouge (Crochet)
            CheckAccountCrochet(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            
            //Enlever la sélection de tous les comptes sauf 800020-RE
           // Search_Account(account5_6055);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account5_6055,10).Click();
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Choisir Liste courante (Crochet) dans le Combo Source(s)
            Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceType_6055],10).Click();
            
            //Mettre Transaction à Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6055],10).Click();
            
            //Ajouter : 500 Unités par compte, symbole = CAS
            AddABuyBySymbol(quantity_6055,cmbTransaction_6055,symbol_6055);
            
            //Valider que l'ordre d'achat du titre CAS est ajouté
            CheckABuyInGrid(quantity_6055,symbol_6055);
            
            //Cliquer sur Aperçu
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Vérifier le message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning_6055);
            Get_DlgWarning().Keys("[Enter]");
            
            //Vérifier l'affichage des comptes dans la section Ordres
            CheckAccountsAfterPreview5(account1_6055,account2_6055,account3_6055,account4_6055,account5_6055);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6055);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6055);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6055);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6055],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que les comptes 800019-JW, 800020-ER, 800020-FS, 800020-RE sont affichés dans l'onglet Comptes sous-jacents et non 800019-HU
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == UndrlyingAccounts_6055) Log.Checkpoint(UndrlyingAccounts_6055+" comptes sous-jacent sont affichés");
            else Log.Error("Le nombre de comptes affichés dans l'onglet sous-jacents est incorrect");
            for (i=0;i<Grid.Items.Count;i++){
              if (Grid.Items.Item(0).DataItem.AccountNumber == account1_6055)
                  Log.Error("Le compte "+account1_6055+" ne doit pas être affiché");
              if (i==0)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account2_6055);
              if (i==1)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account3_6055);
              if (i==2)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account4_6055);
              if (i==3)aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account5_6055);
            }
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698"); 
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6055); 
                      
//6070
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800019-JW
            SelectTwoAccounts(account1_6070,account2_6070);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Vérifier le message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning_6070);
            Get_DlgWarning().Keys("[Enter]");
            
            //Mettre Transaction à Vente
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6070],10).Click();
            
            //Ajouter : 100 % de la position détenue, symbole = NBC813
            AddABuyBySymbol(quantity_6070,cmbTransaction_6070,symbol_6070);
            
            //Valider que l'ordre de vente du titre NBC813 est ajouté
            CheckASellInGrid(quantity_6070,symbol_6070);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
            Get_WinSwitchBlock_BtnGenerate().Click(); 
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            SetAutoTimeOut();
            if(Get_WinSwitchBlock().Exists){
               Get_WinSwitchBlock_BtnGenerate().Click(); 
               WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            }
            RestoreAutoTimeOut();
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6070);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6070);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6070);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6070],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que juste le compte 800019-JW est affiché dans l'onglet Comptes sous-jacents
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == 1) Log.Checkpoint("Un seul compte sous-jacent est affiché");
            else Log.Error("Aucun compte ou plus d'un compte sous-jacents sont affichés");
            aqObject.CheckProperty( Grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account2_6070);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6070); 
            
            //Supprimer les segments et les modèles créés dans CROES-6025
            DeleteSleevesAndModelsCreatedIn6025(); 
      
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess(); 
            
            //Mettre la pref PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = "" valeur par défaut
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TRADE_ACCOUNT_TYPES_EXCLUDED", "", vServerOrders);
            
            //Mettre la pref PREF_SLEEVE_ALLOW_TRADE = NO  pour le USer utilisé (keyneJ) la valeur par défaut
            Activate_Inactivate_Pref("KEYNEJ", "PREF_SLEEVE_ALLOW_TRADE", "NO", vServerOrders);
            
            //Redemarrer les services
            RestartServices(vServerOrders);               
        }
}            

