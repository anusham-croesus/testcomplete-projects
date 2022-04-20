//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Jira Xray   : TCVE-3340
    Description : Valider les filtres rapides et les critères de recherche simples sur les champs Nieau de gestion et offside	
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : A.A
    Version: 90.21-21
**/

function TCVE_3340_ValidateQuickFilterAndSearchCriterion()
{
    var logEtape1, logEtape2, logRetourEtatInitial;
    try {               
        Log.Link("https://jira.croesus.com/browse/TCVE-3340","Lien du Cas de test sur Jira Xray");
        Log.Link("https://jira.croesus.com/browse/TCVE-3356","Lien de la tâche sur Jira Xray");

        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
  
        var Offside           = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_Offside", language+client);
        var managementLevel   = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_managementLevel", language+client);
        var operatorAmong     = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_operatorAmong", language+client);
        var operatorExcluding = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_operatorExcluding", language+client);
        var yesValue          = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_yesValue", language+client);
        var manageFilter      = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_manageFilter", language+client);
        var balance           = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3340_Balance", language+client);
        
        var OffsideFilter         = "Offside=Yes";
        var managementLevelFilter = "managementLevel=Client"
        
        // Étape 1
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Rouler les cfLoaders se connacter avec KEYNEJ");

        ExecuteSSHCommandCFLoader("TCVE_3340", vServerRCMGenerique, "cfLoader -RCMManagementLevel", "aminea");
        ExecuteSSHCommandCFLoader("TCVE_3340", vServerRCMGenerique, "cfLoader -RCMPortfolioGenerator --Entities=ACCOUNT,CLIENT", "aminea");
        
        //Se connecter avec KEYNEJ
        Login(vServerRCMGenerique, userNameKEYNEJ, passwordKEYNEJ, language);
       
        //Accès au module Comptes 
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        //Ajouter les colonnes "Hors tolérance" et "Niveau de gestion"
        Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), Offside);
        Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), managementLevel);

// Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Valider que les champs 'Hors Tolérance' et 'niveau de gestion' sont affichés dans le menu entonoire.");
         
        Get_RelationshipsClientsAccountsGrid().Click(8, 8)
          
        var SubMenu = Get_SubMenus().WPFObject("ContextMenu", "", 1);
        var count = SubMenu.ChildCount;
        var isFound = 0;
        for (i=0; i<count; i++){
            var item = SubMenu.wItems.Item(i);
            if (item.Text == Offside || item.Text == managementLevel){
                Log.Checkpoint("le menu : " +item.Text +" est visible");
                isFound++;
                if (isFound == 2)
                    break;
            }
        }
//Étape 3 
        //Ajouter un filtre niveau de gestion = Client et valider le résultat du filtre 
        AddFilter(managementLevel, operatorAmong, "Client", managementLevelFilter);
        //valider les résultats su filtre
        ValidateFilterResult("ManagementLevelDescription", "Client");     
        
// Étape 4: 
        //modifier le filtre à niveau de gestion = Compte et valider le résultat
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 4: modifier le filtre à niveau de gestion = Compte et valider le résultat");
        var account = (language == "french")? "Compte": "Account";
        Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).Click();
        Get_WinCRUFilter_GrpCondition_DgvValue().FindChild("Value", account, 10).Click();
        Get_WinCRUFilter_BtnOK().Click();
        
        //valider les résultats du filtre       
        ValidateFilterResult("ManagementLevelDescription", account);
       
//Étape 5
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 5: Dans Clients Ajouter le filtre Hors tolérance = oui et valider le résultat");
        //Accès au module Clients
        Get_ModulesBar_BtnClients().Click(); 
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Log.Message("Restore default configuration for the columns.");
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        //Ajouter les colonnes "Hors tolérance" et "Niveau de gestion"
        Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), Offside);
        Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), managementLevel);
         
        //Ajouter un filter Hors tolérance parmi oui
        AddFilter(Offside, operatorAmong, yesValue, OffsideFilter);
        //valider les résultats su filtre
        ValidateFilterResult("IsOffsideForRCM", true)
        
//Étape 6 
        //Modifier le filtre Hors tolérance excluant oui
        //Click sur l'entonoir
        Get_RelationshipsClientsAccountsGrid().Click(8, 8);
        Get_SubMenus().FindChild("WPFControlText", manageFilter, 10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild("Text", OffsideFilter, 10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit().Click(); 
        SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator(), operatorExcluding); 
        Get_WinCRUFilter_BtnOK().Click(); 
        Get_DlgWarning_BtnOK().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["BaseWindow", "Avertissement"], 30000);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        //valider les résultats su filtre
        ValidateFilterResult("IsOffsideForRCM", false);

//Étape 8 
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 8: Dans Comptes Ajouter un critère de recherche Hors tolérance = oui et valider le résultat");
        //Accès au module Comptes 
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
     
        //Ajouter le critère de recherche 'Liste des comptes (Comptes réél) ayant Hors tolérence égale à Oui'     
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager_BtnAdd().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemOffside().Click();
        
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 10000);
        
        //valider les résultats su filtre
        ValidateFilterResult("IsOffsideForRCM", true);
        
        //Modifier le critère de recherche à 'Liste des comptes (Comptes réél) ayant Hors tolérence différent de Oui'
        Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ContentControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).Click();
        Get_WinAddSearchCriterion_LvwDefinition_ItemNo(5).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemNotEqualTo().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 10000);
        
        //valider les résultats su filtre
        ValidateFilterResult("IsOffsideForRCM", false);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        
        //Suprimer les filtres
        DeleteFilter(managementLevelFilter, manageFilter);
        Get_ModulesBar_BtnClients().Click();
        DeleteFilter(OffsideFilter, manageFilter);
        
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {       
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}

function DeleteFilter(filterName, manageFilter){
        
        Log.Message("Supprimer le filtre: "+ filterName)
        //Click sur l'entonoir
        Get_RelationshipsClientsAccountsGrid().Click(8, 8);
        Get_SubMenus().FindChild("WPFControlText", manageFilter, 10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild("Text", filterName, 10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click(); 
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
}

function ValidateFilterResult(field, value){
    
        Log.Message("Valider le résultat du filtre: "+ field +" = "+ value);
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;

        for (i=0; i<count; i++){
            var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
            aqObject.CheckProperty(item.DataItem, field, cmpEqual, value);
        }
}

function AddFilter(champFiltre, operator, value, filterName){
        
        Log.Message("Ajouter le filtre: "+ filterName);
        //Click sur l'entonoir
        Get_RelationshipsClientsAccountsGrid().Click(8, 8);
        
        var SubMenu = Get_SubMenus().WPFObject("ContextMenu", "", 1);
        var count = SubMenu.ChildCount;     
        for (i=0; i<count; i++){
            var item = SubMenu.wItems.Item(i);
            if (item.Text == champFiltre){
                item.Click();
                break;
            }
        }     
        SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operator);
        Get_WinCreateFilter_DgvValue().FindChild("Value", value, 10).Click();
        Get_WinCreateFilter_BtnSaveAndApply().Click();
        Get_WinSaveFilter_TxtName().Keys(filterName);
        Get_WinSaveFilter_BtnOK().Click();
}