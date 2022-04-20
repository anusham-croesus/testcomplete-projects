//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/*
    Description : Mailler dans tous les modules à partir d'un compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119
    Analyste d'assurance qualité :antonb
    Version: ref90-10-Fm-6--V9
*/


function Regression_CROES_4119_Acc_DragSeveralAccountsToOtherModules()
{
   try{
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4119","CROES_4119");   
     var Compt1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Compt1", language+client);
     var Compt2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Compt2", language+client);
     var Client1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Client1", language+client);
     var Client21= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Client2-1", language+client);
     var Client22= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Client2-2", language+client);

    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Sélectionner plusieurs comptes 800232-NA et 800283-HU    
    //Créer un tableau contenant les numéros de comptes 
    var comptes= new Array(Compt1, Compt2);
     for (var i =0 ; i < comptes.length; i++){          
        
        Log.Message("numeros compte :");
        Log.Message(comptes[i]);
       }
    SelectAccounts(comptes);
   
    //Mailler les comptes sélectionnés vers Clients
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    Get_MenuBar_Modules_Clients_DragSelection().Click();
    
    //Valider que les numéros des clients 800232, 800283-1 et 800283-2 sont affichés
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Client1,10), "Exists", cmpEqual, true);
    Log.Message("Le client: "+Client1+ " est affiché");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Client21,10), "Exists", cmpEqual, true);
    Log.Message("Le client: "+Client21+ " est affiché");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Client22,10), "Exists", cmpEqual, true);
    Log.Message("Le client: "+Client22+ " est affiché");
   
   }

  catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    
  finally{   
    Terminate_CroesusProcess();
    }  

}