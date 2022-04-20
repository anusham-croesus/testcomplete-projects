//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transaction » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Tra_MenuBar_SearchAddFilter()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().WaitProperty("VisibleOnScreen", true, 5000);
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]);
        
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
 