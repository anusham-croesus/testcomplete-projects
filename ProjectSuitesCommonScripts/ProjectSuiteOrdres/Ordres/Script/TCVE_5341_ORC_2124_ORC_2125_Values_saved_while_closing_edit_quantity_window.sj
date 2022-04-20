//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    
    ORC-2125
    Créer un ordre dans l’accumulateur avec la quantité :200
    Cliquer sur le bouton ‘Modifier’
    La fenêtre modification quantité s’ouvre.
    Saisir une valeur  invalide 999999999
    Cliquer sur (X)
    Cliquer à nouveau sur modifier
    La valeur est sauvegardée = 0
    Fermer la fenêtre est cliquer sur le bouton ‘Sauvegarder ‘
    La quantité 0 est bien reflétée sur l’ordre      

    ORC-2124
    Après la modification de la quantité si l'utilisateur décide de ne pas garder cette 
    information il clique sur la (X) la quantité est toujours sauvegardée.
    
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Philippe Maurice
    Date: 20 avril 2021
    version: 90.25-48
*/


function TCVE_5341_ORC_2124_ORC_2125_Values_saved_while_closing_edit_quantity_window()
{
    try{  
        
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-5341","Lien de la story dans Jira");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_Account", language + client);
        var account2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2124_Account", language + client);
        var invalidValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_InvalidValue", language + client);
        var editValue = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2124_EditValue", language + client);
        var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_Qty", language + client);
        var quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2124_Qty", language + client);
        var secDescription = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_SecDescription", language + client);
        var secDescription2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2124_SecDescription", language + client);
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_Symbol", language + client);
        var symbol2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2124_Symbol", language + client);
        
        Log.Message("Se loguer à Croesus");
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
        
        
        //Click le module compte et création des ordres multiples
        Log.PopLogFolder();
        logCreateMultipleOrders = Log.AppendFolder("Recherche des comptes et création des ordres multiples");        
        createMultipleOrder(account, quantity, secDescription, symbol);
        createMultipleOrder(account2, quantity2, secDescription2, symbol2);
        
        
        Log.PopLogFolder();
        logValidationQuantity = Log.AppendFolder("---- Validation de la quantité. ----");
        Log.Message("Aller dans le module Ordres.");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
        
        validationQuantity(account, quantity, secDescription, invalidValue);
        validationQuantity(account2, quantity2, secDescription2, editValue);
        
    }
     catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logCleanUp = Log.AppendFolder("---- Suppression des ordres et fermeture de Croesus ----");
        deleteOrder(quantity);
        deleteOrder(quantity2);
       
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}


function createMultipleOrder(account, quantity, securityDescription, symbol)
{    
    var transaction = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_transactionType", language + client);
    var qtyType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_QtyType", language + client);
    
    
    Log.Message("Aller dans le module Comptes et rechercher le compte " + account + ".");
    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
    //recherche un compte
    Search_Account(account);
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
    Get_RelationshipsClientsAccountsGrid().Find("Value", account, 100).Click();
        
    //Creation de l'ordre
    Log.PopLogFolder();
    logCreationMultipleOrder = Log.AppendFolder("---- Création d'un ordre multiple: Symbole: " + symbol + "  Compte: " + account + " ----");
    
    //Click sur ordre multiple
    Log.Message("Cliquer sur ordre multiple et choisir le type de transaction (Vente)");
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
                    
    //Ajout d'une transaction(s):Vente 
    Log.Message("Ajout d'une transaction de vente")
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();                 
         
    Log.Message("Entrer les informations:  Quantité = " + quantity + " unités par compte");
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_WinSwitchSource_TxtQuantity().set_Text(quantity);
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_SubMenus().Find("WPFControlText", qtyType, 10).Click();
    
    Log.Message("Entrer les informations:  Description = " + securityDescription );
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    //Get_WinSwitchSource_CmbSecurity().Click();
    //Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click(); 
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Click();     
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().set_Text(symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", securityDescription, 10).DblClick();
    }
    Get_WinSwitchSource_GrpPosition_TxtSecurity().WaitProperty("IsEnabled", true, 30000);
    Get_WinSwitchSource_GrpPosition_TxtPrice().WaitProperty("IsEnabled", true, 30000);    
    
    Get_WinSwitchSource_btnOK().WaitProperty("IsEnabled", true, 30000);
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

function validationQuantity(account, quantity, secDescription,  newValue)
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
        
    //Fermer la fenêtre
    Log.Message("Fermer la fenêtre");
    Get_WinEditQuantity().Close();
        
    //Modifier
    Log.Message("Cliquer sur le bouton Modifier (après avoir cancellé la modification");
    Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click();
         
    //Quantité requise = quantité (validation)
    aqObject.CheckProperty(Get_WinEditQuantity_TxtRequestedQuantity(), "Value", cmpEqual, quantity);
        
    //Fermer
    Get_WinEditQuantity().Close();
        
    //Sauvegarder
    Get_WinOrderDetail_BtnSave().Click(); 
         
    //Sélectionner l'ordre 
    Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", quantity, 10).DblClick();
    WaitObject(Get_WinOrderDetail(),"Uid", "TabControl_2c50");
        
    //Valider la quantité dans la partie vente d'actions
    aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtQuantity(),"Value", cmpEqual, quantity);
    Get_WinOrderDetail_BtnCancel().Click();
}


function deleteOrder(quantity)
{
    Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", quantity, 10).Click();
    Get_OrderAccumulator_BtnDelete().Click();
        
    if(Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
}

//function selectAnOrderWithQuantity(symbol, quantity)
//{
//    var grid = Get_OrderAccumulatorGrid().RecordListControl;
//    var count = grid.Items.Count;
//    var found = false;
//    var i = 1;
//    while (i < count && found == false){
//        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && (grid.Items.Item(i).DataItem.Quantity == quantity)) {
//            Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Click();
//            found = true;
//        }
//        i = i + 1;
//    }
//    if (found == false)
//        Log.Error("L'ordre n'existe pas dans la grille");
//}