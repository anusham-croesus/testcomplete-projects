//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Créer un filtre en maillant un item vers un autre module
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-673
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0673_Rel_Create_a_filter_by_dragging_an_item_to_another_module()
{
    var temporaryRelationshipName = "#7 TEST";
    
    try {
        Login(vServerRelations, userName, psw, language);
        
        CreateRelationship(temporaryRelationshipName);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071")
        
        //Récupérer le Numéro de la relation temporaire
        var found = false
        var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        for (var i = 0; i < nbOfRelationships; i++){
            var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            if (currentRelationshipName == temporaryRelationshipName){
                var temporaryRelationshipNumber = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_LinkNumber();
                Log.Message(temporaryRelationshipName + " relationship number is : " + temporaryRelationshipNumber);
                found = true;
                break;
            }
        }
        
        if (!found){
            Log.Error(temporaryRelationshipName + " relationship not found ; this is not expected.");
            return;
        }
        
        //Mailler la relation temporaire vers le module Client
        Log.Message("Drag the relationship No " + temporaryRelationshipNumber + " to the Clients module.");
        SearchRelationshipByName(temporaryRelationshipName);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","QuickSearchWindow_b326");
        var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", temporaryRelationshipName, 10);
        var dragDestination = Get_ModulesBar_BtnClients();
        Drag(dragSource, dragDestination);
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        
        //Vérifier le nom affiché du filtre est : "Relation(s) maillée(s) = XXXXX"
        var expectedFilterDescription = GetData(filePath_Relations, "CR1352", 116, language) + temporaryRelationshipNumber;
        Log.Message("Selon Karima il faut ignorer un espace de plus avant le nom de la relation maillée, donc le datapool a été adapté")
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, expectedFilterDescription);

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