//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT DBA



/**
    Description : Se connecter avec copern
                  Ajouter un client externe ou fictif 
                  Mailler le client externe vers le module compte 
                  Cliquer sur + pour ajouter un compte externe ou fictif 
                  Croesus crash
                  
        Numéro de l'anomalie:CROES-9495.
        Version de scriptage:ref90-07-Co-6--V9-Be_1-co6x
        Auteur : Sana Ayaz
*/
function CROES_9495_CrashApplicToAddExternAccounOrFictious()
{
    try {
        
        
        //Se connecter avec Copern et aller au module Comptes
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         var clientNameExternCROES_9495=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "clientNameExternCROES_9495", language+client);
         var clientNameFictifCROES_9495=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "clientNameFictifCROES_9495", language+client);
         var IACodeCROESExtern_9495=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "IACodeCROESExtern_9495", language+client);
         var clientNumberExternCROES_9495=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "clientNumberExternCROES_9495", language+client);
         var clientNumberFictifCROES_9495=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "clientNumberFictifCROES_9495", language+client)
         
         Log.Message(language+client)
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
        
         //Ajouter un client externe
        CreateExternalClient(clientNameExternCROES_9495, IACodeCROESExtern_9495)
       //Mailler le client externe vers le module compte
       Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameExternCROES_9495, 10).Click();
       Get_MenuBar_Modules().Click();
       Get_MenuBar_Modules_Accounts().Click();
       Get_MenuBar_Modules_Accounts_DragSelection().Click();
       //Cliquer sur + pour ajouter un compte externe ou fictif 
       Get_Toolbar_BtnAdd().Click();
       //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée a l'écrasn' 
       aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
       aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
       Log.Message("CROES-9495")
       Get_WinDetailedInfo_BtnCancel().Click();     
       
       //Ajouter un client fictif
       CreateFictitiousClient(clientNameFictifCROES_9495);
       WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071")
         
       //Mailler le client externe vers le module compte
       Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNameFictifCROES_9495, 10).Click();
       Get_MenuBar_Modules().Click();
       Get_MenuBar_Modules_Accounts().Click();
       Get_MenuBar_Modules_Accounts_DragSelection().Click();
       //Cliquer sur + pour ajouter un compte externe ou fictif 
       Get_Toolbar_BtnAdd().Click();
       //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée a l'écrasn' 
       aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
       aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
       Log.Message("CROES-9495")
       Get_WinDetailedInfo_BtnCancel().Click();
       
       
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
        DeleteClient(clientNameExternCROES_9495);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",15000)
        DeleteClient(clientNameFictifCROES_9495);
        Terminate_CroesusProcess(); //Fermer Croesus
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
        DeleteClient(clientNameExternCROES_9495);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",15000)
        DeleteClient(clientNameFictifCROES_9495);
        Terminate_CroesusProcess(); //Fermer Croesus
    
    }
}

