//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Toolbar -QuickFilters - Manage. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Ord_QuickFilters_Manage_Ctrl_Maj_Q()
 {
   var module="ordres"
   Login(vServerOrders, userName , psw ,language);
   Get_ModulesBar_BtnOrders().Click()
   Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 15000);
   WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true); 
   
   Get_MainWindow().Keys("^F"); //_Ctrl_Maj_Q in automation 9 
   
    //Les points de vérification en français 
     if(language=="french"){Check_QuickFiltersManage_Properties_French(module)}//la fonction est dans Common_functions
    //Les points de vérification en anglais 
    else {Check_QuickFiltersManage_Properties_English(module)} //la fonction est dans le script Common_functions
    
     //La présence des composants 
    Check_QuickFiltersManage_Existence_Of_Controls(module)//la fonction est dans Common_functions
    
    Get_WinQuickFiltersManager_BtnClose().Click()
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }