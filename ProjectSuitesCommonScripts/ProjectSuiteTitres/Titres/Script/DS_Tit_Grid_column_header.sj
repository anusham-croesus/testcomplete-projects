//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions


/* Description : Aller au module "Titre" en cliquant sur BarModules-btnSecurities. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. Par la suite remettre la configuration par défaut */

function Survol_Tit_Grid_column_header()
{
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
       
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}   
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
   Close_Croesus_MenuBar();
//Sys.Browser("iexplore").Close()
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties_English(language)
{
    Get_SecurityGrid_ChDescription().ClickR()
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
    var i=0;
    aqObject.CheckProperty(Get_SecurityGrid_ChDescription().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i));
    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChType().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChBid().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChAsk().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChClose().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChMY().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_SecurityGrid_ChDescription().ClickR()
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
    
    Add_AllColumns()
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    
    aqObject.CheckProperty(Get_SecurityGrid_ChDescription().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChDiscrMgmt().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChDividend().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChDividendDate().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));    
    aqObject.CheckProperty(Get_SecurityGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChFrequency().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChInitialAmount().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChInterest().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChManager().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChMandate().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChMarket().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChMaturity().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChNonRedeemable().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChRegion().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSubsequentAmount().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChType().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChBid().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChAsk().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    Scroll()
    Delay(200)
    aqObject.CheckProperty(Get_SecurityGrid_ChClose().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChMY().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, Project.Variables.Grid_column_header.Item(language,i++));
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore()
  
}


function Check_Properties_French()
{

//    Get_SecurityGrid_ChDescription().ClickR()
//    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
//    
//    aqObject.CheckProperty(Get_SecurityGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
//    aqObject.CheckProperty(Get_SecurityGrid_ChType().Content, "OleValue", cmpEqual, "Type");  
//    aqObject.CheckProperty(Get_SecurityGrid_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
//    aqObject.CheckProperty(Get_SecurityGrid_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
//    aqObject.CheckProperty(Get_SecurityGrid_ChClose().Content, "OleValue", cmpEqual, "Clôture");
//    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice().Content, "OleValue", cmpEqual, "Devise prix");
//    aqObject.CheckProperty(Get_SecurityGrid_ChMY().Content, "OleValue", cmpEqual, "RM (%)");
//    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");
//    aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclu de la facturation");
       
    Get_SecurityGrid_ChDescription().ClickR()
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
    
    Add_AllColumns()
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    
//    aqObject.CheckProperty(Get_SecurityGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
//    aqObject.CheckProperty(Get_SecurityGrid_ChRegion().Content, "OleValue", cmpEqual, "Région");
//    aqObject.CheckProperty(Get_SecurityGrid_ChNonRedeemable().Content, "OleValue", cmpEqual, "Non rachetable");         
//    aqObject.CheckProperty(Get_SecurityGrid_ChSubsequentAmount().Content, "OleValue", cmpEqual, "Montant subséquent");
//    aqObject.CheckProperty(Get_SecurityGrid_ChInitialAmount().Content, "OleValue", cmpEqual, "Montant initial");
//    aqObject.CheckProperty(Get_SecurityGrid_ChMandate().Content, "OleValue", cmpEqual, "Mandat");
//    aqObject.CheckProperty(Get_SecurityGrid_ChInterest().Content, "OleValue", cmpEqual, "Intérêt");
//    aqObject.CheckProperty(Get_SecurityGrid_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
//    aqObject.CheckProperty(Get_SecurityGrid_Ch.Content, "OleValue", cmpEqual, "Gestionnaire");
//    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity().Content, "OleValue", cmpEqual, "Gestion discr.");
//    aqObject.CheckProperty(Get_SecurityGrid_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
//    aqObject.CheckProperty(Get_SecurityGrid_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");  
//    aqObject.CheckProperty(Get_SecurityGrid_ChDividend().Content, "OleValue", cmpEqual, "Dividende");
//    aqObject.CheckProperty(Get_SecurityGrid_ChDividendDate().Content, "OleValue", cmpEqual, "Date de dividende");
//    aqObject.CheckProperty(Get_SecurityGrid_ChMarket().Content, "OleValue", cmpEqual, "Bourse");  
//    aqObject.CheckProperty(Get_SecurityGrid_ChType().Content, "OleValue", cmpEqual, "Type");   
//    aqObject.CheckProperty(Get_SecurityGrid_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
//    aqObject.CheckProperty(Get_SecurityGrid_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
//    Scroll()   
//    aqObject.CheckProperty(Get_SecurityGrid_ChClose().Content, "OleValue", cmpEqual, "Clôture");
//    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice().Content, "OleValue", cmpEqual, "Devise prix");
//    aqObject.CheckProperty(Get_SecurityGrid_ChMY().Content, "OleValue", cmpEqual, "RM (%)");
//    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");

    if(Get_SecurityGrid_ChExcludeFromBilling().Exists)
    {
      aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclu de la facturation");
    }
    else
    {
      Scroll()
      aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling().Content, "OleValue", cmpEqual, "Exclu de la facturation");      
    }
    
}

function Add_AllColumns()
{
   Get_SecurityGrid_ChSubCategory().ClickR()
    while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_SecurityGrid_ChSubCategory().ClickR()
    }  
}

function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_SecurityGrid().get_ActualWidth()
    var ControlHeight=Get_SecurityGrid().get_ActualHeight()
    //for (i=1; i<=28; i++) { Get_SecurityGrid().Click(ControlWidth-20, ControlHeight-5)} 
    Get_SecurityGrid().Click(ControlWidth-40, ControlHeight-5)
}

