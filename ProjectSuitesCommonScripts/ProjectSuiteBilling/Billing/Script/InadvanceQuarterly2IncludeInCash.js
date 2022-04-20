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

function InadvanceQuarterly2IncludeInCash()
{



      try {
           
              // activer la préférence PREF_BILLING_PROCESS pour l'user 
              var RelationShipName=GetData(filePath_Billing,"RelationBilling",115,language)
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
            Delay(1000);
               if(client == "BNC")
              {
                var  NameSheetInAdvanceQMarsIncludInCash ="InAdvanceQMarsIncludInCashBNC"
                var  NameSheetInAdvanceQJuinIncludInCash ="InAdvanceQJuinIncludInCashBNC"
                var  NameSheetInAdvanceQSeptemIncludInCash ="InAdvanceQSeptemIncludInCashBNC"
				        var  NameSheetInAdvanceQDembreIncludInCash ="InAdvanceQDembreIncludInCashBNC"
                
              }
              if(client == "US")
              {
                var  NameSheetInAdvanceQMarsIncludInCash   ="InAdvanceQMarsIncludInCash"
                var  NameSheetInAdvanceQJuinIncludInCash   ="InAdvanceQJuinIncludInCash"
                var  NameSheetInAdvanceQSeptemIncludInCash ="InAdvanceQSeptemIncludInCash"
				        var  NameSheetInAdvanceQDembreIncludInCash ="InAdvanceQDembreIncludInCash"
                
              }
        
            // modification de la grille 
            ChangingGrillAccurIDIncludeInCash();
            Delay(1000);
              //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",115,language));
            Delay(800)
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",115,language),100).DblClick();
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
            Delay(800)
            FillRelationshipBillingTab([GetData(filePath_Billing,"WinAssignCompte",10,language)], GetData(filePath_Billing,"RelationBilling",11,language))
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000)
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
           CheckPointsMessageByMonthInAdvanceMIncludInAssetAsset()
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInAdvanceQMarsIncludInCash);
           GeneratExportPDFCloseReport();
             
           
           //Choisir le mois juin 
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
           CheckPointsMessageByMonthInAdvanceMIncludInAssetAsset()
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInAdvanceQJuinIncludInCash);
           GeneratExportPDFCloseReport();
           
            //Choisir le mois Septembre 
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
           CheckPointsMessageByMonthInAdvanceMIncludInAssetAsset()
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInAdvanceQSeptemIncludInCash);
           GeneratExportPDFCloseReport();
           
           //Choisir le mois Décembre 
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
           CheckPointsMessageByMonthInAdvanceMIncludInAssetAsset()
           CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheetInAdvanceQDembreIncludInCash);
          
              
              
             Get_WinBilling_BtnCancel().Click();
             Delay(300)
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
            ChangingGrillAccurIDExclude();
            Delay(800)
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Delay(800)
           
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",115,language));
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",115,language),100).DblClick();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(800)
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",191,language),GetData(filePath_Billing,"RelationBilling",192,language),GetData(filePath_Billing,"RelationBilling",193,language),GetData(filePath_Billing,"RelationBilling",194,language));
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
          /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }
 }

 