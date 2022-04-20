//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relation » , afficher la fenêtre « Print » avec AltP. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

 function Survol_Rel_Print_AltP()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
  
  Get_RelationshipsClientsAccountsGrid().Keys("~p");
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  //else{Check_Print_Properties_English()} // la fonction est dans le script CommonCheckpoints
  
  if(Get_DlgInformation().Exists){  //
      var width = Get_DlgInformation().Get_Width();
      Get_DlgInformation().Click((width*(1/2)),73);         
  }
  Close_Croesus_MenuBar();
 }
 