//USEUNIT ReportCommander_Commonfunctions

/**
    Jira Xray   : https://jira.croesus.com/browse/TCVE-2136
    Description : 
    Analyste d'assurance qualité : Karima Meh
    Analyste d'automatisation : A.A
**/

function RPT_3009_AutomateGP1859ReportsGenerationWithReportCommander()
{
    var logEtape1, logEtape2, logRetourEtatInitial;
    
    
    try {
            Log.Link("https://jira.croesus.com/browse/TCVE-2136","Lien du Cas de test sur Jira Xray");
        
            var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
            var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        
            var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
            var listOfReportNames = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_ListOfReportNames", language+client);
            var selectedRportName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_SelectedRportName", language+client);
        
            var destination    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_Destination", language+client);
            var reportLanguage = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_ReportLanguage", language+client);
        
            var relationshipName      = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_RelationshipName", language+client);
            var relantionshipLanguage = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_RelantionshipLanguage", language+client);
            var currency              = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_Currency", language+client);
            var IACode                = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_IACode", language+client);
            var client800228          = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_Client800228", language+client);
            var client800249          = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "ReportCommander", "RPT_3009_Client800249", language+client);
        
            //        var listOfReportNames = "Page couverture (trimestriel)|Répartition d'actifs du portefeuille|Historique du rendement|Évolution de la valeur de marché|Évaluation du portefeuille (trimestriel)"
            //                                    "Cover Page (Quarterly)|Assets Allocation|Cash History|Evolution of Market Value|Portfolio Evaluation (Quarterly)"
            var arrayOfReportsNames = listOfReportNames.split("|");

            var xmlFilePath   = folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteRapports\\Rapports\\RCommander\\ReportCommander_GP1859.xml"
            var xmlFolderPath = folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteRapports\\Rapports\\RCommander\\";
            var vserverRemoteFolder = "/etc/finansoft/GP1859";        
       
            // Étape 1        
            logEtape1 = Log.AppendFolder("Étape 1: login avec UNI00 et valider que les rapports ont un thème spécifique");
            Login(vServerReportsCR1485, userNameUNI00, passwordUNI00, language);
        
            //valider que tous les rapports ont un thème spécifique
            Log.Message("valider que les rapports ont un thème spécifique");
            ValidateSpecificThemeReport(arrayOfReportsNames);
       
            //Fermer Croesus
            Close_Croesus_MenuBar();
         
            //Se deconnecter de Croesus
            LogoutFromCroesus(vServerReportsCR1485);
        
            //Se connecter en mode Debug
            Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language, null, debugModeString);   
        
            //Créer la relation "CR1485-2" et joindre les clients 800228 et 800249
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer la relation CR1485-2 et joindre les clients 800228 et 800249");
            CreateRelationship(relationshipName, IACode, currency, relantionshipLanguage);
            JoinClientToRelationship(client800228, relationshipName) 
            JoinClientToRelationship(client800249, relationshipName)
              
            //Étape 3 et 4: Générer le fichier XML
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 3 et 4: Générer le fichier XML.");
            SearchRelationshipByName(relationshipName);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
            GenerateXmlFile(selectedRportName, destination, reportLanguage, xmlFilePath, true);
            
            
            //Creer le dossier: /etc/finansoft/GP1859
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 5: Copier le fichier XML.");
            var CreateFolderSSHCommand = "[ ! -d " + vserverRemoteFolder + " ] && mkdir -p "+ vserverRemoteFolder +" || rm -f "+ vserverRemoteFolder + "/*.*";
            ExecuteSSHCommand("aminea", vServerReportsCR1485, CreateFolderSSHCommand, null);
        
            //Étape 5: Copier le fichier ReportCommander_GP1859.xml dans le vserveur
            CopyFileToVserverThroughWinSCP(vServerReportsCR1485, vserverRemoteFolder, xmlFilePath);
        
            //Étape 6 et 7: Créer et rouler la commande SSH
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 6 et 7: Créer et rouler la commande SSH ");
        
            var XmlFileTaskPath = "/etc/finansoft/GP1859/ReportCommander_GP1859.xml";
            var ResultFolderPath = "/etc/finansoft/GP1859";
            
            ExecuteReportCommanderCommand(userNameDARWIC, XmlFileTaskPath, ResultFolderPath);
      
            //Étape 8: Valider que le PDF a été créé  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 8: Valider que le PDF a été créé ");
        
            ExecuteWinSCPCommand(vServerReportsCR1485, '"get /etc/finansoft/GP1859/BD88-*.pdf ""' + xmlFolderPath + '"""');

            var colFiles = aqFileSystem.GetFolderInfo(xmlFolderPath).Files;
            var isFound  = false;
            while (colFiles.HasNext()){
                var FileItem = colFiles.Next();
                FileExt = aqFileSystem.GetFileExtension(FileItem.Path);
                if (FileExt == "pdf"){
                    isFound = true;
                    Log.Checkpoint("Un fichier PDF est généré: " + FileItem.Name);
                    Log.Message(FileItem.Path)
                    aqFileSystem.DeleteFile(FileItem.Path);
                }
            }
            if (!isFound)
                Log.Error("Le dossier " + xmlFolderPath + " ne contient aucun fichier PDF");
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Supprimer la relation: " + relationshipName);
        //Supprimer la relation 
        DeleteRelationship(relationshipName);
        
        //Fermer le processus Croesus
        Close_Croesus_MenuBar();
    }
}    