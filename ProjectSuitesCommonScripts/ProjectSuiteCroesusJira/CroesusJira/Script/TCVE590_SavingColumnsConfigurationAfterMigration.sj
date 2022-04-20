//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-590
    Description          :  Automatisation la sauvegarde de la configuration des colonnes dans toutes les grilles après chaque migration
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.12.HF.78-2
     
*/

function TCVE590_SavingColumnsConfigurationAfterMigration() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-590");
            Log.Link("Il faut exécuter ce script avec un dump spécial demande de Karima. Pour cette raison le script n'est pas dans la suite d'exécution.");  
                       
            var userNameFIRMADM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FIRMADM", "username");
            var passwordFIRMADM = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FIRMADM", "psw");
                                                      
            //Se connecter à croesus
            Log.Message("Se connecter à croesus");
            Login(vServerPortefeuille, userNameFIRMADM, passwordFIRMADM, language);
            Get_MainWindow().Maximize();
            
            //Valider la présence de colonnes dans le module Clients:  
            Log.Message("Valider la présence de colonnes dans le module Clients: lungue; Communication;Actif net; No modèle; Commission ");
            Get_ModulesBar_BtnClients().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider la présence de colonnes dans le module Clients");
            
            SetAutoTimeOut();
            if (Get_ClientsGrid_ChLangue().Exists){
                Log.Checkpoint("'lungue' column displayed.");
                aqObject.CheckProperty(Get_ClientsGrid_ChLangue(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'lungue' column not displayed. This is not expected.");
            }
           
            if (Get_ClientsGrid_ChCommunication().Exists){
                Log.Checkpoint("'Communication' column displayed.");
                aqObject.CheckProperty(Get_ClientsGrid_ChCommunication(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Communication' column not displayed. This is not expected.");
            }
           
            if (Get_ClientsGrid_ChTotalNetValue().Exists){
                Log.Checkpoint("'Actif net' column displayed.");
                aqObject.CheckProperty(Get_ClientsGrid_ChTotalNetValue(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Actif net' column not displayed. This is not expected.");
            }
           
            if (Get_ClientsGrid_ChModelNumber().Exists){
                Log.Checkpoint("'No modèle' column displayed.");
                aqObject.CheckProperty(Get_ClientsGrid_ChModelNumber(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'No modèle' column not displayed. This is not expected.");
            }
         
            if (Get_ClientsGrid_ChCommission().Exists){
                Log.Checkpoint("'Commission' column displayed.");
                aqObject.CheckProperty(Get_ClientsGrid_ChCommission(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Commission' column not displayed. This is not expected.");
            }
            RestoreAutoTimeOut();

                   
            //Valider la présence de colonnes dans le module Comptes:  
            Log.Message("Valider la présence de colonnes dans le module Comptes: Loisirs, Discretionnaire, Dern.trans, État, date ");
            Get_ModulesBar_BtnAccounts().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider la présence de colonnes dans le module Comptes:");
            
            SetAutoTimeOut();
            if (Get_AccountsGrid_ChHobbies().Exists){
                Log.Checkpoint("'Loisirs' column displayed.");
                aqObject.CheckProperty(Get_AccountsGrid_ChHobbies(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Loisirs' column not displayed. This is not expected.");
            }
           
            if (Get_AccountsGrid_ChDiscretionary().Exists){
                Log.Checkpoint("'Discretionnaire' column displayed.");
                aqObject.CheckProperty(Get_AccountsGrid_ChDiscretionary(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Discretionnaire' column not displayed. This is not expected.");
            }
           
            if (Get_AccountsGrid_ChLastTransaction().Exists){
                Log.Checkpoint("'Dern.trans' column displayed.");
                aqObject.CheckProperty(Get_AccountsGrid_ChLastTransaction(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Dern.trans' column not displayed. This is not expected.");
            }
           
            if (Get_AccountsGrid_ChStatus().Exists){
                Log.Checkpoint("'État' column displayed.");
                aqObject.CheckProperty(Get_AccountsGrid_ChStatus(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'État' column not displayed. This is not expected.");
            }
         
            if (Get_AccountsGrid_ChDate().Exists){
                Log.Checkpoint("'date' column displayed.");
                aqObject.CheckProperty(Get_AccountsGrid_ChDate(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'date' column not displayed. This is not expected.");
            }
            RestoreAutoTimeOut();
            
            //Valider la présence de colonnes dans le module Relations:  
            Log.Message("Valider la présence de colonnes dans le module Relations: Segmentation, Employer, Interlocuteur,Discretionnaire, Commission");
            Get_ModulesBar_BtnRelationships().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT:Valider la présence de colonnes dans le module Relations:");
            
            SetAutoTimeOut();
            if (Get_RelationshipsGrid_ChSegmentation().Exists){
                Log.Checkpoint("'Segmentation,' column displayed.");
                aqObject.CheckProperty(Get_RelationshipsGrid_ChSegmentation(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Segmentation,' column not displayed. This is not expected.");
            }
           
            if (Get_RelationshipsGrid_ChDiscretionary().Exists){
                Log.Checkpoint("'Discretionnaire' column displayed.");
                aqObject.CheckProperty(Get_RelationshipsGrid_ChDiscretionary(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Discretionnaire' column not displayed. This is not expected.");
            }
           
            if (Get_RelationshipsGrid_ChEmployer().Exists){
                Log.Checkpoint("'Employer' column displayed.");
                aqObject.CheckProperty(Get_RelationshipsGrid_ChEmployer(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Employer' column not displayed. This is not expected.");
            }
           
            if (Get_RelationshipsGrid_ChRepresentative().Exists){
                Log.Checkpoint("'Interlocuteur' column displayed.");
                aqObject.CheckProperty(Get_RelationshipsGrid_ChRepresentative(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Interlocuteur' column not displayed. This is not expected.");
            }
         
            if (Get_RelationshipsGrid_ChCommission().Exists){
                Log.Checkpoint("'Commission' column displayed.");
                aqObject.CheckProperty(Get_RelationshipsGrid_ChCommission(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Commission' column not displayed. This is not expected.");
            }
            RestoreAutoTimeOut();
            
           
            //Valider la présence de colonnes dans le module Modeles:  
            Log.Message("Valider la présence de colonnes dans le module Modeles: date de création, nom complet");
            Get_ModulesBar_BtnModels().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider la présence de colonnes dans le module Modeles:");
            SetAutoTimeOut();
            if (Get_ModelsGrid_ChCreationDate().Exists){
                Log.Checkpoint("'date de création' column displayed.");
                aqObject.CheckProperty(Get_ModelsGrid_ChCreationDate(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'date de création' column not displayed. This is not expected.");
            }
         
            if (Get_ModelsGrid_ChFullName().Exists){
                Log.Checkpoint("'nom complet' column displayed.");
                aqObject.CheckProperty(Get_ModelsGrid_ChFullName(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'nom complet' column not displayed. This is not expected.");
            }
             RestoreAutoTimeOut();
            
            //Valider la présence de colonnes dans le module Titre   
            Log.Message("Valider la présence de colonnes dans le module Titre:Fréquence,Région,Suivi des analystes");
            Get_ModulesBar_BtnSecurities().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT:Valider la présence de colonnes dans le module Titre");
            SetAutoTimeOut();
            if (Get_SecurityGrid_ChAnalystCoverage().Exists){
                Log.Checkpoint("'Suivi des analystes' column displayed.");
                aqObject.CheckProperty(Get_SecurityGrid_ChAnalystCoverage(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Suivi des analystes' column not displayed. This is not expected.");
            }
         
            if (Get_SecurityGrid_ChRegion().Exists){
                Log.Checkpoint("'Région' column displayed.");
                aqObject.CheckProperty(Get_SecurityGrid_ChRegion(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Région' column not displayed. This is not expected.");
            }
            
            if (Get_SecurityGrid_ChFrequency().Exists){
                Log.Checkpoint("'Fréquence' column displayed.");
                aqObject.CheckProperty(Get_SecurityGrid_ChFrequency(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Fréquence' column not displayed. This is not expected.");
            }
             RestoreAutoTimeOut();
           
            //Valider la présence de colonnes dans le module Ordre 
			      Log.Message("Jira: TCVE-803");  
            Log.Message("Valider la présence de colonnes dans le module Ordre:Fournisseur,Instrument financier,Taux");
            Get_ModulesBar_BtnOrders().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider la présence de colonnes dans le module Ordre");
            
             if (Get_OrderGrid_ChSupplier().Exists){
                Log.Checkpoint("'Fournisseur' column displayed.");
                aqObject.CheckProperty(Get_OrderGrid_ChSupplier(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Fournisseur' column not displayed. This is not expected.");
            }
         
            if (Get_OrderGrid_ChFinancialInstrument().Exists){
                Log.Checkpoint("'Instrument financier' column displayed.");
                aqObject.CheckProperty(Get_OrderGrid_ChFinancialInstrument(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Instrument financier' column not displayed. This is not expected.");
            }
            
            if (Get_OrderGrid_ChRate().Exists){
                Log.Checkpoint("'Taux' column displayed.");
                aqObject.CheckProperty(Get_OrderGrid_ChRate(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Taux' column not displayed. This is not expected.");
            }
            RestoreAutoTimeOut();
            
            //Valider la présence de colonnes dans le module Portefeuille   
            Log.Message("Valider la présence de colonnes dans le module Portefeuille:Secteur, Bêta");
            Get_ModulesBar_BtnClients().Click();
            Log.Picture(Sys.Desktop.ActiveWindow(), "SREENSHOT: Valider la présence de colonnes dans le module Portefeuille");
            Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).Click();
            //maillage vers le module portefeuille 
            Get_MenuBar_Modules().OpenMenu();
            Get_MenuBar_Modules_Portfolio().OpenMenu();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            SetAutoTimeOut();
            if (Get_Portfolio_PositionsGrid_ChBeta().Exists){
                Log.Checkpoint("'Bêta' column displayed.");
                aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChBeta(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Bêta' column not displayed. This is not expected.");
            }
            
            if (Get_Portfolio_PositionsGrid_ChSector().Exists){
                Log.Checkpoint("'Secteur' column displayed.");
                aqObject.CheckProperty(Get_Portfolio_PositionsGrid_ChSector(), "VisibleOnScreen", cmpEqual, true);
            }
            else {
                Log.Error("'Secteur' column not displayed. This is not expected.");
            }
            RestoreAutoTimeOut();
      
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
     
            //Fermer l'application
            Terminate_CroesusProcess();                       
        }
}



