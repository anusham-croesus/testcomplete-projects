//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transaction » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Tra_ToolBar_btnQuickFilters_AddFilter()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
      
    Get_Toolbar_BtnQuickFilters().Click(); 
    Get_Toolbar_BtnQuickFilters().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        
    //Les points de vérification en français 
     if(language=="french"){ Check_AddFilter_Properties_French()} // la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
    else {Check_AddFilter_Properties_English()}  // la fonction est dans CommonCheckpoints
    
    //Les points de vérification: La présence des contrôles
    Check_AddFilter_Existence_Of_Controls() // la fonction est dans CommonCheckpoints
            
    Get_WinAddFilter_BtnCancel().Click();
      
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
