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
1-Selectionner 'Test rouge' puis 'Delete' puis on recoi un message puis OK.
2-Selectionner 'Standard intervalle' puis 'Delete'
 
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

function CR885_7_2_DeleteLineOfGrillNoAssignRelationShip()
{



      try {
           
          // activer la préférence PREF_BILLING_PROCESS pour l'user 
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);*/
            
            //RestartServices(vServerBilling);
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
            InitializDataBaseFeeSchedul_Fixed(NamExcel,count);
           
            //les points de vérifications qu'il existe plus la grille test rouge
            ClickWinConfigurationsManageBilling();
            aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",GetData(filePath_Billing,"CR885",87,language),100), "Exists", cmpEqual, false);
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
           //suppression du schedule fee test rouge
            ClickWinConfigurationsManageBilling();
            Delay(300);
            var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
            Delay(200)
            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            InitializDataBaseFeeSchedul_Fixed(NamExcel,count);
           // désactiver les prefs
            /*Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);*/
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }

           
           
          
  }
  