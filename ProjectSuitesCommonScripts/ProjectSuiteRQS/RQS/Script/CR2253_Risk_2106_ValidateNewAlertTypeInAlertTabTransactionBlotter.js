//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Valider l'ajout le nouveau type Alerte dans l'onglet alertes,TransactionBlotter, ExportExcel, Query Log
      https://jira.croesus.com/browse/RISK-2106
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.17-42 */ 

function CR2253_Risk_2106_ValidateNewAlertTypeInAlertTabTransactionBlotter(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime   = 5000;
            
      try {
             
               var transactionBlotterDateFrom = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_transactionBlotterDateFrom", language + client);
               var account800011NA            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_account800011NA", language + client);
           
               var amongOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_amongOperator", language + client);
               var equalOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_equalOperator", language + client);
               var testFilter    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_testFilter", language + client);
               var proAccountTrading   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_proAccountTrading", language + client);
               var accountNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_accountNumberFilter", language + client);
               var anythingButClosed   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2106_anythingButClosed", language + client);
               
               var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y");
               var attr = Log.CreateNewAttributes();
               attr.Bold = true;
          
                //Se connecter
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
                // Attendre le boutton RQS présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
                Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
                Get_Toolbar_BtnRQS().Click();
                Get_WinRQS().Parent.Maximize();
          
                // Attendre l'onglet 'Alerts' présent et actif dans la fenêtre RQS
                WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
                Get_WinRQS_TabAlerts().Click();  
                Get_WinRQS_TabAlerts().WaitProperty("IsChecked", true, waitTime);
                
                //Mettre la configuration par défaut des colonnes
                Get_WinRQS_TabAlert_ColumnHeader("Test").ClickR();
                Get_WinRQS_TabAlert_ColumnHeader("Test").ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                         
                //Appliquer le filtre:  TEST = 'Pro Account Trading'
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(testFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);


                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), amongOperator); 

                aqObject.CheckProperty(Get_WinCreateFilter_DgvValue().Find("Value", proAccountTrading, 10), "Exists",          cmpEqual, true);
                aqObject.CheckProperty(Get_WinCreateFilter_DgvValue().Find("Value", proAccountTrading, 10), "Isvisible",       cmpEqual, true);
                aqObject.CheckProperty(Get_WinCreateFilter_DgvValue().Find("Value", proAccountTrading, 10), "VisibleOnScreen", cmpEqual, true);
              
                Get_WinCreateFilter_DgvValue().Find("Value", proAccountTrading, 10).Click();
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);

                //Valiter le champ 'Test' de la liste des alertes
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 2: Valider que toutes les alertes ont Test = 'PRO account trading'", "", pmNormal, attr);
                var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Count
                Log.Message(nbrAlertes)
                for (i=0; i<nbrAlertes; i++) {                    
                      aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertTestDescription, "OleValue", cmpEqual, proAccountTrading);}
                Log.PopLogFolder();

                //Valider le type 'Pro Account Trading' dans le sommaire de l'alerte
                var firstAlertClientNumber = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ClientNumber;
                aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtTest(), "Text", cmpEqual, proAccountTrading);           

                //Valider dans l'export vers Excel
                Log.Message("Étapes 4: Valider dans l'export vers Excel");
                Get_WinRQS_TabAlerts_BtnExportToExcel().Click();
                ValidateExcelFile(proAccountTrading, false);
                
                //Valider dans le QueryLog
                Log.Message("Étapes 5: Valider dans le QueryLog");
                Get_WinRQS_BtnQueryLog().Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuerylogView_b490", waitTime);
              
                //Transaction Blotter Date From = '01/25/2010' and To = today date
                Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Set_Value(aqConvert.StrToDate(transactionBlotterDateFrom));
                Get_WinQueryLog_GrpTransactionBlotterDate_DateTo().Set_Value(aqConvert.StrToDate(todayDateString));
                 
                //Choisir Status = 'Anything but closed'     
                SelectComboBoxItem(Get_WinQueryLog_GrpLastStatus_CmbStatus(), anythingButClosed);
                Get_WinQueryLog_BtnGenerate().Click();
                
                //Cliquer sur Ok du petite fenêtre de pourcentage
                if(Get_DlgProgressCroesus())
                    Get_DlgProgressCroesus_BtnOK().Click();
                
                ValidateExcelFile(proAccountTrading, true);                
                
                //Valider dans l'onget Transaction  
                Log.Message("Étapes 6: Valider dans l'onglet Transaction");   
                Get_WinRQS_TabTransactionBlotter().Click();  
                Get_WinRQS_TabTransactionBlotter().WaitProperty("IsChecked", true, waitTime);              
                              
                //Appliquer un filtre avec le numéro du client = 800011-NA
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(accountNumberFilter).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);
                Get_WinCreateFilter_TxtValue().Keys(account800011NA);
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime); 
                //Cliquer sur l'onglet  'Notes and Alerts'         
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click();
//
                count = Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts().WPFObject("RecordListControl", "", 1).Items.Count
//                Log.Message(count);
                var isFound = false;
                i = 0;
                while(i<count) {                    
                    if(Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertTestDescription.OleValue == proAccountTrading){
                        Log.Checkpoint(i+ " - Le type d'alertes : '"+proAccountTrading+"' existe dans le sommaire des alertes", "", pmNormal, attr);
                        isFound = true;
                        break;
                    }
                    else i++;
                }
                if(!isFound) 
                    Log.Error(" Le type d'alertes : '"+proAccountTrading+"' existe dans le sommaire des alertes", "", pmNormal, attr)
    
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
            }
}  

function ValidateExcelFile(proAccountTrading, queryLog){
              
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));    
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
              var attr = Log.CreateNewAttributes();
              attr.Bold = true;
              isFound = false;
              myFile.SetPosition(1,0);
              Delay(40000);
              
              if(!queryLog){
                  //Valider que dans toutes les lignes Test = 'PRO account trading'
                  while(! myFile.IsEndOfFile()){
                      line = myFile.ReadLine();
                      // Split at each space character.
                      var textArr = line.split("	");          
                      if(aqString.Unquote(textArr[4]) != proAccountTrading){
                          isFound = true;
                          break;}
                  } 
                  if (!isFound)
                      Log.Checkpoint(" '"+ proAccountTrading + "'  est exporté correctement dans le fichier Excel", "", pmNormal, attr);
                  else 
                      Log.Error(" '"+ proAccountTrading + "'  n'est pas exporté vers le fichier Excel", "", pmNormal, attr);
              }
              else{
                  //Valider qu'il y a au moins une ligne qui contient Test = 'PRO account trading'
                  while(! myFile.IsEndOfFile()){
                      line = myFile.ReadLine();
                      // Split at each space character.
                      var textArr = line.split("	");          
                      if(aqString.Unquote(textArr[3]) == proAccountTrading){
                          isFound = true;
                          break;}
                  } 
                  if (isFound)
                      Log.Checkpoint(" '"+ proAccountTrading + "'  est exporté correctement dans le fichier Excel", "", pmNormal, attr);
                  else 
                      Log.Error(" '"+ proAccountTrading + "'  n'est pas exporté vers le fichier Excel", "", pmNormal, attr);
              }
              //Fermer le fichier excel  
              while(Sys.waitProcess("EXCEL").Exists){
                  Sys.Process("EXCEL").Terminate();
              }    
}