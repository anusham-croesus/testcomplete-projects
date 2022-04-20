//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : En tant que TCVE, je veux automatiser le jira RPT-5002 pour l'inclure dans nos tests de régression du modules rapports
                  
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
    version: 90.25-69
    Date: 2021-06-16
*/


function TCVE_5342_RPT_5002_Default_Reports_Not_Generated()
{
    try {
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var clientNumber = GetData(filePath_ReportsCR1485, "Anomalies", 26);
        var reportNames = GetData(filePath_ReportsCR1485, "Anomalies", 27);
        var arrayOfReportNames = reportNames.split("|");
        var waitTimeLong = GetData(filePath_ReportsCR1485, "Anomalies", 28);
        var defaultReport = GetData(filePath_ReportsCR1485, "Anomalies", 29);
        
        
        Log.Link("https://jira.croesus.com/browse/TCVE-5342", "Lien de la story");
        Log.Link("https://jira.croesus.com/browse/RPT-957", "Lien du cas de test");
        
        
        //Activation des PREFS
        Log.Message("----- Activation des PREFS -----")
        ActivationPREFS();
       
        //Login 
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Get_ModulesBar_BtnClients().Click();
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("1. Sélection du client " + clientNumber);
        SelectClients(clientNumber);   //Sélectionner le client 800035
        
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("2. Info / Rapports par défaut");
        Get_ClientsBar_BtnInfo().Click(60, 11);  //Cliquer sur le bouton info (le petit triangle)
        Get_ClientsBar_BtnInfo_ItemDefaultReports().Click();
        Delay(100);
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("3. Cliquer sur ([<=) pour s'assurer qu'aucun rapport n'est dans la liste de rapports par défaut.");
        if (Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAllReports()
            
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("4. Déplacer vers la droite (=>) les rapports: Page Couverture, Gains et pertes (réalisés), Évaluation du portefeuille (valeur accumulée).");
        SelectReports(arrayOfReportNames);
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("5. Cliquer sur OK pour sauvegarder la sélection des rapports.");
        Get_WinDetailedInfo_BtnOK().Click();
        
        Delay(1000);
        
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("6. Sélectionner le client 800035 / Rapports / Rapports sauvegardés.");
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientNumber);   //1. Sélectionner le client 800035
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("7. Sélectionner Rapports par défaut et le déplacer vers la droite (=>).");
        SelectMySavedReport2(defaultReport);  //Sélection de Rapports par défaut
        
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("8. Cliquer sur OK et les produire avec les paramètres par défaut.");
        Get_WinReports_BtnOK().Click();  //Cliquer sur OK

        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("9. Vérifier que la barre d'avancement arrive au 100% et les rapports sont produits sans aucun freeze ou crash.");
        WaitObject(Get_MainWindow_StatusBar(), ["ClrClassName", "Text","VisibleOnScreen"], ["ClassicStatusBarContent", "100 %", true], waitTimeLong);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("----- Fermeture de Croesus -----")
        Terminate_CroesusProcess();
    }
}


function ActivationPREFS()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE", "YES", vServerReportsCR1485);
        
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFMAN_COVERPAGE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ROGERS_COVER_PAGE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_RPFL_COVERPAGE_ALONE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPFL_COVER_PAGE", "NO", vServerReportsCR1485);
}


function SelectReports(arrayOfReportsNames, isSavedReportSelected)
{
    if (isSavedReportSelected == undefined)
        isSavedReportSelected = false;
    
    if (arrayOfReportsNames != undefined && GetVarType(arrayOfReportsNames) != varArray && GetVarType(arrayOfReportsNames) != varDispatch)
        arrayOfReportsNames = new Array(arrayOfReportsNames);
        
    Log.Message("Select the following report(s) : " + arrayOfReportsNames);
    
    //WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
    Delay(3000);
    Get_Reports_GrpReports_TabReports().Click();
    Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
    
    if (!isSavedReportSelected && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
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


//Sélectionner le rapport dans l'onglet "Rapports sauvegardés"
function SelectMySavedReport2(savedReportName, removePreviouslySelectedReports)
{    
    Log.Message("Select My Saved Report ; saved report name : '" + savedReportName + "'.");
    
    Delay(3000);
    Get_Reports_GrpReports_TabSavedReports().Click();
    Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 60000);
    
    if (removePreviouslySelectedReports && Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();
    
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwMySavedReports().set_IsExpanded(true);
    Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm().set_IsExpanded(true);
    
    var mySavedReportsAllChildren = Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm().FindAllChildren("ClrClassName", "CFTreeViewItem", 1).toArray();
    var isFound = false;
    for (var i = 0; i < mySavedReportsAllChildren.length; i++){
        var reportNameSearch = mySavedReportsAllChildren[i].FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", savedReportName]);
        if (reportNameSearch.Exists){
            mySavedReportsAllChildren[i].set_IsSelected(true);
            isFound = true;
            break;
        }
    }
    
    if (isFound){
        Get_Reports_GrpReports_BtnAddAReport().Click();
        Log.Message("Saved report '" + savedReportName + "' selected.");
    }
    else
        Log.Warning("The saved report '" + savedReportName + "' was not found!");
    
    return isFound;
}