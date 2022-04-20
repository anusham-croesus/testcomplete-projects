//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Accounts » , afficher la fenêtre « Print » avec ClickR. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Acc_ClickR()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsClientsAccountsGrid().ClickR();
  
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_RelationshipsClientsAccountsGrid().ClickR();
    numberOftries++;
  }
  
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print().Click();
  
  //Check_Print_Properties(); //la fonction est dans Common_functions
  
  Get_DlgInformation().Click(93, 66);
  Close_Croesus_X();
}