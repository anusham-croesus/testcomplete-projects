//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Cli_AltF4

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
contenant les boutons Info, Perfomance, Activities , . Fermêture de l’application avec SysClose */

function Survol_Cli_SysClose()
{
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  //Les points de vérification en français 
  Check_Properties(language); // la fonction est dans le Survol_Cli_AltF4
   
  Close_Croesus_SysMenu();
}