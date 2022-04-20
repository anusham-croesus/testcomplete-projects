//USEUNIT CR1449_Common



/**
    Description : Accès à la fenêtre de catégorisation de titres - Acces SYSADM, Pref YES
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5434
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_AccesSYSADM_PrefYES()
{
    if (client == "CIBC")
        CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestPositif("UNI00", "SYSADM", "YES");
    else
        CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestPositif("GP1859", "SYSADM", "YES");
}



function CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestPositif(userID, accessLevel, prefValue)
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", userID, "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", userID, "psw");
        
        //Configuration du niveau d'accès et de la pref
        Log.Message("***** CR1449 Croes-5434 : niveau d'accès = " + accessLevel + ", PREF_EDIT_FIRM_FUNCTIONS = " + prefValue);
        VerifyUserAccessLevel(testUserName, accessLevel);
        var previousPrefValue = GetUserPrefValue(vServerTitre, "PREF_EDIT_FIRM_FUNCTIONS", testUserName);
        Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", prefValue, vServerTitre);
        RestartServices(vServerTitre);
        
        //Se connecter à Croesus et tenter d'ouvrir la fenêtre 'Catégorisation de titres'
        Log.Message("Se connecter à Croesus et tenter d'ouvrir la fenêtre 'Catégorisation de titres'");
        Login(vServerTitre, testUserName, testUserPassword, language);
        
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
        
        Log.Message("Vérifier que le lien 'Catégorisation de titres' est affiché dans l'arbre de la fenêtre de Configurations.");
        if (!aqObject.CheckProperty(Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation(), "Exists", cmpEqual, true))
            return;
        
        Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation().Click();
        Delay(2000);
        Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation().DblClick();
        
        Log.Message("Vérifier que la fenêtre 'Catégorisation de titres' est affichée.");
        if (aqObject.CheckProperty(Get_WinSecurityCategorisationConfigurations(), "Exists", cmpEqual, true))
            Get_WinSecurityCategorisationConfigurations().Close();
       
        //Fermer Croesus
        Get_WinConfigurations().Close();
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restaurer la pref pour l'utilisateur
        if (typeof previousPrefValue != "undefined"){
            Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", previousPrefValue, vServerTitre);
            RestartServices(vServerTitre);
        }
        Terminate_CroesusProcess();
    }
}



function CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestNegatif(userID, accessLevel, prefValue)
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", userID, "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", userID, "psw");
        
        //Configuration du niveau d'accès et de la pref
        Log.Message("***** CR1449 Croes-5434 : niveau d'accès = " + accessLevel + ", PREF_EDIT_FIRM_FUNCTIONS = " + prefValue);
        VerifyUserAccessLevel(testUserName, accessLevel);
        var previousPrefValue = GetUserPrefValue(vServerTitre, "PREF_EDIT_FIRM_FUNCTIONS", testUserName);
        Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", prefValue, vServerTitre);
        RestartServices(vServerTitre);        
        
        //Se connecter à Croesus et tenter d'ouvrir la fenêtre 'Catégorisation de titres'
        Log.Message("Se connecter à Croesus et tenter d'ouvrir la fenêtre 'Catégorisation de titres'");
        Login(vServerTitre, testUserName, testUserPassword, language);
        
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
        
        Log.Message("Vérifier que le lien 'Catégorisation de titres' n'est pas affiché dans l'arbre de la fenêtre de Configurations.");
        aqObject.CheckProperty(Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation(), "Exists", cmpEqual, false);
        
        //Fermer Croesus
        Get_WinConfigurations().Close();
        SetAutoTimeOut();
        Close_Croesus_MenuBar();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        RestoreAutoTimeOut();
        
        //Restaurer la pref pour l'utilisateur
        if (typeof previousPrefValue != "undefined"){
            Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", previousPrefValue, vServerTitre);
            RestartServices(vServerTitre);
        }
    }
}
