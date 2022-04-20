﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un filter » en cliquant sur Menubar - SearchAddFilters. 
 Vérifier la présence des contrôles et des étiquetés
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1772 */
 
 function Survol_Tit_MenuBar_SearchAddFilter()
 {
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
    //afficher la fenêtre « Ajouter un filter »
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
        
    //Les points de vérification en français 
     if(language=="french"){ Check_AddFilter_Properties_French()} // la fonction est dansCommonCheckpoints
    
    //Les points de vérification en anglais 
    else {Check_AddFilter_Properties_English()}  // la fonction est dansCommonCheckpoints
    
    //Les points de vérification: La présence des contrôles
    Check_AddFilter_Existence_Of_Controls() // la fonction est dans CommonCheckpoints
    
    //Fermeture de la fenêtre « Ajouter un filter »        
    Get_WinAddFilter_BtnCancel().Click();
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
