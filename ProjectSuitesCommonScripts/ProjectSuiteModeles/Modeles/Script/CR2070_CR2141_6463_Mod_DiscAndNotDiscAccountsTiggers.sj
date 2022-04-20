//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6463 
    Description          : :Déclencheurs des comptes discrétionnaire/non discrétionnaires (2070).
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  21/05/2019
    
*/


function CR2070_CR2141_6463_Mod_DiscAndNotDiscAccountsTiggers() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6463","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var discretionaryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discretionaryLabel", language+client);
            var accountNo1_6463 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo6_6348", language+client);
            var accountNo2_6463 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6348", language+client);
            var relationshipName1_6463 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var clientNo_6463 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo1_6349", language+client);
            var relationshipName2_6463 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName2_6348", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
            
            //Ajouter la colonne "Discrétionnaire" dans la grille comptes
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille comptes ------------- ");
            Add_ColumnByLabel(Get_AccountsGrid_ChTotalValue(), discretionaryLabel);
            
            setProfileToBlanc(accountNo1_6463);
            setProfileToBlanc(accountNo2_6463);
            
            //Valider qu'il n ya pas de crochet sous la colonne Discrétionnaire pour les 2 comptes
            Search_Account(accountNo1_6463);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                }
            }
            Search_Account(accountNo2_6463);
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                }
            }
            
            //Mailler le compte 800241-SF vers Relation
            Log.Message("--------- Mailler le compte ("+accountNo1_6463+") vers Relation --------------");
            Search_Account(accountNo1_6463);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo1_6463,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Relationships().Click();
            Get_MenuBar_Modules_Relationships_DragSelection().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille Relations
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille Relations ------------- ");
            Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(), discretionaryLabel);
            
            //Valider qu'il n ya pas de crochet sous la colonne Discrétionnaire pour la relation D--TEST8
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.ShortName == relationshipName1_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                }
            }
            
            //Aller dans module clients et selectionner le client 800044
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
            Search_Client(clientNo_6463);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille Relations
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille clients ------------- ");
            Add_ColumnByLabel(Get_ClientsGrid_ChTotalValue(), discretionaryLabel);
            
            //Valider qu'il n ya pas de crochet sous la colonne Discrétionnaire pour la relation D--TEST8
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                }
            }
            
            //Exécuter les requêtes SQL
            Log.Message("-------- Exécuter des requêtes SQL --------------");
            Execute_SQLQuery("update b_compte set date_close = '2010.01.23' where no_compte = '800044-SF'", vServerModeles);
            Execute_SQLQuery("update b_compte set date_close = '2010.01.23' where no_compte = '800247-NA'", vServerModeles);
            
            //Exécuter le Plugin du CR2070
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            //Aller dans le module Relations
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000); 
            SearchRelationshipByName(relationshipName2_6463);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille Relations
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille Relations ------------- ");
            Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(), discretionaryLabel);
            
            //Valider qu'il ya de crochet sous la colonne Discrétionnaire pour la relation D--TEST7
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.ShortName == relationshipName2_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                }
            }
            
            //Aller dans module clients et selectionner le client 800044
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
            Search_Client(clientNo_6463);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille Relations
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille clients ------------- ");
            Add_ColumnByLabel(Get_ClientsGrid_ChTotalValue(), discretionaryLabel);
            
            //Valider qu'il n ya pas de crochet sous la colonne Discrétionnaire pour la relation D--TEST8
            //var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6463){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                }
            }
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Exécuter les requêtes SQL pour retourner à l'état initial
            Log.Message("-------- Exécuter des requêtes SQL --------------");
            Execute_SQLQuery("update b_compte set date_close = null where no_compte = '800044-SF'", vServerModeles);
            Execute_SQLQuery("update b_compte set date_close = null where no_compte = '800247-NA'", vServerModeles);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

function setProfileToBlanc(accountNo){
        var GroupBoxDefaut = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "GroupBoxDefaut", language+client);
        //Aller dans le module compte et électionner 800241-SF
        Log.Message("------- Aller au module comptes et accéder à info du compte No "+accountNo+" --------");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
        Search_Account(accountNo);
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo, 10).DblClick();
            
        //Acceder à l'onglet Profil
        Log.Message("----------- Acceder à l'onglet Profil et enlever le contenu du profil KYC-TYPE-honoraires-----------------");
        Get_WinDetailedInfo_TabProfile().Click();
            
        Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]");
        Get_WinDetailedInfo_BtnApply().Click();
        Get_WinDetailedInfo_BtnOK().Click();
}
