//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider l'anomalie 8
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6288
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-4
*/

function CR2083_6288_Anomaly8_Validation()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6288","Cas de test TestLink : Croes-6288") 
         
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
         
         var defaultGroupBox=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "DefaultGroupBox", language+client); //Défaut
         var analystCoverage=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverage", language+client);//"Suivi des analystes"
         var analystCoverageValue=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverageValue_6288", language+client);//Non
         var securitiesmodule=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "Securitiesmodule", language+client);
         var deletionNotPossibleMessage=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "deletionNotPossibleMessage_6288", language+client);
         var analystCoverageFrDscription=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverageFrDscription", language+client);//"Suivi des analystes"
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerTitre, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();        
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000); 
        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks pour enlever les filtres s'ils existent") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
        
        Log.Message("Faire info titre  et cliquer sur l'onglet Profils")
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabProfiles().Click();
        
        Log.Message("Cliquer sur Configuration... et cocher le profil "+analystCoverage+" + Sauvegarder"); 
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(false);
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();  
        profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(analystCoverage);
        if(profileCheckbox.get_IsChecked() == false)
            profileCheckbox.Click();        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        Log.Message("Valider que le combo du profil "+analystCoverage+" existe")
        var profileCombo = Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["Expander", defaultGroupBox], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "1"], 10).WPFObject("ComboValue")
        aqObject.CheckProperty(profileCombo, "Exists", cmpEqual, true);
        
        Log.Message("Dans le combo du profil choisir Non + OK")
        profileCombo.Set_Text(analystCoverageValue);
        Get_WinInfoSecurity_BtnOK().Click(); ;
        
        Log.Message("Dans la barre de menu cliquer sur OUTILS/ Configurations../groupes de profils")
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools().OpenMenu();
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().WaitProperty("Exists", true, 30000);
        Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
        WaitObject(Get_CroesusApp(),"Uid","ListView_bc90");
        Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles().WaitProperty("Exists", true, 30000);
        Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles().DblClick();
        WaitObject(Get_CroesusApp(),"Uid","ConfigurationWindow_a034");
        
        Log.Message("Dans la fenêtre : choisir modules : "+securitiesmodule+" cliquer sur "+defaultGroupBox)
        Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule().Set_Text(securitiesmodule);
        WaitObject(Get_CroesusApp(),"Uid","GroupBox_2aed");        
        Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilGroupsGrid().Find("Value",defaultGroupBox,10).Click();
        
        Log.Message("À droite de la fenêtre les profils titres s'affichent sélectionner "+ analystCoverageFrDscription);
        Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilListGrid().Find("Value",analystCoverageFrDscription,10).Click();
        
        Log.Message("Cliquer sur Supprimer le profil");
        Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnDeleteProfile().Click();
        
        Log.Message("Valider le message qui s'affiche")
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, deletionNotPossibleMessage);
        Get_DlgInformation_BtnOK().Click();
        
        Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
        
        
        Log.Message("************************************************* CLEANUP *************************************************")
        RestoreData(analystCoverage, profileCombo);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();        
        
        Log.Message("************************************************* CLEANUP *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();        
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        RestoreData(analystCoverage, profileCombo);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
        
    }
    finally {
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function Test(){
    var defaultGroupBox=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "DefaultGroupBox", language+client); //Défaut
         var analystCoverage=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverage", language+client);//"Suivi des analystes"
         var analystCoverageValue=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverageValue_6288", language+client);//Non
         var securitiesmodule=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "Securitiesmodule", language+client);
         var deletionNotPossibleMessage=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "deletionNotPossibleMessage_6288", language+client);
         //var profileCombo = Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["Expander", defaultGroupBox], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "1"], 10).WPFObject("ComboValue")
         
         RestoreData(analystCoverage);     
         
}
function RestoreData(profile, profileCombo){      
        
        Log.Message("Faire info titre  et cliquer sur l'onglet Profils")
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabProfiles().Click();        
        
        Log.Message("Cliquer sur Configuration... et décocher le profil "+profile+" + Sauvegarder"); 
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(false);
        profileCombo.Set_Text("");
        
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();  
        profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(profile);
        if(profileCheckbox.get_IsChecked() == true)
            profileCheckbox.Click();        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_BtnOK().Click(); ;
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
        
        Log.Message("Refaire info titre  et cliquer sur l'onglet Profils")
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabProfiles().Click();
        
        Log.Message("Valider que le combo du profil "+profile+" n'existe pas")
        aqObject.CheckProperty(profileCombo, "Exists", cmpEqual, false);
        Get_WinInfoSecurity_BtnOK().Click(); ;
}
