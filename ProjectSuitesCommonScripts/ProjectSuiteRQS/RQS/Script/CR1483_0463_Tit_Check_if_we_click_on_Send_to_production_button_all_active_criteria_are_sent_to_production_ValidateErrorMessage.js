//USEUNIT CR1483_0463_Tit_Check_if_we_click_on_Send_to_production_button_all_active_criteria_are_sent_to_production_BtnCancel



/**
    Description : Check if we click on Send to production button, all actives criteria are sended to production - Validate error Message
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-463
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0463_Tit_Check_if_we_click_on_Send_to_production_button_all_active_criteria_are_sent_to_production_ValidateErrorMessage()
{
    try {
        var winSendToProductionExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinSendToProductionTitle", language + client);
        var invalidPasswordMessage = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SendToProductionInvalidPasswordMessage", language + client);       
        
        //1- Connect to croesus with sysadmin. Go to the Securities module click on Risk Rating Manager button then on Simulation tab.
        Log.Message("1 : Connect to croesus with sysadmin. Go to the Securities module click on Risk Rating Manager button then on Simulation tab.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //2- Click on Send to production button, check if Send Criteria to production window is displayed.
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("2 : Click on Send to production button.");
        Get_WinRiskRatingCriteriaManager_BtnSendToProduction().Click();
        Log.Message("Check if 'Send to production' window is displayed.");
        if (aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "Title", cmpEqual, winSendToProductionExpectedTitle);
        }
        
        //3- Let the password empty and click on Send to production button.
        Log.Message("Let the password empty and click on Send to production button.");
        Get_WinSendCriteriaToProduction_BtnSendToProduction().Click();
        
        //Error message "Invalide risk rating password" is displayed
        Log.Message("Check if error message 'Invalide risk rating password' is displayed");
        if (aqObject.CheckProperty(Get_DlgCroesus(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_DlgCroesus_LblMessage(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_DlgCroesus_LblMessage().Text, "OleValue", cmpEqual, invalidPasswordMessage);
            Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        }
    
        Get_WinSendCriteriaToProduction_BtnCancel().Click();
    
        //Fermer Croesus
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}
