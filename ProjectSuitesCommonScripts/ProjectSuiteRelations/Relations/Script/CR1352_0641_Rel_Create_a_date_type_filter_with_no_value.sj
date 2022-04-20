//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Créer un filtre type 'date' sans valeur
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-641
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0641_Rel_Create_a_date_type_filter_with_no_value()
{
    try {
        Login(vServerRelations, userName, psw, language);
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, Sélectionner le champ "Date" puis "Création"
        //puis cliquer sur le bouton Appliquer sans renseigner de valeur
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Date().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Date_CreationDate().Click();
        Get_WinCreateFilter_DtpValue().Click();
        Get_WinCreateFilter_DtpValue().Keys("[BS][BS][BS][BS][BS][BS][BS][BS][BS][BS]");
        Get_WinCreateFilter_BtnApply().Click();
        
        //La boîte de dialogue Croesus avec le message "La valeur entrée est invalide." doit apparaître
        SetAutoTimeOut()
        if (Get_DlgInformation().Exists){
            Log.Checkpoint("Croesus dialog box displayed, this is expected.");
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations, "CR1352", 95, language));// YR modif pour 78-CX avant WPFControlText
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45); //Cliquer sur OK de la boîte de dialogue Croesus
        }
        else {
            Log.Error("Croesus dialog box not displayed, this is not expected.");
        }
        RestoreAutoTimeOut();
        Get_WinCreateFilter_BtnCancel().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}

