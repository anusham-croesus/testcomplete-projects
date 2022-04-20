//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relation » , afficher la fenêtre « Critères de recherche » en cliquant sur MenuBar – SearchCriteriaSubmenuSearchManage
Vérifier la présence de tous les boutons */

function Survol_Rel_MenuBar_SearchCriteriaSubmenuSearchManage()
{
  if (client == "BNC" ){
      var criterion="GESTION SEP" //creterion in BD of BNC
  }
  else if(client == "US"){
  var criterion="Clients turning 69 this year"
    
  } 
  else{ //RJ
      if(language=="french"){
        var criterion="Clients qui auront 71 ans au cours de l'année" // creterion in BD of RJ
      }
      else{
        var criterion="Clients turning 71 this year"
      }
  }
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click()
  
  Get_MenuBar_Search().OpenMenu()
  Get_MenuBar_Search_SearchCriteria().OpenMenu() 
  Get_MenuBar_Search_SearchCriteria_Manage().Click()
  
  Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
  Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_SearchManage_Properties_French()}// la fonction est dans CommonCheckpoints
  //Les points de vérification en anglais CommonCheckpoints
  else { Check_SearchManage_Properties_English()}// la fonction est dans 
    
  //Les points de vérification: la présence des contrôles
  Check_SearchManage_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
  
  Get_WinSearchCriteriaManager_BtnClose().Click();
  
  Get_MainWindow().SetFocus()
  Close_Croesus_MenuBar()
}

