//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCM_ActivateFiltersInAlertsTab

/*
      Ligne 34 du fichier Performance N°28: Changer le status des alerts avec le filtre Alerte status est activé
      
      Analyste d'automatisation: Amine A. */


function Performance_RCM_ChangeAlertsStatus(){
          
            var StopWatchObj     = HISUtils.StopWatch;           
            var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  
            
            var fieldAlertStatus  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "FieldAlertStatus", language+client); 
            var nameAlertStatus   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "NameAlertStatus", language+client);
            var valueClosed       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "ValueClosed", language+client);
            var operatorExcluding = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "OperatorExcluding", language+client);
            var noteText          = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "NoteText", language+client);
                   
            var waitTime = 3000;
            var alertStatusDate = "2019"; 
            var nbAlertes = 20;

            var SoughtForValue = "Performance_RCM_ChangeAlertsStatus";
            var column = FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
                  
        try {
                // Se connecte
                Login(vServerPerformance, userNamePerformance, pswPerformance, language);            
            
                // Attendre le boutton RQS présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005");
                Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
                Get_Toolbar_BtnRQS().Click();
                                     
                // Attendre l'onglet 'Alerts' présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
                Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)          
          
                Get_WinRQS_TabAlerts().Click(); 
                //Fermer la fenêtre de dialogue
                SetAutoTimeOut();
                if(Get_DlgWarning().Exists){
                   Get_DlgWarning_BtnOK().Click();} 
                RestoreAutoTimeOut();
              
                WaitObject(Get_CroesusApp(), "Uid", "AlertsControl_53a1", waitTime);
                Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
              
                /* Changer la date du filte à 2019
                Get_WinRQS_TabAlerts_CmbAlertStatusDatePicker().Click();
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Text",alertStatusDate,10).Click();}*/
                //Adaptation des scripts cas le filter 2019 n'existe plus 
                var dateFrom ="";
                var dateTo ="";
                if(language=="french"){
                  dateFrom="20190101";
                  dateTo ="20191231";
                }else{
                  dateFrom="01012019";
                  dateTo ="12312019";
                };
                ChangeDateOfLastAlertStatus(dateFrom,dateTo);
              
                //Enlever tout les filtres appliqués
                var nbActiveFilter = Get_WinRQS_TabAlerts_AlertsControl().WPFObject("alerts").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
                while(nbActiveFilter > 0){
                    if (Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).wState)
                        Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).WPFObject("Button", "", 2).Click();
                    nbActiveFilter -= 1;
                }
            
                //Créer le filtre 'Alert status excluding Closed'
                CreateFilter(nameAlertStatus, fieldAlertStatus, operatorExcluding, valueClosed);           
        
                //Selectionner 20 alertes
                for (i=0; i<nbAlertes; i++)
                    Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                
                //Ouvrir la fenêtre 'Manage selected'
                Get_WinRQS_BtnManageSelected().Click();
                var numberOftries=0;  
                while ( numberOftries < 5 && !Get_WinMangeSelected().Exists){
                        Get_WinRQS_BtnManageSelected().Click();
                        numberOftries++;
                }
                
                //Choisir Status = Closed, note = noteText
                SelectComboBoxItem(Get_WinMangeSelected_CmbStatus(), valueClosed);
                Get_WinMangeSelected_TxtNote().SetText(noteText);
                Get_WinMangeSelected_BtnSave().Click();
                
                // Mesurer la performance
                StopWatchObj.Start();
                Get_WinMangeSelected_BtnSave().Click();
                WaitObject(Get_WinRQS_TabAlerts_AlertsControl(), ["WPFControlName", "ClrClassName", "VisibleOnScreen"], ["alerts", "AlertList", true], waitTimeShort);
                var timeSpotted=StopWatchObj.Split()/1000
                StopWatchObj.Stop();
            
                // Écrit le résultat dans le fichier excel
                Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());           
                var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
                WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
                
                //Fermer le filtre
                Get_WinRQS_TabAlerts_BtnFilter(1).WPFObject("Button", "", 2).Click();
            
                //Supprimer les Filtres
                DeleteFilter(nameAlertStatus); 
                
                //Fermer RQS et Croesus
                Get_WinRQS().Close();                     
                Close_Croesus_MenuBar();
                
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Fermer Croesus
                TerminateProcess("CroesusClient");
        }
}