//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Créer un filtre avec le même nom et le même accès
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-664
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0664_Rel_Create_a_filter_with_the_same_name_and_access()
{
    var expectedIACode = "0AED";
    var filterName = "test0664";
    
    try {
        
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
        Login(vServerRelations, userName, psw, language);
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //Créer un filtre avec un accès Utilisateur
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
        Get_WinCRUFilter_BtnOK().Click();
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
        
        //Créer un autre filtre de même nom que précédemment avec le même accès Utilisateur
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
        Get_WinCRUFilter_BtnOK().Click();
        Log.Message("Le numéro de l'anomalie qui est trouvé sur CX:CROES-7951")
        
        //La boîte de dialogue Croesus avec le message "Un filtre a déjà été enregistré sous ce nom" doit apparaître
        if (Get_DlgWarning().Exists){
            Log.Checkpoint("Croesus dialog box displayed, this is expected.");
            
            //Le CheckProperty en utilisant le fichier Excel ne fonctionne pas
            //aqObject.CheckProperty(Get_DlgCroesus_LblMessage(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "CR1352", 107, language));
            Log.Message("CROES-4495")
            var expectedMessage;
            if (language == "french"){
                expectedMessage = "Un filtre a déjà été enregistré sous ce nom.\r\nVeuillez vérifier le nom du filtre dans les deux langues." //EM : modifié selon le Jira CROES-4495 - avant: "les noms"
            }
            else {
                expectedMessage = "A filter has already been saved under this name.\r\nVerify the filter name in both languages." //EM : modifié selon le Jira CROES-4495 - avant: "the names"
            }
            aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, expectedMessage);
            
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45); //Cliquer sur OK de la boîte de dialogue Croesus
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
        Delete_FilterCriterion(filterName, vServerRelations);
        Terminate_CroesusProcess();
    }
}