//USEUNIT SmokeTest_Common



function SmokeTest_ValiderAideEnligne_TableauDeBord()
{
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 100000);
        Clear_Dashboard();
        Add_PositiveCashBalanceSummaryBoard();
        Get_MainWindow().WaitProperty("IsEnabled", true, 10000);
        
        Terminate_IEProcess();
        
        Get_MainWindow().Keys("[F1]");
        
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_TableauDeBord", language + client));
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_IEProcess();
        Terminate_CroesusProcess();
    }
}
