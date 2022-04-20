//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Crash lors de supprimer une phrase prédéfinies.

                          Préconditions 
                          fbnqasit

                          Étapes
                          1. Se connecter avec DESLAUJE 
                          2. Aller au module clients/Note/ phrase prédéfinies 
                          3. Click sur le btn Supprimer

                          Résultat reçu
                          L'application crash


    Auteur : Sana Ayaz
    Anomalie:CROES-6760
    Version de scriptage:ref90-06-Be-17--V9-AT_1-co6x
*/
function CROES_6760_CliCrashWhenDeletPredefSentence()
{
    try {
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
       
        var NumberTheBugCROES6760=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumberTheBugCROES6760", language+client);
        var NumBerClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumBerClient800300", language+client);
        /*Dans le module Client
        Choisir Outils/Configurations/Catégorisation des titres
        */
         
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NumBerClient800300);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClient800300, 10).DblClick();
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        Get_WinCRUANote_GrpPredefinedSentences_BtnDelete1().Click();
        
        //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
        if(Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        else
            CheckPointForCrash(NumberTheBugCROES6760);
        Get_WinCRUANote_BtnCancel1().Click();

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}

function CheckPointForCrash(NumberTheBug)
{
  maxWaitTime = 10000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
            Log.Message("Wait for crash.");
        }
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error(NumberTheBug);
            Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, Get_DlgError().get_ActualHeight()-45);
        }
        else
            Log.Checkpoint("No crash detected.")
}
