//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Mailler dans tous les modules à partir d'un compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V9
*/

function Regression_CROES_4119_Acc_DragAllModulesFromAnAccount()
{
  try {
      
  
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119","CROES_4119");
    var accountN= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountN", language+client);
    var relationship1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "relationship1", language+client);
    var relationship2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "relationship2", language+client);
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "800238-OB"
    SelectAccounts(accountN);    
    
    //Mailler vers le module Relations
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Relationships().Click();
    Get_MenuBar_Modules_Relationships_DragSelection().Click();
    
    //Valider que le compte a deux relations "00000" et "00002"
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",relationship1,10), "Exists", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",relationship1,10), "VisibleOnScreen", cmpEqual, true);
   Log.Message("relation numéro 1 est: "+relationship1);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",relationship2,10), "Exists", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",relationship2,10), "VisibleOnScreen", cmpEqual, true);
   Log.Message("relation numéro 2 est: "+relationship2);
    }
    
  catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    
  finally{   
    Terminate_CroesusProcess();
    }  
   
}
