//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* /* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un titre » Par la clique droite de la souris  . 
Vérifier la présence de boutons radio : Réel, Manuel 
Vérifier la présence de  boutons OK, Annuler */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-330roes-1774*/

 /*Description    : Combiner les deux façons pour ajouter un titre
   Date           : 21-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function Survol_Tit_Add_Security_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : Afficher la fenêtre « Ajouter un titre » par ClicR *******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Ajouter un titre » par ClicR");
        
        Get_SecurityGrid().ClickR() 
        Get_SecurityGrid_ContextualMenu_Add().Click()
   
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()}
        //Les points de vérification en anglais 
        else {Check_Properties_English()}
    
        Check_Existence_Of_Controls()   
        Get_WinCreateSecurity_BtnCancel().Click()
        

// ********** Étape 3 : Afficher la fenêtre « Ajouter un itre » par CtrlN  *******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Ajouter un titre » par CtrlN");
        Get_SecurityGrid().Keys("^n");
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_Add_ClickR
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_Add_ClickR
    
        Check_Existence_Of_Controls()// la fonction est dans le script Survol_Tit_Add_ClickR
  
        Get_WinCreateSecurity_BtnCancel().Click();
        
// ********** Étape 4 : Afficher la fenêtre « Ajouter un titre » par MenuBr *******************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Afficher la fenêtre « Ajouter un titre » par MenuBar");
        
        Get_MenuBar_Edit().OpenMenu()
        Get_MenuBar_Edit_Add().Click()
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_Add_ClickR
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_Add_ClickR
    
        Check_Existence_Of_Controls() // la fonction est dans le script Survol_Tit_Add_ClickR
  
        Get_WinCreateSecurity_BtnCancel().Click();
        
// ********** Étape 5 : Afficher la fenêtre « Ajouter un titre » par Bouton *******************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Afficher la fenêtre « Ajouter un titre » par Bouton");
        
        Get_Toolbar_BtnAdd().Click();
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_Add_ClickR
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_Add_ClickR
    
        Check_Existence_Of_Controls()// la fonction est dans le script Survol_Tit_Add_ClickR
  
        Get_WinCreateSecurity_BtnCancel().Click();
        
    }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 6 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}

//Fonctions  (les points de vérification pour les scripts qui testent Add_Security)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinCreateSecurity().Title, "OleValue", cmpEqual, "Ajouter un titre");
     //N’existe pas dans l’automation 9 (BD FNB)
//    if (client == "CIBC" || client == "BNC" || || client =="US" || client == "TD" ){                                                                             
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoReal().Content, "OleValue", cmpEqual, "Réel");
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoManual().Content, "OleValue", cmpEqual, "Manuel");
//    }
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinCreateSecurity().Title, "OleValue", cmpEqual, "Add a Security");
     //N’existe pas dans l’automation 9 (BD FNB)
//    if (client == "CIBC" || client == "BNC" || || client =="US" || client == "TD" ){
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoReal().Content, "OleValue", cmpEqual, "Real");
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoManual().Content, "OleValue", cmpEqual, "Manual");
//    }
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Cancel"); 
}

function Check_Existence_Of_Controls()
{    //N’existe pas dans l’automation 9 (BD FNB)

//    if (client == "CIBC" || client == "BNC" || || client =="US" || client == "TD" ){
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoReal(), "IsVisible", cmpEqual, true);
//      aqObject.CheckProperty(Get_WinCreateSecurity_RdoManual(), "IsVisible", cmpEqual, true);     
//    }
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCreateSecurity_BtnCancel(), "IsEnabled", cmpEqual, true);
}