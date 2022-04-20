//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module "Relationships", Afficher la fenêtre « Perfomance» 
 par ContextualMenu_Functions_Perfomance. Vérifier la présence des contrôles et des étiquetés.*/

 function Survol_Rel_ContextualMenu_Functions_Performance()
 {
  var module="relationships";
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  
//  Get_MainWindow().Keys("[Apps]")//AA: ne fonctionne pas sur VM et en local
  
  Get_RelationshipsClientsAccountsBar().ClickR();     
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_SubMenus().Exists){
        Get_RelationshipsClientsAccountsBar().ClickR();
        numberOftries++;
    } 
    
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Performance().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_Performance_French(module)} //la fonction est dans CommonCheckpoints
  //Les points de vérification en anglais 
  else {Check_Properties_Performance_English(module)} //la fonction est dans CommonCheckpoints
  //Les points de vérification
  Check_Performance_Existence_Of_Controls(module) //la fonction est dans CommonCheckpoints
  
  Get_WinPerformance_BtnClose().Click();
  
  Close_Croesus_X();
 }