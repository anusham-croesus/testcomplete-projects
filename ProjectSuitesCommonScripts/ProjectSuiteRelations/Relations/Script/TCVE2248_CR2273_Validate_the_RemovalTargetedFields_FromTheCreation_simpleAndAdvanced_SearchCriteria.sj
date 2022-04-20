//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR2273_Commun_Function


/**
    Description : Automatisation des critères de recherche pour TD
    Valider que les champs ciblés ont été retirés de la création des critères de recherches simples et avancés    
    https://jira.croesus.com/browse/TCVE-2248
    Analyste d'assurance qualité : Marina Gassin
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.19.2020.09-18
*/

function TCVE2248_CR2273_Validate_the_RemovalTargetedFields_FromTheCreation_simpleAndAdvanced_SearchCriteria()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-1295") 
            
            
            //Variables                
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10,logEtape11, logEtape12;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            
            
            //Les variables
            var test_telephone      =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "TEST_TELEPHONE", language+client);
            var relationTest3       =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "RELATIONTEST3", language+client);
            var num_Tel44           =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "NUM_TEL44", language+client);
            var nbrclient_Tel44     =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "NBRCLIENT_TEL44", language+client);
            var client800202        =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "CLIENT800202", language+client);
            
            var codePostal_critereName  = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "CODE_POSTAL_CRITERENAME", language+client);
            var codePostal              = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "CODE_POSTAL", language+client);
            
            var module                = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "MODULE", language+client);
            var informativeHeader     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "INFORMATIVE_HEADER", language+client);
            var codePostalHeader      = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "CODE_POSTAL_HEADER", language+client);
            var BasicFieldsHeader     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "BASIC_FIELDS_HEADER", language+client);
            var client800238          =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "CLIENT800238", language+client);
            
            var Adresse_Courriel_critereName  =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "ADRESSEC_COURIEL_CRITERENAME", language+client);
            var Adresse_Courriel_1            =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "ADRESSEC_COURIEL_1", language+client);
            var Ville_province_critereName    =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "VILLE_PROVINCE_CRITERENAME", language+client);
            var Ville_province                =  ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "VILLE_PROVINCE", language+client);
            var nbr_client_VilleLaval         = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2273", "NBR_CLIENT_VILLE_LAVAL", language+client);
            
            
            
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1:Activer les pref"); 
            
            //Mettre la pref PREF_TOGGLE_ENCRYPT_FEATURES a Non                   
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "NO", vServerRelations);
            Activate_Inactivate_Pref("KEYNEJ", "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
                
            //Redemarrer les service
            RestartServices(vServerRelations);
            
     
  
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej et acceder au module client");
             
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            //Acceder au module client  
            Log.Message("Acceder au module client  "); 
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
            CreateCriterion(test_telephone,num_Tel44)
            
            
            //Validation du nombre des clients dont numero de tel termine par 44
            Delay(1000)
            Log.Message("Validation de l'affichage du citere de recherche et du nombre des clients dont le numero de tel termine par 44");
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(), "WPFControlText", cmpEqual, test_telephone);
            aqObject.CheckProperty(Get_StatusBarContentSelection(), "Text", cmpEqual, nbrclient_Tel44);
               
//Étape3
            
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Ajouter un critere avancé: Nom: Code_postal_client Champ: > Clients > Informatif >  Code postal (client)Opérateur: égale Valeur:  J6E 3G1");
             
            //Creation du critere avancé
            CreateAdvancedCriterion(codePostal_critereName,module,informativeHeader,BasicFieldsHeader,codePostalHeader, codePostal) 
            
            
            //Validation
            Log.Message("Validation du nombre du client dont le code postale est J6E 3G1");
            var grid = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 1);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRedCheck(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(), "WPFControlText", cmpEqual, codePostal_critereName);
            aqObject.CheckProperty(grid.Items.Item(0).DataItem, "ClientNumber", cmpEqual, client800202);                    
            
//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: Sélectionner la relation #3 TEST / Info, Appuyer sur la flèche du champ Interlocuteurr puis sélectionner le client 800241, associer l'adresse, le courriel et le téléphone du client à l'Interlocuteur de la relation."); 
            
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            Get_RelationshipsClientsAccountsGrid().Find("Value",relationTest3,10).Click();
            Get_RelationshipsBar_BtnInfo().Click();
            
            
            //Valider que la case à cocher du champ Interlocuteur est cochée, Appuyer sur la flèche du champ Interlocuteurr puis sélectionner le client 800241, associer l'adresse, le courriel et le téléphone du client à l'Interlocuteur de la relation.
            Log.Message("Valider que la case à cocher du champ Interlocuteur est cochée, Appuyer sur la flèche du champ Interlocuteurr puis sélectionner le client 800241, associer l'adresse, le courriel et le téléphone du client à l'Interlocuteur de la relation.")
           
            Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
            Get_WinDetailedInfo_WinClientRoot().FindChild("Text", client800238, 10).Click(); 
            Get_WinDetailedInfo_WinClientRoot_btnOk().Click();
            aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "IsChecked", cmpEqual, true);
             
            Get_DlgConfirmation_BtnYes().Click();
            Get_WinDetailedInfo_BtnOK().Click();
            
            
            
//Étape5            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Ajouter un critère, Liste des relations ayant adresse de courriel 1 contenant aelbers.clement.puis Sauvegarder et actualiser");            
            
            CreateCriterion_EmailAddress(Adresse_Courriel_critereName, Adresse_Courriel_1)

            //Validation du nombre de relation  dont  l'adresse courriel est  CARTERS.CHOUINIERE.
            Log.Message(" Validation du nombre de relation  dont  l'adresse courriel est  CARTERS.CHOUINIERE.1");
            var grid = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 1);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(), "WPFControlText", cmpEqual, Adresse_Courriel_critereName);
            aqObject.CheckProperty(grid.Items.Item(0).DataItem, "ShortName", cmpEqual, relationTest3); 
            aqObject.CheckProperty(grid.Items.Item(0).DataItem, "Email1", cmpEqual, Adresse_Courriel_1);  
                       
//Étape6     
       
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Acceder au module tableau de bord et ajouter un critere de recherche Liste des clients (Client réel) ayant ville ou province débutant par Laval. / Nom: Ville_province Sauvegarder et actualiser");            
   
            Get_ModulesBar_BtnDashboard().Click();
            Get_ModulesBar_BtnDashboard().WaitProperty("IsEnabled", true, 10000)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","AddBoardDialog_c7f4")
            Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion().Click();
            Get_DlgAddBoard_BtnOK().Click();
            
            //Ajouter du critere de recherche
            Log.Message("Ajouter du critere de recherche");
            CreateCriterion_VilleProvince(Ville_province_critereName, Ville_province);
            
            //Validation du nombre de client dont le nom  de la ville ou de la province commence  Laval 
            Log.Message("Validation du nombre de client dont le nom  de la ville ou de la province commence  Laval ");
            aqObject.CheckProperty(Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("GenericCriteriaBasedBoard", "", 2), "HeaderValue2", cmpEqual, nbr_client_VilleLaval);
            aqObject.CheckProperty(Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("GenericCriteriaBasedBoard", "", 2), "PageTitle", cmpEqual, Ville_province_critereName);
            
            //Fermer le processus Croesus
            Terminate_CroesusProcess(); 
            
            
//Étape7            
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("tape 7: A partir du Configurateur Web, activer la PREF_TOGGLE_ENCRYPT_FEATURES=Oui (niveau firme)");  
            
            //A partir du Configurateur Web, activer la PREF_TOGGLE_ENCRYPT_FEATURES=Oui (niveau firme)"          
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "YES", vServerRelations);
            
            //Redemarrer les service
            RestartServices(vServerRelations);
            
            
//Étape8            
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8:Se connecter avec l'usager Keynej / Module Relations et Valider que le critère de recherche qu'on a ajouté, à l'étape 5 (le rectangle bleu+nom: Adresse_Courriel_1), ne s'affiche pas dans la grille");            

            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            //Acceder au module client 
            Log.Message("Acceder au module client  "); 
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
            
            
//Étape9   

            //Valider que le critère de recherche qu'on a ajouté, à l'étape 5 (le rectangle bleu+nom: Adresse_Courriel_1), ne s'affiche pas dans la grille relation
            Log.Message("Valider que le critère de recherche qu'on a ajouté, à l'étape 5 (le rectangle bleu+nom: Adresse_Courriel_1), ne s'affiche pas dans la grille relation");
                     
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Valider que le critère - Adresse_Courriel_1  ne s'affiche pas dans la liste des critères par défaut"); 
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(), "Exists", cmpEqual, false);


            Get_Toolbar_BtnManageSearchCriteria().Click();
            var grid = Aliases.CroesusApp.winSearchCriteriaManager.WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1)
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
                    
                      if (grid.Items.Item(i).DataItem.Description == Adresse_Courriel_1){
                        var Adresse_Courriel_1isfound = true
 
                      }  
                }         
               
               if (Adresse_Courriel_1isfound){
                        
                        Log.Error("le critere " +Adresse_Courriel_1+ "est present dans la liste des criteres")
                        
                } 
                else  {
                        
                        Log.Message("le critere " +Adresse_Courriel_1+ "n'est pas present dans la liste des criteres")
                        
                } 
           
                                
//Étape10            
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10 : Appuyer sur le bouton Ajouter, puis valide que dans le critère de recherche au niveau du champ ‘Informatif’ les options suivants ne devraient pas être affichées :");            
            
            Get_WinSearchCriteriaManager_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
            
            
            //Validation Les options ci-dessous ne sont pas affichées dans le menu déroulant du champ ‘Informatif’ :Adresse civique, Adresse courriel 1, NAS  Numero de Tel, Pays, Ville ou province, Code postale 
            Log.Message("Validation Les options ci-dessous ne sont pas affichées dans le menu déroulant du champ ‘Informatif’ :Adresse civique, Adresse courriel 1, NAS  Numero de Tel, Pays, Ville ou province, Code postale");
            
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress1(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress2(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress3(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_PostalCode(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_StreetAddress(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_telephoneNumber(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCountry(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_CityOrProvince(), "Exists", cmpEqual, false);
            
            
            Get_WinAddSearchCriterion_BtnCancel().Click();
            Get_WinSearchCriteriaManager_BtnClose().Click();
            
//Étape11 
            
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11: Dans la barre de menu appuyer sur RECHERCHE / Critère de recherche / Ajouter un critère… / Définition: Liste des clients (Client réel) ayant Informatif --> la liste des options"); 
            Log.Message("Acceder au module client  "); 
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
            
            
            //Valider que le critere TEST_Téléphone n'est pas afficher dans la grille Client
            Log.Message("Valider que le critere TEST_Téléphone n'est pas afficher dans la grille Client");
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(), "Exists", cmpEqual, false);
          
            
            Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
            WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
            
            
            //Validation Les options ci-dessous ne sont pas affichées dans le menu déroulant du champ ‘Informatif’ :Adresse civique, Adresse courriel 1, NAS  Numero de Tel, Pays, Ville ou province, Code postale 
            Log.Message("Validation Les options ci-dessous ne sont pas affichées dans le menu déroulant du champ ‘Informatif’ :Adresse civique, Adresse courriel 1, NAS  Numero de Tel, Pays, Ville ou province, Code postale");
            
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress1(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress2(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress3(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_PostalCode(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_NAS(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_StreetAddress(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_telephoneNumber(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCountry(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_CityOrProvince(), "Exists", cmpEqual, false);
            
            Get_WinAddSearchCriterion_BtnCancel().Click();

//Étape12 
            
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12: Valider que le bord: 'Ville_province' ne s'affiché pas dans la grill et dans la liste des tableau"); 
            
            //Acceder au module Tableau de bord
            Get_ModulesBar_BtnDashboard().Click();
            Get_ModulesBar_BtnDashboard().WaitProperty("IsEnabled", true, 10000) 
            
            
            //lider que le bord: 'Ville_province' ne s'affiché pas
            Log.Message("lider que le bord: 'Ville_province' ne s'affiché pas ");
            aqObject.CheckProperty(Get_CroesusApp().FindChild(["ClrClassName", "ReportTitle"], ["GenericCriteriaBasedBoard", "ville_province12    Total:22"], 10), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_CroesusApp().FindChild(["ClrClassName", "PageTitle"], ["GenericCriteriaBasedBoard", "Ville_province"], 10), "Exists", cmpEqual, false);
}
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            
            //Mettre la pref PREF_MODEL_FREECASH_MODE = 2                   
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "NO", vServerRelations);
            Activate_Inactivate_Pref("KEYNEJ", "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);
            
            
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}


