//USEUNIT CR1958_8_PreparationBD_RiskRatingVerification
//USEUNIT CR1958_8_PreparationBD_RiskRatingAllocation
//USEUNIT CR1958_8_PreparationBD_Configs

NameMapping.TimeOutWarning = false;

function CR1958_8_PreparationBD()
{
    Log.Message("CR1958_8_PreparationBD()");
    
    try {
        //Configs
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\CR1958_PreparationBD_1.sql", vServerRQS);
        RestartServices(vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Delay(PROJECT_AUTO_WAIT_TIMEOUT/2);
        
        //Risk Rating Allocation
        CR1958_8_PreparationBD_RiskRatingAllocation.CR1958_8_PreparationBD_RiskRatingAllocation();
        
        //Risk Rating Allocation Verification
        CR1958_8_PreparationBD_RiskRatingVerification.CR1958_8_PreparationBD_RiskRatingVerification();
        
        //Fermer Croesus
        Close_Croesus_X();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        RestoreAutoTimeOut();
        
        //Configs
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\CR1958_PreparationBD_2.sql", vServerRQS);
        RestartServices(vServerRQS);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Sauvegarder le log
        var logFolderPath = logRootFolderPath + GetVServerReference(vServerRQS) + "\\RQS_CR1958_8_PreparationBD_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S") + "\\";
        Log.SaveResultsAs(logFolderPath, 0, 0);
    }
}
