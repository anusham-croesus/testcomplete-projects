//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT PDFUtils


/**
    Jira Xray                 : https://jira.croesus.com/browse/TCVE-4080
    Description               : Valider que la quantité dans le rapport 'Titres détenus sous gestion' est correcte (PF-2691)  
    Version de scriptage      : ref90.28.27-2021.12-42
    Date:                     : 6 décembre 2021

    Analyste d'automatisation : Abdel.m
    Analyste QA               : Karima.Mo
**/

function TCVE_4080_PF_2691_ValidateQuantityInSecuritiesHeldUnderManagementReport()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-4080","Lien du cas de test dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-8368","Lien de la story dans Jira");
        
        var userNameCOPERN     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordCOPERN     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        var SSHUser   = "aminea";
        var SSHFolder = "CR1958.2.6644";
        var sshCommand = "cfLoader -DashboardRegenerator -FIRM=FIRM_1";
        var IACodeBD88 = GetData(filePath_ReportsCR1485, "Anomalies", 80, language);//"BD88"
        var symbolNA = GetData(filePath_ReportsCR1485, "Anomalies", 81, language);//"NA"
        var totalQty = GetData(filePath_ReportsCR1485, "Anomalies", 82, language);//"12 166"//"12,166"
        var marketValue = GetData(filePath_ReportsCR1485, "Anomalies", 83, language);//"692 975,36"//"692,975.36"
        var reportName = GetData(filePath_ReportsCR1485, "Anomalies", 79, language);//"Titres détenus sous gestion"//Securities Held"
        
        
        //******************************************* Étape 1***************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1.");
        
        Log.Message("Execution de la commande cfLoader");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerDashboard, sshCommand, SSHUser);       
                                    
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Se loguer avec COPERN");
        
       // Se connecter à croesus
        Log.Message("Se connecter à croesus");
        Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language);
                
        //******************************************* Étape 3***************************************************

        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Dans la barre de tâche, cliquer sur UTILISATEUR/Sélection.");
        
        //Cliquer le menu Utilisateurs
        Get_MenuBar_Users().Click();
                   
        //Accéder à Selection "Travailler en tant que"
        Get_MenuBar_Users_Selection().Click();
        
        //Acceder à l'onglet Code de CP
        Get_WinUserMultiSelection_TabIACodes().Click();
        
        //Selectionner un filtre BD88 et appliquer 
        Log.Message("Selectionner un filtre BD88 et appliquer");
        Search_IACode(IACodeBD88);
        Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",IACodeBD88],10).Click();
        Get_WinUserMultiSelection_BtnApply().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
        
        //******************************************* Étape 4***************************************************

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Aller dans le module Titres et Sélectionner le titre ayant symbole NA.");
        
        Log.Message("Aller dans le module Titres");
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
        
        //Sélectionner le titre ayant symbole NA
        Log.Message("Sélectionner le titre ayant symbole NA");
        Search_SecurityBySymbol(symbolNA);
        Get_SecurityGrid().Find("Text", symbolNA, 10).Click();
        
        //Cliquer sur le bouton "Total détenu" en haut à droite
        Log.Message("Cliquer sur le bouton 'Total détenu' en haut à droite");
        Get_SecuritiesBar_BtnTotalHeld().Click();
        WaitObject(Get_CroesusApp(), "Uid", "HoldingSecurityWindow_2cc0");
        
        // Valider que la quantité totale est 12166 
        Log.Message("Valider que la quantité tatale est "+totalQty);
        aqObject.CheckProperty(Get_WinTotalHeld().Find("Uid","Label_2242",10), "Text", cmpEqual, totalQty);
        aqObject.CheckProperty(Get_WinTotalHeld().Find("Uid","Label_8056",10), "Text", cmpEqual, marketValue);
        
        //Fermer la fenêtre
        Get_WinTotalHeld_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "HoldingSecurityWindow_2cc0");
        
        
        //******************************************* Étape 5***************************************************

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5:Cliquer sur l'iône 'Rapport et graphique' dans la barre de tâche.");
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
              
        
        //******************************************* Étape 6***************************************************

        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Générer le rapport et valider la quantité totale du titre NA dans le fichier PDF.");
        
        var reportFolderPath = folderPath_Data + client + "\\CR1485\\ResultFolder\\";
        var reportFileName  = "PF2691_Rapport"+ "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
        var reportFilePath = reportFolderPath + reportFileName;
            
        //Sauvegarder le rapport généré
        ValidateAndSaveReportAsPDF(reportFilePath, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
//        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, false, true, true);
        
        var reportfullname = reportFilePath + ".pdf";
        
        //Points de vérification
        Log.Message("Points de vérification");
        var StringList = [symbolNA, totalQty, marketValue];
        CheckStringOccurenceInPdfFile(reportfullname, 1, StringList);
       
        //******************************************* Étape 7***************************************************

        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7:Mailler le titre avec le symbole NA dans Portefeuille et Valider que le total des quantités est égal total détenu dans Titres et dans le rapport pdf.");
        
        //Mailler le titre NA vers portefeuille
        Log.message("Mailler le titre NA vers portefeuille");
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        //Cliquer le bouton Sommation
        Log.Message("Cliquer le bouton Sommation");
        Get_Toolbar_BtnSum().Click();
        
        //Valider la valeur de marché dans la fnêtre sommation
        Log.Message("Valider la valeur de marché dans la fnêtre sommation");
        aqObject.CheckProperty(Get_WinPortfolioSum().Find("Uid","Label_8056",10), "Text", cmpEqual, marketValue);
       
    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}


function Search_IACode(IACode){
      
      Get_WinUserMultiSelection_TabIACodes_DgvIACodes().Keys("C");
      Get_WinQuickSearch_TxtSearch().SetText(IACode);
//      Get_WinQuickSearch_RdoIACode().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
}

function CheckStringOccurenceInPdfFile(PDFFilePath, startPageNumber, arrayOfString){
     
        var PdfFileContent = GetPdfTextThroughCommandLine(PDFFilePath, startPageNumber);
            Log.Message(PdfFileContent);  
        for(i=0; i<arrayOfString.length; i++ ){ 
            var Res = aqString.Contains(PdfFileContent, arrayOfString[i]); 
            if ( Res != -1 )
              Log.Checkpoint("Substring:  '" + arrayOfString[i] + "'  was found in report text file  at position " + Res)
            else
              Log.Error("There are no occurrences of   '" + arrayOfString[i] + "'  in report text file'")
        }
}