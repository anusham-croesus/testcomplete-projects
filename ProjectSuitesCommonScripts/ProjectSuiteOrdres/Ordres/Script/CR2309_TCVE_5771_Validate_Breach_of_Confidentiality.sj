//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    Automatisation de la story ORC-2372 pour BNC.  Il faut s'assurer que nos tests autos couvrent la fonction 
    Bris de confidentialités
    
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
    Date: 29 juin 2021
    version: 90.24.2021.04-120 (révisé à la version 90.24.2021.04-143)
*/


function CR2903_TCVE_5771_Validate_Breach_of_Confidentiality()
{
    try {  
        
        //Lien de la story et du cas X-Ray
        Log.Link("https://jira.croesus.com/browse/TCVE-5771","Lien du cas X-ray");   
        Log.Link("https://jira.croesus.com/browse/TCVE-6182","Lien de la story");
        
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        var userNameLYNCHJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "username");
        var passwordLYNCHJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "psw");
        
        var accountList1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_accounts1", language + client);
        var accounts1  = accountList1.split("|");
        var accountList2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_accounts2", language + client);
        var accounts2  = accountList2.split("|");
        
        var symbolNA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_SymbolNA", language + client);
        var descNA   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_DescNA", language + client);
        var qtyNA   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_QtyNA", language + client);
        var orderNAValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_OrderNAValue", language + client);
        
        var symbolMSFT = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_SymbolMSFT", language + client);
        var descMSFT = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_DescMSFT", language + client);
        var qtyMSFT = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_QtyMSFT", language + client);
        var orderMSFTValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_OrderMSFTValue", language + client);
        var orderMSFTNewValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_OrderMSFTNewValue", language + client);
        var orderMSFTNewValue2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_OrderMSFTNewValue2", language + client);
        
        var symbolAAPL = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_SymbolAAPL", language + client);
        var descAAPL = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_DescAAPL", language + client);
        var qtyAAPL = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_QtyAAPL", language + client);
        var orderAAPLValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_OrderAAPLValue", language + client);
        
        var acc800232NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_Acc800232NA", language + client);
        var acc800300NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_Acc800300NA", language + client);
        var acc800228RE = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_Acc800228RE", language + client);
        
        var level = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_Level", language + client);
        var msgBloquant = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_Message1", language + client);
        
        var transTypeSell = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_TransTypeSell", language + client);
        var transTypeBuy = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_TransTypeBuy", language + client);
        
        
        //Préconditions
        Log.PopLogFolder();
        logPreconditions = Log.AppendFolder("Préconditions: exécution des scripts SQL");
        Pre_Conditions();
        
        //-- ÉTAPE 1 --
        //Activation des PREFS
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 1: Activation des PREFS");
        Activate_Inactivate_Pref("COPERN", "PREF_GDO_VALIDATE_ASC_CODE", 2, vServerOrders);
        Activate_Inactivate_Pref("GP1859", "PREF_GDO_VALIDATE_ASC_CODE", 2, vServerOrders);
        RestartServices(vServerOrders);
        
        
        Log.Message("Se loguer à Croesus avec l'utilisateur " + userNameGP1859);
        Login(vServerOrders, userNameGP1859, passwordGP1859, language);
        Get_MainWindow().Maximize();
        
        //--ÉTAPE 1.1 --
        // Vider l'accumulateur
        Log.PopLogFolder();
        logEmptyAccumulator = Log.AppendFolder("Étape 1.1: Vider l'accumulateur");
        Empty_Accumulator();
        
        
        //-- ÉTAPE 2 --
        //Click le module compte et création des ordres multiples
        Log.PopLogFolder();
        logCreateMultipleOrders = Log.AppendFolder("Étape 2: Recherche des comptes et création des ordres multiples");
        Log.Message("Selectionner les comptes 800228-RE, 800217-SF, 800300-N et 800232-NA");
        Select_Multiple_Accounts(accounts1);
        Create_Multiple_Order(qtyMSFT, descMSFT, symbolMSFT, transTypeSell);  //Creation d'un ordre multiple
        
        //Acceder au Module Comptes
        Log.Message("Acceder au Module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        Create_Multiple_Order(qtyNA, descNA, symbolNA, transTypeSell);  //Creation d'un ordre multiple
        
         //Acceder au Module Comptes
        Log.Message("Acceder au Module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);

        Log.Message("Selectionner les comptes 800228-RE, 800217-SF, 800300-NA, 800232-NA et 800265-LY");
        Select_Multiple_Accounts(accounts2);        
        Create_Multiple_Order(qtyAAPL, descAAPL, symbolAAPL, transTypeBuy);  //Creation d'un ordre multiple
        

        
        //-- ÉTAPE 3 --
        Log.PopLogFolder();
        logValidationQuantity = Log.AppendFolder("Étape 3: Modification de l'ordre MSFT avec COPERN.");
        Log.Message("Se loguer à Croesus avec l'utilisateur " + userNameCOPERN);
        Login(vServerOrders, userNameCOPERN, passwordCOPERN, language);
        
        Log.Message("Aller dans le module Ordres.");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
        
        //Sélectionner ordre et modifier
        Edit_Order(orderMSFTValue, acc800232NA, orderMSFTNewValue);

        
        
        //-- ÉTAPE 4 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 4: Vérifier ordre MSFT et Soumettre");
        
        //Sélectionner l'ordre dans l'accumulateur
        Log.Message("Sélectionner l'ordre MSFT dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderMSFTNewValue2, 10).Click();
        
        Get_OrderAccumulator_BtnVerify().Click();  //Vérifier 
        //soumettre
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();

        
        
        //-- ÉTAPE 5 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 5: Modifier ordre AAPL"); 
        
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
        //Sélectionner l'ordre dans l'accumulateur
        Log.Message("Sélectionner l'ordre dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderAAPLValue, 10).DblClick();
        WaitObject(Get_WinOrderDetail(), "Uid", "TabControl_2c50");
        
        //Sélectionner le compte dans la grille
        Get_WinOrderDetail_TabUnderlyingAccounts().Click();
        Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", acc800300NA, 100).Click();
        
        //Nouveau comportement à partir de la version 2021.04-133 (Bouton "Modifier" et "Vérifier" sont grisés)
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(),"IsEnabled", cmpEqual, false);
        
        //Sauvegarder
        Get_WinOrderDetail_BtnCancel().Click(); 
        
        
        
        //-- ÉTAPE 6 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 6: COPERN n'a plus le droit de modifier un ordre de GP1859");
        Log.Message("Modification de la PREF 'PREF_GDO_VALIDATE_ASC_CODE' à 1 pour COPERN") 
        Activate_Inactivate_Pref("COPERN", "PREF_GDO_VALIDATE_ASC_CODE", 1, vServerOrders);
        RestartServices(vServerOrders);
        
        
       
        //-- ÉTAPE 7 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 7: Modification de la quantité du compte dans l'ordre NA par COPERN"); 
        Log.Message("Se loguer à Croesus avec l'utilisateur " + userNameCOPERN);
        Login(vServerOrders, userNameCOPERN, passwordCOPERN, language);
        
        Log.Message("Aller dans le module Ordres.");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
        
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
        //Sélectionner l'ordre dans l'accumulateur
        Log.Message("Sélectionner l'ordre NA dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderNAValue, 10).DblClick();
        WaitObject(Get_WinOrderDetail(), "Uid", "TabControl_2c50");
        
        //Sélectionner le compte dans la grille
        Get_WinOrderDetail_TabUnderlyingAccounts().Click();
        Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", acc800228RE, 100).Click();
    
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(),"IsEnabled", cmpEqual, false);
         
        //Cliquer sur le bouton annuler
        Get_WinOrderDetail_BtnCancel().Click();
        
        
        
        //-- ÉTAPE 8 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 8: Vérification de l'ordre NA");
        
        //Sélectionner l'ordre dans l'accumulateur
        Log.Message("Sélectionner l'ordre NA dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderNAValue, 10).Click();
        
        Get_OrderAccumulator_BtnVerify().Click(); //Vérifier l'ordre
        
        //Valider le message "Ordre en lecture seule"
        Log.Message("Valider les messages d'avertissement après le clic sur vérifier");
        aqObject.CheckProperty(Get_WinAccumulator().Find("Uid", "GroupBox_1c98", 10).Find(["ClrClassName","WPFControlOrdinalNo"],["ListBoxItem","1"],10).DataContext, "Message", cmpEqual, "L'ordre est en lecture seule.");
        

        
        //-- ÉTAPE 9 --
        Log.PopLogFolder();
        logPrefsActivation = Log.AppendFolder("Étape 9: Cas où un firmadmin ne peut modifier un ordre de GP1859"); 
        Activate_Inactivate_Pref("LYNCHJ", "PREF_GDO_VALIDATE_ASC_CODE", 1, vServerOrders);
        RestartServices(vServerOrders);
        
        Log.Message("Se loguer à Croesus avec l'utilisateur " + userNameLYNCHJ);
        Login(vServerOrders, userNameLYNCHJ, passwordLYNCHJ, language);
        
        Log.Message("Aller dans le module Ordres.");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
        
        //Sélection de l'ordre NA
        Log.Message("Sélectionner l'ordre NA dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderNAValue, 10).DblClick();
        WaitObject(Get_WinOrderDetail(), "Uid", "TabControl_2c50");
        
        //Sélectionner un compte dans la grille
        Get_WinOrderDetail_TabUnderlyingAccounts().Click();
        Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", acc800228RE, 100).Click();
        //Vérification:  bouton Modifier et Vérifier sont grisés
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(),"IsEnabled", cmpEqual, false);
        
        //Quitter la fenêtre - Cliquer sur le bouton annuler
        Get_WinOrderDetail_BtnCancel().Click();
        
        //Sélectionner l'ordre NA 
        Log.Message("Sélectionner l'ordre NA dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", orderNAValue, 10).Click();
        //Vérifier
        Get_OrderAccumulator_BtnVerify().Click(); //Vérifier l'ordre
        
        //Cocher la case
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        
        //Avertissement
        if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive){
            Log.Message("Message d'avertissement est apparu!");
            Get_DlgWarning().Keys("[Enter]");  //Fermer la fenêtre
        }
        else
            Log.Error("Un message d'avertissement doit apparaître!");        
    }
     catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logCleanUp = Log.AppendFolder("---- Fermeture de Croesus ----");
       
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}




function Pre_Conditions()
{
    var query="update b_compte set is_discretionary = 'N' where no_compte = '800232-NA'";
    Log.Message("Rendre le compte '800232-NA' non-discretionnaire");
    Execute_SQLQuery(query, vServerOrders);
        
        
    var query2= "update b_compte set TYPE2='991999999990' where NO_COMPTE = '800228-RE'\r\n" +
    "update b_compte set TYPE2='992999999990' where NO_COMPTE = '800217-SF'\r\n" +
    "update b_compte set TYPE2='991599999990' where NO_COMPTE = '800300-NA'\r\n" +
    "update b_compte set TYPE2='991699999990' where NO_COMPTE = '800232-NA'\r\n" +
    "update b_compte set TYPE2='991999999990' where NO_COMPTE = '800265-LY'\r\n";                  
    Execute_SQLQuery(query2, vServerOrders);
    RestartServices(vServerOrders);
}


function Empty_Accumulator()
{
    Log.Message("Aller dans le module Ordres.");
    Get_ModulesBar_BtnOrders().Click();
    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
    
    if (Get_OrderAccumulatorGrid().RecordListControl.Items.Count > 0) {
        Get_OrderAccumulatorGrid().Keys("^a");
        
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
}


function Select_Multiple_Accounts(accounts)
{
    //Acceder au Module Compte
    Log.Message("Accéder au module Compte");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    
    Log.Message("Nombre de comptes dans liste: " + accounts.length);

    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (i = 0; i < accounts.length; i++) {
         SearchAccount(accounts[i]);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", accounts[i], 10).Click(-1, -1, skCtrl);
    }
}


function Create_Multiple_Order(quantity, securityDescription, symbol, transType)
{ 
    var qtyType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_QtyType", language + client);

    //Creation de l'ordre
    Log.PopLogFolder();
    logCreationMultipleOrder = Log.AppendFolder("---- Création d'un ordre multiple: Symbole: " + symbol + " ----");
    
    //Click sur ordre multiple
    Log.Message("Cliquer sur ordre multiple et choisir le type de transaction (Vente)");
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transType);
    
           
    //Ajout d'une transaction(s)
    Log.Message("Ajout d'une transaction de " + transType);
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                    
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    Get_WinSwitchSource_CmbSecurity().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
           
    Log.Message("Entrer les informations:  Quantité = " + quantity + " unités par compte");
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_WinSwitchSource_TxtQuantity().Keys(quantity);
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_SubMenus().Find("WPFControlText", qtyType, 10).Click();
    
    Log.Message("Entrer les informations:  Description = " + securityDescription );
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", symbol, 10).DblClick();
    }
    
    Get_WinSwitchSource_btnOK().Click();
                      
    Log.Message("Cliquer sur Aperçu et Générer par la suite.");                
    Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
    Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 2000);
    Get_WinSwitchBlock_BtnGenerate().Click();
    
    //si il y a fenêtre pour confirmation ici
    if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation_BtnYes().Click();
    }
}


function Edit_Order(quantity, account, newValue)
{
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Sélectionner l'ordre dans l'accumulateur
    Log.Message("Sélectionner l'ordre dans l'accumulateur.");
    Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", quantity, 10).DblClick();
    WaitObject(Get_WinOrderDetail(), "Uid", "TabControl_2c50");
        
    //Sélectionner le compte dans la grille
    Get_WinOrderDetail_TabUnderlyingAccounts().Click();
    Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", account, 100).Click();
        
    //Modifier
    Log.Message("Cliquer sur le bouton Modifier");
    Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click();
    
    //Modification de la valeur du champ "Quantité"
    Log.Message("Modifier la quantité");
    Get_WinEditQuantity_TxtRequestedQuantity().Keys(newValue);
    Get_WinEditQuantity_BtnOK().Click();
        
    //Sauvegarder
    Get_WinOrderDetail_BtnSave().Click(); 
}