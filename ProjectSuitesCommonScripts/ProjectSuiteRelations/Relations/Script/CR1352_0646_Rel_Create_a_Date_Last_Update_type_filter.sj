//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_2549_Rel_Create_a_temporary_relationship


/**
    Description : Créer un filtre type 'date mise a jour'
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-646
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0646_Rel_Create_a_Date_Last_Update_type_filter()
{
    var temporaryRelationshipName = "#7 TEST";
    var temporaryrelationshipAlternateName = "Test7";
    var filterName = "test08";
    var dateMin = 20161001;
    
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
            var currentLastUpdateDateTime = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_LastUpdate();
            var currentLastUpdateDate = StrToInt(DateTimeToFormatStr(currentLastUpdateDateTime, "%Y%m%d"));
            if (currentLastUpdateDate > dateMin){
                expectedRelationships.push(currentRelationshipName);
            }
        }
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //Saisir Nom = test08, Accès = Utilisateur, Champ = (Date) Mise à jour, Opérateur = est ultérieur au, Valeur = 2016/10/01, puis cliquer sur OK
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("(Date) Mise à jour", "(Date) Last Update").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAfterThe().Click();
        Get_WinCRUFilter_GrpCondition_DtpValue().Click();
        Get_WinCRUFilter_GrpCondition_DtpValue().Keys("[BS][BS][BS][BS][BS][BS][BS][BS][BS][BS]");
        if (language == "french"){
            Get_WinCRUFilter_GrpCondition_DtpValue().Keys(dateMin);
        }
        else {
            Get_WinCRUFilter_GrpCondition_DtpValue().Keys(aqString.SubString(dateMin, 4, 4) + aqString.SubString(dateMin, 0, 4));
        }
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
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(temporaryRelationshipName);
        Terminate_CroesusProcess();
    }
}