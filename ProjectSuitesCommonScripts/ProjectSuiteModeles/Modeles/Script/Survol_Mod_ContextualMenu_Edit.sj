//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions


 /* Description : Dans le du module « Modeles », rechercher un Modèle ~M-00002-0 , afficher la fenêtre « Modèle Info » Par ContextualMenu - Edit. 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_ContextualMenu_Edit()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_TestedModel(); 
  
  Get_MainWindow().Keys("[Apps]")
  Get_ModelsGrid_ContextualMenu_Edit().Click()
   
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
   else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  
  ClickToClose_WinModelInfo(); 
  
  Close_Croesus_SysMenu()
}


//******************************************************************FUNCTIONS************************************************************
//***************************************************************************************************************************************
function ClickToClose_WinModelInfo()
{
   if (client == "BNC" ){
     Get_WinModelInfo_BtnClose().Click();
  }
  else{
    Get_WinModelInfo_BtnCancel().Click();
  } 
}

function CloseByESC_WinModelInfo()
{
  if (client == "BNC" ){
    Get_WinModelInfo_BtnClose().Keys("[Esc]")
  }
  else{
    Get_WinModelInfo_BtnCancel().Keys("[Esc]")
  }
}


function Get_TestedModel()
{
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    Search_Model("~M-00002-0")
  }
  else{//Dans la BD de RJ les numéros de modelés ne sont pas pareils 
    Search_Model("~M-00003-0")
  }
}

 //Fonctions  (les points de vérification pour les scripts qui testent Add_Security)
function Check_Properties_French()
{
   //Model
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel().Header, "OleValue", cmpEqual, "Modèle");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblFullName().Text, "OleValue", cmpEqual, "Nom complet: ");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblShortName().Text, "OleValue", cmpEqual, "Nom abrégé:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblType().Text, "OleValue", cmpEqual, "Type:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblIACode().Text, "OleValue", cmpEqual, "Code de CP:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblCreation().Text, "OleValue", cmpEqual, "Création:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive().Content, "OleValue", cmpEqual, "Actif");
   
   // Underlying Accounts Summary
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary().Header, "OleValue", cmpEqual, "Sommaire des comptes sous-jacents");
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblBalance().Content, "OleValue", cmpEqual, "Solde:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblTotalValue().Content, "OleValue", cmpEqual, "Valeur totale:");
   
   //btns
   //aqObject.CheckProperty(Get_WinModelInfo_BtnCancel().Content, "OleValue", cmpEqual, "Annuler"); // N’existe pas dans automation 9 
   //aqObject.CheckProperty(Get_WinModelInfo_BtnOK().Content, "OleValue", cmpEqual, "OK"); //N’existe pas dans automation 9 
   aqObject.CheckProperty(Get_WinModelInfo_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");//
   
   //tab Notes - tab grid 
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes().Header, "OleValue", cmpEqual, "Notes");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid().Header, "OleValue", cmpEqual, "Grille");
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   
   //les en-têtes des colonnes DefaultConfiguration 
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Créée par");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   
   //Conter le contenue de la liste (les colonnes qu’on peut ajouter)  
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu() 
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797") ;
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 2); // En réalité dans la liste il y a 1 colonne qu’on peut ajouter 
   
    //Faire apparaitre tous les en-têtes des colonnes
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
    };
   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Créée par");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797");  
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChModificationDate().Content, "OleValue", cmpEqual, "Date de modification");
   
    //btns
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Content, "OleValue", cmpEqual, "Aj_outer");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Content, "OleValue", cmpEqual, "Consulter");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Content, "OleValue", cmpEqual, "S_upprimer");
   
   //tab Notes - tab summary
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary().Header, "OleValue", cmpEqual, "Sommaire");
   
   //tab Investment Objective 
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective().Header, "OleValue", cmpEqual, "Objectif de placement");
   
   //tab Documents
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments().Header, "OleValue", cmpEqual, "Documents");
   
   Get_WinModelInfo_TabDocuments().Click()
   
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, "Commentaires");
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, "Mo_difier");
}

function Check_Properties_English()
{
   //Model   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel().Header, "OleValue", cmpEqual, "Model");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblFullName().Text, "OleValue", cmpEqual, "Full Name:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblShortName().Text, "OleValue", cmpEqual, "Short Name:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblType().Text, "OleValue", cmpEqual, "Type:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblIACode().Text, "OleValue", cmpEqual, "IA Code:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_LblCreation().Text, "OleValue", cmpEqual, "Creation:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive().Content, "OleValue", cmpEqual, "Active");
   
   // Underlying Accounts Summary
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary().Header, "OleValue", cmpEqual, "Underlying Accounts Summary");
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblBalance().Content, "OleValue", cmpEqual, "Balance:");
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_LblTotalValue().Content, "OleValue", cmpEqual, "Total Value:");
   
   //btns
//   aqObject.CheckProperty(Get_WinModelInfo_BtnCancel().Content, "OleValue", cmpEqual, "Cancel"); // N’existe pas dans automation 9 
//   aqObject.CheckProperty(Get_WinModelInfo_BtnOK().Content, "OleValue", cmpEqual, "OK"); // N’existe pas dans automation 9 
   aqObject.CheckProperty(Get_WinModelInfo_BtnClose().Content, "OleValue", cmpEqual, "_Close");
   
   //tab Notes - tab grid 
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes().Header, "OleValue", cmpEqual, "Notes");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid().Header, "OleValue", cmpEqual, "Grid");
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   
   //les en-têtes des colonnes DefaultConfiguration 
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Creation Date");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Created by");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   
   //Conter le contenue de la liste (les colonnes qu’on peut ajouter)  
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()  
   Log.Message("CROES-7797");
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 2); // En réalité dans la liste il y a 1 colonne qu’on peut ajouter 
   
   //Faire apparaitre tous les en-têtes des colonnes
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
    };
    
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Creation Date");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Created by");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   Log.Message("CROES-7797");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChModificationDate().Content, "OleValue", cmpEqual, "Modification Date");
      
   //btns
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Content, "OleValue", cmpEqual, "_Add");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Content, "OleValue", cmpEqual, "Display");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Content, "OleValue", cmpEqual, "De_lete");
   
   //tab Notes - tab summary
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary().Header, "OleValue", cmpEqual, "Summary");
   
   //tab Investment Objective 
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective().Header, "OleValue", cmpEqual, "Investment Objective");
   
   //tab Documents
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments().Header, "OleValue", cmpEqual, "Documents");
   Get_WinModelInfo_TabDocuments().Click()
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, "Comments");
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, "_Edit");
}

function Check_Existence_Of_Controls(btn)
{
   //Model
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtFullName(), "IsVisible", cmpEqual, true);
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtFullName(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtFullName(), "IsEnabled", cmpEqual, true);
   }
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtShortName(), "IsVisible", cmpEqual, true);
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtShortName(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtShortName(), "IsEnabled", cmpEqual, true);
   }
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbType(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbType(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IsVisible", cmpEqual, true);
   if(client == "US" || client == "TD" || client == "CIBC"){
     aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IsEnabled", cmpEqual, true);
   } 
   else{
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IsEnabled", cmpEqual, false);}
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbCurrency(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbCurrency(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_DtpCreation(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_DtpCreation(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsVisible", cmpEqual, true);
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, true);
   }
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsChecked", cmpEqual, true);
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, true);
   }
   
   // Underlying Accounts Summary
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtBalance(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtTotalValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtTotalValue(), "IsReadOnly", cmpEqual, true);
   
   //btns
   //aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsVisible", cmpEqual, true); // N’existe pas dans automation 9 
   //aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsEnabled", cmpEqual, true); 
   
  //aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsVisible", cmpEqual, true); //N’existe pas dans automation 9 
   //aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsEnabled", cmpEqual, true);
   
    if (client == "BNC" ){
        aqObject.CheckProperty(Get_WinModelInfo_BtnClose(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinModelInfo_BtnClose(), "IsEnabled", cmpEqual, true);
    }
    else{//RJ
        aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsEnabled", cmpEqual, true);       
    }

   
   //tab Notes - tab Grid
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes(), "IsSelected", cmpEqual, true);
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_TxtNote(), "IsVisible", cmpEqual, true);
   
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, true);
   }
   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, false);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
   
   Get_WinModelInfo_TabNotes_TabSummary().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary_TxtSummary(), "IsVisible", cmpEqual, true);
   
   //tab Investment Objective 
   Get_WinModelInfo_TabInvestmentObjective().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsChecked", cmpEqual, false);
   
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsEnabled", cmpEqual, true);
   }
   
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(), "IsVisible", cmpEqual, true);
   
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(), "IsEnabled", cmpEqual, true);
   }
   
   //tab Documents
   Get_WinModelInfo_TabDocuments().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments(), "IsSelected", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsVisible", cmpEqual, true);
   if (client == "BNC" ){
       aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsEnabled", cmpEqual, false);
   }
   else{
      aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsEnabled", cmpEqual, true);
   }
    
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsReadOnly", cmpEqual, true);
      
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PersonalDocuments_TvwDocumentsForClientAndModel(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments(), "IsVisible", cmpEqual, true);
}


