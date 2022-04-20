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

-Sélectionner le Client 800238
-Cliquer le bouton 'Report&Graphs' .
-Sélectionner le rapport 'Management Fees'
-Parameters:-idem 885_8
-Parameters:April:2009
-Cocher 'Include Grid'

 puis OK-OK

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR0992_992_3_Print_Bill_Client()
  {
      try {
           EmptyBillingHistory();
           var reportName = "Management Fees_Billing_KEYNEJ_992_3";
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
            Delay(4000)
            //ouvrir le module client
            Get_ModulesBar_BtnClients().Click();
            Delay(1000)
            Get_ModulesBar_BtnClients().Click();
            Delay(1000)
            // Sélectionner le client 800238
            
            Search_Client(GetData(filePath_Billing,"WinAssignClient",3,language));    
            Get_RelationshipsClientsAccountsGrid().Find("value",GetData(filePath_Billing,"WinAssignClient",3,language),10).Click();

            //Click sur le bouton rapport
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            //sélectionner le rapport ensuite cliquer sur le bouton OK
            Select_Report("Management Fees");
            Delay(1000)
            //Click sur le bouton OK
            Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
            WaitReportParametersWindow();
            // Côcher la case a côché Include Grid et choisir le mois Avril et l'année 2009
            Get_WinParameters_ChkIncludeGrid().Click();
            Get_WinParameters_CmbBillingDateMonth().Click();
            Get_WinParameters_CmbBillingDateMonth_Item("Avril","April").Click();
            Get_WinParameters_CmbBillingDateYear().Click()
            Get_WinParameters_CmbBillingDateYear_Item("2009").Click()
            //Click OK de la fenêtre des paramétres 
            Get_WinParameters_BtnOK().Click()
            Delay(3000)
            Get_WinReports_BtnOK().Click();
            Delay(4000)
           
            Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            // Vérifier si le fichier PDF s'afficher     
            aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
            //sauvegarder le fichier
            SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

            FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf") 


             // Fermer application        
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar(); }
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            Login(vServerBilling, userNameBilling, pswBilling, language);
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",21,language));
            Delete_FeeScheduleFixed();
            Close_Croesus_MenuBar();
            
            EmptyBillingHistory();
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
            UncheckedBillableRelastionShip();
            //Décôcher AUM et Billable
            UncheckedAUMBillable();
              
              
            Terminate_CroesusProcess();
          }

           
           
          
  }
  
  
function Select_Report(reportName)
{
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    Get_Reports_GrpReports_TabReports_LvwReports().Keys("[Home]");
    for (var i = 1; i < reportsCount; i++){
        var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
        if (currentReportName == reportName){
            Get_Reports_GrpReports_BtnAddAReport().Click();
            break;
        }

        Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
    }
} 

