//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables



/**
    Description : Valider la performance d'un client dans une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-582
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0582_Rel_Validate_a_client_performance_in_a_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0582";
    var clientName = "SAUFFERER BOYD";
    var accountName = clientName;
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        //Créer la relation
        CreateRelationship(relationshipName);
        
        //Associer le compte à la relation
        JoinAccountToRelationship(accountName, relationshipName, true);
        
        
        //Accéder au module Relations et sélectionner le nom du client dans la hiérarchie d'une relation
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        var accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", GetData(filePath_Relations, "CR1352", 51, language), 10).FindChild(["ClrClassName", "DataContext.DataItem.Name"], ["DataRecordPresenter", accountName], 10);
        
        if (!(accountsHierarchy.IsExpanded)){
            accountsHierarchy.Click(4, 10); //Cliquer sur le +
        }
        
        var ownersHierarchy = accountsHierarchy.FindChild("Description", GetData(filePath_Relations, "CR1352", 52, language), 10).FindChild("OriginalValue", clientName, 10);
        
        //Clic droit puis Performance
        ownersHierarchy.ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance().Click();
        
        //Vérifier que la fenêtre Performance est ouverte 
        Log.Message("Verify that the Performance window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinPerformance().Exists)){
            Log.Error("The Performance window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){
            aqObject.CheckProperty(Get_WinPerformance(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 54, language));
        }
        else {
            aqObject.CheckProperty(Get_WinPerformance(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 53, language));
        }
         
        //Vérifier le contenu de la fenêtre Performance et fermer la fenêtre
        CheckWinPerformanceProperties();
        Get_WinPerformance_BtnClose().Click();
        
        
        //Accéder au module Clients et sélectionner le nom du client et cliquer sur le bouton Performance
        
        Get_ModulesBar_BtnClients().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
        
        Sys.Keys(clientName);
        Get_WinQuickSearch_TxtSearch().SetText(clientName);
        Get_WinQuickSearch_BtnOK().Click();
        
        var searchResultClient = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        SetAutoTimeOut();
        if (searchResultClient.Exists == false){
            Log.Error("The client " + clientName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
        
        Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
        
        //Vérifier que la fenêtre Performance est ouverte 
        Log.Message("Verify that the Performance window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinPerformance().Exists)){
            Log.Error("The Performance window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinPerformance(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 54, language));
        
        //Vérifier le contenu de la fenêtre Performance et fermer la fenêtre
        CheckWinPerformanceProperties();
        Get_WinPerformance_BtnClose().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
        
}


function CheckWinPerformanceProperties()
{
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 55, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 56, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 57, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPerformanceCalculations_CmbPerformanceCalculations(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 58, language));
    if (client != "RJ"){
        aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 59, language));
    }
        
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1From(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 60, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1To(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 61, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2From(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 62, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2To(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 63, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3From(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 64, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3To(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 65, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4From(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 66, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4To(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 67, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 68, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 69, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 70, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 71, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 72, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 73, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 74, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 75, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 76, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 77, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 78, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 79, language));
}