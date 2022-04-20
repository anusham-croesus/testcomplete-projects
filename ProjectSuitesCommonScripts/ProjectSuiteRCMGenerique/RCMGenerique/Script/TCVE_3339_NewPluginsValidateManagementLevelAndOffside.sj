//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/**
    Jira Xray   : TCVE-3557
    Description : RCM générique: Valider les nouveaux plugins, Niveau de gestion et Comptes offside
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : A.A
    Version: 90.21-21
**/

function TCVE_3339_NewPluginsValidateManagementLevelAndOffside()
{
            var logEtape1, logEtape2, logRetourEtatInitial;
            try {               
                Log.Link("https://jira.croesus.com/browse/TCVE-3339","Lien du Cas de test sur Jira Xray");
                Log.Link("https://jira.croesus.com/browse/TCVE-3557","Lien de la tâche sur Jira Xray");

                var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
  
                var Offside           = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_Offside", language+client);
                var managementLevel   = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_managementLevel", language+client);
                var balance           = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_Balance", language+client);
                var operatorEqual     = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_operatorEqual", language+client);
                var account           = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_account", language+client);
                var offsideAccounts   = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_offsideAccounts", language+client);    
           
                var clientNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_clientNumberFilter", language+client);
                var client800300       = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_client800300", language+client);
                var client800241       = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_client800241", language+client);
                var client800217       = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_client800217", language+client);
                var account800300NA    = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_account800300NA", language+client);
                var account800241GT    = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_account800241GT", language+client);
                var account800217RE    = ReadDataFromExcelByRowIDColumnID(filePath_RCMGenerique, "90.21-21", "TCVE_3339_account800217RE", language+client);

                var waitTime = 15000;
                var listOfColumnNames = [managementLevel, Offside];
        
        // Étape 0
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Étape 0: Rouler les cfLoaders se connacter avec KEYNEJ");

                ExecuteSSHCommandCFLoader("TCVE_3340", vServerRCMGenerique, "cfLoader -RCMManagementLevel", "aminea");
                ExecuteSSHCommandCFLoader("TCVE_3340", vServerRCMGenerique, "cfLoader -RCMPortfolioGenerator --Entities=ACCOUNT,CLIENT", "aminea");
              
                //Se connecter avec KEYNEJ
                Login(vServerRCMGenerique, userNameKEYNEJ, passwordKEYNEJ, language);

                //Accès au module Comptes et ajouter les 2 colonnes
                Get_ModulesBar_BtnAccounts().Click();
                Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, waitTime);
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        
                Log.Message("Restore default configuration for the columns.");
                Get_AccountsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
                //Ajouter les colonnes "Hors tolérance" et "Niveau de gestion"
                Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), Offside);
                Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), managementLevel);
        
                //Accès au module Clients
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, waitTime);
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        
                Log.Message("Restore default configuration for the columns.");
                Get_AccountsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
                //Ajouter les colonnes "Hors tolérance" et "Niveau de gestion"
                Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), Offside);
                Add_ColumnByLabel(Get_RelationshipsClientsAccountsGrid_ColumnHeader(balance), managementLevel);

        // Étape 1
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 2: Valider que les colonnes 'Hors Tolérance' et 'niveau de gestion' sont déplaçables, triables et exportables.");
        
                //Valider que la colonne 'niveau de gestion' est triable
                Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).Click();
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel), "SortStatus", cmpNotEqual, "NotSorted");
        
                //Valider que la colonne 'Hors tolérance' n'est pas triable
                Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside).Click();
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside), "SortStatus", cmpEqual, "NotSorted");       

        // Étape 2         
                //Valider que les colonnes sont deplaçables
                var ML_X = Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).ScreenLeft;
                var Y    = Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).ScreenTop;
        
                var ML_Width  = Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).Width;
                var ML_Heigh  = Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).Height;       
                var OFF_Width = Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside).Width;
        
                Sys.Desktop.MouseDown(MK_LBUTTON, ML_X + ML_Width/2, Y + ML_Heigh/2);
                Sys.Desktop.MouseUp(MK_LBUTTON, ML_X + ML_Width + OFF_Width, Y + ML_Heigh/2);
                Delay(3000)
                var OFF_X = Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside).ScreenLeft;
                Sys.Desktop.MouseDown(MK_LBUTTON, OFF_X + OFF_Width/2, Y + ML_Heigh/2);
                Sys.Desktop.MouseUp(MK_LBUTTON, OFF_X + ML_Width + OFF_Width, Y + ML_Heigh/2);

        // Étape 3        
                //Valider que les colonnes sont exportables dans Excel
                Get_RelationshipsClientsAccountsGrid_BtnExportToMSExcel().Click();       
                ValidateExcelFile(listOfColumnNames);
        
                //Valider que les colonnes sont exportables dans Excel
                Get_MenuBar_Edit().Click();
                Get_MenuBar_Edit_ExportToMsExcel().Click();      
                ValidateExcelFile(listOfColumnNames);
        
        // Étape 5 
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 5: Valider les données des colonnes 'Hors Tolérance' et 'niveau de gestion' pour le client 800217.");
        
                Search_Client(client800217);
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    if(item.DataItem.ClientNumber == client800217){
                        aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, "Client");
                        aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, true);
                        break;
                        }
                }
        
        // Étape 6               
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800217, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "CustomTextBox_5194", waitTime);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevels(7), "Text", cmpEqual, "Client");
                Get_WinDetailedInfo_BtnCancel().Click();
        
        // Étape 7
                Drag(Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800217, 10), Get_ModulesBar_BtnAccounts());
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, "Client");
                    aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, true);
                }
   
        // Étape 8
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", account800217RE, 10).Click();
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_ManagementLevel(), "Text", cmpEqual, "Client");
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value", account800217RE, 10).ClickR();
                Get_SubMenus().FindChild("Header", "Info", 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "CustomTextBox_5194", waitTime);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevels(10), "Text", cmpEqual, "Client");
                Get_WinDetailedInfo().Close();

        // Étape 9
        // Étape 10
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 10: Valider les données des colonnes 'Hors Tolérance' et 'niveau de gestion' pour le client 800241.");

                //Accès au module Client
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, waitTime);
       
                Search_Client(client800241);
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    if(item.DataItem.ClientNumber == client800241){
                        aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, account);
                        aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, true);
                        break;
                    }
                } 
        
        // Étape 11       
                Drag(Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800241, 10), Get_ModulesBar_BtnAccounts());
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpNotEqual, "Client");
                }
        
        // Étape 12
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", account800241GT, 10).Click();
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_ManagementLevel(), "Text", cmpEqual, account);
                Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value", account800241GT, 10).ClickR();
                Get_SubMenus().FindChild("Header", "Info", 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "CustomTextBox_5194", waitTime);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevels(10), "Text", cmpEqual, account);
                Get_WinDetailedInfo().Close();

        // Étape 13
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 13: Valider les données des colonnes 'Hors Tolérance' et 'niveau de gestion' pour le client 800300.");
        
                //Accès au module Client
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, waitTime);
        
                Search_Client(client800300);
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800300, 10).Click();
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    if(item.DataItem.ClientNumber == client800300){
                        aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, null);
                        aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, false);
                        break;
                        }
                } 
                Drag(Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800300, 10), Get_ModulesBar_BtnAccounts());
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, null);
                    aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, false);
                }
        
        // Étape 14
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 14: Modifier les valeurs des niveaux de risque pour le client 800300, rouler les pluging et valider les changements");

                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, waitTime);
        
                Search_Client(client800300);
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800300, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "CustomTextBox_5194", waitTime);
                Get_WinDetailedInfo_TabProfile().Click();
                Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskLow().Keys(50)
                Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskMed().Keys(10)
                Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskHigh().Keys(20) 
                Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo().Close();
       
                ExecuteSSHCommandCFLoader("TCVE_3339", vServerRCMGenerique, "cfLoader -RCMManagementLevel", "aminea");
                ExecuteSSHCommandCFLoader("TCVE_3339", vServerRCMGenerique, "cfLoader -RCMPortfolioGenerator --Entities=ACCOUNT,CLIENT", "aminea"); 
        
                Search_Client(client800300);
                Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800300, 10).Click();
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    if(item.DataItem.ClientNumber == client800300){
                        aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, "Client");
                        aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, true);
                        break;
                    }
                } 
                Drag(Get_RelationshipsClientsAccountsGrid().FindChild("DisplayText", client800300, 10), Get_ModulesBar_BtnAccounts());
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0; i<count; i++){
                    var item = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i);
                    aqObject.CheckProperty(item.DataItem, "ManagementLevelDescription", cmpEqual, "Client");
                    aqObject.CheckProperty(item.DataItem, "IsOffsideForRCM", cmpEqual, true);
                }
    
        //Étape 16  
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 16: Valider les données dans le module RQS.");
      
                Get_Toolbar_BtnRQS().Click();
                Get_WinRQS().Parent.Maximize()
                Get_WinRQS_TabReports().Click();
                SelectComboBoxItem(Get_WinRQS_TabReports_CmbReportType(), offsideAccounts);
                Get_WinRQS_TabReports_BtnDisplayReport().Click();
      
                //Appliquer le filtre 'AClient Number = 800300'
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(clientNumberFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operatorEqual);               
                Get_WinCreateFilter_TxtValue().SetText(client800300);
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
  
                var nbItems = Get_WinRQS_TabReports_DgvOffsideAccounts().Items.Count
                Log.Message("nombre d'item: "+nbItems);
                
                if (nbItems == 1)
                     Log.Checkpoint("nombre d'item comme attendu: "+nbItems);
                else 
                     Log.Error("nombre d'item non attendu: "+nbItems);   
                     
                Get_WinRQS().Close()


        //Étape 18
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 18: Enlever les colonnes 'Hors Tolérance' et 'niveau de gestion' des modules Comptes et Clients.");

                //Accès au module Client
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, waitTime); 
        
                Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).ClickR();
                Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();

                Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside).ClickR();
                Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();

        //Étape 19        
                //Accès au module Comptes
                Get_ModulesBar_BtnAccounts().Click();
                Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, waitTime);
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        
                Get_RelationshipsClientsAccountsGrid_ColumnHeader(managementLevel).ClickR();
                Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();

                Get_RelationshipsClientsAccountsGrid_ColumnHeader(Offside).ClickR();
                Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();        

                //Fermer Croesus
                Close_Croesus_X();
            }
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {       
                //Fermer le processus Croesus
                Terminate_CroesusProcess();
            }
}

function ValidateExcelFile(listOfColumnNames){
              
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));    
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
              
              var attr = Log.CreateNewAttributes();
              attr.Bold = true;
              
              Log.Message("Valider que la colonne 'niveau de gestion' et 'Hors tolérance' sont bien exportées dans excel")
              Delay(4000);
              //Valider que la colonne 'niveau de gestion' et 'Hors tolérance' sont bien exportées dans excel
              line = myFile.ReadLine();
              // Split at each space character.
              var textArr = line.split("	");          
              if(aqString.Unquote(textArr[6]) == listOfColumnNames[0])
                  Log.Checkpoint(" '"+ listOfColumnNames[0] + "'  est exporté correctement dans le fichier Excel", "", pmNormal, attr);
              else 
                  Log.Error(" '"+ listOfColumnNames[0] + "'  n'est pas exporté vers le fichier Excel", "", pmNormal, attr);
              
              if(aqString.Unquote(textArr[7]) == listOfColumnNames[1])
                  Log.Checkpoint(" '"+ listOfColumnNames[1] + "'  est exporté correctement dans le fichier Excel", "", pmNormal, attr);
              else 
                  Log.Error(" '"+ listOfColumnNames[1] + "'  n'est pas exporté vers le fichier Excel", "", pmNormal, attr);

              //Fermer le fichier excel  
              while(Sys.waitProcess("EXCEL").Exists){
                  Sys.Process("EXCEL").Terminate();
              }    
}