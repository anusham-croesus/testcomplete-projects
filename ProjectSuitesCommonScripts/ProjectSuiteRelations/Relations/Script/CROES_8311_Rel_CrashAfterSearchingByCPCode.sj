//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Dans le module clients par exemple , faire une recherche par code CP 
                      croesus crash. L'anomalie est présente pour les modules suivants:Clients,Comptes et Relations.


    Auteur : Sana Ayaz
    Anomalie:CROES-8311
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8311_Rel_CrashAfterSearchingByCPCode()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
       
        var RelationNameCROES_7509=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RelationNameCROES_7509", language+client);
        var DetailComptesRelaCROES_7509=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DetailComptesRelaCROES_7509", language+client);
        var Account800256FS=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "Account800256FS", language+client);
        var NumberTheBug=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberTheBug", language+client);
        var IACodeCROES_8311=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACodeCROES_8311", language+client);
        /*Dans le module Relation
        faire une recherche par code CP 
        */
         
        Get_ModulesBar_BtnRelationships().Click();
        // Faire la recherche a partir du bouton de recherche pour le code de CP :BD88
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(IACodeCROES_8311);
        Get_WinRelationshipsQuickSearch_RdoIACode().set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
        
        //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
        
        CheckPointForCrash(NumberTheBug);
       
        //Afficher la fenêtre de recherche a partir du'une touche du clavier fGet_MainWindow().Keys("F");
		Get_ModulesBar_BtnRelationships().Click();
        Get_MainWindow().Keys("F");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(IACodeCROES_8311);
        Get_WinRelationshipsQuickSearch_RdoIACode().set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
        //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
         CheckPointForCrash(NumberTheBug);
         
        //afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search
		Get_ModulesBar_BtnRelationships().Click();
        Get_MenuBar_Edit().OpenMenu()
        Get_MenuBar_Edit_Search().Click() 
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(IACodeCROES_8311);
        Get_WinRelationshipsQuickSearch_RdoIACode().set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
         //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
         CheckPointForCrash(NumberTheBug);
        
    // Les points de vérifications

      
     
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

