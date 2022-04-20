//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_034_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_048_Cli_Ind_BVMV_CR1562
//USEUNIT CR1485_133_Rel_Ind_BVMV_CR1562

/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
*/

function CR1485_034_Sec_Ind_BVMV_CR1562()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\34. Échéances\\1.1 Securities", "CR1485_034_Sec_Ind_BVMV_CR1562");
    Log.Link("https://jira.croesus.com/browse/TCVE-24", "Lien vers la story");
        
    
    try {
//    Les variables  
        var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
   
        var securitiesNames = GetData(filePath_ReportsCR1485, "034_MATURITY", 39, language);
        var arrayOfSecuritiesNames = securitiesNames.split("|");
        var reportName = GetData(filePath_ReportsCR1485, "034_MATURITY", 40,language);
        var arrayOfReportsNames = reportName.split("|");
        
        var reportFileName = GetData(filePath_ReportsCR1485, "034_MATURITY", 46);
        
        
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "034_MATURITY", 49, language);
        var sortBy = GetData(filePath_ReportsCR1485, "034_MATURITY", 50, language);
        var currency = GetData(filePath_ReportsCR1485, "034_MATURITY", 51, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "034_MATURITY", 52, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "034_MATURITY", 53, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "034_MATURITY", 54, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "034_MATURITY", 55, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "034_MATURITY", 56, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "034_MATURITY", 57, language);
        var message = GetData(filePath_ReportsCR1485, "034_MATURITY", 58, language);
        var source = GetData(filePath_ReportsCR1485, "034_MATURITY", 59, language);
        
        
        //Activate Prefs
        ActivatePrefs_CR1485_034_Sec_Ind_BVMV_CR1562();
        
        Log.Message("Mise à jour de la BD");       
        Update_Database();
        
         //Login
        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
         
        //Dévalidation des rapports
        Log.Message("Dévalider les rapports");
        DevalidateReports_49();
        
        Log.Message("Sélectionner le module titre")
        Get_ModulesBar_BtnSecurities().Click();
       //   Sélectionner les titres suivants :L05144|388548|460009|306362|162064|221374|285791|359131|U63676|550160|M85810|599751|744310     
        Log.Message("Sélectionner des titres")
        SelectSecuritiesBySecurity(arrayOfSecuritiesNames);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        //Selection des options pour le rapport
        Log.Message("Sélection des options du rapport");
     
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSource(), source);
        
        //Sélection de tous les rapports nécessaires
        Log.Message("Sélection des rapports");
        SelectReports(arrayOfReportsNames);
        //Selection, déplacement et traitement des différents rapports
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[0] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        ChangingSecurityHoldersReportParameters(arrayOfReportsNames[0]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[1] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        ChangingMaturityReportParameters(arrayOfReportsNames[1]);
        
        Log.Message("Validaton et sauvegarde des rapports");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);    
           
         //************************* Generate French report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "034_MATURITY", 78);
          
          //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        //Selection des options pour le rapport
        Log.Message("Sélection des options du rapport");
       //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "034_MATURITY", 81, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "034_MATURITY", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSource(), source);
         //Sélection de tous les rapports nécessaires
        Log.Message("Sélection des rapports");
        SelectReports(arrayOfReportsNames);
        //Selection, déplacement et traitement des différents rapports
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[0] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        ChangingSecurityHoldersReportParameters(arrayOfReportsNames[0]);
        
        Log.Message("Déplacer le rapport " + arrayOfReportsNames[1] + " au top et sélectionner les paramètres" );
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        ChangingMaturityReportParameters(arrayOfReportsNames[1]);
        
        Log.Message("Validaton et sauvegarde des rapports");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);    
           
      
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function ActivatePrefs_CR1485_034_Sec_Ind_BVMV_CR1562(){
       
/* 
0. Pref rapports (Niveau firme)
PREF_REPORT_HOLDERS=YES
PREF_REPORT_MATURITY=YES


*/  
     //Pref niveau firme
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_HOLDERS", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_MATURITY", "YES", vServerReportsCR1485);
      
/*    
1. *** Nievau firme ***
PREF_REPORT_BVMV_IND = YES						
PREF_LOT_DEFAULT_PRICE = NO						
PREF_USE_DEFAULT_VALUES = NO	
*/  

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_USE_DEFAULT_VALUES", "NO", vServerReportsCR1485);
        
        
  /*      *** Niveau firme ***
PREF_REPORT_MATURITY=YES (pour le rapport)
PREF_TAX_LOT=NO
 */  
 
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_MATURITY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TAX_LOT", "NO", vServerReportsCR1485);
   
//      Redémarrer les services  
        Log.Message("Redémarrage des services")
//        RestartServices(vServerReportsCR1485);
        
        }
        
        
// Fonction qui permet de changer les paramètres du rapport: Clients détenteurs       
               
function ChangingSecurityHoldersReportParameters(reportName) {
    
     var checkIncludePortfolioValue = GetData(filePath_ReportsCR1485, "034_MATURITY", 64, language);
     var costCalculation = GetData(filePath_ReportsCR1485, "034_MATURITY", 65, language);
      
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
     SetReportParameters_Reports_034_Sec_Ind_BVMV_CR1562(checkIncludePortfolioValue, costCalculation,"","","")

} 



       
// Fonction qui permet de changer les paramètres du rapport: Clients détenteurs       
               
function ChangingMaturityReportParameters(reportName) {
    
     var startDate = GetData(filePath_ReportsCR1485, "034_MATURITY", 71, language);
     var endDate = GetData(filePath_ReportsCR1485, "034_MATURITY", 72, language);
     var checkAllRecords = GetData(filePath_ReportsCR1485, "034_MATURITY", 73, language);
     var costCalculation = GetData(filePath_ReportsCR1485, "034_MATURITY", 74, language);
        
     
    //Sélectionner les paramètres du rapport
    Log.Message("Sélection des paramètres du rapport " + reportName);
     //Set the report parameters
    SetReportParameters_Reports_034_Sec_Ind_BVMV_CR1562("", costCalculation,startDate,endDate,checkAllRecords)
} 




       
   
        
        


 
function SetReportParameters_Reports_034_Sec_Ind_BVMV_CR1562(checkIncludePortfolioValue,costCalculation,startDate,endDate,checkAllRecords)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    // Inclure la valeur du portefeuille (%) (Include portfolio (%) value) 
   if (Trim(VarToStr(checkIncludePortfolioValue)) != ""){

    if (Get_WinParameters_ChkIncludePortfolioValue().IsEnabled)
        Get_WinParameters_ChkIncludePortfolioValue().set_IsChecked(aqString.ToUpper(checkIncludePortfolioValue) == "VRAI" || aqString.ToUpper(checkIncludePortfolioValue) == "TRUE");    
     }  
  
// Calcul du coût (Cost Calculation) 
     if (Trim(VarToStr(costCalculation)) != ""){

    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    } 
    
// Date de début (Start Date)
   if (Trim(VarToStr(startDate)) != ""){
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    } 

    
    // Date de fin (End Date)
   if (Trim(VarToStr(endDate)) != ""){
     SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    } 
    
// Tous les enregistrements (All Records)    
if (Trim(VarToStr(checkAllRecords)) != ""){
        
    if (Get_WinParameters_ChkAllRecords().IsEnabled)
        Get_WinParameters_ChkAllRecords().set_IsChecked(aqString.ToUpper(checkAllRecords) == "VRAI" || aqString.ToUpper(checkAllRecords) == "TRUE");
    

}

 
       
    Get_WinParameters_BtnOK().Click();
}



function SelectSecuritiesBySecurity(arrayOfSecuritiesNamesToBeSelected)
{
    if (GetVarType(arrayOfSecuritiesNamesToBeSelected) != varArray && GetVarType(arrayOfSecuritiesNamesToBeSelected) != varDispatch)
        arrayOfSecuritiesNamesToBeSelected = new Array(arrayOfSecuritiesNamesToBeSelected);
        
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (var i = 0; i < arrayOfSecuritiesNamesToBeSelected.length; i++){
        var securityNameToBeSelected = arrayOfSecuritiesNamesToBeSelected[i];
        Search_Security(securityNameToBeSelected);
        var objSecurityToBeSelected = Get_SecurityGrid().FindChildEx("Value", securityNameToBeSelected, 10, true, 30000);
        if (objSecurityToBeSelected.Exists)
            objSecurityToBeSelected.Click(-1, -1, skCtrl);
        else
            Log.Error("Security description '" + securityNameToBeSelected + "' not found");
    }
    
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements != arrayOfSecuritiesNamesToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfSecuritiesNamesToBeSelected.length + " securities have been actually selected!");
    
    return (nbOfSelectedElements == arrayOfSecuritiesNamesToBeSelected.length);
}
