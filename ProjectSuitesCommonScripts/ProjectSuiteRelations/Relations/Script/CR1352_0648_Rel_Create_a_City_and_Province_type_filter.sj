//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_2549_Rel_Create_a_temporary_relationship


/**
    Description : Créer un filtre type 'Ville et province'
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-648
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0648_Rel_Create_a_City_and_Province_type_filter()
{

    var temporaryRelationshipName = "#7 TEST";
    var temporaryrelationshipAlternateName = "Test7";
    var expectedAddressCityProv = "Montreal";
    var filterName = "test04";
    
    try {
    
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
        Login(vServerRelations, userName, psw, language);
        
        Create_a_temporary_relationship(temporaryRelationshipName, temporaryrelationshipAlternateName);
        
        
        //Parcourir la liste des relations et remplir le tableau des résultats attendus
        
        var expectedRelationships = new Array();
        var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        for (var i = 0; i < nbOfRelationships; i++){
            var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsActive(true);
            Get_RelationshipsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"WindowMetricTag","LINK_NOTEBOOK")
            Get_WinDetailedInfo_TabAddresses().Click();
            Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
            currentRelationshipAddressCityProv = Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv().get_Text();
            
            
            Get_WinDetailedInfo_BtnCancel().Click();
            //WaitUntilObjectDisappears(Get_CroesusApp(),"WindowMetricTag","LINK_NOTEBOOK");  
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");        
            if (currentRelationshipAddressCityProv == expectedAddressCityProv){
                expectedRelationships.push(currentRelationshipName);
            }
        }
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("(Adresse) Ville et province", "(Address) City and Province").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedAddressCityProv);
        Get_WinCRUFilter_BtnOK().Click();
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        SetAutoTimeOut();
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        RestoreAutoTimeOut();
        
        //Vérifier que seules les relations attendues sont affichées
        
        var nbOfDisplayedRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        var nbOfExpectedRelationships = expectedRelationships.length;
        CheckEquals(nbOfDisplayedRelationships, nbOfExpectedRelationships, "The number of filtered relationships");
        
        for (var i = 0; i < nbOfDisplayedRelationships; i++){
            var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            var found = false;
            for (var j = 0; j < nbOfExpectedRelationships; j++){
                if (VarToStr(currentRelationshipName) == expectedRelationships[j]){
                    found = true;
                    break;
                }
            }
            
            if (found){
                Log.Checkpoint("The displayed relationship \"" + currentRelationshipName + "\" was expected.");
            }
            else {
                Log.Error("The displayed relationship \"" + currentRelationshipName + "\" was not expected.");
            }
        }
        
        
        //Fermer le filtre
         
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userName, psw, language);
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        DeleteRelationship(temporaryRelationshipName);
        Terminate_CroesusProcess();
    }
}