//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description : Le champs entité légale est obligatoire pour la sauvegarde d`un compte externe.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4124
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4124_Acc_LegalEntityIsMandatoryToSaveExternalAccount()
{
  try{  
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4124","Croes-4124");
    
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EXTERNAL_ACCOUNT_INSTITUTION", "YES", vServerAccounts);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EXTERNAL_ACCOUNT_INSTITUTION_MANDATORY", "YES", vServerAccounts);
    RestartServices(vServerAccounts)
    
    var clientNameExternalCROES_4124=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "clientNameExternalCROES_4124", language+client); 
    var IACodeCROESExtern_4124=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "codeCP", language+client);  
    var RealClient_4124=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "RealClient_4124", language+client);  
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Clients 
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnClients().Click(); 
      
    //créer un compte externe
    CreateExternalClient(clientNameExternalCROES_4124, IACodeCROESExtern_4124)

    //Mailler le client externe vers le module compte
   Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameExternalCROES_4124, 10).Click();
   Get_MenuBar_Modules().Click();
   Get_MenuBar_Modules_Accounts().Click();
   Get_MenuBar_Modules_Accounts_DragSelection().Click();
   //Cliquer sur + pour ajouter un compte externe
   Get_Toolbar_BtnAdd().Click();
   //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée à l'écran' 
   aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
     
   //Cliquer sur OK
   Get_WinAccountInfo_BtnOK().Click();
     
   //le message "L'entité juridique est obligatoire .. " est affiché
   aqObject.CheckProperty(Get_DlgInformation().Parent, "Exists", cmpEqual, true);
   aqObject.CheckProperty(Get_DlgInformation().Parent, "VisibleOnScreen", cmpEqual, true);
  
   //Cliquer sur OK
   Get_DlgInformation_BtnOK().Click();
   
   //Choisir "Externe" dans la liste d'entité juridique 
   Get_WinAccountInfo_GrpAccount_CmbLegalEntity().Click();
   if (client == "CIBC")
      Get_SubMenus().FindChild ("WPFControlText", "CIBC", 1).Click();
   else
      Get_SubMenus().FindChild ("WPFControlText", "Externe", 1).Click();
   Get_WinAccountInfo_BtnOK().Click();
   
    //Valider la création du compte
    SearchClientByName( clientNameExternalCROES_4124);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameExternalCROES_4124, 10).Click();
    resultClientSearch =  Get_RelationshipsClientsAccountsGrid().FindChild("Value",  clientNameExternalCROES_4124, 10);
        if (resultClientSearch.Exists == false){
            Log.Error("Client " +  clientNameExternalCROES_4124 + " not found in the accounts grid.");
            }
        else {
            Log.Message("The account "+ clientNameExternalCROES_4124 +" exist.")
        }
    
        
    //Accès au module Clients 
    Get_ModulesBar_BtnClients().Click();     
    //Choisir un client réél
    Search_AccountByName(RealClient_4124);
    var resultClientSearch= Get_RelationshipsClientsAccountsGrid().FindChild("Value", RealClient_4124, 10);
    resultClientSearch.Click();
    
    //mailler le client réel vers le module compte
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", RealClient_4124, 10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();
   
   //Cliquer sur + pour ajouter un compte
   Get_Toolbar_BtnAdd().Click();
   
   //Cliquer sur OK
   Get_WinAccountInfo_BtnOK().Click();
   
   //le message "L'entité juridique est obligatoire .. " est affiché
   aqObject.CheckProperty(Get_DlgInformation().Parent, "Exists", cmpEqual, true);
   aqObject.CheckProperty(Get_DlgInformation().Parent, "VisibleOnScreen", cmpEqual, true);
   
   //Cliquer sur OK
   Get_DlgInformation_BtnOK().Click();
   WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["BaseWindow", "Information"],5000);
   
   //Choisir "Externe" dans la liste d'entité juridique 
   Get_WinAccountInfo_GrpAccount_CmbLegalEntity().Click();
   if (client == "CIBC")
      Get_SubMenus().FindChild ("WPFControlText", "CIBC", 1).Click();
   else
      Get_SubMenus().FindChild ("WPFControlText", "Externe", 1).Click();
   Get_WinAccountInfo_BtnOK().Click();
   
   //Valider la création du compte
    SearchClientByName(RealClient_4124);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", RealClient_4124, 10).Click();
    resultClientSearch =  Get_RelationshipsClientsAccountsGrid().FindChild("Value", RealClient_4124, 10);
        if (resultClientSearch.Exists == false){
            Log.Error("Client " + RealClient_4124+ " not found in the accounts grid.");
            }
        else {
            Log.Message("The account "+ RealClient_4124 +" exist.")
        }
    //Supprimer le client externe
     DeleteClient(clientNameExternalCROES_4124);
    
  }
  catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
  }
    
  finally{   
    Terminate_CroesusProcess();
    //Mettre la pref PREF_EXTERNAL_ACCOUNT_INSTITUTION = NO (État initial)
   Activate_Inactivate_PrefFirm("Firm_1", "PREF_EXTERNAL_ACCOUNT_INSTITUTION ", "NO", vServerAccounts);
   Activate_Inactivate_PrefFirm("Firm_1", "PREF_EXTERNAL_ACCOUNT_INSTITUTION_MANDATORY", "NO", vServerAccounts);
   RestartServices(vServerAccounts); 
  }   

}

