//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Ajouter des transactions dans un compte de client externe par le right clik
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4233
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_4233_Right_Clik_To_Add_Tra_To_External_Account()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4233");
  
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte4233", language+client);
        var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName4233", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType4233", language+client);
        var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount4233", language+client);
        var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec4233", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity4233", language+client);
        var Prix=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix4233", language+client);
        var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency4233", language+client);
        var Total=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total4233", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission4233", language+client);
        
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
        
        //Create Transaction
        Get_Transactions_ListView().ClickR();
        Log.Message("Bug JIRA PF-371 / QAV-746 : Crash l'application lorsqu'on ajoute une transaction sur un client externe.");
        var numberOftries = 0;
        while (numberOftries < 5 && !Get_Transactions_ContextualMenu().Exists){
            Get_Transactions_ListView().ClickR();
            numberOftries++;
        }
        
        Get_Transactions_ContextualMenu_Add().Click();
        Create_Transaction(TansType, TansAccount, TranSec, Quantity, Prix, Currency);
        
        
        //Les points de vérifications :  
        //Vérifier que la transaction est bien ajouté
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity, Prix, Currency, Total, Commission);

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
