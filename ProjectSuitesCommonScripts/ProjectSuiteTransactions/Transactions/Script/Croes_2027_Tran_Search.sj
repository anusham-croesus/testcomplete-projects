//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Effectuer une recherche dans le module Transactions
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2027
    
    Analyste d'assurance qualité : Créé le  22/09/2016 15:10:23  par redaa
                                   Dernière modification le 10/01/2018 17:05:08  par antonb 
                                   
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2027_Tran_Search()
{
  try {
    
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2027");

        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2027", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2027", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnTransactions().Click();
        
        //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        
        //Wait Clients List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");   
        Get_TransactionsBar().click();
        Search_Transactions_Account(Compte);

        /****************************** Les points de vérifications ******************************/ 

        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");

        aqObject.CheckProperty(Get_Transactions_ListView().FindChild(["ClrClassName", "IsFocused"], ["DragableListViewItem", true], 10).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
        aqObject.CheckProperty(Get_Transactions_ListView().FindChild(["ClrClassName", "IsFocused"], ["DragableListViewItem", true], 10).WPFObject("BrowserCellTemplateSimple", "", 5), "Text", cmpEqual, TansType);
      // Validate_Transaction(TansAccount, TansType, TranSec, Quantity, Prix, Currency, Total, Commission); 
      } 
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
      
      
}
