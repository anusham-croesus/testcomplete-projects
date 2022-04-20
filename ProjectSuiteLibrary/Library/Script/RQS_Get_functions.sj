 //USEUNIT Global_variables
//USEUNIT Common_Get_functions
 
 
 
 /******************************************* RQS************************************************/
 
 
//Alhassane : la Grille details de  l'onglet Alerte  de la fenêtre RQS
function  Get_WinRQS_Details(){return Get_WinRQS().FindChild("Uid", "Expander_1e20", 10);}


//Alhassane : la Grille RQS  de la fenêtre RQS
function Get_WinRQS_TabAlerlist(){return Get_WinRQS().FindChild("Uid", "TabControl_9229", 10);}


//Alhassane : la Grille des listes d'alerte de  l'onglet Alerte  de la fenêtre RQS
function Get_WinRQS_TabAlerts_DgvAlerts(){return Get_WinRQS_TabAlerlist().WPFObject("AlertsControl", "", 1).WPFObject("alerts").WPFObject("RecordListControl", "", 1);}


// RQS --> Window 'Transaction Review'
function Get_WinTransactionReview(){return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}

function Get_WinTransactionReview_BtnValidate(){return Get_WinTransactionReview().FindChild("Uid", "Button_c9dd", 10)}

function Get_WinTransactionReview_GrpNoteTextBox(){return Get_WinTransactionReview().FindChild("Uid", "TextBox_b392", 10)}

function Get_WinTransactionReview_RdBSpotcheck() {return Get_WinTransactionReview().FindChild("Uid", "RadioButton_c208", 10)}

function Get_WinTransactionReview_CmbTypeOfReview() {return Get_WinTransactionReview().FindChild("Uid", "ComboBox_2637", 10)}

function Get_WinTransactionReview_CmbQueryCategory(){return Get_WinTransactionReview().FindChild("Uid", "ComboBox_f3ad", 10)}

//RQS --> Window 'Transaction Summary'
function Get_WinTransactionSummary(){return Get_CroesusApp().FindChild("Uid", "TransactionSummaryWindow_579d", 10)}

function Get_WinTransactionSummary_BtnClose(){return Get_WinTransactionSummary().FindChild("Uid", "Button_6b17", 10)}

//Colonne Management Level
function Get_WinRQS_TabAlerts_DgvAlerts_ChMgmtLevel(){if (language == "french"){return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Niv. gestion"], 10)}
  else {return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Mgmt level"], 10)}
}
//Colonne  Client Relationship Name 
function Get_WinRQS_TabAlerts_DgvAlerts_ChClientRelName(){if (language == "french"){return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Nom rel. client"], 10)}
  else {return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Client rel. name"], 10)}
}

function Get_WinRQSDetailsGrid_LblPositionMarketValue(){return Get_WinRQS().FindChild("Uid", "CFTextBlock_efe8", 10);}

function Get_WinRQS_TabAlerts_BtnExportToExcel(){
      return Get_WinRQS().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["Button",3], 10)}  

//---------------------------------------RQS --> Window 'Bulk Validation'-----------------------------------------------------------------
function Get_WinBulkValidation(){return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}

function Get_WinBulkValidation_BtnAddPredefinedSentences(){return Get_WinBulkValidation().FindChild("Uid", "Button_f802", 10)}

function Get_WinBulkValidation_BtnEditPredefinedSentences(){return Get_WinBulkValidation().FindChild("Uid", "Button_4cfb", 10)}

function Get_WinBulkValidation_BtnCopyPredefinedSentences(){return Get_WinBulkValidation().FindChild("Uid", "Button_017b", 10)}

function Get_WinBulkValidatione_BtnDeletePredefinedSentences(){return Get_WinBulkValidation().FindChild("Uid", "Button_eadf", 10)}

function Get_WinBulkValidation_DgvPredefinedSentences(){return Get_WinBulkValidation().FindChild("Uid", "NoteSentenceDataGrid_ae74", 10)}

function Get_WinBulkValidation_BtnClose(){return Get_WinBulkValidation().FindChild("Uid", "Button_2076", 10)}

function Get_WinBulkValidation_GrpGeneralTransactionBlotterDateTxt(){return Get_CroesusApp().FindChild("Uid", "TextBlock_093d", 10)}

function Get_WinBulkValidation_GrpGeneralSpotCheckedTxt(){return Get_CroesusApp().FindChild("Uid", "TextBlock_b148", 10)}

function Get_WinBulkValidation_GrpGeneralManualAlertsTxt(){return Get_CroesusApp().FindChild("Uid", "TextBlock_b0fb", 10)}

function Get_WinBulkValidation_GrpGeneralTotalToBeValidatedTransactionsTxt(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_0f8e", 10)}

function Get_WinBulkValidation_GrpGeneralTotalToBeValidatedAccountsTxt(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_f192", 10)}

function Get_WinBulkValidation_GrpGeneralTotalToBeValidatedClientsTxt(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_80f3", 10)}

function Get_WinBulkValidation_GrpGeneralTotalToBeValidatedRelatioshipsTxt(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_d572", 10)}

function Get_WinBulkValidation_GrpNoteCreationDateTxt(){return Get_CroesusApp().FindChild("Uid", "TextBox_4358", 10)}

function Get_WinBulkValidation_GrpNoteCreatedByTxt(){return Get_CroesusApp().FindChild("Uid", "TextBox_d210", 10)}

function Get_WinBulkValidation_BtnBulkValidate(){return Get_CroesusApp().FindChild("Uid", "Button_3f56", 10)}

//RQS --> Tab 'Notes and Alerts' --> Button 'Delete' --> Window 'Deletion'
function Get_WinDeletion(){return Get_CroesusApp().FindChild("Uid", "DeletionWindow_5967", 10)}          
function Get_WinDeletion_BtnYes(){return Get_WinDeletion().FindChild("Uid", "Button_cbe4", 10)}               
function Get_WinDeletion_BtnDeleteForManyTransactions(){return Get_WinDeletion().FindChild("Uid", "Button_8553", 10)}
function Get_WinDeletion_BtnDeleteNoteForCurrentTransaction(){return Get_WinDeletion().FindChild("Uid", "Button_393a", 10)}
function Get_WinDeletion_BtnCcancel(){return Get_WinDeletion().FindChild("Uid", "Button_a69b", 10)}

function Get_WinEditValidation(){return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}
function Get_WinEditValidation_BtnClose(){return Get_WinEditValidation().FindChild("Uid", "Button_764a", 10)}
function Get_WinEditValidation_BtnEditNoteForCurrentTransaction(){return Get_WinEditValidation().FindChild("Uid", "Button_bbf9", 10)}
function Get_WinEditValidation_BtnEditNoteForManyTransaction(){return Get_WinEditValidation().FindChild("Uid", "Button_c641", 10)}

//Tab Trans Blottom 
function Get_WinRQS_BottomSection(){return Get_WinRQS().FindChild("Uid", "Expander_f6d2", 10)}
function Get_WinRQS_BottomSection_TabNotesAndAlerts(){return Get_WinRQS_BottomSection().FindChild("Uid", "TabItem_49e0", 10)}          
function Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete(){return Get_WinRQS_BottomSection().FindChild("Uid", "Button_9e45", 10)}
function Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnEdit (){return Get_WinRQS_BottomSection().FindChild("Uid", "Button_7ff7", 10)}



//Tabb Transaction Toggle Button (Filter)
function Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(WPFControlOrdinalNo){
        return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)
}

function Get_WinRQS_TabAlerts_ToggleFilter(item){
  return Get_WinRQS_TabAlerts_AlertsControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", item], 10)
}

//Tab Transaction image spotcheck (oeil)
function Get_WinRQS_TabTransactionBlotter_SpotcheckImage(i){
    return Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", i).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", 1], 10)} 

//////////////////////////6646////////////////////
function Get_WinRQS_TabAlerts_AlertList(){return Get_WinRQS().FindChild("Uid","AlertList_5770", 10);}  //Get_WinRQS_TabAlerts_AlertList
//function Get_WinRQS_TabAlerts_DgvAlerts_Filtres(){return Get_WinRQS().FindChild("Uid","AlertList_5770", 10);} 
function Get_WinRWS_QuickSearch(){return Get_WinQuickSearch().Find ("Uid", "QuickSearchWindow_b326", 10)}

function Get_WinRQS_TabAlert_ColumnHeader(columnHeaderText){
    return Get_WinRQS_TabAlerts_AlertList().FindChild (["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeaderText],10)
}

function Get_WinRQS_TabTransactionBlotter_ColumnHeader(header){
    return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlText", "IsVisible"], ["LabelPresenter", header, true], 10)
}

//-----------------------------Ajout de filtre-------------------------------
function Get_WinCRUFilter_CmbOperator(operator){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", operator], 10);}
function Get_WinCRUFilter_CmbField(field) {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", field], 10);}



function Get_WinRQS_TabAlerts_DgvAlerts_BtnFiltres(WPFControlOrdinalNo){
	return Get_WinRQS_TabAlerts_DgvAlerts_Filtres().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)} 


function Get_WinRQS_QuickFilter_FilterField(field){
  return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", field], 10) }
//----------------------------------Fenêtre RQS Object Calendrier------------------------------
function Get_WinRQS_MonthCalendar_BtnToDay(){return Get_SubMenus().FindChild("Uid", "Button_77f6", 10)}
function Get_WinRQS_MonthCalendar_BtnOK(){return Get_SubMenus().FindChild("Uid", "Button_92ab", 10)}

//--------------------------------Fenêtre Manage selected--------------------------------------------
function Get_WinRQS_BtnManageSelected(){
        return Get_WinRQS().FindChild("Uid", "Button_86cf", 10)}   

function Get_WinMangeSelected(){
        return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}
                
function Get_WinMangeSelected_CmbStatus(){
        return Get_WinMangeSelected().FindChild("Uid", "CFComboBox_84cf", 10)}              

function Get_WinMangeSelected_TxtNote(){
        return Get_WinMangeSelected().FindChild("Uid", "TextBox_b392", 10)}        

function Get_WinMangeSelected_BtnSave(){
        return Get_WinMangeSelected().FindChild("Uid", "Button_ce71", 10)}
                
//--------------------------------Fenêtre QueryLog--------------------------------------------

function Get_WinRQS_BtnQueryLog(){return Get_WinRQS().FindChild("Uid", "Button_02d6", 10)}

function Get_WinQueryLog(){return Get_CroesusApp().FindChild("Uid", "QuerylogView_b490", 10)} 
       
function Get_WinQueryLog_BtnGenerate(){return Get_WinQueryLog().FindChild("Uid", "Button_3c68", 10)}  
      
function Get_WinQueryLog_BtnClose(){return Get_WinQueryLog().FindChild("Uid", "Button_839a", 10)}

function Get_WinQueryLog_GrpTransactionBlotterDate(){return Get_WinQueryLog().FindChild("Uid", "GroupBox_06ba", 10)}

function Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom(){
      return Get_WinQueryLog_GrpTransactionBlotterDate().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",1], 10)}   

function Get_WinQueryLog_GrpTransactionBlotterDate_DateTo(){
      return Get_WinQueryLog_GrpTransactionBlotterDate().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",2], 10)} 
      
function Get_WinQueryLog_GrpClientRelationship(){return Get_WinQueryLog().FindChild("Uid", "GroupBox_f91b", 10)}  

function Get_WinQueryLog_GrpClientRelationship_CmbManagementLevel(){
      return Get_WinQueryLog_GrpClientRelationship().FindChild("Uid", "ComboBox_f9ae", 10)}    

function Get_WinQueryLog_GrpLastStatus(){return Get_WinQueryLog().FindChild("Uid", "GroupBox_fb84", 10)}

function Get_WinQueryLog_GrpLastStatus_CmbStatus(){return Get_WinQueryLog_GrpLastStatus().FindChild("Uid", "ComboBox_5794", 10)}

function Get_WinQueryLog_GrpLastStatus_DateFrom(){
      return Get_WinQueryLog_GrpLastStatus().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",1], 10)}


function Get_WinQueryLog_GrpLastStatus_DateTo(){
      return Get_WinQueryLog_GrpLastStatus().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",2], 10)}            

function Get_WinQueryLog_GrpClientRelationshipOrClientTxtNameStartsWith(){
      return Get_WinQueryLog().Find("Uid", "TextBox_8b20",10)} 

function Get_DlgConfirmation_BtnClose(){
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}}            
      
//--------------------------------Section Details de l'onglet Alertes de  la fenêtre RQS--------------------------------------------     

function Get_WinRQS_PadAlerts_TxtClientNumber(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_702c", 10);}
function Get_WinRQS_PadAlerts_LblCliRelNumName(){return Get_WinRQS().Find("Uid", "TextBlock_1854", 10)}
function Get_WinRQS_PadAlerts_TxtCliRelNumName(){return Get_WinRQS().Find("Uid", "CFTextBlock_6759", 10) }
function Get_WinRQS_PadAlerts_LblManLevel(){return Get_WinRQS().Find("Uid","TextBlock_7a24",10)}
function Get_WinRQS_PadAlerts_TxtManagementLevel(){return Get_WinRQS().Find("Uid", "CFTextBlock_e366", 10)}
function Get_WinRQS_PadAlerts_LblCliRelTotalValue(){return Get_WinRQS().Find("Uid","TextBlock_8f2b", 10) }
function Get_WinRQS_PadAlerts_TxtClientRelTotalValue(){return Get_WinRQS().Find("Uid","CFTextBlock_cfa0", 10)}
function Get_WinRQS_PadAlerts_LblInvesKnow(){return Get_WinRQS().Find("Uid", "TextBlock_9b30", 10) }
function Get_WinRQS_PadAlerts_TxtInvestKnowledge(){return Get_WinRQS().Find("Uid", "CFTextBlock_2696",10)}
function Get_WinRQS_PadAlerts_LblNonResIndicator(){return Get_WinRQS().Find("Uid", "TextBlock_1a3d",10)}
function Get_WinRQS_PadAlerts_TxtNonResidentIndicator(){return Get_WinRQS().Find("Uid", "CFTextBlock_c3cf",10)}
function Get_WinRQS_PadAlerts_LblResiLocation(){return Get_WinRQS().Find("Uid", "TextBlock_4bf7",10)} 
function Get_WinRQS_PadAlerts_TxtResidentLocation(){return Get_WinRQS().Find("Uid", "CFTextBlock_990a",10) } 
function Get_WinRQS_PadAlerts_LblInvestRiskLow(){return Get_WinRQS().Find("Uid", "TextBlock_c6a3",10)} 
function Get_WinRQS_PadAlerts_TxtInvestRiskLow(){return Get_WinRQS().Find("Uid", "CFTextBlock_4381",10) } 
function Get_WinRQS_PadAlerts_LblInvestRiskMedium(){ return Get_WinRQS().Find("Uid", "TextBlock_c610",10)} 
function Get_WinRQS_PadAlerts_TxtInvestRiskMedium() {return Get_WinRQS().Find("Uid", "CFTextBlock_f0cd",10)} 
function Get_WinRQS_PadAlerts_LblInvestRiskHigh(){return Get_WinRQS().Find("Uid", "TextBlock_6773",10)}   
function Get_WinRQS_PadAlerts_TxtInvestRiskHigh(){return Get_WinRQS().Find("Uid", "CFTextBlock_8249",10) } 
function  Get_WinRQS_PadAlerts_TxtTotalNetWorth(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_4d0c", 10);}
function  Get_WinRQS_PadAlerts_TxtAnnualIncome(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_f6dd", 10);} 
function  Get_WinRQS_PadAlerts_TxtProIndicor(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_0735", 10);}

function Get_WinRQS_PadAlerts_TxtActualInvestRiskLow(){return Get_WinRQS().Find("Uid", "CFTextBlock_b881",10)} 
function Get_WinRQS_PadAlerts_TxtActualInvestRiskMedium(){return Get_WinRQS().Find("Uid", "CFTextBlock_4f3a",10)}   
function Get_WinRQS_PadAlerts_TxtActualInvestRiskHigh(){ return Get_WinRQS().Find("Uid", "CFTextBlock_1aef",10)}
function Get_WinRQS_PadAlerts_LblBrancheCode(){return Get_WinRQS().Find("Uid", "TextBlock_e35a",10) }   
function Get_WinRQS_PadAlerts_TxtBrancheCode(){return Get_WinRQS().Find("Uid", "CFTextBlock_c541",10)}  
function Get_WinRQS_PadAlerts_LblIACode(){return Get_WinRQS().Find("Uid", "TextBlock_5865",10) }   
function Get_WinRQS_PadAlerts_TxtIACode(){ return Get_WinRQS().Find("Uid", "CFTextBlock_16b4",10)} 

function Get_WinRQS_PadAlerts_TxtIncome(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_e227", 10);}
function Get_WinRQS_PadAlerts_TxtShortTerm(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_bf1b", 10);}
function Get_WinRQS_PadAlerts_TxtLongTerm(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_be73", 10);}
function Get_WinRQS_PadAlerts_TxtMediumTerm(){return Get_WinRQS_Details().FindChild("Uid", "CFTextBlock_e488", 10);}

function Get_WinRQS_TabAlerts_CmbAlertStatusDatePicker(){return Get_WinRQS().FindChild("Uid", "ComboBox_f40b", 10);}

function Get_WinQueryLog_TabAlerts_DateFrom(){
      return Get_WinRQS().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",1], 10)} 
      
function Get_WinQueryLog_TabAlerts_DateTo(){
      return Get_WinRQS().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",2], 10)} 
      
function ChangeDateOfLastAlertStatus(dateFrom,dateTo){  
  // Changer le filte à Custom Dates  
  Get_WinRQS_TabAlerts_CmbAlertStatusDatePicker().Click();
  if(Get_SubMenus().Exists){
      if(language=="french"){
        Get_SubMenus().Find("Text","Dates modifiables",10).Click();
      }else{
        Get_SubMenus().Find("Text","Custom Dates",10).Click();
      };
  };
    
  Get_WinQueryLog_TabAlerts_DateFrom().CLick();
  Get_WinQueryLog_TabAlerts_DateFrom().Keys(dateFrom);//Set_StringValue
  
  Get_WinQueryLog_TabAlerts_DateTo().Click();
  Get_WinQueryLog_TabAlerts_DateTo().Keys(dateTo+"[Enter]");
}      
            
function Get_WinRQS_AlertDetailSection_BranchInfoTxt(){return Get_CroesusApp().FindChild("Uid", "TextBlock_1bcb", 10)}
function Get_WinRQS_AlertDetailSection_ClientInfoTxt(){return Get_CroesusApp().FindChild("Uid", "TextBlock_ece7", 10)}  

function Get_WinRQS_AlertDetailSection_ClientNumberName(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_702c", 10)}             
function Get_WinRQS_AlertDetailSection_AccountNumberName(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_b19c", 10)}   

function Get_WinRQS_AlertDetailSection_TxtResidenceLocation(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_990a", 10)} 
function Get_WinRQS_AlertDetailSection_TxtActualLow(){return Get_CroesusApp().FindChild("Uid", "TextBlock_b1b3", 10)}  

function Get_WinRQS_AlertDetailSection_TxtActualMedium(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_4f3a", 10)}  
function Get_WinRQS_AlertDetailSection_TxtActualHigh(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_1aef", 10)}                
function Get_WinRQS_AlertDetailSection_TxtOldIACodeName(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_e32f", 10)}   

function  Get_WinRQS_QuickFilterClick(){ 
        Get_WinRQS().Click(Get_WinRQS().Width-1930,Get_WinRQS().Height-967);}
        
function Get_WinRQS_Details_TransactionList(){ return  Get_WinRQS().FindChild("Uid", "TransactionList_a236", 10)}
function Get_WinRQS_AlertDetailSection_TxtProductType(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_7b21", 10)}
function Get_WinRQS_AlertDetailSection_TxtTest(){return Get_CroesusApp().FindChild("Uid", "CFTextBlock_47e9", 10)}

//Boutton Client Activités
function Get_WinRQS_TabAlerts_BtnClientActivities(){
        return Get_WinRQS().FindChild("Uid", "Button_7b32", 10)}
 
//--------------------------------Section Details de l'onglet Transaction Blotter de la fenêtre RQS--------------------------------------------    


/*********************Client Relationship Info************************/
function Get_WinRQS_PadTransBlotter_TxtCliRelNumName(){ return Get_WinRQS().Find("Uid", "CFTextBlock_87d0", 10)}     
function Get_WinRQS_PadTransBlotter_TxtTotalNetWorth(){return Get_WinRQS().Find("Uid", "CFTextBlock_1118", 10)} 
function Get_WinRQS_PadTransBlotter_TxtAnnualIncome(){ return Get_WinRQS().Find("Uid", "CFTextBlock_d2bd", 10)} 
function Get_WinRQS_PadTransBlotter_TxtClientRelTotalValue(){return Get_WinRQS().Find("Uid", "CFTextBlock_bf39", 10)}
function Get_WinRQS_PadTransBlotter_TxtInvestmentKnowledge(){return Get_WinRQS().Find("Uid", "CFTextBlock_8fbd", 10)} 
function Get_WinRQS_PadTransBlotter_TxtNonResidentIndicator(){return Get_WinRQS().Find("Uid", "CFTextBlock_b6ae", 10)}
function Get_WinRQS_PadTransBlotter_TxtResidentLocation(){return Get_WinRQS().Find("Uid", "CFTextBlock_e490", 10)}

/*********************Investement Objective************************/
function Get_WinRQS_PadTransBlotter_TxtIncome(){return Get_WinRQS().Find("Uid", "CFTextBlock_7aff", 10)}
function Get_WinRQS_PadTransBlotter_TxtShortTermeInvest(){return Get_WinRQS().Find("Uid", "CFTextBlock_8e2f", 10)}
function Get_WinRQS_PadTransBlotter_TxtMediumTermeInvest(){return Get_WinRQS().Find("Uid", "CFTextBlock_bac3", 10)}
function Get_WinRQS_PadTransBlotter_TxtLongTermeInvest(){return Get_WinRQS().Find("Uid", "CFTextBlock_1420", 10)}

/*********************Investement Risk************************/
function Get_WinRQS_PadTransBlotter_TxtInvestmentRiskLow(){return Get_WinRQS().Find("Uid", "CFTextBlock_afdd", 10)}
function Get_WinRQS_PadTransBlotter_TxtInvestmentRiskMedium(){return Get_WinRQS().Find("Uid", "CFTextBlock_c498", 10)}
function Get_WinRQS_PadTransBlotter_TxtInvestmentRiskHigh(){return Get_WinRQS().Find("Uid", "CFTextBlock_1bd2", 10)}

/*********************Branche Info************************/
function Get_WinRQS_PadTransBlotter_TxtBrancheCode(){return Get_WinRQS().Find("Uid", "CFTextBlock_c222", 10)}
function Get_WinRQS_PadTransBlotter_TxtIACode(){return Get_WinRQS().Find("Uid", "CFTextBlock_ab90", 10)}

function Get_WinRQS_BottomSection_TabNotesAndAlerts_TxtNote(){return Get_WinRQS_BottomSection().FindChild("Uid", "CFTextBlock_b2b7", 10)}
  
/*************************************************************Fenêtre note*****************************************************************/

//Radio Bouton Alerte manuelle de la fenêtre de création note
function Get_WinTransactionReview_RdBManualAlerte(){return Get_WinTransactionReview().FindChild("Uid", "RadioButton_314c", 10)}

//------------------------------------ Fenêtre dialogue de progression------------------------------

function Get_DlgProgressCroesus_BtnOK(){return Get_DlgProgressCroesus().FindChild("Uid", "Button_5293", 10)}  

function Get_WinRQS_TabAlerts_DgvAlerts_ChTest(){
      return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Test"], 10)}

function Get_WinRQS_ContextualMenu_AddColumn()           {return Get_SubMenus().FindChild("Uid", "MenuItem_587c", 10)};
function Get_WinRQS_ContextualMenu_DefaultConfiguration(){return Get_SubMenus().FindChild("Uid", "MenuItem_c549", 10)};
function Get_WinRQS_ContextualMenu_PositionMarketValue(){
    if (language == "french")
        return Get_CroesusApp().FindChild(["ClrClassName","WPFControlText"],["TextBlock", "Valeur de marché de la position (%)"], 10);
    else
        return Get_CroesusApp().FindChild(["ClrClassName","WPFControlText"],["TextBlock", "Position market value (%)"], 10);};