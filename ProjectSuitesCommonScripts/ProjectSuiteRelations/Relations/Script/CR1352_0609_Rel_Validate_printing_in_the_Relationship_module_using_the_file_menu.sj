//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CR1352_0606_Rel_Validate_printing_in_the_Relationship_module_using_the_button


/**
    Description : Valider l'impression dans le module Relations en utilisant le menu Fichier
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-609
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0609_Rel_Validate_printing_in_the_Relationship_module_using_the_file_menu()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-609", "CR1352_0609_Rel_Validate_printing_in_the_Relationship_module_using_the_file_menu()");
        Login(vServerRelations, userName, psw, language);
        
        Log.Message("Go to the Relationships module and select nothing.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 30000);
        
        //Menu Fichier - Imprimer
        Log.Message("Click File menu and Print");
        Get_MenuBar_File().Click();
        Get_MenuBar_File_Print().Click();
        
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