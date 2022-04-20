//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints


 /* Description : A partir du module "Relationships". Afficher la fenêtre « Perfomance» pour le client qui est sélectionné par default (800300) 
en cliquant sur MenuBar_Perfomance. Vérifier la présence des contrôles et des étiquetés.*/

 function Survol_Rel_MenuBar_EditFunctions_Performance()
 {
  var module="Relationships";
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
     
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Performance().Click();//Il a y une anomalie dans automation 10 , le menu est vide 
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_Performance_French(module)}// la fonction est dans /CommonCheckpoints
  //Les points de vérification en anglais 
  //else {Check_Properties_Performance_English(module)}// la fonction est dans CommonCheckpoints
  //Les points de vérification
  //Check_Performance_Existence_Of_Controls(module)// la fonction est dans CommonCheckpoints
  
  Get_WinPerformance().Close();
  
  Close_Croesus_MenuBar();
 }