//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : 
        Connecter à Croesus avec DARWIC user et croesus password. 
        -dans le menu de crouses clique sur le bouton RQS et sélectionner la date 01/25/2010 . 
        -Enter AC42 et cocher IA code. 
        Résultat attendu: 
        ICode AC42 est selectionné 

        Résultat obtenu: 
        l'application crash 

      note: l'application crash peut import la valeur du IA code

    
    Auteur : Sana Ayaz
    Anomalie:CROES-9426
    Version de scriptage:ref90-06-11--V9-AT_1-co6x
*/

function CROES_9426_CrashAfterQuickSearchInGridTranswithIACod()
{
    try {
    
        userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        var IACODECROES9426 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Anomalies", "IACODECROES9426", language + client);
        var NumberTheBugCROES9426 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Anomalies", "NumberTheBugCROES9426", language + client);
        //Login
        Login(vServerRQS, userNameDARWIC, passwordDARWIC, language);

        //dans le menu de crouses clique sur le bouton RQS et sélectionner la date 01/25/2010 .
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Get_Toolbar_BtnRQS().Click();
        Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().DblClick();
        Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().Keys("01252010");
        Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("F"); 
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(IACODECROES9426);
        Get_WinQuickSearch_RdoIACode().ClickButton();
        Get_WinQuickSearch_BtnOK().Click();
       
       //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
        
        CheckPointForCrash(NumberTheBugCROES9426);
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
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
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error(NumberTheBug);
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
}
