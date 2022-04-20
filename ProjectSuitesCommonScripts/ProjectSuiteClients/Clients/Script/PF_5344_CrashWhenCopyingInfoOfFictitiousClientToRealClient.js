//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description :Je veux pouvoir copier/sauvegarder l'information d'un client fictif à un client réel par la fonction existante (right click > Copy Client Information),
                 Afin de sauver le temps de re-copiage manuel des infos du client.
    Lien du cas de test:  https://jira.croesus.com/browse/RTM-1493
    Lien de la story:  https://jira.croesus.com/browse/TCVE-7755
    Analyste d'assurance qualité : Alberto Q
    Analyste d'automatisation : Abdel M
    version : 90.27.2021.10-57
    Date: 11/11/2021
*/

function PF_5344_CrashWhenCopyingInfoOfFictitiousClientToRealClient()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/RTM-1493", "Lien du cas de test");
        Log.Link("https://jira.croesus.com/browse/TCVE-7755", "Lien de la story");
        
        /*Variables*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        var client800068 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "client800068", language+client);
        var clientFictif = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "clientFictif", language+client);
        var employeur = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil2", language+client);
        var TabProfilText = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TabProfilText", language+client);
        var street1 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street1", language+client);
        var street2 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street2", language+client);
        var country = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "country", language+client);
        var postalCode = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "postalCode", language+client);
        var phoneNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "phoneNumber", language+client);
        var typeAddress = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "typeAddress", language+client);
        
        
//***************************************** ÉTAPE 1 **********************************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Darwic"); 
        
        //Login
        Login(vServerClients, userName, password, language);
        
//***************************************** ÉTAPE 2 **********************************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Selectionner le client client800068 puis mailler le vers le module Portefeuille"); 
        
        //Acceder au module client et selectionner le client  800068
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000);
        Search_Client(client800068);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800068, 10, true, 30000).Click();
        Drag( Get_RelationshipsClientsAccountsGrid().Find("Value",client800068,10), Get_ModulesBar_BtnPortfolio());
         if (Get_DlgConfirmation().Exists){
          Get_DlgConfirmation_BtnCancel().ClicK()
         }
        
         // Cliquer sur Simulation
         Get_PortfolioBar_BtnWhatIf().Click();
         //cliquer sur Sauvergarder
         Get_PortfolioBar_BtnSave().Click();
         //4.cliquer sur Sauvegarde détaillée en laissant Nouveau compte fictif coché 
         Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().set_IsChecked(true);
         Get_WinWhatIfSave_BtnOK().Click();
         Get_DlgInformation_BtnOK().Click();
         
//***************************************** ÉTAPE 3 **********************************************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner le client fictif BARKWELL CARLSON / Info / Profils"); 
        
        //Acceder au module client et selectionner le client  fictif
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000);
        Search_Client(clientFictif);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientFictif, 10, true, 30000).DblClick();
        Get_WinDetailedInfo_TabProfile().Click();
        WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
   
        //cliquer sur Configuration et cocher les profils 'Employeur'  Défaut et sauvgarder
        Get_WinInfo_TabProfile_BtnSetup().Click();

        var profilEmpl=Get_WinVisibleProfilesConfiguration_ChkProfile(employeur)
        if(profilEmpl.get_IsChecked() == false)
        profilEmpl.Click();
        Get_WinVisibleProfilesConfiguration().Find("Value",employeur,10).WaitProperty("IsChecked", true, 10000);
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        Get_WinDetailedInfo_BtnApply().Click();
//        Get_WinDetailedInfo_BtnOK()>Click();
        
//***************************************** ÉTAPE 4 **********************************************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur l'onglet Adresses , ajouter un numero de tel et une adresse de type Résidence secondaire");
        
        //Cliquer l'onglet Adresse
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);

        //Ajouter une adresse
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
        Get_WinCRUAddress_CmbType().set_SelectedIndex(3);//Résidence secondaire
        Get_WinCRUAddress_TxtStreet1().Keys(street1);
        Get_WinCRUAddress_TxtStreet2().Keys(street2);
        Get_WinCRUAddress_TxtCountry().Keys(country);
        Get_WinCRUAddress_TxtPostalCode().Keys(postalCode);
        Get_WinCRUAddress_BtnOK().Click();
//        WaitObject(Get_CroesusApp(), ["WPFControlText","VisibleOnScreen"], ["ALARY ANNY: 800241", true]); 
        
        //Ajouter un numéro de téléphone
        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
        Get_WinCRUTelephone_CmbType().Click();
        Get_WinCRUTelephone_CmbType().set_SelectedIndex(2);//Bureau
        Get_WinCRUTelephone_TxtNumber().Keys(phoneNumber);
        Get_WinCRUTelephone_BtnOK().Click();
        
        Get_WinDetailedInfo_BtnOK().Click();
        
//***************************************** ÉTAPE 5 **********************************************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Sélectionner le client fictif BARKWELL CARLSON / clique droit Copier les informations du client");
        
        Search_Client(clientFictif);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientFictif, 10, true, 30000).ClickR();
        //Cliquer sur Copier l'information du client
        Get_ClientsGrid_ContextualMenu_CopyClientInformation().Click();
        //Rechercher le client 800068 dans la fenêtre Copier les informations
        Log.Message("Dans la section de droite de la fenêtre  Faire une recherche par Numero du client 800068.");
        Get_WinCopyClientInfo_ListPickerCombo().Click();
        Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", "2"], 10).Click();
        Get_WinCopyClientInfo_TxtQuickSearch().SetText(client800068);
        WaitObject(Get_WinCopyClientInfo(), "Uid", "ListPickerExec_9344", 3000);
        Get_WinCopyClientInfo_TxtQuickSearch().Keys("[Tab]");
        
        //Cocher Profil, adresse et téléphone
        Log.Message("Cocher Profil, adresse et téléphone")
        Get_WinCopyClientInfo_ChkBoxProfile().set_IsChecked(true);
        Get_WinCopyClientInfo_ChkBoxAddress().set_IsChecked(true);
        Get_WinCopyClientInfo_ChkBoxPhoneNumber().set_IsChecked(true);
        Get_WinCopyClientInfo_BtnOK().Click();
        
//***************************************** ÉTAPE 6 **********************************************************************
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Valider que les informations sont bien copiés au client 800068 sans aucun crash");
        
        //Accéder à la fenêtre info du client 800068
        Log.Message("Accéder à la fenêtre info du client "+client800068);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800068, 10, true, 30000).DblClick();
        
        //Onglet profile
        Log.Message("Validation du profil");
        Get_WinDetailedInfo_TabProfile().Click();
        WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
        CheckIfItemExists(employeur);
        
        //Onglet Adresses
        Log.Message("Validation de l'adresse et numéro de téléphone");
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
        Get_SubMenus().FindChild("WPFControlText", typeAddress, 10).Click(); 
        CheckIfItemExists(street1);
        CheckIfItemExists(street2);
        CheckIfItemExists(postalCode);
        CheckIfItemExists(country);
        CheckIfItemExists(phoneNumber);
        Get_WinDetailedInfo_BtnOK().Click();
             
       
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
//***************************************** ÉTAPE 7 **********************************************************************
      Log.PopLogFolder();
      logEtape7 = Log.AppendFolder("Étape 7: --------- C L E A N U P ------------");
        
      DeleteClientByNumber(clientFictif);
  		//Fermer le processus Croesus
      Terminate_CroesusProcess();
    }
}

function CheckIfItemExists(Item){
    var itemText = Get_WinDetailedInfo().FindChild("Text", Item, 10);
    if (itemText.Exists)
        Log.Checkpoint("L'item "+Item+" a été bien copié");
    else  
        Log.Error("L'item "+Item+" n'a pas été bien copié");
}