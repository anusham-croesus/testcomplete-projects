//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Relations_Get_functions

 /* Description :Dans le du module « Relationship » ,afficher la fenêtre «Accounts» par ClickR ContextualMenu_JoinClients 
Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Rel_ContextualMenu_JoinClients()
{ 
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  
 // Get_RelationshipsClientsAccountsGrid().ClickR();
  Get_RelationshipsClientsAccountsGrid().Keys("[Apps]");// SA: le click right sur les machines virtuelles ne fonctionne pas 90-04-50 
  Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
  Get_RelationshipsGrid_ContextualMenu_Add_JoinClients().Click();

  //les points de vérification
  Check_Properties(language)
  
  Get_WinPickerWindow_BtnCancel().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PickerBase_dcbf")){
      Close_Croesus_AltF4();
  } else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
 }
 
  //Fonctions  (les points de vérification pour les scripts qui testent Join Accounts)
function Check_Properties(language)
{
    aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual,  GetData(filePath_Relations,"JoinClientsAccounts",2,language))    
    Get_WinPickerWindow_BtnOK().Content, "OleValue", cmpEqual, GetData(filePath_Relations,"JoinClientsAccounts",10,language)
    aqObject.CheckProperty(Get_WinPickerWindow_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPickerWindow_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel().Content, "OleValue", cmpEqual, GetData(filePath_Relations,"JoinClientsAccounts",11,language))
    aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel(), "IsEnabled", cmpEqual, true);
   
    aqObject.CheckProperty(Get_WinPickerWindow_ChClientNo().Content, "OleValue", cmpEqual,  GetData(filePath_Relations,"JoinClientsAccounts",3,language))
    aqObject.CheckProperty(Get_WinPickerWindow_ChName().Content, "OleValue", cmpEqual,  GetData(filePath_Relations,"JoinClientsAccounts",4,language));
}
 