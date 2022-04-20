﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables

/* Description : 
- Ajouter une relation R5 puis OK;
- Selctionner R5 puis cocher 'Billable Relationship' puis 'Apply'
- Selectionner l'onglet billing.
- Remplir les valeurs d'entrées. 
- Cliquer sur leb outon 'history'.
- Apply puis OK.
- Aller a Tools/billing 
- Month-end billing:Décembre 2009 puis cocher Montly OK
- Generate puis cocher 'Export to PDF format' OK
- La fenêtre Rapport est affiché, Sélectionner le rapport 'Management Fees'
- OK, vérifier qu'une facture PDF et imprimée.
- Vérifier les données dans 'History'


Valeur d'entrée:
Frequency: Montly 
Period: End of period 
Fee Schedule:Standard. 
Calculated Methode:Tiered Basis
Comptes:800228-FS, 800230-RE, 300010-OB, 800236-OB ET 300006-OB
Billing Start Date:01 Avril 2009




ce cas de test a modifier ses points de vérifications parce que d'aprés Sofia, il sera modifié avec la prochaine version.

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR1006_1006_1_Creat_Relati_Billabl_Monthly_Methodofcalculationbylevel()
  {
      try {
           EmptyBillingHistory();
           var reportName = "Management Fees_Billing_KEYNEJ_1006_1";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");  
 
          // activer la préférence PREF_BILLING_PROCESS pour l'user KEYNEJ
          /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            RestartServices(vServerBilling);*/

            Delay(2000);
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
            UncheckedBillableRelastionShip();
            //Décôcher AUM et Billable
            UncheckedAUMBillable();
            
            var RelationshipName=GetData(filePath_Billing,"RelationBilling",25,language)
            var IACode=GetData(filePath_Billing,"RelationBilling",15,language)
            
            var CmbFrequency= GetData(filePath_Billing,"RelationBilling",3,language)
            var CmbPeriod=GetData(filePath_Billing,"RelationBilling",17,language)
            var DgvFeeTemplateManager= GetData(filePath_Billing,"CR885",84,language)
    
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            


             //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            CreateRelationshipBillable(RelationshipName,IACode)
           // chercher la relation
           SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",25,language));
            Delay(3000)
            //Assigner les trois compts suivants: 800228-FS, 800230-RE, 300010-OB, 800236-OB ET 300006-OB a la relation relationship Billing

            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",60,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",61,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",16,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",44,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",12,language),RelationshipName)
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",25,language),100).DblClick();
            Delay(3000)
            // vérifier l'existence de l'onglet billing
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Visible", cmpEqual, true);
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Exists", cmpEqual, true);
            
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000)
            //remplir les valeurs d'entrées
            FillingFrequPeriodFeeSchedule(CmbFrequency,CmbPeriod,DgvFeeTemplateManager)
            //il faut cliquer sur le bouton OK de la fenêtre Billing Configuration
            Get_WinBillingConfiguration_BtnOK().Click();
            // remplir la partie d'en bas
             FillInTheBottomPartOfAccounts(440);

            //click sur le bouton History
            Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
            //Vérifier que la grille est vide
            aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            aqObject.CheckProperty(Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            
            // Cliquer sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            //Le click sur le bouton Apply 
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(4000)
            // Clic sur le bouton OK pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000);
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Décembre
             Get_Calendar_LstMonths_ItemDecember().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(3000);
             // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             Delay(3000);
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Get_WinOutputSelection_BtnOK().Click()
             Delay(3000);
            //Click sur OK 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            Delay(3000);

             // Sélectionner le rapport Management Fees
              Select_Report("Management Fees");
              Delay(3000)
             // Click sur le bouton OK
             Get_WinReports_BtnOK().Click();
             Delay(3000);
             
             Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
             // Vérifier si le fichier PDF s'afficher     
             aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
             //sauvegarder le fichier
             SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

             FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf")  
             //double click sur la relation pour ouvrir la fenêtre info de la relation Billing Relation
             Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",25,language),100).DblClick();
             Delay(10000)
             Get_WinDetailedInfo_TabBillingForRelationship().Click();
             //click sur le bouton History
             Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
             Delay(3000)
             //Vérifier les données dans la fenêtre 'Billing History'.
              //click sur le bouton maximiser pour agrandir la fenêtre Billing History
              Get_WinBillingHistory().Parent.Maximize();
              Delay(200)
             // vérifier les données de la grille Billing
             var z=0; 
            var countBilling = Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Count
            if(countBilling == "9") Log.Checkpoint("Le nombre des éléments de la grille de billing est correcte");
            else Log.Error("Le nombre des éléments de la grille de billing est incorrecte");
          for(k=0;k<countBilling;k++){
          Log.Message("les points de vérifications de la ligne de la grille Billing "+k);
          //Vérifier la valeur de Billed on
          var Billed=Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
          var BilledOn=GetData(filePath_Billing,"CR1006-1",2+z,language);
          Log.Message("La ligne du fichier excel"+2+z);
          CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
           //Vérifier la valeur de AUM
           var aum=Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
           var aumExcel=GetData(filePath_Billing,"CR1006-1",3+z,language);
           Log.Message("La ligne du fichier excel"+3+z);
           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
          //Vérifier la valeur de Fees
          var Fees= Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
          var FeesExcel=GetData(filePath_Billing,"CR1006-1",4+z,language);
          Log.Message("La ligne du fichier excel",+4+z);
          CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
           // Vérifier la valeur de période
           var periode= Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue;
           var periodeExcel=GetData(filePath_Billing,"CR1006-1",5+z,language);
           Log.Message("La ligne du fichier excel",+5+z);
           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
          
         // vérifier du nom de la relation
         var relationshipNam= Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
         var relationshipNamExel=GetData(filePath_Billing,"CR1006-1",6+z,language);
         Log.Message("La ligne du fichier excel",+6+z);
         CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
          //Vérifier la valeur de CF Adjustement
          var CFAdjustement= Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee.OleValue;
          var CFAdjustementExcel=GetData(filePath_Billing,"CR1006-1",7+z,language);
          Log.Message("La ligne du fichier excel",+7+z);
          CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
 
         z=z+6;}
          //Vérifier les données de Accounts
         var countAcccount =Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Count;
         if(countAcccount== "5") Log.Checkpoint("Le nombre des éléments de la grille des accounts est correcte");
         else Log.Error("Le nombre des éléments de la grille des accounts est incorrecte");
         var j=0;
         for(var i=0;i<countAcccount;i++){ 
                            // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           Log.Message("Les points de vérifications de la ligne de la partie des comptes "+i)
                           var IncludedAccompt=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,"CR1006-1",61+j,language);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,"CR1006-1",62+j,language);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,"CR1006-1",63+j,language);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,"CR1006-1",64+j,language);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,"CR1006-1",65+j,language);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,"CR1006-1",66+j,language);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,"CR1006-1",67+j,language);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,"CR1006-1",68+j,language);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,"CR1006-1",69+j,language);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,"CR1006-1",70+j,language);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,"CR1006-1",71+j,language);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,"CR1006-1",72+j,language);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,"CR1006-1",73+j,language);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AdjustmentFee;
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,"CR1006-1",74+j,language);
                           if(CFAdjustementAccount == null && CFAdjustementAccountExcel == ""){
                             Log.Checkpoint("La valeur de CF Adjustement est correcte");
                           } 
                           else{
                             Log.Error("La valeur de CF Adjustement est incorrecte")
                           } 
                         //  CheckEquals(VarToString(CFAdjustementAccount),VarToString(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                           Delay(400);
                           j=j+14;
                          }
  
         //Vérifier les données de Summary
         // clic sur calculate 
         Get_WinBillingHistory_GrpSummary_LlbCalculate().Click();
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblCurrentAUM(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR1006-1",132,language));
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LlbCalculate(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LlbCalculate(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR1006-1",133,language));
         
         
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblLastBillingAUM(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblLastBillingAUM(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR1006-1",134,language));
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtLastBillingAUM(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtLastBillingAUM(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR1006-1",135,language)); 
         
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblLastBillingDate(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblLastBillingDate(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR1006-1",136,language));
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtLastBillingDate(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtLastBillingDate(), "Text", cmpEqual, GetData(filePath_Billing,"CR1006-1",137,language));
         
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginning(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginning(), "Text", cmpEqual, GetData(filePath_Billing,"CR1006-1",138,language));
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginning(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginning(), "Text", cmpEqual, GetData(filePath_Billing,"CR1006-1",139,language));
         
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginningOfTheYear(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginningOfTheYear(), "Text", cmpEqual, GetData(filePath_Billing,"CR1006-1",140,language));
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginningOfTheYear(), "Enabled", cmpEqual, true); 
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginningOfTheYear(), "Text", cmpEqual, GetData(filePath_Billing,"CR1006-1",141,language));
         // J'ai mis le texte du message a l'intérieur du script au lieu d'utiliser le fichier excel parce que a partir du fichier excel le script échoue.
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblMessage(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinBillingHistory_GrpSummary_LblMessage(), "WPFControlText", cmpEqual, "The fees displayed have been generated but not necessarily billed.\r\nVerify all transactions on the statement to confirm fees have been billed.");
      // Cliquer sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            Delay(3000)
            //Le click sur le bouton OK
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000)
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
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",25,language));
            Close_Croesus_MenuBar();
            // désactiver les prefs
          /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
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
  