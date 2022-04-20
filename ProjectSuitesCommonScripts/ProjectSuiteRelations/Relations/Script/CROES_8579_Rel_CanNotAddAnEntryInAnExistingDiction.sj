//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : Se connecter avec UNI00 
                      Sélectionner le dictionnaire 119 
                      Cliquer sur Modifier 
                      La fenêtre Modifier le dictionnaire s'affiche mais tous les champs sont grisés 
                      Voire fichier joints ( CX et AT) 

    Auteur : Sana Ayaz
    Anomalie:CROES-8579
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8579_Rel_CanNotAddAnEntryInAnExistingDiction()
{
    try {
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/browse/CROES-8579","Anomalie : Jira CROES-8579")
        
        //Enlever la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='N' where  CODE_DICT=119", vServerRelations)  
        RestartServices(vServerRelations); 
        
        //CROES_8447_Rel_CanNotAddAnEntryInAnExistingDiction
        //CROES_8579_Rel_CrashWhenWeClickOnProductServices
        if(client == "CIBC"){
            userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
            passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
            Login(vServerRelations, userNameUNI00, passwordUNI00, language);
        }
        else{
            userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            //Se connecter avec GP1859 au lieu de UNI00
            Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        }
        Get_ModulesBar_BtnRelationships().Click();
        
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        
        
        
        Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
        Delay(2000);
        Get_WinConfigurations_LvwListView_LlbDictionaries().DblClick();
        SearchForDictionaryRelatType()
        
        var dictionariesListCount = Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        var expectedFrenchDescription=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DictionDescriptionCROES_8579", "french"+client);
        var expectedEnglishDescription = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DictionDescriptionCROES_8579", "english"+client);
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
    // Les points de vérifications
    // D'aprés Karima il faut vérifier juste que les boutons suivants: Ajouter modifier et supprimer sont actifs
    // Le bouton Ajouter est actif
    Log.Message("CROES-8579")
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd(), "IsEnabled", cmpEqual, true);
    //Le bouton modifier est actif
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnEdit(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnEdit(), "IsEnabled", cmpEqual, true);
    //Le bouton supprimer est actif
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnDelete(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnDelete(), "IsEnabled", cmpEqual, true);
    Get_WinCRUDictionary_BtnCancel().Click();
    Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
    Get_WinConfigurations().Close();   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        //Enlever la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='Y' where  CODE_DICT=119", vServerRelations)  
        RestartServices(vServerRelations);
        
        
    }
}




function SearchForDictionaryRelatType()
{
   var dictionaryRelatTypeCROES_8579 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "dictionaryRelatTypeCROES_8579", language+client);
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().Keys("F");
    Get_WinQuickSearch_TxtSearch().SetText(dictionaryRelatTypeCROES_8579);
    Get_WinQuickSearch_BtnOK().Click();
} 
