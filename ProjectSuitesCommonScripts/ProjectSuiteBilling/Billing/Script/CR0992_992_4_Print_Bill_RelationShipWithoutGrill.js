//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
/* Description : 

-Sélectionner la relation R1.
-Cliquer le bouton 'Report&Graphs' .
-Sélectionner le rapport 'Management Fees'
-Parameters:April:2009
Parameters puis OK-OK

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR0992_992_4_Print_Bill_RelationShipWithoutGrill()
  {
      try {
           EmptyBillingHistory();
           var reportName = "Management Fees_Billing_KEYNEJ_992_4";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");  
          
          // activer la préférence PREF_BILLING_PROCESS pour l'user KEYNEJ
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","FIRMADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            RestartServices(vServerBilling);*/

            Delay(2000);
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
           UncheckedBillableRelastionShip();
           //Décôcher AUM et Billable
           UncheckedAUMBillable();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000)
            Cas885_8();
            Delay(1000)
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
           // double click sur la relation Billing Relation
           Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).Click();
           Delay(2000);
            //Click sur le bouton rapport
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            //sélectionner le rapport ensuite cliquer sur le bouton OK
            Select_Report("Management Fees");
            Delay(1000)
            //Click sur le bouton OK
            Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
            WaitReportParametersWindow();
            //Choisir le mois Avril et l'année 2009
            //Get_WinParameters_ChkIncludeGrid().Click();
            Get_WinParameters_CmbBillingDateMonth().Click();
            Get_WinParameters_CmbBillingDateMonth_Item("Avril","April").Click();
            Get_WinParameters_CmbBillingDateYear().Click()
            Get_WinParameters_CmbBillingDateYear_Item("2009").Click()
            //Click OK de la fenêtre des paramétres 
            Get_WinParameters_BtnOK().Click()
            Delay(1000)
            Get_WinReports_BtnOK().Click();
            Delay(1000)
           
            Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            Delay(1000)
            // Vérifier si le fichier PDF s'afficher     
            aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
            //sauvegarder le fichier
            SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

            FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf") 


             // Fermer application        
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar(); }
            
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            Login(vServerBilling, userNameBilling, pswBilling, language);
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",21,language));
            Delete_FeeScheduleFixed();
            Close_Croesus_MenuBar();
            // désactiver les prefs
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            RestartServices(vServerBilling);*/
            EmptyBillingHistory();
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
            UncheckedBillableRelastionShip();
            //Décôcher AUM et Billable
            UncheckedAUMBillable();
              
              
            Terminate_CroesusProcess();
          }

           
           
          
  }
 