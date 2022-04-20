//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-312
    Description          :  GDO Ajouter des ordre en bloc pour valider les comptes Pro dans l'accumulateur 
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-39
  
    
*/


function GDO_TCVE312_Validate_Column_Pro() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-312");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var columnPro=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "columnPro", language+client); 
            var acc800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800300NA", language+client);
            var acc800301NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800301NA", language+client);
            var acc800202NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800202NA", language+client);
            var acc800203FS=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800203FS", language+client);
            var quantity_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE312", language+client);
            var quantity1_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity1_TCVE312", language+client);
            var symbol_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE312", language+client);
            var cmbTransaction_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE312", language+client); 
            var cmbTransactionType_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE312", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            DeleteAllOrdersInAccumulator();  
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            
            //Aller dans l'entête et ajouté la colonne Pro
            Log.message("Aller dans l'entête et ajouter la colonne Pro");   
            SetAutoTimeOut();
            if(!Get_AccountsGrid_ChPro().Exists){
                Get_AccountsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }
            RestoreAutoTimeOut();            
            //La colonne Pro est ajoutée dans la grille
            Log.Message("La colonne Pro est ajoutée dans la grille")
            aqObject.CheckProperty(Get_AccountsGrid_ChPro(), "Content", cmpEqual, columnPro);

            //Les étapes 2  à 4 
            CreateOrdre(acc800300NA,acc800301NA,quantity_TCVE312,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312);
                                              
            /*Dans la section du bas faire un right clcik sur ajouter l'entête. Ajouter la colonne Pro*/     
            Log.Message("Dans la section du bas faire un right clcik sur ajouter l'entête Ajouter la colonne Pro");
            SetAutoTimeOut();
            if(!Get_WinSwitchBlock_DgvOrders_ChPro().Exists){
               Get_WinSwitchBlock_DgvOrders_ChInclude().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }
            RestoreAutoTimeOut();
                         
            //La colonne Pro est visible et est coché pour les deux comptes
            Log.Message("La colonne Pro est visible et est coché pour les deux comptes");
            aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChPro(), "Content", cmpEqual, columnPro);
            aqObject.CheckProperty(Get_WinSwitchBlock().FindChild("Value",acc800300NA,10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
            aqObject.CheckProperty(Get_WinSwitchBlock().FindChild("Value",acc800301NA,10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
                        
            //cliquer sur Générer
            Log.message("cliquer sur Générer");
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Retourner  au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            //Les étapes 5  à 7
            CreateOrdre(acc800202NA,acc800203FS,quantity1_TCVE312,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312);
                                            
            //La colonne Pro 800202-NA  -> Coché; 800203-FS  -> vide
            Log.Message("validation:La colonne Pro 800202-NA  -> Coché; 800203-FS  -> vide")
            aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChPro(), "Content", cmpEqual, columnPro);
            aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().FindChild("Value",acc800202NA,10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
            aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().FindChild("Value",acc800203FS,10).DataContext.DataItem, "IsProAccount", cmpEqual, false);
                      
            //cliquer sur Générer
            Log.message("cliquer sur Générer");
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          
            //- Dans l'accumulateur - Ajouter la colonne Pro
            Log.Message("- Dans l'accumulateur - Ajouter la colonne Pro");
            SetAutoTimeOut();
            if(!Get_OrderAccumulatorGrid_ChPro().Exists){
               Get_OrderAccumulatorGrid_ChAccountNo().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }             
            RestoreAutoTimeOut();
            //La colonne Pro coché pour les deux comptes (CAD_ACCOUNT)
            Log.Message("La colonne Pro est visible et est coché pour les deux comptes");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPro(), "Content", cmpEqual, columnPro);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("WPFControlText","126",10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("WPFControlText","122",10).DataContext.DataItem, "IsProAccount", cmpEqual, true);  
         
            // Dans l'accumulateur sélectionner le compte CAD-ACCOUNT crée de l'étape précédente avec la quantité = 126 et faire une double click
            Log.Message("Dans l'accumulateur sélectionner le compte CAD-ACCOUNT crée de l'étape précédente avec la quantité = 126 et faire une double click");
            Get_OrderAccumulatorGrid().FindChild("WPFControlText","126",10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Cliquer sur l'Onglet compte sous-jacents. Ajouter la colonne Pro dans l'entête
            SetAutoTimeOut();
            if(!Get_WinOrderDetail_TabUnderlyingAccounts_ChPro().Exists){
               Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Get_GridHeader_ContextualMenu_AddColumn_Pro().Click(); 
            }
            RestoreAutoTimeOut();
            //Validation: La colonne Pro est visible 800202-NA  -> Coché 800203-FS  -> vide 
            Log.message("validation: La colonne Pro est visible 800202-NA  -> Coché 800203-FS  -> vide");
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChPro(), "Content", cmpEqual, columnPro);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",acc800202NA,10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",acc800203FS,10).DataContext.DataItem, "IsProAccount", cmpEqual, false); 
            Get_WinOrderDetail_BtnCancel().Click();            
           
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
            
      }
      finally {
	       //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language); 
            Get_ModulesBar_BtnOrders().Click();
            //Supprimer l'ordre généré
            DeleteAllOrdersInAccumulator();                        
            //Fermer l'application
            Terminate_CroesusProcess();              
        }
}


function CreateOrdre(acc1,acc2,quantity,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312){
            Log.Message("Sélectionner les comptes" + acc1+" et"+ acc2);
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            SelectTwoAccounts(acc1,acc2);
                        
            //cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)   
            Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            /*- Dans la fenêtre choisir - transactions = Achat + Ajouter  - Quantité = */ +quantity+/* - Unités par compte - Symbole = LB (BANQUE lAURENTIENNE CDA) - OK - cliquer sur Aperçu*/
            Log.Message("Dans la fenêtre choisir- transactions = Achat + Ajouter - Quantité = 61- Unités par compte- Symbole = LB (BANQUE lAURENTIENNE CDA)- OK- cliquer sur Aperçu");
           
            //Choisir type transaction Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionType_TCVE312],10).Click();
            AddABuyBySymbol(quantity,cmbTransaction_TCVE312,symbol_TCVE312);                  
                    
            //Cliquer sur Aperçu
            Get_WinSwitchBlock_BtnPreview().WaitProperty("IsEnabled", true, 30000);
            Get_WinSwitchBlock_BtnPreview().Click();
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_7704",maxWaitTime);
			Delay(2000);
}