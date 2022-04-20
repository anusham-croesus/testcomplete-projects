//USEUNIT SmokeTest_Common



function SmokeTest_ValiderAideEnligne_Transactions()
{
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Terminate_IEProcess();
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
        Get_MainWindow().WaitProperty("IsEnabled", true, 10000);
        
        Terminate_IEProcess();
        
        Get_MainWindow().Keys("[F1]");
        
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Transactions", language + client));
        
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