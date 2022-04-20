//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Mailler dans tous les modules à partir de transactions
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1998
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1998_Tra_DragSelection_In_All_Modules()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1998");
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte1998", language+client);
        var PortfolioSum=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PortfolioSum1998", language+client);
        var AccountsSum=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "AccountsSum1998", language+client);      
        var ClientsSum=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientsSum1998", language+client);
        var RelationshipsSum=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RelationshipsSum1998", language+client);
        var SecuritySum=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "SecuritySum1998", language+client);
        
      Login(vServerTransactions, userName , psw ,language);
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
      Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);  
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Delay(3000)   
      //Recherche transaction  
      Search_Transactions_Account(Compte);
      
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 3).Click();

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
      
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Delay(3000) 
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
      
      
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Delay(3000) 
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
      
      
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Delay(3000) 
      //Mailler Transaction vers Relations
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Relationships().Click();
      Get_MenuBar_Modules_Relationships_DragSelection().Click();
      
      //Les points de vérifications :  
      Get_MainWindow().Click();
      Get_MainWindow().Keys("^a");
      Get_Toolbar_BtnSum().Click();
      aqObject.CheckProperty(Get_WinRelationshipsSum_TxtNumberOfRelationshipsTotalCAD(), "Content", cmpEqual, RelationshipsSum);
      Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
      
      
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      Delay(3000) 
      //Mailler Transaction vers Modeles
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Models().Click();
      Get_MenuBar_Modules_Models_DragSelection().Click();
      
      //Les points de vérifications :  
        aqObject.CheckProperty(Get_Toolbar_BtnSum(), "IsEnabled", cmpEqual, false);
      
      
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Clients List View 
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
      
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
      
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
