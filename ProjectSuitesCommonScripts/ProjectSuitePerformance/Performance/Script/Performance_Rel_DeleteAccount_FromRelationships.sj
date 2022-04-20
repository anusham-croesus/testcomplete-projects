//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Rel_DeleteAccount_FromRelationships()
{
    
            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Rel_DeleteAccount_FromRelationships";
//            var clientName = GetData(filePath_Performance, sheetName_DataBD, 12, language);
//            var relationshipName = GetData(filePath_Performance, sheetName_DataBD, 13, language);
//            var IAcode = GetData(filePath_Performance, sheetName_DataBD, 14, language);   
//            var HierarchyLabel1 = GetData(filePath_Performance, sheetName_DataBD, 15, language);
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);

            var clientName       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ClientName", language+client); 
            var IAcode           = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "IACode", language+client);
            var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "RelationshipNo", language+client); 
            var HierarchyLabel1  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "HierarchyTitle", language+client); 
            var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
    
            try {
        
                // Se connecte
                Login(vServerPerformance, userNamePerformance, pswPerformance, language);
                
                // Crée un client
                CreateFictitiousClient(clientName, IAcode);
        
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 30000);
        
                // Crée un compte
                CreationAccounts(clientName, IAcode);
                
                Get_Toolbar_BtnSearch().Click();
                Get_WinQuickSearch_TxtSearch().SetText(clientName);
                Get_WinAccountsQuickSearch_RdoName().set_IsChecked(true);
                Get_WinQuickSearch_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326", waitTimeShort);
                // Récupere le numéro de comptes
                var accountNo = Get_AccountNumber(clientName);
                Log.Message("numero de comptes est:" + accountNo)
        
                JoinAccountToRelationship(accountNo, relationshipName);
        
                //Sélectionner la relation
                Log.Message("Select '" + relationshipName + "' relationship.");
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
                //Dans la hiérarchie de la relation, faire clic droit sur le compte puis Retirer de la relation
                Log.Message("In the relationship hierarchy, right-click on the the account No " + accountNo + " and click on Remove from the relationship.");
                //var accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", "Accounts", 10).FindChild(["ClrClassName", "DataContext.DataItem.DisplayAccountNumber"], ["DataRecordPresenter", accountNo], 10);
                accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value", accountNo, 100);
                accountsHierarchy.ClickR();
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1]);

                //  Mesure la performance enlever un compte à une relation
                StopWatchObj.Start();
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);

                //Vérifier que le compte retiré ne figure plus dans la hiérarchie de la relation
                Log.Message("Check that the account No" + accountNo + " has been actually removed from the relationship hierarchy.");
                accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", HierarchyLabel1, 10).FindChild(["ClrClassName", "DataContext.DataItem.DisplayAccountNumber"], ["DataRecordPresenter", accountNo], 10);
                if (accountsHierarchy.Exists){
                    Log.Error("Account No " + accountNo + " has not been removed from " + relationshipName + " relationship.");
                }
                else {
                    Log.Checkpoint("Account No " + accountNo + " has been removed from " + relationshipName + " relationship.");
                }
                StopWatchObj.Stop();
        
                // Écrit le résultat dans le fichier excel
                Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
                var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
                WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());        

                Terminate_CroesusProcess();
                Terminate_IEProcess();
        
            }
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
                Terminate_CroesusProcess();
                Login(vServerPerformance, userNamePerformance, pswPerformance, language);             
                DeleteAccounts(clientName);
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
                Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
                DeleteClient(clientName);
                Terminate_CroesusProcess();
                Terminate_IEProcess();
            }
}


function CreateFictitiousClient(clientName, IAcode)

    {
        Log.Message("Create a fictitious client (" + clientName + ").");
        
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
        Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_CreateFictitiousClient().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(clientName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().set_Text(IAcode);
        Get_WinDetailedInfo_BtnOK().Click();
        
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsLoaded", true, 15000); 
        
        searchClient = Get_RelationshipsClientsAccountsGrid().Find("Value", clientName, 10);
        if (searchClient.Exists == false){
            Log.Error("The client " + clientName + " no exist." + "numero d'anomalie: CROES-6181");
        }
        else {
            Log.Checkpoint("The client " + clientName + " was found in the client list.");
        }
    }
    
function CreationAccounts(clientName, IAcode)

    {
        Log.Message("Create a account under the client (" + clientName + ").");
        
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAdd().Click();
        
        Search_Client(clientName);
        Get_WinPickerWindow().FindChild("Value", clientName, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForAccount().set_Text(IAcode);
        Get_WinAccountInfo_BtnOK().Click();
        
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsLoaded", true, 15000); 
        
        searchAccount = Get_RelationshipsClientsAccountsGrid().Find("Value", clientName, 10);
        if (searchAccount.Exists == false){
            Log.Error("The account " + clientName + " no exist." + "numero d'anomalie: CROES-6181");
        }
        else {
            Log.Checkpoint("The account " + clientName + " was found in the client list.");
        }
        
    }    
    
function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForAccount(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}    
    
function DeleteAccounts(clientName)

    {
        Log.Message("Delete a account under the client (" + clientName + ").");
        
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();       
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 30000);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Search_Account(clientName);
        
        resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultAccountSearch.Exists == true){
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
          resultAccountSearch.WaitProperty("Exists", false, 60000);  
        }
        else {
            Log.Message("The client " + clientName + " does not exist.");
        }
        
        /*if (resultAccountSearch.Exists == false){
            Log.Checkpoint("The account " + clientName + " has been deleted.");
        }     
        else {
            Log.Error("The account " + clientName + " was found in the client list.");
        }*/

    }      
    
    
/*function DeleteClient(clientName)
{
        Log.Message("Delete client " + clientName + ". The related accounts will be automatically deleted.");

        Get_ModulesBar_BtnClients().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "15"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        Search_Client(clientName);
    
        resultClientSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultClientSearch.Exists == true){
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
            Get_Toolbar_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
            resultAccountSearch.WaitProperty("Exists", false, 60000);    
        }   
        else {
            Log.Message("The client " + clientName + " does not exist.");
        }
    
        /*if (resultClientSearch.Exists == false){
            Log.Checkpoint("The client " + clientName + " has been deleted.");
        }
        else {
            Log.Error("The client " + clientName + " was found in the client list.");
        }*/
    
//}

function DeleteClient(clientName)
{
    Log.Message("Delete client " + clientName + ". The related accounts will be automatically deleted.");

    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    SearchClientByName(clientName);
    resultClientSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
    if (resultClientSearch.Exists == true){
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        //Get_DlgConfirmAction_BtnDelete().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", "1"]);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
        resultClientSearch.WaitProperty("Exists", false, 60000);
    }
    else
        Log.Message("The client " + clientName + " does not exist.");
}

function Search_Client(clientName)
{
      Sys.Keys(clientName);
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
      Get_WinQuickSearch_TxtSearch().SetText(clientName);
      Get_WinClientsQuickSearch_RdoName().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
}

function Search_Account(clientName)
{
      Sys.Keys(clientName);
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
      Get_WinQuickSearch_TxtSearch().SetText(clientName);
      Get_WinClientsQuickSearch_RdoName().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
}

function Get_AccountNumber(clientName)
{
        Get_ModulesBar_BtnAccounts().Click();       
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 15000);

        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            if (clientName == Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name()){
                var AccountNo = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber());
                break;
            }
        }
        
        return AccountNo;

}


function JoinAccountToRelationship(accountNameOrNumber, relationshipName)
{
    Log.Message("Join the account " + accountNameOrNumber + " to the relationship " + relationshipName + ".");
    
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
    Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
    Get_ModulesBar_BtnRelationships().Click();
    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
    Sys.Keys(relationshipName);
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 30000);
    Get_WinQuickSearch_TxtSearch().SetText(relationshipName);
    Get_WinRelationshipsQuickSearch_RdoRelationshipNo().Click();
    //Get_WinRelationshipsQuickSearch_RdoName.set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
    
    searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (searchResultRelationship.Exists == false){
        Log.Error("The relationship " + relationshipName + " was not displayed.");
        return false;
    }
        
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
    Get_Toolbar_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid", "ContextMenu_8804", 30000); 
    Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Click();
    WaitObject(Get_CroesusApp(),"Uid", "PickerBase_dcbf", 30000); 
        
    //Vérifier que la fenêtre Comptes est ouverte
    Log.Message("Verify that he picker window is displayed.");
    if (!(Get_WinPickerWindow().Exists)){
        Log.Error("The picker window was not displayed.");
        return false;
    }
  
    //Choisir un compte et cliquer sur OK
    Sys.Keys(accountNameOrNumber);
    WaitObject(Get_CroesusApp(),"Uid", "QuickSearchWindow_b326"); 
    Get_WinQuickSearch_TxtSearch().SetText(accountNameOrNumber);
    Get_WinQuickSearch_BtnOK().Click();
    WaitObject(Get_WinPickerWindow(),["ClrClassName", "WPFControlOrdinalNo", "Text"], ["XamTextEditor", 1, accountNameOrNumber]); 
    Get_WinPickerWindow().FindChild("Value", accountNameOrNumber, 100).Click();
    Get_WinPickerWindow_BtnOK().Click();
        
    //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
    Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
    if (!(Get_WinAssignToARelationship().Exists)){
        Log.Error("The 'Assign to a relationship' window was not displayed.");
        return false;
    }
        
    Get_WinAssignToARelationship_BtnYes().Click();
    
    return true;
}