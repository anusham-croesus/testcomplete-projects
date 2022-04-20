//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT Global_variables

function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_WinBilling_GrpRelationships_DgvRelationships().get_ActualWidth()
    var ControlHeight=Get_WinBilling_GrpRelationships_DgvRelationships().get_ActualHeight()
    for (i=1; i<=7; i++) { Get_WinBilling_GrpRelationships_DgvRelationships().Click(ControlWidth-40, ControlHeight-3)}     
}

function CreateRelationshipBillable(RelationshipName,IACode)
{
    Log.Message("Create the relationship \"" + RelationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    if (searchResult.Exists == true){
        Log.Message("The relationship " + RelationshipName + " already exists.");
    }
    else {
        Get_Toolbar_BtnAdd().Click();
        Delay(100);
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACode);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true)
        Get_WinDetailedInfo_BtnOK().Click();
    }
} 

function FillInTheBottomPartOfAccounts(NumColumnDatBillinStart){
  Get_WinDetailedInfo().set_Height(700);
             var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
             for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
               
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(GetData(filePath_Billing,"RelationBilling",NumColumnDatBillinStart,language));
                }

} 

function FillTheCashFlowAdjustmen (TxtPercentageInflow,TxtPercentageOutflow,TxtAmountInflow,TxtAmountOutflow){
            Delay(3000);
             // remplir la partie Cash Flow Adjustment
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow().Keys(TxtPercentageInflow);
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow().Keys(TxtPercentageOutflow);
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow().Keys(TxtAmountInflow);
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow().Keys(TxtAmountOutflow);
} 

             
function FillingFrequPeriodFeeSchedule(CmbFrequency,CmbPeriod,DgvFeeTemplateManager,CmbFrequency_Month){
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(CmbFrequency);
             Delay(3000);
             if(CmbFrequency_Month != undefined)
             {
               Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Click();
               Get_SubMenus().Find("WPFControlText",CmbFrequency_Month,10).Click();
               } 
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(CmbPeriod);
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",DgvFeeTemplateManager,100).Click();
             Delay(3000);
             
             }
                          
 function EmptyBillingHistory()
          {
             //Vider l'historique de facturation
             SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ViderFacturation.sql";
             ExecuteSQLFile(SQLFilePath, vServerBilling);
          }  
          
    // Décôcher AUM et Billable pour tous les comptes assignés aux relations      
 function UncheckedAUMBillable(){
    Execute_SQLQuery(" update b_linkAccount set IS_BILLABLE='N',IS_CALCULATED_ASG='N'",vServerBilling);
   
 } 
 // Décôcher La case a cĉoher Billable RelationShip pour tous les relations
 function UncheckedBillableRelastionShip(){
 
    Execute_SQLQuery("update b_link set IS_BILLABLE='N'",vServerBilling);
   
 } 
 
 
 function ChangingGrillAccurIDIncludeInCash(){
            ClickWinConfigurationsManageValidationGrid();
            Delay(1000)
            Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
            Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",332,language),10).Click();
            Delay(800)
            //Click sur le bouton Save de la fenêtre Billing Configuration 
            
             Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
            
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Keys(GetData(filePath_Billing,"CR885",69,language));
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Keys(GetData(filePath_Billing,"CR885",64,language));
             Delay(800)
             Get_WinFeeMatrixConfiguration_BtnOK().Click();
             Delay(800)
             Get_WinConfigurations().Close();
            
           
} 



function ChangingGrillAccurIDIncludeInAsset(){
            ClickWinConfigurationsManageValidationGrid();
            Delay(1000)
            Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
            Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",330,language),10).Click();
            Delay(800)
            //Click sur le bouton Save de la fenêtre Billing Configuration 
            
             Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Keys(GetData(filePath_Billing,"CR885",67,language));
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Keys(GetData(filePath_Billing,"CR885",65,language));
             Delay(800)
             Get_WinFeeMatrixConfiguration_BtnOK().Click();
             Delay(800)
             Get_WinConfigurations().Close();
            
           
} 



function ChangingGrillAccurIDExclude(){
            ClickWinConfigurationsManageValidationGrid();
            Delay(1000)
            Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
            Get_SubMenus().Find("WPFControlText",GetData(filePath_Billing,"CR885",331,language),10).Click();
            Delay(800)
           
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Keys(GetData(filePath_Billing,"CR885",68,language));
             Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Keys(GetData(filePath_Billing,"CR885",68,language));
             Delay(800)
             Get_WinFeeMatrixConfiguration_BtnOK().Click();
             Delay(800)
             Get_WinConfigurations().Close();
            
           
} 


 function ClickWinConfigurationsManageValidationGrid()
 { 
  var BillingCROES_6561=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BillingCROES_6561", language+client);
  var ManageValidationGridCROES_6561=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "ManageValidationGridCROES_6561", language+client);
    Delay(1000)
    Get_MenuBar_Tools().OpenMenu();
    Delay(1000)
    Get_MenuBar_Tools().OpenMenu();
    Delay(800)
    Get_MenuBar_Tools_Configurations().Click();

   
    Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
    	Delay(800)
    //WaitObject(Get_WinConfigurations(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [BillingCROES_6561, true, true]);
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().Click();
   // WaitObject(Get_WinConfigurations(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [ManageValidationGridCROES_6561, true, true]);
   Delay(800)
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    
    
    
   
 }
 
 
 function WaitUntillWinBillingParametersClose(maxWaitTime)
{
    if (maxWaitTime == undefined)
        maxWaitTime = 300000;
        
    Delay(1000);
    waitTime = 0;
    isFound = Get_WinBillingParameters().Exists;
    while (!isFound && waitTime < maxWaitTime){
        Delay(2000);
        waitTime += 2000;
        isFound = Get_WinBillingParameters().Exists;
    }
    Delay(1000);
    
    if (!isFound)
        Log.Message("Billing parametrs Window not display after  " + waitTime + " ms.");
}

function WaitUntilCroesusDialogBoxClose(maxWaitTime){
    //Wait until the Croesus dialog box closes
   Delay(3000);
   waitTime = 0;
   maxWaitTime = 200000;
   isFound = Get_DlgProgressCroesus().Exists;
   while (isFound && waitTime < maxWaitTime){
       Delay(1000);
       waitTime += 1000;
       isFound = Get_DlgProgressCroesus().Exists;
   }
   Delay(2000);
   
   if (isFound)
       Log.Message("Progress Croesus dialog box not closed after " + waitTime + " ms.");
   else
       Log.Message("Progress Croesus dialog box closed after " + waitTime + " ms.");
}

function FillRelationshipBillingTab(arrayOfAccountsNumbers, billingStartDate)
{
    windowHeight = Get_WinDetailedInfo().get_Height();
    Get_WinDetailedInfo().set_Height(800);
   
    accountsCount = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (i = 0; i < accountsCount; i++){
        isFound = false;
        displayedAccountNumber = VarToStr(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
        
        for (j = 0; j < arrayOfAccountsNumbers.length; j++){
            if (displayedAccountNumber == arrayOfAccountsNumbers[j]){
                isFound = true;
                break;
            }
        }
        
        //Check AUM (Cocher ASG)
        SetIsCheckedForCheckbox(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamCheckEditor", "", 1), isFound);
        
        //Check Billable (Cocher Facturable)
        SetIsCheckedForCheckbox(Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 7).WPFObject("XamCheckEditor", "", 1), isFound);
        
        //Billing start date (Date de début de facturation)
        if (isFound){
            Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 8).WPFObject("XamDateTimeEditor", "", 1).DblClick();
            Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 8).WPFObject("XamDateTimeEditor", "", 1).Keys(billingStartDate);
        }
    }
    
    Get_WinDetailedInfo().set_Height(windowHeight);
}


function SetIsCheckedForCheckbox(checkboxObject, booleanValue)
{
    if (booleanValue != checkboxObject.IsChecked)
        checkboxObject.Click();
}
function ChangeFrequencyDateBillingParameters(InArrearsOrInadvan,YearsPeriodBenning,MonthPeriodBeginning,Frequencies)
{
          
            InArrearsOrInadvan.Click();
           // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            // Choisir l'année 
             YearsPeriodBenning.Click()
             Delay(1000);
             MonthPeriodBeginning.Click();
             Delay(1000)
             Get_Calendar_BtnOK().Click();
            
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Frequencies.Set_IsChecked(true);
             Get_WinBillingParameters_DtpBillingDate().Click()
            
            //Wait until the WinBillingParameters  closes
             WaitUntillWinBillingParametersClose();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             WaitUntilCroesusDialogBoxClose();

} 
function CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag){

// Les points de vérifications pour les messages affichés sur la partie Messages de la fenêtre Billing
          var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

                    for(i=0;i<count;i++)
                    {
                           var messages=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ErrorMessage.OleValue;
                           var relationShipName=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RelationshipName.OleValue;
                           var relationShipExcel=GetData(filePath_Billing,"RelationBilling",NbrLignRelationShip,language)
                           
                           var messagesExcel=GetData(filePath_Billing,NameSheet,NbreLigneTxtMessag+i,language)

                           CheckEquals(messages,messagesExcel, "Valeur des messages de la grille");
                           CheckEquals(relationShipName,relationShipExcel, "Valeur du nom de la relation");
    
                    }  
               
                   
                    }
					
function CheckPointsMessageByMonth(Month,NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)
					{
					if(Month == "01" || Month == "04" )
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } 
					}
					if(Month == "07" )
					{
          if(client =="US"){
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count==3){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } 
					
					}
           if(client =="BNC"){
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count==1){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } 
					
          
          }
					if(Month == "10" )
					{
          if(client=="US"){
          var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
					 if(count==2){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } 
					}}
          
          if(client=="BNC"){
          var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
					 if(count==1){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des messsages de la RelationShip"); } 
					}}
          
					}
          
function CheckPointsRelationsShipsAccountsBilling(NameSheet)
{
var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count

 if(countRelat == "1" ){
 Get_WinBilling().Parent.Maximize();
 
//boucle sur le nombre de ligne 
for(k=0;k<countRelat;k++)
{

// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheet,17+z,language),100).Click();
                    Log.Message(17+z);
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheet,14+z,language)
                           Log.Message(14+z);
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheet,15+z,language);
                           Log.Message(15+z);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           //Vérifier la valeur de Billed on
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                           var BilledOn=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message(17+z);
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                           var LastBillingOn=GetData(filePath_Billing,NameSheet,18+z,language);
                           Log.Message(18+z);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheet,19+z,language);
                           Log.Message(19+z);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheet,20+z,language);
                           Log.Message(20+z);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheet,21+z,language);
                           Log.Message(21+z);
                           CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de la Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheet,22+z,language);
                           Log.Message(22+z);
                           CheckEquals(VarToFloat(aumFirmCurrency),VarToFloat(aumFirmCurrencyExcel), "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheet,23+z,language);
                           Log.Message(23+z);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheet,24+z,language);
                           Log.Message(24+z);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheet,25+z,language);
                           Log.Message(25+z);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheet,26+z,language);
                           Log.Message(26+z);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FrequencyTypeID.OleValue
                           var FrequencyExcel=GetData(filePath_Billing,NameSheet,27+z,language);
                           Log.Message(27+z);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheet,28+z,language);
                           Log.Message(28+z);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheet,29+z,language);
                           Log.Message(29+z);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheet,30+z,language);
                           Log.Message(30+z);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheet,31+z,language);
                           Log.Message(31+z);
                           CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
                           Delay(3000);
 // exploser le + de chaque relation
 Delay(300);
                    Get_WinBilling_GrpRelationships_DgvRelationships().Refresh();
                    Delay(3000);
 Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(true);

 Delay(3000)
var i=0;
var countFees =Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count
for(var j=0;j<countFees;j++){ 
    // Vérifier la partie Fees de la ligne sélectionnée
                           // vérifier la valeur d'asset Value
                           
                           var AssetValue=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.AssetValue
                           var AssetValueExcel=GetData(filePath_Billing,NameSheet,32+z+i,language);
                           Log.Message(32+z+i)
                           CheckEquals(VarToStr(AssetValue),VarToStr(AssetValueExcel), "Valeur d'asset Value");
                           //Vérifier le Rate
                           var Rate=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Rate
                           var RateExcel=GetData(filePath_Billing,NameSheet,33+z+i,language);
                           Log.Message(33+z+i)
                           CheckEquals(VarToStr(Rate),VarToStr(RateExcel), "Valeur du Rate");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Fee
                           var FeesExcel=GetData(filePath_Billing,NameSheet,34+z+i,language);
                           Log.Message(34+z+i)
                           CheckEquals(VarToStr(Fees),VarToStr(FeesExcel), "Valeur de Fees");
                                                      
                           //Vérifier  Currency
                           var CurrencyRelationShipFees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Currency.OleValue
                           var CurrencyRelationShipFeesExcel=GetData(filePath_Billing,NameSheet,35+z+i,language);
                           Log.Message(35+z+i)
                           CheckEquals(CurrencyRelationShipFees,CurrencyRelationShipFeesExcel, "Valeur de currency");
                           
                           
                         
                        
                           
                           i=i+4
                           }
                           Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(false);
                           var c=0;
                             // vérifier la patie des comptes
                             for(var r=0;r<2;r++){  
                             
                         // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheet,56+z+c,language);
                           Log.Message(56+z+c);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheet,57+z+c,language);
                           Log.Message(57+z+c);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheet,58+z+c,language);
                           Log.Message(58+z+c);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheet,59+z+c,language);
                           Log.Message(59+z+c);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheet,60+z+c,language);
                           Log.Message(60+z+c);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheet,61+z+c,language);
                           Log.Message(61+z+c);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheet,62+z+c,language);
                           Log.Message(62+z+c);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheet,63+z+c,language);
                           Log.Message(63+z+c);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheet,64+z+c,language);
                           Log.Message(64+z+c);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheet,65+z+c,language);
                           Log.Message(65+z+c);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheet,66+z+c,language);
                           Log.Message(66+z+c);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheet,67+z+c,language);
                           Log.Message(67+z+c);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheet,68+z+c,language);
                           Log.Message(68+z+c);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AdjustmentFee
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheet,69+z+c,language);
                           Log.Message(69+z+c);
                           CheckEquals(VarToStr(CFAdjustementAccount),VarToStr(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                            
                          Delay(200);
                          c=c+14;}
                           var ligneselection=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+70
						  }}
              else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShipa");}

  
} 

function GeneratExportPDFCloseReport(){
  
// Click sur le bouton Generate
              Get_WinBilling_BtnGenerate().Click();
              // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Get_WinOutputSelection_BtnOK().Click()
             Delay(3000);
            //Click sur OK 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            Delay(3000);
            
             Get_WinReports_BtnClose().Click();
             Delay(300)
} 

function CheckPointsMessageByMonthInAdvanceM(Month,NameSheet, NbrLignRelationShip,NbreLigneTxtMessag){
  	
   if(client == "US"){
   if(Month == "03" || Month == "06" )
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					}
          else
					{
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count == "1"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					
					}}
          if(client == "BNC")
          {
             if(Month == "03" || Month == "04" || Month == "05" || Month == "06" || Month == "07" || Month == "08")
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					}
          else
					{
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count == "1"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					
					}
          }
} 

function CheckPointsRelationsShipsAccountsBillingIntervalOneAccount(NameSheet){

Log.Message(NameSheet);
                                      //Les points de vérifications pour la facturation de tous les mois facturés
var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count
//boucle sur le nombre de ligne 
if(countRelat==1)
             {Get_WinBilling().Parent.Maximize();
for(k=0;k<countRelat;k++)
{

// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheet,18+z,language),100).Click();
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           Log.Message(15+z);
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheet,15+z,language)
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           Log.Message(16+z);
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheet,16+z,language);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           
                           //Vérifier la valeur de Billed on
                           Log.Message(18+z);
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                         //  var BilledConStr=VarToString(Billed);
                           
                           var BilledOn=GetData(filePath_Billing,NameSheet,18+z,language);
                          
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           Log.Message(19+z);
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                          // var LastBillingConvStr = VarToStr(LastBilling)
                           var LastBillingOn=GetData(filePath_Billing,NameSheet,19+z,language);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           Log.Message(20+z);
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheet,20+z,language);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
                           //Vérifier la valeur de Fees
                           Log.Message(21+z);
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheet,21+z,language);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           Log.Message(22+z);
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheet,22+z,language);
                           CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de la Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           Log.Message(23+z);
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheet,23+z,language);
                           CheckEquals(VarToFloat(aumFirmCurrency),VarToFloat(aumFirmCurrencyExcel), "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           Log.Message(24+z);
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheet,24+z,language);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           Log.Message(25+z);
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheet,25+z,language);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           Log.Message(26+z);
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheet,26+z,language);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           Log.Message(27+z);
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheet,27+z,language);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           Log.Message(28+z);
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FrequencyTypeID.OleValue
                           var FrequencyExcel=GetData(filePath_Billing,NameSheet,28+z,language);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           Log.Message(29+z);
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheet,29+z,language);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           Log.Message(30+z);
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheet,30+z,language);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           Log.Message(31+z);
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheet,31+z,language);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           Log.Message(32+z);
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheet,32+z,language);
                           CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
 
 
 
var i=0;

//for(var j=0;j<33;j++){ 
    // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           Log.Message(15);
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheet,15,language);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           
                           //Vérifier le numéro de compte
                           Log.Message(33+z);
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheet,33+z,language);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                            Log.Message(34+z);
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheet,34+z,language);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                            Log.Message(35+z);
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheet,35+z,language);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                            Log.Message(36+z);
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheet,36+z,language);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           Log.Message(37+z);
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheet,37+z,language);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                            Log.Message(38+z);
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheet,38+z,language);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                            Log.Message(39+z);
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingDate.OleValue;
                          // var BilledonAccountConStr=VarToStr(BilledonAccount);
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheet,39+z,language);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           Log.Message(40+z);
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheet,40+z,language);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           Log.Message(41+z);
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheet,41+z,language);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           Log.Message(42+z);
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheet,42+z,language);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           Log.Message(43+z);
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheet,43+z,language);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           Log.Message(44+z);
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheet,44+z,language);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                            Log.Message(45+z);
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AdjustmentFee.OleValue;
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheet,45+z,language);
                           CheckEquals(VarToFloat(CFAdjustementAccount),VarToFloat(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                           Delay(400)
                           //Exploser le + du premier compte pour vérifier les données contenus dedans
                          
                           Log.Message("La valeur de i+1 : " + IntToStr(i+1));
                          Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsExpanded(true);
                          Delay(400);
                          var countExplospluscount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.count
                          Delay(400);
                          var s=0;
                          for(var d=0;d<countExplospluscount;d++){  
                                     //Vérifier  Class de Fees
                                     Log.Message(46+z+s);
                                      var Class=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.AssetClass.OleValue;
                                      var ClassFeesAccountExcel=GetData(filePath_Billing,NameSheet,46+z+s,language);
                                      CheckEquals(VarToStr(Class),VarToStr(ClassFeesAccountExcel), "Valeur de Class de Fees");
                                      Log.Message(Class);
                                      //Vérifier Asset %
                                      Log.Message(47+z+s);
                                      var Assetpercent=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.AssetPercent;
                                      var AssetAccountExcel=GetData(filePath_Billing,NameSheet,47+z+s,language);
                                      CheckEquals(VarToStr(Assetpercent),VarToStr(AssetAccountExcel), "Valeur de Asset %");
                                      Log.Message(Assetpercent);
                                       //Vérifier Asset Value
                                       Log.Message(48+z+s);
                                      var AssetValue=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.AssetValue.OleValue;
                                      var AssetValueAccountExcel=GetData(filePath_Billing,NameSheet,48+z+s,language);
                                      CheckEquals(VarToFloat(AssetValue),VarToFloat(AssetValueAccountExcel), "Valeur de Asset Value");
                                      Log.Message(AssetValue);
                                      //Vérifier Rate
                                      Log.Message(49+z+s);
                                      var Rate=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.Rate;
                                      var RateAccountExcel=GetData(filePath_Billing,NameSheet,49+z+s,language);
                                      CheckEquals(VarToFloat(Rate),VarToFloat(RateAccountExcel), "Valeur de Rate");
                                      Log.Message(Rate);
                                      //Vérifier Fee
                                      Log.Message(50+z+s);
                                      var Fee=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.Fee;
                                      var FeeAccountExcel=GetData(filePath_Billing,NameSheet,50+z+s,language);
                                      CheckEquals(VarToFloat(Fee),VarToFloat(FeeAccountExcel), "Valeur de Fee");
                                      Log.Message(Fee);
                                      //J'ai pas pu vérifier la devise mais d'aprés pas nécessaire de la vérifier parce qu'on la valide sur la ligne parente
                                       //Vérifier CF Adjustement
                                       Log.Message(51+z+s);
                                      var AdjustmentFee=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(d).DataItem.AdjustmentFee;
                                      var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheet,51+z+s,language);
                                      CheckEquals(VarToFloat(AdjustmentFee),VarToFloat(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                                      Log.Message(AdjustmentFee);
                                      s=s+6;



             }

                           
                          Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsExpanded(false);
                          Delay(200);
                          // j=j+30;
                           i=i+1
                          // }
                           var ligneselection=GetData(filePath_Billing,NameSheet,18+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+67
						  }}
               else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille RelationShip"); }  
  
} 

 function InitializeDataBase()
   {
   ClickWinConfigurationsManageValidationGrid();
    //Parcourir la grille Billing Configuration pour stocker les valeurs de la colonne valeur totale dans un tableau
    //var tabpointverif =BrowsGridConfigBilliGrid();
    //Get_WinFeeMatrixConfiguration_BtnOK().Click();
   // Get_WinConfigurations().Close();
   // ClickWinConfigurationsManageValidationGrid();
   // Vider et Remplir la grille
   EmptyGridConfigBilling();

    ClickWinConfigurationsManageValidationGrid();
    
    Click_FirstLine_TotalValue_BilliConfig();
    //Log.Message(tabl);
   // var count= tabl.length;
  //Log.Message(count);
    for(j=0;j<5; j++)
    {
        taillegrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsSelected(true);
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsActive(true);
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnSplit().Click();
        Delay(1000);
        Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing,"CR885",j+303,language));
        Delay(1000);
        Get_WinAddRange_BtnOK().Click();
    
     }   
      var NbrLigne = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
      Log.Message(NbrLigne);
      FillTheGridWithValues(NbrLigne)
      Get_WinFeeMatrixConfiguration_BtnOK().Click();
      Get_WinConfigurations().Close();
       ClickWinConfigurationsManageBilling();
                
                 
                 // il faut se connecter avec Uni00 pour pouvoir avoir le bouton migrate activé
      // sélectionner la premier ligne ensuite cliquer sur le bouton migrate utiliser for
     var countFeeSchedule=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
      for(i=0;i<countFeeSchedule;i++){
          var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",Name,100).Click();
          Delay(800)
          Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Click();
          Delay(800)
          Get_WinFeeTemplateMigration_BtnOK().Click();
          Delay(800)
          }
          Get_WinBillingConfiguration_BtnOK().Click();
     
      Delay(800)
                 
      // rechercher dans la grille voila la fonction get de la grille Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager
      Get_WinConfigurations().Close();
      Delay(800)
   //   Close_Croesus_MenuBar();
   }

    function EmptyGridConfigBilling(){
  
  
    count = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
    
    var valtotaldiv = new Array();
    Click_FirstLine_TotalValue_BilliConfig();
    for (var i = 0; i < count-2; i++)
    {
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;
       
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnMerge().Click();
        Delay(1000);
        // click sur le bouton OK de la fenêtre Add Range
        x=Get_DlgConfirmation().get_ActualWidth()/3;
        y=Get_DlgConfirmation().get_ActualHeight()-50;
        Get_DlgConfirmation().Click(x,y);
        Delay(1000);
        /*
       //Trouver la position du "-" dans la chaine de caractére de Total value
        var rechtiret=aqString.Find(TotalValueRange, "-");
        //Récupérer la longueur de la chaine de caractére TotalValueRange
        lengtValTotal=aqString.GetLength(TotalValueRange);
        
        valTotal = aqString.SubString(TotalValueRange,rechtiret+1,lengtValTotal);
        valtotaldiv1=StrToInt(valTotal)/1000;
        valtotaldiv.push(valtotaldiv1);*/
        
    }
    Get_WinFeeMatrixConfiguration_BtnOK().Click();
    Log.Message("En attente du numéro de l'anomalie qui sera crée par Sofia");
     // Fermer la fenêtre de Configurations
    Get_WinConfigurations().Close();
    
    return valtotaldiv;
  }  
  
function Click_FirstLine_TotalValue_BilliConfig()
  {
    
    var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
    Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value",TotalValueRange,100).Click();
    return TotalValueRange;
    
   
  }
  
  function ClickWinConfigurationsManageBilling()
  {
  var NameLabelBilling=GetData(filePath_Billing,"CR885",413,language);
      var NameLabelManageBilling=GetData(filePath_Billing,"CR885",414,language);
      Get_MenuBar_Tools().OpenMenu();
      WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"], ["CFMenuItem_9f7c",true ]);
      Get_MenuBar_Tools_Configurations().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelBilling,true,true ]);
      Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelManageBilling,true,true  ]);
      Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"], ["BillingConfigurationWindow_cbca",true ]);
        
  }
  
  
function FillTheGridWithValues(NbrLigne)
{
        
        var j=112;
        // boucler sur la grille selon le nombre de ligne de la grille
        var k;
        for(k=1;k<NbrLigne+1;k++)
        {
        // sélectionner la ligne de la grille
       var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(k-1).DataItem.TotalValueRange.OleValue;
       Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value",TotalValueRange,100).Click();

        var i;
        //boucler sur les cellules de la grille selon la ligne
        for(i=3;i<31;i++)
        {

        var MinCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
        MinCash.Click();
        var WritCelMinCash=MinCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        WritCelMinCash.Keys(GetData(filePath_Billing,"CR885",j,language)); 

        var MaxCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i+1], 10);
        MaxCash.Click();
        var WritCelMaxCash=MaxCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        WritCelMaxCash.Keys(GetData(filePath_Billing,"CR885",j+1,language));
        j=j+2
        i=i+2;
        }
        }
}


function CheckPointsMessageByMonthInAdvanceQua(Month,NameSheet, NbrLignRelationShip,NbreLigneTxtMessag){
  	if(Month == "03")
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {
                    Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					}
    else
					{
          if(client == "BNC")
          {
            var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
             if(count != "0"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{
          Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
            
          }
          if(client !== "BNC")
          {
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count == "3"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } }
					
					}
} 



function CheckPointsMessageByMonthInAdvanceQua2(Month,NameSheet, NbrLignRelationShip,NbreLigneTxtMessag){
  	if(Month == "03" || Month == "06" || Month == "09" )
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					}
          else
					{
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count == "3"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					
					}
} 



function CheckPointsMessageByMonthInAdvanceMIncludInAssetAsset(){
  	
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					
} 



function CheckPointsRelationsShipsAccountsBillingIncludAssetClasTwoAccount(NameSheet){
   
 Log.Message(NameSheet);
 
 
            
var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count

 if(countRelat == 1 ){
 Get_WinBilling().Parent.Maximize();

 
//boucle sur le nombre de ligne 
for(k=0;k<countRelat;k++)
{



// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheet,17+z,language),100).Click();
                    Log.Message(17+z);
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheet,14+z,language)
                           Log.Message(14+z);
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheet,15+z,language);
                           Log.Message(15+z);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           //Vérifier la valeur de Billed on
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                           var BilledOn=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message(17+z);
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                           var LastBillingOn=GetData(filePath_Billing,NameSheet,18+z,language);
                           Log.Message(18+z);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheet,19+z,language);
                           Log.Message(19+z);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheet,20+z,language);
                           Log.Message(20+z);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheet,21+z,language);
                           Log.Message(21+z);
                           CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de la Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheet,22+z,language);
                           Log.Message(22+z);
                           CheckEquals(aumFirmCurrency,aumFirmCurrencyExcel, "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheet,23+z,language);
                           Log.Message(23+z);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheet,24+z,language);
                           Log.Message(24+z);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheet,25+z,language);
                           Log.Message(25+z);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheet,26+z,language);
                           Log.Message(26+z);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FrequencyTypeID.OleValue
                           var FrequencyExcel=GetData(filePath_Billing,NameSheet,27+z,language);
                           Log.Message(27+z);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheet,28+z,language);
                           Log.Message(28+z);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheet,29+z,language);
                           Log.Message(29+z);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheet,30+z,language);
                           Log.Message(30+z);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheet,31+z,language);
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
//if(countFees == 2){
for(var j=0;j<countFees;j++){ 
    // Vérifier la partie Fees de la ligne sélectionnée
                           // vérifier la valeur d'asset Value
                           
                           var AssetValue=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.AssetValue
                           var AssetValueExcel=GetData(filePath_Billing,NameSheet,32+z+i,language);
                           Log.Message(32+z+i)
                           CheckEquals(VarToStr(AssetValue),VarToStr(AssetValueExcel), "Valeur d'asset Value");
                           //Vérifier le Rate
                           var Rate=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Rate
                           var RateExcel=GetData(filePath_Billing,NameSheet,33+z+i,language);
                           Log.Message(33+z+i)
                           CheckEquals(VarToStr(Rate),VarToStr(RateExcel), "Valeur du Rate");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Fee
                           var FeesExcel=GetData(filePath_Billing,NameSheet,34+z+i,language);
                           Log.Message(34+z+i)
                           CheckEquals(VarToStr(Fees),VarToStr(FeesExcel), "Valeur de Fees");
                                                      
                           //Vérifier  Currency
                           var CurrencyRelationShipFees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Currency.OleValue
                           var CurrencyRelationShipFeesExcel=GetData(filePath_Billing,NameSheet,35+z+i,language);
                           Log.Message(35+z+i)
                           CheckEquals(CurrencyRelationShipFees,CurrencyRelationShipFeesExcel, "Valeur de currency");
                           
                           
                         
                        
                           
                           i=i+4
                           }//}
                           //else { Log.Error("Il y a une erreur dans les éléemts de la grille Fees");}
                           Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(false);
                           var f=0
                             // vérifier la patie des comptes
                             for(var j=0;j<15;j++){ 
                             
                         // Vérifier la partie des comptes
                           // vérifier la valeur de la case a côchée include
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheet,40+z+f,language);
                           Log.Message(40+z+f);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheet,41+z+f,language);
                           Log.Message(41+z+f);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheet,42+z+f,language);
                           Log.Message(42+z+f);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheet,43+z+f,language);
                           Log.Message(43+z+f);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheet,44+z+f,language);
                           Log.Message(44+z+f);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheet,45+z+f,language);
                           Log.Message(45+z+f);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheet,46+z+f,language);
                           Log.Message(46+z+f);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheet,47+z+f,language);
                           Log.Message(47+z+f);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheet,48+z+f,language);
                           Log.Message(48+z+f);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheet,49+z+f,language);
                           Log.Message(49+z+f);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheet,50+z+f,language);
                           Log.Message(50+z+f);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM AUM Excluded");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheet,51+z+f,language);
                           Log.Message(51+z+f);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheet,52+z+f,language);
                           Log.Message(52+z+f);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AdjustmentFee
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheet,53+z+f,language);
                           Log.Message(53+z+f);
                           CheckEquals(VarToStr(CFAdjustementAccount),VarToStr(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                            
                          Delay(200);
                          j=j+13
                          f=f+14
                          }
                  
                           var ligneselection=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+56
						  }}
              else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShipa");}
              
 
 } 

 
function CheckPointsMessageByMonthInAdvanceMIncludCas(Month,NameSheet, NbrLignRelationShip,NbreLigneTxtMessag){
  	if(Month == "05" || Month == "06" || Month == "07" || Month == "08" || Month == "09" )
					{
           var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

					 if(count== "0" ){
              Log.Checkpoint("La grille est vide");
                    }
                    else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					}
          else
					{
					var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
                 if(count == "1"){
					CheckPointGrillMessages(NameSheet, NbrLignRelationShip,NbreLigneTxtMessag)}
					else{Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShip"); } 
					
					}
} 


function CheckPointsRelationsShipsAccountsBillingIncludInCashInAdQuartTwoAccount(NameSheet){
  

                      
var z=0;
var countRelat = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count

 if(countRelat == 1 ){
 Get_WinBilling().Parent.Maximize();
 
//boucle sur le nombre de ligne 
for(k=0;k<countRelat;k++)
{

// click sur la premiére ligne de la partie de relationShips


                    Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value",GetData(filePath_Billing,NameSheet,17+z,language),100).Click();
                    Log.Message(17+z);
                    Delay(300);
                    Get_WinBilling_GrpAccounts_DgvAccounts().Refresh();
                    Delay(300);
                    
                  
                          
                          Delay(200)
                           // vérifier la valeur de la case a côchée
                           var included=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.OkFlag.OleValue;
                           var includedExcel=GetData(filePath_Billing,NameSheet,14+z,language)
                           Log.Message(14+z);
                           CheckEquals(VarToStr(included),VarToStr(includedExcel), "Valeur de la case a côché included");
                           // vérifier du nom de la relation
                           var relationshipNam=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FullName.OleValue;
                           var relationshipNamExel=GetData(filePath_Billing,NameSheet,15+z,language);
                           Log.Message(15+z);
                           CheckEquals(relationshipNam,relationshipNamExel, "Le nom de la relation");
                           //Vérifier la valeur de Generated on
                           var Generated=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ActualDate.OleValue;
                           var GeneratedOn=aqDateTime.Today();
                           CheckEquals(VarToString(Generated),VarToString(GeneratedOn), "Valeur de Generated on");
                           //Vérifier la valeur de Billed on
                           var Billed=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.BillingDate.OleValue;
                           var BilledOn=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message(17+z);
                           CheckEquals(VarToString(Billed),BilledOn, "Valeur de Billed on");
                           //Vérifier la valeur de Last Billing
                           var LastBilling=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.LastBillingDate;
                           var LastBillingOn=GetData(filePath_Billing,NameSheet,18+z,language);
                           Log.Message(18+z);
                           CheckEquals(VarToStr(LastBilling),VarToStr(LastBillingOn), "Valeur de Last Billing");
                           //Vérifier la valeur de AUM
                           var aum=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalAUM;
                           var aumExcel=GetData(filePath_Billing,NameSheet,19+z,language);
                           Log.Message(19+z);
                           CheckEquals(VarToFloat(aum),VarToFloat(aumExcel), "Valeur de la AUM");
                           //Vérifier la valeur de Fees
                           var Fees=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFee;
                           var FeesExcel=GetData(filePath_Billing,NameSheet,20+z,language);
                           Log.Message(20+z);
                           CheckEquals(VarToFloat(Fees),VarToFloat(FeesExcel), "Valeur de Fees");
                           //Vérifier la valeur de Currency
                           var Currency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.Currency.OleValue;
                           var CurrencyExcel=GetData(filePath_Billing,NameSheet,21+z,language);
                           Log.Message(21+z);
                           CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de la Currency");
                           //Vérifier la valeur de AUM Firm Currency
                           var aumFirmCurrency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.TotalFirmAUM.OleValue;
                           var aumFirmCurrencyExcel=GetData(filePath_Billing,NameSheet,22+z,language);
                           Log.Message(22+z);
                           CheckEquals(aumFirmCurrency,aumFirmCurrencyExcel, "Valeur d'AUM Firm Currencyd");
                           //Vérifier la valeur de Currency de la firme
                           var Currencyfirme=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FirmCurrency.OleValue
                           var CurrencyfirmeExcel=GetData(filePath_Billing,NameSheet,23+z,language);
                           Log.Message(23+z);
                           CheckEquals(VarToStr(Currencyfirme),VarToStr(CurrencyfirmeExcel), "Valeur de la Currency de la firme");
                           // Vérifier la valeur de AUM Excluded
                           var AUMExcluded=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.ExcludedAUM.OleValue
                           var AUMExcludedExcel=GetData(filePath_Billing,NameSheet,24+z,language);
                           Log.Message(24+z);
                           CheckEquals(VarToFloat(AUMExcluded),VarToFloat(AUMExcludedExcel), "Valeur de la AUM Excluded");
                           // Vérifier la valeur de AUM for Calculation
                           var AUMForCalculation=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculation.OleValue
                           var AUMForCalculationExcel=GetData(filePath_Billing,NameSheet,25+z,language);
                           Log.Message(25+z);
                           CheckEquals(VarToFloat(AUMForCalculation),VarToFloat(AUMForCalculationExcel), "Valeur de la AUM for Calculation");
                           // Vérifier la valeur de AUM for  Firm Curr
                           var AUMforFirmCurr=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AUMForCalculationFirmCurr.OleValue
                           var AUMforFirmCurrExcel=GetData(filePath_Billing,NameSheet,26+z,language);
                           Log.Message(26+z);
                           CheckEquals(VarToFloat(AUMforFirmCurr),VarToFloat(AUMforFirmCurrExcel), "Valeur de la  AUM for  Firm Curr");
                           // Vérifier la valeur de Frequency
                           var Frequency=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.FrequencyTypeID.OleValue
                           var FrequencyExcel=GetData(filePath_Billing,NameSheet,27+z,language);
                           Log.Message(27+z);
                           CheckEquals(VarToStr(Frequency),VarToStr(FrequencyExcel), "Valeur de la Frequency");
                           // Vérifier la valeur de période
                           var periode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.PeriodTypeID.OleValue
                           var periodeExcel=GetData(filePath_Billing,NameSheet,28+z,language);
                           Log.Message(28+z);
                           CheckEquals(VarToStr(periode),VarToStr(periodeExcel), "Valeur de la période");
                           // Vérifier la valeur de IA code
                           var IAcode=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.RepresentativeNumber.OleValue;
                           var IAcodeExcel=GetData(filePath_Billing,NameSheet,29+z,language);
                           Log.Message(29+z);
                           CheckEquals(VarToStr(IAcode),VarToStr(IAcodeExcel), "Valeur de la IA code");
                           // Vérifier la valeur de nombre de comptes
                           var NombreCompte=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.NumberOfBilledAccounts;
                           var NombreCompteExcel=GetData(filePath_Billing,NameSheet,30+z,language);
                           Log.Message(30+z);
                           CheckEquals(VarToStr(NombreCompte),VarToStr(NombreCompteExcel), "Valeur du nombre de comptes");
                           //Vérifier la valeur de CF Adjustement
                           var CFAdjustement=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(k).DataItem.AdjustmentFee;
                           var CFAdjustementExcel=GetData(filePath_Billing,NameSheet,31+z,language);
                           Log.Message(31+z);
                           CheckEquals(VarToStr(CFAdjustement),VarToStr(CFAdjustementExcel), "Valeur de la CF Adjustement"); 
                           Delay(3000);
 // exploser le + de chaque relation
 Delay(300);
                    Get_WinBilling_GrpRelationships_DgvRelationships().Refresh();
                    Delay(1000);
 Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(true);
 Log.Message( k+1)

 Delay(300)
var i=0;
var countFees =Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count

for(var j=0;j<countFees;j++){ 
    // Vérifier la partie Fees de la ligne sélectionnée
                          
                         // vérifier la description de la class 
                           var ClassDescript = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.ClassDescription.OleValue
                           var ClassDescripExcel=GetData(filePath_Billing,NameSheet,32+z+i,language);
                           Log.Message(32+z+i)
                           CheckEquals(VarToStr(ClassDescript),VarToStr(ClassDescripExcel), "Valeur de la description class");
                           
                           // Vérifier la valeur de Total Value 
                          var TotalValue=Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange.OleValue ;
                          var TotalValueExcel=GetData(filePath_Billing,NameSheet,33+z+i,language);
                          Log.Message(33+z+i)
                          CheckEquals(VarToStr(TotalValue),VarToStr(TotalValueExcel), "Valeur de Total Value");
                          
                          //Vérifier la valeur de Asset Value
                          var AssetValue = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.AssetValue
                          var AssetValueExcel=GetData(filePath_Billing,NameSheet,34+z+i,language);
                          Log.Message(34+z+i)
                          CheckEquals(VarToStr(AssetValue),VarToStr(AssetValueExcel), "Valeur de AssetValue");
                          
                          
                          var Rate =  Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Rate
                          var RateExcel=GetData(filePath_Billing,NameSheet,35+z+i,language);
                          Log.Message(35+z+i)
                          CheckEquals(VarToStr(Rate),VarToStr(RateExcel), "Valeur de Rate");
                          
                          
                          var Fees =  Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Fee
                          var FeesExcel=GetData(filePath_Billing,NameSheet,36+z+i,language);
                          Log.Message(36+z+i)
                          CheckEquals(VarToStr(Fees),VarToStr(FeesExcel), "Valeur de Fees");
                          
                          var Currency = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.Currency.OleValue
                          var CurrencyExcel=GetData(filePath_Billing,NameSheet,37+z+i,language);
                          Log.Message(37+z+i)
                          CheckEquals(VarToStr(Currency),VarToStr(CurrencyExcel), "Valeur de currency");                                                                                                                                                
                         
                           
                           
                           
                         
                        
                           
                           i=i+6
                           }
                           Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", k+1).set_IsExpanded(false);
                           
                             // vérifier la patie des comptes
                             
                     var r=0        
                         // Vérifier la partie des comptes
						 for(var j=0;j<26;j++){ 
                           // vérifier la valeur de la case a côchée include
                           var IncludedAccompt=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.OkFlag;
                           var IncludedAccomptExcel=GetData(filePath_Billing,NameSheet,80+z+j,language);
                           Log.Message(80+z+j);
                           CheckEquals(VarToStr(IncludedAccompt),VarToStr(IncludedAccomptExcel), "Valeur de la case a côché included");
                           //Vérifier le numéro de compte
                           var AccountNubrAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AccountNumber.OleValue;
                           var AccountNubrAccountExcel=GetData(filePath_Billing,NameSheet,81+z+j,language);
                           Log.Message(81+z+j);
                           CheckEquals(VarToStr(AccountNubrAccount),VarToStr(AccountNubrAccountExcel), "Valeur du numéro de compte");
                           //Vérifier le nom du client
                           var ClientNameAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AccountName.OleValue
                           var ClientNameAccountExcel=GetData(filePath_Billing,NameSheet,82+z+j,language);
                           Log.Message(82+z+j);
                           CheckEquals(VarToStr(ClientNameAccount),VarToStr(ClientNameAccountExcel), "Valeur du nom du client");
                                                      
                           //Vérifier Billed Fees
                           var BilledFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.CustomFee.OleValue;
                           var BilledFeesAccountExcel=GetData(filePath_Billing,NameSheet,83+z+j,language);
                           Log.Message(83+z+j);
                           CheckEquals(VarToFloat(BilledFeesAccount),VarToFloat(BilledFeesAccountExcel), "Valeur de Billed Fees");
                           
                           //Vérifier Special Fees
                           var SpecialFeesAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.SpecialFee;
                           var SpecialFeesAccountExcel=GetData(filePath_Billing,NameSheet,84+z+j,language);
                           Log.Message(84+z+j);
                           CheckEquals(VarToStr(SpecialFeesAccount),VarToStr(SpecialFeesAccountExcel), "Valeur de Special Fees");
                           
                          //Vérifier Currency
                           var CurrencyAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.Currency.OleValue;
                           var CurrencyAccountExcel=GetData(filePath_Billing,NameSheet,85+z+j,language);
                           Log.Message(85+z+j);
                           CheckEquals(VarToStr(CurrencyAccount),VarToStr(CurrencyAccountExcel), "Valeur de Currency");
                           
                           //Vérifier Billed Account
                           var BilledAccountAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.BillingAccountNumber.OleValue;
                           var BilledAccountAccountExcel=GetData(filePath_Billing,NameSheet,86+z+j,language);
                           Log.Message(86+z+j);
                           CheckEquals(VarToStr(BilledAccountAccount),VarToStr(BilledAccountAccountExcel), "Valeur de Billed Account");
                           
                           //Vérifier Billed on
                           var BilledonAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.BillingDate.OleValue;
                           var BilledonAccountExcel=GetData(filePath_Billing,NameSheet,87+z+j,language);
                           Log.Message(87+z+j);
                           CheckEquals(VarToStr(BilledonAccount),VarToStr(BilledonAccountExcel), "Valeur de Billed on");
                           
                           //Vérifier Generated on 
                           var GeneratedOnAccountAppl=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.ActualDate.OleValue;
                           var GeneratedOnAccount=aqDateTime.Today();
                           CheckEquals(VarToStr(GeneratedOnAccountAppl),VarToStr(GeneratedOnAccount), "Valeur de Generated on ");
                           
                           //Vérifier IA Code 
                           var IACodeAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.RepresentativeNumber.OleValue;
                           var IACodeAccountExcel=GetData(filePath_Billing,NameSheet,88+z+j,language);
                           Log.Message(88+z+j);
                           CheckEquals(VarToStr(IACodeAccount),VarToStr(IACodeAccountExcel), "Valeur de IA Code ");
                           
                           //Vérifier  AUM
                           var AUMAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.TotalAUM;
                           var AUMAccountExcel=GetData(filePath_Billing,NameSheet,89+z+j,language);
                           Log.Message(89+z+j);
                           CheckEquals(VarToFloat(AUMAccount),VarToFloat(AUMAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM Excluded
                           var AUMExcludedAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.ExcludedAUM.OleValue;
                           var AUMExcludedAccountExcel=GetData(filePath_Billing,NameSheet,90+z+j,language);
                           Log.Message(90+z+j);
                           CheckEquals(VarToStr(AUMExcludedAccount),VarToStr(AUMExcludedAccountExcel), "Valeur de AUM ");
                           
                           //Vérifier  AUM For Calculation
                           var AUMForCalculationAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AUMForCalculation.OleValue;
                           var UMForCalculationAccountExcel=GetData(filePath_Billing,NameSheet,91+z+j,language);
                           Log.Message(91+z+j);
                           CheckEquals(VarToFloat(AUMForCalculationAccount),VarToFloat(UMForCalculationAccountExcel), "Valeur de AUM For Calculation ");
                           
                           //Vérifier  Weighting
                           var WeightingAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.WeightedMarketValueRatio;
                           var WeightingAccountExcel=GetData(filePath_Billing,NameSheet,92+z+j,language);
                           Log.Message(92+z+j);
                           CheckEquals(VarToStr(WeightingAccount),VarToStr(WeightingAccountExcel), "Valeur de Weighting");
                           
                           //Vérifier  CF Adjustement
                           var CFAdjustementAccount=Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(r).DataItem.AdjustmentFee
                           var CFAdjustementAccountExcel=GetData(filePath_Billing,NameSheet,93+z+j,language);
                           Log.Message(93+z+j);
                           CheckEquals(VarToStr(CFAdjustementAccount),VarToStr(CFAdjustementAccountExcel), "Valeur de CF Adjustement");
                            
                          Delay(200);
                           j=j+13;
                           r=r+1;}
                  
                           var ligneselection=GetData(filePath_Billing,NameSheet,17+z,language);
                           Log.Message("Fin de test du ligne"+VarToStr(ligneselection));
						   z=z+147
						  }}
              else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille des RelationShipa");}
 } 
 
function EnterCashflowAdjustments(percentInflow,percentOutflow,amountInflow, amountOutflow)
{
  Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow().Keys(percentInflow);
  Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow().Keys(percentOutflow);
  Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow().Keys(amountInflow);
  Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow().Keys(amountOutflow);
}

function EnterBillingTabAccountsGroupbox(billingStartDate)
{
  var numberAccounts;
             
  Get_WinDetailedInfo().set_Height(700);
  numberAccounts = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
               
  for(i=1; i<numberAccounts+1; i++)
  {
    Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
    Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
    Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
    Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(billingStartDate);
  }
} 

function CheckIfEqual(actualValue, expectedValue, valueDescription)
{
  actualValue = (actualValue != "") ? actualValue : "null";
  expectedValue = (expectedValue != "") ? expectedValue : "null";
    
  if (actualValue == expectedValue)
  {
    Log.Checkpoint(valueDescription + " Expected: '" + expectedValue + "' - Actual: '" + actualValue + "'");
  }
  else
  {
    Log.Error(valueDescription + " Expected: '" + expectedValue + "' - Actual: '" + actualValue + "'");
  }
}

function GetColumnNames(searchObject, numberColumns)
{
    var columnNames = [];
    var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"]; 
   
    for (var columnNumber = 0; columnNumber < numberColumns; columnNumber++)
    {
      var valuesArray = ["LabelPresenter", (columnNumber + 1)];
      
      columnNames[columnNumber] = searchObject.FindChild(propertiesArray, valuesArray, 10).WPFControlText;
    }
    
    return (columnNames);      
}

function GetCroesusBuildVersion()
{
  var croesusBuildVersion = "";
  var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
  var valuesArray = ["TextBlock", 7];

  // Ensure that Croesus MainWindow is focused
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  // Click on ? in Classic Menu of MainWindow
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();  
  // Click on About to open About dialog
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();
  // Read version
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  // Close About dialog
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();
  // Return version
  return (croesusBuildVersion);  
}

function GetNthParent(targetObject, level)
{
  while (level > 0)
  {
    targetObject = targetObject.Parent;
    level--;
  }
  
  return (targetObject);
}

