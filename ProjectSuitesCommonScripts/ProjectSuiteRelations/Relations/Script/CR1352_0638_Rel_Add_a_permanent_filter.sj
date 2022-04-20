//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_2549_Rel_Create_a_temporary_relationship
//USEUNIT CR1352_0639_Rel_Delete_a_permanent_filter


/**
    Description : Ajouter un filtre permanent
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-638
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0638_Rel_Add_a_permanent_filter()
{
    var temporaryRelationshipName = "#7 TEST";
    var temporaryrelationshipAlternateName = "Test7";
    if (client == "CIBC" || client == "BNC"  || client == "US" ){
      var expectedIACode = "0AED";
    }
    else{//RJ
      var expectedIACode = "BD88";
    }
    var filterName = "test01";
    var filterNewName = "test0669_edited";
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
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //Saisir Nom = test01, Accès = Utilisateur, Champ = Code de CP, Opérateur = égal(e) à, Valeur = 0AED, puis cliquer sur OK
        
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
//        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
         
/********************************************   CR1352_0669_Rel_Edit_a_filter  ************************************************************************/        
     //Vérifier que le filtre "test0669" existe et que le filtre "test0669_edited" n'existe pas
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
          var filterFound = SearchFilter(filterName);
          if (!filterFound){
              Log.Error(filterName + " filter not found ; this is not expected.");
              return;
          }
          else {
              Log.Checkpoint(filterName + " filter found ; this is expected.");
          }
        
          filterFound = SearchFilter(filterNewName);
          if (!filterFound){
              Log.Checkpoint(filterNewName + " filter not found ; this is expected.");
          }
          else {
              Log.Error(filterNewName + " filter found ; this is not expected.");
              return;
          }
        
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        
          //Cliquer sur l'icône du crayon dans le filtre sur la barre en haut
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 40, 10);
        
          //Vérifier que la fenêtre "Modifier un filtre" est ouverte
           SetAutoTimeOut();
          if (!(Get_WinCRUFilter().Exists)){
              Log.Error("WinCRUFilter window not displayed ; this is not expected.");
              return;
          }
           RestoreAutoTimeOut();
          aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 113, language));
        
        
          //Changer le nom du filtre et valider avec le bouton OK
          Get_WinCRUFilter_GrpDefinition_TxtName().Clear();
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterNewName);
          Get_WinCRUFilter_BtnOK().Click();
        
          //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
             SetAutoTimeOut();

          if (Get_DlgWarning().Exists){
              Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
          }
        RestoreAutoTimeOut();
        
          //Vérifier que le filtre "test0669" n'existe plus et que le filtre "test0669_edited" existe
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
          filterFound = SearchFilter(filterName);
          if (!filterFound){
              Log.Checkpoint(filterName + " filter not found ; this is expected.");
          }
          else {
              Log.Error(filterName + " filter found ; this is not expected.");
          }
        
          var filterFound = SearchFilter(filterNewName);
          if (!filterFound){
              Log.Error(filterNewName + " filter not found ; this is not expected.");
          }
          else {
              Log.Checkpoint(filterNewName + " filter found ; this is expected.");
          }
        
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        
          //Fermer le filtre
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);     
/********************************************  CR1352_0639_Rel_Delete_a_permanent_filter  ************************************************************************/        
           
        //Cliquer sur le bouton Filtres Y, cliquer sur "Gérer les filtres"
        //Sélectionner le filtre créé et cliquer sur le bouton "Supprimer"
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        var filterFound = SearchFilter(filterNewName);
        if (!filterFound){
            Log.Error(filterNewName + " filter not found ; this is not expected.");
            return;
        }
        
        filterIndex = filterFound[1];
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(filterIndex).set_IsSelected(true);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(filterIndex).set_IsActive(true);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
        
        SetAutoTimeOut();
        if (!(Get_DlgConfirmation().Exists)){
            Log.Error("Confirmation dialog box not displayed. This is not expected.");
            return;
        }
        RestoreAutoTimeOut();

        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        var filterFound = SearchFilter(filterNewName);
        if (!filterFound){
            Log.Checkpoint(filterNewName + " filter not found after deletion ; this is expected.");
        }
        else {
            Log.Error(filterNewName + " filter found after deletion ; this is not expected.");
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userName, psw, language);
    }
    finally {
        Delete_FilterCriterion(filterNewName, vServerRelations);
        DeleteRelationship(temporaryRelationshipName);
        Terminate_CroesusProcess();
    }
}