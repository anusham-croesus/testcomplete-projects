//USEUNIT Common_Get_functions
//USEUNIT CR2330_Common
//USEUNIT DBA
//USEUNIT PDFUtils
//USEUNIT CR1485_150_Common_functions
//USEUNIT ReportCommander_Commonfunctions

//USEUNIT Global_variables


/**
    Description : 
    1. Valider la possibilité de copie et de configurer le rapport ‘Feuillets d’impôt attendus’
    2. Valider la possibilité de personnaliser le message dans le haut du rapport 'Feuillets d'impôt attendus' (comptes non-enregistrés)
    3. Valider la possibilité de personnaliser la note du rapport 'Feuillets d'impôt attendus' (comptes non-enregistrés)
    4. Valider l’intégration du nom de la firme et l’année dynamiquement dans la note du rapport 'Feuillets d'impôt attendus' (comptes non-enregistrés)
    Analyste d'assurance qualité : Marina.G.
    Analyste d'automatisation : Abdel.M.
    version: ref90-19-2020-09-23.un dump de TD
    Date: 09/10/2020
*/

function CR2280_TCVE2623_ExpectedTaxSlipsReport_ConfigurableNote()
{
    Log.Link("https://jira.croesus.com/browse/TCVE-2623");  
       
    try {        
     
         var userNameKEYNEJ  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         var userNameCOPERN  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         var userNameDARWIC  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
  
         var itemGlobal      = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "itemGlobal", language+client);
         var reportTaxSlips  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "reportTaxSlips", language+client);
     
         //var KeynejCopyReportName = "KEYNEJ_Copie de Feuillets d'impôt attendus (comptes non enregistrés)"
         //var DarwicCopyReportName = "DARWIC_Copie de Feuillets d'impôt attendus (comptes non enregistrés)"
         var KeynejnoteTextFrench  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "KeynejnoteTextFrench", language+client);
         var KeynejnoteTextEnglish = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "KeynejnoteTextEnglish", language+client);
         
         var DarwicnoteTextFrench  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "DarwicnoteTextFrench", language+client);
         var DarwicnoteTextEnglish = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "DarwicnoteTextEnglish", language+client);
     
         var accountNumber800249NA  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "accountNumber800249NA", language+client);
         var reportNameTCVE2623     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "reportNameTCVE2623", language+client);
         var reportNameTCVE2623Keynej = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "reportNameTCVE2623Keynej", language+client);
         var reportNameTCVE2623Darwic = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "reportNameTCVE2623Darwic", language+client);
         
     
         var reportFileName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "reportFileName", language+client);
         var year           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "year", language+client);
         
         var LOBKeynej = "LOB1Firme KEYNEJ 2008"
         var LOBDarwic = "LOB1DARWIC_Equipe de travail 2008"
         var LOB1 = "LOB1"
         
     
         //Acivation des prefs
         Pref_Activations(userNameKEYNEJ, userNameCOPERN, userNameDARWIC);



        //************************************************ L'étape 1********************************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ et aller dans configuration des rapports");
        Log.Message("Se connecter à croesus avec KEYNEJ");
        Login(vServerReportsCR1485, userNameKEYNEJ, psw, language);
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        
        SetAutoTimeOut();
        
        while (! Get_SubMenus().Exists)
            Get_MenuBar_Tools().Click();
            
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
        //************************************************ L'étape 2********************************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Sélectionner le rapport 'Feuillets d'impôt attendus (comptes non enregistrés)' et cliquer sur copier vers…");
               
        Log.Message("Rapports / Double clique sur Configuration des rapports");
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Delay(2000);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        Log.Message("Choisir le niveau Global")
        Delay(2000);
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        SelectReportToCopy(reportTaxSlips);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        
        //Choisir Firme et valider par OK
        Get_WinCopyReport_RdoFirm().set_IsChecked(true);
        Get_WinCopyReport_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");

        //************************************************ L'étape3********************************************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: changer le nom du rapport");
       
        //Modifier le nom du rapport
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Click();
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys("[Home][Home]");
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys(userNameKEYNEJ+"_");
        
        //Dans l'onglet Avis et notes / Décocher ‘Utiliser le défaut’ de la boîte ‘Texte de référence’
        Get_WinReportConfigurationCopy_TabDisclaimers().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault().set_IsChecked(false);
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Keys(KeynejnoteTextEnglish);
        
        //Cliquer sur le bouton pour changer la langue
        width = Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().get_ActualWidth()
        height = Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().get_ActualHeight()
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Click(width-10,height-5)
        Delay(2000);
        Get_SubMenus().WPFObject("ComboBoxItem", "", 2).Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Keys(KeynejnoteTextFrench);
        
        
        //Dans l’onglet Avis et notes modifier la note dans la boîte Texte de référence en ajoutant à la fin de la note:
        Get_WinReportConfigurationCopy_TabDisclaimers().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefaultNote().set_IsChecked(false);
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys(/*KeynejnoteTextEnglish*/LOBKeynej);
        
        //Cliquer sur le bouton pour changer la langue
        width = Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().get_ActualWidth()
        height = Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().get_ActualHeight()
        
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Click(width-10,height-5);
        Delay(2000)
        Get_SubMenus().WPFObject("ComboBoxItem", "", 2).Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys(/*KeynejnoteTextFrench*/LOBKeynej);
        
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");
        Get_WinReportConfiguration_BtnClose().Click();
        Get_WinConfigurations().Close();
        
        //Fermer Croesus
        Terminate_CroesusProcess();
        
        //************************************************ L'étape4********************************************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Se loguer avec l'utilisateur DARWIC et créer une copie du rapport Feuillets d'impôt attendus (comptes non enregistrés) au niveau Équipe de travail/ OK ");
        
        Log.Message("Se connecter à croesus avec DARWIC");
        Login(vServerReportsCR1485, userNameDARWIC, psw, language);
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");  
        
        Log.Message("Rapports / Double clique sur Configuration des rapports");
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Delay(2000);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        Log.Message("Choisir le niveau Global")
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        SelectReportToCopy(reportTaxSlips);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        
        //Choisir Groupe de travail et valider par OK
        Get_WinCopyReport_RdoWorkgroup().set_IsChecked(true);
        Get_WinCopyReport_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");  
        
        //Modifier le nom du rapport
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Click();
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys("[Home][Home]");
        Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys(userNameDARWIC+"_");
        
        //décocher 'Utiliser le nom du rapport' puis modifier l'en-tête du rapport en ajoutant le nom DARWIC au début
        Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().set_IsChecked(false);
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Click();
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Keys("[Home][Home]");
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Keys(userNameDARWIC+"_");
        
        width2 = Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().get_ActualWidth()
        height2 = Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().get_ActualHeight()
        
        //changer la langue et changer le nom de l'entête
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Click(width2-10, height2-5);
        Delay(2000)
        Get_SubMenus().WPFObject("ComboBoxItem", "", 2).Click();
        
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Click();
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Keys("[Home][Home]");
        Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().Keys(userNameDARWIC+"_");
        

        
        //Dans l’onglet Avis et notes modifier la note dans la boîte Texte de référence en ajoutant à la fin de la note:
        Get_WinReportConfigurationCopy_TabDisclaimers().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefaultNote().set_IsChecked(false);
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys(/*DarwicnoteTextEnglish*/LOBDarwic);
        
        //Cliquer sur le bouton pour changer la langue
        width = Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().get_ActualWidth()
        height = Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().get_ActualHeight()
        
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Click(width-10,height-5);
        Delay(2000)
        Get_SubMenus().WPFObject("ComboBoxItem", "", 2).Click();
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys("[End]");
        Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference().Keys(/*DarwicnoteTextFrench*/LOBDarwic);
        
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");
        Get_WinReportConfiguration_BtnClose().Click();
        Get_WinConfigurations().Close();
        
        //Fermer Croesus
        Terminate_CroesusProcess();

        //************************************************ L'étape5********************************************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se loguer avec l'utilisateur COPERN et aller au module Comptes");
                
        Log.Message("Se connecter à croesus avec COPERN");
        Login(vServerReportsCR1485, userNameCOPERN, psw, language);
        
        Log.Message("Acceder au module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          
        SearchAccount(accountNumber800249NA);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",accountNumber800249NA],10).Click();
          
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        AddReport(reportNameTCVE2623);
        AddReport(reportNameTCVE2623Keynej);
        AddReport(reportNameTCVE2623Darwic);
          
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
       
        var fullname = REPORTS_FILES_FOLDER_PATH + reportFileName + ".pdf"
        
        //Points de vérification
        Log.Message("Points de vérification");
        var year = "2008"
        
        //-----------------------------------------Modifié par A.A TCVE-6179 Maintenance des rapports TD-------------------------------------
        
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(year, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 1);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(year, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 2);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(year, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 3);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(LOBKeynej, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 2);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(LOB1, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 2);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(/*reportNameTCVE2623Darwic*/ "DARWIC_FEUILLETS D'IMPÔT ATTENDUS (COMPTES NON ENREGISTRÉS)", /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 3);           
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(LOBDarwic, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 3);
//        CheckIfExpectedStringIsDisplayedInPDFPagePicture(LOB1, /*REPORTS_FILES_FOLDER_PATH + reportFileName*/ fullname , 3);
        
        var StringList1 = [year, LOBKeynej, LOB1];   
        var StringList2 = [year, LOBDarwic, "DARWIC_FEUILLETS D'IMPÔT ATTENDUS (COMPTES NON ENREGISTRÉS)", LOB1];
        
        CheckStringOccurenceInPdfFile(fullname, 1, [year]);
        CheckStringOccurenceInPdfFile(fullname, 2, StringList1);            
        CheckStringOccurenceInPdfFile(fullname, 3, StringList2);
        //-------------------------------------------------------------------------------------------------------------------------------------
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();      
    }   
}

function Pref_Activations(userNameKEYNEJ, userNameCOPERN, userNameDARWIC)
{
    Log.Message("Le CR2280 est un CR spécifique pour TD")
    Log.Message("Les préconditions: 'Activation des prefs");
    Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameDARWIC, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPT_CONFIG_SAC", "YES", vServerReportsCR1485);
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EXPECT_TAX_SLIPS_NRA", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
    
    Activate_Inactivate_PrefFirm("FIRM_1", "ACCOUNT_TYPE_NON_REGISTERED", "A,C,E", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "SECURITY_TAX_SLIP_NON_REGISTERED ", "2611392,315,3158000,3158001,3158002,3158007,3158008,3158015,330,3807000,3807500,3807850,3807680", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_GROUPING", "1", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);

}

function Get_WinReportConfiguration_Report(reportName){
    return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", reportName], 10)
}

function SelectReportToCopy(reportName){
    grid = Get_WinReportConfiguration().WPFObject("UniGroupBox", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 309, language), 2).WPFObject("UniList", "", 1);
    count = grid.Items.Count;
    grid.WPFObject("ListBoxItem", "", 1).Click();
    
    for (i=1;i<count;i++) {
        if (! Get_WinReportConfiguration_Report(reportName).Exists)
            Sys.Keys("[Down]");
            
    }
    
    Get_WinReportConfiguration_Report(reportName).set_IsSelected(true);
}


function AddReport(reportName){
    if (language == "french") 
        var grid = Get_WinReports().WPFObject("UniGroupBox", "Rapports", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1)
    else 
        grid = Get_WinReports().WPFObject("UniGroupBox", "Reports", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("TreeView", "", 1)
    
    grid.Find("Text",reportName,10).Click();
    Get_Reports_GrpReports_BtnAddAReport().Click();
    
    //Parameters values
    year = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "year", language+client);
    numbering = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2280", "numbering", language+client);
        
    SetReportParameters(year, numbering);
}


function Get_WinReportConfigurationCopy_TabDisclaimers_TxtReference(){return Get_WinReportConfigurationCopy().FindChild(["Uid", "WPFControlOrdinalNo"], ["LocaleTextbox_ff77", 2], 10)}
function Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefaultNote(){return Get_WinReportConfigurationCopy().FindChild(["Uid","WPFControlName"],["CheckBox_18a5", "chkUsesDefaultNote1"], 10)}