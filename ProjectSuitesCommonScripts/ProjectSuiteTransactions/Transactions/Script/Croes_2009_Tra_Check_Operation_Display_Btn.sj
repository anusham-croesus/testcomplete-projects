//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Affichage
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2009
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2009_Tra_Check_Operation_Display_Btn()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2009");
  
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2009", language+client);
        var Symbol=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbol2009", language+client);
        var Name=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Name2009", language+client);
        var Note1=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note12009", language+client);
        var Note2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note22009", language+client);
        var Note3=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note32009", language+client);
        var Note4=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note42009", language+client);
        
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
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_TransactionsBar_BtnDisplay().click();
        
        /****************************** Les points de vérifications ******************************/ 
        //Les points de vérifications :  
        //Vérifier si 6 transactions sont affichées dans le browser sur le Symbole B87545 apparaît
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        var NB=aqConvert.StrToInt(NBTran)+1;
        Log.Message("Le nombre des transactions affichées = " + NB);
        Get_WinTransactionsSum_BtnClose().click();
        var pos = 3;
        var note_pos = 3;
        if (client == "CIBC"){
             pos++;
             note_pos = 10;
        }
        Log.Message(pos)
           for (i=1; i<= NB; i++){ 
           Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).click();
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("ContentControl", "", pos).WPFObject("TextBlock", Compte, 1), "Text", cmpEqual, Compte);
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("ContentControl", "", pos+1).WPFObject("TextBlock", Name, 1), "Text", cmpEqual, Name);
               if(i==1)  var Note=Note1;
               if(i==2)  var Note=Note2;
               if(i==3)  var Note=Note3;
               aqObject.CheckProperty(Get_TransactionsPlugin().WPFObject("UniGroupBox", "Note", 3).WPFObject("UniLabel", "", 1).WPFObject("innerLabel"), "Content", cmpEqual, Note);
          
          }
          if (i==NB+1) Log.Checkpoint("Le nombre des transactions affichées est égal à 6.");
          else      Log.Error("Le nombre des transactions affichées est différent de 6." );
        /********************************* Fin de vérifications **********************************/  
        
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_TransactionsBar_BtnDisplay().click();
        
          /****************************** Les points de vérifications ******************************/ 
        //Les points de vérifications :  
        //Vérifier si 9 transactions sont affichées dans le browser sur le Symbole B87545 apparaît
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Sys.Keys("^a");
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        var NB=aqConvert.StrToInt(NBTran)+1;
        Log.Message("Le nombre des transactions affichées = " + NB);
        Get_WinTransactionsSum_BtnClose().click();
        
           for (i=1; i<= NB; i++){ 
            Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).click();
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("ContentControl", "", pos+1).WPFObject("TextBlock", Compte, 1), "Text", cmpEqual, Compte);
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("ContentControl", "", pos+2).WPFObject("TextBlock", Name, 1), "Text", cmpEqual, Name);
               if(i==1)  var Note=Note1;
               if(i==2)  var Note=Note2;
               if(i==3)  var Note=Note3;
               if (client == "CIBC") var Note=Note4;
               aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("ContentControl", "", note_pos).WPFObject("TextBlock", Note, 1), "Text", cmpEqual, Note);
          }
          if (i==NB+1) Log.Checkpoint("Le nombre des transactions affichées est égal à 5.");
          else      Log.Error("Le nombre des transactions affichées est différent de 5." );
        /********************************* Fin de vérifications **********************************/  
        
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_TransactionsBar_BtnDisplay().click();
        
        /****************************** Les points de vérifications ******************************/ 
        //Les points de vérifications :  
        //Vérifier si 3 transactions sont affichées dans le browser sur le Symbole B87545 apparaît
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Sys.Keys("^a");
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
        
        
         
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
       Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
}







