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
//USEUNIT Helper

/* Description : 
-Aller dans le menu: Tools/Configurations/Billing/Manage Billing.
-Assigner a la relation "Test rouge"
-Selectionner 'Test rouge' puis 'Delete' on reçois un message qui est :"Cette grille tarifaire ne peut pas être supprimée."

 
Prérequis:
- Pref billing = Yes 
-PREF_BILLING_FEESCHEDULE
-cas 885_7_1


Valeurs d'entrée:
1- La grille tarifaire :'Test rouge' (cas885_7_1)


Résultats attendus:
1- La grille est supprimer 


Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

function CR885_7_2_DeleteLineOfGrillAssignRelationShip()
{



      try {
           
          // activer la préférence PREF_BILLING_PROCESS pour l'user 
           // Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
           // Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
           // Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            
           // RestartServices(vServerBilling);
            Delay(2000);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            var NamExcel=GetData(filePath_Billing,"CR885",87,language);
            // Ajout Fee Schedule test rouge dont Access est Firm et Rate Pattern est Asset class
            // Choisir Tools/Configurations/Billing/Manage Billing
            ClickWinConfigurationsManageBilling();
           
           
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",87,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",81,language));
           Delay(300);
           Get_WinFeeTemplateEdit_BtnOK().Click();
           Delay(200)
           Get_WinBillingConfiguration_BtnOK().Click();
           Get_WinConfigurations().Close();
           //Ouvrir de nouveau Tools/Configurations/Billing/Manage Billing et supprimer test rouge
           ClickWinConfigurationsManageBilling();
          
            Delay(300);
            //vérifier que le test rouge existe dans la grille
            aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",GetData(filePath_Billing,"CR885",87,language),100), "Exists", cmpEqual, true);
            var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
            Delay(200)
            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            // Assigner cette Fee Schedule a une relation 
            //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Get_Toolbar_BtnAdd().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",21,language));
            
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
            Delay(800)
            //Assigner les trois compts suivants: 800077-SF,800238-OB et 800238-SF a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"RelationBilling",21,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",5,language),GetData(filePath_Billing,"RelationBilling",21,language))
            

            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).DblClick();
            Delay(3000);
            
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling",3,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling",4,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,"CR885",87,language),100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
             Get_WinBillingConfiguration_BtnOK().Click();
             Delay(400)
             Get_WinDetailedInfo_BtnOK().Click();
             Delay(400)
            //supprimer Test rouge
            
            ClickWinConfigurationsManageBilling();
            Delay(400)
         
            for (var i=1;i<count+1;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
                      // click sur le bouton Delete de la fenêtre Billing
                      x=Get_DlgConfirmation().get_ActualWidth()/3;
                      y=Get_DlgConfirmation().get_ActualHeight()-50;
                      Get_DlgConfirmation().Click(x, y);
                      Delay(400)
                      //Vérifier le message affiché
                      aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, GetData(filePath_Billing,"CR885",99,language));
                      
                      break;                                                                                     
                      }
                      
      
             }
           //Clic sur le bouton de la fenêtre Billing pour fermer le message
            x=Get_DlgWarning().get_ActualWidth()/2;
            y=Get_DlgWarning().get_ActualHeight()-50;
            Get_DlgWarning().Click(x, y);
             // Click sur le bouton OK
            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
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
           //suppression du schedule fee test rouge
            ClickWinConfigurationsManageBilling();
            Delay(300);
            var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
            Delay(200)
            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            InitializDataBaseFeeSchedul_Fixed(NamExcel,count);
           // désactiver les prefs
          /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);*/
            //RestartServices(vServerBilling);
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }

           
           
          
  }
  


