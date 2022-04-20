//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1872_5755_ExtractOfRates_followedBy1stand2ndPhasefile_forPTFandNAVex
//USEUNIT GDO_TCVE_2474_AutomationOfJirasAndGDOStoryMergedInVersion2020_09



/**
    Module               :  Orders
    Jira                 :  TCVE-2138
    Description          :  Automatisation des stories (  GDO-2706, GDO-2693, GDO-2690, GDO-2689)

    
    Auteur               :  Sana Ayaz
    Version de scriptage :	90-18-2020-08-29
    date                 :  02-09-2020 
  
    
*/

function GDO_TCVE2138_ValidIncludBoxAndWarningMessages()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2173","Lien de la story dans Jira");
           //Lien du cas de test dans jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2138","Lien du cas de test dans Jira");
    
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
           var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
           
           
           var securitySymbolPreCond       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securitySymbolPreCond", language+client);
           var securityDescriptionRY       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityDescriptionRY", language+client);
           var securityDescriptionBMO      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityDescriptionBMO", language+client);
           var symbolSecuBBD               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolSecuBBD", language+client);
           var symbolSecuRY                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolSecuRY", language+client);
           var symbolSecuNA                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolSecuNA", language+client);
           var TCVE2138ValudecompteStep3   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE2138ValudecompteStep3", language+client);
           var securityDescriptionBBDB     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityDescriptionBBDB", language+client);
           var securityDescriptionNA       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityDescriptionNA", language+client);
           var textMessage1Step6           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage1Step6", language+client);    
           var textMessage2Step6           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage2Step6", language+client); 
           var textMessage1Step7           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage1Step7", language+client);    
           var textMessage2Step7           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage2Step7", language+client);
           var textMessage3Step7           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessage3Step7", language+client);
           var account800057FS             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800057FS", language+client);
           var account800238RE             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800238RE", language+client);
           var account800007FS             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800007FS", language+client);
           var QuantityTansactStep5        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityTansactStep5", language+client);
           var cmbTransactionStep5         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionStep5", language+client);
           var textMessageBBDStep8         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "textMessageBBDStep8", language+client);
           var QuantityBBDStep9            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityBBDStep9", language+client);
           var QuantityNAStep9             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityNAStep9", language+client);
           var QuantityRYStep9             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityRYStep9", language+client);
           var account800049OB             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800049OB", language+client);
           var symboleStep10               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symboleStep10", language+client);
           var quantityBuyStep10           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityBuyStep10", language+client); 
           var statusTraderApproval        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "statusTraderApproval", language+client); 
           var winTitle                    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailTitle", language+client);    
           var titleWinExecuStep13         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "titleWinExecuStep13", language+client);
           var descriptionTitStep13        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descriptionTitStep13", language+client);
           var valquantitStep14            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valquantitStep14", language+client);
           var valClientPriceStep14        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valClientPriceStep14", language+client);
           var valCPPriceStep14            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valCPPriceStep14", language+client);
           var rendementANNStep14          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "rendementANNStep14", language+client);
           var rendementSAStep14           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "rendementSAStep14", language+client);
           var marketStep14                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "marketStep14", language+client);
           var notreRoleStep14             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "notreRoleStep14", language+client);
           var inventoryCodeStep14         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "inventoryCodeStep14", language+client);
           var symbolBMO                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolBMO", language+client);
           var quantityTypeSecurityHeld         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTypeSecurityHeld", language+client);
           var DescriptionSecuritySymbolBBDB    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolBBDB", language+client);
           var DescriptionSecuritySymbolBMO     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolBMO", language+client);
           var DescriptionSecuritySymbolNA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolNA", language+client);
           var DescriptionSecuritySymbolRY      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "DescriptionSecuritySymbolRY", language+client);
           var cmbTypeSecurityHeld              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTypeSecurityHeld", language+client);
           var market                      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "market", language+client);
      
/************************************Préconditions************************************************************************/     
    Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
           /*Précondition: Se connecter avec le user UNI00, dans Titres rendre le titre BMO non rachetable*/
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Précondition: Se connecter avec le user UNI00, dans Titres rendre le titre BMO non rachetable");
          Log.Message("Se connecter à croesus avec UNI00")
          Login(vServerOrders, userNameUNI00, passwordUNI00, language);
          Get_MainWindow().Maximize();
          Log.Message("Clic sur le module titres")
          Get_ModulesBar_BtnSecurities().Click();
          Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
          Log.Message("Chercher le titre dont le symbole est BMO")
          Search_SecurityBySymbol(securitySymbolPreCond);
          Log.Message("Ouvrir la fenêtre info du titre dont le symbole et BMO")
          Get_SecurityGrid().Find("Value",securitySymbolPreCond,10).DblClick();
          Log.Message("Rendre le titre BMO non rachetable");
          Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(true);
          Get_WinInfoSecurity_BtnOK().Click();
          
          Log.Message("Aller au le module ordres pour vider l'accumulateur")
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 20000);
          
          //Vider l'accumulateur
          Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
          if(Get_OrderAccumulator_BtnDelete().Enabled){
              Get_OrderAccumulator_BtnDelete().Click();
              Get_DlgConfirmation_BtnDelete().Click();
          }
          //Fermer Croesus
          Close_Croesus_MenuBar();
          if(Get_DlgConfirmation().Exists)
              Get_DlgConfirmation_BtnYes().Click();    
/************************************Étape 1************************************************************************/     
           /*Se connecter avec le user KEYNEJ*/          
            
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user KEYNEJ");
          Log.Message("Se connecter avec le user KEYNEJ")
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          
/************************************Étape 2************************************************************************/     
           /*Atteindre le module Comptes puis mailler dans Portefeuille les comptes
            800057-FS, 800238-RE et 800007-FS
            Bloquer la position RY (quantité=850) dans le comptes 800057-FS 
            Bloquer la position BMO (quantité=175) dans le compte 800007-FS*/        
            
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Atteindre le module Comptes puis mailler dans Portefeuille les comptes 800057-FS, 800238-RE et 800007-FS Bloquer la position RY (quantité=850) dans le comptes 800057-FS Bloquer la position BMO (quantité=175) dans le compte 800007-FS");     
          Log.Message("Choisir le module compte")  
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
          Log.Message("Sélectionner les comptes: "+account800057FS+", "+account800238RE+", "+account800007FS);
          var arrayOfAccountsNo= new Array(account800057FS,account800238RE,account800007FS);
          SelectAccounts(arrayOfAccountsNo);
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
         //Rechercher le symbole BMO
          Log.Message("Bloquer la position BMO (quantité=175) dans le compte 800007-FS ")
          SelectPosition(securitySymbolPreCond,account800007FS) 
          Get_PortfolioBar_BtnInfo().Click();
          Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(true);
          Get_WinPositionInfo_BtnOK().Click();
/************************************Étape 3************************************************************************/  
   
           /*Sélectionner les positions:
              BBD.B dans le compte 800238-RE
              BMO dans les comptes 800057-FS, 800007-FS et 800238-RE
              NA dans le compte 800057-FS
              RY dans 800057-FS
              Dans la barre de menu, cliquer sur l'icône de Ordres multiple, en bloc et d'échanges*/        
            
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3: Sélectionner les positions:BBD.B dans le compte 800238-RE,BMO dans les comptes 800057-FS, 800007-FS et 800238-RE,NA dans le compte 800057-FS,RY dans 800057-FS.Dans la barre de menu, cliquer sur l'icône de Ordres multiple, en bloc et d'échanges");     
           Log.Message("Sélectionner les positions:BBD.B dans le compte 800238-RE,BMO dans les comptes 800057-FS, 800007-FS et 800238-RE,NA dans le compte 800057-FS,RY dans 800057-FS")
           Log.Message("Cliquer sur le bouton EDITION/annuler la sélection") 
           ExecuteActionAndExpectSubmenus(Get_MenuBar_Edit(), "Click");
//           Get_MenuBar_Edit().OpenMenu();
           Get_MenuBar_Edit_CancelSelection().Click();
           SelectPosition(symbolSecuBBD,account800238RE) 
          //Relâcher la touche CTRl enfoncée
           Sys.Desktop.KeyDown(0x11);
           SelectPosition(securitySymbolPreCond,account800057FS) 
           SelectPosition(securitySymbolPreCond,account800007FS)
           SelectPosition(securitySymbolPreCond,account800238RE)
           SelectPosition(symbolSecuNA,account800057FS)
           SelectPosition(symbolSecuRY,account800057FS)
           
           //Relâcher la touche ctrl enfoncée
           Sys.Desktop.KeyUp(0x11);
           Log.Message("Cliquer sur le bouton ordre multiple, en bloc et échange");
           Get_Toolbar_BtnSwitchBlock().Click();
           
           if (Get_DlgConfirmation().Exists) //Ajouté par A.A
                Get_DlgConfirmation_BtnInclude().Click();
                
           AddTransactionWinSwitchBlock(quantityTypeSecurityHeld, DescriptionSecuritySymbolBBDB,cmbTypeSecurityHeld,symbolBMO,market)
           AddTransactionWinSwitchBlock(quantityTypeSecurityHeld, DescriptionSecuritySymbolNA,cmbTypeSecurityHeld,symbolSecuBBD,market)
           AddTransactionWinSwitchBlock(quantityTypeSecurityHeld, DescriptionSecuritySymbolRY,cmbTypeSecurityHeld,symbolSecuNA,market)
           AddTransactionWinSwitchBlock(quantityTypeSecurityHeld, DescriptionSecuritySymbolBMO,cmbTypeSecurityHeld,symbolSecuRY,market)
           Log.Message("Les 4 titres sélectionnés sont dans l'encadré rose ")
           var countGridTransaction=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Count
           if(countGridTransaction == 4)
             Log.Checkpoint("Le nombre des titres affichés dans l'encadré rose est égale à 4")
           else
             Log.Error("Le nombre des titres affichés dans l'encadré rose n'est pas égale à 4")  
             
           aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescriptionBBDB,10).DataContext.DataItem, "SymbolDisplay", cmpContains,symbolSecuBBD);
           aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescriptionBMO,10).DataContext.DataItem, "SymbolDisplay", cmpContains,securitySymbolPreCond);
           aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescriptionNA,10).DataContext.DataItem, "SymbolDisplay", cmpContains,symbolSecuNA);
           aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescriptionRY,10).DataContext.DataItem, "SymbolDisplay", cmpContains,symbolSecuRY);
 
           Log.Message("Le décompte de Source indique 3 éléments")
           aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, TCVE2138ValudecompteStep3);
           
           
           
/************************************Étape 4************************************************************************/  
   
           /*Sélectionner tout les ordres affichés dans l'encadré rose, puis cliquer sur Modifier*/        
            
           Log.PopLogFolder();
           logEtape4 = Log.AppendFolder("Étape 4: Sélectionner tout les ordres affichés dans l'encadré rose, puis cliquer sur Modifier");   
           Log.Message("Sélectionnéer les 4 ordres qui sont dans l'encadrée rose")  
           Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescriptionBBDB,10).Click();     
           Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Keys("^a");
           Log.Message("Cliquer sur le bouton modifier")  
           Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();
           WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");

/************************************Étape 5************************************************************************/  
   
           /*Modifier la quantité à 1000 Unités par compte puis cliquer sur OK*/        
            
           Log.PopLogFolder();
           logEtape5 = Log.AppendFolder("Étape 5: Modifier la quantité à 1000 Unités par compte puis cliquer sur OK");  
           Get_WinSwitchSource_TxtQuantity().Clear();
           Get_WinSwitchSource_TxtQuantity().Keys(QuantityTansactStep5);
           Get_WinSwitchSource_CmbQuantity().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionStep5],10).Click();
           Get_WinSwitchSource_btnOK().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
  

/************************************Étape 6************************************************************************/  
   
           /*Cliquer sur Aperçu*/        
            
           Log.PopLogFolder();
           logEtape6 = Log.AppendFolder("Étape 6: Cliquer sur Aperçu");  
           Log.Message("Cliquer sur le bouton Aperçu") 
           Get_WinSwitchBlock_BtnPreview().Click();
           
           if (Get_DlgConfirmation().Exists) //Ajouté par A.A
                Get_DlgConfirmation_BtnInclude().Click();
                
           Log.Message("Affichage des messages d'information:La position BMO est bloquée pour le compte 800007-FS. Aucune transaction ne sera effectuée pour ce compte");
           var textMessageStep6=textMessage1Step6+"\r\n"+textMessage2Step6
           aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"WPFControlText", cmpEqual, textMessageStep6 );
           

/************************************Étape 7************************************************************************/  
   
           /* Cliquer sur OK*/        
            
           Log.PopLogFolder();
           logEtape7 = Log.AppendFolder("Étape 7: Cliquer sur OK");
           Get_DlgInformation_BtnOK().Click(); 
           Log.Message("Affichage des messages d'information:Le titre BMO est non rachetable. Aucune transaction ne sera effectuée pour le compte 800007-FS.Le titre BMO est non rachetable. Aucune transaction ne sera effectuée pour le compte 800057-FS.Le titre BMO est non rachetable. Aucune transaction ne sera effectuée pour le compte 800238-RE.");
           var textMessageStep7=textMessage1Step7+"\r\n"+textMessage2Step7+"\r\n"+textMessage3Step7
           aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"WPFControlText", cmpEqual, textMessageStep7 );     
           

/************************************Étape 8************************************************************************/  
   
           /* Cliquer sur OK*/        
            
           Log.PopLogFolder();
           logEtape8 = Log.AppendFolder("Étape 8: Cliquer sur OK");
           Get_DlgInformation_BtnOK().Click(); 
           Log.Message("Affichage des messages affichés dans l'encardré Ordes en bas de la fenêtre");
           var count = Get_WinSwitchBlock_DgvOrders().Items.Count;
           if(count == 12)
           Log.Checkpoint("La grille d'ordre contient 12 éléments")
           else 
           Log.Error("La grille d'ordre ne contient pas 12 éléments")
           
           for (i=0; i<count; i++){
              Log.Message("Le symbole est "+Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.Symbol.OleValue);
               //Points de vérifications pour le symbole BMO
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.Symbol.OleValue == securitySymbolPreCond ){
                     Log.Message("La case à côché de l'ordre dont le symbole BMO Inclure est décôchée")
                     aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, false);
                     aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsEnabled", cmpEqual, false);
                     //
                     if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800007FS)
                        aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessage1Step7);
                    //
                     if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800057FS)
                        aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessage2Step7);
                          
                    //
                     if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800238RE)
                        aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessage3Step7);
                            }
              // Points de vérifications pour le symbole BBD.B                          
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.Symbol.OleValue == symbolSecuBBD  ){
                 Log.Message("La case à côché de l'ordre dont le symbole BMO Inclure est côchée")
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
                 aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsEnabled", cmpEqual, false);
                  //
                  if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800007FS)
                        aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessageBBDStep8);
                    //
                  if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800057FS || Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800238RE)
                        aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, null);
                          
              }
              
              
               // Points de vérifications pour le symbole NA
              if (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.Symbol.OleValue == symbolSecuNA  ){
                Log.Message("La case à côché de l'ordre dont le symbole BMO Inclure est côchée")
                aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
                aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsEnabled", cmpEqual, false);
                aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessageBBDStep8);                 
              }
              
              
              // Points de vérifications pour le symbole RY 
              if  (Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.Symbol.OleValue == symbolSecuRY  ){
                 if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800007FS ||  Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800238RE)
                      {
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, true);
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsEnabled", cmpEqual, false);
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessageBBDStep8);      
                 }
                 
                  if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber.OleValue == account800057FS)
                      {
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsIncluded", cmpEqual, false);
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"IsEnabled", cmpEqual, false); 
                  aqObject.CheckProperty(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem,"Message", cmpEqual, textMessage2Step6);      
                 }
              }
              
           }
           
           
           
/************************************Étape 9************************************************************************/  
   
           /* Cliquer sur Générer*/        
            
           Log.PopLogFolder();
           logEtape9 = Log.AppendFolder("Étape 9: Cliquer sur Générer"); 
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000); 
           Get_WinSwitchBlock_BtnGenerate().Click();
           Log.Message("La fenêtre du pop-up ne s'affiche pas dans la version 2020.08 ")
          Get_DlgConfirmation_BtnYes1().Click();
           Log.Message("Les ordres sont envoyés dans l'accumulateur: BBD.B (quantité=3 000), NA (quantité=3 000) et RY(quantité=2 000)")     
          
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().Find("Value",symbolSecuBBD,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,QuantityBBDStep9); 
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().Find("Value",symbolSecuNA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,QuantityNAStep9);
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().Find("Value",symbolSecuRY,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,QuantityRYStep9);
           
/************************************Étape 10************************************************************************/  
   
           /* Dans le module Ordres, ajouter un ordre d'achat Revenus fixes*/        
            
           Log.PopLogFolder();
           logEtape10 = Log.AppendFolder("Étape 10: Dans le module Ordres, ajouter un ordre d'achat Revenus fixes");    
           Log.Message("Clic sur le bouton créer un ordre d'achat")
           Get_Toolbar_BtnCreateABuyOrder().Click();
        
            //Selectioner 'Revenue fixe'
            Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
               
           
            //Remplir les details de l'ordre
        
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account800049OB)
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
            Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantityBuyStep10);
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symboleStep10)
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            
/************************************Étape 11************************************************************************/  
   
           /*Cliquer sur Vérifier puis Soumettre*/        
            
           Log.PopLogFolder();
           logEtape11 = Log.AppendFolder("Étape 11: Cliquer sur Vérifier puis Soumettre");    
                  
            //Vérifier et soumettre
            Get_WinOrderDetail_BtnVerify().Click();
            if (language == "french") WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Soumettre"]);
            else WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Submit"]);
            Get_WinOrderDetail_BtnVerify().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            Log.Message("L'ordre est passé au blotteur avec le statut En approbation")
            //Format date
            if (language == "french")
                var dateFormat = "%Y/%m/%d";
            else
                var dateFormat = "%m/%d/%Y";
            CheckOrderStatus(symboleStep10, statusTraderApproval, dateFormat)    
/************************************Étape 12************************************************************************/  
   
           /*Sélectionner l'ordre puis cliquer sur Consulter*/        
            
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12: Sélectionner l'ordre puis cliquer sur Consulter");   
            var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
            SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
            ReduceColumnsHeadersWidthToMaxValue(); //Christophe : Stabilisation
            if (Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat),10).DataContext.DataItem.OrderSymbol == symboleStep10){
                Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat),10).Click();              
            }
            SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
           
           Get_OrdersBar_BtnView().Click();  
           aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains,winTitle);
/************************************Étape 13************************************************************************/  
   
           /*Approuvé l'ordre*/        
            
           Log.PopLogFolder();
           logEtape13 = Log.AppendFolder("Étape 13: Approuvé l'ordre");    
      
           Get_WinOrderDetail_BtnApprove().Click();
           aqObject.CheckProperty(Get_WinOrderFills(), "Title", cmpContains,titleWinExecuStep13+descriptionTitStep13)
/************************************Étape 14************************************************************************/  
   
           /*Ajouter une exécution puis cliquer sur OK et Sauvegardé*/        
            
           Log.PopLogFolder();
           logEtape14 = Log.AppendFolder("Étape 14: Ajouter une exécution puis cliquer sur OK et Sauvegardé");    

           Get_WinOrderFills_GrpFills_BtnAdd().Click();        
           Get_WinAddOrderFill_TxtQuantity().Keys(valquantitStep14);
           Get_WinAddOrderFill_TxtClientPrice().Keys(valClientPriceStep14); 
           Get_WinAddOrderFill_TxtIAPrice().Keys(valCPPriceStep14);    
           Get_WinAddOrderFill_TxtYieldANN().set_Value(rendementANNStep14);
           Get_WinAddOrderFill_TxtYieldSA().set_Value(rendementSAStep14);
           Get_WinAddOrderFill_CmbMarket().set_Text(marketStep14); 
           Get_WinAddOrderFill_CmbOurRole().set_Text(notreRoleStep14);
           Get_WinAddOrderFill_CmbInvetoryCode().set_Text(inventoryCodeStep14);
           Get_WinAddOrderFill_BtnOK().Click();
           Get_WinOrderFills_BtnSave().Click(); 
/************************************Étape 15************************************************************************/  
   
           /*Sous WinScp, définir un dossier-cible:Exemple:
                    home/karimamo*/        
            
           Log.PopLogFolder();
           logEtape15 = Log.AppendFolder("Étape 15: Sous WinScp, définir un dossier-cible:Exemple:home/alhassaned/loader/CR2080/");

/************************************Étape 16************************************************************************/  
   
///           Dans Putty:Se mettre sur le répértoire déjà défini cd /home/sana/       
            
           Log.PopLogFolder();
           logEtape16 = Log.AppendFolder("Étape 16:Dans Putty:Se mettre sur le répértoire déjà défini cd home/alhassaned/loader/CR2080/");        
/************************************Étape 17************************************************************************/ 
   
//           /Générer le fichier:cfLoader -PhaseOneGenerator -Firm=FIRM_1/*/        
            
           Log.PopLogFolder();
           logEtape17 = Log.AppendFolder("Étape 17:Générer le fichier:cfLoader -PhaseOneGenerator -Firm=FIRM_1");     
           
           //Vider le dossier dans le vseveur
           ExecuteSSHCommand("CR2080", vServerOrders, "rm -f /home/alhassaned/loader/CR2080/*.*", "alhassaned");
           //Générer le fichier PhaseOne
           ExecuteSSHCommandCFLoader("CR2080", vServerOrders, "cfLoader -PhaseOneGenerator -Firm=FIRM_1", "alhassaned");
/************************************Étape 18************************************************************************/ 
   /*Valider que la colonne 13 de la 2ém ligne affiche le code inventaire AH*/        

          Log.PopLogFolder();
          logEtape18 = Log.AppendFolder("Étape 18:Valider que la colonne 13 de la 2ém ligne affiche le code inventaire AH");  

          
          var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d")       

          var refFile = "CR_CROESUS_TRADING_REF.raw";
          var FileNameContains = "CR_CROESUS_TRADING"+date+"*";     
    	    var generatedFileName = "CR_CROESUS_TRADING"+date+".raw";     
          var resultServerFilePath = "/home/alhassaned/loader/CR2080/"+FileNameContains;
          var refFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\TCVE2138\\";
          var sshCommand = "cfLoader -PhaseOneGenerator -FIRM=FIRM_1";
          var ResultlocalFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\TCVE2138\\"; 
          var resultLocalFilePath = ResultlocalFolder + generatedFileName;
          
          //Copier le fichier en local
          Log.Message("-- Copy Result File From Vserver.")   
          if (!CopyFileFromVserverThroughWinSCP(vServerOrders, resultServerFilePath, resultLocalFilePath))
              Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand);
/*     
          //Comparer les deux fichiers
          Log.Message("-- Check data of generated file "+generatedFileName+" with reference file data "+refFile+" for sshCommand = ",sshCommand);
          Log.Warning("++ Dans la comparaison de deux fichiers, On tient pas compte de la première ligne dans la comparaison car la date n'est pas fixe. Ainsi que toutes les dates car ils sont pas fixes.")
		      CompareTxtFiles(refFolder,refFile,ResultlocalFolder, generatedFileName);
 */         
          //Ajoutée par A.A, date: 03-03-2021, version ref90-22-2020-12-77--V9-croesus-co7x-2_1_758, TCVE-4638
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 44, "AH");
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 45, "P");  
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 13, "");  



        }

          
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");  
        Log.Message("Choisir le module compte")  
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        Log.Message("Sélectionner les comptes: "+account800057FS+", "+account800238RE+", "+account800007FS);
        var arrayOfAccountsNo= new Array(account800057FS,account800238RE,account800007FS);
        SelectAccounts(arrayOfAccountsNo);
        Log.Message("Mailler dans Portefeuille les comptes");
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        Log.Message("Bloquer la position RY (quantité=850) dans le comptes 800057-FS ")
           
       
          SelectPosition(symbolSecuRY,account800057FS)
          Get_PortfolioBar_BtnInfo().Click();
          Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(false);
          Get_WinPositionInfo_BtnOK().Click();
         //Rechercher le symbole BMO
          Log.Message("Bloquer la position BMO (quantité=175) dans le compte 800007-FS ")
          SelectPosition(securitySymbolPreCond,account800007FS) 
          Get_PortfolioBar_BtnInfo().Click();
          Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(false);
          Get_WinPositionInfo_BtnOK().Click();     
        Terminate_CroesusProcess();       
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        Runner.Stop(true);   

        
           
    }
 }
 
 function test(){
   
  
          var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d")       

          var refFile = "CR_CROESUS_TRADING_REF.raw";
          var FileNameContains = "CR_CROESUS_TRADING"+date+"*";     
    	    var generatedFileName = "CR_CROESUS_TRADING20210901.txt";     
          var resultServerFilePath = "/home/alhassaned/loader/CR2080/"+FileNameContains;
          var refFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\TCVE2138\\";
          var sshCommand = "cfLoader -PhaseOneGenerator -FIRM=FIRM_1";
          var ResultlocalFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\TCVE2138\\"; 
          var resultLocalFilePath = ResultlocalFolder + generatedFileName;
          
  //Ajoutée par A.A, date: 03-03-2021, version ref90-22-2020-12-77--V9-croesus-co7x-2_1_758, TCVE-4638
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 44, "AH");
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 45, "P");  
          ReadTextFromFile(ResultlocalFolder, generatedFileName, 5, 13, "");  

 
 
 }
 
function ReadTextFromFile(filePath, FileName, line, colonne, inventoryCode)
{ 
      var filePathraw = filePath + FileName
      var filePathtxt = filePath + aqString.Replace(FileName, "raw", "txt");
      
      
      
      //Supprimer l'existant
      if(aqFile.Exists(filePathtxt) && aqFile.Exists(filePathraw))
          aqFile.Delete(filePathtxt);
          
      //Renommer le fichier .raw en .txt
      if(aqFile.Exists(filePathraw))
          aqFile.Rename(filePathraw, filePathtxt);
          
      
      
      // Opens the specified file for reading
      var myFile = aqFile.OpenTextFile(filePathtxt, aqFile.faRead, aqFile.ctANSI);

      //se positionner sur la 2eme ligne
      myFile.SetPosition(line, 0);

      secondLine = myFile.ReadLine();
      Log.Message(secondLine);
    
      var secondLineArray = secondLine.split("|");
      var inventCode = secondLineArray[colonne - 1];
      Log.Message("code inventaire de la colonne: "+colonne +" est : "+ inventCode);
        
      if(inventCode == inventoryCode)    
          Log.Checkpoint("le code inventaire "+ inventoryCode+ " se trouve dans la ligne: "+ line+ " colonne: "+ colonne);
      else
            Log.Error("le code inventaire "+ inventoryCode+ " ne se trouve pas à la bonne place ou pas présent")

      // Closes the file
      myFile.Close();
} 
 
 
function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
            
        var nbOfTries = 0;
        do {
            Sys.Refresh();
            
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
        
        } while (++nbOfTries < maxNbOfTries && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!Get_SubMenus().Exists || !Get_SubMenus().VisibleOnScreen) Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
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


/**
    Auteur : Christophe Paring
*/
function ReduceColumnsHeadersWidthToMaxValue(maxWidth)
{
    maxWidth = (maxWidth == undefined)? 60: maxWidth;
    
    maxLoops = 3;
    for (var k = 1; k <= maxLoops; k++){
        var allDisplayedHeaders = Get_OrderGrid().FindAllChildren(["ClrClassName", "WPFControlText", "VisibleOnScreen"], ["LabelPresenter", "*", true], 10).toArray();
    
        //Reorder objects from left most to right most
        var orderedDisplayedHeaders = [];
        while (orderedDisplayedHeaders.length < allDisplayedHeaders.length){
            var leftMostIndex = null;
            for (var j = 0; j < allDisplayedHeaders.length; j++){
                if (allDisplayedHeaders[j] !== null && (leftMostIndex === null || allDisplayedHeaders[j].ScreenLeft < allDisplayedHeaders[leftMostIndex].ScreenLeft))
                    leftMostIndex = j;
            }
            orderedDisplayedHeaders.push(allDisplayedHeaders[leftMostIndex]);
            allDisplayedHeaders[leftMostIndex] = null;
        }
    
        //Modify width if necessary
        var isHeaderWidthReduced = false;
        for (var i = 0; i < (orderedDisplayedHeaders.length-1); i++){
            if (Trim(orderedDisplayedHeaders[i].WPFControlText) != "" && orderedDisplayedHeaders[i].Width > maxWidth){
                var fromX = orderedDisplayedHeaders[i].ScreenLeft + orderedDisplayedHeaders[i].Width;
                var fromY = orderedDisplayedHeaders[i].ScreenTop + orderedDisplayedHeaders[i].Height/2 - 1;
                var toX = fromX - (orderedDisplayedHeaders[i].Width - maxWidth);
                var toY = fromY;
            
                LLPlayer.MouseDown(MK_LBUTTON, fromX, fromY, 200);
                LLPlayer.MouseMove(toX, toY, 500)
                LLPlayer.MouseUp(MK_LBUTTON, toX, toY, 300);
                isHeaderWidthReduced = true;
            }
        }
        
        if (isHeaderWidthReduced)
            Sys.Refresh();
        else
            break;
    }
}
