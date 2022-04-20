//USEUNIT SmokeTest_Common



function SmokeTest_ValiderAideEnligne_Relations()
{
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        Get_MainWindow().WaitProperty("IsEnabled", true, 10000);
        
        Terminate_IEProcess();
        
        Get_MainWindow().Keys("[F1]");
        //Get_RelationshipsClientsAccountsGrid().Keys("[F1]");
        
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Relations", language + client));
        
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