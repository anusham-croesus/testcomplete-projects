//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0
//USEUNIT GDO_2464_Split_Of_BlockTrade


/* GDO Ajouter des ordres en bloc pour valider les colonnes: Valeur totale(CAD - USD) et Valeur totale en devise du compte  
https://jira.croesus.com/browse/TCVE-470
 
Analyste d'assurance qualité: Carole Turcotte
Analyste d'automatisation: Sana Ayaz*/ 
 
 function GDO_TCVE470_AddBulkOrderToValidatColumn()
 {             
    try{  
      
    
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-470","Lien de la story dans Jira");
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var account1                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_300005NA", language+client);
           var account2                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_300007NA", language+client);
           var account3                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_300006OB", language+client);
           var account4                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_300007OB", language+client);
           var cmbTransaction_TCVE470     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE470", language+client);
           var quantity_TCVE470           =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE470", language+client);
           var cmbTransactionType_TCVE470 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE470", language+client);
           var symbol_TCVE470             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE470", language+client);
           var descRY_TCVE470             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descRY_TCVE470", language+client);
           //Les variables de l'étape 4
           var value1DevisAccount         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value1DevisAccount", language+client);
           var value1CAD                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value1CAD", language+client);
           var value2DevisAccount         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value2DevisAccount", language+client);
           var value2CAD                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value2CAD", language+client);
           var value3DevisAccount         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value3DevisAccount", language+client);
           var value3CAD                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value3CAD", language+client);
           var value4DevisAccount         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value4DevisAccount", language+client);
           var value4CAD                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value4CAD", language+client);
           var symbolTCVE470Step5         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolTCVE470Step5", language+client);
           var securityTCVE470Step5       =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityTCVE470Step5", language+client);
           
            //Les variables de l'étape 5
           var value1DevisAccountStep5    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value1DevisAccountStep5", language+client);
           var value1USDStep5             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value1USDStep5", language+client);
           var value2DevisAccountStep5    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value2DevisAccountStep5", language+client);
           var value2USDStep5             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value2USDStep5", language+client);
           var value3DevisAccountStep5    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value3DevisAccountStep5", language+client);
           var value3USDStep5             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value3USDStep5", language+client);
           var value4DevisAccountStep5    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value4DevisAccountStep5", language+client);
           var value4USDStep5             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "value4USDStep5", language+client);
           
           //Les variables de l'étape 6
           var symbolTCVE470Step6         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolTCVE470Step6", language+client);
           var securityTCVE470Step6       =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityTCVE470Step6", language+client);
    
          //Les variables de l'étape 7
           var symbolTCVE470Step7         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolTCVE470Step6", language+client);
           var securityTCVE470Step7       =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securityTCVE470Step7", language+client);
      
//Étape1
     
           //Se connecter à croesus avec Keynej
           Log.Message("**********************************L'étape 1 du cas de test*********************************")
           Log.Message("Se connecter à croesus avec Keynej")
           Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();
       

           //Accéder au module compte
           Log.Message("Acceder au module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           
           //Sélectionner les comptes 300005-NA, 300006-OB,  300007-NA ET 300007-OB 
            Log.Message("Sélectionner les comptes 300005-NA, 300006-OB,  300007-NA ET 300007-OB ");
            var arrayOfAccountsNo= new Array(account1,account2,account3,account4)
            SelectAccounts(arrayOfAccountsNo)
           /* Cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)  */ 
           Get_Toolbar_BtnSwitchBlock().Click();
         
//Étape2    
           Log.Message("**********************************L'étape 2 du cas de test*********************************")  
           /*Dans la fenêtre choisir
              - transactions = Achat + Ajouter 
              - Quantité = 100
              - Unités par compte
              - Symbole = NA (BANQUE NATIONALE DU CDA)
               - OK*/   
           Log.Message("Dans la fenêtre choisir: - transactions = Achat  ")
           WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
           Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction_TCVE470],10).Click();
           Log.Message("Ajouter d'une transaction d'achat:- Quantité = 100- Unités par compte- Symbole = NA (BANQUE NATIONALE DU CDA)- OK")
           AddABuyBySymbol(quantity_TCVE470,cmbTransactionType_TCVE470,symbol_TCVE470);
           Log.Message("Cliquer sur Générer")
           Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
           Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true, maxWaitTime);
           Get_WinSwitchBlock().Click();
           Get_WinSwitchBlock_BtnGenerate().Click(); 
           if (Get_WinSwitchBlock().Exists)
             Get_WinSwitchBlock_BtnGenerate().Click();      
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");      
           WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd"); 
          
           //Les points de vérifications : L'ordre en bloc est envoyé dans l'accumulateur
           Log.Message("L'ordre en bloc est envoyé dans l'accumulateur")
           aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE470)*4,10).DataContext.DataItem, "SecurityDesc", cmpEqual,descRY_TCVE470 );
//Étape3    
           Log.Message("**********************************L'étape 3 du cas de test*********************************")  
           
          /*- Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.

          - Cliquer sur l'Onglet Comptes sous-jacents  */ 
          Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.")
          Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE470)*4,10).DblClick()
          Get_WinOrderDetail_TabUnderlyingAccounts().Click()
          Log.Message("la fenêtre détail de l'ordre s'ouvre  sous l'onglet Comptes sous-jacents")
         //Les points de vérifications
          aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts(), "IsSelected", cmpEqual, true);
//Étape4    
           Log.Message("**********************************L'étape 4 du cas de test*********************************")  
           Log.Message("Dans la section du bas valider les colonnes Valeur totale (CAD) Valeur totale en devise du compte")  
           
           
           /*L'onglet Comptes sous-jacents contient deux colonnes spécifiques:

            Colonne Valeur totale (CAD): tous les comptes affichent 5696,00

            Colonne Valeur totale en devise du compte: les comptes CAD affichent 5696,00; les comptes USD affichent 5381,20.
            */
            
            ValidateTotalValueDevise(value1DevisAccount,value1CAD,value2DevisAccount,value2CAD,value3DevisAccount,value3CAD,value4CAD,value4DevisAccount,account1,account2,account3,account4)
          
//Étape5    
            Log.Message("**********************************L'étape 5 du cas de test*********************************")  
            Log.Message(" Rester dans la fenêtre section du haut et modifier le symbole pour MSFT (MICROSOFT CORP)") 
           
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolTCVE470Step5)
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            SetAutoTimeOut();
             if(Get_SubMenus().Exists){  
              
               Get_SubMenus().Find("Value",securityTCVE470Step5,10).DblClick();
                                      }   
            RestoreAutoTimeOut();
            // Répondre ok au message
            Log.Message("Répondre ok au message")
            Get_DlgInformation_BtnOK().Click();  
            Log.Message("Colonne Valeur totale (USD): tous les comptes affichent 2932,00 Colonne Valeur totale en devise du compte: les comptes CAD affichent 3103,52; les comptes USD affichent 2932,00.")
            ValidateTotalValueDevise(value1DevisAccountStep5,value1USDStep5,value2DevisAccountStep5,value2USDStep5,value3DevisAccountStep5,value3USDStep5,value4DevisAccountStep5,value4USDStep5,account1,account2,account3,account4)
          
//Étape6    
            Log.Message("**********************************L'étape 6 du cas de test*********************************")          
            Log.Message("Rester dans la fenêtre section du haut et modifier le symbole titre RY, avec la bourse TSE)") 
          	Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Clear();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolTCVE470Step6)
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            SetAutoTimeOut();
             if(Get_SubMenus().Exists){  
             // Get_SubMenus().WPFObject("RecordListControl", "", 1).Items.Item(1).data
             // Get_SubMenus().Find("Value",securityTCVE470Step6,10).DblClick();
                Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).DblClick();
                                      }   
            RestoreAutoTimeOut();
            // Répondre ok au message
            Log.Message("Répondre ok au message")
            Get_DlgInformation_BtnOK().Click();  
            //Les points de vérifications:L'onglet Comptes sous-jacents contient la colonne suivante:Valeur totale (CAD)
            Log.Message("L'onglet Comptes sous-jacents contient la colonne suivante:Valeur totale (CAD)")
            Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Drag(338, 223, 247, -14);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValue(), "VisibleOnScreen", cmpEqual, true);
//Étape7    
            Log.Message("**********************************L'étape 7 du cas de test*********************************")    
            Log.Message("Rester dans la fenêtre section du haut et modifier le symbole titre RY, avec la bourse NYS)") 
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolTCVE470Step7)
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            SetAutoTimeOut();
                if(Get_SubMenus().Exists){  
              
                     Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).DblClick();
                                                }   
            RestoreAutoTimeOut();
            // Répondre ok au message
            Log.Message("Répondre ok au message")
            Get_DlgInformation_BtnOK().Click();  
            //Les points de vérifications:L'onglet Comptes sous-jacents contient la colonne suivante:Valeur totale (CAD)
            Log.Message("L'onglet Comptes sous-jacents contient la colonne suivante:Valeur totale (USD)")
            Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Drag(338, 223, 247, -14);
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValueUSD(), "VisibleOnScreen", cmpEqual, true);
          
  
         
    }
    catch(e) {
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
 
 
 
 
function ValidateTotalValueDevise(value1DevisAccount,value1CAD,value2DevisAccount,value2CAD,value3DevisAccount,value3CAD,value4CAD,value4DevisAccount,account1,account2,account3,account4)
{
  //Les points de vérifications pour le compte 300005-NA
  Log.Message("Les points de vérifications du compte 300005-NA")
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account1,10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual,value1DevisAccount);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account1,10).DataContext.DataItem, "ValueNeeded", cmpEqual,value1CAD);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account1,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value1CAD);
  
  Log.Message("Les points de vérifications du compte 300007-NA")
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account2,10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual,value2DevisAccount);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account2,10).DataContext.DataItem, "ValueNeeded", cmpEqual,value2CAD);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account2,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value2CAD);
  
  Log.Message("Les points de vérifications du compte 300006-OB")
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account3,10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual,value3DevisAccount);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account3,10).DataContext.DataItem, "ValueNeeded", cmpEqual,value3CAD);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account3,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value3CAD);
  
  Log.Message("Les points de vérifications du compte 300007-OB")
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account4,10).DataContext.DataItem, "ValueNeededNDWithAccountCurrency", cmpEqual,value4DevisAccount);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account4,10).DataContext.DataItem, "ValueNeeded", cmpEqual,value4CAD);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",account4,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value4CAD);
    
  
  
 }
