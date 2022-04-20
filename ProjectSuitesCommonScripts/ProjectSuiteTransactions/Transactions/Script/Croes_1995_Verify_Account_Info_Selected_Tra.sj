//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions

/**
    Description : Vérifier les informations compte pour la transaction sélectionnée 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1995
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1995_Verify_Account_Info_Selected_Tra()
{
  try {
    
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1995");
        Login(vServerTransactions, userName , psw ,language); 
        Get_ModulesBar_BtnTransactions().Click();
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
        // Les points de vérifications :  
        // Confirmer que la fenêtre Info qui s'ouvre est celle du compte sélectionné dans le browser Transactions. 

        var Compte = Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 1).WPFObject("BrowserCellTemplateSimple", "", 1).Text;

        Get_TransactionsBar_BtnInfo().Click();
        
        if (client == "CIBC")
              aqObject.CheckProperty(Get_WinEditTransaction_GrpAccounts_TxtToAccount(), "Text", cmpEqual, Compte);
        else 
              aqObject.CheckProperty(Get_WinEditTransaction_GrpAccounts_TxtFromAccount(), "Text", cmpEqual, Compte);
        
        Get_WinEditTransaction_BtnOK().Click();
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Terminate_CroesusProcess(); //Fermer Croesus
  }  
      
      
}















