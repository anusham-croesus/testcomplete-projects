//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/* Description : Aller au module "Modeles" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
contenant les boutons Info, Perfo.Sous-jacente, Documents, Restriction. Fermêture de l’application avec AltF4 */

function Survol_Mod_AltF4()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 10000);
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  Check_Existence_Of_Controls()
   
  Close_Croesus_AltF4()
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
    aqObject.CheckProperty(Get_ModelsBar_BtnInfo().Content, "OleValue", cmpEqual, "_Info");
    aqObject.CheckProperty(Get_ModelsBar_BtnUnderlyingPerformance().Content, "OleValue", cmpEqual, "Perfo. sous-jacente");
    aqObject.CheckProperty(Get_ModelsBar_BtnDocuments().Content, "OleValue", cmpEqual, "Documents");
    aqObject.CheckProperty(Get_ModelsBar_BtnRestrictions().Content, "OleValue", cmpEqual, "Restrictions");    
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
    aqObject.CheckProperty(Get_ModelsBar_BtnInfo().Content, "OleValue", cmpEqual, "_Info");
    aqObject.CheckProperty(Get_ModelsBar_BtnUnderlyingPerformance().Content, "OleValue", cmpEqual, "Under. Performance");
    aqObject.CheckProperty(Get_ModelsBar_BtnDocuments().Content, "OleValue", cmpEqual, "Documents");
    aqObject.CheckProperty(Get_ModelsBar_BtnRestrictions().Content, "OleValue", cmpEqual, "Restrictions");   
}

function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_ModelsBar_BtnInfo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_ModelsBar_BtnInfo(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ModelsBar_BtnUnderlyingPerformance(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_ModelsBar_BtnUnderlyingPerformance(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ModelsBar_BtnDocuments(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_ModelsBar_BtnDocuments(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ModelsBar_BtnRestrictions(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_ModelsBar_BtnRestrictions(), "IsEnabled", cmpEqual, true);
}