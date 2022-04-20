//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA

NameMapping.TimeOutWarning = false;

var cfchartserverServiceName = "cfchartserver";
var chartServerLogFilePath = "/var/log/finansoft/ChartServer.log";
var chartServerConfigFilePath = "/etc/finansoft/ChartServer.exe.config";



function CheckIfCfchartserverServiceIsRunning(vServerURL, savedLogFilePath)
{
    //Check only for RJ
    if (client != "RJ")
        return;
    
    //If service is not running, copy Log file and start it
    Log.Message("Check if " + cfchartserverServiceName + " service is running...");
    if (IsServiceRunning(vServerURL, cfchartserverServiceName))
        Log.Checkpoint(cfchartserverServiceName + " service is running.");
    else {
        Log.Error(cfchartserverServiceName + " service is not running.");
        Log.Message(cfchartserverServiceName + " service is not running: copy Log file from VServer and start the service...");
        CopyFileFromVserver(vServerURL, chartServerLogFilePath, savedLogFilePath);
        if (StartService(vServerURL, cfchartserverServiceName))
            Log.Checkpoint(cfchartserverServiceName + " service is started.");
        else
            Log.Error(cfchartserverServiceName + " service is not started.");
    }
}



function SetDebugModeForChartServer(vServerURL)
{
    Log.Message("Set DEBUG Mode for ChartServer...");
    
    //Create SSH commands file
    var SSHCmdlines = "";
    var levelValues = ["ALL", "INFO", "WARN", "ERROR", "FATAL", "OFF"];
    for (var i = 0; i < levelValues.length; i++)
        SSHCmdlines += "\r\n" + "sed -i -e 's/<level value=\"" + levelValues[i] + "\"\\/>/<level value=\"DEBUG\"\\/>/g' " + chartServerConfigFilePath;
    
    ExecuteSSHCommand(null, vServerURL, SSHCmdlines);
}



function CopyCroesusWebFolder()
{
    var CroesusWebDestinationFolder = "C:\\";
    var CroesusWebSourceFolder = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CroesusWeb";
    var CroesusWebTargetFolder = CroesusWebDestinationFolder + aqFileSystem.GetFolderInfo(CroesusWebSourceFolder).Name;
    
    if (aqFileSystem.Exists(CroesusWebTargetFolder) && !aqFileSystem.DeleteFolder(CroesusWebTargetFolder, true))
        Log.Error("Folder not successfully deleted : " + CroesusWebTargetFolder);
    
    if (!aqFileSystem.CopyFolder(CroesusWebSourceFolder, CroesusWebDestinationFolder, false))
        Log.Error("Folder not successfully copied from '" + CroesusWebSourceFolder + "' to '" + CroesusWebTargetFolder + "'");
}



function CheckIndices(indicesToBeChecked, separatorChar)
{
    if (separatorChar == undefined)
        separatorChar = "|";
    
    var allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    if (GetIndexOfItemInArray(["TOUTES", "TOUS", "ALL"], aqString.ToUpper(Trim(indicesToBeChecked))) != -1){
         for (var i in allIndicesCheckboxes)
            allIndicesCheckboxes[i].set_IsChecked(true);
    }
    else {
        for (var i in allIndicesCheckboxes)
            allIndicesCheckboxes[i].set_IsChecked(false);
        
        if (GetIndexOfItemInArray(["", "AUCUNE", "AUCUN", "NONE"], aqString.ToUpper(Trim(indicesToBeChecked))) == -1){
            var arrayOfIndicesToBeChecked = indicesToBeChecked.split(separatorChar);
            for (var i in arrayOfIndicesToBeChecked)
                Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);
        }
    }
}



function GetIndicesToBeCheckedFromIndicesNotToBeChecked(indicesNotToBeChecked, separatorChar)
{
    if (separatorChar == undefined)
        separatorChar = "|";
    
    Log.Message("Get Indices to be checked from these indices not to be checked : " + indicesNotToBeChecked);
    var indicesToBeChecked = null;
    
    if (GetIndexOfItemInArray(["TOUTES", "TOUS", "ALL"], aqString.ToUpper(Trim(indicesNotToBeChecked))) != -1)
        indicesToBeChecked = "";
    else if (GetIndexOfItemInArray(["", "AUCUNE", "AUCUN", "NONE"], aqString.ToUpper(Trim(indicesNotToBeChecked))) != -1){
        if (language == "french")
            indicesToBeChecked = "TOUS";
        else
            indicesToBeChecked = "ALL";
    }
    else {
        if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
            Log.Error("The Parameters button is disabled!");
            return;
        }
        
        Delay(3000);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 60000);
        WaitReportParametersWindow(60000);
    
        var arrayOfIndicesNotToBeChecked = indicesNotToBeChecked.split(separatorChar);
        var allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
        var arrayOfIndices = [];
        for (var i in allIndicesCheckboxes) arrayOfIndices.push(allIndicesCheckboxes[i].WPFControlText);
        for (var i = arrayOfIndices.length - 1; i >= 0; i--)
            if (GetIndexOfItemInArray(arrayOfIndicesNotToBeChecked, arrayOfIndices[i]) != -1)
                arrayOfIndices.splice(i, 1);
        
        indicesToBeChecked = arrayOfIndices.join(separatorChar);
        Get_WinParameters_BtnCancel().Click();
    }
    
    Log.Message("Indices to be checked are : " + indicesToBeChecked);
    return indicesToBeChecked;
}



function SetIntegrationForSecurity(securityDescription, integrationPartner, identifierType, identifierValue)
{
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Search_SecurityByDescription(securityDescription);
    Get_SecurityGrid().FindChild("Value", securityDescription, 10).Click();
    Get_SecuritiesBar_BtnInfo().Click();
    Get_WinInfoSecurity_TabIntegrations().Click();
    Get_WinInfoSecurity_TabIntegrations().WaitProperty("IsSelected", true, 60000);
    
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), integrationPartner);
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType(), identifierType);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().SetText(identifierValue);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().Keys("[Tab]");
    
    Get_WinInfoSecurity_BtnOK().Click();
}



function EnablePerformanceFeesGroupBoxForUser(prefUserName)
{
    Activate_Inactivate_Pref(prefUserName, "PREF_NET_GROSS_REPORT", "1", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_TIME_MONEY_WEIGHTED", "1", vServerReportsCR1485);
}



function RestoreToDefaultPerformanceFeesGroupBoxForUser(prefUserName)
{
    Activate_Inactivate_Pref(prefUserName, "PREF_NET_GROSS_REPORT", null, vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_TIME_MONEY_WEIGHTED", null, vServerReportsCR1485);
}



function Activate_Inactivate_CheckDigit(prefUserName, prefValue, accountNumber, checkDigitValue)
{
    Activate_Inactivate_Pref(prefUserName, "PREF_DISPLAY_CHECK_DIGIT", prefValue, vServerReportsCR1485);
    
    var checkDigitSQLValue = (checkDigitValue == undefined)? "null": "'" + checkDigitValue + "'";
    Execute_SQLQuery("update B_COMPTE set CHECK_DIGIT = " + checkDigitSQLValue + " where NO_COMPTE = '" + accountNumber + "'", vServerReportsCR1485)
}



function GetBooleanValue(ArrayOrStringValue)
{
    if (GetVarType(ArrayOrStringValue) == varArray || GetVarType(ArrayOrStringValue) == varDispatch){
        var arrayOfBooleanValues = new Array();
        for (var i in ArrayOrStringValue)
            arrayOfBooleanValues.push(GetBooleanValue(ArrayOrStringValue[i]));
        return arrayOfBooleanValues;
    }
    
    ArrayOrStringValue = aqString.ToUpper(Trim(VarToStr(ArrayOrStringValue)));
    
    if (GetIndexOfItemInArray(["VRAI", "OUI", "TRUE", "YES"], ArrayOrStringValue) != -1)
        return true;
    
    if (GetIndexOfItemInArray(["FAUX", "NON", "FALSE", "NO"], ArrayOrStringValue) != -1)
        return false;
    
    return null;
}



function CloseCroesus()
{
    Close_Croesus_MenuBar();
    var previousAutoTimeout = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    SetAutoTimeOut(previousAutoTimeout);
}


function SetIndexComposition(indexContentControlObject, indexDescription, indexPercentValue)
{
    var txtSecurityDescription = indexContentControlObject.FindChild("Uid", Get_WinInfoSecurity_TabIndexComposition_TxtIndex1Value().Uid.OleValue, 10);
    txtSecurityDescription.Clear();
    txtSecurityDescription.Keys(indexDescription + "[Tab]");
    SetAutoTimeOut(5000);
    if (Get_SubMenus().Exists) Get_SubMenus().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "Description", indexDescription], 10).DblClick();
    RestoreAutoTimeOut();
    if (indexContentControlObject.DataContext.Security != null && CompareProperty(indexContentControlObject.DataContext.Security.Description.OleValue, cmpEqual, indexDescription, true, lmError)){
        Sys.Keys(indexPercentValue + "[Tab]");
        CompareProperty(indexContentControlObject.DataContext.get_PercentValue(), cmpEqual, indexPercentValue, true, lmError);
    }
}





function SetBrokerAndMiddlemanAccountsNumbersForAccount(accountNumber, brokerAccountNumber, middlemenAccountNumber)
{
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    Search_Account(accountNumber);
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
    
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProfile().Click();
    Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 60000);
    
    
    //Cette partie est une adaptation qui fait suite à une différence de comportement de la sauvegarde des profils
    //constatée depuis la version Co depuis : ref90-07-22--V9-Be_1-co6x
    
    //Ouvrir la fenêtre de configuration des profils, Cocher les cases à cocher du groupe Défaut et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    if (client != "RJ" && client != "US" && client != "TD"){
        //Scroll
        var height = Get_WinVisibleProfilesConfiguration().Height;
        var width = Get_WinVisibleProfilesConfiguration().Width;
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
    }
    
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration_DefaultExpander(), true);
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();

    //Fin version Co depuis : ref90-07-22--V9-Be_1-co6x
    
    
    Get_WinAccountInfo_TabProfile_DefaultExpander().set_IsExpanded(true);
    
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtBrokerAccountNumber().Click();
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtBrokerAccountNumber().SetText(brokerAccountNumber);
    
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtMiddlemanAccountNumber().Click();
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtMiddlemanAccountNumber().SetText(middlemenAccountNumber);
    
    var windowTitle = VarToStr(Get_WinAccountInfo().Title);
    Get_WinAccountInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", windowTitle], 30000);
} 



function DisplayOnlyDefaultProfilesForAccounts()
{
    
    //Afficher seulement les éléments du groupe Défaut des profils
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProfile().Click();
    Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 60000);
    
    //Ouvrir la fenêtre de configuration des profils, Décocher toutes les cases à cocher et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    windowHeight = Get_WinVisibleProfilesConfiguration().get_Height();
    windowTop = Get_WinVisibleProfilesConfiguration().get_Top();
    //Get_WinVisibleProfilesConfiguration().set_Height(1050);
    Get_WinVisibleProfilesConfiguration().set_Height(Sys.Desktop.Height);
    Get_WinVisibleProfilesConfiguration().set_Top(0);
    
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration(), false);
    
    Get_WinVisibleProfilesConfiguration().set_Height(windowHeight);
    Get_WinVisibleProfilesConfiguration().set_Top(windowTop);
    
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    //Ouvrir la fenêtre de configuration des profils, Cocher toutes les cases à cocher du groupe Défaut et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    if (client != "RJ" && client != "US" && client != "TD"){
        //Scroll
        var height = Get_WinVisibleProfilesConfiguration().Height;
        var width = Get_WinVisibleProfilesConfiguration().Width;
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
    }
    
    //Cocher les cases à cocher du groupe Défaut
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration_DefaultExpander(), true);
    
    //Cliquer sur Sauvegarder
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    //Cliquer sur OK
    Get_WinAccountInfo_BtnOK().Click();
}



function Set_IsCheckedForAllChecboxes(parentComponentObject, booleanValue)
{
    parentComponentObject.WaitProperty("VisibleOnScreen", true, 30000);
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["XamCheckEditor", true, 1], 100).toArray();
    parentComponentObject.Click();
    Sys.Keys("[End][End]");
    
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (booleanValue != arrayOfCheckboxes[i].get_IsChecked())
            arrayOfCheckboxes[i].Click();
        Sys.Keys("[Up][Up]");
    }
}



/**
    !!!!À déplacer vers Common_functions!!!!
    
    Description : Attribue des indices par défaut à un ou plusieurs clients
    Paramètres :
         arrayOfClientsNumbers : Tableau contenant les numéros de clients cibles
         arrayOfIndicesDescriptions : Tableau contenant les descriptions d'indices
         targetReturnPercentValue : Valeur de pourcentage de la Performance visée (paramètre facultatif) 
*/
function SelectDefaultIndicesForClients(arrayOfClientsNumbers, arrayOfIndicesDescriptions, targetReturnPercentValue)
{
    if (GetVarType(arrayOfIndicesDescriptions) != varArray && GetVarType(arrayOfIndicesDescriptions) != varDispatch)
        arrayOfIndicesDescriptions = new Array(arrayOfIndicesDescriptions);
    
    SelectClients(arrayOfClientsNumbers)
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().Click();
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().WaitProperty("IsSelected", true, 60000);
    
    if (Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled){
        Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().Keys("^a");
        Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().Click();
    }
    
    var availableIndicesCount = Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (var i = 0; i < availableIndicesCount; i++){
        var currentAvailableIndice = Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description.OleValue;
        Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected((GetIndexOfItemInArray(arrayOfIndicesDescriptions, currentAvailableIndice) != -1));
    }
    
    if (Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().SelectedItems.Records.Count > 0)
        Get_WinInfo_TabDefaultIndices_BtnAddIndices().Click();
    
    var nbOfSelectedIndices = Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().WPFObject("RecordListControl", "", 1).Items.get_Count();
    if (nbOfSelectedIndices != arrayOfIndicesDescriptions.length)
        Log.Error(nbOfSelectedIndices + " indices sont sélectionnés au lieu de " + arrayOfIndicesDescriptions.length);
    
    //Au besoin saisir le pourcentage de la Performance visée
    if (targetReturnPercentValue != undefined){
        
        Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Clear();
        Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Keys(VarToStr(targetReturnPercentValue));
        CompareProperty(Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Text.OleValue, cmpEqual, VarToStr(targetReturnPercentValue), true, lmWarning);
        Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Keys("[Tab]");
        
        if (targetReturnPercentValue == ""){
            if (!isNaN(Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Value))
                Log.Error("Une valeur a été enregistrée pour la Performance visée, ceci est inattendu.");
        }
        else {
            if (isNaN(Get_WinInfo_TabDefaultIndices_TxtTargetReturn().Value))
                Log.Error("La valeur de Performance visée '" + targetReturnPercentValue + "' n'a pas été acceptée.");
        }
        
    }
    
    var windowTitle = Get_WinDetailedInfo().Title;
    Get_WinDetailedInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", windowTitle]);
}



function DeleteAllRelationshipAddresses()
{
    Delay(1000);
    while (Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().IsEnabled){
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        Delay(1000);
    }
}



/**
    Description : Importer plusieurs thèmes dans la fenêtre "Configuration des défauts"
    Paramètre : arrayOfThemesFilesPaths (tableau devant avoir la structure suivante :
        - Chaque clé du tableau correspond au nom du thème (le même nom en Anglais et en Français)
        - La valeur de chaque élément du tableau est le chemin d'accès du fichier du thème référé par la clé)
        
    Préalable : La fenêtre "Configuration des défauts" doit être ouverte
*/
function ImportThemesInDefaultConfigurationWindow(arrayOfThemesFilesPaths)
{
    var arrayOfLanguageComboboxItems = (client == "US")? ["English (U.S.)"] : ["English (Canada)", "Français (Canada)"];
    
    for (var themeName in arrayOfThemesFilesPaths){
        Get_WinDefaultConfiguration_BtnImport().WaitProperty("IsEnabled", true, 5000);
        Get_WinDefaultConfiguration_BtnImport().Click();
        
        Get_WinAddOrEditAReportTheme_TxtFile().Clear();
        Get_WinAddOrEditAReportTheme_TxtFile().Keys(arrayOfThemesFilesPaths[themeName]);
        
        for (key in arrayOfLanguageComboboxItems){
            SelectComboBoxItem(Get_WinAddOrEditAReportTheme_CmbLanguage(), arrayOfLanguageComboboxItems[key]);
            Get_WinAddOrEditAReportTheme_TxtThemeName().Clear();
            Get_WinAddOrEditAReportTheme_TxtThemeName().Keys(themeName);
        }
        
        Get_WinAddOrEditAReportTheme_BtnOK().Click();
                
        if (!Get_WinDefaultConfiguration_CmbTheme().WaitProperty("Text", themeName, 30000))
            CompareProperty(Get_WinDefaultConfiguration_CmbTheme().Text, cmpEqual, themeName, true, lmError);
        
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 5000);
    }
}


/**
    Description : Assigner à chaque rapport d'une liste, un thème spécifique
    Paramètre : arrayOfReportsThemes (tableau devant avoir la structure suivante :
        - Chaque clé du tableau correspond au nom du rapport (le nom du rapport est généralement différent selon la langue : Anglais, Français)
        - La valeur de chaque élément du tableau est le nom du thème à assigner au rapport identifié par la clé)
    Préalable : La fenêtre "Configuration des défauts" doit être ouverte
*/
function AssignSpecificConfigurationThemeToEachReport(arrayOfReportsThemes)
{
    for (var reportName in arrayOfReportsThemes){
        var objSpecificConfigurationReportTheme = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem_LlbTheme(reportName);
        objSpecificConfigurationReportTheme.HoverMouse();
        objSpecificConfigurationReportTheme.Click();
        Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(reportName).HoverMouse();;
        
        Get_WinDefaultConfiguration_CmbTheme().WaitProperty("IsEnabled", false, 5000);
        Get_WinDefaultConfiguration_CmbTheme().WaitProperty("IsEnabled", true, 5000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        
        if (false != Get_WinDefaultConfiguration_ChkUseDefault().IsChecked.OleValue)
            Get_WinDefaultConfiguration_ChkUseDefault().Click();
            
        SelectComboBoxItem(Get_WinDefaultConfiguration_CmbTheme(), arrayOfReportsThemes[reportName]);
            
        if (false != Get_WinDefaultConfiguration_ChkUseDefault().IsChecked.OleValue)
            CompareProperty(Get_WinDefaultConfiguration_ChkUseDefault().IsChecked.OleValue, cmpEqual, false, true, lmError);
        
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 5000);
    }
}


/**
    Description : Vérifie si un rapport de la liste des rapports courants
                ne peut être déplacé au sommet de la liste et reste bloqué en bas.
    Paramètre : currentReportName (string - nom du rapport à déplacer)
    Résultat : true si succès, false autrement
    Auteur : Christophe Paring
*/
function CheckIfCurrentReportIsStuckedAtBottom(currentReportName)
{
    Log.Message("Check if Current Report '" + currentReportName + "' cannot be moved to the top, and is stucked at bottom.");
    var isCurrentReportNameAtTop = null;
    var isCurrentReportNameAtBottom = null;
    
    //Perform actions to move report to the top
    Log.LockEvents(5);
    if (true !== SelectAReportInCurrentReportsPanel(currentReportName))
        Log.Error("There was issue while selecting Current Report '" + currentReportName + "'.");
    else {
        var nbClicksLeft = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]).WPFControlOrdinalNo;
        while (nbClicksLeft > 1){
            Get_Reports_GrpReports_BtnMoveTheReportUp().Click();
            Delay(3000);
            nbClicksLeft--;
        }
        
        //Check if report is at top
        Get_Reports_GrpReports_LvwCurrentReports().Keys("[Home]");
        Delay(3000);
        isCurrentReportNameAtTop = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "IsSelected", "WPFControlOrdinalNo"], ["ListBoxItem", currentReportName, true, 1]).Exists;
    
        //Check if report is at bottom
        Get_Reports_GrpReports_LvwCurrentReports().Keys("[End][End]");
        Delay(3000);
        var reportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.get_Count();
        isCurrentReportNameAtBottom = Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "IsSelected", "WPFControlOrdinalNo"], ["ListBoxItem", currentReportName, true, reportsCount]).Exists;
    
        //Result
        if (isCurrentReportNameAtBottom === true){
            if (reportsCount > 1)
                Log.Checkpoint("Current Report '" + currentReportName + "' is stucked at bottom.");
            else
                Log.Checkpoint("Current Report '" + currentReportName + "' is at bottom.");
        }
        else if (isCurrentReportNameAtTop === true)
            Log.Error("Current Report '" + currentReportName + "' moved to top.");
        else
            Log.Error("Current Report '" + currentReportName + "' was not at bottom upon actions to move it to top.");
    }
    
    Log.UnlockEvents();
    return isCurrentReportNameAtBottom;
}





function Test_CopySubfoldersFilesToAUniqueFolder()
{
    var parentFolder = "P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\TESTCHRIS\\BNC";
    var destFolder = "P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\TESTCHRIS\\BNC_UNIQUE";
    DeleteOldFolders(parentFolder);
    CopySubfoldersFilesToAUniqueFolder(parentFolder, destFolder);
}

function DeleteOldFolders(parentFolder)
{
    //var parentFolder = "P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\TESTCHRIS\\BNC";
    
    var foundFolders, aFolder;
    foundFolders = aqFileSystem.FindFolders(parentFolder, "*Old*", true);
    if (!strictEqual(foundFolders, null))
    while (foundFolders.HasNext()){
        aFolder = foundFolders.Next();
        var folderPath = aFolder.Path;
        if (!aqFileSystem.DeleteFolder(folderPath, true))
            Log.Error("Error while deleting the folder : " + folderPath);
    }
}



function CopySubfoldersFilesToAUniqueFolder(parentFolder, destFolder)
{
    var foundFiles = aqFileSystem.FindFiles(parentFolder, "*", true);
    
    if (!strictEqual(foundFiles, null))
        while (foundFiles.HasNext()){
            var aFile = foundFiles.Next();
            var filePath = aFile.Path;
            var fileName = aFile.Name;
            
            if (!aqFileSystem.CopyFile(filePath, destFolder + "\\" + RenameReportFile(fileName), false))
                Log.Error(filePath + " : not successfully copied in : " + destFolder);
        }
}



function RenameReportFile(reportFileName)
{
    var reportNumberChars = 0;
    while (reportNumberChars < 3){
        var firstUnderscorePos = aqString.Find(reportFileName, "_", 0, true);
        
        if (firstUnderscorePos == -1)
            return reportFileName;
        
        var secondUnderscorePos = aqString.Find(reportFileName, "_", firstUnderscorePos + 1, true);
        
        if (secondUnderscorePos == -1)
            return reportFileName;
        
        var reportNumber = aqString.SubString(reportFileName, firstUnderscorePos + 1, secondUnderscorePos - firstUnderscorePos - 1);
        reportNumberChars = aqString.GetLength(reportNumber);
    
        if (reportNumberChars < 3)
            reportFileName = aqString.Insert(reportFileName, "0", firstUnderscorePos + 1);
    }
    
    return reportFileName;
}