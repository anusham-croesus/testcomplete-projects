//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Supprimer un compte fictif
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1533
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1533_Acc_Delete_a_fictitious_account()
{
    var clientName = "CLIENT_FICTIF";
    var nbOfFictitiousAccounts = 3;
    
    
    try {
        /*le script a été révisé et remplace les scripts suivants: Croes-1533, Croes-1547*/
            Log.Message("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6887");
    
        Login(vServerAccounts, userName, psw, language);
        
        
        //Créer un client fictif
        
        CreateFictitiousClient(clientName);
        
        
        //Créer un compte fictif
        
        Log.Message("Create a fictitious account (" + clientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAdd().Click();
        resultClientSearch = Get_WinPickerWindow().FindChild("Value", clientName, 10);
        if (resultClientSearch.Exists == false){
            Log.Error("Client " + clientName + " not found in the picker window.");
            return;
        }
        
        Get_WinPickerWindow().FindChild("Value", clientName, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        
        //Supprimer le compte fictif
        
        Log.Message("Delete the fictitious account (" + clientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Search_AccountByName(clientName);
        resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultAccountSearch.Exists == false){
            Log.Error("Account " + clientName + " not found in the accounts grid.");
            return;
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click();
        //Get_DlgConfirmAction_BtnDelete().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        //Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
        Get_DlgConfirmation_BtnYes().Click();
        
        
        //Vérifier que le compte n'existe plus
        
        Log.Message("Verify that the fictitious account (" + clientName + ") was deleted.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_CroesusApp().Find("UID","TextBox_06a4",100).WaitProperty("IsVisible", true, 30000);
        Get_Toolbar_BtnSearch().WaitProperty("IsEnabled", true, 30000);
        Search_AccountByName(clientName);
        resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultAccountSearch.Exists == false){
            Log.Checkpoint("Fictitious account " + clientName + " was deleted.");
        }
        else {
            Log.Error("Account " + clientName + " not deleted.");
        }
        
        
        /*************************Création de plusieurs comptes fictifs ensuite les supprimer***************/
         //Créer un client fictif
        
      /*  CreateFictitiousClient(clientName);*/
        
        
        //Créer les comptes fictifs
        
        var arrayOfAccountsNames = new Array();
        for (var i = 0; i < nbOfFictitiousAccounts; i++){
            var accountName = clientName + i;
            Log.Message("Create a fictitious account (" + accountName + ").");
            Get_ModulesBar_BtnAccounts().Click();
            Get_Toolbar_BtnAdd().Click();
            resultClientSearch = Get_WinPickerWindow().FindChild("Value", clientName, 10);
            if (resultClientSearch.Exists == false){
                Log.Error("Client " + clientName + " not found in the picker window.");
                return;
            }
        
            Get_WinPickerWindow().FindChild("Value", clientName, 10).Click();
            Get_WinPickerWindow_BtnOK().Click();
            Get_WinAccountInfo_GrpAccount_TxtShortName().set_Text(accountName);
            Get_WinAccountInfo_BtnOK().Click();
            arrayOfAccountsNames.push(accountName);
        }
        
        
        //Sélectionner les comptes fictifs créés
        Search_AccountByName(clientName);
        
        Log.Message("Select all the created fictitious accounts.");
        for (var i = 0; i < (nbOfFictitiousAccounts + 5); i++){ //Faire apparaître les comptes fictifs créés
            Get_RelationshipsClientsAccountsGrid().Keys("[Up]");
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayOfAccountsNames[0], 10).Click(); //Work around pour activer le bouton Supprimer
        
        var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < rowCount; i++){
            var displayedAccountName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name();
            var found = false;
            for (var j = 0; j < arrayOfAccountsNames.length; j++){
                if (displayedAccountName == arrayOfAccountsNames[j]){ 
                    found = true;
                    break;
                }
            }
        
            if (found == true){
                Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(true);
            }
            else {
                Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(false);
            }
        
        }
        
        
        //Supprimer les comptes fictifs
        
        Log.Message("Delete the fictitious accounts.");
        Get_Toolbar_BtnDelete().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        //Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
        Get_DlgConfirmation_BtnYes().Click();
        
        
        //Vérifier que les comptes n'existent plus
        
        Log.Message("Verify that the fictitious accounts was deleted.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_CroesusApp().Find("UID","TextBox_06a4",100).WaitProperty("IsVisible", true, 30000);
        Delay(5000)
        for (var j = 0; j < arrayOfAccountsNames.length; j++){
            var accountName = arrayOfAccountsNames[j];
            resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountName, 10);
            if (resultAccountSearch.Exists == false){
                Log.Checkpoint("Fictitious account " + accountName + " was deleted.");
            }
            else {
                Log.Error("Account " + accountName + " not deleted.");
            }
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerAccounts, userName, psw, language);
        DeleteClient(clientName);
        Terminate_CroesusProcess();
    }
    
}
