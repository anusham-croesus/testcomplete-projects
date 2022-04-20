//USEUNIT CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #5 : Validate Filter Menu Fields in TransactionsBlotter Tab)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #5 : Validate Filter Menu Fields in TransactionsBlotter Tab
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_FilterMenuFields_TabTransactionsBlotter()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #5 - Validate Filter Menu Fields in TransactionsBlotter Tab : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_FilterMenuFields_TabTransactionsBlotter()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var Label_MenuItemField_ManagementLevel             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ManagementLevel", language + client);
        var Label_MenuItemField_ClientRelationshipName      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipName", language + client);
        var Label_MenuItemField_ClientRelationshipNumber    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipNumber", language + client);
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Precondition
        CR1958_2_6645_PrepareDB();
        
        //Se loguer avec KEYNEJ, Cliquer sur le bouton Risk and Compliance Manager' (bouton en forme d'oeil)
        Log.Message("Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        
        //STEP #5 :
        //Dans la fenêtre Risk & Compliance Manager --> onglet Transaction Blotter --> cliquer sur le bouton filtre (entonnoir avec +)
        //Validate If the fields  'Management level', 'Client relationship name' and 'Client relationship number' are not displayed in the filters RQS.
        var arrayOf_TransactionBlotterFilter_UnexpectedFields = [Label_MenuItemField_ManagementLevel, Label_MenuItemField_ClientRelationshipName, Label_MenuItemField_ClientRelationshipNumber];
        Log.Message("STEP #5 : Validate that the following fields are not displayed in the filters RQS : " + arrayOf_TransactionBlotterFilter_UnexpectedFields, arrayOf_TransactionBlotterFilter_UnexpectedFields.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var nbOfTries = 0;
        do {
            Get_WinRQS_TabTransactionBlotter().Click();
        } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
        
        Get_WinRQS_TabTransactionBlotter_BtnFilter().Click();
        var numTry = 0; //Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la le menu contextuel de façon persistante
        while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 2000, 2500))
            Get_WinRQS_TabTransactionBlotter_BtnFilter().Click();
        
        CheckUnexpectedLabelsInSubMenusContextMenu(arrayOf_TransactionBlotterFilter_UnexpectedFields);
                
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
