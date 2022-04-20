//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_048_Common_functions
//USEUNIT CR1485_Common_functions


/**
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
*/

function CR1827_RPT_3438()
{
       
    try {
       Log.Link("https://jira.croesus.com/browse/TCVE-2509", "Lien vers la story");
       Log.Link("https://jira.croesus.com/browse/RPT-3438", "Lien vers le cas de test");
       //Les préconditions


//       UpdateDatabase()
  
       

        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
       
        var reportName            =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportName", language+client);
        var dateOfDetentionStep2  =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "dateOfDetentionStep2", language+client);  
        var reportLanguageStep2   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportLanguageStep2", language+client); 
        var reportFileNameStep2   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep2", language+client);
        var reportLanguageStep3   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportLanguageStep3", language+client); 
        var reportFileNameStep3   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep3", language+client);
        var dateOfDetentionStep4  =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "dateOfDetentionStep4", language+client);
        var reportFileNameStep4   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep4", language+client);
        var reportFileNameStep5   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep5", language+client);
  
  
      
        
/************************************Étape 1************************************************************************/     
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: - Se loguer avec l'user GP1859 - Clients / Rapports / Déplacer vers la droite le rapport *FATCA – Particuliers – Valeurs élevées*");
         
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        Log.Message("Il faut utiliser le dump : RGMP_90.20.2020.10-11_2020-10-27_Sana  qui se trouve dans BDREF sinon il faut voir avec Karima Mehiguene")
        
        Get_ModulesBar_BtnClients().Click();
	      Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportName);
/************************************Étape 2************************************************************************/     
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2:- Paramètres:- *Date de détention*: 31 décembre 2009- *Langue*: Français-  Cliquer sur OK pour produire le rapport *Note:* La devise est toujours USD ");
 
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep2);
        SetReportsOptions(null, null, null, reportLanguageStep2, null, null, null, null, null, null, true);
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep2, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
 /************************************Étape 3************************************************************************/     
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3:-Refaire l'étape 2, pour produire le rapport en *English*");
          //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportName);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep2);
        SetReportsOptions(null, null, null, reportLanguageStep3, null, null, null, null, null, null, true);
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep3, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
/************************************Étape 4************************************************************************/     
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4:- Avec le même user- Clients / Rapports / Déplacer vers la droite le rapport *FATCA – Particuliers – Valeurs élevées*- Paramètres:- *Date de détention*: 31 décembre 2005*Langue*: Français-Cliquer sur OK pour produire le rapport");
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportName);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep4);
        SetReportsOptions(null, null, null, reportLanguageStep2, null, null, null, null, null, null, true);
          //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep4, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
       
        
/************************************Étape 5************************************************************************/     
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5:- Refaire l'étape 4, pour produire le rapport en *English*");
         //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportName);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep4);
        SetReportsOptions(null, null, null, reportLanguageStep3, null, null, null, null, null, null, true);
          //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep5, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
       
        
        
                
         }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function UpdateDatabase()  {
   
    //Mise à jour de la BD
    var SQLQuery_B_def1 = "update b_def set DEFAULT_VALUE='2002.06.30' where cle = 'PREF_REPORT_GPD_FATCA_DATE'";		
    var SQLQuery_B_def2 = "update b_def set DEFAULT_VALUE='2002.06.30' where cle = 'PREF_REPORT_GPD_NCD_DATE'";		
    
    var SQLQuery_B_addrss1 = "update b_addrss set COUNTRY='West Australia' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182705')";		
    var SQLQuery_B_addrss2 = "update b_addrss set COUNTRY='États Unis' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182708')";		
    var SQLQuery_B_addrss3 = "update b_addrss set COUNTRY='Germany' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182711')";		
    var SQLQuery_B_addrss4 = "update b_addrss set COUNTRY='ANDORRE' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182717')";		
    var SQLQuery_B_addrss5 = "update b_addrss set COUNTRY='Danemark' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182718')";		
    var SQLQuery_B_addrss6 = "update b_addrss set COUNTRY='Belgique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182719')";		
    var SQLQuery_B_addrss7 = "update b_addrss set COUNTRY='Mexique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182720')";		
    var SQLQuery_B_addrss8 = "update b_addrss set COUNTRY='New Zealand' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182721')";		
    var SQLQuery_B_addrss9 = "update b_addrss set COUNTRY='Argentina' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182723')";		
    var SQLQuery_B_addrss10 = "update b_addrss set COUNTRY='Espagne' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182725')";		
    var SQLQuery_B_addrss11 = "update b_addrss set COUNTRY='France' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182726')";		
    var SQLQuery_B_addrss12 = "update b_addrss set COUNTRY='Venezuela' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182728')";		
    var SQLQuery_B_addrss13 = "update b_addrss set COUNTRY='Chili' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182744')";		
    var SQLQuery_B_addrss14= "update b_addrss set COUNTRY='United Arab Emi' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182745')";		
    var SQLQuery_B_addrss15 = "update b_addrss set COUNTRY='Finland' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182746')";		
    var SQLQuery_B_addrss16 = "update b_addrss set COUNTRY='Equatorial Guin' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182747')";		
    var SQLQuery_B_addrss17 = "update b_addrss set COUNTRY='Ireland' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182748')";		
    var SQLQuery_B_addrss18= "update b_addrss set COUNTRY='Luxembourg' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182750')";		
    var SQLQuery_B_addrss19= "update b_addrss set COUNTRY='Maurice' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182751')";		
    var SQLQuery_B_addrss20= "update b_addrss set COUNTRY='Mozambique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182752')";
    				
    				
      
    Log.Message("Mise à jour de la BD");
    Execute_SQLQuery(SQLQuery_B_def1, vServerReportsCR1485);
    Execute_SQLQuery(SQLQuery_B_def2, vServerReportsCR1485);
    
    
    
     Execute_SQLQuery(SQLQuery_B_addrss1, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss2, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss3, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss4, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss5, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss6, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss7, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss8, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss9, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss10, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss11, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss12, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss13, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss14, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss15, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss16, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss17, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss18, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss19, vServerReportsCR1485);
     Execute_SQLQuery(SQLQuery_B_addrss20, vServerReportsCR1485);
     
     Activate_Inactivate_PrefFirm("FIRM_1", "FD_TAXEVASION_DECLARABLE_ACC", "AA,AC,AD,AE,AG,AI,AJ,AK,AM,AO,AP,AQ,AS,AU,AV,AW,AY,AZ,BB,BC,BE,BF,BH,BI,BK,BL,BN,BO,BQ,BR,BT,BU,BW,BX,BZ,CA,CD,CF,CG,CI,CJ,CL,CM,CO,CP,CQ,CR,CS,CU,CV,CX,CY,DA,DD,DG,DL,DM,DP,DS,DV", vServerReportsCR1485); 

    Log.Message("Redémarrage des services");
    RestartServices(vServerReportsCR1485); 
}

function SetReportParametersDateOfDetention(dateOfDetention)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
         }
    
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        WaitReportParametersWindow();
        SelectComboBoxItem(Get_WinParameters_CmbDateOfDetention(), dateOfDetention);
        Delay(300);
        Get_WinParameters_BtnOK().Click();
}