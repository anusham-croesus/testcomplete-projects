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

function PalierInadvanceQuarterly()
{



      try {
           
              // activer la préférence PREF_BILLING_PROCESS pour l'user 
              var RelationShipName=GetData(filePath_Billing,"RelationBilling",109,language)
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
                var  NameSheetPalierInadvaQuJanuary  =  "PalierInadvaQuJanuaryBNC"
                var  NameSheetPalierInadvaQuApril    =  "PalierInadvaQuAprilBNC"
                var  NameSheetPalierInadvaQuJuly     =  "PalierInadvaQuJulyBNC"
                var  NameSheetPalierInadvaQuOctober  =  "PalierInadvaQuOctoberBNC"
                
              }
              if(client == "US")
              {
                var  NameSheetPalierInadvaQuJanuary  =  "PalierInadvaQuJanuary"
                var  NameSheetPalierInadvaQuApril    =  "PalierInadvaQuApril"
                var  NameSheetPalierInadvaQuJuly     =  "PalierInadvaQuJuly"
                var  NameSheetPalierInadvaQuOctober  =  "PalierInadvaQuOctober"
              }
            
            
            Delay(1000);
              //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",109,language));
            Delay(800)
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",109,language),100).DblClick();
            Delay(3000);
            // côcher Billable Relationship
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(8000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
           
            FillRelationshipBillingTab([GetData(filePath_Billing,"WinAssignCompte",44,language),GetData(filePath_Billing,"WinAssignCompte",45,language)], GetData(filePath_Billing,"RelationBilling",16,language))


            // Clic sur le bouton OK  et apply pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(8000);
            
            //Choisir le mois Janvier 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemJanuary(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
           // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           Log.Message("le nom de la feuille est PalierInadvaQuJanuary")
           CheckPointsMessageByMonth("01",NameSheetPalierInadvaQuJanuary, "131",2)
           CheckPointsRelationsShipsAccountsBilling(NameSheetPalierInadvaQuJanuary);
           GeneratExportPDFCloseReport();
            //Choisir le mois avril
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemApril(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
           // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           Log.Message("le nom de la feuille est PalierInadvaQuApril") 
           CheckPointsMessageByMonth("04",NameSheetPalierInadvaQuApril, "131",2)
           CheckPointsRelationsShipsAccountsBilling(NameSheetPalierInadvaQuApril);
           GeneratExportPDFCloseReport();
            
            
            //Choisir le mois juillet
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemJuly(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
           // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           Log.Message("le nom de la feuille est PalierInadvaQuJuly")   
           CheckPointsMessageByMonth("07",NameSheetPalierInadvaQuJuly, "131",2)
           CheckPointsRelationsShipsAccountsBilling(NameSheetPalierInadvaQuJuly);
           GeneratExportPDFCloseReport();
            
            //Choisir le mois d'octobre 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            ChangeFrequencyDateBillingParameters(Get_WinBillingParameters_RdoInAdvance(),Get_Calendar_LstYears_Item("2009"),Get_Calendar_LstMonths_ItemOctober(),Get_WinBillingParameters_GrpFrequencies_ChkQuarterly())
 
           // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
           Log.Message("le nom de la feuille est PalierInadvaQuOctober")    
           CheckPointsMessageByMonth("10",NameSheetPalierInadvaQuOctober, "131",2)
           CheckPointsRelationsShipsAccountsBilling(NameSheetPalierInadvaQuOctober);
           GeneratExportPDFCloseReport();
             
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); 
              Delay(800)}
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            
             Delay(300)
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Delay(800)
           
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",109,language));
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",109,language),100).DblClick();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(800)
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",264,language),GetData(filePath_Billing,"RelationBilling",265,language),GetData(filePath_Billing,"RelationBilling",266,language),GetData(filePath_Billing,"RelationBilling",267,language))
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
 
 