//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6458
    Description          :  2 : Niveau Compte
                            La notion de compte discrétionnaire/non discrétionnaire est existante.
                            Les comptes discrétionnaires ou non discrétionnaires peuvent être rééquilibrés.
 
                            **Basé seulement sur comptes ouverts selon PREF_CLOSED_ACCOUNTS_COND.  Les comptes zombifiés sont aussi considérés 
                            comme étant fermés(code de CP de compte débutant par '_'). 
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  17/05/2019
    
*/


function CR2070_CR2141_6458_Mod_IdentificationOfDiscNotDiscAccounts() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6458","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo1_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo6_6348", language+client);
            var accountNo2_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo8_6348", language+client);
            var clientNo_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6458", language+client);
            var relationName_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var accountNo3_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo7_6348", language+client);
            var accountNo4_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6348", language+client);
            var accountNo5_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6348", language+client);
            var accountNo6_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo3_6348", language+client);
            var accountNo7_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo4_6348", language+client);
            var accountNo8_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo5_6348", language+client);
            
            var discretionaryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discretionaryLabel", language+client);
            var actifCriterion_6458 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "actifCriterion_6458", language+client);
                     
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille comptes
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille comptes ------------- ");
            Add_ColumnByLabel(Get_AccountsGrid_ChTotalValue(), discretionaryLabel);
            
            //Vérifier qu il ya pas de crochet pour le compte 800241-SF
            Log.Message("-------- Vérifier qu il n ya pas de crochet pour le compte "+accountNo1_6458+" ---------");
            Search_Account(accountNo1_6458);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6458){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                }
            }
            
            //Vérifier qu il n'ya pas de crochet pour le compte 800217-SF
            Log.Message("-------- Vérifier qu il n ya pas de crochet pour le compte "+accountNo2_6458+" ---------");
            Search_Account(accountNo2_6458);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6458){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                } 
            }
           
            //Aller dans le module clients
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille clients
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille clients ------------- ");
            Add_ColumnByLabel(Get_ClientsGrid_ChTotalValue(), discretionaryLabel);
            Search_Client(clientNo_6458);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
                if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6458){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                } 
            }
            
            //Aller dans le module relations
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille relations
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille relations ------------- ");
            Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(), discretionaryLabel);
            SearchRelationshipByName(relationName_6458);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
                if (grid.Items.Item(i).DataItem.ShortName == relationName_6458){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                } 
            }
            
            //Aller dans le module comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            //Ajouter ou afficher un critère actif
            Log.Message("-------- Ajouter ou afficher un critère actif ("+actifCriterion_6458+")-----------");
            Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
            Get_WinAddSearchCriterion_TxtName().Clear();
            Get_WinAddSearchCriterion_TxtName().Keys(actifCriterion_6458);
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemDiscretionary().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
            Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
            
            //Validation des comptes discrétionnaires affichés
            Log.Message("---------- Validation des comptes discrétionnaires affichés ------------");
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 7);
            for (i=0; i<count; i++){
                /*if (grid.Items.Item(i).DataItem.AccountNumber == "800241-FS")   
                  Log.Checkpoint("Le compte 800241-FS existe dans la grille après application du critère actif discrétionnaire");
                else*/ if (grid.Items.Item(i).DataItem.AccountNumber == accountNo7_6458)   
                         Log.Checkpoint("Le compte "+accountNo7_6458+" existe dans la grille après application du critère actif discrétionnaire");
                      else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo8_6458)   
                              Log.Checkpoint("Le compte "+accountNo8_6458+" existe dans la grille après application du critère actif discrétionnaire");
                           else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6458)   
                                   Log.Checkpoint("Le compte "+accountNo1_6458+" existe dans la grille après application du critère actif discrétionnaire");   
                                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6458)   
                                        Log.Checkpoint("Le compte "+accountNo3_6458+" existe dans la grille après application du critère actif discrétionnaire");   
                                     else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo6_6458)   
                                            Log.Checkpoint("Le compte "+accountNo6_6458+" existe dans la grille après application du critère actif discrétionnaire");   
                                          else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo4_6458)   
                                                 Log.Checkpoint("Le compte "+accountNo4_6458+" existe dans la grille après application du critère actif discrétionnaire");
                                               else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo5_6458)   
                                                      Log.Checkpoint("Le compte "+accountNo5_6458+" existe dans la grille après application du critère actif discrétionnaire"); 
                                                    else
                                                      Log.Error("L'un des comptes précédents n'est pas affiché");
                         
            }
            
            //Actualiser pour enlever les crochets
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().click();
     
              
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Supprimer le critère actif créé
            Log.Message("----------- Supprimer le critère actif créé -------------");
            Get_Toolbar_BtnManageSearchCriteria().Click();
            WaitObject(Get_CroesusApp(),"Uid","ManagerWindow_efa9");
            Sys.Keys("C");
            Get_WinQuickSearch_TxtSearch().set_Text(actifCriterion_6458);
            Get_WinQuickSearch_BtnOK().Click();
            Get_WinSearchCriteriaManager().Find("Value", actifCriterion_6458, 10).Click();
            Get_WinSearchCriteriaManager_BtnDelete().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnDelete().Click();
            Get_WinSearchCriteriaManager_BtnClose().Click();
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}


