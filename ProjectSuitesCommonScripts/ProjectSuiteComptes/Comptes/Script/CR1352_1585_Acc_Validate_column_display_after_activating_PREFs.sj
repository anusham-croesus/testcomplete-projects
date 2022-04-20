//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Valider l'affichage des colonnes en activant des PREF
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1585
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1585_Acc_Validate_column_display_after_activating_PREFs()
{
    try {
        
        //Activer les Prefs, Démarrer Croesus, Aller au module Comptes, et Vérifier la présence des nouvelles options de colonne
        
        Log.Message("Activate prefs : PREF_DISPLAY_CHECK_DIGIT and PREF_DISPLAY_ASC_CODE");
        //Activate_Inactivate_Pref(userName, "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerAccounts);
        //Activate_Inactivate_Pref(userName, "PREF_DISPLAY_ASC_CODE", "REP", vServerAccounts);
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerAccounts);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_ASC_CODE", "REP", vServerAccounts);
        RestartServices(vServerAccounts);
        
        Log.Message("Login to Croesus and go to the Accounts module.");
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Log.Message("Right-click on a column header and click on Add column item");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        
        CheckMenuItemExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CheckDigit(), "Check Digit");
        CheckMenuItemExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Product(), "Product");
        CheckMenuItemExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_SecondaryProduct(), "Secondary Product");
        
        Log.Message("Close Croesus");
        Close_Croesus_SysMenu();
        
        
        //Désactiver les Prefs, Démarrer Croesus, Aller au module Comptes, et Vérifier la présence des nouvelles options de colonne
        
        Log.Message("Disable prefs : PREF_DISPLAY_CHECK_DIGIT and PREF_DISPLAY_ASC_CODE");
        //Activate_Inactivate_Pref(userName, "PREF_DISPLAY_CHECK_DIGIT", "NO", vServerAccounts);
        //Activate_Inactivate_Pref(userName, "PREF_DISPLAY_ASC_CODE", "", vServerAccounts);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "NO", vServerAccounts);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_ASC_CODE", "", vServerAccounts);
        RestartServices(vServerAccounts);
        
        Log.Message("Login to Croesus and go to the Accounts module.");
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Log.Message("Right-click on a column header and click on Add column item");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        
        CheckMenuItemNonExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CheckDigit(), "Check Digit");
        CheckMenuItemNonExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Product(), "Product");
        CheckMenuItemNonExistence(Get_AccountsGrid_ColumnHeader_ContextualMenuItem_SecondaryProduct(), "Secondary Product");
        
        Log.Message("Close Croesus");
        Close_Croesus_SysMenu();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus si ouverte
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "NO", vServerAccounts); //Désactiver la pref PREF_DISPLAY_CHECK_DIGIT
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_ASC_CODE", "", vServerAccounts); //Désactiver la pref PREF_DISPLAY_ASC_CODE
    }
}




function CheckMenuItemExistence(menuItemObject, menuItemName)
{
    if (menuItemObject.Exists){
        Log.Checkpoint("The " + menuItemName + " menu item was present.");
    }
    else {
        Log.Error("The " + menuItemName + " menu item was not present.");
    }
}



function CheckMenuItemNonExistence(menuItemObject, menuItemName)
{
    if (menuItemObject.Exists){
        Log.Error("The " + menuItemName + " menu item was present.");
    }
    else {
        Log.Checkpoint("The " + menuItemName + " menu item was not present.");
    }
}