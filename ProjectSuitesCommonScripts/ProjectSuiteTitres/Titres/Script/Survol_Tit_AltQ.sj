//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_AltF4

//Description : Aller au module "Titre" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons Info, Données historiques, Total détenu, Taux de change  
//Fermêture de l’application avec AltQ
// Lien cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-313
function Survol_Tit_AltQ()
{
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Tit_AltF4
   
   //Les points de vérification en anglais 
   else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_AltF4

  Close_Croesus_AltQ()
}