//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Tit_MenuBar_Search_QuickFilters_Manage
//USEUNIT Global_variables

/* Description : A partir du module « Titre » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Toolbar -QuickFilters - Manage. 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1808*/
 
 function Survol_Tit_ToolBar_QuickFilters_Manage()
 {
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
   Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
   Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters().Click()
       
    //Les points de vérification en français 
     if(language=="french"){Check_Properties_French()}//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    //Les points de vérification en anglais 
    else {Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
     //La présence des composants 
    Check_Existence_Of_Controls()//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
    Get_WinQuickFiltersManager_BtnClose().Click()
      
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
    //Sys.Browser("iexplore").Close();
 }