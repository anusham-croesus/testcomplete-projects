//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions

/**
    Description : Anomalie CROES-7438  
    Auteur : Youlia Raisper
*/
function CROES_7438_Crash_IndustryCode()
{
    try {
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        
        var security=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "security", language+client);
        
        
        Login(vServerTitre, user, psw, language);
        Get_ModulesBar_BtnSecurities().Click();
       
        Get_SecurityGrid().Find("Value",security,10).Click();
        
        //Cliquer sur le btn Industry Code
        Get_SecuritiesBar_BtnInfo().Click();
        
        //Cliquer sur le code Industry Code
        Get_WinInfoSecurity_GrpDescription_CmbIndustryCode().Click()
        
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
            Log.Error("Bug CROES-7438");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}