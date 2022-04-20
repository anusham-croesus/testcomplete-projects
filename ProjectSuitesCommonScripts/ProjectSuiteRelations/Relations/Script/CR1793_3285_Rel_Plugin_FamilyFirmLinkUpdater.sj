//USEUNIT Common_functions


/**
    Description : Si un nouveau compte est ouvert sous une racine existante qui est incluse dans une relation de type ‘Famille-Firme’,
                  le nouveau compte sera ajouté à la relation par les loader.
                  Avec l’aide de plugin FamilyFirmLinkUpdater.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3285
    Auteur : Christophe Paring
*/

function CR1793_3285_Rel_Plugin_FamilyFirmLinkUpdater()
{
    try {
        var RelationDetailAccount = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "RelationDetailAccount", language + client);
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "CR1793_3285_clientNumber", language + client);
        var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "CR1793_3285_relationshipName", language + client);
        var relationshipIACode = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "CR1793_3285_relationshipIACode", language + client);
        var userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
        var passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");

        //1. Ouvrir une session avec l'utilisateur REAGAR
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        
        //Créer la relation Famille-Firme
        CreateFamilyFirmRelationship(clientNumber, relationshipName, relationshipIACode);
        
        if (Log.ErrCount > 0)
            return;
        
        
        //2. Mailer un client  qui fait partie d’une relation Famille-Firme dans le module compte.
        //Pas la peine de valider que tous les comptes de ce client sont affichés
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
        var formerArrayOfAllDisplayedAccountsNumbers = GetAllDisplayedAccountsNumbers();
        
        //3. Appuyer sur l'icône '+' pour ajouter un compte et appuyer sur ok.
        Get_Toolbar_BtnAdd().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        var newArrayOfAllDisplayedAccountsNumbers = GetAllDisplayedAccountsNumbers();
        
        //Récupérer le numéro du nouveau compte
        var arrayOfNewAccountsNumbers = new Array();
        for (var i = 0; i < newArrayOfAllDisplayedAccountsNumbers.length; i++){
            if (GetIndexOfItemInArray(formerArrayOfAllDisplayedAccountsNumbers, newArrayOfAllDisplayedAccountsNumbers[i]) == -1)
                arrayOfNewAccountsNumbers.push(newArrayOfAllDisplayedAccountsNumbers[i]);
        }
        
        if (arrayOfNewAccountsNumbers.length != 1){
            Log.Error("Expecting to have only one new account, there was : " + arrayOfNewAccountsNumbers.length, arrayOfNewAccountsNumbers);
            return;   
        }
        
        var newAccountNumber = arrayOfNewAccountsNumbers[0];
        Log.Checkpoint("The new account number '" + newAccountNumber + "' is displayed in the client '" + clientNumber + "' accounts list.");
        
        
        //4. Se connecter en SSH au vserveur et exécuter : cfLoader -FamilyFirmLinkUpdater
        //S'assurer que la commande est exécutée sans erreur.
        var errorLocalFilePath = folderPath_ProjectSuiteCommonScripts + "CR1793_3285_Rel_cfLoader_Error.txt";
        var errorFilePath = "/tmp/CR1793_3285_error.txt";
        var sshCommand = "cfLoader -FamilyFirmLinkUpdater -Firm=FIRM_1 2> " + errorFilePath;
        ExecuteSSHCommandCFLoader("CR1793", vServerRelations, sshCommand, userName);
        CopyFileFromVserver(vServerRelations, errorFilePath, errorLocalFilePath);
        
        var errorContent = Trim(aqFile.ReadWholeTextFile(errorLocalFilePath, aqFile.ctANSI));
        if (Trim(errorContent) != ""){
            Log.Error("There was error upon the execution of this SSH command : " + sshCommand, errorContent);
            return;
        }
        
        Log.Checkpoint("There was no error upon the execution of this SSH command : " + sshCommand);
        
        
        //5. Retourner dans le module Relations, Rafraîchir.
        //   Sélectionner la Relation Famille-Firme de quel fait partie le client et vérifier la liste des comptes qui sont affiché pour le client.       
        Log.Message("Check if the new account is displayed in the Details section of the Family-Firm relationship.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
        var newAccountObject = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", RelationDetailAccount, 10).Find("OriginalValue", newAccountNumber, 10);
        if (newAccountObject.Exists)
            Log.Checkpoint("The New account '" + newAccountNumber + "' is displayed in the Details section of the Family-Firm relationship '" + relationshipName + "'");
        else{
            Log.Message("CROES-10131, CR1793: Un compte manquant dans la section détail d'une relation firme famille")
            Log.Error("The New account '" + newAccountNumber + "' is not displayed in the Details section of the Family-Firm relationship '" + relationshipName + "'");}
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_MainWindow().Maximize();
        if (newAccountNumber != undefined)
            DeleteAccount(newAccountNumber);
            
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
        
}



function CreateFamilyFirmRelationship(clientNumber, relationshipName, relationshipIACode)
{
    Log.Message("Create Family-Firm relationship : client number = '" + clientNumber + "', relationship name = '" + relationshipName + "', relationship IA Code = '" + relationshipIACode + "'.");
    
    var rootsBNC_1145 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language + client);
    
    //1. Chercher le client
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
    
    // 2.clic droit sur sa racine secondaire Client800239
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", rootsBNC_1145, 10).Find("OriginalValue", clientNumber, 10).Click();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", rootsBNC_1145, 10).Find("OriginalValue", clientNumber, 10).ClickR();
    
    //3.Associer----> Relation ---> Créer une relation Famille-Firme
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
    //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click()
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
    
    //4.Oui
    Get_WinAssignToARelationship_BtnYes().Click();
    
    // 5.Renseigner Noms et code de CP(BD88)
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
    
    if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().VisibleOnScreen)
        SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), relationshipIACode);
    else
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(relationshipIACode);
    
    //6.OK
    Get_WinDetailedInfo_BtnOK().Click();
}
