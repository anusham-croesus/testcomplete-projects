//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions


/**
    Description : Impression des fenêtres dans le module Comptes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1515
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1515_Acc_Window_printing_in_the_Accounts_module()
{
    try {
        
        Login(vServerAccounts, userName, psw, language);
        
        Log.Message("Go to the Accounts module and click on the Info button.");
        Get_ModulesBar_BtnAccounts().Click();
        Get_AccountsBar_BtnInfo().Click()
        CheckComponentExistenceAndState(Get_WinAccountInfo(), true, "Account Info window");
        
        
        //Faire clic droit puis Imprimer
        
        Log.Message("Right-click on the Account Info window, and Print.");
        Get_WinAccountInfo().ClickR();
        Get_Win_ContextualMenu_Print().Click();
        
        
        //Vérifier que la boîte de dialogue "Imprimer" est affichée
        
        Log.Message("Check if the Print dialog box is displayed and if the button are in the expected enabled state.");
        CheckComponentExistenceAndState(Get_DlgPrint(), true, "Print dialog box");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnPrint(), true, "Print button");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnCancel(), true, "Cancel button");
        CheckComponentExistenceAndState(Get_DlgPrint_BtnApply(), false, "Apply button");
        
        
        //Cliquer sur Annuler
        
        Log.Message("Click the cancel button in the Print dialog box.");
        Get_DlgPrint_BtnCancel().Click();
        
        
        //Fermer la fenêtre Info Compte et Croesus
        
        Log.Message("Close Account Info window and Croesus.");
        Get_WinAccountInfo_BtnCancel().Click();
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


