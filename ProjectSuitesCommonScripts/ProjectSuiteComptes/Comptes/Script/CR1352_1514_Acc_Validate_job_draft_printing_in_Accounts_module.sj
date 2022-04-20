//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions


/**
    Description : Valider l'impression du brouillon de travail dans le module Comptes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1514
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1514_Acc_Validate_job_draft_printing_in_Accounts_module()
{
    
    try {
        
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore columns default configuration.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Vérifier que la colonne 'Langue' n'est pas affichée
        
        if (Get_AccountsGrid_ChLanguage().Exists){
            Log.Error("'Language' column displayed. This is not expected.");
            return;
        }
        
        
        //Ajouter la colonne 'Langue'
    
        Log.Message("Add the 'Language' column.");
        Get_AccountsGrid_ChMargin().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
    
    
        //Vérifier que la colonne 'Langue' est affichée
        
        if (!(Get_AccountsGrid_ChLanguage().Exists)){
            Log.Error("'Language' column not displayed. This is not expected.");
            return;
        }
        
        
        //Faire Alt + P pour imprimer
        
        Log.Message("Hit 'Alt + P'");
        Get_RelationshipsClientsAccountsGrid().Keys("~p");
        
        
        //Vérifier que la boîte de dialogue "Imprimer" est affichée
        
        Log.Message("Check if the Print dialog box is displayed and if the buttons are in the expected enabled state.");
        CheckComponentExistenceAndState(Get_DlgPrint(), true, "Print dialog box");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnPrint(), true, "Print button");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnCancel(), true, "Cancel button");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnApply(), false, "Apply button");
        
        
        //Cliquer sur Annuler
        
        Log.Message("Click the cancel button in the Print dialog box.");
        Get_DlgPrint_BtnCancel().Click();
        //Get_DlgPrinting_BtnOK().Click();
        Get_DlgInformation().Click(93, 66);
        
        
        //Rétablir la configuration par défaut des colonnes
        
        Log.Message("Restore columns default configuration.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        
        //Fermer Croesus
        
        Log.Message("Close Croesus.");
        Close_Croesus_SysMenu();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
     
}




function CheckComponentExistenceAndState(componentObject, enabledValue, componentName)
{
    if (componentObject.Exists && componentObject.Visible && componentObject.Enabled == enabledValue){
        Log.Checkpoint("The " + componentName + " component was present and its enabled state was " + enabledValue);
    }
    else {
        Log.Error("The " + componentName + " component was not present or its enabled state was not the expected.");
    }
}


