//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables



/**
    Description : Reproduire le crash de la fenêtre Performance de Clients
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Christophe Paring
*/

function Crash_test_of_the_client_performance_window_1()
{
    var ClientNo = "800217";
    //ClientNo = new Array("800217", "800075", "300005");
    var nbOfIterations = 1000;
    
    try {
    
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(ClientNo);
        
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




function SelectClients(arrayOfClientsNos)
{
    if ((GetVarType(arrayOfClientsNos) != varArray) && (GetVarType(arrayOfClientsNos) != varDispatch)){
        arrayOfClientsNos = new Array(arrayOfClientsNos);
    }
    
    Get_ModulesBar_BtnClients().Click();
    Delay(100);
    
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        var displayedClientNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClientNumber();
        var found = false;
        for(var j = 0; j < arrayOfClientsNos.length; j++){
            if (displayedClientNo == arrayOfClientsNos[j]){ 
                found = true;
                break;
            }
        }
        
        if (found == true){
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
        }
        else {
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(false);
        } 
    }
}