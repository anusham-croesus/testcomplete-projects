//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons  
CFO, Consulter,Exécutions,CXL,Replacer,Rafraîchir. Fermêture de l’application avec AltF4 */

function Survol_Ord_AltF4()
{
    Login(vServerOrders, userName , psw ,language);
    Get_ModulesBar_BtnOrders().Click()
  
    //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French()} 
  
    //Les points de vérification en anglais 
     else {Check_Properties_English()}
   
    Close_Croesus_AltF4()
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties_French()
{
  aqObject.CheckProperty(Get_OrdersBar_BtnCFO(), "Content", cmpEqual, "Modifier un ordre..."); //Corrigé suit à CROES-7518. Avant CFO...
  aqObject.CheckProperty(Get_OrdersBar_BtnView(), "Content", cmpEqual, "Consulter...");
  aqObject.CheckProperty(Get_OrdersBar_BtnFills(), "Content", cmpEqual, "Exécutions...");
  aqObject.CheckProperty(Get_OrdersBar_BtnCXL(), "Content", cmpEqual, "Annuler un ordre");//Corrigé suit à CROES-7518. Avant CXL
  aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Content", cmpEqual, "Renvoyer...");//Story-GDO-667
  aqObject.CheckProperty(Get_OrdersBar_BtnRefresh(), "Content", cmpEqual, "Rafraîchir");
  
}

function Check_Properties_English()
{
  aqObject.CheckProperty(Get_OrdersBar_BtnCFO(), "Content", cmpEqual, "Modify Order...");//Corrigé suit à CROES-7518. Avant CFO...
  aqObject.CheckProperty(Get_OrdersBar_BtnView(), "Content", cmpEqual, "View...");
  aqObject.CheckProperty(Get_OrdersBar_BtnFills(), "Content", cmpEqual, "Fills...");
  aqObject.CheckProperty(Get_OrdersBar_BtnCXL(), "Content", cmpEqual, "Cancel Order");//Corrigé suit à CROES-7518. Avant CXL
  aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Content", cmpEqual, "Send Back...");//Story GDO-667
  aqObject.CheckProperty(Get_OrdersBar_BtnRefresh(), "Content", cmpEqual, "Refresh");
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_OrdersBar_BtnCFO(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnCFO(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_OrdersBar_BtnView(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnView(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_OrdersBar_BtnFills(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnFills(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_OrdersBar_BtnCXL(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnCXL(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_OrdersBar_BtnRefresh(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_OrdersBar_BtnRefresh(), "IsEnabled", cmpEqual, true);

}