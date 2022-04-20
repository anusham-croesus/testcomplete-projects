//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions


 /* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un titre » Par la clique droite de la souris  . 
Vérifier la présence de boutons radio : Réel, Manuel 
Vérifier la présence de  boutons OK, Annuler */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-330
 function Survol_Tit_MenuBar_EditAdd()
{
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_SecurityGrid().ClickR() 
  Get_SecurityGrid_ContextualMenu_Add().Click()
   
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
    else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  Get_WinCreateSecurity_BtnCancel().Click()
  
  Close_Croesus_AltF4()
  //Sys.Browser("iexplore").Close() 
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