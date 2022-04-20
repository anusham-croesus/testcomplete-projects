//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/* Description : Aller au module "Modeles". Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. Par la suite remettre la configuration par défaut */

function Survol_Mod_Grid_column_header()
{
   Login(vServerModeles, userName , psw ,language);
   Get_ModulesBar_BtnModels().Click()
      
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  
  Get_ModelsGrid_ChName().ClickR()
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close()
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties_English()
{
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
   //Default Configuration
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   aqObject.CheckProperty(Get_ModelsGrid_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_ModelsGrid_ChModelNo().Content, "OleValue", cmpEqual, "Model No.");
   aqObject.CheckProperty(Get_ModelsGrid_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_ModelsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_ModelsGrid_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue().Content, "OleValue", cmpEqual, "Underlying Total Value");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance().Content, "OleValue", cmpEqual, "Underlying Balance");
   aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash().Content, "OleValue", cmpEqual, "Excess Cash");
   if (client == "CIBC"){                 //Adapté pour CIBC
          aqObject.CheckProperty(Get_ModelsGrid_ChUpdatedOn().Content, "OleValue", cmpEqual, "Updated on");
          aqObject.CheckProperty(Get_ModelsGrid_ChInactive().Content, "OleValue", cmpEqual, "Inactive");
          }
   else
          aqObject.CheckProperty(Get_ModelsGrid_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");
   
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual,3);//en réalité dans la liste il ay 2 items , anomalie?  
   
   //All columns
   Add_AllColumns()
    
   aqObject.CheckProperty(Get_ModelsGrid_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_ModelsGrid_ChFullName().Content, "OleValue", cmpEqual, "Full Name");
   aqObject.CheckProperty(Get_ModelsGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Creation Date");
   aqObject.CheckProperty(Get_ModelsGrid_ChModelNo().Content, "OleValue", cmpEqual, "Model No.");
   
   aqObject.CheckProperty(Get_ModelsGrid_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_ModelsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_ModelsGrid_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue().Content, "OleValue", cmpEqual, "Underlying Total Value");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance().Content, "OleValue", cmpEqual, "Underlying Balance");
   aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash().Content, "OleValue", cmpEqual, "Excess Cash");
   if (client == "CIBC"){             //Adapté pour CIBC
          aqObject.CheckProperty(Get_ModelsGrid_ChUpdatedOn().Content, "OleValue", cmpEqual, "Updated on");
          aqObject.CheckProperty(Get_ModelsGrid_ChInactive().Content, "OleValue", cmpEqual, "Inactive");
          }
   else
          aqObject.CheckProperty(Get_ModelsGrid_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");
   
   //Default Configuration
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore() 
}

function Check_Properties_French()
{
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
   //Default Configuration
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
   
   aqObject.CheckProperty(Get_ModelsGrid_ChName().Content, "OleValue", cmpEqual, "Nom");
   aqObject.CheckProperty(Get_ModelsGrid_ChModelNo().Content, "OleValue", cmpEqual, "No de modèle");
   aqObject.CheckProperty(Get_ModelsGrid_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
   aqObject.CheckProperty(Get_ModelsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_ModelsGrid_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue().Content, "OleValue", cmpEqual, "Valeur totale sous-jacente");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance().Content, "OleValue", cmpEqual, "Solde sous-jacent");
   aqObject.CheckProperty(Get_ModelsGrid_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");
   aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash().Content, "OleValue", cmpEqual, "Excédent d'encaisse");//Le changement a été fait selon le fichier Excel Modification_Documentation.xlsx
   if (client == "CIBC")            //Adapté pour CIBC
          aqObject.CheckProperty(Get_ModelsGrid_ChInactive().Content, "OleValue", cmpEqual, "Inactif");
   
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual,3);//en réalité dans la liste il ay 2 items , anomalie?  
   
   //All columns
   Add_AllColumns()
   
   aqObject.CheckProperty(Get_ModelsGrid_ChName().Content, "OleValue", cmpEqual, "Nom");
   aqObject.CheckProperty(Get_ModelsGrid_ChFullName().Content, "OleValue", cmpEqual, "Nom complet");
   aqObject.CheckProperty(Get_ModelsGrid_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
   aqObject.CheckProperty(Get_ModelsGrid_ChModelNo().Content, "OleValue", cmpEqual, "No de modèle");
   aqObject.CheckProperty(Get_ModelsGrid_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
   aqObject.CheckProperty(Get_ModelsGrid_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_ModelsGrid_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue().Content, "OleValue", cmpEqual, "Valeur totale sous-jacente");
   aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance().Content, "OleValue", cmpEqual, "Solde sous-jacent");
   aqObject.CheckProperty(Get_ModelsGrid_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");
   aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash().Content, "OleValue", cmpEqual, "Excédent d'encaisse");//Le changement a été fait selon le fichier Excel Modification_Documentation.xlsx
   if (client == "CIBC")        //Adapté pour CIBC
          aqObject.CheckProperty(Get_ModelsGrid_ChInactive().Content, "OleValue", cmpEqual, "Inactif");
   
   
   //Default Configuration
   Get_ModelsGrid_ChName().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore()     
}

function Add_AllColumns()
{
  Get_ModelsGrid_ChName().ClickR()
    while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_ModelsGrid_ChName().ClickR()
    } 
}