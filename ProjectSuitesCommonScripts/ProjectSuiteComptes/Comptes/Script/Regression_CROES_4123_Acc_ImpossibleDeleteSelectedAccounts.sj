//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Regression_CROES_4132_Acc_AddFictitiousClient
//USEUNIT Regression_CROES_4139_Acc_AddExternalAccountWtithProfile

/**
    Description : Suppression d’une sélection de comptes à la fois.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4123
    couvert par CR1352_1533_Acc_Delete_a_fictitious_account
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4123_Acc_ImpossibleDeleteSelectedAccounts()
{
   
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4132","CROES_4123"); 
   
    var clientNameFictifCROES_4123=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameFictifCROES_4123", language+client);
    var ExterName= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameExternalCROES_4123", language+client);
    var RealClient = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "RealClient", language+client);
    var IACode_4123=  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "IACode", language+client);
    var FName= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "FullName_4123", language+client);
    var accountExtern= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountExrter", language+client);
    var accountFictif= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountFictif", language+client);
     
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnClients().Click(); 
    
    //Ajouter un compte fictif
    CreateFictitiousAccount(clientNameFictifCROES_4123) 
         
    //céer un compte externe
    createExternalAccount(ExterName, IACode_4123);
    
      
    //Sélectionner le compte fictif "~F-00000-0", le compte externe "~E-0000D-0" et le compte réel "800237-DQ"
    Delay(2000);
    SearchClientByName(clientNameFictifCROES_4123)      //Ajouté par Amine A.
    var clientFictif = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameFictifCROES_4123, 10).DataContext.DataItem.AccountNumber.OleValue;
    Log.Message(clientFictif);
    var clientExter=Get_RelationshipsClientsAccountsGrid().FindChild("Value", ExterName, 10).DataContext.DataItem.AccountNumber.OleValue;
    Log.Message(clientExter);
    
    Delay(2000);
    //Créer un tableau contenant les numéros de comptes des clients de recherche 
    var clients= new Array(RealClient, clientFictif, clientExter);
    for (var i =0 ; i < clients.length; i++){          
        
    Log.Message("numeros compte :");
    Log.Message(clients[i]);
    }
    SelectAccounts(clients);
    Delay(1000);
    
    //Valider que le bouton supprimer est grisé est inaccessible 
    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, false)    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, false)
     
    //Supprimer le client ficif 
    DeleteClient(clientNameFictifCROES_4123);
    Delay(2000);
  
    //Supprimer le client externe
     DeleteClient(ExterName); 
    } 
    catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
    finally {
          Terminate_CroesusProcess();
      }
    
}   