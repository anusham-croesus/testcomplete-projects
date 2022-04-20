//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1872_5755_ExtractOfRates_followedBy1stand2ndPhasefile_forPTFandNAVex
//USEUNIT CR1571_Croes6545_ValidateTheOperationNewCheckBoxManualProcessingOrder




/**
    Module               :  Orders
    Jira                 :  TCVE-2474
    Description          : Régression des story GDO-3164, GDO-2694, GDO-2698, GDO-3208, GDO-3425, GDO-3271, GDO-3473

    
    Auteur               :  Sana Ayaz
    Version de scriptage :	ref90-19-2020-09-14--V9-croesus-co7x-2_1_758
    date                 :  22-09-2020 
  
    
*/

function GDO_TCVE_2474_AutomationOfJirasAndGDOStoryMergedInVersion2020_09()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2508","Lien de la story dans Jira");
           //Lien du cas de test dans jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2474","Lien du cas de test dans Jira");
           Log.Message("ce script est en lien avec le script:GDO_TCVE2138_ValidIncludBoxAndWarningMessages parce que la partie des préconditions est fait dedans su script GDO_TCVE2138_ValidIncludBoxAndWarningMessages ")
    
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
           var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
           
           
           var symbolSecuRY                     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolSecuRY", language+client);
           var account800057FS                  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800057FS", language+client);
           var account800238RE                  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800238RE", language+client);
           var account800007FS                  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800007FS", language+client);
           var sourceTypeStep3                  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "sourceTypeStep3", language+client);
           var selectionWithCheckMarkectStep3   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "selectionWithCheckMarkectStep3", language+client);
           var DescriptionSecuritySymbolBBDB    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolBBDB", language+client);
           var DescriptionSecuritySymbolBMO     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolBMO", language+client);
           var DescriptionSecuritySymbolNA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolNA", language+client);
           var DescriptionSecuritySymbolRY      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolRY", language+client);
           var DescriptionSecuritySymbolTD      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolTD", language+client);
           var cmbTypUnitsPerAccount            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTypUnitsPerAccount", language+client); 
           var cmbTypeSecurityHeld              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTypeSecurityHeld", language+client);
           var quantityTypeUnitPerAccount       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTypeUnitPerAccount", language+client);
           var quantityTypeSecurityHeld         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTypeSecurityHeld", language+client);
           var symbolBBDB                       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolBBDB", language+client);
           var symbolRY                         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolRY", language+client);
           var symbolBMO                        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolBMO", language+client);
           var symbolNA                         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolNA", language+client);
           var symbolTD                         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolTD", language+client);
           var textMessage2Step6                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage2Step6", language+client); 
           var textMessage1Step7                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage1Step7", language+client);    
           var textMessage2Step7                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage2Step7", language+client);
           var textMessage3Step7                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage3Step7", language+client);
           var msg1Step10                       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "msg1Step10", language+client);
           var msg2Step10                       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "msg2Step10", language+client);
           var typOrdreFiltre                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "typOrdreFiltre", language+client);
           var valueFiltreStep11                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueFiltreStep11", language+client);
           var statusApproval                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "statusApproval", language+client);
           var valQuantity                      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valQuantity", language+client);
           var price                            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "price", language+client);
           var filterNameStep14                 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "filterNameStep14", language+client);
           var cmbFieldSymbolStep14             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbFieldSymbolStep14", language+client);
           var cmbOperatorFiltrStep14           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbOperatorFiltrStep14", language+client);
           var stausPartialFill                 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "stausPartialFill", language+client);
           var filterNameStep15                 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "filterNameStep15", language+client);
           var cmbOperatorFiltrStep15           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbOperatorFiltrStep15", language+client);
           var market                           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "market", language+client);
      

/************************************Étape 1************************************************************************/     
           /*Se connecter avec le user KEYNEJ*/          typOrdreFiltre
            
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user KEYNEJ");
          Log.Message("Se connecter avec le user KEYNEJ")
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
/************************************Étape 2************************************************************************/     
           /** Atteindre le module Comptes
             * Mailler dans Portefeuille le compte 800057-FS
             * Bloquer la position RY (quantité=850)*/        
            
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: * Atteindre le module Compte* Mailler dans Portefeuille le compte 800057-F* Bloquer la position RY (quantité=850)");     
          Log.Message("Choisir le module compte")  
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
          Log.Message("Sélectionner le compte: "+account800057FS);
          SelectAccounts(account800057FS);
          Log.Message("Mailler dans Portefeuille les comptes");
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          Log.Message("Bloquer la position RY (quantité=850) dans le comptes 800057-FS ")
           
       
          SelectPosition(symbolSecuRY,account800057FS)
          Get_PortfolioBar_BtnInfo().Click();
          Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(true);
          Get_WinPositionInfo_BtnOK().Click();

/************************************Étape 3************************************************************************/  
   
          /*Dans Comptes, sélectionner (en bleu et avec des crochets rouges) les comptes 800007-FS, 800057-FS et 800238-RE
           * Cliquer sur l'icône Ordres multiples, en bloc et d'échanges
           * Dans la fenêtre Ordres multiple qui est affichée, sélectionner le paramétre Source: Liste courante (Crochets)*/        
            
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Dans Comptes, sélectionner (en bleu et avec des crochets rouges) les comptes 800007-FS, 800057-FS et 800238-RE* Cliquer sur l'icône Ordres multiples, en bloc et d'échanges* Dans la fenêtre Ordres multiple qui est affichée, sélectionner le paramétre Source: Liste courante (Crochets)");     
          Log.Message("Choisir le module compte")  
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
          Log.Message("Sélectionner les comptes: "+account800057FS+", "+account800238RE+", "+account800007FS);
          var arrayOfAccountsNo= new Array(account800057FS,account800238RE,account800007FS);
          SelectAccounts(arrayOfAccountsNo);
          Get_RelationshipsClientsAccountsGrid().Keys("   ");
          Log.Message("Cliquer sur l'icône Ordres multiples, en bloc et d'échanges")
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          Log.Message(" Dans la fenêtre Ordres multiple qui est affichée, sélectionner le paramétre Source: Liste courante (Crochets)");
          Log.Message("Sélectionner dans sources 'Liste courante (Crochets)'")
          Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceTypeStep3],10).Click();  
          Log.Message("vérifier le nombre des élements sélectionnés avec crochets");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, selectionWithCheckMarkectStep3);
          
/************************************Étape 4************************************************************************/  
   
          /** Cliquer sur Ajouter pour ajouter des transactions
          *   Cliquer sur Aperçu*/        
            
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur Ajouter pour ajouter des transaction et Cliquer sur Aperçu"); 
          AddTransactionWinSwitchBlock(quantityTypeUnitPerAccount, DescriptionSecuritySymbolBBDB,cmbTypUnitsPerAccount,symbolBMO,market)
          AddTransactionWinSwitchBlock(quantityTypeUnitPerAccount, DescriptionSecuritySymbolBMO,cmbTypUnitsPerAccount,symbolRY,market)
          AddTransactionWinSwitchBlock(quantityTypeUnitPerAccount, DescriptionSecuritySymbolNA,cmbTypUnitsPerAccount,symbolBBDB,market)
          AddTransactionWinSwitchBlock(quantityTypeUnitPerAccount, DescriptionSecuritySymbolRY,cmbTypUnitsPerAccount,symbolNA,market)
          AddTransactionWinSwitchBlock(quantityTypeSecurityHeld, DescriptionSecuritySymbolTD,cmbTypeSecurityHeld,symbolTD,market)
          Get_WinSwitchBlock_BtnPreview().Click();
          
          if (Get_DlgConfirmation().Exists) //Ajouté par A.A
                Get_DlgConfirmation_BtnInclude().Click();
                
          WaitObject(Get_CroesusApp(),["ClrClassName", "Title","VisibleOnScreen"], ["BaseWindow", "Information", true]);
          
          Log.Message("Affichage des messages d'information:La position RY est bloquée dans le compte 800057-FS. Aucune transaction ne sera effectuée pour ce compte");          
          aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"WPFControlText", cmpEqual, textMessage2Step6 );
           
/************************************Étape 5************************************************************************/  
   
           /* Cliquer sur OK*/        
            
           Log.PopLogFolder();
           logEtape5 = Log.AppendFolder("Étape 5: Cliquer sur OK");
           Get_DlgInformation_BtnOK().Click(); 
//         étape 7 du cas pde test TCVE-2138
           var textMessageStep7=textMessage1Step7+"\r\n"+textMessage2Step7+"\r\n"+textMessage3Step7
           aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"WPFControlText", cmpEqual, textMessageStep7 );     
           
           
/************************************Étape 6************************************************************************/  
   
           /* Cliquer sur OK puis consulter les positions: BBD.B, BMO, RY et TD*/        
            
           Log.PopLogFolder();
           logEtape6 = Log.AppendFolder("Étape 6: Cliquer sur OK");              
           Get_DlgInformation_BtnOK().Click(); 
           Log.Message("Sana:On peut pas valider les icônes à partir de testcomplete");

           
/************************************Étape 7************************************************************************/  
   
           /*Déplacer les colonnes Inclure, (Icônes) et Messages*/        
            
           Log.PopLogFolder();
           logEtape7 = Log.AppendFolder("Étape 7: Déplacer les colonnes Inclure, (Icônes) et Messages"); 
           Get_WinSwitchBlock_DgvOrders_ChInclude().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
             
           Log.Message("Vérifier que les colonnes Include, Message et colonne d'icone sont fixe à droites")
           CheckColumFixedToRight(Get_WinSwitchBlock_DgvOrders_ChInclude())
           CheckColumFixedToRight(Get_WinSwitchBlock_DgvOrders_ChMessage())
           CheckColumFixedToRight(Get_WinSwitchBlock_DgvOrders_ChErrorIcone())
           
           Get_WinSwitchBlock_DgvOrders_ChInclude().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           
           Log.Message("Vérifier que les colonnes Include, Message et colonne d'icone sont fixe à gauche")
           CheckColumFixedToLeft(Get_WinSwitchBlock_DgvOrders_ChInclude())
           CheckColumFixedToLeft(Get_WinSwitchBlock_DgvOrders_ChMessage())
           CheckColumFixedToLeft(Get_WinSwitchBlock_DgvOrders_ChErrorIcone())
           
           
           Get_WinSwitchBlock_DgvOrders_ChInclude().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           
           Log.Message("Vérifier que les colonnes Include, Message et colonne d'icone sont mobiles")
           CheckColumMovable(Get_WinSwitchBlock_DgvOrders_ChInclude())
           CheckColumMovable(Get_WinSwitchBlock_DgvOrders_ChMessage())
           CheckColumMovable(Get_WinSwitchBlock_DgvOrders_ChErrorIcone()) 

                                   
       
           
/************************************Étape 8************************************************************************/  
   
           /*Clic droit ==>Configuration par défaut*/        
            
           Log.PopLogFolder();
           logEtape8 = Log.AppendFolder("Étape 8:Clic droit ==>Configuration par défaut"); 
           
           Get_WinSwitchBlock_DgvOrders_ChInclude().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
             
           Log.Message("Les colonnes sont placées à gauche dans l'ordre suivant:Inclure - (Icônes) - Messages")
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChInclude(), "WPFControlOrdinalNo", cmpEqual, 2);
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChMessage(), "WPFControlOrdinalNo", cmpEqual, 3);
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChErrorIcone(), "WPFControlOrdinalNo", cmpEqual, 1);

/************************************Étape 9************************************************************************/  
   
           /*Trier les colonnes Inclure, Icônes (sans titre) et Messages*/        
            
           Log.PopLogFolder();
           logEtape9 = Log.AppendFolder("Étape 9:Trier les colonnes Inclure, Icônes (sans titre) et Messages"); 
           
            Log.Message("Valider que la colonne Inlcure est triable");
            Get_WinSwitchBlock_DgvOrders_ChInclude().Click();
            if(Get_WinSwitchBlock_DgvOrders_ChInclude().SortStatus!="Descending"){
              Get_WinSwitchBlock_DgvOrders_ChInclude().Click();
            }
            aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChInclude(), "SortStatus", cmpEqual, "Descending");
            Get_WinSwitchBlock_DgvOrders_ChInclude().Click();
             if(Get_WinSwitchBlock_DgvOrders_ChInclude().SortStatus!="Ascending"){
              Get_WinSwitchBlock_DgvOrders_ChInclude().Click();
            }
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChInclude(), "SortStatus", cmpEqual, "Ascending");
          
           Log.Message("Valider que la colonne message est non triable");
           Get_WinSwitchBlock_DgvOrders_ChMessage().Click();
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChMessage(), "SortStatus", cmpEqual, "NotSorted");
           
           Log.Message("Valider que la colonne d'icôneest non triable");
           Get_WinSwitchBlock_DgvOrders_ChErrorIcone().Click();
           aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders_ChErrorIcone(), "SortStatus", cmpEqual, "NotSorted");
   

/************************************Étape 10************************************************************************/  
   
           /*Cliquer sur Générer*/        
            
           Log.PopLogFolder();
           logEtape10 = Log.AppendFolder("Étape 10:Cliquer sur Générer"); 
           Log.Message("La fenêtre du pop-up ne s'affiche pas dans la version 2020.08 (cette étape à valider sur la 2020.09)")  
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
           Get_WinSwitchBlock_BtnGenerate().Click();  
           var msgStep10 = msg1Step10 + "\r\n\t\r\n" +msg2Step10
           aqObject.CheckProperty( Get_DlgConfirmation_LblMessage2(), "Text", cmpEqual,msgStep10);



/************************************Étape 11************************************************************************/  
   
           /** Cliquer sur Oui* Dans l'accumulateur, appliquer le filtre "Type d'ordre parmi Au marché"*/        
            
           Log.PopLogFolder();
           logEtape11 = Log.AppendFolder("Étape 11:* Cliquer sur Oui* Dans l'accumulateur, appliquer le filtre Type d'ordre parmi Au marché"); 
           Get_DlgConfirmation_BtnYes().Click();
           Log.Message("Appliquer le filtre Type d'ordre parmi au marché")
           Get_OrderAccumulatorGrid().Click(Get_OrderAccumulatorGrid().get_ActualWidth()/95, Get_OrderAccumulatorGrid().get_ActualHeight()/80);
           Get_OrderAccumulatorGrid().Click(Get_OrderAccumulatorGrid().get_ActualWidth()/95, Get_OrderAccumulatorGrid().get_ActualHeight()/80);
           Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(typOrdreFiltre);
           Get_WinCreateFilter_CmbOperator().set_IsDropDownOpen(true);
           Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
           Get_WinCreateFilter().FindChild("Value", valueFiltreStep11, 10).Click();
           Log.Message("Jira GDO-3425:L'application crash avec le filtre Type d'ordre")
           Get_WinCreateFilter_BtnApply().Click();
           aqObject.CheckProperty(Get_OrderAccumulatorGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_OrderAccumulatorGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
           Log.Message("Les ordres sur les titres TD, BBD.B, NA et RY sont affichés dans l'accumulateur")
           var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count

           for(var i=0;i<count;i++){
             aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem, "PriceStr", cmpEqual,valueFiltreStep11);
             }
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,symbolTD);
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,symbolNA);
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "OrderSymbol", cmpEqual,symbolBBDB);
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "OrderSymbol", cmpEqual,symbolRY);
 
           Get_OrderAccumulatorGrid_BtnFilter_BtnRemove(1).Click();  
             
/************************************Étape 12************************************************************************/  
   
           /**Vérifier puis soumettre l'ordre de vente NA"*/        
            
           Log.PopLogFolder();
           logEtape12 = Log.AppendFolder("Étape 12:Vérifier puis soumettre l'ordre de vente NA"); 
//              
           Get_OrderAccumulatorGrid().FindChild("Value", symbolNA, 10).Click();
           Log.Message("Cliquer sur le bouton vérifier")
           Get_OrderAccumulator_BtnVerify().Click();
           Log.Message("Côcher la cas Inclure + Soumettre");
           Get_WinAccumulator().FindChild("Uid","IncludedKey",10).set_IsSelected(true);
           Get_WinAccumulator().FindChild("Uid","IncludedKey",10).Click();
           Get_WinAccumulator_BtnSubmit().Click(); 
           WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "BatchOrderVerificationWindow_342c");
           Log.Message("L'ordre de vente est passé au blotteur avec le statut En approbation")
           
           var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
           SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
           aqObject.CheckProperty(Get_OrderGrid().FindChild("Value",symbolNA,10).DataContext.DataItem, "Status", cmpEqual,statusApproval); 
           SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
           
/************************************Étape 13************************************************************************/  
   
           /* Consulter puis approver l'ordre de vente NA .Ajouter une exécution puis sauvegarder*/        
            
           Log.PopLogFolder();        
           logEtape13 = Log.AppendFolder("Étape 13:Consulter puis approver l'ordre de vente NA .Ajouter une exécution puis sauvegarder"); 
           var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
           SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
           Get_OrderGrid().FindChild("Value",symbolNA,10).Click();
           Log.Message("Approuver l'ordre") ;
           Get_OrdersBar_BtnView().Click();
           Get_WinOrderDetail_BtnApprove().Click();  
           Get_OrderGrid().FindChild("Value",symbolNA,10).Click();  
           SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
           Get_OrdersBar_BtnFills().Click();
           Get_WinOrderFills_GrpFills_BtnAdd().Click();        
           Get_WinAddOrderFill_TxtQuantity().Keys(valQuantity);
           Get_WinAddOrderFill_TxtClientPrice().Keys(price);       
           Get_WinAddOrderFill_CmbMarket().Click();
           Get_WinAddOrderFill_CmbMarket_ChBource().Click();
           Get_WinAddOrderFill_CmbOurRole().Click();
           Get_WinAddOrderFill_CmbOurRole_ChAgent().Click();
           Get_WinAddOrderFill_BtnOK().Click();
           Get_WinOrderFills_BtnSave().Click(); 
                


/************************************Étape 14************************************************************************/  
   
           /*Dans le blotteur, ajouter le filtre rapide "Symbole égalé NA" puis sauvegarder*/        
            
           Log.PopLogFolder();        
           logEtape14 = Log.AppendFolder("Étape 14:Dans le blotteur, ajouter le filtre rapide Symbole égalé NA puis sauvegarder"); 
 
           Log.Message("Ajouter le filtre rapide Symbole égalé NA puis sauvegarder");
            SetAutoTimeOut();
          		    var numberOftries=0; 
    		    while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
              Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click(); 
    		    numberOftries++;
            }
            RestoreAutoTimeOut();         
            Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
            Get_WinCRUFilter_TextName_ForOrdersAndSecurities().set_Text(filterNameStep14);
            Log.Message(" Sélectionner:Champ = Symbole");
            SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(),cmbFieldSymbolStep14);
            Log.Message(" Sélectionner:Opérateur = égale");
            SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(),cmbOperatorFiltrStep14);
            Get_WinAddFilter_GrpCondition_TxtValue().Set_Text(symbolNA);
            
            Log.Message("Appliquer le filtre")
            Get_WinAddFilter_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 120000);
            Delay (5000); //SA: la pause dynamique ne fonctionne pas
            var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
            SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
            Log.Message("Jira GDO_3271: L'application crash lorsqu'on applique un filtre dans le Blotteur")
              Log.Message("Le filtre retourne l'ordre exécuté NA")
              var count=Get_OrderGrid().RecordListControl.Items.Count
              if(count == 1)
              
                Log.Checkpoint("La grille contient un seul élément")
              
              else
              Log.Error("La grille ne contient pas un seul élément")
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,symbolNA);
              aqObject.CheckProperty(Get_OrderGrid().FindChild("Value",symbolNA,10).DataContext.DataItem, "Status", cmpEqual,stausPartialFill); 
           SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation

/************************************Étape 15************************************************************************/  
   
           /*Raffraichir puis modifier le filtre avec le gestionnaire de filtre: "Symbole n'égale pas NA"*/        
            
           Log.PopLogFolder();        
           logEtape15 = Log.AppendFolder("Étape 15:Raffraichir puis modifier le filtre avec le gestionnaire de filtre: Symbole n'égale pas NA"); 
           
           Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
           WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
           Get_OrderGrid().WaitProperty("IsEnabled",true,30000);
           var waitTime = 5000;
           
          Get_MenuBar_Search().Click();
          WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_79ff");
          Get_MenuBar_Search_QuickFilters().Click();
          Get_MenuBar_Search_QuickFilters_Manage().Click();
          WaitObject(Get_CroesusApp(),"Uid", "CFMenuItem_4c89");
          Get_WinQuickFiltersManager().WaitProperty("VisibleOnScreen", true, waitTime);
           
           
           
           Get_WinQuickFiltersManager().FindChild("WPFControlText",filterNameStep14,10).Click();
           Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Click();


            Get_WinCRUFilterForSecuritiesOrders_TxtName().set_Text(filterNameStep15);
            Log.Message(" Sélectionner:Champ = Symbole");
            SelectComboBoxItem(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbField(),cmbFieldSymbolStep14);
            Log.Message(" Sélectionner:Opérateur = n'égale pas");
            SelectComboBoxItem(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbOperator(),cmbOperatorFiltrStep15);

            Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue().Set_Text(symbolNA);
            
            Log.Message("Appliquer le filtre")
            Get_WinCRUFilterForSecuritiesOrders_BtnOK().Click();
           
           
           Get_WinQuickFiltersManager_BtnClose().Click()

           Log.Message("activer le filtre modifié")
           SetAutoTimeOut();
          		    var numberOftries=0; 
    		    while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
              Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click(); 
    		    numberOftries++;
            }
            RestoreAutoTimeOut();         
           Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", filterNameStep15 , 10).Click();

            var NbrItem = Get_OrderGrid().RecordListControl.Items.Count;
            Log.Message("Le nombre des ordres dans le blotteur est : "+NbrItem);
            for (var i=0; i<NbrItem; i++)
            {
              var symbolItemGril=Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol
              if(symbolItemGril == symbolNA){
              Log.Error("Le symbol NA se trouve dans la grille ");
              }
              else
              Log.Checkpoint("Le symbol NA ne se trouve pas dans la grille ")
            }
            
            //Fermer Croesus
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
            SetAutoTimeOut();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();

    }      
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         Terminate_CroesusProcess(); 
        
    }
    finally {   
        Terminate_CroesusProcess(); 
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");  
        Delete_FilterCriterion(filterNameStep15,vServerOrders)//Supprimer le filtre de BD   
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
        //Fermer Croesus
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
        Terminate_CroesusProcess(); 
        Runner.Stop(true);   

        
           
    }
 }

function SelectPosition(symbol,accountNumber){
    SearchAccountBySymbolInPortfolioGrid(symbol);  
          Log.Message("Sélectionner la position dont le symbole est "+symbol+" et dont le numéro de compte est "+accountNumber) 
          var lines =Get_Portfolio_Grid_VisibleLines();
           for (n=0 ; n< lines.length; n++){
             var accountNumberComp=VarToString(lines[n].dataContext.dataItem.AccountNumber.OleValue)
             var symbolComp=VarToString(lines[n].dataContext.dataItem.Symbol.OleValue)
        
               if(accountNumberComp == accountNumber && symbolComp == symbol   ){
                 
//                      
//                     Get_Portfolio_PositionsGrid().Items.Item(n).set_IsSelected(true);
//                      Get_Portfolio_PositionsGrid().Items.Item(n).set_IsActive(true)
                      Get_Portfolio_PositionsGrid().WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
           
              
           }   
           }
           
 function AddTransactionWinSwitchBlock(quantity, descriptionSecurity,typeQuantity,symbol,market)
 {



        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        
 
        Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
        Get_SubMenus().FindChild("WPFControlText",typeQuantity,10).Click();           
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        SetAutoTimeOut();
        if(Get_SubMenus().Exists){ 
        
        var Grid = Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1)
        var NbrItem=Grid.ChildCount;
        for (i=1;i<NbrItem;i++)
        {
             if (Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.MarketName == market && Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.Symbol == symbol)
            {
                Grid.WPFObject("DataRecordPresenter", "", i).DblClick();
                break;
            }
        }
        }
        RestoreAutoTimeOut();
        Get_WinSwitchSource_btnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");




 }

 function CheckColumFixedToRight(functionGetcolumn)
 {
           functionGetcolumn.ClickR();
           Get_GridHeader_ContextualMenu_ColumnStatus().Click();
           Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();
           Log.Message("Vérifier que l'État de la colonne  est : fixe à droite")
//           Vérifier que l'État de la colonne : fixe à droite
           aqObject.CheckProperty(functionGetcolumn, "IsFixed", cmpEqual,true);
           aqObject.CompareProperty(functionGetcolumn.Field.FixedLocation,cmpEqual,"FixedToFarEdge",true);
   

 }
 function CheckColumFixedToLeft(functionGetcolumn)
 {
           functionGetcolumn.ClickR();
           Get_GridHeader_ContextualMenu_ColumnStatus().Click();
           Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheLeft().Click();
           Log.Message("Vérifier que l'État de la colonne est: fixe à droite")
//        Vérifier que l'État de la colonne : fixe à gauche
           aqObject.CheckProperty(functionGetcolumn, "IsFixed", cmpEqual,true);
           aqObject.CompareProperty(functionGetcolumn.Field.FixedLocation,cmpEqual,"FixedToNearEdge",true);
   

 }
 
function CheckColumMovable(functionGetcolumn)
 {
           functionGetcolumn.ClickR();
           Get_GridHeader_ContextualMenu_ColumnStatus().Click();
           Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();
           Log.Message("Vérifier que l'État de la colonne est: mobile")
//        Vérifier que l'État de la colonne :mobile
           aqObject.CheckProperty(functionGetcolumn, "IsFixed", cmpEqual,false);
         

 } 
 
 
 /**
    Auteur : Christophe Paring
*/
function SetIsExpandedForAccumulatorAndLogExpanders(newStateAccumulatorExpander, newStateLogExpander)
{
    var executeSysRefresh = false;
    
    if (newStateAccumulatorExpander != undefined && newStateAccumulatorExpander != Get_OrderAccumulator().IsExpanded){
        Get_OrderAccumulator().set_IsExpanded(newStateAccumulatorExpander);
        executeSysRefresh = true;
    }
    
    if (newStateLogExpander != undefined && newStateLogExpander != Get_OrderLogExpander().IsExpanded){
        Get_OrderLogExpander().set_IsExpanded(newStateLogExpander);
        executeSysRefresh = true;
    }
    
    if (executeSysRefresh)
        Sys.Refresh();
}
 