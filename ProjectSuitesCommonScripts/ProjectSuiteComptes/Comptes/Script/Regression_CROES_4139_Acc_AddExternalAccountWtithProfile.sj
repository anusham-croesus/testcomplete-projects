//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description :Valider l'ajout d'un compte externe avec profil
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4139
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
    
*/


function Regression_CROES_4139_Acc_AddExternalAccountWtithProfile()
{
    try {
          
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4139","CROES_4139");
    var clientNameExternCROES_4139=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameExternalCROES_4139", language+client);    
    var IACodeCROESExtern_4139=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "IACode", language+client);
    var Profile_Hobbies=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ProfileCroesExtern_4139", language+client); 
     
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
        
    //Accès au module Clients 
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnClients().Click(); 
      
    //créer un compte externe
    createExternalAccount(clientNameExternCROES_4139, IACodeCROESExtern_4139)
    
    //Aller sur la fenêtre info
    Get_AccountsBar_BtnInfo().Click(); 
        
    //Choisir le l'onglet profil 
    Get_WinAccountInfo_TabProfile().Click();
    Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 20000)
    aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Profile",2,language));
    aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "IsSelected", cmpEqual, true);
    
    //Remplir le champ "Loisirs"
      if(!Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies().Exists){
        Get_WinInfo_TabProfile_BtnSetup().Click();
        Get_WinVisibleProfilesConfiguration().Click(62,  38);
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    }
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies().SetText(Profile_Hobbies);
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Valider l'affichge du profil choisi
    Get_AccountsDetails_TabProfile().Click();
    aqObject.CheckProperty(Get_AccountsDetails_TabProfile(), "IsSelected", cmpEqual, true);    
    var loisirs=   Get_ClientsDetails_TabProfile_ItemControl().FindChild("Text",Profile_Hobbies, 10).Exists
    Log.Message(loisirs)
     if(loisirs == true){
              
          Log.Checkpoint("Loisirs Correspend à : "+Profile_Hobbies)           
        }
     else  
        {
          Log.Error("Loisirs est différent de: "+Profile_Hobbies)
        }  

    }
    
     catch(e) {
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      
    }
    
    finally {   
    Terminate_CroesusProcess();
    Login(vServerAccounts, userName, psw, language);
    DeleteClient(clientNameExternCROES_4139);
    Terminate_CroesusProcess();  
      
    }  
  
}
function createExternalAccount(clientName, IACode)
{
    //ajouter un client Externe
    CreateExternalClient(clientName, IACode);
    
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
        
    //Cliquer sur + pour ajouter un compte 
    Get_Toolbar_BtnAdd().Click();
    
    //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée a l'écran' 
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
    Log.Message("CROES-4139")
    
    //Ajouter le compte
    Get_WinDetailedInfo_BtnOK().Click();
    
   //Valider la création du compte
    SearchClientByName(clientName);
    //Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
     resultClientSearch =  Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
    if (resultClientSearch.Exists == false){
            Log.Error("Client " + clientName + " not found in the accounts grid.");
            return;
    }        
}

