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

function PalierMidPeriodMonth()
{



      try {
           
              // activer la préférence PREF_BILLING_PROCESS pour l'user 
              var RelationShipName=GetData(filePath_Billing,"RelationBilling",106,language)
              Execute_SQLQuery("update b_link set IS_BILLABLE='N' WHERE SHORTNAME='"+RelationShipName+"'",vServerBilling)   
                
      
           /*  Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
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
                var  NameSheetPalierMidPeriodM  =  "PalierMidPeriodMBNC"
                
                
              }
              if(client == "US")
              {
                var  NameSheetPalierMidPeriodM  = "PalierMidPeriodM"
                
              }
            
            
            Delay(1000);
              //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",106,language));
            Delay(800)
          // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",106,language),100).DblClick();
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
           // FillInTheBottomPartOfAccounts(16);
            FillRelationshipBillingTab([GetData(filePath_Billing,"WinAssignCompte",41,language)], GetData(filePath_Billing,"RelationBilling",11,language))


            // Clic sur le bouton OK  et apply pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(8000);
            
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
            Get_WinBillingParameters_RdoInArrears().Click();
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

          // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois decembre
             Get_Calendar_LstMonths_ItemJuly().Click();
             Get_Calendar_BtnOK().Click();
            // Delay(3000)
            //Wait until the WinBillingParameters  closes
             WaitUntillWinBillingParametersClose();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             WaitUntilCroesusDialogBoxClose();
 
            
             
             // Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
             
             var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
             Log.Message("Le nombre des éléments de la grille de la grille des messages est"+count);
             if(client =="US"){
              if(count== 6 ){
                    for(i=0;i<count;i++)
                    {
                           var messages=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ErrorMessage.OleValue;
                           var relationShipName=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RelationshipName.OleValue;
                           var relationShipExcel=GetData(filePath_Billing,"RelationBilling",128,language)
                           
                           var messagesExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,2+i,language)
                           Log.Message(2+i)

                           CheckEquals(messages,messagesExcel, "Valeur des messages de la grille");
                           CheckEquals(relationShipName,relationShipExcel, "Valeur du nom de la relation");
    
                    } }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } }
                    
                    
                    
               if(client =="BNC"){     
              if(count== 0 ){
                    for(i=0;i<count;i++)
                    {
                           var messages=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ErrorMessage.OleValue;
                           var relationShipName=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RelationshipName.OleValue;
                           var relationShipExcel=GetData(filePath_Billing,"RelationBilling",128,language)
                           
                           var messagesExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,2+i,language)
                           Log.Message(2+i)

                           CheckEquals(messages,messagesExcel, "Valeur des messages de la grille");
                           CheckEquals(relationShipName,relationShipExcel, "Valeur du nom de la relation");
    
                    } }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } }
 var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count

 if(countRelat == 5 ){
 Get_WinBilling().Parent.Maximize();
 
//boucle sur le nombre de ligne 
for(k=0;k<countRelat;k++)
{

// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheetPalierMidPeriodM,17+z,language),100).Click();
                    Log.Message(17+z);
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,14+z,language)
                           Log.Message(14+z);
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,15+z,language);
                           Log.Message(15+z);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           //Vérifier la valeur de Billed on
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                           var BilledOn=GetData(filePath_Billing,NameSheetPalierMidPeriodM,17+z,language);
                           Log.Message(17+z);
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                           var LastBillingOn=GetData(filePath_Billing,NameSheetPalierMidPeriodM,18+z,language);
                           Log.Message(18+z);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,19+z,language);
                           Log.Message(19+z);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,20+z,language);
                           Log.Message(20+z);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,21+z,language);
                           Log.Message(21+z);
                           CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de la Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,22+z,language);
                           Log.Message(22+z);
                           CheckEquals(aumFirmCurrency,aumFirmCurrencyExcel, "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,23+z,language);
                           Log.Message(23+z);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,24+z,language);
                           Log.Message(24+z);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,25+z,language);
                           Log.Message(25+z);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,26+z,language);
                           Log.Message(26+z);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FrequencyTypeID.OleValue
                           var FrequencyExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,27+z,language);
                           Log.Message(27+z);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,28+z,language);
                           Log.Message(28+z);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,29+z,language);
                           Log.Message(29+z);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,30+z,language);
                           Log.Message(30+z);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,31+z,language);
                           Log.Message(31+z);
                           CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
                           Delay(3000);
 // exploser le + de chaque relation
 Delay(300);
                    Get_WinBilling_GrpRelationships_DgvRelationships().Refresh();
                    Delay(300);
 Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(true);

 Delay(3000)
var i=0;
var countFees =Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count
for(var j=0;j<countFees;j++){ 
    // Vérifier la partie Fees de la ligne sélectionnée
                           // vérifier la valeur d'asset Value
                           
                           var AssetValue=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.AssetValue
                           var AssetValueExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,32+z+i,language);
                           Log.Message(32+z+i)
                           CheckEquals(VarToStr(AssetValue),VarToStr(AssetValueExcel), "Valeur d'asset Value");
                           //Vérifier le Rate
                           var Rate=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Rate
                           var RateExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,33+z+i,language);
                           Log.Message(33+z+i)
                           CheckEquals(VarToStr(Rate),VarToStr(RateExcel), "Valeur du Rate");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Fee
                           var FeesExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,34+z+i,language);
                           Log.Message(34+z+i)
                           CheckEquals(VarToStr(Fees),VarToStr(FeesExcel), "Valeur de Fees");
                                                      
                           //Vérifier  Currency
                           var CurrencyRelationShipFees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Currency.OleValue
                           var CurrencyRelationShipFeesExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,35+z+i,language);
                           Log.Message(35+z+i)
                           CheckEquals(CurrencyRelationShipFees,CurrencyRelationShipFeesExcel, "Valeur de currency");
                           
                           
                         
                        
                           
                           i=i+4
                           }
                           Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(false);
                           
                             // vérifier la patie des comptes
                             
                             
                         // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,56+z,language);
                           Log.Message(56+z);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,57+z,language);
                           Log.Message(57+z);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,58+z,language);
                           Log.Message(58+z);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,59+z,language);
                           Log.Message(59+z);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,60+z,language);
                           Log.Message(60+z);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,61+z,language);
                           Log.Message(61+z);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,62+z,language);
                           Log.Message(62+z);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,63+z,language);
                           Log.Message(63+z);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,64+z,language);
                           Log.Message(64+z);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,65+z,language);
                           Log.Message(65+z);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,66+z,language);
                           Log.Message(66+z);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,67+z,language);
                           Log.Message(67+z);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,68+z,language);
                           Log.Message(68+z);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AdjustmentFee
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheetPalierMidPeriodM,69+z,language);
                           Log.Message(69+z);
                           CheckEquals(VarToStr(CFAdjustementAccount),VarToStr(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                            
                          Delay(200);
                  
                           var ligneselection=GetData(filePath_Billing,NameSheetPalierMidPeriodM,17+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+57
						  }}
              else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShipa");}

              
              
             Get_WinBilling_BtnCancel().Click();
             Delay(300)
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); 
             Delay(300)}
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
           
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",106,language));
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",106,language),100).DblClick();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(800)
            FillTheCashFlowAdjustmen (GetData(filePath_Billing,"RelationBilling",239,language),GetData(filePath_Billing,"RelationBilling",240,language),GetData(filePath_Billing,"RelationBilling",241,language),GetData(filePath_Billing,"RelationBilling",242,language))
            //Click sur le bouton OK de la fenêtre info
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(800)
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar();
            
            
            
            
            Delay(300)
            
            
            Execute_SQLQuery("update b_link set IS_BILLABLE='N' WHERE SHORTNAME='"+RelationShipName+"'",vServerBilling) 
            EmptyBillingHistory();
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            // désactiver les prefs
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }
 }

