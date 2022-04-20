//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Créer un filtre de type = IPS (RGMP)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-695
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0695_Rel_Create_an_IPS_type_filter()
{
    try {
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-0695","Cas de test TestLink : Croes-0695")
            
        if(client == "US")
            Activate_Inactivate_Pref('GP1859', "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations); 
        
        //Enlever la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='N' where  CODE_DICT=119", vServerRelations)          
        RestartServices(vServerRelations);
        
        //Ajouter le type de relation IPS dans le dictionnaire des types de relation
        CreateIPSRelationType();
        
        //Se connecter avec COPERN et vérifier la présence du type de filtre "Relation IPS"
        Login(vServerRelations, userName, psw, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Type().Click();
        
        var expectedType = GetData(filePath_Relations, "CR1352", 124, language);
        var nbOfTypes = Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.get_Count();
        var isIPSRelationTypeFound = false;
        for (var i = 0; i < nbOfTypes; i++){
            var currentType = Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Value();
            if (currentType == expectedType){
                isIPSRelationTypeFound = true;
                break;
            }
        }
        
        Get_WinCreateFilter_BtnCancel().Click();
        
        if (isIPSRelationTypeFound)
            Log.Checkpoint(expectedType + " found in the relationships possible type values. This is expected.");
        else
            Log.Error(expectedType + " not found in the relationships possible type values. This is not expected.");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
   
        Terminate_CroesusProcess();
        DeleteIPSRelationType();
        
        if(client == "US")
          Activate_Inactivate_Pref('GP1859', "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);
       
        //Réinitialiser la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='Y' where  CODE_DICT=119", vServerRelations)          
        RestartServices(vServerRelations);
    }
    
}



function SearchForDictionaryMnemonic()
{
    dictionaryMnemonic = GetData(filePath_Relations, "CR1352", 126, language);
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().Keys("F");
    Get_WinQuickSearch_TxtSearch().SetText(dictionaryMnemonic);
    Get_WinQuickSearch_BtnOK().Click();
} 



function CreateIPSRelationType()
{
    var userWithRights = "GP1859";
    Login(vServerRelations, userWithRights, psw, language);
    
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
    Delay(2000);
    Get_WinConfigurations_LvwListView_LlbDictionaries().DblClick();
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary().Click();
    Delay(2000);
    
    SearchForDictionaryMnemonic();
    
    var dictionariesListCount = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var expectedFrenchDescription = GetData(filePath_Relations, "CR1352", 123, "french");
    var expectedEnglishDescription = GetData(filePath_Relations, "CR1352", 123, "english");
    var isDictionaryFound = false;
    for (var i = 0; i < dictionariesListCount; i++){
        var currentFrenchDescription = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL1();
        var currentEnglishDescription = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL2();
        if (currentFrenchDescription == expectedFrenchDescription && currentEnglishDescription == expectedEnglishDescription){
            Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
            isDictionaryFound = true;
            break;
        }
    }
    
    if (!isDictionaryFound){
        Log.Error("'Relationship Type' dictionary not found in the dictionaries list ; this is not expected.");
        return;
    }
    
    Log.Message("'Relationship Type' dictionary found in the dictionaries list ; this is expected.");
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnEdit().Click();
    
    
    var IPSRelationFrenchDescription = GetData(filePath_Relations, "CR1352", 124, "french");
    var IPSRelationEnglishDescription = GetData(filePath_Relations, "CR1352", 124, "english");
    var IPSRelationFrenchMnemonic = GetData(filePath_Relations, "CR1352", 125, "french");
    var IPSRelationEnglishMnemonic = GetData(filePath_Relations, "CR1352", 125, "english");
    
    var dictionaryEntriesCount = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var isIPSRelationEntryFound = false;
    for (var i = 0; i < dictionaryEntriesCount; i++){
        var currentEntryFrenchDescription = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL1();
        var currentEntryEnglishDescription = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL2();
        var currentEntryFrenchMnemonic = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_MnemonicL1();
        var currentEntryEnglishMnemonic = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_MnemonicL2();
        if ((client == "US" && currentEntryEnglishDescription == IPSRelationEnglishDescription && currentEntryEnglishMnemonic == IPSRelationEnglishMnemonic) || (client != "US" && currentEntryFrenchDescription == IPSRelationFrenchDescription && currentEntryEnglishDescription == IPSRelationEnglishDescription && currentEntryFrenchMnemonic == IPSRelationFrenchMnemonic && currentEntryEnglishMnemonic == IPSRelationEnglishMnemonic)){
            isIPSRelationEntryFound = true;
            break;
        }
    }
    
    if (isIPSRelationEntryFound)
        Log.Message("'IPS Relation' entry found in the 'Relationship Type' dictionary entries. No need to add it again.");
    else {
        Log.Message("'IPS Relation' entry not found in the 'Relationship Type' dictionary entries. Proceed to add it.");
        
        if(!Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd().IsEnabled){
            Log.Error("CROES-8579 : on ne pourra pas ajouter d'entrée sur le dictionnaire car celui-ci est en lecture seulement.")
            return;
        }
        Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd().Click();
        if( client != "US"){
          Get_WinCRUDictionary_TxtFrenchDescription().Keys(IPSRelationFrenchDescription);
          Get_WinCRUDictionary_TxtFrenchMnemonic().Keys(IPSRelationFrenchMnemonic);
        } 
        
        Get_WinCRUDictionary_TxtEnglishDescription().Keys(IPSRelationEnglishDescription);
        Get_WinCRUDictionary_TxtEnglishMnemonic().Keys(IPSRelationEnglishMnemonic);
        Get_WinCRUDictionaryEntry_BtnOK().Click();
    }
    
    Get_WinCRUDictionary_BtnOK().Click();
    Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
    Get_WinConfigurations().Close();
    
    Close_Croesus_X();
    Delay(3000);
}



function DeleteIPSRelationType()
{
    var userWithRights = "GP1859";
    Login(vServerRelations, userWithRights, psw, language);
    
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
    Delay(2000);
    Get_WinConfigurations_LvwListView_LlbDictionaries().DblClick();
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary().Click();
    Delay(2000);
    
    SearchForDictionaryMnemonic();
    
    var dictionariesListCount = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var expectedFrenchDescription = GetData(filePath_Relations, "CR1352", 123, "french");
    var expectedEnglishDescription = GetData(filePath_Relations, "CR1352", 123, "english");
    var isDictionaryFound = false;
    for (var i = 0; i < dictionariesListCount; i++){
        var currentFrenchDescription = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL1();
        var currentEnglishDescription = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL2();
        if (currentFrenchDescription == expectedFrenchDescription && currentEnglishDescription == expectedEnglishDescription){
            Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
            isDictionaryFound = true;
            break;
        }
    }
    
    if (!isDictionaryFound){
        Log.Error("'Relationship Type' dictionary not found in the dictionaries list ; this is not expected.");
        return;
    }
    
    Log.Message("'Relationship Type' dictionary found in the dictionaries list ; this is expected.");
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnEdit().Click();
    
    
    var IPSRelationFrenchDescription = GetData(filePath_Relations, "CR1352", 124, "french");
    var IPSRelationEnglishDescription = GetData(filePath_Relations, "CR1352", 124, "english");
    var IPSRelationFrenchMnemonic = GetData(filePath_Relations, "CR1352", 125, "french");
    var IPSRelationEnglishMnemonic = GetData(filePath_Relations, "CR1352", 125, "english");
    
    var dictionaryEntriesCount = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var isIPSRelationEntryFound = false;
    var IPSRelationEntryIndex;
    for (var i = 0; i < dictionaryEntriesCount; i++){
        var currentEntryFrenchDescription = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL1();
        var currentEntryEnglishDescription = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_DescriptionL2();
        var currentEntryFrenchMnemonic = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_MnemonicL1();
        var currentEntryEnglishMnemonic = Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_MnemonicL2();
        if ((client == "US" && currentEntryEnglishDescription == IPSRelationEnglishDescription && currentEntryEnglishMnemonic == IPSRelationEnglishMnemonic) || (client != "US" && currentEntryFrenchDescription == IPSRelationFrenchDescription && currentEntryEnglishDescription == IPSRelationEnglishDescription && currentEntryFrenchMnemonic == IPSRelationFrenchMnemonic && currentEntryEnglishMnemonic == IPSRelationEnglishMnemonic)){
            isIPSRelationEntryFound = true;
            IPSRelationEntryIndex = i;
            break;
        }
    }
    
    if (isIPSRelationEntryFound){
        Log.Message("'IPS Relation' entry found in the 'Relationship Type' dictionary entries. Proceed to delete it.");
        Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(IPSRelationEntryIndex).set_IsActive(true);
        Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries().WPFObject("RecordListControl", "", 1).Items.Item(IPSRelationEntryIndex).set_IsSelected(true);
        Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
    else
        Log.Message("'IPS Relation' entry not found in the 'Relationship Type' dictionary entries. Cannot delete it.");
    
    Get_WinCRUDictionary_BtnOK().Click();
    Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
    Get_WinConfigurations().Close();
    
    Close_Croesus_X();
    Delay(3000);
}