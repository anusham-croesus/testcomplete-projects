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

function StartOfPeriodeQuarterlyIncludeInCash()
{



      try {
         
          // activer la préférence PREF_BILLING_PROCESS pour l'user 
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            
            RestartServices(vServerBilling);*/
            
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            Delay(2000);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
             Delay(800)
               if(client == "BNC")
              {
                var  NameSheetStart_periode_QIncludeInCash ="Start_periode_QIncludeInCashBNC"
                
              }
              if(client == "US")
              {
                var  NameSheetStart_periode_QIncludeInCash ="Start_periode_QIncludeInCash"
              }
            // modification de la grille 
             ChangingGrillAccurIDIncludeInCash();
            Delay(1000);
           
             //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",94,language));
            Delay(800)
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",94,language),100).DblClick();
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
            FillInTheBottomPartOfAccounts(10);
            Delay(1000);
            // Clic sur le bouton OK pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000);
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000);
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
            Get_WinBillingParameters_RdoInArrears().Click();
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(false);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

            
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
             // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
                var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                if(count ==  0)
                    
                    {
                          Log.Checkpoint( "Le nombre des éléments de la grille des messages est correcte" )
    
                    } 
                 else { Log.Error("Le nombre des éléments de la grille des messages est incorrecte");}   
                    //Les points de vérifications pour la facturation de tous les mois facturés
                  
                
var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count
//boucle sur le nombre de ligne 
if(countRelat ==  3){
for(k=0;k<countRelat;k++)
{

// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,12+z,language),100).Click();
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,9+z,language)
                           Log.Message(9+z);
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,10+z,language);
                           Log.Message(10+z);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           //Vérifier la valeur de Billed on
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                           var BilledOn=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,12+z,language);
                           Log.Message(12+z);
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                           var LastBillingOn=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,13+z,language);
                           Log.Message(13+z);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,14+z,language);
                           Log.Message(14+z);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de Last AUM");
                          // vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,15+z,language);
                           Log.Message(15+z);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,16+z,language);
                           Log.Message(16+z);
                           CheckEquals(VarToString(Currency),VarToString(CurrencyExcel), "Valeur de Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,17+z,language);
                           Log.Message(17+z);
                           CheckEquals(VarToFloat(aumFirmCurrency),VarToFloat(aumFirmCurrencyExcel), "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,18+z,language);
                           Log.Message(18+z);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,19+z,language);
                           Log.Message(19+z);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,20+z,language);
                           Log.Message(20+z);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,21+z,language);
                           Log.Message(21+z);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 14], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
                           var FrequencyExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,22+z,language);
                           Log.Message(22+z);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,23+z,language);
                           Log.Message(23+z);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,24+z,language);
                           Log.Message(24+z);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,25+z,language);
                           Log.Message(25+z);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,26+z,language);
                           Log.Message(26+z);
                           CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
 
 
 
var i=0;

for(var j=0;j<20;j++){ 
    // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,9,language);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,27+j+z,language);
                           Log.Message(27+j+z);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,28+j+z,language);
                           Log.Message(28+j+z);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                           
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,29+j+z,language);
                           Log.Message(29+j+z);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,30+j+z,language);
                           Log.Message(30+j+z);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,31+j+z,language);
                           Log.Message(31+j+z);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,32+j+z,language);
                           Log.Message(32+j+z);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,33+j+z,language);
                           Log.Message(33+j+z);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,34+j+z,language);
                           Log.Message(34+j+z);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,35+j+z,language);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           Log.Message(35+j+z);
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,36+j+z,language);
                           Log.Message(36+j+z);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,37+j+z,language);
                           Log.Message(37+j+z);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,38+j+z,language);
                           Log.Message(38+j+z);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AdjustmentFee.OleValue;
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,39+j+z,language);
                           Log.Message(39+j+z);
                           CheckEquals(VarToFloat(CFAdjustementAccount),VarToFloat(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                           Delay(400)
                           //Exploser le + du premier compte pour vérifier les données contenus dedans
                          
                           Log.Message("La valeur de i+1 : " + IntToStr(i+1));
                          Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsExpanded(true);
                          Delay(400);
                           //Vérifier  Class de Fees
                           var ClassFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.AssetClass.OleValue
                           var ClassFeesAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,40+j+z,language);
                           Log.Message(40+j+z);
                           CheckEquals(VarToStr(ClassFeesAccount),VarToStr(ClassFeesAccountExcel), "Valeur de Class de Fees");
                           
                           //Vérifier Asset %
                           var AssetAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.AssetPercent;
                           var AssetAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,41+j+z,language);
                           Log.Message(41+j+z);
                           CheckEquals(VarToStr(AssetAccount),VarToStr(AssetAccountExcel), "Valeur de Asset %");
                           
                           //Vérifier Asset Value
                           var AssetValueAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.AssetValue.OleValue
                           var AssetValueAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,42+j+z,language);
                           Log.Message(42+j+z);
                           CheckEquals(VarToFloat(AssetValueAccount),VarToFloat(AssetValueAccountExcel), "Valeur de Asset Value");
                           
                           //Vérifier Rate
                           var RateAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.Rate;
                           var RateAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,43+j+z,language);
                           Log.Message(43+j+z);
                           CheckEquals(VarToFloat(RateAccount),VarToFloat(RateAccountExcel), "Valeur de Rate");
                           
                           //Vérifier Fee
                           var FeeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.Fee
                           var FeeAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,44+j+z,language);
                           Log.Message(44+j+z);
                           CheckEquals(VarToFloat(FeeAccount),VarToFloat(FeeAccountExcel), "Valeur de Fee");
                           
                           //Vérifier Currency : j'arrive pas a récupérer  currency a partir de testcomplete
                           
                           //Vérifier CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Fees.Current.AdjustmentFee.OleValue;
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,45+j+z,language);
                           Log.Message(45+j+z);
                           CheckEquals(VarToFloat(CFAdjustementAccount),VarToFloat(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                           //Exploser le -
                          Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsExpanded(false);
                          Delay(200);
                           j=j+18;
                           i=i+1
                           }
                           var ligneselection=GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,12+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+56
						  }}
              else { Log.Error("Il y a une erreur dans le nombre des éléments de la grille de relation")}
              // ajout de points de vérifications pour la partie summary aprés avoir corrigé l'anomalie des UID 
               
              
              
             aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "WPFControlText", cmpEqual, GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,182,language));
             
             aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "WPFControlText", cmpEqual, GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,183,language));
            
             aqObject.CheckProperty( Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(), "WPFControlText", cmpEqual, GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,184,language));
             aqObject.CheckProperty( Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(), "WPFControlText", cmpEqual, GetData(filePath_Billing,NameSheetStart_periode_QIncludeInCash,185,language));
             
                  
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
            Delay(800)
            ChangingGrillAccurIDExclude();
            Delay(300)
            
            Delay(300)
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",94,language));
            Delay(800)
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",94,language),100).DblClick();
            Delay(3000);
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            
           
            
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000);
            
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",165,language),GetData(filePath_Billing,"RelationBilling",166,language),GetData(filePath_Billing,"RelationBilling",167,language),GetData(filePath_Billing,"RelationBilling",168,language))
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(800)
            
            
            
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
            
            
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

