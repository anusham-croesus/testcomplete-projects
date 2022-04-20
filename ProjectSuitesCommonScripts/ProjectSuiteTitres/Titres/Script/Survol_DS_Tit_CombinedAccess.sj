//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT ExcelUtils

/* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 /*Description    : Combiner les deux façons pour afficher les data source
   Date           : 22-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function Survol_DS_Tit_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : Vérifier Column Grid Header *******************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 2: Vérifier Column Grid Header");
        Get_ModulesBar_BtnSecurities().Click()
       
        //Les points de vérification en français 
        if(language=="french"){ Check_Properties_French()}   
        //Les points de vérification en anglais 
        else {Check_Properties_English()}
        

// ********** Étape 3 : Vérifier SearchAddFilter par MenuBar  *******************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 3: Vérifier SearchAddFilter par MenuBar");
        
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_QuickFilters().OpenMenu();
        Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
    
        Check_Properties(language);
    }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 5 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
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
    Get_SecurityGrid_ChDescription().ClickR()
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
    
    Add_AllColumns()
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    

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

//Fonctions  (les points de vérification pour les scripts qui testent Add_Filter)
function Check_Properties(language)
{    
    //Vérification des textes 
    aqObject.CheckProperty(Get_WinAddFilter().Title, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",1,language))
   
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",2,language));      
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel().Content.Text, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",3,language));
    aqObject.CheckProperty(Get_WinAddFilter_LblDescription().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",4,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition().Header, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",5,language));

    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblField().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",6,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblOperator().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",7,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblValue().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",8,language));  
    
    //Vérification de contrôles 
    aqObject.CheckProperty(Get_WinAddFilter_TxtDescription(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_TxtDescription(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsEnabled", cmpEqual, true); 
       
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsEnabled", cmpEqual, true);
      
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsEnabled", cmpEqual, true); 
    
}

