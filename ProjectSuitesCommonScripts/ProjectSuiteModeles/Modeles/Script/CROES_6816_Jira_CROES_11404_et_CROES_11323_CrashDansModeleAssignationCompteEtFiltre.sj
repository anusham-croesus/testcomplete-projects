//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/*
    Analyste automatisation: Amine A.
    Anomalie:CROES-11404 et CROES-11323
    Version : 90.13.In-6_2019-09-12
*/

function CROES_6816_Jira_CROES_11404_et_CROES_11323_CrashDansModeleAssignationCompteEtFiltre()
{
    try {
                
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Modele : Ch Bonds
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModelName_6816", language+client);
        
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
                    
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsSelected", true, 10000); 

        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        
        //Cliquer sur Assigner --> Comptes
        Log.Message("Clique sur Assigner --> Comptes");
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios().WaitProperty("IsSelected", true, 10000); 
        
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
        
        //Cliquer sur le boutton Filtre (entonnoire) et selectionner 'A des segments'
        Log.Message("Clique sur Filtre --> 'A des segments'");
        Get_WinPickerWindow().Click(5,5);
        Get_WinPickerWindow_ChHasSleeves().Click();
        
        //Selectionner 'Non' --> Appliquer --> Annuler
        Log.Message("Clique sur Appliquer --> Annuler");
        Get_WinCreateFilter_TxtValue_ChNo().Click();
        Get_WinCreateFilter_BtnApply().Click();
        Get_WinPickerWindow_BtnCancel().Click();
        
        //Detecter un crash
        CheckPointForCrash(2000);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));    
    }
    finally {
        //Fermer Croesus
        Terminate_CroesusProcess(); 
    }
}
function Get_WinPickerWindow_ChHasSleeves(){
      if(language == "french")
          return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "A des segments"], 10);
      else 
          return Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Has sleeves"], 10);
      }
function Get_WinCreateFilter_TxtValue_ChNo(){
      if(language == "french") 
          return Get_WinCreateFilter().FindChild(["ClrClassName","DisplayText"],["XamTextEditor","Non"],10);
      else
          return Get_WinCreateFilter().FindChild(["ClrClassName","DisplayText"],["XamTextEditor","No"],10);
      }

function CheckPointForCrash(maxWaitTime)
{
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
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
}