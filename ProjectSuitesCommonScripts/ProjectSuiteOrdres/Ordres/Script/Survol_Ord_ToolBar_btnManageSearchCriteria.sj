﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Critères de recherche » en cliquant sur ToolBar – btnManageSearchCriteria 
Vérifier la présence de tous les boutons 
Selon la ligne sélectionnée, il a trois cas possibles : 
1)	Les btns Consulter et Copier sont actifs, le btn Supprimer est inactif  
2)	Le btn Créer à partir de… est actif, les btns Copier et Supprimer sont inactifs 
3)	Les btns Modifier, Copier, Supprimer sont actifs */


function Survol_Ord_ToolBar_btnManageSearchCriteria()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      var criterion="GESTION SEP" //creterion in BD of BNC
  }
  else{ //RJ
      if(language=="french"){
        var criterion="Clients qui auront 71 ans au cours de l'année" // creterion in BD of RJ
      }
      else{
        var criterion="Clients turning 71 this year"
      }
  }
  
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click();
  
  Get_Toolbar_BtnManageSearchCriteria().Click();
  
  Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
  Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
  
   //Les points de vérification en français 
   if(language=="french"){Check_SearchManage_Properties_French()} // la fonction est dans Common_functions
   //Les points de vérification en anglais 
   else { Check_SearchManage_Properties_English()} // la fonction est dans Common_functions
    
  //Les points de vérification: la présence des contrôles
  Check_SearchManage_Existence_Of_Controls()// la fonction est dans Common_functions
    
  Get_WinSearchCriteriaManager_BtnClose().Click()
  
  Get_MainWindow().SetFocus()
  Close_Croesus_AltF4()
}