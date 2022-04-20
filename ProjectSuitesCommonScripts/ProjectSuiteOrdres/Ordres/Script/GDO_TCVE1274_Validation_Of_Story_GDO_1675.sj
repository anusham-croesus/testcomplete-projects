//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA



/* 
Analyste d'assurance qualité: Karima Mouzaoui
Analyste d'automatisation: Sana Ayaz*/ 
 
 function GDO_TCVE1274_Validation_Of_Story_GDO_1675()
 {             
    try{  
      
    
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1284","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1274","Lien du cas de test dans Jira");
           
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var account800006NA                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800006NA", language+client);
           var account800011NA                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800011NA", language+client);
           var securitySymbolRY                 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securitySymbolRY", language+client);
           var securitySymbolENB                =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securitySymbolENB", language+client);
           var saleTransaction                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "saleTransaction", language+client);
           var quantiteTransactionVente         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionVente", language+client);
           var quantiteTransactionSourceRY      =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionSourceRY", language+client);
           var cmbQuantiteAccountMarketValue    =ReadDataFromExcelByRowIDColumnID(filePath_Orders,"GDO", "cmbQuantiteAccountMarketValue", language+client);         
           var securitySymbolNA                 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securitySymbolNA", language+client);
           var referencePriceTransactionSource  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "referencePriceTransactionSource", language+client);
           var valueComboQuantiteDeuxPosi       =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueComboQuantiteDeuxPosi", language+client);
           var valueComboQuantiteStep8          =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueComboQuantiteStep8", language+client);
           var quantiteTransactionSourceStep8   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionSourceStep8", language+client);
           var quantiteTransactionVenteStep8    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionVenteStep8", language+client);
           var buyTransaction                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "buyTransaction", language+client);
           var countDgvOrdersStep10             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "countDgvOrdersStep10", language+client);
           var SourceStep13                     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SourceStep13", language+client);
           var quantiteStep6                    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteStep6", language+client);
           var referencePriceTransactionSourceStep6 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "referencePriceTransactionSourceStep6", language+client);
           var quantiteTransactionSourceDeuxPosi =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionSourceDeuxPosi", language+client);
           var valueGroupTransactionStep8        =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueGroupTransactionStep8", language+client);
           var valueGroupTransactionStep9        =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueGroupTransactionStep9", language+client);
           var countDgvAccumulOrdreStep13        =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "countDgvAccumulOrdreStep13", language+client);
        
           
           
           
           
           

/************************************Étape 1************************************************************************/     
           //Se connecter à croesus avec Keynej
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");
          Log.Message("Se connecter à croesus avec Keynej")
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
       
/************************************Étape 2************************************************************************/     
           
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Mailler les comptes 800006-NA et 800011-NA vers Portefeuille");

           //Accéder au module compte
           Log.Message("Acceder au module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           
           //Sélectionner les comptes 800006-NA et 800011-NA 
           Log.Message("Sélectionner les comptes  800006-NA et 800011-NA ");
           var arrayOfAccountsNo= new Array(account800006NA,account800011NA)
           SelectAccounts(arrayOfAccountsNo)
           Log.Message("Mailler vers le module portefeuile")
           Get_MenuBar_Modules().Click();
           Get_MenuBar_Modules_Portfolio().Click();
           Get_MenuBar_Modules_Portfolio_DragSelection().Click();
           
/************************************Étape 3************************************************************************/     
              
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3: Sélectionner les titres ENBRIDGE (compte 800006-NA) et BANQUE ROYALE DU CANADA (compte 800011-NA) dans le Portefeuille");
           Search_SecurityBySymbol(securitySymbolRY);
 
    var lines = Get_Grid_VisibleLines(Get_Portfolio_AssetClassesGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.Symbol.OleValue == securitySymbolRY && lines[n].dataContext.dataItem.AccountNumber.OleValue == account800011NA ){
                 Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
           

            Sys.Desktop.KeyDown(0x11);
            Search_SecurityBySymbol(securitySymbolENB);
             var lines = Get_Grid_VisibleLines(Get_Portfolio_AssetClassesGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.Symbol.OleValue == securitySymbolENB && lines[n].dataContext.dataItem.AccountNumber.OleValue == account800006NA ){
                 Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
           
            Sys.Desktop.KeyUp(0x11);
            
/************************************Étape 4************************************************************************/     
              
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur le bouton Ordres multiples");
            Get_Toolbar_BtnSwitchBlock().Click();
//          Les points de vérifications  
            Log.Message("Vérifier que le champ Transaction(s):contient Vente")
            aqObject.CheckProperty(Get_WinSwitchBlock_GrpParameters_CmbTransactions(), "wText", cmpEqual, saleTransaction);
            var displayQuantiteItem1=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(0).DataItem.DisplayQuantity
            var displayQuantiteItem2=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(1).DataItem.DisplayQuantity
            var displaySymbolItem1=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(0).DataItem.SymbolDisplay
            var displaySymbolItem2=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(1).DataItem.SymbolDisplay

            Log.Message("Vérification de la valeur de la quantité de la position 1")
            CheckEquals(displayQuantiteItem1, quantiteTransactionVente, "La valeur de la quantité de la position 1");
            
            Log.Message("Vérification de la valeur de la quantité de la position 2")
            CheckEquals(displayQuantiteItem2, quantiteTransactionVente, "La valeur de la quantité de la position 2");
            
            Log.Message("Vérification de la valeur de la colonne symbole de la position 1")
            CheckEquals(displaySymbolItem1, securitySymbolRY, "La valeur de la colonne symbole de la position 1");
            
            Log.Message("Vérification de la valeur de la colonne symbole de la position 2")
            CheckEquals(displaySymbolItem2, securitySymbolENB, "La valeur de la colonne symbole de la position 2");
                     
            
/************************************Étape 5************************************************************************/     
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Modification de la position dont le symbole est RY");
            Log.Message("Sélectionner la position RY sous  Transaction(s): Vente ")  
            Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value", securitySymbolRY, 100).Click();
            Log.Message("Cliquer sur le bouton Modifier")
            Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();
            Log.Message("attendre que la fenêtre transaction source s'affiche")
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            Log.Message("Mettre pour le champ quantité la valeur 50")
            Get_WinSwitchSource_TxtQuantity().Keys(quantiteTransactionSourceRY); 
            Log.Message("Sélectionner % valeur de marché du compte  ")
            Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
            Get_WinSwitchSource_CmbQuantity().set_Text(cmbQuantiteAccountMarketValue);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
            Log.Message("Saisir pour le champ Titre la valeur NA")
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbolNA);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            Aliases.CroesusApp.subMenus.Find("Text",securitySymbolNA,10).DblClick(); 
            Get_WinSwitchSource_GrpPosition_TxtPrice().Clear();
            Log.Message("Saisir pour la valeur du Prix de référence la valeur 30")
            Get_WinSwitchSource_GrpPosition_TxtPrice().Clear();
            Get_WinSwitchSource_GrpPosition_TxtPrice().Keys(referencePriceTransactionSource);
           
             
           /************************************Étape 6************************************************************************/     
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Validation de la modification sur la position dont le symbole RY");
            Log.Message("Click sur le bouton OK de la fenêtre de transaction source pour sauvegarder les modification")
            Get_WinSwitchSource_btnOK().Click();
            Log.Message("Fenêtre Transaction(s): Vente Les données modifiés sont affichées ")
            
            Log.Message("Vérification de la valeur de la quantité de la position dont le symbole est NA")
            var displayQuantiteSymbolNA=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.DisplayQuantity.OleValue;
            CheckEquals(displayQuantiteSymbolNA, quantiteStep6, "La valeur de la quantité de la position dont le symbole est NA");
            
            Log.Message("Vérification de la valeur du prix de référence de la position dont le symbole est NA")
            var displayPrixReferenceSymbolNA=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.PriceForDisplay.OleValue;
            CheckEquals(displayPrixReferenceSymbolNA, referencePriceTransactionSourceStep6, "La valeur du prix de référence de la position dont le symbole est NA");
            
             /************************************Étape 7************************************************************************/     
           
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Validation de la modification sur la position dont le symbole RY");
            Log.Message("Sélectionner les positions NA et ENB sous Transaction(s): Vente")
            Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolENB, 10).Click();         
            Log.Message("Sélectionner tous avec :Ctrl+A ")
            Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Keys("^a");
            Log.Message("Cliquer sur le bouton Modifier")
            Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();
            Log.Message("Attendre que la fenêtre transaction source s'affiche")
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            Log.Message("Seules les informations touchant la quantité (nombre et type) sont affichées")
            SetAutoTimeOut(); 
             if(Get_WinSwitchSource_GrpPosition().Exists == true)
             {
                if(Get_WinSwitchSource_GrpPosition().VisibleOnScreen == true)
                {
                  Log.Error("Le groupe position visible alors que seules les informations touchant la quantité (nombre et type) sont affichées ")
                }
                else Log.Checkpoint("Le groupe position n'est pas visible ")
             }
             else Log.Checkpoint("Le groupe position n'existe pas")
             RestoreAutoTimeOut();

             aqObject.CheckProperty(Get_WinSwitchSource_TxtQuantity(), "Text", cmpEqual, quantiteTransactionSourceDeuxPosi);
             aqObject.CheckProperty(Get_WinSwitchSource_TxtQuantity(), "VisibleOnScreen", cmpEqual, true);
            
             aqObject.CheckProperty(Get_WinSwitchSource_CmbQuantity(), "Text", cmpEqual, valueComboQuantiteDeuxPosi);
             aqObject.CheckProperty(Get_WinSwitchSource_CmbQuantity(), "VisibleOnScreen", cmpEqual, true);
             
              /************************************Étape 8************************************************************************/     
           
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Validation de la modification sur la position dont le symbole RY");
            Log.Message("Modifier la quantité à [75], [Unités par compte]")
            Get_WinSwitchSource_TxtQuantity().Keys(quantiteTransactionSourceStep8); 
            Get_WinSwitchSource_CmbQuantity().set_Text(valueComboQuantiteStep8);
            Log.Message("Cliquer sur le bouton OK")
            Get_WinSwitchSource_btnOK().Click();
//          Les points de vérifications
            Log.Message("Vérification de la valeur de la quantité de la position dont le symbole est NA")
            var displayQuantiteSymbolNA=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.DisplayQuantity.OleValue;
            CheckEquals(displayQuantiteSymbolNA, quantiteTransactionVenteStep8, "La valeur de la quantité de la position dont le symbole est NA");
            
            Log.Message("Vérification de la valeur de la quantité de la position dont le symbole est ENB")
            var displayQuantiteSymbolENB=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolENB, 10).DataContext.DataItem.DisplayQuantity.OleValue;
            CheckEquals(displayQuantiteSymbolENB, quantiteTransactionVenteStep8, "La valeur de la quantité de la position dont le symbole est ENB");
            aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions(), "WPFControlText", cmpEqual, valueGroupTransactionStep8);
           
             
              /************************************Étape 9************************************************************************/     
           
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Dans Paramètres, cliquer sur Transaction(s): Vente, et modifier pour Achat");
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(buyTransaction);
                    
            aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions(), "WPFControlText", cmpEqual, valueGroupTransactionStep9);
        
//          Les points de vérifications
  
            
            Log.Message("Vérification de la valeur de la quantité de la position dont le symbole est NA")
            var displayQuantiteSymbolNA=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.DisplayQuantity.OleValue;
            CheckEquals(displayQuantiteSymbolNA, quantiteTransactionVenteStep8, "La valeur de la quantité de la position dont le symbole est NA");
            
             
            Log.Message("Vérification de la valeur de la quantité de la position dont le symbole est ENB")
            var displayQuantiteSymbolENB=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild("Value",securitySymbolENB, 10).DataContext.DataItem.DisplayQuantity.OleValue;
            CheckEquals(displayQuantiteSymbolENB, quantiteTransactionVenteStep8, "La valeur de la quantité de la position dont le symbole est ENB");
            
            
            
            
            
              /************************************Étape 10************************************************************************/     
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10:Click sur le bouton Aperçu et validation des 4 transactions affichés dans l'aperçu");
            Log.Message("Click sur le bouton Aperçu")
            Get_WinSwitchBlock_BtnPreview().Click();
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_7704");
            Delay(5000);
//          Les points de vérifications :Quatre transactions sont affichées dans l'Aperçu 

            var nbreElementGrilleOrdre=Get_WinSwitchBlock_DgvOrders().Items.Count 
            Log.Message("Vérification du nombre d'élément de la grille ordre")
            CheckEquals(nbreElementGrilleOrdre, countDgvOrdersStep10, "Le nombre d'élément de la grille ordres");
//          Les points de vérifications des comptes affichées  
            var displayAccountItem1=Get_WinSwitchBlock_DgvOrders().Items.Item(0).DataItem.AccountNumber
            var displayAccountItem2=Get_WinSwitchBlock_DgvOrders().Items.Item(1).DataItem.AccountNumber
            var displayAccountItem3=Get_WinSwitchBlock_DgvOrders().Items.Item(2).DataItem.AccountNumber
            var displayAccountItem4=Get_WinSwitchBlock_DgvOrders().Items.Item(3).DataItem.AccountNumber
            
            CheckEquals(displayAccountItem1, account800006NA, "Le numéro du premier compte ");
            CheckEquals(displayAccountItem2, account800006NA, "Le numéro du deuxième compte");
            CheckEquals(displayAccountItem3, account800011NA, "Le numéro du troisième compte");
            CheckEquals(displayAccountItem4, account800011NA, "Le numéro du quatrième compte");
            
          //Les points de vérifications des symboles affichés
  
            var displaySymbolItem1=Get_WinSwitchBlock_DgvOrders().Items.Item(0).DataItem.Symbol
            var displaySymbolItem2=Get_WinSwitchBlock_DgvOrders().Items.Item(1).DataItem.Symbol
            var displaySymbolItem3=Get_WinSwitchBlock_DgvOrders().Items.Item(2).DataItem.Symbol
            var displaySymbolItem4=Get_WinSwitchBlock_DgvOrders().Items.Item(3).DataItem.Symbol
            
            CheckEquals(displaySymbolItem1, securitySymbolNA, "Le numéro du premier compte ");
            CheckEquals(displaySymbolItem2, securitySymbolENB, "Le numéro du deuxième compte");
            CheckEquals(displaySymbolItem3, securitySymbolNA, "Le numéro du troisième compte");
            CheckEquals(displaySymbolItem4, securitySymbolENB, "Le numéro du quatrième compte");
            
            
   
              /************************************Étape 11************************************************************************/     
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11:cliquer sur Générer");
            
            //cliquer sur Générer
            Log.message("cliquer sur Générer");
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
//            
           
/************************************Étape 12************************************************************************/     
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12:Dans l'accumulateur:valider les 2 ordres générés");
            var nbreElementGrilleAccumulOrdre=Get_OrderAccumulatorGrid().RecordListControl.Items.Count 
            Log.Message("Vérification du nombre d'élément de la grille accumulateur")
            CheckEquals(nbreElementGrilleAccumulOrdre, countDgvAccumulOrdreStep13, "Le nombre d'élément de la grille Accumulateur");
                       
            Log.Message("Vérification de la valeur de la colonne côté de l'ordre dont le symbole est NA")
            var displayQuantiteSymbolNA=Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.TypeForDisplay.OleValue;
            CheckEquals(displayQuantiteSymbolNA, buyTransaction, "La valeur de la colonne côté de l'ordre dont le symbole est NA");
            
             
            Log.Message("Vérification de la valeur de la colonne côté de l'ordre dont le symbole est ENB")
            var displayQuantiteSymbolENB=Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolENB, 10).DataContext.DataItem.TypeForDisplay.OleValue;
            CheckEquals(displayQuantiteSymbolENB, buyTransaction, "La valeur de la colonne côté de l'ordre dont le symbole est ENB");
     
            
             Log.Message("Vérification de la valeur de la colonne source de l'ordre dont le symbole est NA")
            var displayQuantiteSymbolNA=Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolNA, 10).DataContext.DataItem.SourceForDisplay.OleValue;
            CheckEquals(displayQuantiteSymbolNA, SourceStep13, "La valeur de la colonne source de l'ordre dont le symbole est NA");
            
             
            Log.Message("Vérification de la valeur de la colonne source de l'ordre dont le symbole est ENB")
            var displayQuantiteSymbolENB=Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolENB, 10).DataContext.DataItem.SourceForDisplay.OleValue;
            CheckEquals(displayQuantiteSymbolENB, SourceStep13, "La valeur de la colonne source de l'ordre dont le symbole est ENB");
          
            
/************************************Étape 13************************************************************************/     
            Log.PopLogFolder();
            logEtape13 = Log.AppendFolder("Étape 13:Double cliquer sur l'ordre ENB pour voir le détail de l'ordre");
            Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolENB, 10).DblClick();
            aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "Text", cmpEqual, securitySymbolENB);
         
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "AccountNumber", cmpEqual,account800006NA);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "AccountNumber", cmpEqual,account800011NA);
         
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "QuantityNeededForDisplay", cmpEqual,quantiteTransactionSourceStep8);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "QuantityNeededForDisplay", cmpEqual,quantiteTransactionSourceStep8);
            Get_WinOrderDetail_BtnCancel().Click();
           
/************************************Étape 14************************************************************************/     
            Log.PopLogFolder();
            logEtape14 = Log.AppendFolder("Étape 14:Double cliquer sur l'ordre NA");
            Get_OrderAccumulatorGrid().FindChild("Value",securitySymbolNA, 10).DblClick();
            aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "Text", cmpEqual, securitySymbolNA);
         
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "AccountNumber", cmpEqual,account800006NA);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "AccountNumber", cmpEqual,account800011NA);
         
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "QuantityNeededForDisplay", cmpEqual,quantiteTransactionSourceStep8);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "QuantityNeededForDisplay", cmpEqual,quantiteTransactionSourceStep8);
/************************************TCVE-1861:Automatisation de la story GDO-2867************************************************************************/           
/************************************Étape 15************************************************************************/ 
            Log.Link("https://jira.croesus.com/browse/TCVE-1867","Lien de la story dans Jira");
  
            Log.PopLogFolder();
            logEtape15 = Log.AppendFolder("Étape 15:Dans la fenêtre Détail de l'ordre, valider les boutons radio de la section Sollicité");
            Log.Message("Sollicité est coché par défaut et grisé")
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, true);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "Enabled"  , cmpEqual, false);
           
            Log.Message("Non sollicité est non coché et il est grisé")
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "Enabled"  , cmpEqual, false);
/************************************Étape 16************************************************************************/     
            Log.PopLogFolder();
            logEtape16 = Log.AppendFolder("Étape 16:Vérifier puis soumettre l'ordre NA puis Valider les boutons radio Sollicité");
             //Cliquer sur vérifier ensuite soumettre
            Get_WinOrderDetail_BtnVerify().Click();
            if (language == "french") WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Soumettre"]);
            else WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Submit"]);
            Get_WinOrderDetail_BtnVerify().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            Get_OrderGrid().Find("Value",securitySymbolNA,10).DblClick();
            Log.Message("Sollicité est coché par défaut et grisé")
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, true);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "Enabled"  , cmpEqual, false);
           
            Log.Message("Non sollicité est non coché et il est grisé")
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "Enabled"  , cmpEqual, false);
            Get_WinOrderDetail_BtnCancel().Click();
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Log.Message("Supprimer les ordres"); 
        DeleteAllOrdersInAccumulator(); 
        Terminate_CroesusProcess();
    }
    finally {   
        
//      suppression de tous les ordres
        Log.Message("Supprimer les ordres"); 
        DeleteAllOrdersInAccumulator(); 
        //Fermer l'application
        Terminate_CroesusProcess();    
      
    }
 }
 
  
 function DeleteAllOrdersInAccumulator()
{   
   
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){
    

       
      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
      Get_DlgConfirmation_BtnYes().Click();
       }   
}
 