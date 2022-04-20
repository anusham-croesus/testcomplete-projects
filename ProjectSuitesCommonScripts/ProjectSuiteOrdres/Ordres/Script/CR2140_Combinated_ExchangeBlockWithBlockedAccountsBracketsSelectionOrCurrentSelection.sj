//USEUNIT CR2140_common_functions


/**
    Ce script regroupe les scripts: CR2140_6053, CR2140_6038
    
    Les Liens dans TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6053
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6038
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
    Regroupé par : A.A Version ref90-19-2020-09-6 
    
*/


function CR2140_Combinated_ExchangeBlockWithBlockedAccountsBracketsSelectionOrCurrentSelection() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6053","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var account1_6053    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6053    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6037", language+client);
            var sourceType_6053  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "sourceType_6055", language+client);
            var quantity_6053    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6053", language+client); 
            var symbol_6053      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6038", language+client); 
            var type_6053        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6032", language+client);
            var msgWarning1_6053 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6037", language+client);
            var msgWarning2_6053 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning2_6053", language+client);
    
            var transactionType_6053 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6070", language+client);
            var cmbTransaction_6053  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            
            var account1_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6038", language+client);
            
            var msgWarning1_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6038", language+client);
            var CADAccount_6038  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CADAccount_6038", language+client);
            var transactionType_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6038  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            
            var quantity_6038 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6038", language+client);
            var symbol_6038   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6038", language+client);
            var type_6038     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "type_6031", language+client);

      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800022-HU
            SelectTwoAccounts(account1_6053,account2_6053);
                
            //Appuyer la touche espace 
            Get_RelationshipsClientsAccountsGrid().Keys(" ");
                        
            //Valider que les deux comptes ont un check rouge
            var Grid = Get_RelationshipsClientsAccountsGrid().RecordListControl
            var count = Grid.Items.Count;
            Log.Message(count)
            for (i=0;i<count;i++){
              if (Grid.Items.Item(i).DataItem.AccountNumber == account1_6053){
                  Log.Message(i)
                  aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
                  }
              if (Grid.Items.Item(i).DataItem.AccountNumber == account2_6053){
                  Log.Message(i)
                  aqObject.CheckProperty( Grid.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual,true);
                  }
            }
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Choisir Liste courante (Crochet) dans le Combo Source(s)
            Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceType_6053],10).Click();
            
            //Mettre Transaction à Vente
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6053],10).Click();
            
            //Ajouter : 10 unité par compte, symbole = NBC813
            AddABuyBySymbol(quantity_6053,cmbTransaction_6053,symbol_6053);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
            
            if(Get_WinSwitchBlock_BtnGenerate().IsEnabled){
               Get_WinSwitchBlock_BtnGenerate().Click(); 
            };
            //Vérifier le 1er message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6053);
            Get_DlgWarning().Keys("[Enter]");
            
            //Vérifier le 2eme message d'avertissement affiché
            Log.Message("Jira CROES-11412");
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning2_6053);
            Get_DlgWarning().Keys("[Enter]");
            
            Get_WinSwitchBlock_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800019-JW
            SelectTwoAccounts(account1_6038,account2_6038);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Vérifier le 1er message d'avertissement affiché
            if(Get_DlgWarning().Exists){
                aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6038);
                Get_DlgWarning().Keys("[Enter]");
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            }
            //Choisir type transaction Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6038],10).Click();
            
                       
            //Ajouter : 100 Unités par compte, symbole = NBC813
            AddABuyBySymbol(quantity_6038,cmbTransaction_6038,symbol_6038);
            
            //Valider que l'ordre d'achat du titre NBC813 est ajouté
            CheckABuyInGrid(quantity_6038,symbol_6038);
            
            //Cliquer sur Aperçu
            Get_WinSwitchBlock_BtnPreview().Click();
            
            if(Get_DlgWarning().Exists){
                aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6038);
                Get_DlgWarning().Keys("[Enter]");
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            }
            
            //Vérifier l'affichage des comptes dans la section Ordres
            CheckAccountsAfterPreview(account1_6038,account2_6038);
            
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //valider l'ordre dans l'accumulateur CAD_ACCOUNT
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"AccountNumber",cmpEqual,CADAccount_6038);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"TypeForDisplay",cmpEqual,type_6038);
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0).DataItem,"OrderSymbol",cmpEqual,symbol_6038);
            
            //Double cliquer sur l'ordre
            Get_OrderAccumulator().FindChild(["ClrClassName","Value"],["XamTextEditor",CADAccount_6038],10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Vérifier que juste le compte 800019-JW est affiché dans l'onglet Comptes sous-jacents
            var Grid = Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1);
            if (Grid.Items.Count == 1) Log.Checkpoint("Un seul compte sous-jacent est affiché");
            else Log.Error("Aucun compte ou plus d'un compte sous-jacents sont affichés");
            aqObject.CheckProperty( Grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account2_6038);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");            
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
          
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(CADAccount_6038);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}