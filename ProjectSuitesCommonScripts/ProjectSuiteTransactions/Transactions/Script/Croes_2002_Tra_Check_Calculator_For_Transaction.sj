//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement de la calculatrice pour une transaction 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2002
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2002_Tra_Check_Calculator_For_Transaction()
{
  try {
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2002");
  
        var Client=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2002", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2002", language+client);
        var InterestRate=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "InterestRate2002", language+client);
        var Cost=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Cost2002", language+client);
        var MarketPrice=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MarketPrice2002", language+client);
        var ParValue=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ParValue2002", language+client);
        var CostYield=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CostYield2002", language+client);
        var MarketYield=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MarketYield2002", language+client);
        var YieldToDate=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "YieldToDate2002", language+client);
        var ModifiedDuration=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ModifiedDuration2002", language+client);
        var AccInterest=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "AccInterest2002", language+client);
        var Note=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note2002", language+client);
        
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
        if (language=="french")
           {
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 53).Click();
           }
        else   
           {
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
            Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 25).Click();
           }

        
        //Les points de vérifications :  
        //Vérifier la somation
        Get_Toolbar_BtnBondCalculator().Click();
        Get_WinBondCalculator_BtnClose().WaitProperty("IsVisible",true,15000);
        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "Text", cmpEqual, InterestRate);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "Text", cmpEqual, Cost);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "Text", cmpEqual, MarketPrice);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "Text", cmpEqual, ParValue);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "Text", cmpEqual, CostYield);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "Text", cmpEqual, MarketYield);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "Text", cmpEqual, YieldToDate);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "Text", cmpEqual, ModifiedDuration);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "Text", cmpEqual, AccInterest);
        
        Get_WinBondCalculator_BtnClose().Click();
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}




           