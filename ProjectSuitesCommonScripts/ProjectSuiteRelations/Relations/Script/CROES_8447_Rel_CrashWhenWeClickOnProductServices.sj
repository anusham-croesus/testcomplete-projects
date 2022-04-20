//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  Se connecter avec UNI00 
                  Dans la fenêtre Outils/ Configuration 
                  Cliquer sur Produit et service
                  Crash de croesus lorsqu'on clique sur Produit et Services de la fenêtre Configuration


    Auteur : Sana Ayaz
    Anomalie:CROES-8447
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8447_Rel_CrashWhenWeClickOnProductServices()
{
    try {
        
        if(client == "CIBC"){
            userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
            passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
            Login(vServerRelations, userNameUNI00, passwordUNI00, language);
        }
        else{
            userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            //Se connecter avec GP1859 au lieu de UNI00
            Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        }
        Get_ModulesBar_BtnRelationships().Click();
        
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        
        Get_WinConfigurations_TvwTreeview_LlbProductsAndServices().Click();
        
        
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
            Log.Error("Bug CROES-8447");
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


