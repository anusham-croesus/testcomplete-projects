//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT Global_variables


/**
    Description : Valider l'annulation de l'impression du brouillon de travail dans le module Transactions
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1997
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_1997_Tra_Validate_Cancellation_Printing_Draft_Job()
{
  try {
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1997");
      Login(vServerTransactions, userName , psw ,language);
      
      //cliquer sur module Transactions
      Get_ModulesBar_BtnTransactions().Click();
        
      //Wait Transactions List View 
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        Delay(10000)
        //Set the default configuration of columns in the grid
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
        
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        Delay(15000)
      // afficher la fenêtre « Print » avec AltP
      Get_Transactions_ListView().Click();
      Get_MainWindow().Keys("~p");
      //Get_MenuBar_File().OpenMenu();
      //Get_MenuBar_File_Print().Click();
      
     if(!Get_DlgDefinePrintingType().Exists){ Log.Error("On attente de loger un Jira. Il n'y a pas la fenêtre de choix de type d'impression.");}
  
      Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Click();
      Get_DlgDefinePrintingType_BtnOK().Click();
      //Les points de vérifications :  
      //Vérifier Boîte de dialogue impression
      aqObject.CheckProperty(Get_DlgPrint(), "Visible", cmpEqual, true);
        
      //Les points de vérification  
      Check_Print_Tra_Properties(language);
  
      //Get_DlgPrinting_BtnOKForTransactionsAndAgenda().Click();
     if(Get_DlgInformation().Exists){   
        var width = Get_DlgInformation().Get_Width();
        Get_DlgInformation().Click((width*(1/2)),73);}
        
      }

  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }  
          
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
  else{
    aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",6,language))
  }
     
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoStaticNonManageableColumns(), "IsEnabled", cmpEqual, true);
  
  if(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().IsChecked==true)
  {
     aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",8,language))
  }
  else{
     aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Print",7,language))
  }
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns(), "IsVisible", cmpEqual,true); 
  aqObject.CheckProperty(Get_DlgDefinePrintingType_RdoDynamicManageableColumns(), "IsEnabled", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "Content", cmpEqual, GetData(filePath_Transactions,"Print",9,language));
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(), "IsEnabled", cmpEqual, true);
}

function Check_Print_Tra_Properties(language)
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print"); // la langue est de VM est en anglais
  Get_DlgPrint_BtnCancel().Click() 
  if(language=="french")
  {     
      aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Impression annulée");
  }

  if(language=="english")
  {      
      aqObject.CheckProperty(Get_DlgInformation(), "WPFControlText", cmpEqual, "Information"); 
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, "Printing cancelled");   
  }
  
}


