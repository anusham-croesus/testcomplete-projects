//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_136_Common_functions
//USEUNIT CR1485_155_Common_function


/**
    Description : 
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\136. Rapport de fin d'exercice\3.2 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation :  Philippe Maurice
*/

function CR1485_136_Acc_Ind_BVMV_CR1562()
{       
    try {
        /*Variables*/
        var savedReportName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 2, language);
        var accountNumbers = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 53);
        var arrayOfAccountNumbers = accountNumbers.split("|");
        

        
        //Reports options values
        var packageStartDate = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 57, language);
        var packageEndDate = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 58, language);
        
        var destination = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 62, language);
        var sortBy = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 63, language);
        var currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 64, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 65, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 66, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 67, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 68, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 69, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 70, language);
        var message = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 71, language);

        Log.Link("https://jira.croesus.com/browse/TCVE-24", "Lien de la story");
        
        //Activation des PREFS
        Log.Message("Activation des PREFS");
        Activate_PREFS();
             
        //Mise à jour de la BD
        Log.Message("Mise à jour de la base de données");
        Update_DataBase();
        
        //Login
        Log.Message("Se connecter à l'application");
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Dévalider les rapports
        Log.Message("Dévalidation des rapports");
        DevalidateReports();
        
        //Select clients
        Log.Message("Sélection des numéros de compte");
        SelectAccounts(arrayOfAccountNumbers);
        
        
        //************************* Generate reports *********************
        Log.Message("Génération des rapports en anglais et en français");
        var reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 55);
        
        /*Explication de la boucle for: La génération des rapports se fait en anglais et en français
        Donc il va y avoir 2 itérations:  une pour anglais, une pour français */
        for (i=0; i<2; i++) {
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
        
            //Sélectionner le rapport de fin d'exercice
            Log.Message("Sélectionner le rapport " + savedReportName );
            SelectFirmSavedReport(savedReportName);        
        
            //Selection des options pour le rapport
            Log.Message("Sélection des options du rapport en " + reportLanguage);
            selectDates(packageStartDate, packageEndDate);
            SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
            Log.Message("Validaton et sauvegarde des rapports");
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
            //Changement de langue (Français)
            reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 77);
            currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 80, language);
            reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 81, language);
        }    
            
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



function Activate_PREFS() {

    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_USE_DEFAULT_VALUES", "NO", vServerReportsCR1485);
}


function Update_DataBase(){
    
    //Mise à jour de la BD
    var SQLQuery_B_Portef = "update b_portef set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001)";
    var SQLQuery_B_HISPO_DELTA = "update B_HISPO_DELTA set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001) and no_compte in ('300001-NA', '300002-OB', '800064-RE','800300-NA','800400-NA')";
    var SQLQuery_B_TRANS = "update B_TRANS set BV_MV_IND='Y' where security in (2616,3216,3384,3855,4016,4505,5022,48415,49132,430403404,430488097,430516922,440577918,440571460,17001) and no_compte in ('300001-NA', '300002-OB', '800064-RE', '800300-NA','800400-NA')";
        
    Log.Message("Mise à jour de la BD");
    Execute_SQLQuery(SQLQuery_B_Portef, vServerReportsCR1485);
    Execute_SQLQuery(SQLQuery_B_HISPO_DELTA, vServerReportsCR1485);
    Execute_SQLQuery(SQLQuery_B_TRANS, vServerReportsCR1485);

    Log.Message("Redémarrage des services");
    RestartServices(vServerReportsCR1485); 
}


function DevalidateReports() {

    //Outils / Configurations / Rapports / Configurations des défauts / OK
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
    Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
    Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 45000);
    Get_WinDefaultConfiguration_BtnOK().Click();
    Get_WinConfigurations().Close();
    
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "BaseFrame_4c01", 40000);
    
    Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000); //Christophe : Stabiliation
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000); //Christophe : Stabiliation
}
