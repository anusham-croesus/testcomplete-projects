//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions


/* Description : A partir du module « Transactions » , afficher la fenêtre « Filter » en cliquant sur MenuBar - fonctions-Filter. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_ContextualMenu_Functions_Filter()
{

   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){      
    
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
      WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000); 
      
      //afficher la fenêtre « Filter » en cliquant sur MenuBar - fonctions-Filter.
      Get_MainWindow().Keys("[Apps]");
      Get_Transactions_ContextualMenu_Functions().Click();
      Get_Transactions_ContextualMenu_Functions_Filter().Click();
      WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]); 
      
      //Les points de vérification  
      Check_Properties(language)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
   }
   else {
      Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   //La fermeture de la fenêtre 
   Get_WinFilter_BtnCancel().Click();

   
   //afficher la fenêtre « Filter » en cliquant sur MenuBar - EditFunctions_Filter. Vérifier la présence des contrôles et des étiquetés   
   Get_MenuBar_Edit().OpenMenu();
   Get_MenuBar_Edit_FunctionsForTransactions().OpenMenu();
   Get_MenuBar_Edit_FunctionsForTransactions_Filter().Click();
          
   //Les points de vérification 
   WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]); 
   Check_Properties(language)//la fonction est dans le script Survol_Tra_ContextualMenu_Functions_Filter
   
   
    //La fermeture de la fenêtre 
   Get_WinFilter_BtnCancel().Click();
   
   Close_Croesus_AltF4();
}
function Check_Properties(language)
{
  aqObject.CheckProperty(Get_WinFilter().Title, "OleValue", cmpEqual, GetData(filePath_Transactions,"Filter",2,language));
  aqObject.CheckProperty(Get_WinFilter_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Filter",3,language));
  aqObject.CheckProperty(Get_WinFilter_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Filter",4,language));
  aqObject.CheckProperty(Get_WinFilter_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_BtnApply().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Filter",5,language));
  aqObject.CheckProperty(Get_WinFilter_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //grp account
  aqObject.CheckProperty(Get_WinFilter_GrpAccount(), "Header", cmpEqual, GetData(filePath_Transactions,"Filter",6,language));
  aqObject.CheckProperty(Get_WinFilter_GrpAccount_TxtAccount(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinFilter_GrpAccount_TxtAccount(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpAccount_BtnAccount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpAccount_BtnAccount(), "IsEnabled", cmpEqual, true);
  
  //processing date
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate(), "Header", cmpEqual, GetData(filePath_Transactions,"Filter",7,language));
  
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_LblStart(), "Text", cmpEqual, GetData(filePath_Transactions,"Filter",8,language));
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_DtpStart(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_DtpStart(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_LblEnd(), "Text", cmpEqual, GetData(filePath_Transactions,"Filter",9,language));
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_DtpEnd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpProcessingDate_DtpEnd(), "IsEnabled", cmpEqual, true);
  
  //type
  aqObject.CheckProperty(Get_WinFilter_GrpType(), "Header", cmpEqual, GetData(filePath_Transactions,"Filter",10,language));
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAdjustment(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",11,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAdjustment(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAdjustment(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkContribution(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",12,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkContribution(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkContribution(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDividends(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",13,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDividends(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDividends(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkFees(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",14,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkFees(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkFees(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkJournalEntry(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",15,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkJournalEntry(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkJournalEntry(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkReceipt(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",16,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkReceipt(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkReceipt(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransfer(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",17,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransfer(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransfer(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAssignment(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",18,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAssignment(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkAssignment(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCorrection(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",19,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCorrection(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCorrection(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDonation(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",20,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDonation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDonation(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGST(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",21,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGST(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGST(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkManagementFee(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",22,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkManagementFee(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkManagementFee(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkRedemption(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",23,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkRedemption(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkRedemption(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransferDisposition(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",24,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransferDisposition(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkTransferDisposition(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValue(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",25,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValue(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDelivery(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",26,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDelivery(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDelivery(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExchange(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",27,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExchange(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExchange(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGrossAmount(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",28,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGrossAmount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkGrossAmount(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkMiscellaneous(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",29,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkMiscellaneous(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkMiscellaneous(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSell(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",30,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSell(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSell(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWithdrawal(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",31,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWithdrawal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWithdrawal(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValueAdj(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",32,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValueAdj(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBookValueAdj(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDeposit(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",33,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDeposit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDeposit(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExercise(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",34,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExercise(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExercise(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkHST(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",35,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkHST(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkHST(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkNonResidentTax(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",36,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkNonResidentTax(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkNonResidentTax(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSplit(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",37,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSplit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSplit(), "IsEnabled", cmpEqual, true);
  // modifier 'Witholding tax' par 'Withholding tax' suite a l'anomalie : CROES-3652
  Log.Message("j'ai modifié 'Witholding tax' par 'Withholding tax' suite a l'anomalie : CROES-3652");
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWitholdingTax(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",38,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWitholdingTax(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkWitholdingTax(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBuy(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",39,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBuy(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkBuy(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDepositoryFee(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",40,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDepositoryFee(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkDepositoryFee(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExpiration(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",41,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExpiration(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkExpiration(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkInterest(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",42,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkInterest(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkInterest(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkPST(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",43,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkPST(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkPST(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSubstitution(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",44,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSubstitution(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkSubstitution(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnSelectAll().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Filter",45,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnSelectAll(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnSelectAll(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnRemoveAll().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Filter",46,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnRemoveAll(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_BtnRemoveAll(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCashFlow(), "Content", cmpEqual, GetData(filePath_Transactions,"Filter",47,language));
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCashFlow(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinFilter_GrpType_ChkCashFlow(), "IsEnabled", cmpEqual, true);
}