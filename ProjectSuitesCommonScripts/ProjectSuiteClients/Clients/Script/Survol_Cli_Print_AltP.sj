//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Clients » , afficher la fenêtre « Print » avec AltP. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

 function Survol_Cli_Print_AltP()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()

  Get_MainWindow().Keys("~p")
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  //else{Check_Print_Properties_English()} // la fonction est dans le script CommonCheckpoints
  
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  Close_Croesus_MenuBar();
 }
 