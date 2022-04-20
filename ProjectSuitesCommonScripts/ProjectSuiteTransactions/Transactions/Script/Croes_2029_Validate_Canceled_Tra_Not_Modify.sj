﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider qu'une transaction annulée est non modifiable
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2029
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2029_Validate_Canceled_Tra_Not_Modify()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2027");

        var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName2029", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2029", language+client);
        var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount2029", language+client);
        var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec2029", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2029", language+client);
        var Prix=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2029", language+client);
        var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency2029", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2029", language+client);
        var Total=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total12029", language+client);
        
        Login(vServerTransactions, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        //Create External Client
        CreateExternalClient(ClientName)
        
        //Mailler External Client vers Transaction
        SearchClientByName(ClientName);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
        //Create Account
        Get_RelationshipsClientsAccountsGrid().ClickR();
        Get_AccountsGrid_ContextualMenu_Add().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        //cliquer sur module Clients
        Get_ModulesBar_BtnClients().Click();
        
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        //Mailler External Client vers Transaction
        SearchClientByName(ClientName);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Create Transaction
        Get_Toolbar_BtnAdd().Click();
        Log.Message("Bug JIRA PF-371 / QAV-746 : Crash l'application lorsqu'on ajoute une transaction sur un client externe.");
        var numberOftries = 0;
        while (numberOftries < 5 && !Get_WinAddTransaction().Exists){
            Get_Toolbar_BtnAdd().Click(); 
            numberOftries++;
        }
        
        Get_WinAddTransaction().WaitProperty("VisibleOnCreen",true,15000)
        WaitObject(Get_WinAddTransaction(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"]);
        
        Create_Transaction(TansType, TansAccount, TranSec, Quantity, Prix, Currency);

        //Les points de vérifications :  
        //Vérifier que la transaction est bien ajouté
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity, Prix, Currency, Total, Commission);
       
        //Annuler les deux Transactions
        Cancel_Transactions(TansAccount);

        //Les points de vérifications :  
        //Vérifier la supprission de la transaction
        Get_TransactionsBar_BtnAll().Click();
        Get_TransactionsBar_BtnInfo().Click();
        
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtQuantity(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtPrix(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_cmbCurrency(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinEditTransaction_GrpAmounts_TxtCommission(), "IsEnabled", cmpEqual, false);
        
        Get_WinEditTransaction_BtnOK().Click();
        
        //Supprimer les deux Transactions
        Delete_Transactions(TansAccount);
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        Delay(1500)
        //cliquer sur module Clients
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        //supprimer le client cree 
        DeleteClient(ClientName); 

      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerTransactions, userName, psw, language);
        DeleteClient(ClientName);
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }      
}

