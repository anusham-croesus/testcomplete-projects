//USEUNIT CR1958_2_Helper

/**
    Description : Cas pour regénerer l'environemnet RQS
   https://jira.croesus.com/browse/RISK-1822
    
    Ce cas sert à Mettre à jour les tables de RQS:
    
        1. Vides les tables :
        
               B_RQS_ALERT_SECURITY
               B_RQS_CLIENT
               B_RQS_ALERT
               B_RQS_ALERT_CLIENT
               B_RQS_ALERT_ACCOUNT
               B_RQS_TRANS_BLOTTER
               B_RQS_TRANS_BLOTTER_VALIDATION
               
        2. Rouler les plugins suivants:
        
               cfLoader -DashboardRegenerator "generateAccountPortfolio=false generateRQSPortfolio=Client,Link" -firm=FIRM_1
               cfLoader -RQSActivityBlotter="StartDate:2009.01.17;EndDate:2010.01.25"
               cfLoader -RiskRating \"-report\"
               cfLoader -RQSAlertGenerator
                  
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Amine A.
    Version de scriptage : ref90.15-86
*/

function CR1958_RISK_1822_RQS_Environment_Regeneration()
{
    Log.Link("https://jira.croesus.com/browse/RISK-1822", "CR1958_RISK_1822_RQS_Environment_Regeneration()");
    
        var cfLoaderPlugin_generateRQSPortfolio                    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_generateRQSPortfolio", language + client);
        var cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_RQSActivityBlotter                      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RQSActivityBlotter", language + client);
        var cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_RiskRating_report                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RiskRatingReport", language + client);
        var cfLoaderPlugin_RiskRating_report_OutputSuccessRegEx    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RiskRatingReport_OutputSuccessRegEx", language + client);        
        var cfLoaderPlugin_RQSAlertGenerator                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RQSAlertGenerator", language + client);
        var cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx", language + client);

        var RISK_1822_SSHUser     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_SSHUser", language + client);
        var RISK_1822_SSHFolder   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_RISK_1822_SSHFolder", language + client);
        var all_SSH_FilesNames    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_FilesNames", language + client);  
        var productionPassword    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_Password", language + client);
        
        var lowInvestment_Risk    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_lowInvestment_Risk", language + client);
        var mediumInvestment_Risk = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_mediumInvestment_Risk", language + client);
        var highInvestment_Risk   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_highInvestment_Risk", language + client);
        
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");        
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SECURITY_RATING_PASSWORD", productionPassword, vServerRQS);
     
        var MNEMONICS_VALUES_String = "ANNUAL_INCOME_MNEMONIC=ANNUAL_INCOME\nINV_OBJECTIVE_INCOME_MNEMONIC=INV_OBJECTIVE_1\nINV_OBJECTIVE_LONG_TERM_MNEMONIC=INV_OBJECTIVE_4\n" +
                                      "INV_OBJECTIVE_MEDIUM_TERM_MNEMONIC=INV_OBJECTIVE_3\nINV_OBJECTIVE_SHORT_TERM_MNEMONIC=INV_OBJECTIVE_2\nINVESTMENT_KNOWLEDGE_MNEMONIC=INV_KNOW\n" +
                                      "INVESTMENT_RISK_HIGH_MNEMONIC=INVESTMENT_RISK_3\nINVESTMENT_RISK_LOW_MNEMONIC=INVESTMENT_RISK_1\nINVESTMENT_RISK_MEDIUM_MNEMONIC=INVESTMENT_RISK_2\n" +
                                      "NET_WORTH_MNEMONIC=NET_WORTH\nNON_RESIDENT_INDICATOR_MNEMONIC=NON_RESIDENT_IND\nPRO_INDICATOR_MNEMONIC=PRO\nPRODUCT_TYPE_MNEMONIC=PRODUCT_TYPE\n" +
                                      "RESIDENCY_LOCATION_MNEMONIC=RESIDENCY_LOC";

        var queryUpdateString = "update b_config set note = '" + MNEMONICS_VALUES_String + "' where cle = 'FD_COMPLIANCE_PROFILS'";
        var queryInsertString = "INSERT INTO b_config (cle, note) VALUES ('FD_COMPLIANCE_PROFILS', '" + MNEMONICS_VALUES_String + "')";
        
//        Log.Message(queryUpdateString)
        
        //Si la ligne 'FD_COMPLIANCE_PROFILS' existe dans la table 'b_config' on la met à jour, sinon on l'insère
        var queryString = "select * from b_config where cle = 'FD_COMPLIANCE_PROFILS'";
        var FD_ComliancePF_Exist = Execute_SQLQuery_GetField(queryString, vServerRQS, "cle");
        if (FD_ComliancePF_Exist)
            Execute_SQLQuery(queryUpdateString, vServerRQS);   
        else
            Execute_SQLQuery(queryInsertString, vServerRQS);   
        
//        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", "", vServerRQS);
        RestartServices(vServerRQS);
        
            
    try {
      
        //Précondition: update b_config set note='/home/taousa/CR1958' where CLE='FD_DATA_DIR'
        Execute_SQLQuery("update b_config set note='/home/aminea/CR1958' where CLE='FD_DATA_DIR'", vServerRQS);
    
        //Téléverser sur le vserver les fichiers requis pour les commandes SSH
        TestSSHConnexions(vServerRQS);
        var vserverRemoteFolder = "/home/" + RISK_1822_SSHUser + "/" + RISK_1822_SSHFolder + "/"; //Has to comply with function ExecuteSSHCommand()
        Log.Message("The vserver remote folder is: " + vserverRemoteFolder);       
        CopySSHFileToVserver(all_SSH_FilesNames, vserverRemoteFolder);
        

        
         /*
        ÉTAPE #1 : Exécuter les commandes loader suivantes (Récupérer les fichiers en annexe):
        loader 800229_PRO.xml -FORCE -LOG2STDOUT
        loader 800401_PRO.xml -FORCE -LOG2STDOUT
        loader 800300_PRO.xml -FORCE -LOG2STDOUT
        loader 800302_PRO.xml -FORCE -LOG2STDOUT
        */
        Log.Message("STEP #1 : Add Transactions through loader commands.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        LoaderFilesCommand(all_SSH_FilesNames, RISK_1822_SSHFolder);
              
               
        //Se loguer avec KEYNEJ pour peupler la matrice
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        
        Log.Message("Peupler la matrice");
        
        var numTry = 0;
        do {
            Get_MenuBar_Tools().OpenMenu();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
            
        Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation().DblClick();
        WaitObject(Get_CroesusApp(),"Uid", "Window_2efc");
        
        //Risk allocation levels for all Security risk ratings      
        var dataSeparatorChar = "|";
        var allSecurityRiskRatings = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_SecurityRiskRatings", language + client);
        var arrayOfSecuritiesRiskRatings  = (Trim(allSecurityRiskRatings) == "")? []: allSecurityRiskRatings.split(dataSeparatorChar);
        Log.Message("The risk ratings are: " + arrayOfSecuritiesRiskRatings);
        
        for (j in arrayOfSecuritiesRiskRatings){
            var riskRating = arrayOfSecuritiesRiskRatings[j];
            //Remplir les lignes
            SecurityRiskRatingsSetting(riskRating);
        }       
        
        //Risk Rating Profiles Mnemonic codes
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(lowInvestment_Risk);
        
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(mediumInvestment_Risk);
        
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(highInvestment_Risk);
        
       
        //Save with password
        Get_WinRiskAllocationConfigurationTool_BtnSave().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["BaseWindow",1]);
        Get_DlgConfirmation_TxtRiskIndexPasswordBox().Keys(productionPassword);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 80);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "Window_2efc");
        
        Get_WinConfigurations().Close();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
        
        //Fermer Croesus
        Close_Croesus_X();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        RestoreAutoTimeOut();
       
        //Excute Risk Rating plugin
      
    //Étape1  
          //Vider les tables: B_RQS_ALERT_SECURITY, B_RQS_CLIENT, B_RQS_ALERT, B_RQS_ALERT_CLIENT, B_RQS_ALERT_ACCOUNT, B_RQS_TRANS_BLOTTER et B_RQS_TRANS_BLOTTER_VALIDATION
          Log.Message("Étape #1 : Vider les tables: B_RQS_ALERT_SECURITY, B_RQS_CLIENT, B_RQS_ALERT, B_RQS_ALERT_CLIENT, B_RQS_ALERT_ACCOUNT, B_RQS_TRANS_BLOTTER et B_RQS_TRANS_BLOTTER_VALIDATION", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
          
          Execute_SQLQuery("truncate table B_RQS_ALERT_SECURITY",           vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_CLIENT",                   vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_ALERT",                    vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_ALERT_CLIENT",             vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_ALERT_ACCOUNT",            vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_TRANS_BLOTTER",            vServerRQS);
          Execute_SQLQuery("truncate table B_RQS_TRANS_BLOTTER_VALIDATION", vServerRQS);

    //Étape2
          Log.Message("Étape #2 : Rouler les plugins.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
          
          ExecuteSSHCommand(RISK_1822_SSHFolder, vServerRQS, cfLoaderPlugin_generateRQSPortfolio,RISK_1822_SSHUser);//, cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx); A.A le log de la commande est vide
          ExecuteSSHCommand(RISK_1822_SSHFolder, vServerRQS, cfLoaderPlugin_RQSActivityBlotter,  RISK_1822_SSHUser);//, cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx);
          ExecuteSSHCommand(RISK_1822_SSHFolder, vServerRQS, cfLoaderPlugin_RQSAlertGenerator,   RISK_1822_SSHUser);//, cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx);
          ExecuteSSHCommand(RISK_1822_SSHFolder, vServerRQS, cfLoaderPlugin_RiskRating_report,   RISK_1822_SSHUser);//, cfLoaderPlugin_RiskRating_report_OutputSuccessRegEx);
 

    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
}

function test(){
        var MNEMONICS_VALUES_String = "ANNUAL_INCOME_MNEMONIC=ANNUAL_INCOME\nINV_OBJECTIVE_INCOME_MNEMONIC=INV_OBJECTIVE_1\nINV_OBJECTIVE_LONG_TERM_MNEMONIC=INV_OBJECTIVE_4\n" +
                                      "INV_OBJECTIVE_MEDIUM_TERM_MNEMONIC=INV_OBJECTIVE_3\nINV_OBJECTIVE_SHORT_TERM_MNEMONIC=INV_OBJECTIVE_2\nINVESTMENT_KNOWLEDGE_MNEMONIC=INV_KNOW\n" +
                                      "INVESTMENT_RISK_HIGH_MNEMONIC=INVESTMENT_RISK_3\nINVESTMENT_RISK_LOW_MNEMONIC=INVESTMENT_RISK_1\nINVESTMENT_RISK_MEDIUM_MNEMONIC=INVESTMENT_RISK_2\n" +
                                      "NET_WORTH_MNEMONIC=NET_WORTH\nNON_RESIDENT_INDICATOR_MNEMONIC=NON_RESIDENT_IND\nPRO_INDICATOR_MNEMONIC=PRO\nPRODUCT_TYPE_MNEMONIC=PRODUCT_TYPE\n" +
                                      "RESIDENCY_LOCATION_MNEMONIC=RESIDENCY_LOC";

        var queryUpdateString = "update b_config set note = '" + MNEMONICS_VALUES_String + "' where cle = 'FD_COMPLIANCE_PROFILS'";
        var queryInsertString = "INSERT INTO b_config (cle, note) VALUES ('FD_COMPLIANCE_PROFILS', '" + MNEMONICS_VALUES_String + "')";
        
        Log.Message(queryUpdateString)
        
        
        var queryString = "select * from b_config where cle = 'FD_COMPLIANCE_PROFILS'";
        var FD_ComliancePF_Exist = Execute_SQLQuery_GetField(queryString, vServerRQS, "cle");
        if (FD_ComliancePF_Exist)
            Execute_SQLQuery(queryUpdateString, vServerRQS);   
        else
            Execute_SQLQuery(queryInsertString, vServerRQS);

}

function CopySSHFileToVserver(all_SSH_FilesNames, vserverRemoteFolder) {
  
          var dataSeparatorChar        = "|";
          var arrayOfAllSSHFilesNames  = (Trim(all_SSH_FilesNames) == "")? []: all_SSH_FilesNames.split(dataSeparatorChar);
          Log.Message( arrayOfAllSSHFilesNames);
          
          for (j=0; j< arrayOfAllSSHFilesNames.length; j++){
            var fileName = arrayOfAllSSHFilesNames[j];
            Log.Message("The value: " + fileName);
            CopyFileToVserverThroughWinSCP(vServerRQS, vserverRemoteFolder, CR1958_2_REPOSITORY_SSH + fileName);
            Delay(10000);
            
            }
}
function LoaderFilesCommand(all_SSH_FilesNames, RISK_1822_SSHFolder) {

          var dataSeparatorChar        = "|";
          var arrayOfAllSSHFilesNames  = (Trim(all_SSH_FilesNames) == "")? []: all_SSH_FilesNames.split(dataSeparatorChar);
          
          for (j=0; j< arrayOfAllSSHFilesNames.length; j++){
            var fileName = arrayOfAllSSHFilesNames[j];
            Log.Message("Loader: " + j);
            ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, "loader "+ fileName +" -FORCE -LOG2STDOUT", RISK_1822_SSHFolder);
            Delay(10000);            
            }
}

function SecurityRiskRatingsSetting(riskRating){
  
    var dataSeparatorChar       = "|";
    var all_Low_RiskAllocationLevels    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_RiskAllocationLevels_" + riskRating, language + client);
    var arrayOfAllRiskAllocationLevels  = (Trim(all_Low_RiskAllocationLevels) == "")? []: all_Low_RiskAllocationLevels.split(dataSeparatorChar);
    Log.Message( arrayOfAllRiskAllocationLevels);
    
        switch(riskRating){
        case "Low":
        {                 
            Log.Message("The security risk ratings: low");  
            var rating = 1;                
            break;
        }
        case "Low-Medium":
        {  
            Log.Message("The security risk ratings: low-Medium");  
            var rating = 2;               
            break;
        }
        case "Medium":
        {  
            Log.Message("The security risk ratings: Medium");  
            var rating = 3;                    
            break;
        }
        case "Medium-High":
        {  
            Log.Message("The security risk ratings: Medium-High");  
            var rating = 4;                  
            break;
        }                  
        case "High":
        {  
            Log.Message("The security risk ratings: High");  
            var rating = 5;                   
            break;
        }
        }
    
        for (j=0; j< arrayOfAllRiskAllocationLevels.length; j++){
            var value = arrayOfAllRiskAllocationLevels[j];
            Log.Message("The value: " + value +"---" +j);
            Get_WinRiskAllocationConfigurationTool().WPFObject("dgMatrix").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", rating).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", j+3).WPFObject("XamNumericEditor", "", 1).Click()
            Get_WinRiskAllocationConfigurationTool().WPFObject("dgMatrix").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", rating).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", j+3).WPFObject("XamNumericEditor", "", 1).Keys(value + "[Tab]")
            Delay(500);
//            Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", j+3], 10).WPFObject("XamNumericEditor", "", 1).Click();
//            Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", j+3], 10).WPFObject("XamNumericEditor", "", 1).Keys(value + "[Tab]");
//            Delay(500);
        }
}
