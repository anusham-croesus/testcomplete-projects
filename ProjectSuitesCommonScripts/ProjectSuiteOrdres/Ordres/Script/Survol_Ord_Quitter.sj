//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Ord_AltF4


/*Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
CFO, Consulter,Exécutions,CXL,Replacer,Rafraîchir  
Fermêture de l’application par Quitter*/

function Survol_Ord_Quitter()
{
    Login(vServerOrders, userName , psw ,language);
    Get_ModulesBar_BtnOrders().Click()
  
    //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French()} 
  
    //Les points de vérification en anglais 
     else {Check_Properties_English()}
   
    Close_Croesus_MenuBar()
}