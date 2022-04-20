//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Copier et coller l'information du module Transactions dans Excel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1996
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1996_Tra_Copy_Paste_Into_Excel()
{
  try {
    
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1996");
        var CroesusRowCount=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CroesusRowCount1996", language+client);
        Login(vServerTransactions, userName , psw ,language);
        
        //fermer les fichiers excel
        CloseExcelProcess();
        
        // Les points de vérifications :  
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        var tempClipboard = "Croes_1996_Tra_Copy_Paste_Into_Excel";
        Sys.Clipboard = tempClipboard;
        
        Sys.Keys("^c");
        
        var nbOfChecks = 0;
        while (nbOfChecks < 30 && Sys.Clipboard == tempClipboard){
            Delay(1000);
            nbOfChecks++;
        }
        
        //Paste in the Excel sheet
        objExcel = Sys.OleObject("Excel.Application");
        objExcel.Visible = true;
        objExcelWorkbook = objExcel.Workbooks.Add();
        Delay(10000);
        Sys.Keys("^v");
        
        excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
        Log.Message("excelRowCount= " + excelRowCount);
        
        //The row count in the Excel sheet should be the same as in Croesus
        if (CroesusRowCount == excelRowCount)
            Log.Checkpoint("The Excel row count equal to The Croesus row count: " + excelRowCount+" = "+CroesusRowCount);
        else  
            Log.Error("The Excel row count not equal to The Croesus row count: " + excelRowCount+" != "+CroesusRowCount);
        
        //fermer les fichiers excel
        CloseExcelProcess();
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Terminate_CroesusProcess(); //Fermer Croesus
  }  
}

function test(){
  
    Sys.Keys("^c");
}