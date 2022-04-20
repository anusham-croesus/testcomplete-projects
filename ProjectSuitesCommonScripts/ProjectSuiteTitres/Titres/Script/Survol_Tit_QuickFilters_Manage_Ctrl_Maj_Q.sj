//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Tit_MenuBar_Search_QuickFilters_Manage
//USEUNIT Global_variables

/* Description : A partir du module « Titre » , afficher la fenêtre « Gestionnaire de filtes rapides » par [Ctrl+Maj+Q in automation 9], [Ctrl+Maj+F in automation 10] 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1807*/
 
 function Survol_Tit_QuickFilters_Manage_Ctrl_Maj_Q() 
 {
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Get_SecurityGrid().Keys("^F"); //_Ctrl_Maj_Q in automation 9 
       
    //Les points de vérification en français 
     if(language=="french"){Check_Properties_French()}//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    //Les points de vérification en anglais 
    else {Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
     //La présence des composants 
    Check_Existence_Of_Controls()//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
    Get_WinQuickFiltersManager_BtnClose().Click()
      
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
 }

