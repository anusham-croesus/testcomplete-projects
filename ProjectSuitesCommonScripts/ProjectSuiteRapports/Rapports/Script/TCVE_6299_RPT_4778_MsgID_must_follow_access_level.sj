//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//CR1485_Common_functions



/**
    Description : En tant que TCVE, je veux automatiser le jira RPT-3454 pour l'inclure dans nos tests de régression du modules rapports
                  
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
    Version: 98.29-25
    Date: 15 novembre 2021
**/




function TCVE_6299_RPT_4778_MsgID_must_follow_access_level()
{
    try {
        
        var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        var userNameWASHIG = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "WASHIG", "username");
        var passwordWASHIG = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "WASHIG", "psw");
        
        Log.Link("https://jira.croesus.com/browse/TCVE-6189", "Lien de la story");
        Log.Link("https://jira.croesus.com/browse/RPT-2972", "Lien du cas de test");
    
        //Préconditions + Prefs pour créer des copies de rapports
        Activate_PREFS();
       
        //1. Se loguer avec l'user COPERN et créer une copie du rapport Gains et pertes (réalisés) au niveau Équipe de travail (ex nom: Copie de Gains et pertes (réalisés)_C)
        var reportName = GetData(filePath_ReportsCR1485, "Anomalies", 68, language);
        var newReportName = GetData(filePath_ReportsCR1485, "Anomalies", 69, language);
        var levelGlobal = GetData(filePath_ReportsCR1485, "Anomalies", 70, language);
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se loguer avec l'user COPERN et créer une copie du rapport Gains et pertes (réalisés) au niveau Équipe de travail (ex nom: Copie de Gains et pertes (réalisés)_C) ");
        Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language);
        Create_Report_Copy(levelGlobal, reportName, newReportName);   //Créer une copie de rapport
        Terminate_CroesusProcess();

        
        //2. Se loguer avec l'user DARWIC (qui appartient au même équipe de COPERN) / Clients / rapports / la Copie de Gains et pertes (réalisés)_C doit être disponible dans le groupe Équipe de travail (Nicolas Copernic) / fermer Croesus
        var levelNicCopernic = GetData(filePath_ReportsCR1485, "Anomalies", 72, language);
        
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Se loguer avec l'user DARWIC (qui appartient au même équipe de COPERN) / Clients / rapports / la Copie de Gains et pertes (réalisés)_C doit être disponible dans le groupe Équipe de travail (Nicolas Copernic) / fermer Croesus");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        if (!Report_Found(levelNicCopernic, newReportName))
            Log.Error("---Le rapport ne se trouve pas dans la liste");

        Terminate_CroesusProcess();
        
        
        //3. Se loguer avec l'user WASHIG (qui appartient à une autre équipe) / Clients / rapports / aucune copie ne doit être disponible, seulement le rapport "original", c-à-d. Gains et pertes (réalisés) / fermer Croesus
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Se loguer avec l'user WASHIG (qui appartient à une autre équipe) / Clients / rapports / aucune copie ne doit être disponible, seulement le rapport 'original', c-à-d. Gains et pertes (réalisés) / fermer Croesus");
        Login(vServerReportsCR1485, userNameWASHIG, passwordWASHIG, language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        if (Report_Found(Report_Found(levelNicCopernic, newReportName)))
            Log.Erreur("!! Le rapport ne devrait pas se retrouver dans la liste!!! ");
        
        Terminate_CroesusProcess();
        
        
        //4. Revenir avec l'user COPERN et modifier le niveau d'accès du rapport de Équipe de travail vers Firme
        var levelFirm = GetData(filePath_ReportsCR1485, "Anomalies", 73, language);
        var levelWorkTeam = GetData(filePath_ReportsCR1485, "Anomalies", 73, language);
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Revenir avec l'user COPERN et modifier le niveau d'accès du rapport de Équipe de travail vers Firme");
        Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language);
        Modify_Access_Level_Of_Report(newReportName, levelWorkTeam, levelFirm);
        
        Terminate_CroesusProcess();
        
        
        //5. Se loguer avec l'user DARWIC (qui appartient au même équipe de COPERN) / Clients / rapports /
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se loguer avec l'user DARWIC (qui appartient au même équipe de COPERN) / Clients / rapports /");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Le groupe Équipe de travail (Nicolas Copernic) ne devrait plus s'afficher
        //La Copie de Gains et pertes (réalisés)_C s'affiche au niveau global
        Log.Message("Le groupe Équipe de travail (Nicolas Copernic) ne devrait plus s'afficher + La Copie de Gains et pertes (réalisés)_C s'affiche au niveau global")
        if (!Report_Found_GlobalLevel([newReportName]))
            Log.Error("!!! Rapport pas trouvé au niveau global !!!");
        
        Terminate_CroesusProcess();

            
        //6. Se loguer avec l'user WASHIG (qui appartient à une autre équipe) / Clients / rapports /
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Se loguer avec l'user WASHIG (qui appartient à une autre équipe) / Clients / rapports /");
        Login(vServerReportsCR1485, userNameWASHIG, passwordWASHIG, language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //La Copie de Gains et pertes (réalisés)_C s'affiche au niveau global
        //Le rapport "original", c-à-d. Gains et pertes (réalisés) est remplacé par la copie
        Log.Message("La Copie de Gains et pertes (réalisés)_C s'affiche au niveau global.  Le rapport 'original', c-à-d. Gains et pertes (réalisés) est remplacé par la copie ")
        if (!Report_Found_GlobalLevel([newReportName]))
            Log.Error("!!! Rapport pas trouvé au niveau global !!!");
        
        Get_WinReports_BtnClose().Click();
            
        Delay(5000);
        Log.PopLogFolder();
        logDeleteReport = Log.AppendFolder("Remettre à l'état initial");
        Delete_Report(levelFirm, newReportName);

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logCloseApp = Log.AppendFolder("----- Désactivation des PREFS et Fermeture de Croesus -----");
        Terminate_CroesusProcess();
        Deactivate_PREFS();        
    }
}


 function Activate_PREFS()
 {
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPT_CONFIG_SAC", "YES", vServerReportsCR1485);
    
    RestartServices(vServerReportsCR1485);

 }
 
 
 function Deactivate_PREFS()
 {
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPT_CONFIG_SAC", "NO", vServerReportsCR1485);
    
    RestartServices(vServerReportsCR1485);

 }



 function Create_Report_Copy(itemLevel, reportName, newReportName)
 {
    Get_MenuBar_Tools().Click();
        
    SetAutoTimeOut();
    while (! Get_SubMenus().Exists)
        Get_MenuBar_Tools().Click();
    RestoreAutoTimeOut();
        
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");  
    
    Log.Message("Rapports / Double clique sur Configuration des rapports");
    Log.Message("Cliquer sur le label rapport");
    Get_WinConfigurations_TvwTreeview_LlbReports().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock", GetData(filePath_ReportsCR1485, "Anomalies", 74, language)]);
    Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
    WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
    
    //Au niveau Global / Sélectionner le rapports à copier / Cliquer sur copier vers
    Log.Message("Choisir le niveau " + itemLevel);
    Delay(5000);
    Get_WinReportConfiguration_BtnGroup().Click();
    Get_SubMenus().FindChild("WPFControlText", itemLevel, 10).Click();
    
    SelectReportToCopy(reportName);
    Get_WinReportConfiguration_BtnCopyTo().Click();
    
    Get_WinCopyReport().WaitProperty("VisibleOnScreen", true, 30000);
    Get_WinCopyReport_RdoWorkgroup().set_IsChecked(true);
    Get_WinCopyReport_BtnOK().Click();
     
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_ReportsCR1485, "Anomalies", 75, language)], 5000)
    WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
     
    //Faire les modifications désirés (ex: Changer le nom du rapport, Le thème, etc.) / Cliquer sur OK
    //Sélectionner le niveau où sera créée la copie (ex: Firme, Succursale, etc.) / Cliquer sur OK
    Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys(newReportName);
 
    Get_WinReportConfigurationCopy_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
    
    Get_WinReportConfiguration_BtnClose().Click();
 
    Log.Message("Fermer la fenêtre Configuration");
    Get_WinConfigurations().Close();
 
 }
 
 
 
function SelectReportToCopy(reportName){
  
    grid = Get_WinReportConfiguration().WPFObject("UniGroupBox", ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "SelectAReport", language+client), 2).WPFObject("UniList", "", 1);
    count = grid.Items.Count;
    var report=grid.FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", reportName], 10);
    
    grid.WPFObject("ListBoxItem", "", 1).Click();
    
    for (i=1;i<count;i++) {
        if (grid.WPFObject("ListBoxItem", "", i).DataContext.Text==reportName){
            grid.WPFObject("ListBoxItem", "", i).Click();
            break;                     
        } else{
            grid.WPFObject("ListBoxItem", "", i).Click();
        }
    }         
}



function Report_Found(itemLevel, reportName){
                
    var count=Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).WPFObject("TreeView", "", 1).Items.Count
    var foundI=false;
    var foundJ=false;
    
    for (i=0; i<count; i++) {
        Log.Message(Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).DataContext.Header);
            
        if (Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).DataContext.Header == itemLevel){
            foundI = true;
            var nodesCount = Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Count
          
            for (j=0; j<nodesCount;j++){    
                if(Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Item(j).Header==reportName){
                    foundJ = true;
                    Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).WPFObject("CFTreeViewItem", "", j+1).Click();
                    Log.Checkpoint("le  rapport "+ reportName+"  a été cliqué  " );
                    Get_Reports_GrpReports_BtnAddAReport().Click();
                    Delay(1000);
                    break;
                } 
                else {
                    Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).WPFObject("CFTreeViewItem", "", j+1).Click();
                }                             
            }          
            break;
        }
    }
          
    if(foundI == false){
        Log.Message("****Le niveau d'accès " + itemLevel+ "  n'exite pas")
        return false;
    } else if (foundJ == false){
        Log.Message("****Le rapport " + reportName +  " n'existe pas dans la section " + itemLevel);
        return false;
    } else {
      return true;
    }
}


function Modify_Access_Level_Of_Report(reportName, accessLevel, newAccessLevel)
{
    Get_MenuBar_Tools().Click();
        
    SetAutoTimeOut();
    while (! Get_SubMenus().Exists)
        Get_MenuBar_Tools().Click();
    RestoreAutoTimeOut();
        
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");  
    
    Log.Message("Rapports / Double clique sur Configuration des rapports");
    Log.Message("Cliquer sur le label rapport");
    Get_WinConfigurations_TvwTreeview_LlbReports().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock", GetData(filePath_ReportsCR1485, "Anomalies", 75, language)]);
    Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
    WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
    
    
    //Au niveau Global / Sélectionner le rapports à copier / Cliquer sur copier vers
    Log.Message("Choisir le niveau " + accessLevel);
    Delay(5000);
    
    Get_WinReportConfiguration_BtnGroup().Click();
    Get_SubMenus().FindChild("WPFControlText", "Équipe de travail", 10).Click(); //---variable
    
    if (Trim(VarToStr("Nicolas Copernic"))!== ""){
        Get_CroesusApp().FindChild(["ClrClassName","WPFControlText"],["MenuItem","Nicolas Copernic"],10).Click();
    }
    
    SelectReportToCopy(reportName);
    Get_WinReportConfiguration_BtnEdit().Click();
    
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ReportConfigurationWindow", true], 40000);
    
    Get_WinReportConfigurationCopy_TabProperties_CmbOwner().Click();
    Get_SubMenus().FindChild("WPFControlText", "Firme", 10).Click();  //variable
    Get_WinReportConfigurationCopy_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
    
    Get_WinReportConfiguration_BtnClose().Click();
    
    Log.Message("Fermer la fenêtre Configuration");
    Get_WinConfigurations().Close();
}


function Report_Found_GlobalLevel(arrayOfReportsNames)
{
    Log.Message("Looking for the following report(s): " + arrayOfReportsNames );
    
    Delay(3000);
    Get_Reports_GrpReports_TabReports().Click();
    Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
    
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    var nbOfSelectedReports = 0;
    for (var j = 0; j < arrayOfReportsNames.length; j++){
        //Les rapports Agenda, Modèles et Titres se présentent de la même façon que le projet soit Performance ou General
        var arrayOfAlwaysDefaultDisplayReports = (language == "french")? ["Rapport", "Rapports modèles", "Rapports titres"]: ["Report", "Model Reports", "Security Reports"];
        var isReportDisplayPerformanceSpecific = ((projet == "Performance") && GetIndexOfItemInArray(arrayOfAlwaysDefaultDisplayReports, Get_WinReports().Title) == -1);
        var isReportSelected = (isReportDisplayPerformanceSpecific)? Select_Report_Performance(arrayOfReportsNames[j], false): SelectAReport(arrayOfReportsNames[j]);
        if (isReportSelected) nbOfSelectedReports ++;
    }
    
    if (nbOfSelectedReports < arrayOfReportsNames.length){
        Log.Warning("Only " + nbOfSelectedReports + " out of " + arrayOfReportsNames.length + " reports have been selected!");
        Log.Warning("La sélection des rapports a été en date testée seulement pour les projets : 'General' et 'Performance' ; pas pour 'PerformanceNFR' ni 'PerformanceEVOL'.");
    }
    return (nbOfSelectedReports == arrayOfReportsNames.length);  
}


function Delete_Report(itemLevel, reportName)
{
    Get_MenuBar_Tools().Click();
        
    SetAutoTimeOut();
    while (! Get_SubMenus().Exists)
        Get_MenuBar_Tools().Click();
    RestoreAutoTimeOut();
        
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");  
    
    Log.Message("Rapports / Double clique sur Configuration des rapports");
    Log.Message("Cliquer sur le label rapport");
    Get_WinConfigurations_TvwTreeview_LlbReports().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock", GetData(filePath_ReportsCR1485, "Anomalies", 75, language)]);
    Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
    WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
    
    
    Log.Message("Choisir le niveau " + itemLevel);
    Delay(5000);
    Get_WinReportConfiguration_BtnGroup().Click();
    Get_SubMenus().FindChild("WPFControlText", itemLevel, 10).Click();
    
    SelectReportToCopy(reportName);
    Get_WinReportConfiguration_BtnDelete().Click();
    
     if (Get_DlgConfirmation().Exists){
        Get_DlgConfirmation_BtnYes().Click();
    }
    
    Delay(1000);
    WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
    Get_WinReportConfiguration_BtnClose().Click();
    
    Log.Message("Fermer la fenêtre Configuration");
    Get_WinConfigurations().Close();
}