//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : En tant que RTE, je veux automatiser  les jiras RPT-2273 et RPT-3260  dans une Bd QA interne (BNC)
                  Afin que ces jiras  soient couverts dans nos tests auto du module Rapports
                  
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
    version: 90.25-69
    Date: 2021-05-13
*/


function TCVE_2479_RPT_2415_ProjectedAnnualIncome_ReportConfig_EditBtn()
{
    Log.Link("https://jira.croesus.com/browse/TCVE-2479");
    
    try {
        
        //Préconditions   PREF_REPORT_ANNIC=YES
        Log.Message("Précondition:  Activer la pref 'PREF_REPORT_ANNIC = YES' ");
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_ANNIC", "YES", vServerReportsCR1485);
        
        
        var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "Anomalies", 20, language);
        var copiedReportName = GetData(filePath_ReportsCR1485, "Anomalies", 21, language);
        
        var columnNames = GetData(filePath_ReportsCR1485, "Anomalies", 22, language);
        arrayOfColumnNames = columnNames.split("|");
               
        //Se connecter avec l'utilisateur DARWIC
        Log.Message("Se connecter avec l'utilisateur " + userNameDARWIC + ".");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
        
        Log.Message("Cliquer sur Outils -> Configuration");
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
         
        //Cliquer sur "Rapports"
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_WinConfigurations(), "Uid", "ListView_bc90");
        //Cliquer sur Configuration des rapports
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        
        
        //Selectionner le rapport 'Projection de liquidités (annuelle)'
        Log.Message("Selectionner le rapport 'Projection de liquidités (annuelle)'")
        SelectReport(reportName, userName);           
        WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        Get_WinReportConfiguration_BtnCopyTo().Click();
        //Par défaut le nom du rapport sera "Copie de Projection de liquidités (annuelle)" ou "Copy of Projected Income (annual)"
        
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BaseDialog_136b", true], 15000);
        Get_WinCopyReport_BtnOK().Click();
        
        //Cliquer sur l'onglet Contenu
        Get_WinReportConfigurationCopy_TabContent().Click();
        
        Log.Message("Selectionner les colonnes et cliquer sur bouton 'Modifier'");
        SelectAndEditItems(arrayOfColumnNames);
             
        Log.Message("Cliquer sur le bouton 'OK'");
        Get_WinReportConfigurationCopy_BtnOK().Click();
        
        Log.Message("Fermer la fenêtre 'Configuration de rapport'");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre 'Configuration'");
        Get_WinConfigurations().Close();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Remise à la configuration initiale (supprimer le rapport copié)
        Log.Message("=== Remise à l'état initial de la fenêtre des rapports ==="); 
        DeleteCopyOfReport(copiedReportName);
        Terminate_CroesusProcess();
    }
}


function SelectReport(reportName, userName){
  
    Get_WinReportConfiguration_UniList().Click();          
    //Hit first character
    var reportNameFirstChar = aqString.ToLower(aqString.GetChar(reportName, 0));
    Get_WinReportConfiguration_UniList().Keys(reportNameFirstChar);
        
    var reportsCount = Get_WinReportConfiguration_UniList().Items.get_Count();
    //Get row Index
    var selectedRow = Get_WinReportConfiguration_UniList().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]);
    if (selectedRow.Exists)
        var selectedRowIndex = selectedRow.WPFControlOrdinalNo;

    for (var i = selectedRowIndex; i <= reportsCount; i++){             
        var currentReportName = VarToStr(Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).WPFControlText);
                  
        if (currentReportName == reportName){
              Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).Set_IsSelected(true);
                         
              Log.Message("Report '" + currentReportName + "' selected.");
              return true;
            }
        else  
            Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).Keys("[Down]");             
    }
        
    if(i == reportsCount+1) Log.Error("Le rapport '" + reportName + "' n'éxiste pas dans la liste des rapports");
}


function DeleteCopyOfReport(copiedReportName){

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
            
    //Cliquer sur le bouton (flèche=>) et choisir Groupe Utilisateur
    Get_WinReportConfiguration_BtnGroup().Click();
    Get_WinReportConfiguration_BtnGroup_ItemUser().Click();
            
    //Supprimer les rapports dans la liste user
    SelectReport(copiedReportName, "N/A");  //Sélectionner le rapport
    Get_WinReportConfiguration_BtnDelete().Click();  //Supprimer
    Get_DlgConfirmation_BtnRemove().Click();  //Confirmation de la suppression

    //Fermer les toutes les fenêtres
    Get_WinReportConfiguration_BtnClose().Click();
    Get_WinConfigurations().Close();
}



function SelectAndEditItems(itemsList){
    
    count = Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().wItemCount;
    Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", 1).Click();
    
    var i = 1;
    var found = false;
    
    for (j=0; j < itemsList.length; j++) { 
        
        i = 1;
        found = false;
        Log.Message("Selectionner et cliquer sur le bouton 'Modifier' de l'item " + itemsList[j] + ".");
        
        while ( i <= count && found == false) {
            if (Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i).DataContext.Name.OleValue == itemsList[j]) {
                found = true;
                Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i).Click();
            
                Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i).WPFObject("Button", "Modifier", 1).Click();
                WaitObject(Get_CroesusApp(), "Uid","UserDefinedReportColumnLabelWindow_d6ad");
                Get_WinColumnHeader_BtnCancel().Click();
            }        
            i = i + 1;
        }
    }
}