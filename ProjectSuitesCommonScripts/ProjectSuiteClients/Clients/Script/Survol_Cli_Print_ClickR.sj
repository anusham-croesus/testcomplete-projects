﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Titre » , afficher la fenêtre « Print » avec ClickR. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

 function Survol_Cli_Print_ClickR()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  //Get_RelationshipsClientsAccountsGrid().Keys("[Apps]");
  WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
  Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
  Get_RelationshipsClientsAccountsGrid().ClickR();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print().Click();
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  //else{Check_Print_Properties_English()} // la fonction est dans le script CommonCheckpoints
  
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);;
  Close_Croesus_X();
 }