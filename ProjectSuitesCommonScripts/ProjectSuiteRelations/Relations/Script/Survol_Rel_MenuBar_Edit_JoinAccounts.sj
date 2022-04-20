//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_ContextualMenu_JoinAccounts

 /* Description :Dans le du module « Relationship » ,afficher la fenêtre «Accounts» par MenuBar_Edit_JoinAccounts. 
Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Rel_MenuBar_Edit_JoinAccounts()
{  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_AddForRelationshipsAndClients().Click();
  Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship().Click();
  
  //les points de vérification
  Check_Properties(language) // la fonction est dans Survol_Rel_ContextualMenu_JoinAccounts
  
  Get_WinPickerWindow_BtnCancel().Click();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PickerBase_dcbf")){
      Close_Croesus_AltF4();
  } else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
  
 }