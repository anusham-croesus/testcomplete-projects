//USEUNIT Agenda_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Transactions_Get_functions

/* Description : A partir du module « Transactions » , afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

 function Survol_Tra_MenuBar_FilePrint()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 3000)
  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
  
  //afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Print().Click();
  
  Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Click();
  //Les points de vérification
  Check_Properties(language);
  Get_DlgDefinePrintingType_BtnOK().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Tra_Properties_French()}
  //Les points de vérification en anglais 
  else{Check_Print_Tra_Properties_English()}
  
  //Get_DlgPrinting_BtnOKForTransactionsAndAgenda().Click();
   if(Get_DlgInformation().Exists){  //EM : Modifié selon CROES-6167 
      var width = Get_DlgInformation().Get_Width();
      Get_DlgInformation().Click((width*(1/2)),73);         
   }

  Close_Croesus_AltF4();    
 }
 
 function Check_Properties(language)
{
  aqObject.CheckProperty(Get_DlgDefinePrintingType(), "Title", cmpEqual, GetData(filePath_Transactions,"Print",2,language)); 
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",3,language));
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnCancel().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",4,language));
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgDefinePrintingType_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  if(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().IsChecked==true)
  {
    aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",5,language))
  }
  else {
    aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",6,language))
  }
     
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns(), "IsEnabled", cmpEqual, true);
  
  if(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().IsChecked==true)
  {
     aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",8,language))
  }
  else {
     aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",7,language))
  }
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns(), "IsVisible", cmpEqual,true); 
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns(), "IsEnabled", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "Content", cmpEqual, GetData(filePath_Transactions,"Print",9,language));
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "IsEnabled", cmpEqual, true);
}

function Check_Print_Tra_Properties_French()
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print");
  Get_DlgPrint_BtnCancel().Click()
  aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Impression annulée");
}

function Check_Print_Tra_Properties_English()
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print");
  Get_DlgPrint_BtnCancel().Click() 
  aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Printing cancelled");   
}
