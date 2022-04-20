//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR0992_992_1_Print_Bill_RelationShip

/* Description : 
Jaune :
-Aller dans le menu: Tools/Configurations/Billing/Manage Billing.
-Dans le menu 'Fee Schedule' faire 'Add'.
- Remplir les valeurs d'entrées puis 'OK'.
-Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid
- Changer la valeur du rang 'Asset Class', la colonne cash
-Faire la facturation d'un mois 

Valeurs d'entrée:
Jaune: Name: Test jaune 
Valeurs grille de validation: Min: 0 et Max 5

Résultats attendus:
Jaune: Le statut de la grille tarifaire devient 'Jaune' dans la fenêtre 'billing configuration'
Losqu'on a une grille tarifaire qui est déja dans une relation, lorsque la grille devient jaune, lors de la facturation de la relation ,on voie le message dans section message 
'This relationship's fee schedule do not match the validation grid'

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_7_CheckingIndicatorForGridTestYellow()
  {
      try {
           
          // activer la préférence PREF_BILLING_PROCESS pour l'user 
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            
            RestartServices(vServerBilling);*/
            Delay(2000);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            var NamExcel=GetData(filePath_Billing,"CR885",86,language);
            // Ajout Fee Schedule test jaune dont Access est Firm et Rate Pattern est Asset class
            // Choisir Tools/Configurations/Billing/Manage Billing
        
           ClickWinConfigurationsManageBilling();
           
           
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",86,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",79,language));
           Delay(300);
            Get_WinFeeTemplateEdit_ChkShowMinMax().Set_IsChecked(true);
           Delay(200)
           Get_WinFeeTemplateEdit_BtnOK().Click();
           Delay(200)
           Get_WinBillingConfiguration_BtnOK().Click();
           Get_WinConfigurations().Close();
           // Ouvrir de nouveau la grille et modifier le cash min et cash max de Asset Class
           ClickWinConfigurationsManageValidationGrid();
           Delay(200)
           var MinCashAssetClass=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 7], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
           
           MinCashAssetClass.Click()
           Delay(300)
           var y= MinCashAssetClass.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
           Delay(300)
           y.Keys(GetData(filePath_Billing,"CR885",250,language));
           Delay(400)
           var MaxCashAssetClass=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 7], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10);
           
           Delay(500)
           MaxCashAssetClass.Click();
           var z= MaxCashAssetClass.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
           Delay(500)
           z.Keys(GetData(filePath_Billing,"CR885",230,language));
           
           // Click sur le bouton OK de Billing Configuration
           Get_WinFeeMatrixConfiguration_BtnOK().Click();  
           Log.Message(" CROES-8999");//l'application crashe'
           Get_WinConfigurations().Close();
           
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Get_Toolbar_BtnAdd().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",21,language));
            
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            //Assigner les trois compts suivants: 800077-SF,800238-OB et 800238-SF a la relation relationship Billing
             JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",5,language),GetData(filePath_Billing,"RelationBilling",21,language));
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).DblClick();
            Delay(3000);
            
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling",3,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling",4,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,"CR885",86,language),100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
                Get_WinBillingConfiguration_BtnOK().Click();
             // remplir la partie d'en bas
             Get_WinDetailedInfo().set_Height(700);
             var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
             for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(GetData(filePath_Billing,"RelationBilling",441,language));
                }

            
            //Le click sur le bouton Apply 
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000);
            // Clic sur le bouton OK pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnOK().Click();
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Octobre
             Get_Calendar_LstMonths_ItemOctober().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(1000);
             //Les points de vérifications du message affiché
             Delay(200)
             
            aqObject.CheckProperty(Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", GetData(filePath_Billing,"CR885",260,language), 4).WPFObject("XamTextEditor", "", 1), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", GetData(filePath_Billing,"CR885",260,language), 4).WPFObject("XamTextEditor", "", 1), "Text", cmpEqual, GetData(filePath_Billing,"CR885",260,language));
            aqObject.CheckProperty(Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", GetData(filePath_Billing,"CR885",260,language), 4), "Visible", cmpEqual, true);
            
            Delay(2000);
            Get_WinBilling_BtnCancel().Click();
            Delay(500);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar(); }
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
             // suppression de la relation R1
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",21,language));
            //Mettre la valeur de Cash min et max a leur valeur initiale 10 et 20 sur le fichier excel 232 et 233
            ClickWinConfigurationsManageValidationGrid();
           Delay(200)
           var MinCashAssetClass=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 7], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
           
           MinCashAssetClass.Click()
           Delay(300)
           var y= MinCashAssetClass.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
           Delay(300)
           y.Keys(GetData(filePath_Billing,"CR885",232,language));
           Delay(400)
           var MaxCashAssetClass=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 7], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10);
           
           Delay(500)
           MaxCashAssetClass.Click();
           var z= MaxCashAssetClass.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
           Delay(500)
           z.Keys(GetData(filePath_Billing,"CR885",233,language));
           // Click sur le bouton OK de Billing Configuration
           Get_WinFeeMatrixConfiguration_BtnOK().Click();  
           Get_WinConfigurations().Close();
            
            //suppression du schedule fee test jaune
            ClickWinConfigurationsManageBilling();
            Delay(300);
            var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
            Delay(200)
            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            InitializDataBaseFeeSchedul_Fixed(NamExcel,count);
            Close_Croesus_MenuBar();
            
            
            
            // désactiver les prefs
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            //Appel fonction de suppression d'un Fee Schedule
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            Terminate_CroesusProcess();
          }

           
           
          
  }
  



