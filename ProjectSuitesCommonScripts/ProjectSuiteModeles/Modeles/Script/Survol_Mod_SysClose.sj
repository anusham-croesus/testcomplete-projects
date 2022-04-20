//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Mod_AltF4

/* Description : Aller au module "Modeles" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
contenant les boutons Info, Perfo.Sous-jacente, Documents, Restriction.Fermêture de l’application par SysClose*/

function Survol_Mod_SysClose()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
   Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 10000);
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Tit_AltF4   
   //Les points de vérification en anglais 
   else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_AltF4
   
  Check_Existence_Of_Controls()// la fonction est dans le script Survol_Tit_AltF4
    
  Close_Croesus_SysMenu()
}