//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Créer un filtre sans valeur
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-654
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0654_Rel_Create_a_filter_with_no_value()
{
    try {
        Login(vServerRelations, userName, psw, language);
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //puis cliquer directement sur le bouton OK sans renseigner de valeur
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_BtnOK().Click();
        
        //La boîte de dialogue Croesus avec le message "Veuillez choisir une condition." doit apparaître
        if (Get_DlgInformation().Exists){
            Log.Checkpoint("Croesus dialog box displayed, this is expected.");
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations, "CR1352", 104, language)); //YR modif pour 78-CX BNC avant WPFControlText
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45); //Cliquer sur OK de la boîte de dialogue Croesus
        }
        else {
            Log.Error("Croesus dialog box not displayed, this is not expected.");
        }
        
        Get_WinCRUFilter_BtnCancel().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}