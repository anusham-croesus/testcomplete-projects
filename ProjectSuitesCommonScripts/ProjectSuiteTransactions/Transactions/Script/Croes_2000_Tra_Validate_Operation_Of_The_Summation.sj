//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider le fonctionnement du bouton Sommation des transactions  
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2000
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2000_Tra_Validate_Operation_Of_The_Summation()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2000");
        
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2000", language+client);
        var CADNumber=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CADNumber2000", language+client);
        var USANumber=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "USANumber2000", language+client);
        var EURNumber=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "EURNumber2000", language+client);
        var TotalNumber=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TotalNumber2000", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        //Mailler External Client vers Transaction
        Search_Account(Compte);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 30000);
        //Les points de vérifications :  
        //Vérifier la somation
        Get_Toolbar_BtnSum().Click();
        WaitObject(Get_WinTransactionsSum(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"]);
        aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions(), "Text", cmpEqual, CADNumber);
        aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions(), "Text", cmpEqual, USANumber);
        aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalNumberOfTransactions(), "Text", cmpEqual, TotalNumber);
        
        if (client != "CIBC")
              aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURNumberOfTransactions(), "Text", cmpEqual, EURNumber);

        Get_WinTransactionsSum_BtnClose().Click();



      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
/*
function Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions1(){
          var nb = 34;
          if (client == "CIBC") nb = 27
          return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb], 10)}
function Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions1(){
          return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "26"], 10)}
function Get_WinTransactionsSum_TxtTotalNumberOfTransactions(){
          return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "28"], 10)}   
  
function test(){
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions1(), "Text", cmpEqual, 1);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions1(), "Text", cmpEqual, 4);
}*/