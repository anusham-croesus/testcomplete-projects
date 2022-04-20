//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Regroupement des cas de tests suivants:
        Croes_2027_Tran_Search
        Croes_2001_Tra_Check_Info_For_Selected_Transaction
        Croes_1995_Verify_Account_Info_Selected_Tra *******Supprimé, couvert par Croes-2001
        Croes_4235_Add_Tra_To_Real_Account
        Croes_2011_Delete_Tra_In_Real_Account
        Croes_2012_Edit_Tra_In_Real_Account
        Croes_2023_Tra_Check_Operation_Position_Btn
        Croes_2016_Tran_Verify_Operation_Of_Configurable_Columns
        Croes_1998_Tra_DragSelection_In_All_Modules
        Croes_4231_Tra_DragSelection_In_All_
        
        Lien: https://jira.croesus.com/browse/TCVE-4084
        
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
    Scripté sur la version:  90.22.2020.12-56
*/



function TCVE_4084_Transactions_Real_Account()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-4084");

        //Mettre la pref "PREF_EDIT_TRANS" à la valeur YES
        Log.Message("Activation de la pref PREF_EDIT_TRANS (niveau utilisateur)");
        Activate_Inactivate_Pref(userName, "PREF_EDIT_TRANS", "YES", vServerTransactions);
        RestartServices(vServerTransactions);
             
        Login(vServerTransactions, userName, psw,language);
        Get_MainWindow().Maximize();
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("---- Étape 1: Effectuer une recherche dans le module Transactions ----");
        step1_Search_Transaction();        
        Delay(3000);
        
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("---- Étape 2:  Modifier des transactions dans un compte réel ----");
        step2_Edit_Transaction_In_Real_Account();
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("---- Étape 3:  Vérifier les informations pour la transaction sélectionnée ----");
        step3_validate_info_from_selected_transaction();
        Delay(3000);
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("---- Étape 4:  Vérifier l'ajout/Suppression des transactions dans un compte réel ----");
        step4_Validate_Adding_Deleting_Transaction_Real_Acc();
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("---- Étape 5:  Vérifier les informations de la fenêtre du bouton Positions ----");
        step5_Verify_Position_Btn_Info();
        Delay(3000);
        
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("---- Étape 6:  Copier plusieurs transactions avec Exporter vers Excel ----");
        step6_Copy_Paste_In_Excel();
        Delay(3000);
        
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("---- Étape 7:  Mailler dans les tout les modules à partir de Transactions ----");
        step7_Drag_Selection_Into_All_Modules();
        
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("---- Étape 8:  Mailler de tout les modules vers le module transactions ----");
        step8_Drag_All_Modules_To_Transactions();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        //Mettre la pref "PREF_EDIT_TRANS" à la valeur NO
        Log.Message("Désactivation de la pref PREF_EDIT_TRANS");
        Activate_Inactivate_Pref(userName, "PREF_EDIT_TRANS", "NO", vServerTransactions);
        RestartServices(vServerTransactions);
    }
}

function step1_Search_Transaction()
{
    var Compte = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2012", language+client);
    
    Get_ModulesBar_BtnTransactions().Click();
        
    //Wait Clients List View 
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
      
    Get_TransactionsBar().click();
    Search_Transactions_Account(Compte);
}


function step2_Edit_Transaction_In_Real_Account()
{
    var TranSec = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec2012", language+client);
    var TansType = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2012", language+client);
    var Quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity22012", language+client);
    var Quantity3 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity32012", language+client);
    var Prix = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2012", language+client);
    var Currency = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency2012", language+client);
    var Commission = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2012", language+client);
    var Compte = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2012", language+client);
        
    Get_ModulesBar_BtnClients().Click();
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");    //Wait Clients List View 
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
    SelectClients(["300001"]);
        
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();

    //Wait Transactions List View 
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
      
        
    //sélectionner première transaction et modifier
    Get_TransactionsBar_BtnInfo().Click();   //cliquer sur info
    Modifier_Une_Transaction(Quantity2, "55,000", Currency, "");
    
    //Les points de vérifications :  
    //Vérifier la modification du prix
    Validate_Edited_Transaction(Compte, TansType, TranSec, Quantity2, "55,000", Currency);
        
    Delay(3000);
}


function step3_validate_info_from_selected_transaction()
{
    var quant = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2001", language+client);
    var prix = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2001", language+client);
    var montantBrut = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix22001", language+client);
    var taux = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Taux2001", language+client);
    var interetCouru = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Interet2001", language+client);
    var commission = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2001", language+client);
    var frais = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Frais2001", language+client);
    var fraisCom = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "FraisComm2001", language+client);
    var montantNet = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MontantNet2001", language+client);
    var note = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note2001", language+client);
    var Client = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2001", language+client);
    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 150000);
        
    //Mailler Client vers Transaction
    Search_Client(Client);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
    
    //Selectionner la transaction
    if (language == "french") {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 25).Click();
    }
    else {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 48).Click();
    }
       
    //Verification:  Quantité, Montant Brut, taux, commission, frais, montant net
    Log.Message("Validation de la transaction sélectionnée");
    Verify_Transaction_Info(quant, prix, montantBrut, taux, interetCouru, commission, frais, fraisCom, montantNet, note)
}


function step4_Validate_Adding_Deleting_Transaction_Real_Acc()
{  
    //Vérifier que c'est Impossible d'ajouter une transaction car le bouton est grisée
    Log.Message("Vérification que le bouton (+) ajouter une transaction est grisée");
    aqObject.CheckProperty(Get_Toolbar_BtnAdd(), "IsEnabled", cmpEqual, false);
    
    //Vérifier la supprission de la transaction
    Log.Message("Vérification que le bouton (-) ajouter une transaction est grisée");
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(), "IsEnabled", cmpEqual, false);
}


function step5_Verify_Position_Btn_Info()
{
    var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2023", language+client);
    var Symbole=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbole2023", language+client);
    var Quantite =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantite2023", language+client);
    var Capital =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Capital2023", language+client);
    var Comptable =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Comptable2023", language+client); 
    
    //Selectionner la transaction
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        
    if (language == "french") {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 6).Click();
    }   

    //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter. 
    Get_TransactionsBar_BtnPosition().Click();
    WaitObject(Get_CroesusApp(), "Uid", "PositionInfo_75ee");   
     
    //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    Log.Message("Vérifier si 2 transactions sont affichées dans l'application sur le symbole 1CAD apparaît");
    aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "Text", cmpEqual, Quantite);
    aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "Text", cmpEqual, Capital);
    aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "Text", cmpEqual, Comptable);
            
    Get_WinPositionInfo_BtnOK().Click();
}


function step6_Copy_Paste_In_Excel()
{
    var CroesusRowCount = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CroesusRowCount1996", language+client);
    
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Get_TransactionsBar_BtnAll().Click();
    
    //fermer les fichiers excel
    CloseExcelProcess();
        
    // Les points de vérifications :  
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        
    Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    var tempClipboard = "Croes_1996_Tra_Copy_Paste_Into_Excel";
    Sys.Clipboard = tempClipboard;
        
    Sys.Keys("^c");
        
    var nbOfChecks = 0;
    while (nbOfChecks < 30 && Sys.Clipboard == tempClipboard){
        Delay(1000);
        nbOfChecks++;
    }
        
    //Paste in the Excel sheet
    objExcel = Sys.OleObject("Excel.Application");
    objExcel.Visible = true;
    objExcelWorkbook = objExcel.Workbooks.Add();
    Delay(10000);
    Sys.Keys("^v");
        
    excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
    Log.Message("excelRowCount= " + excelRowCount);
        
    //The row count in the Excel sheet should be the same as in Croesus
    if (CroesusRowCount == excelRowCount)
        Log.Checkpoint("The Excel row count equal to The Croesus row count: " + excelRowCount+" = "+CroesusRowCount);
    else  
        Log.Error("The Excel row count not equal to The Croesus row count: " + excelRowCount+" != "+CroesusRowCount);
        
    //fermer les fichiers excel
    CloseExcelProcess();

}


function step7_Drag_Selection_Into_All_Modules()
{
    var RelationshipsSum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RelationshipsSum1998", language+client);
    var ClientsSum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientsSum1998", language+client);
    var RelationshipsSum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RelationshipsSum1998", language+client);
    var SecuritySum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "SecuritySum1998", language+client);
    var PortfolioSum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PortfolioSum1998", language+client);
    var AccountsSum = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "AccountsSum1998", language+client);          

    Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 40);
    Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 148).Click();
    
    //--------   Mailler transaction vers module Relations ---------------
    Log.Message("-- Mailler une transaction vers Relations --");
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Relationships().Click();
    Get_MenuBar_Modules_Relationships_DragSelection().Click();
      
    //Les points de vérifications :  
    Get_MainWindow().Click();
    Get_MainWindow().Keys("^a");
    Get_Toolbar_BtnSum().Click();
    aqObject.CheckProperty(Get_WinRelationshipsSum_TxtNumberOfRelationshipsTotalCAD(), "Content", cmpEqual, RelationshipsSum);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    Delay("3000");
    
    
    //--------   Mailler transaction vers module Clients ---------------
    Log.Message("-- Mailler une transaction vers module Clients --");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
    
    //Mailler Transaction vers Clients
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click(); 
    Get_MenuBar_Modules_Clients_DragSelection().Click(); 
      
    //Les points de vérifications :  
    Get_MainWindow().Click();
    Get_MainWindow().Keys("^a");
    Get_Toolbar_BtnSum().Click();
    if (client != "CIBC")
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "Text", cmpEqual, ClientsSum);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    
    //--------   Mailler transaction vers module Comptes ---------------
    Log.Message("-- Mailler une transaction vers module Comptes --");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
    Delay(3000);
    
    //Mailler Transaction vers Comptes
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();  
    Get_MenuBar_Modules_Accounts_DragSelection().Click();  
      
    //Les points de vérifications :  
    Get_MainWindow().Click();
    Get_MainWindow().Keys("^a");
    Get_Toolbar_BtnSum().Click();
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "Content", cmpEqual, AccountsSum);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    
    //--------   Mailler transaction vers module Titres ---------------
    Log.Message("-- Mailler une transaction vers module Titres --");
    Get_ModulesBar_BtnTransactions().Click();     //cliquer sur module Transactions
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");  //Wait Clients List View 
      
    //Mailler Transaction vers Titres
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Securities().Click();
    Get_MenuBar_Modules_Securities_DragSelection().Click();
      
    //Les points de vérifications :  
    Get_MainWindow().Click();
    Get_MainWindow().Keys("^a");
    Get_Toolbar_BtnSum().Click();
    aqObject.CheckProperty(Get_WinSecuritySum().FindChild("Uid", "count", 10), "Content", cmpEqual, SecuritySum);
    Get_WinSecuritySum_BtnClose().Click();
    
        
    //--------   Mailler transaction vers module Portefeuille ---------------
    Log.Message("-- Mailler une transaction vers module Portefeuille --");
    Get_ModulesBar_BtnTransactions().Click();     //cliquer sur module Transactions
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");  //Wait Clients List View 
    Delay(3000);

    //Mailler Transaction vers Portefeuille
    Delay(3000) 
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();  
      
    //Les points de vérifications :  
    Get_MainWindow().Click();
    Get_MainWindow().Keys("^a");
    Get_Toolbar_BtnSum().Click();
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions(), "Text", cmpEqual, PortfolioSum);
    Get_WinPortfolioSum_BtnClose().Click();
    
    
    //--------   Mailler transaction vers module Modèles ---------------
    Log.Message("-- Mailler une transaction vers module Modèles --");
    Get_ModulesBar_BtnTransactions().Click();   //cliquer sur module Transactions
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); //Wait Clients List View 
    Delay(3000);
    
    //Mailler Transaction vers Modeles
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Models().Click();
    Get_MenuBar_Modules_Models_DragSelection().Click();
      
    //Les points de vérifications :  
    aqObject.CheckProperty(Get_Toolbar_BtnSum(), "IsEnabled", cmpEqual, false);
    
    
    //--------   Mailler transaction vers module Transactions ---------------
    Get_ModulesBar_BtnTransactions().Click();   //cliquer sur module Transactions
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); //Wait Clients List View 
    Delay(3000);
    
    //Mailler Transaction vers Transactions
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
    Delay(3000);
    
    //Une seule transaction dans la grid
    if(Get_Transactions_ListView().Exists && Get_Transactions_ListView().Items.Count == 0){
        Log.Error("Il doit y avoir au moins une transactions dans la liste.");
    }


}


function step8_Drag_All_Modules_To_Transactions()
{
    var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte4231", language+client);
    var Compte1=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte14231", language+client);
    var Compte2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte24231", language+client);
    var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName4231", language+client);
    var RelationName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RelationName4231", language+client);
    var ModeleName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ModeleName4231", language+client);
    var SecurityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "SecurityDescription4231", language+client);
    var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType4231", language+client);
    var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount4231", language+client);
    var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec4231", language+client);
    var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity4231", language+client);
    var Prix= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix4231", language+client);
    var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency4231", language+client);
    
    //Réinitialisation des modules (désactivation des filtres etc. )
    Log.Message("Désactivation des filtres sur tous les modules");
    Filters_deactivation();
    
        
    /****************************** Client Vers Transaction ******************************/
    Log.Message("-- Mailler un client vers le module Transactions --");
    //cliquer sur module Clients
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().Click();
    //Wait Clients List View 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
  
    //Mailler External Clients vers Transactions
    Search_AccountByName(ClientName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    /****************************** Les points de vérifications ******************************/ 
    aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
    /********************************* Fin de vérifications **********************************/    

        
    /****************************** Comptes Vers Transactions ******************************/ 
    Log.Message("-- Mailler un compte vers le module Transactions --");      
    //cliquer sur module Clients
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().Click();
    //Wait Clients List View 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
    //Mailler External Client vers Clients
    Search_AccountByName(ClientName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
    //Mailler External Comptes vers Transaction
    //Search_AccountByName(ClientName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    /****************************** Les points de vérifications ******************************/ 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
    aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
    /********************************* Fin de vérifications **********************************/  
        
  
    /****************************** Portefeuille Vers Transactions ******************************/       
    Log.Message("-- Mailler un portefeuille vers le module Transactions --");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().Click();
    //Wait Clients List View 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
    //Mailler External Client vers Clients
    Search_AccountByName(ClientName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
    //Mailler External Comptes vers Transaction
    //Search_AccountByName(ClientName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().WaitProperty("VisibleOnScreen","true",15000)
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    /****************************** Les points de vérifications ******************************/ 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
    aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
    /********************************* Fin de vérifications **********************************/  
        
        
        
    /****************************** Relations Vers Transactions ******************************/       
    Log.Message("-- Mailler une relation vers le module Transactions --");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().Click();
    //Mailler External Relation vers Transaction
    SearchRelationshipByName(RelationName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    /****************************** Les points de vérifications ******************************/ 
     WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
     if (client == "CIBC"){
          //Search_Transactions_Account(Compte1)
          aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte1);  
     }
     else
          aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte1);
    /********************************* Fin de vérifications **********************************/  

        
    /****************************** Modeles Vers Transactions ******************************/       
    Log.Message("-- Mailler un modèle vers le module Transactions --");
    
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().Click();
    
    //Mailler Relation vers Transaction
    SearchModelByName(ModeleName);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
        
    /****************************** Les points de vérifications ******************************/ 
    aqObject.CheckProperty(Get_MenuBar_Modules_Transactions_DragSelection(), "IsEnabled", cmpEqual, false);
    /********************************* Fin de vérifications **********************************/  
        
        
    /****************************** Titres Vers Transactions ******************************/       
    Log.Message("-- Mailler un titre vers le module Transactions --");
    
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().Click();

    WaitObject(Get_SecurityGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"]); //Wait Securities List View
        
    //Mailler External Comptes vers Transaction
    Search_SecurityByDescription(SecurityDescription);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    /****************************** Les points de vérifications ******************************/ 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
    aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte2);
    /********************************* Fin de vérifications **********************************/ 
}


function Filters_deactivation()
{
    //Description:  C'est une fonction qui enlève les filtres et les éléments avec les crochets
    
    Get_ModulesBar_BtnModels().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Clients
    Get_ModulesBar_BtnClients().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Comptes
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Relations
    Get_ModulesBar_BtnRelationships().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Transactions
    Get_ModulesBar_BtnTransactions().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay("3000");
    
    //Securities
    Get_ModulesBar_BtnSecurities().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
}


function Modifier_Une_Transaction(Quantity, Prix, Currency, Commission)
{
    if (Trim(VarToStr(Quantity)) !== ""){
      //Get_WinEditTransaction_GrpAmounts_TxtQuantity().Click();
      Get_WinEditTransaction_GrpAmounts_TxtQuantity().set_Text(Quantity);
    }  
    
    if (Trim(VarToStr(Prix)) !== ""){
      Get_WinEditTransaction_GrpAmounts_TxtPrix().Click();
      Get_WinEditTransaction_GrpAmounts_TxtPrix().set_Text(Prix);
    }

    if (Currency != undefined && Trim(VarToStr(Currency)) !== ""){
        Get_WinEditTransaction_GrpAmounts_cmbCurrency().Click(); 
        SetAutoTimeOut();
        if (Get_SubMenus().Exists){
            Get_SubMenus().Find("WPFControlText",Currency,10).Click();
        }
        else {
            Log.Message("The "+ Currency +" does not exist.");
        }
        RestoreAutoTimeOut();
    }
    
    if (Trim(VarToStr(Commission)) !== ""){
    Get_WinEditTransaction_GrpAmounts_TxtCommission().Click();
    Get_WinEditTransaction_GrpAmounts_TxtCommission().set_Text(Commission);
    }
    
    Get_WinEditTransaction_BtnOK().Click();
}

function Verify_Transaction_Info(Quantity, Prix, Prix2, Taux, Interet, Commission, Frais, FraisComm, MontantNet, Note)
{
    //Description:  Fonction qui valide les infos d'une transaction
    
    Get_TransactionsBar_BtnInfo().Click();
        
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbQuantity(), "Text", cmpEqual, Quantity);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCost(), "Text", cmpEqual, Prix);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtGrossAmount(), "Text", cmpEqual, Prix2);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbRate(), "Text", cmpEqual, Taux);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbAccruedInterest(), "Text", cmpEqual, Interet);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommission(), "Text", cmpEqual, Commission);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFees(), "Text", cmpEqual, Frais);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(), "Text", cmpEqual, FraisComm);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "Text", cmpEqual, MontantNet);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtNote(), "Text", cmpEqual, Note);
    
    Get_WinEditTransaction_BtnOK().Click();
}


function Validate_Edited_Transaction(TansAccount, TansType, TranSec, Quantity, Prix, Currency)
{
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, TansAccount);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 5), "Text", cmpEqual, TansType);
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, TranSec);
  //aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 7), "Text", cmpEqual, Quantity);
  //aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 8), "Text", cmpEqual, Prix+",000");
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 8), "Text", cmpEqual, Prix);     //Modifié par Amine A.
  aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 9), "Text", cmpEqual, Currency);
}

