//USEUNIT PDFUtils
//USEUNIT ReportCommander_Commonfunctions

/**
    Jira Xray   : https://jira.croesus.com/browse/TCVE-2020
    Description : 
    Analyste d'assurance qualité : Karima Meh
    Analyste d'automatisation : A.A
**/

function RPT_3420_CR2426_AutomateReportsGenerationWithReportCommander()
{
    var logEtape1, logEtape2, logRetourEtatInitial;
    
    
    try {
            Log.Link("https://jira.croesus.com/browse/TCVE-2020","Lien du Cas de test sur Jira Xray");
        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
            var listOfReportNames = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_ListOfReportNames", language+client);
                    
            var destination    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_Destination", language+client);
            var reportLanguage = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_ReportLanguage", language+client);

            var client800228          = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Client800228", language+client);
            var client800052          = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Client800052", language+client);
            
            var addressType800052 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_AddressType800052", language+client);
            var addressType800228 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_AddressType800228", language+client);
            
            var street800052   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Street800052", language+client);
            var street800228   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Street800228", language+client);
            var street800228_1 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Street800228_1", language+client);
            
            var zipCode800052 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_ZipCode800052", language+client);
            var zipCode800228 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_ZipCode800228", language+client);
            
            var IACodeBD66 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_IACodeBD66", language+client);
            var IACodeBD88 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_IACodeBD88", language+client);
            
            var PPStreet800052   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPStreet800052", language+client);
            var PPStreet800228   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPStreet800228", language+client);
            
            var PPZipCode800052 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPZipCode800052", language+client);
            var PPZipCode800228 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPZipCode800228", language+client);
            
            var PPCity800052   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPCity800052", language+client);
            var PPCity800228   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_PPCity800228", language+client);
            
            var city           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_City", language+client);
            var country        = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_Country", language+client);
            var branchLaval    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_BranchLaval", language+client);
            var nameCurieMarie = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3420_NameCurieMarie", language+client);
        
//            var listOfReportNames = "Page couverture|Page couverture (Déclaration de revenus)|Informations client|Gains et pertes (réalisés)"
//                                        "Cover Page|Cover Page (Tax Reporting)|Client Information|Gains and Losses (Realized)"

            var arrayOfReportsNames = listOfReportNames.split("|");
            
            var xmlFileAddPplAdrss  = "ReportCommander_AddPplAdrss.xml";
            var xmlFileSansPplAdrss = "ReportCommander_SansPplAdrss.xml";
            
            var xmlFolderPath = folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteRapports\\Rapports\\RCommander\\";
            
            var vserverAdPpalFolder           = "/etc/finansoft/AdPpal"; 
            var vserverAvecAdPpalResultFolder = "/etc/finansoft/AdPpal/AvecAdPpal";
            var vserverSansAdPpalResultFolder = "/etc/finansoft/AdPpal/SansAdPpal";
            
            var arryOfClient = [client800052, client800228];
            
            var PDFFilePath800052 = xmlFolderPath + "800052.pdf";
            var PDFFilePath800228 = xmlFolderPath + "800228.pdf";
        
            // Étape 0  
            Log.PopLogFolder();      
            logEtape0 = Log.AppendFolder("Étape 0: Activation de Prefs et Login");
/*    */    
            //Ajouter une adresse au Conseiller BD88   
            SqlFilePath = folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteRapports\\Rapports\\AddAddress_CR2426.sql";
            ExecuteSQLFile(SqlFilePath, vServerReportsCR1485);
            
            //Activer les pref
            PrefActivation();
            PrefNonRegisteredActivation();
            
            //Se deconnecter de Croesus
//            LogoutFromCroesus(vServerReportsCR1485);
        
            //Se connecter en mode Debug
            Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language, null, debugModeString); 
        
            //Aller au module Comptes
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Valider les adresses pour BD66 et DB88");
            Get_ModulesBar_BtnAccounts().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            
            //Ouvrir fenêtre Preferences
            Get_MenuBar_File().Click();
            Get_MenuBar_File_Preferences().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 15000);
            Get_WinPrefe_TadUser().Click();
            SelectComboBoxItem(Get_WinPreferences_CmbBranch(), branchLaval);
            SelectComboBoxItem(Get_WinPreferences_CmbName(), nameCurieMarie);
            Get_WinPreferences_TabIACode().Click();
            
            //Selectionner le code BD66
            SelectComboBoxItem(Get_WinPreferences_CmbIACode(), IACodeBD66);
            
            //Valider que l'adresse pour BD66 est vide
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtFrenchAddress1(),  "Text", cmpEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtFrenchAddress2(),  "Text", cmpEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtEnglishAddress1(), "Text", cmpEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtEnglishAddress2(), "Text", cmpEqual,"");
            
            //Valider que l'adresse pour BD88 n'est pas vide
            SelectComboBoxItem(Get_WinPreferences_CmbIACode(),IACodeBD88);
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtFrenchAddress1(),  "Text", cmpNotEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtFrenchAddress2(),  "Text", cmpNotEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtEnglishAddress1(), "Text", cmpNotEqual,"");
            aqObject.CheckProperty(Get_WinPreferences_TabIACode_TxtEnglishAddress2(), "Text", cmpNotEqual,"");
            
//            Get_WinPrefe_BtnOK().Click();
            Get_WinPreferences().Close();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 30000);
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Ajouter adresse secondaire pour 800052 et relation HMS pour 800228"); 
            //Aller au module Clients
            Get_ModulesBar_BtnClients().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            
            //Ajouter une adresse Résidence secondaire au client 800052
            AddAddressToClient(client800052, addressType800052, street800052, city, zipCode800052, country, true);
            
            //Ajouter une adresse Relations HMS au client 800228
            AddAddressToClient(client800228, addressType800228, street800228, city, zipCode800228, country, true);
             
            //Valider que les adresses sont bien ajoutées dans la BD
            var query800052 = "select * from B_ADDRSS where ADDRESS_ID in (select ADDRESS_ID from B_CLADDR where no_client ='" + client800052 +"') and (LOADER_TYPE = 1 or MAILING_ADDRESS= 'Y')";
            var query800228 = "select * from B_ADDRSS where ADDRESS_ID in (select ADDRESS_ID from B_CLADDR where no_client ='" + client800228 +"') and (LOADER_TYPE = 1 or MAILING_ADDRESS= 'Y')";
            
            var arrayOfTypes = Execute_SQLQuery_GetFieldAllValues(query800052, vServerReportsCR1485, "TYPE");
            Log.Message("Type d'adresse pour 800052: "+arrayOfTypes)
            if (arrayOfTypes.length == 2)
                Log.Checkpoint("Le client "+ client800052 +" a 2 types d'adresse");
            else 
                Log.Error("Le client "+ client800052 +" n'a pas 2 types d'adresse")
            
            var arrayOfTypes = Execute_SQLQuery_GetFieldAllValues(query800228, vServerReportsCR1485, "TYPE");
            Log.Message("Type d'adresse pour 800228: "+arrayOfTypes)
            if (arrayOfTypes.length == 2)
                Log.Checkpoint("Le client "+ client800228 +" a 2 types d'adresse");
            else 
                Log.Error("Le client "+ client800228 +" n'a pas 2 types d'adresse")
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 6: Générer le XML  avec utiliser Adresse principale décochée"); 
            //Sélectionner les clients 800228 et 800052 Générer le XML et exécuter la commande de reportCommander avec utiliser Adresse principale décochée
            SelectClients(arryOfClient);
            GenerateXmlFile(arrayOfReportsNames, destination, reportLanguage, xmlFolderPath + xmlFileSansPplAdrss, false, false);
             
            //Creer le dossier: /etc/finansoft/AdPpal
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 6: Creer les dossiers dans le vserver Copier le fichier XML et exécuter la commande de reportCommander");
            var CreateFoldersSSHCommand = "[ ! -d " + vserverAdPpalFolder + " ] && mkdir -p "+ vserverAdPpalFolder +" || rm -f "+ vserverAdPpalFolder + "/*.*" + "\r\n\r\n";
            CreateFoldersSSHCommand += "[ ! -d " + vserverAvecAdPpalResultFolder + " ] && mkdir -p "+ vserverAvecAdPpalResultFolder +" || rm -f "+ vserverAvecAdPpalResultFolder + "/*.*" + "\r\n\r\n";
            CreateFoldersSSHCommand += "[ ! -d " + vserverSansAdPpalResultFolder + " ] && mkdir -p "+ vserverSansAdPpalResultFolder +" || rm -f "+ vserverSansAdPpalResultFolder + "/*.*";
            ExecuteSSHCommand("aminea", vServerReportsCR1485, CreateFoldersSSHCommand, null);
        
            //Étape 5: Copier le fichier ReportCommander_GP1859.xml dans le vserveur
            CopyFileToVserverThroughWinSCP(vServerReportsCR1485, vserverAdPpalFolder, xmlFolderPath + xmlFileSansPplAdrss);
            ExecuteReportCommanderCommand(userNameKEYNEJ, vserverAdPpalFolder +"/" + xmlFileSansPplAdrss, vserverSansAdPpalResultFolder);
            
            //Vider le dossier ReportCommander
            aqFileSystem.DeleteFile(xmlFolderPath + "*.*"); 
            
            //Copier les fichiers PDF générés en local
            ExecuteWinSCPCommand(vServerReportsCR1485, '"get /etc/finansoft/AdPpal/SansAdPpal/*.pdf ""' + xmlFolderPath + '"""');
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 10: Valider l'adresse affichée dans les PDF (adresse secondaire)");
            //Valider l'adresse qui figure dans chaque page des fichiers PDF
            
            //Valider l'adresse dans 800052.PDF
            var Address800052 = [street800052,   city, country+"  "+ zipCode800052];
            CheckStringOccurenceInPdfFile(PDFFilePath800052, 1, [street800052]);
            CheckStringOccurenceInPdfFile(PDFFilePath800052, 4, [street800052]);
            CheckStringOccurenceInPdfFile(PDFFilePath800052, null, Address800052);
            
            //Valider l'adresse dans 800228.PDF
            var Address800228 = [street800228_1, city, country+"  "+ zipCode800228];
            CheckStringOccurenceInPdfFile(PDFFilePath800228, 1, [street800228_1]);
            CheckStringOccurenceInPdfFile(PDFFilePath800228, 5, [street800228_1]);            
            CheckStringOccurenceInPdfFile(PDFFilePath800228, null, Address800228);
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 11-13: Générer le XML  avec utiliser Adresse principale cochée et rouler la commande RCommander");
            //Sélectionner les clients 800228 et 800052 Générer le XML et exécuter la commande de reportCommander avec utiliser Adresse principale cochée
            SelectClients(arryOfClient);
            GenerateXmlFile(arrayOfReportsNames, destination, reportLanguage, xmlFolderPath + xmlFileAddPplAdrss, false, true); 
            CopyFileToVserverThroughWinSCP(vServerReportsCR1485, vserverAdPpalFolder, xmlFolderPath + xmlFileAddPplAdrss);
            ExecuteReportCommanderCommand(userNameKEYNEJ, vserverAdPpalFolder +"/" + xmlFileAddPplAdrss, vserverAvecAdPpalResultFolder);
            
            //Copier les fichiers PDF générés en local
            ExecuteWinSCPCommand(vServerReportsCR1485, '"get /etc/finansoft/AdPpal/AvecAdPpal/*.pdf ""' + xmlFolderPath + '"""');
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 14: Valider l'adresse affichée dans les PDF (adresse principale");
            //Valider l'adresse qui figure dans chaque page des fichiers PDF
            
            //Valider l'adresse dans 800052.PDF
            var PPAddress800052 = [PPCity800052, "CANADA  "+ PPZipCode800052];
            CheckStringOccurenceInPdfFile(PDFFilePath800052, 1, [PPStreet800052]);
            CheckStringOccurenceInPdfFile(PDFFilePath800052, 4, [PPStreet800052]);
            CheckStringOccurenceInPdfFile(PDFFilePath800052, null, PPAddress800052);
            
            //Valider l'adresse dans 800228.PDF
            var PPAddress800228 = [PPCity800228, "CANADA  "+ PPZipCode800228];
            CheckStringOccurenceInPdfFile(PDFFilePath800228, 1, [PPStreet800228]);
            CheckStringOccurenceInPdfFile(PDFFilePath800228, 5, [PPStreet800228]);            
            CheckStringOccurenceInPdfFile(PDFFilePath800228, null, PPAddress800228);
                       
     }
    catch(e) {
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            Log.PopLogFolder();
            logRetourEtatInitial = Log.AppendFolder("Supprimer les adresses secondaires  "); 
        
            DeleteAddressForClient(client800052, addressType800052);
            DeleteAddressForClient(client800228, addressType800228);
        
            //Fermer le processus Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
        
            //Pref par défault
            DefaultPref();
    }
}