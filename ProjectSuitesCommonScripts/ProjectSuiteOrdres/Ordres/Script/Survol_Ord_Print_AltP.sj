//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Print » avec AltP. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

 function Survol_Ord_Print_AltP()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
  Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);
  
  Log.Message("Croesus crash lors de l'impression lorsqu'on n'a plus d'ordres ==> Un Jira a rentrer par Karima.")
  Get_MainWindow().Keys("~p")
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script Common_functions
  //Les points de vérification en anglais 
  else{Check_Print_Properties_English()} // la fonction est dans le script Common_functions
  
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  Close_Croesus_MenuBar();
 }
 
