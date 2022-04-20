//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un filter » en cliquant sur Menubar - SearchAddFilters. 
 Vérifier la présence des contrôles et des étiquetés
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1772 */
 
 /*Description    : Combiner les deux façons pour ajouter un filtre
   Analyste d'auto: Abdel.M
   Date           : 15-01-2021
 */
 
 function Survol_Tit_AddFilter_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : Afficher la fenêtre « Ajouter un filter » par MenuBar *******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Ajouter un filter » par MenuBar");
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
        

// ********** Étape 3 : Afficher la fenêtre « Ajouter un filter » par Bouton Filter *******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Ajouter un filter » par Bouton Filter");
        //afficher la fenêtre « Ajouter un filter »
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_AddAFilter().Click();
        
        //Les points de vérification en français 
        if(language=="french"){ Check_AddFilter_Properties_French()} // la fonction est dansCommonCheckpoints
    
        //Les points de vérification en anglais 
        else {Check_AddFilter_Properties_English()}  // la fonction est dansCommonCheckpoints
    
        //Les points de vérification: La présence des contrôles
        Check_AddFilter_Existence_Of_Controls() // la fonction est dans CommonCheckpoints
    
        //Fermeture de la fenêtre « Ajouter un filter »        
        Get_WinAddFilter_BtnCancel().Click();
      
    }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 4 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}
