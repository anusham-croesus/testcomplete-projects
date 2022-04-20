//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier les informations compte pour la transaction sélectionnée 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1993
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1993_Edit_Tra_In_External_Account()
{
  try {
    
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1993");
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte1993", language+client);
        var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName1993", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType1993", language+client);
        var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount1993", language+client);
        var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec1993", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity1993", language+client);
        var Quantity2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity21993", language+client);
        var Prix=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix1993", language+client);
        var Prix2= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix21993", language+client);
        var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency1993", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission1993", language+client);
        var Commission2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission21993", language+client);
        var Total1=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total11993", language+client);
        var Total2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total21993", language+client);
        var Total3=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total31993", language+client);
        var Total4=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total41993", language+client);
        
        var PrixAffiche = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PrixAffiche1993", language+client);     //Ajouté par Amine A.
        var PrixAffiche2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PrixAffiche21993", language+client);
        
        
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
        
        //Create Transaction
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        Delay(5000);
        Get_Toolbar_BtnAdd().Click();
        Log.Message("Bug JIRA PF-371 / QAV-746 : Crash l'application lorsqu'on ajoute une transaction sur un client externe.");
        var numberOftries = 0;  
        while (numberOftries < 5 && !Get_WinDetailedInfo().Exists){
            Get_Toolbar_BtnAdd().Click(); 
            numberOftries++;
        }
        
        Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 30000);
        Create_Transaction(TansType, TansAccount, TranSec, Quantity, Prix, Currency);
        
        
        //Les points de vérifications :  
        //Vérifier que la transaction est bien ajouté
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity, PrixAffiche, Currency, Total1, Commission2);

        //Modifier une Transaction
        // la quantite
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity2, Prix, Currency, "");
        
        //Les points de vérifications :  
        //Vérifier la modification de la quantite
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity2, PrixAffiche, Currency, Total2, Commission2);

        // le prix
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity2, Prix2, Currency, "");
        
        //Les points de vérifications :  
        //Vérifier la modification du prix
        Delay(5000);
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity2, PrixAffiche2, Currency, Total3, Commission2);

        // la commission
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity2, Prix2, Currency, Commission);
        
        //Les points de vérifications :  
        //Vérifier la modification du commission
        Delay(5000);
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity2, PrixAffiche2, Currency, Total4, Commission);
        
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
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        