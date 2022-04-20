//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT PDFUtils
//USEUNIT CR1485_Common_functions


        //Chaine du login en mode Debug
        var debugModeString = "?debug=tvsnac&DebugPackage=YES&TaskPreview=True";
        
function PrefActivation(){    

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE",      "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE",            "YES", vServerReportsCR1485);        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFMAN_COVERPAGE",   "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ROGERS_COVER_PAGE",           "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_RPFL_COVERPAGE_ALONE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPFL_COVER_PAGE",             "NO", vServerReportsCR1485);

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INFO_CLIENT",      "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INFO_CLIENT_REPORT",     "FIRMADM,SYSADM", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_TAX_COVERPAGE",      "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_TO_CHOOSE_PRIMARY_ADDRESS",      "YES", vServerReportsCR1485);

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "TAX_REPORT_NON_REGISTERED_ACCOUNTS",      "", vServerReportsCR1485);
                
        RestartServices(vServerReportsCR1485)
}

function PrefNonRegisteredActivation(){

        Activate_Inactivate_PrefFirm("FIRM_1", "ACCOUNT_TYPE_NON_REGISTERED",      "A,C,E", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "SECURITY_TAX_SLIP_NON_REGISTERED", "2611392,315,3158000,3158001,3158002,3158007,3158008,3158015,330,3807000,3807500,3807850,3807680", vServerReportsCR1485);
        
//        RestartServices(vServerReportsCR1485)
}

function DefaultPref(){
    
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE",      null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE",            null, vServerReportsCR1485);        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFMAN_COVERPAGE",   null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ROGERS_COVER_PAGE",           null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_RPFL_COVERPAGE_ALONE", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPFL_COVER_PAGE",             null, vServerReportsCR1485);

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INFO_CLIENT",          null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INFO_CLIENT_REPORT",          null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_TAX_COVERPAGE",        null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_TO_CHOOSE_PRIMARY_ADDRESS", null, vServerReportsCR1485);

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "TAX_REPORT_NON_REGISTERED_ACCOUNTS",      null, vServerReportsCR1485);
                
        RestartServices(vServerReportsCR1485)
}
       
function LogoutFromCroesus(vServer, browserName){
    
        //Internet Explorer is the browser to be used by default
        if (browserName == undefined)
            browserName = "iexplore";
    
        //Close browser and Croesus App
        Terminate_CroesusProcess();
        CloseBrowser("iexplore");
        TerminateProcess("dfsvc");
    
        //Launch the specified browser and opens the specified URL in it.
        Browsers.Refresh();
        Browsers.Item(browserName).Run(vServerReportsCR1485);
        var pageObject = Sys.Browser().Page("*");
        pageObject.Wait();
        Delay(1000);
        pageObject.Refresh();
        var headerPanel = pageObject.FindChildEx(["ObjectType", "ObjectIdentifier", "idStr", "Visible"], ["Panel", "header", "header", true], 20, true, 5000);
        if (headerPanel.Exists){//Disconnect
            var disconnectPanel = headerPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "0", true], 10, true, 1000);
            disconnectPanel.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Button", "0", true], 10).Click();
            var disconnectSubmenu = disconnectPanel.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "myDropdown", true], 10, true, 5000);
            disconnectSubmenu.FindChildEx(["ObjectType", "ObjectIdentifier", "Visible"], ["Link", "0", true], 10, true, 3000).Click();
        }   
}

function ValidateSpecificThemeReport(arrayOfReportsNames){
       
        var labelTheme = (language == "french")? "Thème": "Theme";
        
        //Outils / Configurations / Rapports / Configurations des défauts / OK
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 15000);
        Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
        Get_WinConfigurations_LvwListView_LlbDefaultConfiguration().DblClick();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b", 50000);
        Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration().WaitProperty("VisibleOnScreen", true, 30000);
        
        var llbItemObjectParent = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration().Parent;
        llbItemObjectParent.set_IsExpanded(true);
        var arrayOfTreeviewItems = llbItemObjectParent.FindAllChildren(["ClrClassName", "IsVisible"], ["CFTreeViewItem", true]).toArray();

        for (var i in arrayOfReportsNames){
            Log.Message("Rapport : "+arrayOfReportsNames[i]);
            for (var j in arrayOfTreeviewItems)
                if (arrayOfReportsNames[i] == arrayOfTreeviewItems[j].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1]).Text){
                    arrayOfTreeviewItems[j].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1]).DblClick();
                    Delay(2500);
                    arrayOfTreeviewItems[j].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, labelTheme], 10).Click();
//                    Get_WinDefaultConfiguration_ChkUseDefault().WaitProperty("VisibleOnScreen", true);
                    Delay(2500);
                    Get_WinDefaultConfiguration_ChkUseDefault().set_IsChecked(false);
                }
             }
        Get_WinDefaultConfiguration_BtnOK().Click();
        Get_WinConfigurations().Close();  
} 

        
function AddAddressToClient(clientNumber, addressType, street, city, zipCode, country, mailingAddress){    

        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).DblClick();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().waitProperty("IsChecked", true, 5000);
        
        //Supprimer si une adresse du même type existe
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click()
        if(Get_SubMenus().FindChild("WPFControlText", addressType).Exists){
            Log.Message("L'adresse : " + addressType + " existe");
            Get_SubMenus().FindChild("WPFControlText", addressType).Click();
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
            Get_DlgConfirmation_BtnRemove().Click();
        }        
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b", 20000);
        SelectComboBoxItem(Get_WinAddAddress_CmbType(),addressType);
        Get_WinAddAddress_TxtStreet().Keys(street);
        Get_WinAddAddress_TxtCity().Keys(city);
        Get_WinAddAddress_TxtZipCode().Keys(zipCode);
        Get_WinAddAddress_TxtCountry().Keys(country);
        Get_WinAddAddress_ChkBoxMailingAddress().set_IsChecked(mailingAddress)
        Get_WinAddAddress_BtnOK().Click(); 
        
        if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click()
         
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["Uid", "ClrClassName"], ["BaseDialog_136b","UniDialog"], 25000);
}

function GenerateXmlFile(reportName, destination, reportLanguage, xmlFilePath, savedReport, principalAdress){
         
    
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        if(savedReport)
            SelectFirmSavedReport(reportName, true);
        else
            SelectReports(reportName);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbDestination(), destination);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbLanguage(), reportLanguage);
        
        if(principalAdress != undefined && principalAdress != null)
            Get_WinReports_GrpOptions_ChkUsePrinpalAddress().set_IsChecked(principalAdress)

        Get_WinReports_BtnOK().Click();
        
        //Copier le contenu de la fenêtre avec Ctrl a, Ctrl c 
        SetAutoTimeOut(120000)
        Get_WinReportConfiguration().WPFObject("UniTextArea", "", 1).Click()
        Get_WinReportConfiguration().WPFObject("UniTextArea", "", 1).set_Focusable(true);
        Get_WinReportConfiguration().WPFObject("UniTextArea", "", 1).Keys("^a");
        Get_WinReportConfiguration().WPFObject("UniTextArea", "", 1).Keys("^c");
        
        if (aqFileSystem.Exists(xmlFilePath))
                aqFileSystem.DeleteFile(xmlFilePath);
                      
        //Coller dans notePad avec Ctrl v        
        WshShell.Run("notepad");
        Delay(3000);
        var Notepad = Sys.Process("notepad");
        Sys.Desktop.Keys("^v");

        // Obtains the Windows Notepad main menu
        var MainMenu = Notepad.Window("Notepad", "*").MainMenu;
        //Sauvegarder le fichier XML
        MainMenu.Check("File|Save", true);
        Notepad.Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).SetText(xmlFilePath);
        Notepad.Window("#32770", "Save As", 1).Window("Button", "&Save", 1).Click();
        
        //Fermer NotePad
        MainMenu.Check("File|Exit", true);
        RestoreAutoTimeOut();       
        Get_WinReportConfiguration().Close();
}

function ExecuteReportCommanderCommand(userID, XmlFileTaskPath, vserverRemoteFolder){

        var ReportCommanderFolderPath = "/usr/lib/finansoft/reportcommander";
        var SSHCommand = "cd " + ReportCommanderFolderPath + "\r\n\r\n";
            
        SSHCommand += "./reportcommander.exec --file /etc/finansoft/reportcommander.conf --task '" + XmlFileTaskPath + "' --resultpath '" + vserverRemoteFolder + "' --stationid '" + userID + "' --1by1";
        Log.Message(SSHCommand);
        ExecuteSSHCommand("aminea", vServerReportsCR1485, SSHCommand, null);  
}

function DeleteAddressForClient(clientNumber, addressType){
        
        Get_ModulesBar_BtnClients().Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).DblClick();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().waitProperty("IsChecked", true, 5000);
        
        //Supprimer une adresse du même type 
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click()
        if(Get_SubMenus().FindChild("WPFControlText", addressType).Exists){
            
            Get_SubMenus().FindChild("WPFControlText", addressType).Click();
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
            Get_DlgConfirmation_BtnRemove().Click();
            Log.Message("L'adresse : " + addressType + " est supprimée");
        }
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["BaseWindow", "Confirmation"], 5000);
        Get_WinDetailedInfo_BtnOK().Click();
}

function CheckStringOccurenceInPdfFile(PDFFilePath, startPageNumber, arrayOfString){
     
        var PdfFileContent = GetPdfTextThroughCommandLine(PDFFilePath, startPageNumber);
            Log.Message(PdfFileContent);  
        for(i=0; i<arrayOfString.length; i++ ){ 
            var Res = aqString.Contains(PdfFileContent, arrayOfString[i]); 
            if ( Res != -1 )
              Log.Checkpoint("Substring:  '" + arrayOfString[i] + "'  was found in report text file  at position " + Res)
            else
              Log.Error("There are no occurrences of   '" + arrayOfString[i] + "'  in report text file'")
        }
}