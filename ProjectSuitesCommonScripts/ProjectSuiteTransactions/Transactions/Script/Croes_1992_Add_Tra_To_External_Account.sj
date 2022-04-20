﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Ajouter des transactions dans un compte de client externe On clique sur bouton +
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1992
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1992_Add_Tra_To_External_Account()
{
  try {
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1992");

        
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte", language+client);
        var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType", language+client);
        var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount", language+client);
        var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity", language+client);
        var Prix=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix", language+client);
        var PrixAffiche=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PrixAffiche", language+client);
        var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission", language+client);
        var Total=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Total", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
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
        Log.Message("CROES-11577");
        //Create Transaction
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        Get_Toolbar_BtnAdd().Click();
        Log.Message("Bug JIRA PF-371 / QAV-746 : Crash l'application lorsqu'on ajoute une transaction sur un client externe.");
        var numberOftries = 0;
        while (numberOftries < 5 && !Get_WinDetailedInfo().Exists){
            Get_Toolbar_BtnAdd().Click(); 
            numberOftries++;
        }
           
        Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 30000)
        Create_Transaction(TansType, TansAccount, TranSec, Quantity, Prix, Currency);
        
        
        //Les points de vérifications :  
        //Vérifier que la transaction est bien ajouté
        Validate_Transaction(TansAccount, TansType, TranSec, Quantity, PrixAffiche, Currency, Total, Commission);
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

