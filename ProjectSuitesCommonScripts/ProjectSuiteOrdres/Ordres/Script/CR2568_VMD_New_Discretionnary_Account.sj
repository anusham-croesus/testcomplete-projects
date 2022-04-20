//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : En tant que VMD, je veux que croesus ajoute le type de compte GERGDF comme discrétionnaire 
                  afin de pouvoir transiger sur ces comptes.
    
    
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
    Date: 30 juillet 2021
    version: 90.25.2021.06-77
*/


function CR2568_VMD_New_Discretionnary_Account()
{
    try {  
        
        //Lien de la story et du cas X-Ray
        Log.Link("https://jira.croesus.com/browse/ORC-2882","Lien du jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-6821","Lien du cas X-ray");   
        Log.Link("https://jira.croesus.com/browse/TCVE-6842","Lien de la story");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var account        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_Account", language+client);
        var symbol         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_OrderSymbol", language+client);
        var secDescription = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_OrderSecDesc", language+client);
        var orderQty       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_OrderQuantity", language+client);
        var kycFeeBasedType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_KYCFeeBasedType", language+client);

        
        Log.PopLogFolder();
        logStep2 = Log.AppendFolder("-- Étape 2:  Valider compte discrétionnaire --");
        
        // * Ouvrir croesus client avec KEYNEJ
        Log.Message("Se loguer à Croesus avec l'utilisateur " + userNameKEYNEJ);
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
        
        Log.Message("Accéder au Module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);

        // * Dans le module compte, ajouter la colonne Discrétionnaire
        Log.Message("Ajout de la colonne 'Discrétionnaire'");
        if(!Get_AccountsGrid_ChDiscretionary().Exists){
            Get_AccountsGrid_ChName().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Get_GridHeader_ContextualMenu_AddColumn_Discretionary().Click();
        }
        
        
        // * Ouvrir l'info compte 800228-RE, onglet Profil
        Log.Message("Sélectionner le compte " + account + ", valider compte discrétionnaire.");
        SearchAccount(account);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
        
        // * Valider que le compte 800228-RE est discrétionnaire (crochet dans la colonne Discrétionnaire)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 14), "HasContent", cmpEqual, true);
        
        Log.Message("Aller dans l'onglet 'Profil' de la fenêtre Info et valider le 'KYC-Type honoraires'.")
        Get_AccountsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        
        if (!(Get_WinAccountInfo_TabProfile_DefaultExpander().IsExpanded))
            Get_WinAccountInfo_TabProfile_DefaultExpander().Click();
        

        // * Valider que la valeur du champ profil 'KYC Type honoraire' est 'GERGDF'
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtKYCFeeBasedType(), "Text", cmpEqual, kycFeeBasedType);
        Get_WinDetailedInfo_BtnCancel().Click();
        
        Log.PopLogFolder();
        logStep3 = Log.AppendFolder("-- Étape 3: Créer ordre d'achat pour compte " + account + " et valider si il n'y a aucun message d'erreur bloquant. --");
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
        Create_Buy_Order(orderQty, secDescription, symbol);
        
    }
     catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logStep4 = Log.AppendFolder("-- Étape 4: Vider l'accumulateur --");
        //Supprimer les ordres dans l'accumulateur
        var DeleteAllOrdersQuerryString = "delete from B_GDO_ORDER where STATUS=70";
        Execute_SQLQuery(DeleteAllOrdersQuerryString, vServerOrders);
        
        Log.PopLogFolder();
        logCloseCroesus = Log.AppendFolder("---- Fermeture de Croesus ----");
       
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}



function Create_Buy_Order(quantity, securityDescription, symbol)
{ 
    //Creation de l'ordre
    Log.Message("-- Création d'un ordre d'achat: Symbole: " + symbol + " --");
    
    
    //Click sur ordre d'achat
    Log.Message("Cliquer sur créer ordre d'achat et choisir le type de 'Actions'");
    Get_Toolbar_BtnCreateABuyOrder().Click();
    WaitObject(Get_CroesusApp(),"Uid", "FinancialInstrumentSelector_c84d");
    
    //Cliquer sur Actions
    Get_WinFinancialInstrumentSelector_RdoStocks().Click();
    
    //Cliquer sur OK
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
           
    
    //Selectionner security='MSFT'dont la bourse est TSE, quantité = 10, 
    Log.Message("Selectionner symbole = 'MSFT' et quantité = 10");
    Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(symbol))!== ""){  
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(symbol);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
    }
      
    if(Get_SubMenus().Exists){  
        Aliases.CroesusApp.subMenus.Find("Value", symbol, quantity).DblClick();
    }
      
    Log.Message("Cliquer sur Vérifier et Sauvegarder par la suite.");   
    Get_WinOrderDetail_BtnVerify().Click();
    //Vérifier qu'il n'y a pas de messages bloquants
    Validate_Verification();
    
    Get_WinOrderDetail_BtnSave().Click();

}


function Validate_Verification()
{
    var i = 0;
    
    for (i=0 ; i < Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Count; i++) {
        if (Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Level == "Bloquant") {
            Log.Error("Il y a la présence d'un message bloquant");
            break
        }
    }
}