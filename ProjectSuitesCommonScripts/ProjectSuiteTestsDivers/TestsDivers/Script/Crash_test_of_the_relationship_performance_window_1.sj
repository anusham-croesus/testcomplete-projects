//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables



/**
    Description : Reproduire le crash de la fenêtre Performance de Relations
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Christophe Paring
*/

function Crash_test_of_the_relationship_performance_window_1()
{
    var relationshipName = "#3 TEST";
    //relationshipName = new Array("#2 TEST", "#4 TEST", "#5 TEST");
    var nbOfIterations = 3000;
    
    try {
    
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipName);
        
        for (i = 1; i <= nbOfIterations; i++ ){
            Log.Message("Iteration : " + i + " / " + nbOfIterations);
            Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
            for (j = 1; j <= 1; j++){
                Log.Message("Clic sur l'onglet 'Graphique de performance'.");
                Get_WinPerformance_TabPerformanceGraph().Click();
                Delay(1000);
                Log.Message("Clic sur l'onglet 'Historique de performance'.");
                Get_WinPerformance_TabPerformanceHistory().Click();
                Delay(1000);
            }
            Get_WinPerformance_BtnClose().Click();
        }
        
        
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
        
        
}




function SelectRelationships(arrayOfRelationshipsNames)
{
    if ((GetVarType(arrayOfRelationshipsNames) != varArray) && (GetVarType(arrayOfRelationshipsNames) != varDispatch)){
        arrayOfRelationshipsNames = new Array(arrayOfRelationshipsNames);
    }
    
    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
        var found = false;
        for(var j = 0; j < arrayOfRelationshipsNames.length; j++){
            if (displayedRelationshipName == arrayOfRelationshipsNames[j]){ 
                found = true;
                break;
            }
        }
        
        if (found){
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
        }
        else {
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(false);
        } 
    }
}