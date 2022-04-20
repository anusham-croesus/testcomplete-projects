//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Réafficher tous les enregistrements
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2004
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2004_Tra_Check_Operation_Redisplay_Btn()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2004");
  
        var Client=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2004", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2004", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2004", language+client);
        var Prix= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2004", language+client);
        var Prix2= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix22004", language+client);
        var Prix3= ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix32004", language+client);
        var Taux=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Taux2004", language+client);
        var Interet=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Interet2004", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2004", language+client);
        var Frais=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Frais2004", language+client);
        var FraisComm=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "FraisComm2004", language+client);
        var MontantNet=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MontantNet2004", language+client);
        var Note =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note2004", language+client);
        var Note2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note22004", language+client);
        
        var ValeurNull = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ValeurNull_2004", language+client);
        var MontantNet2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MontantNet2_2004", language+client);
        
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
        
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
        //Select transaction
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 24);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 24);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).Click();

        //Les points de vérifications :  
        //Vérifier la somation
        Check_Info_Redisplay_Transactions(Quantity, Prix, Prix2, Taux, Interet, Commission, Frais, FraisComm, MontantNet, Note)

        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 24);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 24);
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
       // Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).Click();
        
        //Les points de vérifications :  
        //Vérifier la somation
        if (client == "CIBC")
            Check_Info_Redisplay_Transactions(ValeurNull, Prix3, ValeurNull, Taux, ValeurNull, ValeurNull, ValeurNull, ValeurNull, MontantNet2, Note2)
        else
            Check_Info_Redisplay_Transactions(Quantity, Prix3, Prix2, Taux, Interet, Commission, Frais, FraisComm, MontantNet, Note2)
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}