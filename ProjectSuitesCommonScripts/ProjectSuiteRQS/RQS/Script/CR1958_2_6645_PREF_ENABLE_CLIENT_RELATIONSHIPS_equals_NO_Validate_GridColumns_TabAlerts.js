//USEUNIT CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #3 : Validate Grid Columns in Alerts Tab)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #3 : Validate Grid Columns in Alerts Tab
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_GridColumns_TabAlerts()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #3 - Validate Grid Columns in Alerts Tab : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_GridColumns_TabAlerts()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var Label_ColumnHeader_ManagementLevel              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ManagementLevel", language + client);
        var Label_ColumnHeader_ClientRelationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipName", language + client);
        var Label_ColumnHeader_ClientRelationshipNumber     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipNumber", language + client);
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Precondition
        CR1958_2_6645_PrepareDB();
        
        //Se loguer avec KEYNEJ, Cliquer sur le bouton Risk and Compliance Manager' (bouton en forme d'oeil)
        Log.Message("Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        
        //STEP #3 :
        //Cliquer sur l'onglet Alerts --> Aller sur l'entête des colonnes --> Right click --> Add Column
        //'Mgmt level' , 'Client rel. no.'  and  'Client rel. name' are not displayed in Grid of The Alerts
        var arrayOf_AlertsGrid_UnexpectedColumsHeaders = [Label_ColumnHeader_ManagementLevel, Label_ColumnHeader_ClientRelationshipName, Label_ColumnHeader_ClientRelationshipNumber];
        Log.Message("STEP #3 : Validate that the following columns are not available in Grid of The Alerts. : " + arrayOf_AlertsGrid_UnexpectedColumsHeaders, arrayOf_AlertsGrid_UnexpectedColumsHeaders.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var nbOfTries = 0;
        do {
            Get_WinRQS_TabAlerts().Click();
        } while (++nbOfTries < 3 && !Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, 40000))        
        
        CheckIfColumnsHeadersAreNotAvailableForGrid(Get_WinRQS_TabAlerts_DgvAlerts(), arrayOf_AlertsGrid_UnexpectedColumsHeaders);
        
        //Close Croesus
        Get_WinRQS().Parent.Keys("[Esc]");
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        CR1958_2_6645_RestoreDB();
    }
}
