//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Regroupement des cas de tests suivants:
        Croes_4233_Right_Clik_To_Add_Tra_To_External_Account
        Croes_1992_Add_Tra_To_External_Account
        Croes_1993_Edit_Tra_In_External_Account
        Croes_1994_Delete_Tra_In_External_Account *****Supprimé couvert par Croes-2024
        Croes_2024_Delete_N_Tra_In_External_Account
        Croes_2029_Validate_Canceled_Tra_Not_Modify
        Croes_1996_Tra_Copy_Paste_Into_Excel
        Croes_1997_Tra_Validate_Cancellation_Printing_Draft_Job
        Croes_2008_Tra_Check_Operation_All_Btn
        
        Lien: https://jira.croesus.com/browse/TCVE-4083
        
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
*/

function TCVE_4083_Transactions_External_Account()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-4083");

        var ClientName = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName4233", language+client);
        var TransType = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType4233", language+client);
        var TransAccount = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount4233", language+client);
        var TranSec = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec4233", language+client);
        var Quantity = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity4233", language+client);
        var Prix = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix4233", language+client);
        var Currency = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency4233", language+client);
        var Total = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total4233", language+client);
        var Commission = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission4233", language+client);
        var Quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity21993", language+client);
        var Prix2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix21993", language+client);
        var Currency = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency1993", language+client);
        var Commission2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission21993", language+client);
        
       
        Log.Message("Étape 1: Se loguer et créer un client externe");
        //Se loguer à Croesus Client avec le user COPERN
        Login(vServerTransactions, userName, psw, language);
        
        //Accéder au module Clients
        Get_ModulesBar_BtnClients().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");    //Wait Clients List View 
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        CreateExternalClient(ClientName);  //Create External Client
        
        
        Log.Message("Étape 2:  Ajouter des transactions dans un compte de client externe");
        Get_ModulesBar_BtnAccounts().Click();   
        ClickOnToolbarAddButton();   //Cliquer sur ajouter
        SelectClient(ClientName);   //Sélectionner le client
        Get_WinAccountInfo_BtnOK().Click();
       
        //Sélectionner le compte et le mailler vers Transactions
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();  //drag vers le module transaction
        
        ClickOnToolbarAddButton();  //Cliquer sur le bouton ajouter
        //Saisir le type de transaction (ex: Achat) le compte (celui créé), le titre (ex: Banque Nationale) et la quantité (ex 100) puis valider avec le bouton ok
        Create_Transaction(TransType, TransAccount, TranSec, Quantity, Prix, Currency);
        Delay(5000);

        Log.Message("Étape 3: Ajouter des transactions dans un compte de client externe par le right click*");
        //Faire un right click dans le browser, Ajouter
        Get_TransactionGridListView().ClickR();
        Get_Transactions_ContextualMenu_Add().Click();
        
        //Sélectionner le compte créé par liste offerte dans la boite à droite du champ Compte
        //Saisir le type de transaction (ex: Achat) le compte (celui créé), le titre (ex: MICROSOFT CORP) et la quantité (ex 150) puis valider avec le bouton ok
        Create_Transaction(TransType, TransAccount, TranSec, Quantity, Prix, Currency);
        Delay(5000);

        Log.Message("Étape 4:  Modifier la transaction");
        //Modifier une Transaction
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity2, Prix, Currency, "");
        Log.Message("Ce test risque d'échouer à cause de ce jira: PF-3141 - Message d'erreur lorsqu'on modifie une transaction d'un compte externe")
        Delay(3000);
        
        
        Log.Message("Étape 5: Suppression de plusieurs transactions à la fois")
        Delete_Transactions(TransAccount);   //Supprimer les deux Transactions
        Delay(3000);
        
        //Verifier la suppression des transactions        
        if(Get_Transactions_ListView().Exists && Get_Transactions_ListView().Items.Count > 0){
            Log.Error("PF-2958: On ne peut plus supprimer les transactions ajoutées à un client externe");
        }
        Delay(1000);
        
        Log.Message("Étape 6: Valider qu'une transaction annulée est non modifiable");
        ClickOnToolbarAddButton();
        //Saisir le type de transaction (ex: Achat) le compte (celui créé), le titre (ex: MICROSOFT CORP) et la quantité (ex 150) puis valider avec le bouton ok
        Create_Transaction(TransType, TransAccount, TranSec, Quantity, Prix, Currency);
        Delay(3000);
        
        Cancel_Transactions(TransAccount);   //Annuler les deux Transactions
        Delay(3000);
        
        //Vérifier la suppression de la transaction
        Get_TransactionsBar_BtnAll().Click();
        Get_TransactionsBar_BtnInfo().Click();
        //Les points de vérifications :  
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtQuantity(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtPrix(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_cmbCurrency(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtCommission(), "IsEnabled", cmpEqual, false);
        
        Get_WinEditTransaction_BtnOK().Click();
        Delay(3000);
        
        
        Log.Message("Étape 7: Cliquer Bouton 'Toutes'");
        //Cliquer sur le bouton réafficher en retirant les crochets
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_TransactionsBar_BtnAll().Click();
        Delay(3000);

        
        Log.Message("Étape 8: Copier et coller l'information du module Transactions dans Excel");
        copy_paste_into_excel();
        Delay(5000);
         
        
        Log.Message("Étape 9: Valider l'annulation de l'impression du brouillon de travail dans le module Transactions");
        Validate_Cancellation_Printing_Draft_Job();
     }
     catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    //Se loguer pour supprimer le client utilisé (remettre le tout comme avant)
    Login(vServerTransactions, userName, psw, language);
    DeleteClient(ClientName);
    
    Terminate_CroesusProcess(); //Fermer Croesus
  }
}


function SelectClient(ClientName)
{
    //Choisir un client et cliquer sur OK
    Sys.Keys(".");
    if (!Get_WinQuickSearch().Exists){
        Get_WinPickerWindow().Focus();
        Sys.Keys(".");
    }
    
    Get_WinClientsQuickSearch_RdoName().set_IsChecked(true);
    
    Get_WinQuickSearch_TxtSearch().SetText(ClientName);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow().FindChildEx("Value", ClientName, 10, true, 10000).Click();
    Get_WinPickerWindow_BtnOK().Click();
}


function copy_paste_into_excel()
{
    var CroesusRowCount = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CroesusRowCount1996", language+client);
    
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


function Validate_Cancellation_Printing_Draft_Job()
{
    //Wait Transactions List View 
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
    Delay(10000);
    //Set the default configuration of columns in the grid
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Delay(15000)
    // afficher la fenêtre « Print » avec AltP
    Get_Transactions_ListView().Click();
    Get_MainWindow().Keys("~p");
      
    if(!Get_DlgDefinePrintingType().Exists){ 
        Log.Error("On attente de loger un Jira. Il n'y a pas la fenêtre de choix de type d'impression.");
    }
  
    Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Click();
    Get_DlgDefinePrintingType_BtnOK().Click();
    //Les points de vérifications :  
    //Vérifier Boîte de dialogue impression
    aqObject.CheckProperty(Get_DlgPrint(), "Visible", cmpEqual, true);
        
    //Les points de vérification  
    Check_Print_Tra_Properties(language);
  
    //Get_DlgPrinting_BtnOKForTransactionsAndAgenda().Click();
    if(Get_DlgInformation().Exists){   
        var width = Get_DlgInformation().Get_Width();
        Get_DlgInformation().Click((width*(1/2)),73);
    }
}


function Check_Print_Tra_Properties(language)
{
    aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print"); // la langue est de VM est en anglais
    Get_DlgPrint_BtnCancel().Click();
  
    if(language == "french") {     
      aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Impression annulée");
    }

    if(language == "english") {      
      aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Printing cancelled");   
    }
}