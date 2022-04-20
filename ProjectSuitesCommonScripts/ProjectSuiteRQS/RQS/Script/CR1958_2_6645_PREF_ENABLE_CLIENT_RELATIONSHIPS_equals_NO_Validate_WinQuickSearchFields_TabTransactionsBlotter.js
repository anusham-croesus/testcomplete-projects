﻿//USEUNIT CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #6 : Validate Quick Search window Fields in TransactionsBlotter Tab)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #6 : Validate Quick Search window Fields in TransactionsBlotter Tab
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_WinQuickSearchFields_TabTransactionsBlotter()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #6 - Validate Quick Search window Fields in TransactionsBlotter Tab : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_WinQuickSearchFields_TabTransactionsBlotter()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var Label_MenuItemField_ManagementLevel             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ManagementLevel", language + client);
        var Label_MenuItemField_ClientRelationshipName      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipName", language + client);
        var Label_MenuItemField_ClientRelationshipNumber    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_MenuItemField_ClientRelationshipNumber", language + client);
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Preconditions
        CR1958_2_6645_PrepareDB();
        
        //Se loguer avec KEYNEJ, Cliquer sur le bouton Risk and Compliance Manager' (bouton en forme d'oeil)
        Log.Message("Login with " + userKEYNEJ + ". Click on Risk & Compliance Management button.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        OpenAndCheckRiskAndComplianceWindow();
        
        //STEP #6 :
        //Dans l'onglet Transaction blotter ---> faire une rechercher rapide 
        //Validate If the fields  management level,'Client relationship name' and 'Client relationship' are not displayed in Quick Search Window in Transaction Blotter
        var arrayOf_TransactionBlotterQuickSearch_UnexpectedFields = [Label_MenuItemField_ManagementLevel, Label_MenuItemField_ClientRelationshipName, Label_MenuItemField_ClientRelationshipNumber];        
        Log.Message("STEP #6 : Validate that the following fields are not displayed in Quick Search Window in Transaction Blotter : " + arrayOf_TransactionBlotterQuickSearch_UnexpectedFields, arrayOf_TransactionBlotterQuickSearch_UnexpectedFields.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys(".");
        
        var nbTries = 0; //Réessayer  au cas où la frappe de clavier n'aurait pas réussi à faire afficher la fenêtre de Recherche
        while (!Get_WinQuickSearch().Exists && ++nbTries < 5)
            Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys(".");
        
        var arrayOfAllRadioButtons = Get_WinQuickSearch().FindAllChildren(["ClrClassName", "IsVisible"], ["RadioButton", true], 10).toArray();
        if (arrayOfAllRadioButtons.length == 0)
            Log.Warning("No RadioButton found in the Quick Search window.");
        
        var arrayOfUnexpectedFieldsFound = [];
        for (var i = 0; i < arrayOfAllRadioButtons.length; i++){
            var radioButtonLabel = VarToStr(arrayOfAllRadioButtons[i].FindChild(["ClrClassName", "IsVisible"], ["TextBlock", true], 10).WPFControlText);
            if (false === CheckNotEqualsToAnyArrayItem(radioButtonLabel, arrayOf_TransactionBlotterQuickSearch_UnexpectedFields, "Transaction blotter Quick Search window field"))
            arrayOfUnexpectedFieldsFound.push(radioButtonLabel);
        }
        
        if (arrayOfUnexpectedFieldsFound.length == 0)
            Log.Checkpoint("None of the following unexpected fields was found : " + arrayOf_TransactionBlotterQuickSearch_UnexpectedFields, "None of the following unexpected fields was found : \r\n" + arrayOf_TransactionBlotterQuickSearch_UnexpectedFields.join("\r\n"));
        else
            Log.Error("The following unexpected fields were found : " + arrayOfUnexpectedFieldsFound, "The following unexpected fields were found : \r\n" + arrayOfUnexpectedFieldsFound.join("\r\n") + "\r\n\r\nUnexpected fields are : \r\n" + arrayOf_TransactionBlotterQuickSearch_UnexpectedFields.join("\r\n"));

        Get_WinQuickSearch_BtnCancel().Click();
                        
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
