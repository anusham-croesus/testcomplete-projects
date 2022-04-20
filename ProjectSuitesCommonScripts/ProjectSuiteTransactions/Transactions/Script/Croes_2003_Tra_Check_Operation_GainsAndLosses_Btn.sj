//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Gains/pertes 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2003
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2003_Tra_Check_Operation_GainsAndLosses_Btn()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2003");
  
        var Client=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2003", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2003", language+client);
        var PositionCost=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PositionCost2003", language+client);
        var CostGainsLosses=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CostGainsLosses2003", language+client);
        var ACBPositionCost=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ACBPositionCost2003", language+client);
        var ACBManualCost=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ACBManualCost2003", language+client);
        var TransactionPos=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TransactionPos2003", language+client);

        
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
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
        if (language=="english")
           {
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
           }
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", TransactionPos).Click();   
        //Les points de vérifications :  
        //Vérifier la somation
        Get_TransactionsBar_BtnGainsLosses().Click();
        
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(), "IsChecked", cmpEqual, true);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostPositionCost(), "Text", cmpEqual, PositionCost);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostGainsLosses(), "Text", cmpEqual, CostGainsLosses);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBPositionCost(), "Text", cmpEqual, ACBPositionCost);
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBGainsLosses(), "Text", cmpEqual, ACBManualCost);

        
        Get_WinTransactionsInfo_BtnOK().Click();
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
  