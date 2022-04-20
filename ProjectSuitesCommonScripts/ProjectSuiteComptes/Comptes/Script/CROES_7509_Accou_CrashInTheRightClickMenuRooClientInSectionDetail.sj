﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Dans le module client
                      Sélectionner un client 
                      Dans la section détails, sélectionner un client racine
                      Faire un click droit et choisir Associer 
                      Croesus Crash 
                      Note , Le meme crash est obtenu pour les détenteurs dans la section détails du module comptes 
                      et la meme chose aussi dans le module relations,


    Auteur : Sana Ayaz
    Anomalie:CROES-7509
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_7509_Accou_CrashInTheRightClickMenuRooClientInSectionDetail()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        var OwnersCROES_7509=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "OwnersCROES_7509", language+client);
        var AccountNumb800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "AccountNumb800300NA", language+client);
        var Client800300=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "Client800300", language+client);
      
        /*Dans le module compte
        Sélectionner un compte 
        */
        Get_ModulesBar_BtnAccounts().Click();
        //Dans la section détenteurs,
        Search_Account(AccountNumb800300NA);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", AccountNumb800300NA, 10).Click();
     
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",OwnersCROES_7509,10).Find("OriginalValue",Client800300,10).Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",OwnersCROES_7509,10).Find("OriginalValue",Client800300,10).ClickR();
        
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
        
        
    // Les points de vérifications
   /*Vérifier qu'il existe pas de fenêtre autre que la fentêtre de configuartion */
      //Vérifier si le message d'erreur apparaît
        maxWaitTime = 10000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("Bug CROES-7509");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
        
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}


