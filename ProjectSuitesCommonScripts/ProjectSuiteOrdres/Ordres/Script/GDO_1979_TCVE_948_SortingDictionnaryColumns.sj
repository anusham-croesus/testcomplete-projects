//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : En tant que TCVE je veux que les tests auto couvre le tri de la colonne description
                  dans la fenêtre dictionnaires afin que  le Jira GDO-1979 ne se produit plus  chez nos clients.
    https://jira.croesus.com/browse/TCVE-948
    https://jira.croesus.com/browse/GDO-1979
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Philippe Maurice
*/

function GDO_1979_TCVE_948_SortDictionnariesByDescription()
{
    try {
        
        /*VARIABLES*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");

                
        Log.Link("https://jira.croesus.com/browse/TCVE-948", "Lien de la story");
        Log.Link("https://jira.croesus.com/browse/GDO-1979", "Lien du JIRA");
       
        //LOGIN
        Login(vServerOrders, userName, password, language);
        
        //Outils - Configurations - Profils & Dictionnaires
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
		WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
        Get_WinConfigurations_LvwListView_LlbDictionaries().DblClick();
        
        
        //Accès l'onglet Dictionnaires
        Get_WinProfilesAndDictionaryConfiguration_TabDictionary().Click();

        //------------  LE TRI DES DIFFÉRENTES COLONNES --------
        Log.Message("---- Différents TRIS ----");
        
        
        //--SECTION LISTE DES DICTIONNAIRES
        Log.Message("Section Liste des dictionnaires");
              
        //Tri de la colonne Code
        Log.Message("Tri selon la colonne Code");
        sort_DictionnaryList_Code();
               
        //Tri de la colonne Description en français / French Description
        Log.Message("Tri selon la colonne Description en français");
        sort_DictionnayList_FrenchDesc();
           
        //Tri de la colonne Description en anglais / English Description
        Log.Message("Tri selon la colonne Description en anglais");
        sort_DictionnaryList_EnglishDesc();
                      
        //Tri de la colonne Mnemonique / Mnemonic
        Log.Message("Tri selon la colonne Mnemonique");
        sort_DictionnaryList_Mnemonic();
        
        

        //--SECTION UNITÉS DE DICTIONNAIRE
        Log.Message("--- Section Unités de dictionnaire ---");

        //Tri de la colonne Index
        Log.Message("Tri selon la colonne Index");
        sort_DictionnaryEntries_Index();
               
        //Tri de la colonne Description en français / French Description
        Log.Message("Tri selon la colonne Description en français");
        sort_DictionnaryEntries_FrenchDesc();
               
        //Tri de la colonne Description en anglais / English Description
        Log.Message("Tri selon la colonne Description en anglais");
        sort_DictionnaryEntries_EnglishDesc();
               
        //Tri de la colonne Mnemonique français / French Mnemonic
        Log.Message("Tri selon la colonne Mnémonique français");
        sort_DictionnaryEntries_FrenchMnemonic();
               
        //Tri de la colonne Mnemonique anglais / English Mnemonic
        Log.Message("Tri selon la colonne Mnémonique anglais");
        sort_DictionnaryEntries_EnglishMnemonic();
        

        Log.Message("--- Fermeture de la fenêtre Dictionnaires ---");
        Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
                            
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}

function sort_DictionnaryList_Code() {    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colCode().Click();    
    Check_columnAlphabeticalSort(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "Code", "DictionaryId");  
}


function sort_DictionnayList_FrenchDesc() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colFrenchDesc().Click();
    
    //Validationdu tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "Description en français", "DescriptionL1");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "French Description", "DescriptionL1");
}


function sort_DictionnaryList_EnglishDesc() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colEnglishDesc().Click();

    //Validation du tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "Description en anglais", "DescriptionL2");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "French Description", "DescriptionL2");    
}

function sort_DictionnaryList_Mnemonic() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colMnemonic().Click();
    
    //Validation du tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "Mnémonique", "Mnemonic");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(), "Mnemonic", "Mnemonic");
}


function sort_DictionnaryEntries_Index() {
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colIndex().Click();
    
    Check_columnAlphabeticalSort(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "Index", "IndexDictionary");
}


function sort_DictionnaryEntries_FrenchDesc() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchDesc().Click();
    
    //Validationdu tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "Description en français", "DescriptionL1");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "French Description", "DescriptionL1");
}


function sort_DictionnaryEntries_EnglishDesc() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishDesc().Click();
    
    //Validationdu tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "Description en anglais", "DescriptionL2");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "English Description", "DescriptionL2");
}


function sort_DictionnaryEntries_FrenchMnemonic() {
    
    //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchMnemonic().Click();
    
    //Validationdu tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "Mnémonique français", "MnemonicL1");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "French Mnemonic", "MnemonicL1");
}


function sort_DictionnaryEntries_EnglishMnemonic() {
    
     //Cliquer une fois pour avoir en ordre croissant
    Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishMnemonic().Click();
    
    //Validationdu tri
    if (language == "french")
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "Mnémonique anglais", "MnemonicL2");
    else
        Check_columnAlphabeticalSort_CR1483(Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(), "English Mnemonic", "MnemonicL2");
}