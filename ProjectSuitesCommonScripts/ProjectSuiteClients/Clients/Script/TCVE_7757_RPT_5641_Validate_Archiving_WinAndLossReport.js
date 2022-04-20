//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description :
    Lien du cas de test: https://jira.croesus.com/browse/RTM-1011 
    Lien de la story: https://jira.croesus.com/browse/TCVE-7757
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane Diallo
*/

function TCVE_7757_RPT_5641_Validate_Archiving_WinAndLossReport()
{
    try {
      
    
    
       var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;

        
        /***************************************************Variables************************************************/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        
        var clientNumber           = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "CLIENT_NUMBER_800252", language+client);
        var accountNum800252FS     = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ACCOUNT_NUMBER_800252FS", language+client);
        var accountNum800252NA     = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ACCOUNT_NUMBER_800252NA", language+client);
        var reportNameGainAndLoss  = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "REPPORT_GAIN_LOSS", language+client);
        var nbrPDFgenere           = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NBR_PDF_GENERE", language+client);
        
        Log.Link("https://jira.croesus.com/browse/RTM-1011", "Lien du cas de test");
        Log.Link("https://jira.croesus.com/browse/TCVE-7757", "Lien de la story");
        
        
        //Se connecter avec Keynej
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej"); 
        Login(vServerClients, userName, password, language);
        
        //Acceder au module client et selectionner le client 800252
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Selectionner le client 800252 puis mailler le vers le module compte"); 
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        Drag( Get_RelationshipsClientsAccountsGrid().Find("Value",clientNumber,10), Get_ModulesBar_BtnAccounts());
         if (Get_DlgConfirmation().Exists){
          Get_DlgConfirmation_BtnCancel().ClicK()
         }
                       
        
        
        //Open eports window and Select reportR
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Selectionner les deux comptes puis  Ouvrir la fenetre rapport et selectionner le rapport Gain et Perte"); 
        Get_RelationshipsClientsAccountsGrid().Keys("^a");
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportNameGainAndLoss);
        Get_WinReports_GrpOptions_ChkArchiveReports().Click();
        Get_WinReports_BtnOK().Click();
        Delay(10000)
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Revenir dans le module client, ouvrir la fenête info puis onglet document"); 
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000); 
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabDocuments().Click();
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Valider la génération et  l'archivage des rapport");   
        if((Get_PersonalDocuments_LstDocuments().ChildCount -1)==nbrPDFgenere){
          
              Log.Checkpoint("les deux rapports PDF sont archivés")
        }
        else{
             Log.Error("Les deux rapports PDF ne sont pas archivés ")
        }
        
        //Supprimer les deux rapports
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Supprimer les deux rapports archivés");
        Get_PersonalDocuments_Toolbar_BtnRemove().Click();
        Get_DlgConfirmation_BtnYes().Click();
        Get_PersonalDocuments_Toolbar_BtnRemove().Click();
        Get_DlgConfirmation_BtnYes().Click();
        Get_WinDetailedInfo_BtnOK().Click(); 
        
        //Valider que le fichier PDF est généré
        Log.Message("---------- Valider que le PDF est généré ----------------");
        Sys.FindChildEx("ProcessName", GetAcrobatProcessName(), 10, true, 3000).WaitWindow("AcrobatSDIWindow", "Open*", 1, 3000); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
        aqObject.CheckProperty(Sys.FindChild("WndClass", "AcrobatSDIWindow", 10), "Visible", cmpEqual, true);
        TerminateAcrobatProcess(); //2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
            
                            
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        
    }
}

