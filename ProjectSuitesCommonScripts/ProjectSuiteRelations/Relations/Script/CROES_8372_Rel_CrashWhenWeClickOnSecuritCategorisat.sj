//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Se connecter avec GP1859 
                      Dans la fenêtre Outils/Configuration 
                      Cliquer sur Catégorisation des titres 
                      Recliquer sur catégorisation des titre à droite de la fenêtre 
                      On obtient un crash 


    Auteur : Sana Ayaz
    Anomalie:CROES-8372
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8372_Rel_CrashWhenWeClickOnSecuritCategorisat()
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
        
        Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation().Click();
        Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation().Click();
        
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
            Log.Error("Bug CROES-8372");
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


