//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1
//USEUNIT CR2141_6320_Mod_AssociateAssignedDiscOrNonDiscToInternalModelAndAMBA_Pref_Model_Discretio

/**
    Module               :  Modeles
    Description          :  Valider la configuration des comptes discrétionnaire pour le client VMD
                            
                            
    Auteur               :  Alhassane diallo
    Version de scriptage :	90.28-24
    Date                 :  29/09/2021
    
    Modifications par:  Philippe Maurice
    Date: 2022-01-10
    Version: 90.30-10, 90.29.2022.02-31 (modifs du 4 février 2022)
*/


function TCVE_7392_Configuration_DiscretionaryAccounts_ForVMD() {
         
      try {
            
            var logEtape1,logEtape2, logEtape3,logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10,logEtape11,logEtape12,logRetourEtatInitial;
  
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/MIB-4575","Lien du cas de test Jira");  
            Log.Link("https://jira.croesus.com/browse/TCVE-8681","Lien Xray");
            
                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_800049OB = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800049OB", language+client);
            var accountNo_800049RE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800049RE", language+client);
            var accountNo_800245GT = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800245GT", language+client);
            var accountNo_800245JW = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800245JW", language+client);
            
            var profils1   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "PROFILS1", language+client);
            var profils2   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "PROFILS2", language+client);
            var profils3   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "PROFILS3", language+client);
            var profils4   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "PROFILS4", language+client);
            var cible      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "CIBLE", language+client);
            var segment    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "SEGMENT", language+client);
            
            var quantityMFST    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "QUANTITY_MFST", language+client);
            var quantityMFST2   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "QUANTITY_MFST2", language+client);
            var securityMSFT    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "SECURITY_MSFT", language+client);
            var chCANADIANEQUI  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "CHCANADIANEQUI", language+client);
            var transaction     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "TRANSACTION", language+client);
            var qtyType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "QUANTITY_TYPE", language + client);
            var quantityMerged  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "MERGED_QUANTITY", language+client);
          
//Étape 1
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Utilisation du dump fourni.");
                                 
//Étape 2  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Identifier les comptes discrétionnaires et les valider (crochet présent dans la colonne 'Discrétionnaire'");  
                
            // * Se loguer à Croesus Client avec KEYNEJ
            Log.Message("Se connecter à croesus")
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            
            // *Identifier les comptes disc:*
            // * Aller dans le module Comptes puis appliquer le filtre rapide Discrétionnaire
            Log.Message("* Aller dans le module Comptes puis appliquer le filtre rapide Discrétionnaire")
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);

            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "4"], 10).Click();
            

            Log.Message("Ajouter la colonne discretionnaire (juste pour s'assurer que c'est présent)");             
        
            if (!(Get_AccountsGrid_ChDiscretionary().Exists)) {
               Get_AccountsGrid_ChMargin().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().Click();
               Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Discretionary().Click();
            }
             
            //Valider l'ajout de la colonnes Discretionnaire 
            Log.Message("Valider l'ajout de la colonnes Discretionnaire");
            aqObject.CheckProperty(Get_AccountsGrid_ChDiscretionary(), "IsVisible", cmpEqual, true);

            var accounts = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "Accounts_List", language+client);
            var listAccounts = accounts.split("|");
            var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            var count = grid.Items.Count;
            var found = false;
            
            // * Valider que la colonne Discrétionnaire affiche un crochet pour les comptes 800049-NA, 800049-OB, 800049-RE, 800245-GT, 800218-JW, 800245-JW, 800245-RE
            Log.Message("Valider que la colonne Discrétionnaire affiche un crochet pour les comptes " + listAccounts + ".");
           
            for (i=0; i<count; i++){
                found = false;
                
                for (j=0; j<listAccounts.length; j++) {
                    if (grid.Items.Item(i).DataItem.AccountNumber == listAccounts[j]){
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                        found = true;
                    }
                    if (found == true)
                        break;
                }
            }
            
            
//Étape 3
            Log.PopLogFolder();
            logEtape3= Log.AppendFolder("Étape 3: Déclencheurs des comptes discr/non discr");
            
            
            //*Déclencheurs des comptes discr/non discr:*
            // * Double cliquer sur le compte 800049-NA, onglet Profil
            Log.Message("Double cliquer sur le compte 800049-NA, onglet Profil");
            var accountNo_800049NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800049NA", language+client);
            
            Search_Account(accountNo_800049NA);
            Get_AccountsBar_BtnInfo().Click();
            Get_WinAccountInfo_TabProfile().Click();
            Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true);


            // * Retirer la valeur du champs profil KYC honoraires + OK
            Log.Message("* Retirer la valeur du champs profil KYC honoraires + OK");
            Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Defaut"]).WPFObject("ItemsControl", "", 2).WPFObject("ContentControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]")
            Get_WinDetailedInfo_BtnApply().Click();
            Get_WinDetailedInfo_BtnOK().Click();
            
            //TEMPORAIRE!!!
            Log.Link("https://jira.croesus.com/browse/SUP-6865","Lien du cas de test Jira");
            Log.Message("À cause du JIRA: SUP-6865.  Il faut faire ce workaround pour le moment.");
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            
            
            // * Valider que le crochet n'est pas affiché dans la colonne discrétionnaire du compte 800049-NA
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Delay(1000);
            
            Search_Account(accountNo_800049NA);
            
            grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            count = grid.Items.Count;
            found = false;
            
            for (i=0; i<count; i++){

                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo_800049NA) {
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                    found = true;
                }
                if (found == true)
                    break;
            }
            
//Étape 4              
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: La relation RELATIONDISCR affiche un crochet dans la colonne Discrétionnaire ");
            
            // * Sélectionner le compte disc 800245-RE puis mailler dans Relations
            var accountNo_800245RE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_800245RE", language+client);
            Search_Account(accountNo_800245RE);

            Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo_800245RE, 10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Relationships().Click();
            Get_MenuBar_Modules_Relationships_DragSelection().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
             
            // * Valider qu'un crochet est affiché dans la colonne Discrétionnaire pour la relation 'RELATIONDISCR'
            grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            aqObject.CheckProperty(grid.Items.Item(0).DataItem, "IsDiscretionary", cmpEqual, true);  
          
            
//Étape 5  
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Valider client 800245 affiché seulement"); 
            
            // * Aller dans le module Clients
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Clients().Click();

            // * Appliquer le filtre Discrétionnaire
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "4"], 10).Click();

            // * Valider que seule le client 800245 est affiché
            grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            count = grid.Items.Count;
            
            CheckEquals(count, 1, "Nombre d'éléments dans la grille");
            

//Étape 6:            
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: ORC-3213: Valider le statut des comptes lorsqu'on change la valeur de la sous-config ACCOUNT_TYPE_MNEMONIC");
            
            var sqlString1 = "update b_config set note='ACCOUNT_TYPE_MNEMONIC=ID3 \r\n ACCOUNT_TYPE_VALUES=GESCGM,GERGDF,TEST2' where cle='FD_DISC_ACCOUNT_TYPE'";
            var sqlString2 = "Insert into B_PROCOM values ('800049-OB', 69, 'A', 'GERGDF', '2021-11-29 00:00:00.000')";
            
            Execute_SQLQuery(sqlString1, vServerModeles);
            Execute_SQLQuery(sqlString2, vServerModeles);
                      
            RestartServices(vServerModeles);
            
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");

            
//Étape 7:
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Se loguer à l'application, aller dans le module Comptes et valider que seul le compte 800049-OB est discrétionnaire.");
            
            // Se loguer à l'application, aller dans le module Comptes et valider
            Log.Message("Se connecter à croesus")
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);

            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "4"], 10).Click();
            
            grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
            count = grid.Items.Count;
            
            Log.Message("Seul le compte " + accountNo_800049OB + " est discrétionnaire et devrait apparaître dans la grille.");
            CheckEquals(count, 1, "Nombre d'éléments dans la grille");
            
            var accountNo_800049OB = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "ACCOUNT_80049OB", language+client);
            
            // * Seul le compte 800049-OB est discrétionnaire   // * Les comptes , 800049-RE, 800245-GT, 800245-RE, 800245-JW, 800218-JW sont non discrétionnaires
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo_800049OB, 10).DataContext.DataItem, "IsDiscretionary", cmpEqual, true);
            

//Étape 8:
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Valider le statut des comptes lorsqu'on change la valeur de la sous-config ACCOUNT_TYPE_VALUES");           
            
            //*Valider le statut des comptes lorsqu'on change la valeur de la sous-config ACCOUNT_TYPE_VALUES:*
            var sqlString3 = "update b_config set note='ACCOUNT_TYPE_MNEMONIC=ID2 \r\n ACCOUNT_TYPE_VALUES=GESCGM,GESNEG,GERGDF' where cle='FD_DISC_ACCOUNT_TYPE'";
            Execute_SQLQuery(sqlString3, vServerModeles);
            RestartServices(vServerModeles);  //sudo service cfadm restart
            
            //Exécuter le plugin cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1
            ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");            
            

//Étape 9:
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Se loguer à l'application, aller dans le module Comptes et valider que les comptes 800049-RE, 800245-GT, 800245-RE sont discrétionnaires");          

            // Se loguer à l'application, aller dans le module Comptes et valider:
            Log.Message("Se connecter à croesus")
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);

            var accountsDisc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "Accounts_List_Discr", language+client);
            var listAccountsDisc = accountsDisc.split("|");
            var accountsNonDisc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE7392", "Accounts_List_NonDiscr", language+client);
            var listAccountsNonDisc = accountsNonDisc.split("|");
            
            // * Les comptes 800049-RE, 800245-GT, 800245-RE sont discrétionnaires
            Log.Message("Les comptes " + listAccountsDisc + " sont discrétionnaires");
            
            for (i=0; i<listAccountsDisc.length; i++) {
                Search_Account(listAccountsDisc[i]);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value", listAccountsDisc[i], 10).DataContext.DataItem, "IsDiscretionary", cmpEqual, true);
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                Delay(1000);
            }
            
            //Les comptes 800049-OB, 800245-JW, 800245-JW sont non discrétionnaires
            Log.Message("Les comptes " + listAccountsNonDisc + " sont non discrétionnaires");
            
            for (i=0; i<listAccountsNonDisc.length; i++) {
                Search_Account(listAccountsNonDisc[i]);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value", listAccountsNonDisc[i], 10).DataContext.DataItem, "IsDiscretionary", cmpEqual, false);
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                Delay(1000);
            }

      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
             //Exécuter la requête suivante pour rendre le compte discrétionnaire à l'état initial 
             Log.PopLogFolder();
             logEtape10 = Log.AppendFolder("Étape 10: Remettre la bd à son état initial");
             
//             Execute_SQLQuery("Update b_config set note='ACCOUNT_TYPE_MNEMONIC=ID2 /r/n ACCOUNT_TYPE_VALUES=GESCGM,GESNEG,GERGDF,TEST1,TEST2' where cle='FD_DISC_ACCOUNT_TYPE' AND firm_id=1", vServerModeles);
//             //Execute_SQLQuery("Delete from B_PROCOM where no_compte='800049-NA' and code=68", vServerModeles);
//             Execute_SQLQuery("Insert into B_PROCOM values ('800049-NA', 68, 'A', 'GESNEG', '2021-11-29 00:00:00.000')", vServerModeles);
//             Execute_SQLQuery("Delete from B_PROCOM where no_compte='800049-OB' and code=69", vServerModeles);
//             Execute_SQLQuery("Update b_compte set is_discretionary = 'Y' where no_compte = '800245-GT'", vServerModeles);
//             
//             ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");

             //Fermer le processus Croesus
             Terminate_CroesusProcess();
             
             //RestartServices(vServerModeles);

      }
}

 function DeleteAllOrdersInAccumulator()
{   
  
    Get_ModulesBar_BtnOrders().Click();
    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000); 
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){
    

      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }   
}



function AddProfileToAccount1(accountNo, profileValue) { 
  
            var GroupBoxDefaut = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "GroupBoxDefaut", language+client);
            var ProfileValue = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", language+"Long_6348", language+client);     
             
            Log.Message("------------ Ajout des profils ---------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            Search_Account(accountNo);
            Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo, 10).DblClick();
            
            //Acceder à l'onglet Profil
            Log.Message("----------- Acceder à l'onglet Profil -----------------");
            Get_WinDetailedInfo_TabProfile().Click();
            Get_WinInfo_TabProfile_ItemControl_TextBox().Keys(profileValue);
            Get_WinDetailedInfo_BtnApply().Click();
            Get_WinDetailedInfo_BtnOK().Click();
            

            
}
function RebalanceAccount(){
            
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
            Get_WinGenerateOrders_BtnGenerate().Click();
            if (Get_DlgConfirmation().Exists){  
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(2/2.9)),73);
            }          
 }


function Get_WinInfo_TabProfile_ItemControl_TextBox(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)}
