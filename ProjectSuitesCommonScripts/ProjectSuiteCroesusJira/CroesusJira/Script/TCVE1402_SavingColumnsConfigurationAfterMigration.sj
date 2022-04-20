//USEUNIT Helper

/**
    Jira                 :  TCVE-1402
    Description          :  Automatisation la sauvegarde de la configuration des colonnes dans toutes les grilles après chaque migration
    Préconditions        :     
    Auteur               :  A.A
    Version de scriptage :	90.18.49
     
*/

function TCVE51402_SavingColumnsConfigurationAfterMigration() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-1402"); 
                       
            var userNameFIRMADM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FIRMADM", "username");
            var passwordFIRMADM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FIRMADM", "psw");
            
            var Client_ColumnList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Client_ColumnList", language+client); 
            var Client_ProfilList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Client_ProfilList", language+client); 
            
            var Comptes_ColumnList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Comptes_ColumnList", language+client); 
            var Comptes_ProfilList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Comptes_ProfilList", language+client);
            
            var Relations_ColumnList      = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Relations_ColumnList", language+client); 
            var Relations_ProfilList      = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Relations_ProfilList", language+client);
            var Relations_ProfilListToAdd = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Relations_ProfilListToAdd", language+client);
            
            var Titre_ColumnList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Titre_ColumnList", language+client); 
            var Titre_ProfilList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Titre_ProfilList", language+client);
            
            var Modeles_ColumnList      = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Modeles_ColumnList", language+client); 
            var Ordre_ColumnList        = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Ordre_ColumnList", language+client);
            var Portefeuille_ColumnList = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_Portefeuille_ColumnList", language+client);
            
            var waitTime = 5000;
            var attr = Log.CreateNewAttributes();
               attr.Bold = true;
                                                         
            //Se connecter à croesus
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Se connecter à croesus ", "", pmNormal, attr); 
            Login(vServerCroesusJira, userNameFIRMADM, passwordFIRMADM, language);
           
            //Ajouter les colonnes et profils dans le module Clients: 
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Clients ", "", pmNormal, attr); 
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_ClientsGrid_ChClientNo().ClickR()
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            Log.Message("Configurer les profils dans Clients");
            AddProfil(Client_ProfilList, 2, false);
            AddListOfColumns(Get_ClientsGrid_ChClientNo(), Client_ColumnList);
            AddListOfProfils(Get_ClientsGrid_ChClientNo(), Client_ProfilList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider l'ajout des colonnes: Langue, Communication, No modèle, Actif net, Commission");

            
            //Ajouter les colonnes et profils dans le module Comptes:  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajouter les colonnes dans le module Comptes ", "", pmNormal, attr);
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_AccountsGrid_ChAccountNo().ClickR()
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            Log.Message("Configurer les profils dans Comptes");
            AddProfil(Comptes_ProfilList, 3, false);
            AddListOfColumns(Get_AccountsGrid_ChAccountNo(), Comptes_ColumnList);
            AddListOfProfils(Get_AccountsGrid_ChAccountNo(), Comptes_ProfilList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider l'ajout des colonnes: Dern.trans., Discrétionnaire, État, date, Loisirs");

            
            //Ajouter les colonnes et profils dans le module Relations:            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Relations ", "", pmNormal, attr);  
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_RelationshipsGrid_ChRelationshipNo().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            Log.Message("Configurer les profils dans Relations");
            AddProfil(Relations_ProfilList, 1, false);
            AddListOfColumns(Get_RelationshipsGrid_ChRelationshipNo(), Relations_ColumnList);
            AddListOfProfils(Get_RelationshipsGrid_ChRelationshipNo(), Relations_ProfilListToAdd);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Relations: Discrétionnaire, Interlocuteur, Segmentation, Date, Connaissance en placement");

            
            //Ajouter les colonnes et profils dans le module Titres:  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Titres ", "", pmNormal, attr);
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_SecurityGrid_ChSecurity().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            Log.Message("Configurer les profils dans Titres");
            AddProfil(Titre_ProfilList, 0, true);
            AddListOfColumns(Get_SecurityGrid_ChSecurity(), Titre_ColumnList);
            AddListOfProfils(Get_SecurityGrid_ChSecurity(), Titre_ProfilList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Titre: Fréquence, Région, Suivi des analystes");
            
            //Ajouter les colonnes et profils dans le module Modeles: 
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Modeles ", "", pmNormal, attr); 
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_ModelsGrid_ChIACode().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            AddListOfColumns(Get_ModelsGrid_ChIACode(), Modeles_ColumnList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Modèles: date de création, nom complet");
            Log.PopLogFolder();
            
            //Ajouter les colonnes et profils dans le module Ordres:
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Ordres ", "", pmNormal, attr);  
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
            
            //Mettre la configuration par défaut
            Get_OrderGrid_ChAccountNo().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            AddListOfColumns(Get_OrderGrid_ChAccountNo(), Ordre_ColumnList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Ordres: Fournisseur, Instrument financier, Taux");

            
            //Ajouter les colonnes et profils dans le module Portefeuille: 
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Ajout des colonnes dans le module Portefeuille ", "", pmNormal, attr); 
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, waitTime);
            Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).Click();
            //maillage vers le module portefeuille 
            Get_MenuBar_Modules().OpenMenu();
            Get_MenuBar_Modules_Portfolio().OpenMenu();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            Get_Portfolio_PositionsGrid_ChName().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            AddListOfColumns(Get_Portfolio_PositionsGrid_ChName(), Portefeuille_ColumnList);
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Portefeuille: Bêta, Secteur");  
            
            //Fermer Croesus
            Close_Croesus_MenuBar()
            Get_DlgConfirmation_BtnYes().Click();
//            Terminate_CroesusProcess(); 

            
            
            //Migrer le dump
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Migrer le dump vers la nouvelle référence ", "", pmNormal, attr); 
            Delay(60000);
            var vServerURL = vServerCroesusJira;
            var newReferenceName = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_NewReferenceName", language+client);
            var newVersionReference = ReadDataFromExcelByRowIDColumnID(filePath_CroesusJira, "ColumnsMigration", "TCVE1402_NewVersionReference", language+client);
            var vserverName = GetVserverName(vServerURL)
            var migrationVserverOutputFile = Project.Path + 'MigrateVserverOutputFor_' + vserverName + '.txt';
            
            MigrationVsever(vServerURL, newReferenceName, newVersionReference);   
            Log.Message(migrationVserverOutputFile);
            Delay(60000);
            
            //Se connecter à Croesus
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Se connecter à croesus 2eme fois", "", pmNormal, attr);
            Login(vServerCroesusJira, userNameFIRMADM, passwordFIRMADM, language);
          
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Valider l'existance des colonnes dans les différents modules ", "", pmNormal, attr);   
            //Valider l'existance des colonnes dans Clients
            //CLIENTS
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
            ValidateColumns(Client_ColumnList + "|" + Client_ProfilList, "Client")
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider l'ajout des colonnes: Langue, Communication, No modèle, Actif net, Commission");
            
            //COMPTES
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
            ValidateColumns(Comptes_ColumnList + "|" + Comptes_ProfilList, "Compte")
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider l'ajout des colonnes: Dern.trans., Discrétionnaire, État, date, Loisirs");
            
            //RELATIONS
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
            ValidateColumns(Relations_ColumnList + "|" + Relations_ProfilListToAdd, "Relation")
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Relations: Discrétionnaire, Interlocuteur, Segmentation, Date, Connaissance en placement");
            
            //TITRES
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
            ValidateColumns(Titre_ColumnList + "|" + Titre_ProfilList, "Titre")
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Titre: Fréquence, Région, Suivi des analystes");
            
            //MODÈLS
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelPlugin_e798", true]);
            ValidateColumns(Modeles_ColumnList, "Modèle");
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Modèles: date de création, nom complet");
            
            //ORDRES
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
            ValidateColumns(Ordre_ColumnList, "Ordre");
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Ordres: Fournisseur, Instrument financier, Taux");
            
            //PORTEFEUILLE
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, waitTime);
            Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).Click();
            //maillage vers le module portefeuille 
            Get_MenuBar_Modules().OpenMenu();
            Get_MenuBar_Modules_Portfolio().OpenMenu();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["PortfolioPlugin_f3c4", true]);
            ValidateColumns(Portefeuille_ColumnList, "Portefeuille"); 
//            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Ajout des colonnes dans Portefeuille: Bêta, Secteur");               
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
     
            //Fermer l'application
            Close_Croesus_MenuBar()
            Get_DlgConfirmation_BtnYes().Click();
//            Terminate_CroesusProcess();                       
        }
}
