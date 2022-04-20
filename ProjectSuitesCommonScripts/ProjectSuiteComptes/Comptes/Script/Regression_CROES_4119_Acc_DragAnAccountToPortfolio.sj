//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/*
    Description : Mailler dans tous les modules à partir d'un compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4119_Acc_DragAnAccountToPortfolio()
{
  try{
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119","CROES_4119");
    var account1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "account1", language+client);
    var account2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "account2", language+client);
    var account3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "account3", language+client);
    
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Sélectionner les comptes "800208-NA", "800238-OB", "800283-HU"
    var accounts= new Array(account1, account2, account3);
    for (var i =0 ; i < accounts.length; i++){          
        
    Log.Message("numeros compte :");
    Log.Message(accounts[i]);
    }
    SelectAccounts(accounts);
    
    //Mailler vers le module portefeuille
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click(); 
    
    //Vérifier la présence des comptes maillés
    WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["DisplayAccountNumber", true]); 
    
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value", account1, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value", account2, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value", account3, 10),"Exists", cmpEqual, true);
    
    }
  catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    
  finally{   
    Terminate_CroesusProcess();
    }  

}
