//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions


/* Description : Aller au module "Transaction" en cliquant sur BarModules-btnTransactions. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. Par la suite remettre la configuration par défaut */

function Survol_Tra_Grid_column_header()
{
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
   WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
   Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
       
  //Les points de vérification en français 
  Check_Properties(language)
     
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
    //Vérification des entêtes de colonnes par défaut 
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();

    Delay(3000);
    
    aqObject.CheckProperty(Get_Transactions_ListView_ChAcctNo().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChProcessing().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChTransaction().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",5,language));
    if(client == "US" ){
     Log.Message(" Le numéro de l'anomalie pour la branche est USDEV-341 mais pour Neo on a pas de jira ")
    } 
    aqObject.CheckProperty(Get_Transactions_ListView_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChType().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChSymbol().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChQuantity().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChPrice().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChCurrency().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",11,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChTotal().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChCommission().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",13,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChGainsLosses().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",14,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChAccruedInt().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",15,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChFees().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",16,language));
    if(client == "US" ){
    aqObject.CheckProperty(Get_Transactions_ListView_ChManualUnitCost().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",33,language));
    } 
    else{
    aqObject.CheckProperty(Get_Transactions_ListView_ChManualACB().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",17,language));}
    aqObject.CheckProperty(Get_Transactions_ListView_ChCashBalance().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",18,language));
    
    
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    if(client == "US" ){
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 11);
    } 
    else if(client == "CIBC"){
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 14);
    }
    else {
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 13);}
    
    //Vérification des entêtes de colonnes
    Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize(); 
    
    aqObject.CheckProperty(Get_Transactions_ListView_ChAcctNo().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",3,language));
    
    aqObject.CheckProperty(Get_Transactions_ListView_ChSource().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",32,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChSettlement().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",31,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChSecurity().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",30,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChRate().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",29,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChNote().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",28,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChName().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",27,language));   
    aqObject.CheckProperty(Get_Transactions_ListView_ChMVInd().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",24,language));
    if(client != "US" ){
    aqObject.CheckProperty(Get_Transactions_ListView_ChManualInvestCost().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",26,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChInvestCapGL().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",25,language));}
    aqObject.CheckProperty(Get_Transactions_ListView_ChInterestPortion().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",23,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",22,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",21,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChCashFlow().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",20,language));
       
    aqObject.CheckProperty(Get_Transactions_ListView_ChProcessing().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChTransaction().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",5,language));
    if(client == "US" ){
      Log.Message("D'aprés Sofia c'est le même texte qu'on a sur la US la prod donc on le garde en attendant de vérifier ça aprés");
    } 
    aqObject.CheckProperty(Get_Transactions_ListView_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChType().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChSymbol().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChQuantity().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChPrice().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChCurrency().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",11,language));
    Scroll();
    aqObject.CheckProperty(Get_Transactions_ListView_ChTotal().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChCommission().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",13,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChGainsLosses().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",14,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChAccruedInt().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",15,language));
    aqObject.CheckProperty(Get_Transactions_ListView_ChFees().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",16,language));
    if(client == "US" ){
    aqObject.CheckProperty(Get_Transactions_ListView_ChManualUnitCost().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",33,language)); } 
    else{
    aqObject.CheckProperty(Get_Transactions_ListView_ChManualACB().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",17,language));}
    aqObject.CheckProperty(Get_Transactions_ListView_ChCashBalance().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Grid_column_header",18,language));

    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore()
  
}

 function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_Transactions_ListView().get_ActualWidth()
    var ControlHeight=Get_Transactions_ListView().get_ActualHeight()
    for (i=1; i<=7; i++) { Get_Transactions_ListView().Click(ControlWidth-40, ControlHeight-3)}     
}

function Add_AllColumns()
{
    Get_Transactions_ListView_ChAcctNo().ClickR(); 
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    for(i=1; i<=count; i++)
    {
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_Transactions_ListView_ChAcctNo().ClickR();
    }  
}


