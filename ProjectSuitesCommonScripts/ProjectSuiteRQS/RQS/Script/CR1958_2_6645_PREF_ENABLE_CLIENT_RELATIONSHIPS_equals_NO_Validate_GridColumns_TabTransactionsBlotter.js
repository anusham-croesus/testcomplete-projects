//USEUNIT CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #2 : Validate Grid Columns in TransactionsBlotter Tab)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #2 : Validate Grid Columns in TransactionsBlotter Tab
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_GridColumns_TabTransactionsBlotter()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #2 - Validate Grid Columns in TransactionsBlotter Tab : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator()");
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
        
        //STEP #2 :
        //Se loguer avec KEYNEJ, Cliquer sur le bouton Risk and Compliance Manager' (bouton en forme d'oeil)
        Log.Message("Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        
        //Onglet Transaction Blotter --> Aller sur l'entête des colonnes --> Right clic  --> Default Configuration
        //Aller sur l'entête des colonnes --> Right clic --> Add column
        //Validate If the new column: 'Mgmt level' , 'Client rel. no.'  and  'Client rel. name' are not displayed in Grid of The TransactionBlotter
        var arrayOf_TransactionBlotterGrid_UnexpectedColumsHeaders = [Label_ColumnHeader_ManagementLevel, Label_ColumnHeader_ClientRelationshipName, Label_ColumnHeader_ClientRelationshipNumber];
        Log.Message("STEP #2 : Validate that the following columns are not available in Grid of The Transaction Blotter : " + arrayOf_TransactionBlotterGrid_UnexpectedColumsHeaders, arrayOf_TransactionBlotterGrid_UnexpectedColumsHeaders.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var nbOfTries = 0;
        do {
            Get_WinRQS_TabTransactionBlotter().Click();
        } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
        
        SetDefaultConfigurationForGrid(Get_WinRQS_TabTransactionBlotter_DgvTransactions());
        CheckIfColumnsHeadersAreNotAvailableForGrid(Get_WinRQS_TabTransactionBlotter_DgvTransactions(), arrayOf_TransactionBlotterGrid_UnexpectedColumsHeaders);
        
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
