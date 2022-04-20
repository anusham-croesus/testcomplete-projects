//USEUNIT SmokeTest_Common


/*
    Description : Valider l'Aide en ligne
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
    
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderAideEnligne()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderAideEnligne()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Log.Message("ValiderAideEnligne_Clients", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_RelationshipsClientsAccountsGrid().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Clients", language + client));
        
        Log.Message("ValiderAideEnligne_Comptes", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_RelationshipsClientsAccountsGrid().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Comptes", language + client));
        
        Log.Message("ValiderAideEnligne_Models", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_ModelsPlugin().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Modeles", language + client));
        
        Log.Message("ValiderAideEnligne_Portfolio", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_Portfolio_PositionsGrid().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Portefeuille", language + client));
        
        Log.Message("ValiderAideEnligne_Relationships", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_RelationshipsClientsAccountsGrid().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Relations", language + client));
        
        Log.Message("ValiderAideEnligne_Dashboard", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);
        Clear_Dashboard();
        Add_PositiveCashBalanceSummaryBoard();
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_TableauDeBord", language + client));
        
        Log.Message("ValiderAideEnligne_Securities", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        //Get_SecurityGrid().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Titres", language + client));
        
        Log.Message("ValiderAideEnligne_Transactions", "", pmNormal, logAttributes);
        Delay(5000);
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
        Delay(5000);
        Terminate_IEProcess();
        Get_MainWindow().Keys("[F1]");
        aqObject.CheckProperty(Get_HelpWindow_Title(vServerGeneral), "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AideEnLigne_Titre_Transactions", language + client));
        
        Delay(5000);
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_IEProcess();
        Terminate_CroesusProcess();
    }
}
