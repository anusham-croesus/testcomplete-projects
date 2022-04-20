//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper



/**
        Description : 
                  
                       Étapes pour reproduire:
                      -Se connecter a l'application avec UNI00.
                      -Tools/Configarations/Billing/Manage validation grid
                      -dans 'Options', la section du bas de la fenêtre 'Billing Configuration', changer la valeur du champ 'Accrued I/D' a 'include in cash' ou bien a 'include in asset class'
                      -OK on constate que l'application crash.
    Anomalie:CROES-6561
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CROES_6561_CrashChangeValueAccruedIDFieldInTheValidationGrid()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        var NumberTheBugCROES_6561=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NumberTheBugCROES_6561", language+client);
        
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);//SA:Je me connecte avec KEYNEJ au lieu de UNI00 suite a la demande de SOFIA. Voir le commentaire mis par Sofia sur l'anomalie'
        ////Modification pour Include in cash
        ClickWinConfigurationsManageValidationGrid();
        Delay(1000);
        Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
        
        Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",332,language),10).Click();
        if(Get_DlgConfirmation().Exists)
        {
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        }
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        //Les points de vérifications
        CheckPointForCrash(NumberTheBugCROES_6561)
        if(  Get_WinConfigurations().Exists){
        Get_WinConfigurations().Close();}
        //Modification pour Include in asset class
        ClickWinConfigurationsManageValidationGrid();
        Delay(1000);
        Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
        
        Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",333,language),10).Click();
         if(Get_DlgConfirmation().Exists)
        {
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        }
        
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        //Les points de vérifications
        CheckPointForCrash(NumberTheBugCROES_6561)
        Terminate_CroesusProcess
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); 
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        ClickWinConfigurationsManageValidationGrid();
        Delay(1000);
        Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
        
        Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",332,language),10).Click();
        if(Get_DlgConfirmation().Exists)
        {
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        }
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Get_WinConfigurations().Close();
        Terminate_CroesusProcess
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
         Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        ClickWinConfigurationsManageValidationGrid();
        Delay(1000);
        Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
        
        Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",331,language),10).Click();
        if(Get_DlgConfirmation().Exists)
        {
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        }
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Get_WinConfigurations().Close();
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
  
