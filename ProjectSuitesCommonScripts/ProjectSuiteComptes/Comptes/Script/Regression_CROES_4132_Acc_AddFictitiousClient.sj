//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Le compte fictif est destiné aux clients potentiels à qui vous désirez faire une proposition de portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4132
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
    
*/

function Regression_CROES_4132_Acc_AddFictitiousClient()
{
    try {

    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4132","CROES-4132");
    var clientNameFictifCROES_4132=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameFictifCROES_4132", language+client);    
      
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
       
    // Créer un compte fictif
    Get_MainWindow().Maximize();
    CreateFictitiousAccount(clientNameFictifCROES_4132);

    //Fermer l'application
    Terminate_CroesusProcess();
        
   
   }  
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerAccounts, userName, psw, language);
        DeleteClient(clientNameFictifCROES_4132);
        Terminate_CroesusProcess();
    }
     
}


  function CreateFictitiousAccount(clientName)
  
{   
   
    //Accès au module Clients 
    Get_ModulesBar_BtnClients().Click(); 
    
    //ajouter un client fictif
    CreateFictitiousClient(clientName);
    
    //Mailler le client externe vers le module compte
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();
    
    // valider que le client créé n'a pas de compte
    var pasDeCompte=Get_RelationshipsClientsAccountsGrid().RecordListControl.HasItems;
    if (pasDeCompte == false)
         Log.Checkpoint("Client "+clientName+" haven't an accuount" )
      else 
         Log.Error("Client "+clientName+" have an accuount")   
    
    //Cliquer sur + pour ajouter un compte fictif 
    Get_Toolbar_BtnAdd().Click();
    
    //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée a l'écran' 
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
   
    
    //Ajouter le compte
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Valider la création du compte
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    SearchClientByName(clientName);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
     resultClientSearch =  Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).DataContext.DataItem.FullName.OleValue;
        if (resultClientSearch.Exists == false){
            Log.Error("Client " + clientName + " not found in the accounts grid.");
            return;
        }
 }   
