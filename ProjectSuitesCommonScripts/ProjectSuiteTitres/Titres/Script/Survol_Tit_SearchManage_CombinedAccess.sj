//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

/* Description : A partir du module « Titre » , afficher la fenêtre « Critères de recherche » en cliquant sur MenuBar – SearchCriteriaSubmenuSearchManage
Vérifier la présence de tous les boutons */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-324

 /*Description    : Combiner les 2 façons pour afficher le sous menu gestionnaire de recherche
   Date           : 25-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function   Survol_Tit_SearchManage_CombinedAccess()
 {
   try {
     
        if (client == "BNC" || client == "TD" ){
          var criterion="GESTION SEP" //creterion in BD of BNC
        }
        if (client != "BNC"  && client != "US" ){ //RJ
          if(language=="french"){
            var criterion="Clients qui auront 71 ans au cours de l'année" // creterion in BD of RJ
          }
          else{
            var criterion="Clients turning 71 this year"
          }
         }
        if(client ==  "US" ){
          var criterion="Clients turning 69 this year"; //creterion in BD of US
        } 
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : afficher la fenêtre « Critères de recherche » en cliquant sur MenuBar – SearchCriteriaSubmenuSearchManage*******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Critères de recherche » en cliquant sur MenuBar – SearchCriteriaSubmenuSearchManageh");
        
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_SearchCriteria().OpenMenu() 
        Get_MenuBar_Search_SearchCriteria_Manage().Click();
  
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
        Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
  
        //Les points de vérification en français 
        if(language=="french"){Check_SearchManage_Properties_French()}// la fonction est dans CommonCheckpoints
        //Les points de vérification en anglais 
        else { Check_SearchManage_Properties_English()}// la fonction est dans CommonCheckpoints
    
        //Les points de vérification: la présence des contrôles
        Check_SearchManage_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
  
        Get_WinSearchCriteriaManager_BtnClose().Click();

// ********** Étape 3 : afficher la fenêtre « Critères de recherche » en cliquant sur ToolBar – btnManageSearchCriteria*******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Critères de recherche » en cliquant sur ToolBar – btnManageSearchCriteria");
        Get_Toolbar_BtnManageSearchCriteria().Click();
  
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
        Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
  
        //Les points de vérification en français 
        if(language=="french"){Check_SearchManage_Properties_French()} // la fonction est dans CommonCheckpoints
        //Les points de vérification en anglais 
        else { Check_SearchManage_Properties_English()} // la fonction est dans CommonCheckpoints
    
        //Les points de vérification: la présence des contrôles
        Check_SearchManage_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
    
        Get_WinSearchCriteriaManager_BtnClose().Click();
        
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

