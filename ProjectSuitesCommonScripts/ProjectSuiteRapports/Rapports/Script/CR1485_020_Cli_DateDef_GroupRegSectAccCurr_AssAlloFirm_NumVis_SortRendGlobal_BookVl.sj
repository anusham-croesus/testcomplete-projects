//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_020_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables

/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\20. Évaluation du portefeuille (avancé)\2.4 Clients
          1.Outils / Configurations / rapports / configuration des rapports / 
          2. Niveau global / sélectionner le rapport / évaluation du portefeuille (avancé) / copier vers ...
          3. Groupe Utilisateur / ok
          4. Déployer l'option "Colonnes" et ajouter les colonnes (voir: Colonnes.JPG): // onglet "contenu" (impact du CR1812.1)
              - Rendement à l'achat
              - Rendement à l'achat courant
          5. OK (Copie faite)
          6. Fermer toutes les fenêtres de configuration des rapports
          7. Module clients / Sélectionner le client 800290 / Rapports / dans le regroupement par "Utilisateur" / sélectionner le rapport "Évaluation du portefeuille (avancé)" <- La copie faite à l'étape 5
          8. Produire selon les paramètres (voir: Capture.JPG)
          
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
    Version de scriptage : ref90-12-Hf-74
    Date: 11/11/2019
*/

function CR1485_020_Cli_DateDef_GroupRegSectAccCurr_AssAlloFirm_NumVis_SortRendGlobal_BookVl()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\20. Évaluation du portefeuille (avancé)\\2.4 Clients\\", "CR1485_020_Cli_DateDef_GroupRegSectAccCurr_AssAlloFirm_NumVis_SortRendGlobal_BookVl()");
    Log.Message("Anomalie JIRA BNC-1762");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 305, language);
        var clientNumber = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 312);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login 
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
       //Aller dans Outils / Configurations / rapports / configuration des rapports /     
        Get_MenuBar_Tools().Click();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
        //Cliquer sur Rapport et entrer dans Configuration des rapports
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        WaitObject(Get_CroesusApp(),"WndCaption", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language));
        
        //Dans Groupe Global choisir le rapport Évaluation du portefeuille (avancé) et cliquer sur copier vers...
        SelectReportToCopy();
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        //Choisir le groupe utilisateur et valider par OK
        Get_WinCopyReport_CmbUser().set_IsChecked(true);
        Get_WinCopyReport_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");
        
        //Dans la fenêtre qui s'affiche aller à l'onglet Contenu
        Get_WinReportConfigurationCopy_TabContent().Click();
        
        //Ajouter les colonnes Rendement à l'achat et  Rendement à l'achat courant
        Add_Columns();
        
        //Valider avec Ok et fermer toutes les fenêtres de configuration
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ReportConfigurationWindow");
        Get_WinReportConfiguration_BtnClose().Click();
        Get_WinConfigurations().Close();
        
        //Aller dans le module Clients
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 314);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
         SelectReport(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 317, language);
        sortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 318, language);
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 319, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 320, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 321, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 322, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 323, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 324, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 325, language);
        message = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 326, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 329, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 330, language);
        type = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 331, language);
        checkComparative = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 332, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 333, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 334, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 335, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 336, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 338, language): GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 337, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 339, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 340, language);
        customAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 341, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 342, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 343, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 344, language);
        numbering = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 345, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 346, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 349);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReport(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 352, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 353, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Supprimer la copie du rapport dans la configuration -----CleanUp--------
        Log.Message("-----------CleanUp -------------------");
        DeleteCopyOfReport()
        Terminate_CroesusProcess();
    }
}


        
function Get_WinReportConfiguration_AdvancedPortfolioEvaluation(){
  return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 1, language)], 10)
  }

function Get_WinReportConfiguration_CopyOfAdvancedPortfolioEvaluation(){
  return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 305, language)], 10)
  }  

function Add_Columns(){
          count = Get_WinReportConfigurationCopy_Columns().wItemCount;
          Get_WinReportConfigurationCopy_Columns().WPFObject("ListBoxItem", "", 1).Click();
          for (i=1;i<count-2;i++){
            Get_WinReportConfigurationCopy_Columns().Keys("[Down]")
            if (Get_WinReportConfigurationCopy_Columns().WPFObject("ListBoxItem", "", i).DataContext.Name == GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 307, language) || Get_WinReportConfigurationCopy_Columns().WPFObject("ListBoxItem", "", i).DataContext.Name == GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 308, language)){
                Get_WinReportConfigurationCopy_Columns().WPFObject("ListBoxItem", "", i).Click();
                Get_WinReportConfigurationCopy_BtnAddToRight().Click();
            }
          }
}
        
function SelectReportToCopy(){
          grid = Get_WinReportConfiguration().WPFObject("UniGroupBox", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 309, language), 2).WPFObject("UniList", "", 1);
          count = grid.Items.Count;
          grid.WPFObject("ListBoxItem", "", 1).Click();
          for (i=1;i<count;i++) {
            if (! Get_WinReportConfiguration_AdvancedPortfolioEvaluation().Exists)
              Sys.Keys("[Down]");
            
            }
          Get_WinReportConfiguration_AdvancedPortfolioEvaluation().set_IsSelected(true);
}
        
function SelectReport(reportName){
          
          Get_Reports_GrpReports_TabReports_LvwReport().WPFObject("CFTreeViewItem", "", 1).WPFObject("TextBlock", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 310, language), 1).Click()
          count1 = Get_Reports_GrpReports_TabReports_LvwReport().Items.Item(1).Nodes.Count;
          count2 = Get_Reports_GrpReports_TabReports_LvwReport().Items.Item(2).Nodes.Count;
          count = count1+count2;
          for(i=1; i<=count+2;i++){
            Sys.Keys("[Down]");          
            if (Get_Reports_GrpReports_TabReports_LvwReport().FindChild(["ClrClassName","WPFControlText"],["TextBlock",reportName]).Exists){
              Get_Reports_GrpReports_TabReports_LvwReport().FindChild(["ClrClassName","WPFControlText"],["TextBlock",reportName]).Click();
              break;
            }
          }
          Get_Reports_GrpReports_BtnAddAReport().Click();
          Log.Message("Report '" + reportName + "' selected.");
}
        
function DeleteCopyOfReport(){
            //Aller dans Outils / Configurations / rapports / configuration des rapports /     
            Get_MenuBar_Tools().Click();
            while (! Get_SubMenus().Exists)
              Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
            //Cliquer sur Rapport et entrer dans Configuration des rapports
            Get_WinConfigurations_TvwTreeview_LlbReports().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
            Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
            WaitObject(Get_CroesusApp(),"WndCaption", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language));
            
            //Cliquer sur le bouton (flèche=>) et choisir Groupe Utilisateur
            Get_WinReportConfiguration_BtnGroup().Click();
            Get_WinReportConfiguration_BtnGroup_ItemUser().Click();
            
            //Supprimer les rapports dans la liste user
            do {              
                Get_WinReportConfiguration_CopyOfAdvancedPortfolioEvaluation().set_IsSelected(true);
                Get_WinReportConfiguration_BtnDelete().Click();
                Get_DlgConfirmation_BtnRemove().Click();
            }while (Get_WinReportConfiguration_CopyOfAdvancedPortfolioEvaluation().Exists)
            
            //Fermer les toutes les fenêtres
            Get_WinReportConfiguration_BtnClose().Click();
            Get_WinConfigurations().Close();
}
        
        