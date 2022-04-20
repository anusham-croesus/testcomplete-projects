//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description :Valider que le MailMerge fonctionne correctement avec la nouvelle configuration (depuis la version 90.24.2021.04-113)

    Pré-conditions: Dans l'Assemble script avoir ajouter:
                    MAIL_MERGE_SERVICE="{"AppSettings:SyncFusionLicense": "MDAxQDMxMzgyZTM0MmUzMGNkY0NTZGFMYVNHQ0ZaZXIrbHZGTGFwaVRSQkF0QWwwRXBOQTNOcW9tUjQ9"}"

                    REPORT_GENERATOR_CONFIG="{"DELEGATOR_NAME": "127.0.0.1", "DELEGATOR_PORT": "6557"}"

                    Exécuter le script : Ajouter_profils_générer_doc.txt (voir le fichier joint)
                    
    Note: La génération des rapports .doc et docx avec des champs de fusion fonctionne uniquement dans modules: Relations, Clients et Comptes
    
    Lien du cas de test:  https://jira.croesus.com/browse/TCVE-8383
    Lien de la story:  https://jira.croesus.com/browse/TCVE-8386
    Analyste d'assurance qualité : Marina G
    Analyste d'automatisation : Abdel M
    version : 90.28.2021.12-49
    Date: 20/12/2021
*/

function TCVE_8383_MailMerge_ValidateRapportGenerationDoc()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/TCVE-8383", "Lien du cas de test");
        Log.Link("https://jira.croesus.com/browse/TCVE-8386", "Lien de la story");
        
        /*Variables*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var client800300 = "800300"//ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "client800068", language+client);
        var client800301 = "800301"
        var client800302 = "800302"
        
        
        
        
//***************************************** PRECONDITIONS **********************************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Préconditions: Exécuter le script : Ajouter_profils_générer_doc.txt (voir le fichier joint)");
        
        ExecuteSQLFile(folderPath_Data + "Ajouter_profils_générer_doc.sql", vServerClients);
           
                
//***************************************** ÉTAPE 1 **********************************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej"); 
        
        //Login
        Login(vServerClients, userName, password, language);
        
//***************************************** ÉTAPE 2 **********************************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Sélectionner les clients: 800300, 800301 et 800302 et appliquer le mailmerge"); 
        
        //Acceder au module client et selectionner les clients: 800300, 800301 et 800302
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000);
        Search_Client(client800300);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800300, 10, true, 30000).Click();
        Get_RelationshipsClientsAccountsGrid().Keys("[Hold]![Down][ReleaseLast][Down][Release]");

//      Dans le menu RAPPORTS sélectionner Exporter vers MS Word
        Log.Message("Dans le menu RAPPORTS sélectionner Exporter vers MS Word");
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExportToMSWord().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        Get_winExportToMSWord_GrpMailMergeFields_BtnRemoveAll().Click();
        
        
         
////***************************************** ÉTAPE 3 **********************************************************************
//        Log.PopLogFolder();
//        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner le client fictif BARKWELL CARLSON / Info / Profils"); 
//        
//        //Acceder au module client et selectionner le client  fictif
//        Get_ModulesBar_BtnClients().Click();
//        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 3000);
//        Search_Client(clientFictif);
//        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientFictif, 10, true, 30000).DblClick();
//        Get_WinDetailedInfo_TabProfile().Click();
//        WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
//        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
//   
//        //cliquer sur Configuration et cocher les profils 'Employeur'  Défaut et sauvgarder
//        Get_WinInfo_TabProfile_BtnSetup().Click();
//
//        var profilEmpl=Get_WinVisibleProfilesConfiguration_ChkProfile(employeur)
//        if(profilEmpl.get_IsChecked() == false)
//        profilEmpl.Click();
//        Get_WinVisibleProfilesConfiguration().Find("Value",employeur,10).WaitProperty("IsChecked", true, 10000);
//        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
//        Get_WinDetailedInfo_BtnApply().Click();
////        Get_WinDetailedInfo_BtnOK()>Click();
//        
////***************************************** ÉTAPE 4 **********************************************************************
//        Log.PopLogFolder();
//        logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur l'onglet Adresses , ajouter un numero de tel et une adresse de type Résidence secondaire");
//        
//        //Cliquer l'onglet Adresse
//        Get_WinDetailedInfo_TabAddresses().Click();
//        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
//
//        //Ajouter une adresse
//        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
//        Get_WinCRUAddress_CmbType().set_SelectedIndex(3);//Résidence secondaire
//        Get_WinCRUAddress_TxtStreet1().Keys(street1);
//        Get_WinCRUAddress_TxtStreet2().Keys(street2);
//        Get_WinCRUAddress_TxtCountry().Keys(country);
//        Get_WinCRUAddress_TxtPostalCode().Keys(postalCode);
//        Get_WinCRUAddress_BtnOK().Click();
////        WaitObject(Get_CroesusApp(), ["WPFControlText","VisibleOnScreen"], ["ALARY ANNY: 800241", true]); 
//        
//        //Ajouter un numéro de téléphone
//        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
//        Get_WinCRUTelephone_CmbType().Click();
//        Get_WinCRUTelephone_CmbType().set_SelectedIndex(2);//Bureau
//        Get_WinCRUTelephone_TxtNumber().Keys(phoneNumber);
//        Get_WinCRUTelephone_BtnOK().Click();
//        
//        Get_WinDetailedInfo_BtnOK().Click();
//        
////***************************************** ÉTAPE 5 **********************************************************************
//        Log.PopLogFolder();
//        logEtape5 = Log.AppendFolder("Étape 5: Sélectionner le client fictif BARKWELL CARLSON / clique droit Copier les informations du client");
//        
//        Search_Client(clientFictif);
//        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientFictif, 10, true, 30000).ClickR();
//        //Cliquer sur Copier l'information du client
//        Get_ClientsGrid_ContextualMenu_CopyClientInformation().Click();
//        //Rechercher le client 800068 dans la fenêtre Copier les informations
//        Log.Message("Dans la section de droite de la fenêtre  Faire une recherche par Numero du client 800068.");
//        Get_WinCopyClientInfo_ListPickerCombo().Click();
//        Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", "2"], 10).Click();
//        Get_WinCopyClientInfo_TxtQuickSearch().SetText(client800068);
//        WaitObject(Get_WinCopyClientInfo(), "Uid", "ListPickerExec_9344", 3000);
//        Get_WinCopyClientInfo_TxtQuickSearch().Keys("[Tab]");
//        
//        //Cocher Profil, adresse et téléphone
//        Log.Message("Cocher Profil, adresse et téléphone")
//        Get_WinCopyClientInfo_ChkBoxProfile().set_IsChecked(true);
//        Get_WinCopyClientInfo_ChkBoxAddress().set_IsChecked(true);
//        Get_WinCopyClientInfo_ChkBoxPhoneNumber().set_IsChecked(true);
//        Get_WinCopyClientInfo_BtnOK().Click();
//        
////***************************************** ÉTAPE 6 **********************************************************************
//        Log.PopLogFolder();
//        logEtape6 = Log.AppendFolder("Étape 6: Valider que les informations sont bien copiés au client 800068 sans aucun crash");
//        
//        //Accéder à la fenêtre info du client 800068
//        Log.Message("Accéder à la fenêtre info du client "+client800068);
//        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800068, 10, true, 30000).DblClick();
//        
//        //Onglet profile
//        Log.Message("Validation du profil");
//        Get_WinDetailedInfo_TabProfile().Click();
//        WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
//        CheckIfItemExists(employeur);
//        
//        //Onglet Adresses
//        Log.Message("Validation de l'adresse et numéro de téléphone");
//        Get_WinDetailedInfo_TabAddresses().Click();
//        Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
//        Get_SubMenus().FindChild("WPFControlText", typeAddress, 10).Click(); 
//        CheckIfItemExists(street1);
//        CheckIfItemExists(street2);
//        CheckIfItemExists(postalCode);
//        CheckIfItemExists(country);
//        CheckIfItemExists(phoneNumber);
//        Get_WinDetailedInfo_BtnOK().Click();
//             
       
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
//***************************************** ÉTAPE 7 **********************************************************************
//      Log.PopLogFolder();
//      logEtape7 = Log.AppendFolder("Étape 7: --------- C L E A N U P ------------");
//        
//      DeleteClientByNumber(clientFictif);
//  		//Fermer le processus Croesus
//      Terminate_CroesusProcess();
    }
}

function test(){
  var grid = Aliases.CroesusApp.winExportToMSWord.WPFObject("UniGroupBox", "Champs de fusion", 1).WPFObject("UniScrollPane", "", 2)
  var count = grid.ChildCount
  for (i=0; i<count; i++){
    if (grid.Content.Children.Item(i)=="Adresse__complete")
        grid.Content.Children.Item(i).IsChecked == true
    
  }
  
}
