//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**
    Description :
                  1.mailler un compte de VT > 0 vers portefeuille
                  2.cliquer sur Simulation
                  3.cliquer sur Sauvergarder
                  4.cliquer sur Sauvegarde détaillée en laissant Nouveau compte fictif coché 
                  5.sauvegardé avec un nouveau nom abrégé(commenÇant par *)
                  6.fermer l`application puis le réouvrir 
                  7.du module client, sélectionner le client fictif créé
                  8.client droit sur sa racine
                  9.sélectionner un client réel
                  10.clic droit sur une racine du client réel sélectionné précédemment
                  11.Associer--->Relation

                  Résultat attendu : les options suivantes sont disponbles
                  -Créer une relation Famille-Firme
                  -Associer à une relation Famille-Firme.
                   
    Auteur : Sana Ayaz
*/
function CR1793_BNC_1871_Cli_DisponiAjoutrelatioFamillFirm()
{
    try {
      
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
      
        //Les variables
          var Account800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800300NA", language+client); 
          var NameClienFictBNC_1871=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameClienFictBNC_1871", language+client);
          var NAMECLIENTFICTIBNC_1871=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NAMECLIENTFICTIBNC_1871", language+client);
          var rootsBNC_1871= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "rootsBNC_1871", language+client);
          var Client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Client300001", language+client);
          var CreateFamilyFirmRelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "CreateFamilyFirmRelationshipBNC_1871", language+client);
          var JoinToAFamilyFirmRelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "JoinToAFamilyFirmRelationshipBNC_1871", language+client);
          var AssignToAnExistingModelBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "AssignToAnExistingModelBNC_1871", language+client);
          var RelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "RelationshipBNC_1871", language+client);      
        
      
         Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        
         Get_ModulesBar_BtnAccounts().Click();
        //Mailler un compte de VT > 0 vers portefeuille 800300-NA
         Search_Account(Account800300NA);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800300NA, 10).Click();
        //Mailler le compte 800300-NA vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          // 2.cliquer sur Simulation
          Get_PortfolioBar_BtnWhatIf().Click();
          //3.cliquer sur Sauvergarder
          Get_PortfolioBar_BtnSave().Click();
          //4.cliquer sur Sauvegarde détaillée en laissant Nouveau compte fictif coché 
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().set_IsChecked(true);
          Get_WinWhatIfSave_BtnDetailedSave().Click();
         //5.sauvegardé avec un nouveau nom abrégé(commenÇant par *)
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(NameClienFictBNC_1871);
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(NameClienFictBNC_1871);
         Get_WinDetailedInfo_BtnOK().Click();
         Get_DlgInformation().Close();
         // 6.fermer l`application puis le réouvrir 
         Get_MainWindow().SetFocus();
         Close_Croesus_MenuBar();
         
       // 7.du module client, sélectionner le client fictif créé
         Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
         Get_MainWindow().Maximize(); 
         Get_ModulesBar_BtnClients().Click();
         
    
         Search_Client(NameClienFictBNC_1871);
         
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NAMECLIENTFICTIBNC_1871, 10).Click();
         //8.client droit sur sa racine
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NAMECLIENTFICTIBNC_1871,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NAMECLIENTFICTIBNC_1871,10).ClickR();
         
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         
         //Les points de vérifications l'option :Associer à un modèle existant... est visible mais elle est grisée
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "Enabled", cmpEqual, false);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "IsVisible", cmpEqual, true);
         Log.Message("Cette différence a été déjà envoyée à Mamoudou, on n’a pas reçue la réponse")
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "WPFControlText", cmpEqual, AssignToAnExistingModelBNC_1871);  //EM: le datapool a été modifié apres la validation de Karima - avant : "Associer à un modèle existant..."      

         
        //9.sélectionner un client réel (300001)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client300001, 10).Click();
        
        
        //10.clic droit sur une racine du client réel sélectionné précédemment
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",Client300001,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",Client300001,10).ClickR();
        
        //11.Associer--->Relation
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         Log.Message("BNC-2042")
         // Les points de vérification que les deux options RelationShip et Assign to an existing model  sont disponibles
        // aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship(), "Enabled", cmpEqual, true);  //Selon BNC-2042
        // aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship(), "IsVisible", cmpEqual, true); //Selon BNC-2042
        // aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship(), "WPFControlText", cmpEqual, RelationshipBNC_1871); // BNC-2042  
          
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "IsVisible", cmpEqual, true);
         //aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "WPFControlText", cmpEqual, AssignToAnExistingModelBNC_1871); //Selon BNC-2042

        // Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click()  //Selon BNC-2042
         
        /*Résultat attendu : les options suivantes sont disponbles
                  -Créer une relation Famille-Firme
                  -Associer à une relation Famille-Firme.*/
                  
       //points de vérification : les options suivantedisponibles :-Créer une relation Famille-Firme -Associer à une relation Famille-Firme

         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship(), "IsVisible", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship(), "WPFControlText", cmpEqual, CreateFamilyFirmRelationshipBNC_1871); //EM: le datapool a été modifié - avant : "Créer une relation Famille - Firme"     
                   
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship(), "IsVisible", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship(), "WPFControlText", cmpEqual, JoinToAFamilyFirmRelationshipBNC_1871); //EM: le datapool a été modifié - avant : "Associer à une relation Famille - Firme"     
                
         
         Get_MainWindow().SetFocus();
         Close_Croesus_AltF4();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize(); 
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NAMECLIENTFICTIBNC_1871);
        DeleteClient(NAMECLIENTFICTIBNC_1871);
         Terminate_CroesusProcess();
        
    }
}
