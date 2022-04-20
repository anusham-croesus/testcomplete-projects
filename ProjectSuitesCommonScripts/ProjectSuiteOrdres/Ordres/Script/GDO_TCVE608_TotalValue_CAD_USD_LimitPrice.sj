//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0
//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade

/**
    Module               :  Orders
    Jira                 :  TCVE-324
    Description          :  GDO Ajouter des ordres en bloc pour valider le calcul: Valeur totale(CAD - USD) pour titres interlistés, Cours Limite
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-77    
    Mise-à-jour sur la version:  90.26-16 (Philippe Maurice)
*/


function GDO_TCVE608_TotalValue_CAD_USD_LimitPrice() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-608");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                        
            var Account800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account800002NA", language+client);
            var Account800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account800002OB", language+client);            
            var cmbTransactionType_TCVE608=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE608", language+client);            
            var quantity_TCVE608=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE608", language+client);           
            var symbol_TCVE608=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE608", language+client);            
            var cmbTransaction_TCVE608=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE608", language+client); 
            var descRY_TCVE608=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descRY_TCVE608", language+client);           
            var NYS=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "NYS_TCVE608", language+client); 
            var TSE=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TSE_TCVE608", language+client); 
            var Value_Acc800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value_Acc800002NA", language+client);  
            var Value_Acc800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value_Acc800002OB", language+client); 
            var Value1_Acc800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value1_Acc800002NA", language+client);  
            var Value1_Acc800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value1_Acc800002OB", language+client); 
            var Value2_Acc800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value2_Acc800002NA", language+client);  
            var Value2_Acc800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value2_Acc800002OB", language+client); 
            var limit = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "limit_TCVE608", language+client); 
            var market = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "market_TCVE608", language+client); 
            var atPrice = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "atPrice_TCVE608", language+client);
            var onStop = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "onStop_TCVE608", language+client);
            var stopLimit = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "stopLimit_TCVE608", language+client);
            
            //Se connecter à croesus
            Log.Message("Se connecter à croesus");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            /*Aller dans le module Compte; Sélectionner les comptes 800002-NA et 800002-OB
            cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)*/
            Log.Message("Aller dans le module Compte; Sélectionner les comptes 800002-NA et 800002-OB");
            SelectTwoAccount(Account800002NA, Account800002OB);
                       
            Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            /*Dans la fenêtre choisir;transactions = Achat + Ajouter ;Quantité = 100;Unités par compte;Symbole = RY (BANQUE ROYALE DU CDA)  BOURSE TSE
            Cliquer sur Générer*/
            Log.Message("Dans la fenêtre choisir, transactions = Achat + Ajouter ;Quantité = 100; Unités par compte;Symbole = RY (BANQUE ROYALE DU CDA)  BOURSE TSE");
            CreateBuyOrderSwitchBlock(cmbTransaction_TCVE608,quantity_TCVE608,cmbTransactionType_TCVE608,symbol_TCVE608,descRY_TCVE608);

            /*Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.*/
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE608)*2,10).DblClick();

            /*Modifier le titre sélectionné pour symb.  RY, Bourse NYS.Répondre Ok au message. titre : RY.Bourse NYS*/           
            Log.Message("Modifier le titre sélectionné pour symb.RY, Bourse NYS.Répondre Ok au message. titre : RY.Bourse NYS");
            ModifySelectedSecurity(1); //NYS

            /*Sous l'onglet Comptes sous-jacents Consulter les colonnes Valeur totale (%devise) et Valeur totale en devise du compte.
            Valeur totale en devise du compte:Le 800002-NA affiche 5271,00;Le 800002-OB affiche 4979,69.*/
            Log.Message("Valider que la valeur totale en devise du compte:Le 800002-NA affiche 5271,00; Le 800002-OB affiche 4979,69.");  
            ValidateTotalValue(Value_Acc800002NA, Value_Acc800002OB, Account800002NA, Account800002OB);           
            
            /*Modifier le titre sélectionné à RY, marché TSE. Répondre OK au message.Dans la section Paramètres champ Type d'ordres:
            Sélectionner dans la liste déroulante 'Cours limite'.Mettre 50.00 dans le champ Prix de l'ordre */
            Log.Message("Modifier le titre sélectionné à RY, marché TSE. Répondre OK au message.Dans la section Paramètres champ Type d'ordres:");
            Log.Message("Sélectionner dans la liste déroulante 'Cours limite'.Mettre 50.00 dans le champ Prix de l'ordre");            
            ModifySelectedSecurity(2);//TSE
            
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            Get_SubMenus().FindChild("WPFControlText",limit,10).DblClick();             
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys(atPrice);
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys("[Tab]");
            
            /*Sous l'onglet Comptes sous-jacents.Consulter les colonnes Valeur totale (%devise) et Valeur totale en devise du compte.
            Valeur totale en devise du compte: Le 800002-NA affiche 5000,00; Le 800002-OB affiche 4723.67.*/
            Log.Message("Sous l'onglet Comptes sous-jacents.Consulter les colonnes Valeur totale (%devise) et Valeur totale en devise du compte.");
            Log.Message("Valeur totale en devise du compte: Le 800002-NA affiche 5000,00; Le 800002-OB affiche 4723.67");
            ValidateTotalValue(Value1_Acc800002NA, Value1_Acc800002OB, Account800002NA, Account800002OB);   
                        
            /*Modifier le titre sélectionné pour symb.  RY,Bourse NYS.Répondre Ok au message. Après validation cliquer sur Annuler */
            Log.Message("Modifier le titre sélectionné pour symb.  RY,Bourse NYS.Répondre Ok au message. Après validation cliquer sur Annuler");
            ModifySelectedSecurity(1); //NYS
            
            /*Sous l'onglet Comptes sous-jacents.Consulter les colonnes Valeur totale (%devise) et Valeur totale en devise du compte.
            Valeur totale en devise du compte:Le 800002-NA affiche 5292,50; Le 800002-OB affiche 5000,00*/
            Log.Message("Sous l'onglet Comptes sous-jacents.Consulter les colonnes Valeur totale (%devise) et Valeur totale en devise du compte.");  
            Log.Message("Valeur totale en devise du compte:Le 800002-NA affiche 5292,50; Le 800002-OB affiche 5000,00");          
            ValidateTotalValue(Value2_Acc800002NA, Value2_Acc800002OB, Account800002NA, Account800002OB);            
            Get_WinOrderDetail_BtnCancel().Click();
            
            
            //Étape 6
            Log.Message("---ÉTAPE 6---");
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE608)*2,10).DblClick();
            
            Log.Message("Sélectionner dans la liste déroulante 'Stop'.  Mettre 50.00 dans le champ Prix de l'ordre Cours limite");
            Log.Message("Valeur totale en devise du compte: Le 800002-NA affiche 5000,00;  Le 800002-OB affiche 4723,67");
            
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            Get_SubMenus().FindChild("WPFControlText", onStop, 10).DblClick();             
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys(atPrice);
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys("[Tab]");
            
            ValidateTotalValue(Value1_Acc800002NA, Value1_Acc800002OB, Account800002NA, Account800002OB);            
            Get_WinOrderDetail_BtnCancel().Click();
            
            
            //Étape 7
            Log.Message("---ÉTAPE 7---");
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE608)*2,10).DblClick();
            
            Log.Message("Sélectionner dans la liste déroulante 'Stop avec limite'.  Mettre 50.00 dans le champ Prix de l'ordre Cours limite");
            Log.Message("Valeur totale en devise du compte: Le 800002-NA affiche 5000,00;  Le 800002-OB affiche 4723,67");
            
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            Get_SubMenus().FindChild("WPFControlText", stopLimit, 10).DblClick();  
            
            Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice2().Keys(atPrice);
            Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice2().Keys("[Tab]");
                       
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys(atPrice);
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys("[Tab]");
            
            ValidateTotalValue(Value1_Acc800002NA, Value1_Acc800002OB, Account800002NA, Account800002OB);            
            Get_WinOrderDetail_BtnCancel().Click();
            
            
            //Étape 8
            Log.Message("---ÉTAPE 8---");
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText", aqConvert.StrToInt(quantity_TCVE608)*2,10).DblClick();
            
            Log.Message("Modifier le titre sélectionné pour symb.  RY,Bourse NYS.Répondre Ok au message. Après validation cliquer sur Annuler");
            ModifySelectedSecurity(1); //NYS
            
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            Get_SubMenus().FindChild("WPFControlText", limit, 10).DblClick();             
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys(atPrice);
            Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Keys("[Tab]");
            
            ValidateTotalValue(Value2_Acc800002NA, Value2_Acc800002OB, Account800002NA, Account800002OB);            
            Get_WinOrderDetail_BtnCancel().Click();
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            //Supprimer l'ordre généré
            DeleteAllOrdersInAccumulator(); 
            //Fermer l'application
            Terminate_CroesusProcess();                       
        }
}

function ValidateTotalValue(value1, value2, Account800002NA, Account800002OB)
{
    Log.Message("Valeur " + Account800002NA + " : " + value1);
    Log.Message("Valeur actuelle: " + Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value", Account800002NA, 10).DataContext.DataItem.ValueNeededNDWithAccountCurrency);

    aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value", Account800002NA, 10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual, value1);

    Log.Message("Valeur " + Account800002OB + " : " + value2);
    Log.Message("Valeur actuelle: " + Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value", Account800002OB, 10).DataContext.DataItem.ValueNeededNDWithAccountCurrency);
    
    aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value", Account800002OB, 10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual, value2);
}

function ModifySelectedSecurity(position){
     Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
     Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", position).DblClick();
     Get_DlgInformation_BtnOK().Click();            
}

function SelectTwoAccount(acc1,acc2){
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
      SelectTwoAccounts(acc1,acc2);
}

function CreateBuyOrderSwitchBlock(cmbTransaction_TCVE608,quantity_TCVE608,cmbTransactionType_TCVE608,symbol_TCVE608,descRY_TCVE608){
      Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
      Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction_TCVE608],10).Click();
      AddABuyBySymbol(quantity_TCVE608,cmbTransactionType_TCVE608,symbol_TCVE608);                             
      Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
      Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
      Get_WinSwitchBlock_BtnGenerate().Click(); 
      if (Get_WinSwitchBlock().Exists)
        Get_WinSwitchBlock_BtnGenerate().Click();      
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");      
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd");
            
      Log.Message("Valider que l'ordre est envoyée dans l'accumulateur");
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE608)*2,10).DataContext.DataItem, "SecurityDesc", cmpEqual,descRY_TCVE608 );
}