
//USEUNIT TCVE_902_Template_Type_WorkTeam

function CR2431_TCVE_6272_DumpPreparation(){
  
    try{   
             Log.Link("https://jira.croesus.com/browse/TCVE-6272", "Lien du récit");  

            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var unifiedManagedAccountTemplates = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_unifiedManagedAccountTemplates", language+client);
            var canadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_canadianEquity", language+client);
            var mediumTerm     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_mediumTerm",     language+client);
            
            var account800003NA     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_account800003NA",     language+client);
            var account800066FS     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_account800066FS",     language+client);
            var account800066GT     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_account800066GT",     language+client);
            
            var client800056           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_client800056",     language+client);
            var relation_TESTCH_CR1869 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_relation_TESTCH_CR1869",     language+client);
            var client800056           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_client800056",     language+client);
            
            var modelAmericanEqui = "CH AMERICAN EQUI";
            var modelCanadianEqui = "CH CANADIAN EQUI";
           
            var model_TOL_BLOQ_Comp    = "TOL BLOQ COMP";
            var model_TOL_GESTI_RETRAI = "TOL GESTI RETRAI";
            var model_TOL_MON_MIN_POSI = "TOL MON MIN POSI";
            

            var levelFirm = "Firm";
           
            //Étape 1: Activation de Prefs
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Activation de Prefs");
            Activate_Pref_Sleeve("UNI00");
            Activate_Pref_Sleeve("KEYNEJ");
      
            //Étape 2: Création de Gabarits
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Login avec KEYNEJ");
            //Se connecter avec KEYNEJ
            Login(vServerSleeves, userNameKEYNEJ, passwordKEYNEJ, language);
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Création de Gabarits");
            //Ovrir la fenêtre de Gabarits de comptes à gestion unifiée
            OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
            
            Log.Message("Créer le gabarit Tempale1 Access: Firme");
            Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");

            Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys("Template1");
            Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
            Get_SubMenus().FindChild("DataContext.Level", levelFirm, 10).Click();
        
            Log.Message("Cliquer sur le bouton 'Ajouter' et créer 1er segment: Sleeve1")
            Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();        
            Log.Message("Sleeve1: associer le modèle American Equi et mettre cible:49, max: 51, min:49");
            AddEditSleeveWinSleevesManager("Sleeve1", "", 50, 49, 51, modelAmericanEqui);
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
            Log.Message("Cliquer sur le bouton 'Ajouter' et créer 2eme segment: Sleeve2")
            Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
            Log.Message("Sleeve2: associer le modèle Canadian Equi et mettre cible:50, max: 49, min:10");
            AddEditSleeveWinSleevesManager("Sleeve2", "", 50, 10, 50, modelCanadianEqui);
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
            //Sauvegader le Gabarit
            Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
       
            //Créer le gabarit Tempale2 
            Log.Message("Créer le gabarit Tempale2 Access: Firme");
            Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys("Template2");
            Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
            Get_SubMenus().FindChild("DataContext.Level", levelFirm, 10).Click();
        
            Log.Message("Cliquer sur le bouton 'Ajouter' et créer 1er segment: Sleeve1")
            Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
            Log.Message("Sleeve1: associer le modèle American Equi et mettre cible:100, max: 100, min: 100");
            AddEditSleeveWinSleevesManager("Sleeve1", mediumTerm, 100, 100, 100, modelAmericanEqui);
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
            //Sauvegader le Gabarit
            Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
            
            //Fermer la fenêtre de gestion unifiée
            Get_WinUnifiedManagedAccountTemplates().Close();
            
            //Fermer la fenêtre de config
            Get_WinConfigurations().Close();
           
            //Étape 3: Mailler le compte 800003-NA dans portefeuille
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Mailler le compte 800003-NA et créer des Sleeves");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            Search_Account(account800003NA);
            Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Text", account800003NA, 10), Get_ModulesBar_BtnPortfolio());
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000);
            Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
			WaitObject(Get_PortfolioPlugin(), ["ClrClassName", "WPFControlOrdinalNo"], ["PortfolioTabItem", 1]);																									
            
            //Selectionner tous les actifs
            Get_Portfolio_Tab(1).Click();
            Get_Portfolio_Tab(1).Keys("^a");
            
            //faire un right-click ensuite choisir créer des segements
            Get_PortfolioPlugin().ClickR();
																	 
            Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();			WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");															   
            
            //Choisir "Actions canadiennes" --> Modifier
            Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value", canadianEquity, 10).Click();
            Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 30000);
			Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["SleeveWindow", 1, true]);
			
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinEditSleeve().Exists){						  
						  
              Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
			  Delay(1500);
              numberOftries++;
            };
            
            
            Log.Message("Sleeve1: Modifer les valeurs avec cible:20, max: 25, min: 15");
            AddEditSleeveWinSleevesManager("", "", 20, 15, 25, "");
            
            //Sauvegarder les modifications
            Get_WinManagerSleeves_BtnSave().Click();
            
            //Étape 4: Associer le compte 800066-FS au un modèle 'TOL BLOQ COMP';
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 4: Associer le compte 800066-FS au un modèle 'TOL BLOQ COMP");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            AssociateAccountWithModel(model_TOL_BLOQ_Comp, account800066FS)
            
            
            //Étape 5: Associer le compte 800066-GT à la relation 'TESTCH-CR1869'
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 5: Associer le compte 800066-GT à la relation 'TESTCH-CR1869'");
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Search_Account(account800066GT);
            Get_RelationshipsClientsAccountsGrid().Find("Value", account800066GT, 10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
            Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
   
   
            Get_WinPickerWindow_DgvElements().Keys("F"); 
            WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
            Get_WinQuickSearch_TxtSearch().Clear();
            Get_WinQuickSearch_TxtSearch().Keys(relation_TESTCH_CR1869);
          
            Get_WinQuickSearch_BtnOK().Click() 
            Get_WinPickerWindow_BtnOK().Click();  
            Get_WinAssignToARelationship_BtnYes().Click();
            
            //Associer la relation TESTCH-CR1869 au un modèle 'TOL GESTI RETRAI'
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            AssociateRelationshipWithModel(model_TOL_GESTI_RETRAI, relation_TESTCH_CR1869);
            
            //Étape 6: Associer le client 800056 au modèle 'TOL MON MIN POSI'
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 6: Associer le client 800056 au modèle 'TOL MON MIN POSI'");
            AssociateClientWithModel(model_TOL_MON_MIN_POSI, client800056);
            
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
       }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      }         
}

function Activate_Pref_Sleeve(user){
  
          Activate_Inactivate_Pref(user,"PREF_ALLOW_SLEEVE_NONDISC",           "YES", vServerSleeves);  
          Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES",                 "YES", vServerSleeves);  
          Activate_Inactivate_Pref(user,"PREF_SLEEVES_ALLOW_TEMPLATE_CREATION","YES", vServerSleeves);  
          Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_CREATE",            "YES", vServerSleeves);  
          Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_DELETE",            "YES", vServerSleeves); 
          Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_SYNC",              "YES", vServerSleeves);
          Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_TRADE",             "YES", vServerSleeves);   
          Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_VIEW",              "YES", vServerSleeves); 
}

