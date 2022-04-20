//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier l'ajout des transactions dans un compte réel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4235
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_4235_Add_Tra_To_Real_Account()
{
  try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4235");
  
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte4235", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        
        Get_ModulesBar_BtnAccounts().Click(); 
        Search_Account(Compte);
        
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
    
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
        //Les points de vérifications :  
        //Vérifier que c'est Impossible d'ajouter une transaction car le bouton est grisée
        Log.Message("Vérification que le bouton (+) ajouter une transaction est grisée");
        aqObject.CheckProperty(Get_Toolbar_BtnAdd(), "IsEnabled", cmpEqual, false);
        

      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }  
      
      
}