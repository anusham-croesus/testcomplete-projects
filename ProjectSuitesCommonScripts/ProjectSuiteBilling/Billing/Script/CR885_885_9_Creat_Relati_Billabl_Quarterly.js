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

- Ajouter une relation R2 puis OK;
- Selctionner R2 puis cocher 'Billable Relationship' puis 'Apply'
- Selectionner l'onglet billing.
- Remplir les valeurs d'entrées: 
Frequency: Quarterly Mar,Jun,Sep,Dec
Period: End of period
Fee Schedule:Fixed intervalle.
Calculated Methode:Defined Intervals
Comptes:800049-OB et 800002-OB (Comptes US)
Billing Start Date:01 Février 2009 
- Apply puis OK.
- Aller a Tools/billing 
-Month-end billing: Juin, 2009 puis cocher Quarterly OK
-Generate puis cocher 'Export to PDF format' OK
-La fenêtre Rapport est affiché, Sélectionner le rapport 'Management Fees'
-OK, vérifier qu'une facture PDF est imprimée.
ce cas de test a modifier ses points de vérifications parce que d'aprés Sofia, il sera modifié avec la prochaine version.

Nom du fichier excel:Régression US - Tests Auto
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_9_Creat_Relati_Billabl_Quarterly()
  {
      try {
	       var language = "english"
           var reportName = "Management Fees_Billing_DARWIC";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");  
           var GrilTarifFixedInterval=GetData(filePath_Billing,"CR885",76,language)
          // activer la préférence PREF_BILLING_PROCESS pour l'user Darwic
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            RestartServices(vServerBilling);*/
            Delay(1000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000)
            Cas885_3();

            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Get_Toolbar_BtnAdd().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",22,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(800)
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",22,language))
              Delay(800)
            //Assigner les trois compts suivants: 800049-OB et 800002-OB a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",6,language),GetData(filePath_Billing,"RelationBilling",22,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",7,language),GetData(filePath_Billing,"RelationBilling",22,language));
            
            Delay(800)
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",22,language))
            Delay(800)
        
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",22,language),100).DblClick();
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling",8,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",32,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling",9,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",GrilTarifFixedInterval,100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
                Get_WinBillingConfiguration_BtnOK().Click();
             // remplir la partie d'en bas
             Get_WinDetailedInfo().set_Height(700);
             var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
             for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(GetData(filePath_Billing,"RelationBilling",440,language));
                }

            //click sur le bouton History
               Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
            //Vérifier que la grille est vide
            aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            // Cliquert sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            //Le click sur le bouton Apply et le bouton OK
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Monsuelle,Semiannual et Annual
   
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Juin
             Get_Calendar_LstMonths_ItemJune().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(1000);
             // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Delay(1000);
             Get_WinOutputSelection_BtnOK().Click()
            //Click sur OK 
            Delay(1000);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            //Click sur le bouton Continue
            Delay(1000);
           
             
             // Sélectionner le rapport Management Fees
              Select_Report("Management Fees");
             // Click sur le bouton OK
             Get_WinReports_BtnOK().Click();
             Delay(3000);
             // Click sur le bouto  OK
            
             Delay(10000);
             Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
             // Vérifier si le fichier PDF s'afficher     
             aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
             //sauvegarder le fichier
             SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

             FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf")  
           // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",22,language),100).DblClick();
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
            //vérifier que la date qu'on a sur la colonne Last Billing est 04/30/2009
            windowHeight = Get_WinDetailedInfo().get_Height();
            Get_WinDetailedInfo().set_Height(600);
   
           accountsCount = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (i = 0; i < accountsCount; i++){
          
        var LastBilling = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingLastDate.Date.Date.OleValue;
        var LastBillingExcel = GetData(filePath_Billing,"RelationBilling",330,language)
        var LastBillingConv = aqConvert.DateTimeToFormatStr(LastBilling, "%#m/%d/%Y");
        
        CheckEquals(VarToStr(LastBillingConv),LastBillingExcel, "Le date de last billing");
        
        } 
            //Le click sur le bouton OK
            Get_WinDetailedInfo_BtnOK().Click();
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
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",22,language));
            //suppression du schedule fee  
            Delete_FeeScheduleFixed();
            Delay(200)
            Get_WinConfigurations().Close();
            Close_Croesus_MenuBar();
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            RestartServices(vServerBilling);*/
            Delay(1000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            Terminate_CroesusProcess();
          }

           
           
          
  }

  function DblClick_FirstLine_ShortNameRelationShip()
  {
            
                var NameRelationShip= Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ShortName.OleValue;
                Get_RelationshipsClientsAccountsGrid().Find("Value",NameRelationShip,100).DblClick();
                return NameRelationShip;
  }
  
   
 

function ClickRightAddJoinAccountToRelationShip()
{
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value","BILLING RELATION",100).ClickR();
            Delay(1000);
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value","BILLING RELATION",100).ClickR();
            Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship().Click();
}




