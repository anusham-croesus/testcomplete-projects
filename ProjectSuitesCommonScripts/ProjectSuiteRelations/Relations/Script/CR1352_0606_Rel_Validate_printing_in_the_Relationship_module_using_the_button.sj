//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Valider l'impression dans le module Relations en utilisant le bouton
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-606
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0606_Rel_Validate_printing_in_the_Relationship_module_using_the_button()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-606", "CR1352_0606_Rel_Validate_printing_in_the_Relationship_module_using_the_button()");
        Login(vServerRelations, userName, psw, language);
        
        Log.Message("Go to the Relationships module and select nothing.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 30000);
        
        //Cliquer sur le bouton Imprimer
        Log.Message("Click on the Print button.");
        Get_Toolbar_BtnPrint().Click();
        
        //Vérifier que la boîte de dialogue "Imprimer" est affichée
        CheckPrintDialogboxAndItsButtons();
        
        //Cliquer sur Annuler
        Log.Message("Click the cancel button in the Print dialog box.");
        Get_DlgPrint_BtnCancel().Click();
        SetAutoTimeOut();
        if(Get_DlgInformation().Exists){  //
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);         
        }
        RestoreAutoTimeOut();
        //Fermer Croesus
        Close_Croesus_SysMenu();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
     
}



function CheckPrintDialogboxAndItsButtons()
{
    Log.Message("Check if the Print dialog box is displayed and if the button are in the expected enabled state.");
    CheckComponentExistenceAndState(Get_DlgPrint(), true, "Print dialog box");
    CheckComponentExistenceAndState(Get_DlgPrint_BtnPrint(), true, "Print button");
    CheckComponentExistenceAndState(Get_DlgPrint_BtnCancel(), true, "Cancel button");
    CheckComponentExistenceAndState(Get_DlgPrint_BtnApply(), false, "Apply button");
}


function CheckComponentExistenceAndState(componentObject, enabledValue, componentName)
{
 SetAutoTimeOut();
    if (componentObject.Exists && componentObject.Visible && componentObject.Enabled == enabledValue){
        Log.Checkpoint("The " + componentName + " component was present and its enabled state was " + enabledValue);
    }
    else {
        Log.Error("The " + componentName + " component was not present or its enabled state was not the expected.");
    }
    RestoreAutoTimeOut();
}
