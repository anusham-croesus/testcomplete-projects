﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » , afficher la fenêtre « Print » avec AltP. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-317 

function Survol_Tit_Print_AltP()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()

  Get_SecurityGrid().Keys("~p")
  
    //Les points de vérification en français 
    if(language=="french")
        if(Get_DlgError().Exists && aqObject.CheckProperty(Get_DlgError().Get_CommentTag(), "OleValue", cmpStartsWith, "Par défaut, Croesus"))
            Get_DlgError_Btn_OK().Click();
        else
            Check_Print_Properties_French() // la fonction est dans le script CommonCheckpoints
    //Les points de vérification en anglais 
    else
      if(Get_DlgError().Exists && aqObject.CheckProperty(Get_DlgError().Get_CommentTag(), "OleValue", cmpStartsWith, "By default, Croesus"))
          Get_DlgError_Btn_OK().Click();
      else
          Check_Print_Properties_English() // la fonction est dans le script CommonCheckpoints
  
   // if(client != "CIBC"){
    if(Get_DlgInformation().Exists){
          var width = Get_DlgInformation().Get_Width();
          Get_DlgInformation().Click((width*(1/2)),73);         
    }
  Close_Croesus_MenuBar()
}
 
 
