//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/**
    Description : Reproduire le crash de la fenêtre Performance de Relations
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Christophe Paring
*/

function Crash_test_of_the_client_performance_window_2()
{
    
    try {
    
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Get Croesus Row count through the summation button
        Get_Toolbar_BtnSum().Click();
        croesusRowCount = Get_WinClientsSum_TxtNumberOfClients().Text;
        
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        ResultCommaSearch = aqString.Find(croesusRowCount, ",");
        if (ResultCommaSearch != -1){
            croesusRowCount = StrToInt(croesusRowCount)/100;
        }
        else {
            croesusRowCount = StrToInt(croesusRowCount);
        }
        
        Log.Message("Number of clients : " + croesusRowCount);
        
        //Select no client
        SelectClients("NO_CLIENT");
        
        //Select the first row
        Get_RelationshipsClientsAccountsGrid().Keys("[Home]");
        Get_RelationshipsClientsAccountsGrid().Keys("[Home]");
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).set_IsSelected(true);
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).set_IsActive(true);
        
        //Select each client and click on Performance button
        for (i = 0; i < croesusRowCount; i++ ){
            if (i > 0){
                Get_RelationshipsClientsAccountsGrid().Keys("[Down]");
            }
            
            var currentClientNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClientNumber();
            Log.Message("Selected client index : " + i + ". (Client No : " + currentClientNo + ")");
            
            Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
            
            if (Get_DlgCroesus().Exists){
                Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
            }
            else {
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