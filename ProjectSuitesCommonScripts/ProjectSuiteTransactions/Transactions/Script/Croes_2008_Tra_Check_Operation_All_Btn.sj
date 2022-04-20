//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Toutes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2008
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2008_Tra_Check_Operation_All_Btn()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2008");
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2008", language+client);
        var Symbol=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbol2008", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
            
        
        /****************************** Portefeuille Vers Transactions ******************************/       
        //cliquer sur module Comptes
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().Click();
        //Wait Clients List View 
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
        //Mailler External Client vers Clients
        Search_Account(Compte);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
        
        Search_Position(Symbol);
        WaitObject(Get_CroesusApp(), "Uid", "GridSection_0466");
        
        Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1).Click();
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        
        //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        Get_TransactionsBar().click();
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        
        /****************************** Les points de vérifications ******************************/ 
        //Les points de vérifications :  
        //Vérifier si 3 transactions sont affichées dans le browser sur le Symbole B87545 apparaît
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        var NB=aqConvert.StrToInt(NBTran)+1;
        Log.Message("Le nombre des transactions affichées = " + NB);
        Get_WinTransactionsSum_BtnClose().click();

           for (i=1; i<= NB; i++){ 
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, Symbol);
          }
          if (i==NB+1) Log.Checkpoint("Le nombre des transactions affichées est égal à 3.");
          else      Log.Error("Le nombre des transactions affichées est différent de 3." );
        /********************************* Fin de vérifications **********************************/  
        

        Get_TransactionsBar_BtnAll().click();
        
          /****************************** Les points de vérifications ******************************/ 
        //Les points de vérifications :  
        //Vérifier si 5 transactions sont affichées dans le browser sur le Symbole B87545 apparaît
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        var NB=aqConvert.StrToInt(NBTran)+1;
        Log.Message("Le nombre des transactions affichées = " + NB);
        Get_WinTransactionsSum_BtnClose().click();

           for (i=1; i<= NB; i++){ 
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, Symbol);
          }
          if (i==NB+1) Log.Checkpoint("Le nombre des transactions affichées est égal à 5.");
          else      Log.Error("Le nombre des transactions affichées est différent de 5." );
        /********************************* Fin de vérifications **********************************/  
        
        
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}
