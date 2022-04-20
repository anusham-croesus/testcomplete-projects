//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/*
    Description : Mailler dans tous les modules à partir d'un compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V9 
*/

function Regression_CROES_4119_Acc_DragAnAccountToTransactions()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119","CROES_4119");
    var NCompte= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Ncompte", language+client);
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "800228-JW "
    SelectAccounts(NCompte);
    
    //Mailler vers le module Relations
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();  
    
    //Valider qu'il y a 5 transactions affichés
    var count = Get_Transactions_ListView().Items.Count;
          Log.Message(count + " It's a number of accounts must be displayed");
        if (count == 5){
            Log.Checkpoint("The number of the displayed accounts is the expected.");
        }
        else {
            Log.Error("The number of the displayed accounts is not the expected. Expecting 2 accounts.");
        }  
    
  }
  catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    
  finally{   
    Terminate_CroesusProcess();
    }    

}