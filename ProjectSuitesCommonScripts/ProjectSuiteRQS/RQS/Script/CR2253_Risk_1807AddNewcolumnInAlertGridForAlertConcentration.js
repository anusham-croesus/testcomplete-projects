//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Ajouter une colonne dans la grille des alerte pour l'alerte de concentration
      https://jira.croesus.com/browse/RISK-1807
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.17-47 */ 

function CR2253_Risk_1807AddNewcolumnInAlertGridForAlertConcentration(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var waitTime   = 3000;
            
//            Log.Warning("Ce script roule sur la version 90.17 et plus");
      try {
             
           var acountNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_AcountNumberFilter", language + client);
           var testFilter         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_TestFilter", language + client);
           
           var amongOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_AmongOperator", language + client);
           var equalOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_EqualOperator", language + client);
           
           var Concentration   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_Concentration", language + client);
           var account800266RE = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_Account800266RE", language + client);
           
           var PositionMarketValue   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_PositionMarketValue", language + client);
           var value1527 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_1807_value1527", language + client);
           
           var attr = Log.CreateNewAttributes();
           attr.Bold = true;
           
              Log.PopLogFolder();
              logEtape1 = Log.AppendFolder("Étape 1 et 2: se loguer ouvrir la RQS aller à l'onglet Alerts", "", pmNormal, attr);  
              //Se connecter
              Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
              Get_WinRQS().Parent.Maximize();
          
              // Attendre l'onglet 'Alerts' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
              Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)          
          
              Get_WinRQS_TabAlerts().Click();
              Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
             
              //Mettre la configuration par défaut des colonnes
              Get_WinRQS_TabAlerts_DgvAlerts_ChTest().ClickR();
              WaitObject(Get_SubMenus(), "Uid", "MenuItem_c549", waitTime)
              Get_WinRQS_ContextualMenu_DefaultConfiguration().Click();

              //Valider que la colonne "Position Market Value (%)" n'est pas visible
              if(Get_WinRQS_TabAlert_ColumnHeader(PositionMarketValue).Exists)
                    Log.Error("la colonne 'Position market value (%)' est visible contrairement à ce qui est attendu")
                else{ 
                    Log.Checkpoint("la colonne 'Position market value (%)' n'est pas visible comme attendu")
                            
                      //Ajouter la colonne "Position Market Value (%)"
                      Get_WinRQS_TabAlerts_DgvAlerts_ChTest().ClickR();
                      WaitObject(Get_SubMenus(), "Uid", "MenuItem_c549", waitTime)
                      Get_WinRQS_ContextualMenu_AddColumn().Click();//OpenMenu();
                      Get_WinRQS_ContextualMenu_PositionMarketValue().Click();
              }
              Log.PopLogFolder();
              logEtape1 = Log.AppendFolder("Étape 3 et 4: Appliquer les filtres et export vers Excel", "", pmNormal, attr);
              //Appliquer le filtre 'Test among concentration'
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(testFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), amongOperator);               
                Get_WinCreateFilter_DgvValue().FindChild("Value", Concentration, 10).Click();
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
                
                //Appliquer le filtre 'Account Number = 800266-RE'
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(acountNumberFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);               
                Get_WinCreateFilter_TxtValue().SetText(account800266RE);
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
                
                var value = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.MarketValuePercent
                Log.Message(value)
                var strValue = aqConvert.FloatToStr(roundDecimal(value))        
                Log.Message(strValue);
                if (language == "french")
                       strValue = aqString.Replace(strValue, ".", ",");
                       
                CheckEquals(strValue, value1527, "Position market value (%) for the account 800266-RE ")
                aqObject.CheckProperty(Get_WinRQSDetailsGrid_LblPositionMarketValue(), "text", cmpEqual, value1527);
                
                //Fermer le filtre 'Account Number = 800266-RE'        
                Get_WinRQS_TabAlerts_ToggleFilter(2).WPFObject("Button", "", 2).Click(); 
            
                //Valider dans l'export vers Excel
                Log.Message("Étapes 4: Valider dans l'export vers Excel");
                Get_WinRQS_TabAlerts_BtnExportToExcel().Click();
                ValidateExcelFile(PositionMarketValue);
                
                //Fermer le filtre 'Test among concentration'        
                Get_WinRQS_TabAlerts_ToggleFilter(1).WPFObject("Button", "", 2).Click();

/*-------------------------------------------------------- TCVE-3163 Validation du crash dans la fenêtre Activities ----------------------------

                https://jira.croesus.com/browse/TCVE-3163
            
                Automatisation du Jira  ORC-630
                
                Lien: https://jira.croesus.com/browse/ORC-630
                
                Description: Dans l'arborescence de la fenêtre Activities Clients de RQS 
                             en  cliquant sur le compte sous-jacent l'application crash  (Cas CIBC).
                             
   --------------------------------------------------------------------------------------------------------------------------------------------*/
                var client800053       = "800053";
                var clientNumberFilter = "Client number";
                var account800053JW    = "800053-JW";
                
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Étape 5: Valider le Jira ORC-630", "", pmNormal, attr);
                //Appliquer le filtre 'AClient Number = 800053'
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(clientNumberFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);               
                Get_WinCreateFilter_TxtValue().SetText(client800053);
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
                
                Get_WinRQS_TabAlerts_AlertsControl().FindChild("Text", client800053, 10).Click();
                Get_WinRQS_TabAlerts_BtnClientActivities().Click();
                
                //Cliquer sur le + s'il n'est ouvert
                if (!Get_WinActivities_GrpActivities_GrpCurrentContext().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1], 10).IsExpanded)
                     Get_WinActivities_GrpActivities_GrpCurrentContext().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1], 10).Click(5,5);
                Delay(500)
                Get_WinActivities_GrpActivities_GrpCurrentContext().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "Value"],["CellValuePresenter", account800053JW], 10).Click();
            
                //Detecter un crash
                Sys.Refresh();
                var processInstance = Sys.WaitProcess("CroesusClient", 500);
                processInstance.Refresh();
                if (!processInstance.Exists)
                    Log.error("Croesus Process crushed");  
                else{ 
                    Log.Checkpoint("No crash detected");
                    Get_WinActivities().Close();
                    }
                //Fermer RQS  
                Get_WinRQS().Close();                         
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
            }
} 
  
function ValidateExcelFile(columnHeader){
              
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));    
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
              
              var attr = Log.CreateNewAttributes();
              attr.Bold = true;
              
              Delay(40000);
              //Valider que la colonne 'Position Market Value (%)' est bien exportée dans excel
              line = myFile.ReadLine();
              // Split at each space character.
              var textArr = line.split("	");          
              if(aqString.Unquote(textArr[5]) == columnHeader)
                  Log.Checkpoint(" '"+ columnHeader + "'  est exporté correctement dans le fichier Excel", "", pmNormal, attr);
              else 
                  Log.Error(" '"+ columnHeader + "'  n'est pas exporté vers le fichier Excel", "", pmNormal, attr);
              
              //Fermer le fichier excel  
              while(Sys.waitProcess("EXCEL").Exists){
                  Sys.Process("EXCEL").Terminate();
              }    
}