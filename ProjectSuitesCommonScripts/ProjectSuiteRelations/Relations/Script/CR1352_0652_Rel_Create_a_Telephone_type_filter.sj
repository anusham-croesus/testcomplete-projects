//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_2549_Rel_Create_a_temporary_relationship


/**
    Description : Créer un filtre type 'Téléphone'
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-652
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0652_Rel_Create_a_Telephone_type_filter()
{
    var temporaryRelationshipName = "#7 TEST";
    var temporaryrelationshipAlternateName = "Test7";
    var expectedTelephone1 = "5144128563";
    var filterName = "test05";
    
    if(client=="RJ" || client == "US" ){
      Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","REP",vServerRelations)
      Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerRelations)// YR: Merge RJ
      RestartServices(vServerRelations)//YR: Merge RJ
    }
    
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
            Get_RelationshipsBar_BtnInfo().WaitProperty("VisibleOnScreen", true, 30000);
            Get_WinDetailedInfo_TabAddresses().Click();            
            WaitObject(Get_WinDetailedInfo_TabAddresses_GrpTelephones(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"],1000);
            
            if (Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().get_IsEnabled()){
                Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().Click();
                currentRelationshipTelephone1 = Get_WinCRUTelephone_TxtNumber().get_Text();
                Get_WinCRUTelephone_BtnCancel().Click();
                if (currentRelationshipTelephone1 == expectedTelephone1){
                    expectedRelationships.push(currentRelationshipName);
                }
            }
            
            Get_WinDetailedInfo_BtnCancel().Click();
        }
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
       
          Log.Message("Anomalie :CROES-6801  ")
         
        Get_WinCRUFilter_CmbField_Item("Téléphone", "Telephone").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedTelephone1);
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
        if(client=="RJ"){
          Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","Sysadm",vServerRelations)
          Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerRelations)//YR: Merge RJ
          RestartServices(vServerRelations)//YR: Merge RJ
        }
    }
}