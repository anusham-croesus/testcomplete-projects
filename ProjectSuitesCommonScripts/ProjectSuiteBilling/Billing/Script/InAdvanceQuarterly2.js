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
//USEUNIT TestGrilCFPercentCas1

function InAdvanceQuarterly2()
{



      try {
           
              // activer la préférence PREF_BILLING_PROCESS pour l'user 
              var RelationShipName=GetData(filePath_Billing,"RelationBilling",116,language)
              Execute_SQLQuery("update b_link set IS_BILLABLE='N' WHERE SHORTNAME='"+RelationShipName+"'",vServerBilling)   
                
            /* 
             Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
             Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
             Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
             RestartServices(vServerBilling);*/

           EmptyBillingHistory();
           UncheckedAUMBillable();
           UncheckedBillableRelastionShip();
            
            Delay(2000);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            if(client == "BNC")
              {
                var  NameSheetInadvanQuarterly2Mars  ="InAdvanceQuarterly2MarsBNC"
                var  NameSheetInadvanQuarterly2June  ="InAdvanceQuarterly2JuneBNC"
                var  NameSheetInadvanQuarterly2Septem ="InAdvanceQuarterly2SeptemBNC"
                var  NameSheetInAdvanceQuarterly2Decemb ="InAdvanceQuarterly2DecembBNC"
              }
              if(client == "US")
              {
                var  NameSheetInadvanQuarterly2Mars  ="InAdvanceQuarterly2Mars"
                var  NameSheetInadvanQuarterly2June  ="InAdvanceQuarterly2June"
                var  NameSheetInadvanQuarterly2Septem ="InAdvanceQuarterly2Septem"
                var  NameSheetInAdvanceQuarterly2Decemb ="InAdvanceQuarterly2Decemb"
              }
            Delay(1000);
              //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",116,language));
            Delay(800)
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",116,language),100).DblClick();
            Delay(3000);
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
            
            // modifier la partie du cash flow adjustement
            
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow().set_Text(GetData(filePath_Billing,"RelationBilling",197,language));
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow().set_Text(GetData(filePath_Billing,"RelationBilling",198,language));
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow().set_Text(GetData(filePath_Billing,"RelationBilling",199,language));
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow().set_Text(GetData(filePath_Billing,"RelationBilling",200,language));

            FillInTheBottomPartOfAccounts(11);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000)
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow().Clear();
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow().Keys(GetData(filePath_Billing,"RelationBilling",197,language));
            Delay(1000)
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow().Clear()
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow().Keys(GetData(filePath_Billing,"RelationBilling",198,language));

            Delay(1000)
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow().Clear();
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow().Keys(GetData(filePath_Billing,"RelationBilling",199,language));
            Delay(1000)
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow().Clear();
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow().Keys(GetData(filePath_Billing,"RelationBilling",200,language));

            
            // Clic sur le bouton OK  et apply pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(800);
            Get_WinDetailedInfo_BtnOK().Click();
            
             //Choisir le mois Mars 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemMarch(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
              // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           CheckPointsMessageByMonthInAdvanceQua2("03",NameSheetInadvanQuarterly2Mars, "140",2)
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInadvanQuarterly2Mars);
           GeneratExportPDFCloseReport();
             
           
           //Choisir le mois june 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemJune(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
              // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
            CheckPointsMessageByMonthInAdvanceQua2("06",NameSheetInadvanQuarterly2June, "140",2)
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInadvanQuarterly2June);
           GeneratExportPDFCloseReport();
           
            //Choisir le mois septembre 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemSeptember(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
              // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           CheckPointsMessageByMonthInAdvanceQua2("09",NameSheetInadvanQuarterly2Septem, "140",2)
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInadvanQuarterly2Septem);
           GeneratExportPDFCloseReport();
           
           
           
           
            //Choisir le mois décembre 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemDecember(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
              // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           CheckPointsMessageByMonthInAdvanceQua2("12",NameSheetInAdvanceQuarterly2Decemb, "140",2)
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInAdvanceQuarterly2Decemb);
           GeneratExportPDFCloseReport();
           

              
             //Get_WinBilling_BtnCancel().Click();
             Delay(1000)
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); }
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Delay(300)
            Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Delay(800)
           
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",116,language));
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",116,language),100).DblClick();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(800)
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",197,language),GetData(filePath_Billing,"RelationBilling",198,language),GetData(filePath_Billing,"RelationBilling",199,language),GetData(filePath_Billing,"RelationBilling",200,language));
            //Click sur le bouton OK de la fenêtre info
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(800)
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
            
            
            
            Execute_SQLQuery("update b_link set IS_BILLABLE='N' WHERE SHORTNAME='"+RelationShipName+"'",vServerBilling) 
            EmptyBillingHistory();
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            // désactiver les prefs
         /*   Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }
 }
