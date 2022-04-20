//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT TestGrilCFPercentCas1
//USEUNIT Helper
/* Description : 

-Création de la relation Test_Grille
-Assigner a la relation les deux comptes suivants :800072-SF et 800239-SF.
-Choisir sur frequency :Monthly, Periode : End of Period, Fee Schedule : Prod Asset class
-Cash Flow Adjustement: percentage/Inflow : 100, percentage/Outflow:100, Amount/Inflow:99,999,999.99 et Amount/OutFlow=99,999,999.99.
-Cliquer sur Tools/Billing, cĉoher Monthly sur la partie de Frequencies
-Mettre sur Period ending in Decembre 2009 ensuite click sur le bouton OK
-Il faut vérifier que sur la partie des Messages aucun message n'est affiché.
 
Nom du fichier excel:Tests auto grille .xlsx
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function TestGrilCFMontantCas1()
  {
      try {
            var language = "english"
          
            var RelationshipName=GetData(filePath_Billing,"RelationBilling",37,language)
           // var IACode=GetData(filePath_Billing,"RelationBilling",15,language)
			/*
			      var CmbFrequency= GetData(filePath_Billing,"RelationBilling",3,language)
            var CmbPeriod=GetData(filePath_Billing,"RelationBilling",9,language)
            var DgvFeeTemplateManager= GetData(filePath_Billing,"CR885",89,language)*/
			      Delay(2000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
			      var TxtPercentageInflow=GetData(filePath_Billing,"RelationBilling",39,language)
            var TxtPercentageOutflow=GetData(filePath_Billing,"RelationBilling",40,language)
            var TxtAmountInflow=GetData(filePath_Billing,"RelationBilling",41,language)
            var TxtAmountOutflow=GetData(filePath_Billing,"RelationBilling",42,language)
			
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","FIRMADM",vServerBilling);
            RestartServices(vServerBilling);*/
            Delay(2000);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            //Création d'une relation billing
            //Création d'une relation billing
            //CreateRelationshipBillable(RelationshipName,IACode)
            Delay(1000);
            SearchRelationshipByName(RelationshipName);
            Delay(800)
            //Assigner les trois compts suivants: 800072-SF et 800239-SF a la relation Test_Grille
           /* AssignAccountToRelationShip(30,37);
            AssignAccountToRelationShip(29,37);*/
           
   
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",37,language),100).DblClick();
           Delay(3000);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            
            //Le click sur le bouton Apply pour pouvoir voir la partie de Cash Flow Adjustement
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
             // remplir la partie Cash Flow Adjustment
             FillTheCashFlowAdjustmen (TxtPercentageInflow,TxtPercentageOutflow,TxtAmountInflow,TxtAmountOutflow)

                // remplir la partie d'en bas
             FillInTheBottomPartOfAccounts(16);

            //Click sur le bouton OK de la fenêtre info
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000)
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            Delay(3000)
            // Décôcher sur la partie frequencies Monsuelle,Semiannual et Annual
            Get_WinBillingParameters_RdoInArrears().Click();
   
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Delay(3000)

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //choisir l'année 2009
            Get_Calendar_LstYears_Item("2009").Click();
            Delay(300)
            //Choisir le mois décembre
             Get_Calendar_LstMonths_ItemDecember().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             WaitUntilCroesusDialogBoxClose();
             
             // Les points de vérifications de la partie des messages 
              
              aqObject.CheckProperty( Get_WinBilling_MessagesDgv().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10), "Enabled", cmpEqual, true);
              aqObject.CheckProperty( Get_WinBilling_MessagesDgv().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10), "HasItems", cmpEqual, false);
 
              var taillegrille = Get_WinBilling_MessagesDgv().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.count;
              if( taillegrille == "0")
              {
               Log.Checkpoint("La grille des Messages est vide");
              } 
              else{
                Log.Error("La grille n'est pas vide");
              } 
             // Fermer application  
             Get_WinBilling_BtnCancel().Click();
             Delay(2000);
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); }
             //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Delay(200)
            Terminate_CroesusProcess();
            Delay(2000);
            // remplir la partie Cash Flow Adjustment
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
           
            SearchRelationshipByName(RelationshipName);
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",37,language),100).DblClick();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(800)
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",158,language),GetData(filePath_Billing,"RelationBilling",159,language),GetData(filePath_Billing,"RelationBilling",160,language),GetData(filePath_Billing,"RelationBilling",161,language));
            //Click sur le bouton OK de la fenêtre info
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000)
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
         /*   Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            Terminate_CroesusProcess();
          }

           
           
          
  }
  
  
          