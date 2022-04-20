//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Titres » , afficher la fenêtre  "Ajouter un critère de recherche" en cliquant sur MenuBar – SearchCriteriaSubmenuAddSearchCriterion
Vérifier la présence des contrôles et des étiquetés. 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1774*/

 /*Description    : Combiner les deux façons pour ajouter un critère de recherche
   Date           : 21-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function Survol_Tit_AddSearchCriterion_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : Afficher la fenêtre « Ajouter un critere de recherche » par MenuBar *******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Ajouter un critere de recherche » par MenuBar");
        //afficher la fenêtre « Ajouter un critere de recherche »
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_SearchCriteria().OpenMenu(); 
        Get_MenuBar_Search_SearchCriteria_AddACriterion().Click();
  
        //Les points de vérification en français 
        if(language=="french"){Check_AddOrDisplayAnActiveCriterion_Properties_French()} // la fonction est dans CommonCheckpoints
        //Les points de vérification en anglais 
        else {Check_AddOrDisplayAnActiveCriterion_Properties_English()} // la fonction est dans CommonCheckpoints
    
        //Les points de vérification: la présence des contrôles
        Check_Check_AddOrDisplayAnActiveCriterion_Properties_French_Existence_Of_Controls();// la fonction est dans CommonCheckpoints
    
        Get_WinAddSearchCriterion_BtnCancel().Click();
        

// ********** Étape 3 : Afficher la fenêtre « Ajouter un critere de recherche » par Bouton  *******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Ajouter un critere de recherche » par Bouton");
        //afficher la fenêtre « Ajouter un filter »
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click()
  
       //Les points de vérification en français 
        if(language=="french"){Check_AddOrDisplayAnActiveCriterion_Properties_French()} // la fonction est dans CommonCheckpoints
        //Les points de vérification en anglais 
        else {Check_AddOrDisplayAnActiveCriterion_Properties_English()} // la fonction est dans CommonCheckpoints
    
        //Les points de vérification: la présence des contrôles
        Check_Check_AddOrDisplayAnActiveCriterion_Properties_French_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
    
        Get_WinAddSearchCriterion_BtnCancel().Click()
  
      
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
