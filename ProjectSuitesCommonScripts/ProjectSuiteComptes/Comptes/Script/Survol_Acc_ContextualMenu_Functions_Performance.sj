//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module "Compte", afficher la fenêtre «Performance» pour le compte qui est sélectionné par défaut
par ContextualMenu_Functions_Perfomance. Vérifier la présence des contrôles et des étiquettes. Fermer la fenêtre en cliquant sur le btn Fermer. */

function Survol_Acc_ContextualMenu_Functions_Perfomance()
{
  var module = "accounts";
  
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  //Get_MainWindow().Keys("[Apps]");
     var numberOftries=0;  
    while ( numberOftries < 5 && !Get_SubMenus().Exists){
        Get_RelationshipsClientsAccountsBar().ClickR();
        numberOftries++;
    } 
     
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Performance().Click();
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_Performance_French(module)} //la fonction est dans Common_functions
  //Les points de vérification en anglais 
  //else {Check_Properties_Performance_English(module)} //la fonction est dans Common_functions
  //Les points de vérification
  //Check_Performance_Existence_Of_Controls(module); //la fonction est dans Common_functions
  
  Get_WinPerformance_BtnClose().Click();
  
  Close_Croesus_X();
}

