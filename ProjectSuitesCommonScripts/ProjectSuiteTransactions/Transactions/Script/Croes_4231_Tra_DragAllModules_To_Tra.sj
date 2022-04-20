//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Mailler de tous les modules vers le module transaction
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4231
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_4231_Tra_DragSelection_In_All_Modules()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4231");

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
        
        Login(vServerTransactions, userName , psw ,language);
        
        /****************************** Client Vers Transaction ******************************/
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
        //cliquer sur module Clients
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
        //cliquer sur module Relations
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
        //cliquer sur module Modeles
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().Click();
        //Mailler External Relation vers Transaction
        SearchModelByName(ModeleName);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        //Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        /****************************** Les points de vérifications ******************************/ 
        aqObject.CheckProperty(Get_MenuBar_Modules_Transactions_DragSelection(), "IsEnabled", cmpEqual, false);
        /********************************* Fin de vérifications **********************************/  
        
        
        /****************************** Titres Vers Transactions ******************************/       
        //cliquer sur module Clients
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().Click();
        //Wait Clients List View      
        WaitObject(Get_SecurityGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"]);
        
        
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

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
function test (){
  
      aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte1);  

}





