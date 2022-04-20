//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier les informations pour la transaction sélectionnée  
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2001
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2001_Tra_Check_Info_For_Selected_Transaction()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2001");
  
        var Client=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2001", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2001", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2001", language+client);
        var Prix= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2001", language+client);
        var Prix2= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix22001", language+client);
        var Taux=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Taux2001", language+client);
        var Interet=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Interet2001", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2001", language+client);
        var Frais=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Frais2001", language+client);
        var FraisComm=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "FraisComm2001", language+client);
        var MontantNet=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MontantNet2001", language+client);
        var Note=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note2001", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        //Mailler External Client vers Transaction
        Search_Client(Client);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        
        //Select transaction
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
        Search_Transactions_Type(TansType);
        if (language=="french")
           {
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 14).Click();
           }
        else   
           {
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 48).Click();
           }
             
        //Les points de vérifications :  
        //Vérifier la somation
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

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}






           