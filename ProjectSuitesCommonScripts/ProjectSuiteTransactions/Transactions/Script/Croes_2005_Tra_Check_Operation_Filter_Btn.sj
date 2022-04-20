//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Filtre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2005
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2005_Tra_Check_Operation_Filter_Btn()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2005");
  
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2005", language+client);
        var Symbole=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbole2005", language+client);
        var DtpStart=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpStart2005", language+client);
        var DtpEnd=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpEnd2005", language+client);
        var RettransCAD =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RettransCAD2005", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_ModulesBar_BtnTransactions().Click();
        
        //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
    
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
         
        //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter.
        var nbOfTriesLeft = 2;
        do {
            Delay(5000);
            Get_TransactionsBar_BtnFilter().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]);
        } while ((--nbOfTriesLeft) > 0 && !Get_WinFilter().Exists)
        
        //Saisie de critères de filtre
        Get_WinFilter_GrpAccount_TxtAccount().Click();
        Get_WinFilter_GrpAccount_TxtAccount().Keys(Compte);
    
        Get_WinFilter_GrpProcessingDate_DtpStart().Click();
        Get_WinFilter_GrpProcessingDate_DtpStart().Keys(DtpStart);
    
        Get_WinFilter_GrpProcessingDate_DtpEnd().Click();
        Get_WinFilter_GrpProcessingDate_DtpEnd().Keys(DtpEnd);
    
        Get_WinFilter_GrpType_ChkWithdrawal().set_IsChecked(true); 
    
        Get_WinFilter_BtnOK().click();
    
        //Les points de vérifications :  
        //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        Log.Message("Le nombre des transactions affichées = " + NBTran);
        
        var RetraitCAD = Get_WinTransactionsSum_TxtTransactionsCADWithdrawal().Text;
        if (RetraitCAD==RettransCAD) Log.Checkpoint("Le Retrait des transactions CAD = " + RetraitCAD);
        else Log.Error("Expected : '" + RettransCAD + "' But Was :'" + RetraitCAD + "'");
        
        Get_WinTransactionsSum_BtnClose().click();

           for (i=1; i<= NBTran; i++){ 
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, Symbole);
          }
          if (i==3) Log.Checkpoint("Le nombre des transactions affichées est égal à 2.");
          else      Log.Error("Le nombre des transactions affichées est différent de 2." );
          
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }      
      
}


