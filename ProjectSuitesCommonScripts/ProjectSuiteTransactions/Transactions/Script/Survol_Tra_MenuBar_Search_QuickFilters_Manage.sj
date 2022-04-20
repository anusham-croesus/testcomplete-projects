//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transactions » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Tra_MenuBar_Search_QuickFilters_Manage()
 {
    var module="transactions"
    
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();    
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
    
    //afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_Manage().Click();
        
    //Les points de vérification en français 
     if(language=="french"){Check_QuickFiltersManage_Properties_French(module)}//la fonction est dans CommonCheckpoints
    //Les points de vérification en anglais 
    else {Check_QuickFiltersManage_Properties_English(module)} //la fonction est dans le script CommonCheckpoints  
     //La présence des composants 
    Check_QuickFiltersManage_Existence_Of_Controls(module)//la fonction est dans CommonCheckpoints
    
    Get_WinQuickFiltersManager_BtnClose().Click()
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 