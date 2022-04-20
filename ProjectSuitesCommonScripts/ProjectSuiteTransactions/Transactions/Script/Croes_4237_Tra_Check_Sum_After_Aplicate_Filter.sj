//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier la sommation sur un Filtre appliqué
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4237
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_4237_Tra_Check_Sum_After_Aplicate_Filter()
{
  try {
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte4237", language+client);
        var DtpStart=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpStart4237", language+client);
        var DtpEnd=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpEnd4237", language+client);
        var RettransCAD =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RettransCAD4237", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_ModulesBar_BtnTransactions().Click();
    
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
        //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter. 
        Get_TransactionsBar_BtnFilter().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]);
    
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
          }
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }  
      
      
}
