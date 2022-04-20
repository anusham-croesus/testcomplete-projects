//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper
/* Description : 

- Ajouter une relation R4 puis OK;
- Selctionner R4 puis cocher 'Billable Relationship' puis 'Apply'
- Selectionner l'onglet billing.
- Remplir les valeurs d'entrées:
Frequency: Montly 
Period: Start of period
Fee Schedule:Prod interval asset
Calculated Methode:Defined Intervals
Comptes:300006-OB et 800059-SF
Billing Start Date:01 Avril 2009

- Apply puis OK.
- Cliquer sur le bouton 'Bill Now'
-Billing date : 01/25/2010 puis OK
-Generate puis cocher 'Export to PDF format' OK
-La fenêtre Rapport est affiché, Sélectionner le rapport 'Management Fees'
-OK, vérifier qu'une facture PDF est imprimée.

Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_13_Billing_RelationShip_Btn_BillNow()
  {
       try {
           var language = "english"
           var reportName = "Management Fees_Billing_KEYNEJ_885_13";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");  
          // activer la préférence PREF_BILLING_PROCESS pour l'user Darwic
           // Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
           // Activate_Inactivate_PrefBranch("0","PREF_BILLING","YES",vServerBilling);
          //  Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
          //  Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
           // RestartServices(vServerBilling);
            
            Delay(2000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000)
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Delay(100);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            Delay(1000);
            
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",24,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().Keys(GetData(filePath_Billing,"RelationBilling",31,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(800)
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",24,language));
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",24,language),100).DblClick();
            // côcher Billable Relationship
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(1000)
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",24,language));
            Delay(800)
            //Assigner les trois compts suivants: 300006-OB et  800059-SF a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",12,language),GetData(filePath_Billing,"RelationBilling",24,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",13,language),GetData(filePath_Billing,"RelationBilling",24,language))
            

            
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",24,language),100).DblClick();
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000)
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling",3,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling",4,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value","prod interval asset",100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
                Get_WinBillingConfiguration_BtnOK().Click();
             // remplir la partie d'en bas
             Get_WinDetailedInfo().set_Height(700);
             var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
             for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(GetData(filePath_Billing,"RelationBilling",10,language));
                }
              //Click sur le bouton Bill Now
              Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
              Delay(4000)
              //Mettre la date 01/25/2010 sur la fenêtre Billing Parameters
              Get_WinInstantBillingParameters_DtpSelectABillingDate().set_StringValue(GetData(filePath_Billing,"RelationBilling",147,language))
              Delay(4000)
              //Cliquer sur le bouton OK
              Get_WinInstantBillingParameters_BtnOK().Click();
              Delay(9000)
         
             
              // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             Delay(8000)
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Get_WinOutputSelection_BtnOK().Click()
             Delay(3000)
            //Click sur OK 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            Delay(5000)
             //sélectionner le rapport ensuite cliquer sur le bouton OK
             Select_Report("Management Fees");
             Delay(3000)
             Delay(3000)
            Get_WinReports_BtnOK().Click();
            Delay(4000)
           
            Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            // Vérifier si le fichier PDF s'afficher     
            aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
            //sauvegarder le fichier
            SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

            FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf") 


           // double click sur la relation Billing Relation
          //  Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",24,language),100).DblClick();
            //Choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(1000);
             //Vérifier que la grille a des éléments
             //click sur le bouton History
               Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
            //Vérifier que la grille est remplie
            // UNe fois qu'on reçois la nouvelle version on doit modifier ces points de vérifications
            aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, true);
            // Cliquert sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            //vérifier que la date qu'on a sur la colonne Last Billing est 1/25/2010
            windowHeight = Get_WinDetailedInfo().get_Height();
            Get_WinDetailedInfo().set_Height(800);
   
           accountsCount = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (i = 0; i < accountsCount; i++){
          
        var LastBilling = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingLastDate.Date.Date.OleValue;
        var LastBillingConv = aqConvert.DateTimeToFormatStr(LastBilling, "%#m/%d/%Y");
        var LastBillingExcel = GetData(filePath_Billing,"RelationBilling",148,language)
        
        CheckEquals(VarToStr(LastBillingConv),LastBillingExcel, "Le date de last billing");
         Log.Message("CROES-8315")
        
        } 
            //Le click sur le bouton OK
            Get_WinDetailedInfo_BtnOK().Click();
             // Fermer application        
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
             }
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
             Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
           
            //suppressionde la relation 
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",24,language));
            Close_Croesus_MenuBar();
            
            
            /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);*/
            //RestartServices(vServerBilling);

            //Appel fonction de suppression d'un Fee Schedule
            Delay(2000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            Terminate_CroesusProcess();
          }

           
           
          
  }
/* 
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
} */



