//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Supprimer un critère de recherche
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-747
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0747_Rel_Delete_search_criterion()
{
    var searchCriterionName = "test_CR1352_0747";
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Ajouter un critère de recherche
        
        Log.Message("Add the '" + searchCriterionName + "' search criterion.");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().set_Text(searchCriterionName);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSave().Click();
        
        
        //Supprimer le critère de recherche
        
        Log.Message("Delete the '" + searchCriterionName + "' search criterion.");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager().Parent.Maximize();
        
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
            if (displayedCriterionName == searchCriterionName){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                break;
            }
        }
        
        Get_WinSearchCriteriaManager_BtnDelete().Click();
        
        if (!(Get_DlgConfirmation().Exists)){
            Log.Error("Confirmation dialog box not displayed. This is not expected.");
            return;
        }
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        
        //Vérifier si le critère de recherche a été supprimé
        
        Log.Message("Verify that the '" + searchCriterionName + "' search criterion has been deleted.");
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        var found = false;
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
            if (displayedCriterionName == searchCriterionName){
                found = true;
                break;
            }
        }
        
        if (found){
            Log.Error("'" + searchCriterionName + "' search criterion was not deleted. This is not expected.");
            return
        }
        
        Log.Checkpoint("'" + searchCriterionName + "' search criterion deleted.");
        
        Get_WinSearchCriteriaManager().Parent.Restore();
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(searchCriterionName, vServerRelations);
        Terminate_CroesusProcess();
    }
}