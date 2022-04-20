//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : En tant TCVE, je veux m'assurer que le crash quand on essaye de copier un rapport en cliquant sur le bouton copier vers
    Analyste d'assurance qualité : Karima Mehiguene
    Analyste d'automatisation : Alhassane Diallo
    version: 90.17.2020.7-38
    *Adapté sur la version 2020.09-45 par Philippe Maurice (2020-11-04)
*/

function RPT_2671_Crash_In_The_ReportConfigurationWindow()
{
    Log.Link("https://jira.croesus.com/browse/TCVE-1674");  
       
    try {
        
         //Se connecter avec l'utilisateur DARWIC
         Log.Message("Se connecter avec l'utilisateur DARWIC")
         var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
         var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
                
         var reportName = GetData(filePath_ReportsCR1485, "Anomalies", 14, language);
         var copiedReportName = GetData(filePath_ReportsCR1485, "Anomalies", 15, language);
         
               
         //Login 
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
         
         Get_WinConfigurations_TvwTreeview_LlbReports().Click();
         WaitObject(Get_WinConfigurations(), "Uid", "ListView_bc90");
         Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
         
         //Selectionner le rapport 'Cotisation'
         Log.Message("Selectionner le rapport 'Cotisation'")
         SelectOneReport1(reportName, userName);           
         WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
         Get_WinReportConfiguration_BtnCopyTo().Click();
         //Par défaut le nom du rapport sera "Copie de Cotisation" ou "Copy of Contributions"
         
         WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BaseDialog_136b", true], 15000);
         Get_WinCopyReport_BtnOK().Click();
         Get_WinReportConfigurationCopy_BtnOK().Click();
             
         //Valider qu'il n y ait plus de Crash, donc la fenetre  'configuration des rapports' existe et visible
         Log.Message("Valider qu'il n y ait plus de Crash donc la fenetre  'configuration des rapports' existe et visible"); 
         aqObject.CheckProperty(Get_WinReportConfiguration(), "Exists", cmpEqual,true);
         aqObject.CheckProperty(Get_WinReportConfiguration(), "IsVisible", cmpEqual,true);
         aqObject.CheckProperty(Get_WinReportConfiguration(), "VisibleOnScreen", cmpEqual,true);
            
         //Fermer les fenêtres
         Log.Message("Fermer les fenêtres"); 
         Get_WinReportConfiguration().Close();
         Get_WinConfigurations().Close();
         
         Delay(500);
         //Remise à la configuration initiale (supprimer le rapport copié)
         Log.Message("=== Remise à l'état initial de la fenêtre des rapports ==="); 
         DeleteCopyOfReport(copiedReportName);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}


function SelectOneReport1(reportName, userName){
  
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
    SelectOneReport1(copiedReportName, "N/A");  //Sélectionner le rapport
    Get_WinReportConfiguration_BtnDelete().Click();  //Supprimer
    Get_DlgConfirmation_BtnRemove().Click();  //Confirmation de la suppression

    //Fermer les toutes les fenêtres
    Get_WinReportConfiguration_BtnClose().Click();
    Get_WinConfigurations().Close();
}