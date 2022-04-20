//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Modifier des transactions dans un compte réel 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2012
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2012_Edit_Tra_In_Real_Account()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2012");
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2012", language+client);
      //  var ClientName=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ClientName2012", language+client);
        var TansType=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2012", language+client);
        var TansAccount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansAccount2012", language+client);
        var TranSec=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TranSec2012", language+client);
        var Quantity=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2012", language+client);
        var Quantity2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity22012", language+client);
        var Quantity3=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity32012", language+client);
        var Prix=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2012", language+client);
        var Prix2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix22012", language+client);
        var Currency=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Currency2012", language+client);
        var Commission=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2012", language+client);
        
        Login(vServerTransactions, userNameUNI00 , passwordUNI00 ,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        
        //Mailler External Client vers Transaction
        Search_Account(Compte);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click(); 
         
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        //Les points de vérifications :  
        //Vérifier que la transaction est bien ajouté
        Delay(5000)
        if (client == "CIBC")
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix, Currency, "(10,302.73)", "103.00"); 
        else
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix, Currency, "0,00", "0,00"); 

        //Modifier une Transaction
        // la quantite
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity3, Prix, Currency, "");
        
        //Les points de vérifications :  
        //Vérifier la modification de la quantite
        if (client == "CIBC")
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix, Currency, "(10,302.73)", "103.00"); 
        else
            Validate_Transaction(Compte, TansType, TranSec, Quantity3, Prix, Currency, "0,00", "0,00");
  
        // le prix
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity2, Prix2, Currency, "");
        
        //Les points de vérifications :  
        //Vérifier la modification du prix
        if (client == "CIBC")
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix2, Currency, "(10,302.73)", "103.00"); 
        else
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix2, Currency, "(400 000,00)", "0,00");

        // la commission
        Get_TransactionsBar_BtnInfo().Click();
        Modifier_Transaction(Quantity2, Prix2, Currency, Commission);
        
        //Les points de vérifications :  
        //Vérifier la modification du commission
        if (client == "CIBC")
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix2, Currency, "(10,302.73)", "103.00"); 
        else
            Validate_Transaction(Compte, TansType, TranSec, Quantity2, Prix2, Currency, "(400 020,00)", "20,00");
        
        //supprimer le client cree 
     //    DeleteClient(ClientName);  
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Get_TransactionsBar_BtnInfo().Click();
        Modifier_Transaction(Quantity2, Prix, Currency, Commission);
        Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
        

        
        
function Test()
{        
        var UserAdmin="UNI00";
        var Compte="300001-NA";
        var ClientName="ClientCroes4233";
        var TansType="Transfert"
        var TansAccount="~E-0000D-0";
        var TranSec="MFC"; 
        var Quantity="200";
        var Quantity2="(200)";
        var Quantity3="55";
        var Prix= "0";
        var Prix2= "2 000";
        var Currency="CAD";
        var Commission="0,00";
        
        Get_TransactionsBar_BtnInfo().Click(); 
        Modifier_Transaction(Quantity3, Prix, Currency, "");
        
        //Les points de vérifications :  
        //Vérifier la modification de la quantite
        Validate_Transaction_SysAdmin(Compte, TansType, TranSec, Quantity3, Prix, Currency, "0,00", "0,00");    
}       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        