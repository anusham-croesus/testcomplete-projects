//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Rel_JoinClients_To_Relationships()
{

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Rel_JoinClients_To_Relationships";
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
        
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"], 30000);
                Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        
                // Crée un compte
                CreationAccounts(clientName, IAcode);
        
                // Clique le module relations
                Get_ModulesBar_BtnRelationships().Click();
                WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);       
        
                // lie un nouveau client à une relation
                Log.Message("Join the client " + clientName + " to the relationship " + relationshipName + ".");
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
                Get_Toolbar_BtnAdd().Click();
                WaitObject(Get_Toolbar_BtnAdd_AddDropDownMenu(),"Uid", "MenuItem_2ec3");
                Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
                WaitObject(Get_CroesusApp(),"Uid", "PickerBase_dcbf", 600000);      
        
                //Choisir un client et cliquer sur OK
                Search_Client(clientName);
    
                Get_WinPickerWindow_BtnOK().Click();
                WaitObject(Get_CroesusApp(),"Uid", "RelationshipAssignationResults_5ddd", 30000);
                Get_WinAssignToARelationship_BtnYes().WaitProperty("Enabled", true, 30000);
        
                //  Mesure la performance lie un nouveau client à une relation
                StopWatchObj.Start();
                Get_WinAssignToARelationship_BtnYes().Click()
                WaitObject(Get_RelationshipsClientsAccountsDetails(), "Uid", "HierarchyPanel_8528", waitTimeShort);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WaitProperty("IsInitialized", true, 15000);
        
                // vérifie le client a été ajouté
                searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", HierarchyLabel1, 10).Find("OriginalValue", clientName, 10);
                if (searchClientInHierarchyPanel.Exists == false){
                    Log.Error("The account number " + clientName + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
                }
                else {
                    Log.Checkpoint("The account number " + clientName + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
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
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"], 30000);
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
        
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1]);
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000); 
        
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
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForAccount().set_Text(IAcode);
        Get_WinAccountInfo_BtnOK().Click();
        
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1]);
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
    
    
function DeleteClient(clientName)
{
        Log.Message("Delete client " + clientName + ". The related accounts will be automatically deleted.");

        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
        Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
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
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 30000);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            if (clientName == Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name()){
                var AccountNo = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber());
                break;
            }
        }
        
        return AccountNo;

}
