//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions


 /* Description : A partir du module « Modeles » , afficher la fenêtre « Ajouter un modèle » Par la clique droite de la souris  . 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_MenuBar_EditAdd()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
  Get_ModelsGrid().ClickR();
  var i = 0;
  while (Get_ModelsGrid_ContextualMenu().Exists == false && i < 10){
        Get_ModelsGrid().ClickR();
        i++; 
  }
  Get_ModelsGrid_ContextualMenu_Add().Click()
   
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
    else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  Get_WinModelInfo_BtnCancel().Click()
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close() 
}

 //Fonctions  (les points de vérification pour les scripts qui testent Add_Security)
function Check_Properties_French()
{
   //Model
   aqObject.CheckProperty(Get_WinModelInfo().Title, "OleValue", cmpEqual, "Ajouter un modèle");
   
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
   aqObject.CheckProperty(Get_WinModelInfo_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinModelInfo_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
   
   //tab Notes - tab grid 
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes().Header, "OleValue", cmpEqual, "Notes");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid().Header, "OleValue", cmpEqual, "Grille");
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   
   //les en-têtes des colonnes DefaultConfiguration 
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate().Content, "OleValue", cmpEqual, "Date de référence");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Créée par");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   
   //Conter le contenue de la liste (les colonnes qu’on peut ajouter)  
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797")  
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
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797")    
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate().Content, "OleValue", cmpEqual, "Date de référence");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Créée par");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   Log.Message("Le numéro de l'anomalie sur CX est : CROES-7797")   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChModificationDate().Content, "OleValue", cmpEqual, "Date de modification");
   
   //Remettre l’affichage par default 
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
    //btns
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Content, "OleValue", cmpEqual, "Aj_outer");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Content, "OleValue", cmpEqual, "Consulter");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Content, "OleValue", cmpEqual, "S_upprimer");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnPrint().Content, "OleValue", cmpEqual, "_Imprimer...");
   
   //tab Notes - tab summary
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary().Header, "OleValue", cmpEqual, "Sommaire");
   
   //tab Investment Objective 
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective().Header, "OleValue", cmpEqual, "Objectif de placement");
   
   //tab Documents
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments().Header, "OleValue", cmpEqual, "Documents");
}

function Check_Properties_English()
{
   //Model
   aqObject.CheckProperty(Get_WinModelInfo().Title, "OleValue", cmpEqual, "Add New Model");
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
   aqObject.CheckProperty(Get_WinModelInfo_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinModelInfo_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
   
   //tab Notes - tab grid 
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes().Header, "OleValue", cmpEqual, "Notes");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid().Header, "OleValue", cmpEqual, "Grid");
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   
   
   //les en-têtes des colonnes DefaultConfiguration 
   Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   Log.Message("CROES-7797");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate().Content, "OleValue", cmpEqual, "Effective Date");
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
   Log.Message("CROES-7797"); 
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate().Content, "OleValue", cmpEqual, "Effective Date");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Creation Date");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChCreatedBy().Content, "OleValue", cmpEqual, "Created by");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChNote().Content, "OleValue", cmpEqual, "Note");
   Log.Message("CROES-7797");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_ChModificationDate().Content, "OleValue", cmpEqual, "Modification Date");
   
   //btns
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Content, "OleValue", cmpEqual, "_Add");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay().Content, "OleValue", cmpEqual, "Display");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete().Content, "OleValue", cmpEqual, "De_lete");
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnPrint().Content, "OleValue", cmpEqual, "_Print...");
   
   //tab Notes - tab summary
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary().Header, "OleValue", cmpEqual, "Summary");
   
   //tab Investment Objective 
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective().Header, "OleValue", cmpEqual, "Investment Objective");
   
   //tab Documents
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments().Header, "OleValue", cmpEqual, "Documents");
}

function Check_Existence_Of_Controls()
{
   //Model
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtFullName(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtFullName(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtShortName(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_TxtShortName(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbType(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbType(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbCurrency(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbCurrency(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_DtpCreation(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_DtpCreation(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsChecked", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsEnabled", cmpEqual, true);
   
   // Underlying Accounts Summary
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtBalance(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtTotalValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_GrpUnderlyingAccountsSummary_TxtTotalValue(), "IsEnabled", cmpEqual, true);
   
   //btns
   aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_BtnOK(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
   //tab Notes - tab Grid
   Get_WinModelInfo_TabNotes().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes(), "IsSelected", cmpEqual, true);
   Get_WinModelInfo_TabNotes_TabGrid().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_TxtNote(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, false);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, false);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, false);
   
   
   Get_WinModelInfo_TabNotes_TabSummary().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabNotes_TabSummary_TxtSummary(), "IsVisible", cmpEqual, true);
   
   //tab Investment Objective 
   Get_WinModelInfo_TabInvestmentObjective().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsChecked", cmpEqual, false);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective(), "IsEnabled", cmpEqual, true);
   
   //tab Documents
   Get_WinModelInfo_TabDocuments().Click()
   aqObject.CheckProperty(Get_WinModelInfo_TabDocuments(), "IsSelected", cmpEqual, true);
}

