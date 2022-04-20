//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly

/* Description : 

- Selctionner R7 puis  l'onglet billing.
- Vérifier que le bouton 'Bill Now' n'est pas disponible 
Habituellement, il est sous le bouton 'History'

Vérifier que la facturation instantaté (Via 'Bill now') n'est pas disponible avec la methode de calcul par palier

Nom du fichier excel:Régression US - Tests Auto
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR1006_1006_5_Billing_RelationShip_Without_BtnBillNow()
  {
       try {
           EmptyBillingHistory();
             
          // Activer la préférence PREF_BILLING_PROCESS pour l'user KEYNEJ
          /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            RestartServices(vServerBilling);*/
            Delay(1000)
            
            var RelationshipName=GetData(filePath_Billing,"RelationBilling",28,language)
            var IACode=GetData(filePath_Billing,"RelationBilling",15,language)
            
            var CmbFrequency= GetData(filePath_Billing,"RelationBilling",14,language)
            var CmbPeriod=GetData(filePath_Billing,"RelationBilling",9,language)
            var DgvFeeTemplateManager= GetData(filePath_Billing,"CR885",85,language)
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
            UncheckedBillableRelastionShip();
            //Décôcher AUM et Billable
            UncheckedAUMBillable();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000)
           //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            CreateRelationshipBillable(RelationshipName,IACode)
            // chercher la relation
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",28,language));
            Delay(3000);
            //Assigner les trois compts suivants:800047-SF, 800039-OB et 800063-OB a la relation relationship Billing
           
            
            
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",21,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",22,language),RelationshipName)
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",10,language),RelationshipName)
            Delay(3000);
  
           
        
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",28,language),100).DblClick();
            Delay(1000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            //remplir les valeurs d'entrées
            FillingFrequPeriodFeeSchedule(CmbFrequency,CmbPeriod,DgvFeeTemplateManager)
            Delay(1000);
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
             Get_WinBillingConfiguration_BtnOK().Click();

             // Vérifier que le bouton Bill Now n'est pas disponible
             
             aqObject.CheckProperty(Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow(), "Visible", cmpEqual, false);
             aqObject.CheckProperty(Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow(), "VisibleOnScreen", cmpEqual, false);
             
             Get_WinDetailedInfo_BtnOK().Click();
             // Fermer application        
             Delay(2000);      
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); }
             catch(e) {
             Log.Error("Exception: " + e.message, VarToStr(e.stack));}
             finally {
             Terminate_CroesusProcess();
            
             Login(vServerBilling, userNameBilling, pswBilling, language);
             DeleteRelationship(GetData(filePath_Billing,"RelationBilling",28,language));
             Close_Croesus_MenuBar();
           /*Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
             Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
             RestartServices(vServerBilling);*/
             EmptyBillingHistory();
            // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
            UncheckedBillableRelastionShip();
            //Décôcher AUM et Billable
            UncheckedAUMBillable();
            EmptyBillingHistory();
             Terminate_CroesusProcess();
           }

           
           
          
  }

 