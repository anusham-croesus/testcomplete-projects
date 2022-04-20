//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Clients » , afficher la fenêtre « Critères de recherche » en cliquant sur MenuBar – SearchCriteriaSubmenuSearchManage
Vérifier la présence de tous les boutons */

function Survol_Cli_MenuBar_SearchCriteriaSubmenuSearchManage()
{
  if (client == "BNC" || client == "TD" ){
      var criterion="GESTION SEP" //creterion in BD of BNC
  }
  if(client == "US" ){
     var criterion="Clients turning 69 this year"
  } 
  if(client != "US" && client != "BNC" ){ //RJ
      if(language=="french"){
        var criterion="Clients qui auront 71 ans au cours de l'année" // creterion in BD of RJ
      }
      else{
        var criterion="Clients turning 71 this year"
      }
  }
  
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_MenuBar_Search().OpenMenu();
  Get_MenuBar_Search_SearchCriteria().OpenMenu() ;
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
  
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}
