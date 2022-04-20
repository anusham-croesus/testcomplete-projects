//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CR1352_2549_Rel_Create_a_temporary_relationship


/**
    Description : Création d'une relation temporaire
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-637
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0637_Rel_Create_a_temporary_filter()
{
    var temporaryRelationshipName = "#7 TEST";
    var temporaryrelationshipAlternateName = "Test7";
    if (client == "BNC" ){
      var expectedIACode = "0AED";
    }
    else{//RJ
      var expectedIACode = "BD88";
    }
    
    try {
        Login(vServerRelations, userName, psw, language);
        
        Create_a_temporary_relationship(temporaryRelationshipName, temporaryrelationshipAlternateName);
        
        
        //Parcourir la liste des relations et remplir le tableau des résultats attendus
        
        var expectedRelationships = new Array();
        var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        for (var i = 0; i < nbOfRelationships; i++){
            var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            var displayedIACode = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_RepresentativeNumber();// YR: Avant RepresentativeNumber
            if (displayedIACode == expectedIACode){
                expectedRelationships.push(currentRelationshipName);
            }
        }
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, choisir Code de CP dans "Champs de filtre"
        //Saisir Opérateur = égal(e) à, Valeur = 0AED, puis cliquer sur Appliquer
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_IACode().Click();
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCreateFilter_TxtValue().Keys(expectedIACode);
        Get_WinCreateFilter_BtnApply().Click();
        
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
       
        DeleteRelationship(temporaryRelationshipName);
        Terminate_CroesusProcess();
    }
}