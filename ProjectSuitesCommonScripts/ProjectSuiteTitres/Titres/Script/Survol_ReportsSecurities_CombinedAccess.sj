//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Titre » , afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-ReportsSecurities . 
    Vérifier la présence des listes déroulants et des cases à cocher   
    Vérifier la présence des  boutons */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-333

 /*Description    : Combiner les 2 façons pour afficher la fenêtre « Rapports titre »
   Date           : 25-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function   Survol_ReportsSecurities_CombinedAccess()
 {
   try {
        var module="security";
        var btn="reports";
     
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-ReportsSecurities*******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-ReportsSecurities");
        
        Get_MenuBar_Reports().OpenMenu();
        Get_MenuBar_Reports_Securities().Click();
  
        //Les points de vérification
        Check_Properties_Reports(language,module,btn);
  
        Get_WinReports_BtnClose().Click();

// ********** Étape 3 : afficher la fenêtre « Rapports titre » en cliquant sur Toolbar-btnReportsAndGraphs*******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Rapports titre » en cliquant sur Toolbar-btnReportsAndGraphs");
        Get_Toolbar_BtnReportsAndGraphs().Click();
  
        //Les points de vérification
        Check_Properties_Reports(language,module,btn); //la fonction est dans le script CommonCheckpoints 
   
        Get_WinReports_BtnClose().Click();
        
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

