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

function Regression_CROES_4123_Acc_DeleteSelectedAccountAtOnce()
{
 try{

     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4132","CROES_4123");

     var FName= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "FullName_4123", language+client);
     var IACode_4123=  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "IACode", language+client);
     var ExterName= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameExternalCROES_4123", language+client);
     var RealClient = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "RealClient", language+client);
     var clientNameFictifCROES_4123=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameFictifCROES_4123", language+client);
     var accountFictif=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountFictif", language+client);
     var accountExrter=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountExrter", language+client);
         
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
       
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click(); 
     
    //Ajouter un client fictif
    CreateFictitiousClient(clientNameFictifCROES_4123);
    
    //Accès au module Comptes ensuite cliquer sur le bouton ajouter     
    Get_ModulesBar_BtnAccounts().Click();    
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Get_Toolbar_BtnAdd().Click();
    //Sélectionner le client fictif créé et modifier le nom complet
    Get_WinPickerWindow_DgvElements().Keys("C");
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(clientNameFictifCROES_4123);
    Get_WinQuickSearch_BtnOK().Click();     
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAccountInfo_GrpAccount_TxtFullName().Clear();
    Get_WinAccountInfo_GrpAccount_TxtFullName().set_Text(FName);  
    Get_WinDeleteTransaction_GrpAction_BtnOK().Click();
   
    // Valider la création du compte
    resultClientSearch = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem.FullName.OleValue
    if (resultClientSearch.Exists == false){
       Log.Error("Client " + FName + " not found in the accounts grid.");
    }
    else{
             Log.Checkpoint("Client "+ FName + "was found in the accounts grid.")
    }
            
  
    //Valider que le bouton Supprimer est accessible et non grisé
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, true)    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, true)
       
    // Supprimer le compte ficif 
    DeleteClient(clientNameFictifCROES_4123);
     
     
    //Vérifier que le compte n'existe plus
    Get_ModulesBar_BtnAccounts().Click();         
    Log.Message("Verify that the fictitious account (" + clientNameFictifCROES_4123 + ") was deleted.");
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Get_Toolbar_BtnSearch().WaitProperty("IsEnabled", true, 30000);
    Search_AccountByName(clientNameFictifCROES_4123);
    resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameFictifCROES_4123, 10);
    if (resultAccountSearch.Exists == false){
        Log.Checkpoint("Fictitious account " + clientNameFictifCROES_4123 + " was deleted.");
    }
    else {
        Log.Error("Account " + clientNameFictifCROES_4123 + " not deleted.");
    }
        
    //Supprimer un compte fictif et un compte externe      
    //créer un compte fictif
    CreateFictitiousAccount(clientNameFictifCROES_4123);
    
    //céer un compte externe
    createExternalAccount(ExterName, IACode_4123)
    
    //Sélectionner le compte fictif CROES4123 et le compte externe EXTERN4123
    //sélectionner d'abord le compte fictif:
    Search_AccountByName(clientNameFictifCROES_4123);
    var resultClientSearch= Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameFictifCROES_4123, 10);
    resultClientSearch.Click();
    //et sélectionner par la suit le compte externe 
    Search_AccountByName(ExterName);  
    var resultClientSearch1 =Get_RelationshipsClientsAccountsGrid().FindChild("Value", ExterName, 10);
    Sys.Desktop.KeyDown(0x11); //Press Ctrl
    resultClientSearch1.Click();   
    Sys.Desktop.KeyUp(0x11); //Release Ctrl
    
    //Valider quer le bouton Supprimer est accesible et non grisé
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, true)    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, true)
    
    //fermer croesus
    Terminate_CroesusProcess();
    
    // se connecter
    Login(vServerAccounts, userName, psw, language); 
    //Accès au module Comptes
    Get_ModulesBar_BtnAccounts().Click(); 
    
    // valider que la suppression d'un compte rééel n'est pas possible:
    //Sélectionner le compte fictif "~F-00000-0", le compte externe "~E-0000D-0" et le compte réel "800237-DQ"
    //Créer un tableau contenant les numéros de comptes des clients de recherche  
     Get_AccountNO( clientNameFictifCROES_4123);
     var cliFict= Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameFictifCROES_4123, 10).DataContext.DataItem.AccountNumber.OleValue
     Log.Message(cliFict)
     Get_AccountNO(ExterName);
    var cliExt=Get_RelationshipsClientsAccountsGrid().FindChild("Value", ExterName, 10).DataContext.DataItem.AccountNumber.OleValue
    Log.Message(cliExt);
      
   var clients= new Array(cliFict, cliExt, RealClient);
     for (var i =0 ; i < clients.length; i++){          
        
        Log.Message("numeros compte :");
        Log.Message(clients[i]);
       }
    SelectAccounts(clients);
   
    //Valider que le bouton supprimer est grisé est inaccessible 
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, false)    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, false)
        
    //Supprimer le client ficif 
    Get_ModulesBar_BtnClients().Click();
    Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 20000)
    DeleteClient(clientNameFictifCROES_4123);
    
    
    //Supprimer le client externe
    Get_ModulesBar_BtnClients().Click();
    Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 20000)
    DeleteClient(ExterName);
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
        Terminate_CroesusProcess();
    }
}
